Date: Thu, 13 Jun 2002 22:27:55 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: Problems with Sonnet Tempo ATA-100 - Promise 20268 Is it supported?
In-Reply-To: <200206111038.33668.kevin.hendricks@sympatico.ca>
Message-ID: <Pine.LNX.4.10.10206132225210.21513-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin,

Frank is long gone from Promise.
If there is some one here in the silly (silicon) valley area with a system
I can get my hands on in first person, I bet I can fix it.
The problem is cross-platform coding in the blind.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Tue, 11 Jun 2002, Kevin B. Hendricks wrote:

>
> Hi,
>
> I think the promise driver is currently in a stat of flux.  All throughout
> the code they are trying to support two different classes of chipsets one
> of which uses IO that the other one can't use.
>
> So in many places they have two differnt routines (for example the reset
> routines)
>
> void pdc202xx_new_reset (ide_drive_t *drive)
> {
> 	OUT_BYTE(0x04,IDE_CONTROL_REG);
> 	mdelay(1000);
> 	OUT_BYTE(0x00,IDE_CONTROL_REG);
> 	mdelay(1000);
> 	printk("PDC202XX: %s channel reset.\n",
> 		HWIF(drive)->channel ? "Secondary" : "Primary");
> }
>
> void pdc202xx_reset (ide_drive_t *drive)
> {
> 	unsigned long high_16	= pci_resource_start(HWIF(drive)->pci_dev, 4);
> 	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
>
> 	OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
> 	mdelay(100);
> 	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
> 	mdelay(2000);		/* 2 seconds ?! */
> 	printk("PDC202XX: %s channel reset.\n",
> 		HWIF(drive)->channel ? "Secondary" : "Primary");
> }
>
>
> Notice for the "new" chipsets they do not  do I/O to the 0x041f location
> and there abouts.
>
> This is true all the way through the code  since they need to special case
> many of the actual control  byte/word writing to handle the two different
> classes of chips (old and new).
>
> My chip is actually the a "newchip" 20268 and as such should not be doing
> I/O to those locations according to my error messages.  But unfortunately,
> the pci_init_pdc202xx routine does the following:
>
>
> unsigned int __init pci_init_pdc202xx (struct pci_dev *dev, const char
> *name)
> {
> 	unsigned long high_16	= pci_resource_start(dev, 4);
> 	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
> 	byte primary_mode	= IN_BYTE(high_16 + 0x001a);
> 	byte secondary_mode	= IN_BYTE(high_16 + 0x001b);
> 	byte newchip		= 0;
>
> 	if (dev->resource[PCI_ROM_RESOURCE].start) {
> 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
> dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> 		printk("%s: ROM enabled at 0x%08lx\n", name,
> dev->resource[PCI_ROM_RESOURCE].start);
> 	}
>
> 	switch (dev->device) {
> 		case PCI_DEVICE_ID_PROMISE_20276:
> 		case PCI_DEVICE_ID_PROMISE_20275:
> 		case PCI_DEVICE_ID_PROMISE_20269:
> 		case PCI_DEVICE_ID_PROMISE_20268R:
> 		case PCI_DEVICE_ID_PROMISE_20268:
> 			newchip = 1;
> 			break;
>
>
> Does the io upfront to store away chip speed and things without finding out
> which chipset they are working with first.
>
> Therefore I get the:
>
>
> PDC20268: IDE controller on PCI bus 01 dev a0
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> IN from bad port 41f at c02cfa68
> IN from bad port 41a at c02cfa84
> IN from bad port 41b at c02cfaa0
> PDC20268: ROM enabled at 0x80090000
>
> Messages.
>
> Has anyone used the Sonnet Tempo ATA 100 card with the Promise 20268
> chipset support on their machines?
>
> Ideas anyone?
>
> Thanks,
>
> Kevin
>
> On June 10, 2002 06:27, benh@kernel.crashing.org wrote:
> > >I noticed that I/O ports are enable (not disabled).  I thought all I/O
> > > was MMIO (memory mapped) but I am unsure if this is the case.
> > >
> > >This card works fine under MacOSX, and Mac OS9 and I hoped PPC Linux
> > > which is why I bought it.
> > >
> > >Can someone give me some hints about where to look to fix this?  Is it
> > > just that the pdc202XX driver is not compatbile with ppc linux?
> > >
> > >Is anyone else using a Sonnet Tempo ATA100 pci card successfully with
> > > DMA and if so which driver?
> >
> > The INs from bad ports mean the driver is trying to access ports that
> > aren't decoded by the card...
> >
> > Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
