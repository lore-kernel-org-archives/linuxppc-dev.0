From: "Ron Bianco" <ronb@junction.net>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Sym53c875 problem with last 2_5 updates
Date: Mon, 19 Mar 2001 12:24:06 -0800
Message-ID: <000501c0b0b2$8be96550$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010316104613.G872@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm not using 2.5.x on our embedded 8240 board with sym53c895 chip, but did run into a similar kind of problem with some
of our boards.   The nominal version of the sym53c8xx.c file is 1.3c.

It seems that in the sym53c8xx_pci_init() function, the method used to read the PCI config registers is unreliable.
The pcibios_read_config_dword() method is better.   Also, it is assumed that the script ram base address has already
been set during PCI configuration.  I had to add code to the PCI config to set it anyway.

Hope this helps and is not too out of date with all the various changes in 2.4.x etc.
I didn't know anyone else was having a problem with it, so I didn't post my hack.

regards, Ron

Early on in the function sym53c8xx_pci_init():

#if LINUX_VERSION_CODE > LinuxVersionCode(2,1,92)
	pdev = pci_find_slot(bus, device_fn);
	vendor_id = pdev->vendor;
	device_id = pdev->device;
	irq = pdev->irq;
	i =	0;
	i =	pci_get_base_address(pdev, i, &io_port);
	printk("1-sym53c8xx_pci_init- io_port: 0x%08X\n", io_port );
	i =	pci_get_base_address(pdev, i, &base);
	printk("1-sym53c8xx_pci_init- base: 0x%08X\n", base );
	(void)	pci_get_base_address(pdev, i, &base_2);           // left in for comparison.

**** these next 3 lines are mine ********
	printk("1-sym53c8xx_pci_init- script ram base: 0x%08X\n", base_2 );

	pcibios_read_config_dword(bus, device_fn, PCI_BASE_ADDRESS_2, (u_int32 *)&base_2);

	printk("11-sym53c8xx_pci_init- script ram base: 0x%08X\n", base_2 );

#else

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Tom Rini
> Sent: Friday, March 16, 2001 9:46 AM
> To: Stefano Coluccini
> Cc: Linuxppc-Embedded
> Subject: Re: Sym53c875 problem with last 2_5 updates
>
>
>
> On Fri, Mar 16, 2001 at 06:22:04PM +0100, Stefano Coluccini wrote:
> >
> > > On Fri, Mar 16, 2001 at 09:38:47AM +0100, Stefano Coluccini wrote:
> > >
> > > >   few days ago (I don't remember the exact date) I have
> > > resynced my local
> > > > repository of 2_5 and today I have recompiled a kernel. While before the
> > > > updates my sym53c875 based board had always worked fine, now the driver
> > > > unsuccesfully try to download script on the chip continually. I
> > > have seen
> > > > that the sym53c8xx.c file is changed, in fact I have correct the problem
> > > > replacing the new file with the old.
> > > > I have not found any mention of sym53c8xx.c change in the changesets at
> > > > http://www.bitmover.com:8888//home/ppc/linuxppc_2_5 so I have
> > > thinked it can
> > > > be an erroneous update ... it is possible ?
> > >
> > > It got updated when I updated 2_5 with some of the changes from 2_4.  What
> > > machine is this?
> >
> > My machine is a Motorola MVME5100 with a PMC150-K mezzanine card based on
> > the sym53c875 chip.
> >
> > >  Search the linuxppc-dev list, as Geert had this same problem
> > > on his LongTrail.
> >
> > Yes, Geert had the same problem, but following the thread it seems to me
> > that     it is still unsolved, or I have not understand ?
> > I have not the necessary skill on SCSI to find and patch the problem, but
> > the developer(s) working on that can use me as tester or other.
>
> The problem is actually w/ PCI resources, if I remember it correctly.
> It's a problem in phys_to_bus, or so Geert determined.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
