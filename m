Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Rob Baxter <robb@synergymicro.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040102151830.GA31261@synergy>
References: <20040101181145.GA27294@iliana> <20040102151830.GA31261@synergy>
Content-Type: text/plain
Message-Id: <1073087816.10542.16.camel@gaston>
Mime-Version: 1.0
Date: Sat, 03 Jan 2004 10:56:57 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-01-03 at 02:18, Rob Baxter wrote:
> Sven,
>
> Synergy Microsystems has designs with the Discovery 2 as well.  We worked
> around this by setting pci_assign_all_busses to true and with modifications
> to the platform specific config cycle routines (only included one as an
> example):
>
> int
> gemini_pcibios_bus_fixup(struct pci_dev *dev, struct pci_controller *hose)
> {
>         return ((dev->bus->number == hose->first_busno) ? 0 : dev->bus->number);
> }
>
> int
> gemini_pcibios_read_config_byte(struct pci_dev *dev, int offset, u8 *val)
> {
>         unsigned long reg;
>         unsigned int addr;
>         int bus;
>         struct pci_controller *hose;
>
>         hose = dev->sysdata;
>         bus = gemini_pcibios_bus_fixup(dev, hose);
>         addr = pci_config_type1_addr(bus, dev->devfn, offset & ~(0x3));
>
>         reg = config_read(addr, hose->cfg_addr, hose->cfg_data);
>         *val = ((reg >> ((offset & 0x3) << 3)) & 0xff);
>         return PCIBIOS_SUCCESSFUL;
> }

Hrm... Why this bus fixup thing ? Why not just clearly writing
something like

if (dev->bus->number == hose->first_busno)
	discovery2_config_type0_addr(....);
else
	discovery2_config_type1_addr(....);

And those could be inline...

Also, the way you define functions with a name that "looks" like a
generic function (pci_config_type1_addr) is rather ugly...


> It is also necessary to set the first and last bus number fields of the
> hose structure correctly in your platform specific code.  These will get
> over written later by the PCI driver code, and in our case, to the same
> values.  Our platform specific code does a preliminary scan of the PCI
> buses to find the first and last bus numbers.

Why would you need to set them correctly ? The PCI code will set them
to sensible values before doing the bus scan and will fixup the last
busno afterward for each controller, you do not need any pre-scan or
whatever and you can leave those values to 0 at init time.

> This will also work when a PtP bridge is located on either of the primary
> PCI buses of the Discovery.  We're using a derivative of a 2.4.19 kernel.

Yup, that should work fine.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
