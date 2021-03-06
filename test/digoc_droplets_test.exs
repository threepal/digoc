defmodule DigOcDropletsTest do
  use ExUnit.Case

  @moduletag :external
  
  setup_all do
    {:ok, droplet: hd(DigOc.droplets!.droplets)}
  end

  test "list droplets" do
    droplets = DigOc.droplets!()
    assert droplets.meta.total == length(droplets.droplets)
  end

  test "retrieve droplet", %{ droplet: droplet } do
    single_drop = DigOc.droplet!(droplet.id)
    assert single_drop.droplet == droplet
  end

  test "get droplet id", %{ droplet: droplet } do
    res = DigOc.droplet(droplet.id)
    assert DigOc.id_from_result(res) == droplet.id
    {_, body, _} = res
    assert DigOc.id_from_result(body) == droplet.id
  end

  test "list available kernels", %{ droplet: droplet } do
    kernel = hd(DigOc.Droplet.kernels!(droplet.id).kernels)
    assert is_integer(kernel.id)
    assert is_binary(kernel.version)
    assert is_binary(kernel.name)
  end

  test "retrieve snapshots", %{ droplet: droplet } do
    snapshot = DigOc.Droplet.snapshots!(droplet.id)
    assert is_list(snapshot.snapshots)
  end

  test "retrieve backups", %{ droplet: droplet } do
    backup = DigOc.Droplet.backups!(droplet.id)
    assert is_list(backup.backups)
  end

  test "retrieve actions", %{ droplet: droplet } do
    actions = DigOc.Droplet.actions!(droplet.id)
    assert is_list(actions.actions)
  end

  test "droplet upgrades" do
    assert is_list(DigOc.Droplet.upgrades!)
  end

  test "droplet neighbors" do
    assert is_map(DigOc.droplet_neighbors!)
    assert is_list(DigOc.droplet_neighbors!().neighbors)
  end
  
end
