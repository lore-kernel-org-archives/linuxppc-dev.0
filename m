Message-ID: <3B4C0567.9BC25E5B@india.infogain.com>
Date: Wed, 11 Jul 2001 13:21:03 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI BAR initialisation..?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I need a little explanation for following from pci experts.
As per the pci specs , to determine the resource requirement by  BAR in pci config space
we write 0xffffffff and then read back , and from the data read we decide the size and
alignment requirement for pci address in either pci i/o or memory spaces.

In case the firmware hasn't initialised the pci devices BAR in slot we have to handle
it  at our own as I have to do for sandpoint + mcp750 with DINK32 as firmware.

But by any chance if somebody has come across a random feature of pci BAR.
that is if you write the required pci addresses in BAR after writing 0xffffffff and
reading it back , and to confirm if the actual value has reached the BAR , we read it again
but then it returns funny values.

more surprisingly if i move the code in some other function then everything behaves correctly.
I am more then sure that nothing relevant is happening betwen two places.

my sequence is like this,.

1.pcibios_write_config_dword(bus,devfn, PCI_BASE_ADDRESS_1, 0xffffffff);
2.pcibios_read_config_dword( bus,devfn, PCI_BASE_ADDRESS_1, &add);

3.now I decode the value of add to determine the size and alignment requirement
  let us say decoded value is "ADD"

4.pcibios_write_config_dword(bus,devfn, PCI_BASE_ADDRESS_1,ADD);

5.now confirming the bar value by,
    pcibios_read_config_dword(..., ..., base address register , &add);

but value of add is not the actual one written.

sometimes this behaviour gets automatically corrected and then i can read the actual value
written.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
