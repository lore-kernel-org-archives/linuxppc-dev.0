Date: Fri, 2 Jan 2004 08:18:30 -0700
From: Rob Baxter <robb@synergymicro.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040102151830.GA31261@synergy>
References: <20040101181145.GA27294@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040101181145.GA27294@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sven,

Synergy Microsystems has designs with the Discovery 2 as well.  We worked
around this by setting pci_assign_all_busses to true and with modifications
to the platform specific config cycle routines (only included one as an
example):

int
gemini_pcibios_bus_fixup(struct pci_dev *dev, struct pci_controller *hose)
{
        return ((dev->bus->number == hose->first_busno) ? 0 : dev->bus->number);
}

int
gemini_pcibios_read_config_byte(struct pci_dev *dev, int offset, u8 *val)
{
        unsigned long reg;
        unsigned int addr;
        int bus;
        struct pci_controller *hose;

        hose = dev->sysdata;
        bus = gemini_pcibios_bus_fixup(dev, hose);
        addr = pci_config_type1_addr(bus, dev->devfn, offset & ~(0x3));

        reg = config_read(addr, hose->cfg_addr, hose->cfg_data);
        *val = ((reg >> ((offset & 0x3) << 3)) & 0xff);
        return PCIBIOS_SUCCESSFUL;
}

It is also necessary to set the first and last bus number fields of the
hose structure correctly in your platform specific code.  These will get
over written later by the PCI driver code, and in our case, to the same
values.  Our platform specific code does a preliminary scan of the PCI
buses to find the first and last bus numbers.

This will also work when a PtP bridge is located on either of the primary
PCI buses of the Discovery.  We're using a derivative of a 2.4.19 kernel.

I'm open to a better approach...

Rob Baxter

On Thu, Jan 01, 2004 at 07:11:45PM +0100, Sven Luther wrote:
>
> I am currently trying to port linux to the Pegasos 2, which uses the
> Marvell Discovery 2 chip, and has two independent pci controllers,
> of which one is faked as an agp bus. This is with a modified 2.4.23
> kernel from the linuxppc_2_4 branch.
>
> Anyway, these two independent controllers both have one bus 0 on them :
>
> PCI bus 0 controlled by pci at 80000000
> PCI bus 0 controlled by pci at c0000000
>
> (This coming from chrp_find_bridges).
>
> For the pci bus, at 80000000, a simple indirect access can be used,
> and i setup a specialized io ops for the faked agp bus since it needs
> special care.
>
> Later, in pcibios_init, there is a problem in the pci_scan_bus. The
> first bus has no problems :
>
> Scanning bus 00
> Found 00:00 [11ab/6460] 000600 00
> Found 00:08 [1106/3044] 000c00 00
> Found 00:28 [1000/0001] 000100 00
> Found 00:60 [1106/8231] 000601 00
> Found 00:61 [1106/0571] 000101 00
> Found 00:62 [1106/3038] 000c03 00
> Found 00:63 [1106/3038] 000c03 00
> Found 00:64 [1106/8235] 000000 00
> Found 00:65 [1106/3058] 000401 00
> Found 00:66 [1106/3068] 000780 00
> Found 00:68 [1106/3065] 000200 00
> Fixups for bus 00
> Bus scan for 00 returning with max=00
>
> But the second fails with :
>
> PCI: Bus 00 already known
>
> Which comes because in drivers/pci/pci.c:pci_bus_exists does handle
> only buses, and thus know nothing of separate pci bridges with the
> same bus number, and thus the kernel dies when accessing bus->xxx
> something in pcibios_init.
>
> Now, i know that the powermacs in particular, and maybe others, also
> have this case of different same numbered pci buses with different
> base addresses, and that this kind of situation has already been
> solved.
>
> So, what is the workaround here, and where does it get set.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
