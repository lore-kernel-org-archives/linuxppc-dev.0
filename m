Date: Fri, 20 Jul 2001 11:35:43 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: fixing up PCI bus resources
Message-ID: <20010720113543.B15642@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Summary: I have to fix up the resources on my host bridge (the firmware sets
them incorrectly). How can I do this from a struct pci_bus?

First I need to make sure the bus needs fixing, by seeing if it's IO lies
between PREP_ISA_IO_BASE and PREP_ISA_MEM_BASE.

	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
		busdev = pci_dev_b(ln);
		if (busdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
			break; /* XXX found the right one? */
	}
	if (!busdev)
		return;

^^ is there a better way to find busdev? being the host bridge, bus->self is
NULL :( [The pci_read_config_byte's below were copied from
pci_read_bridge_bases()]

	for (i = 0; i < 4; ++i) {
		struct resource *res;
		if ((res = bus->resource[i]) == NULL)
			continue;
		if (!res->flags)
			continue;

		if (res->flags & IORESOURCE_IO) {
			u16 io_base_hi, io_limit_hi;
			u8 io_base_lo, io_limit_lo;
			unsigned long base, limit;

			pci_read_config_byte(busdev, PCI_IO_BASE, &io_base_lo);
			pci_read_config_byte(busdev, PCI_IO_LIMIT, &io_limit_lo);
			pci_read_config_word(busdev, PCI_IO_BASE_UPPER16, &io_base_hi);
			pci_read_config_word(busdev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
			base = ((io_base_lo & PCI_IO_RANGE_MASK) << 8) |
					(io_base_hi << 16);
			limit = ((io_limit_lo & PCI_IO_RANGE_MASK) << 8) |
					(io_limit_hi << 16);
			...


base and limit don't seem to be correct though (perhaps they're from the
PCI-PCI bridge on the host bus, not the host bus itself).

Any tips? Thanks...

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
