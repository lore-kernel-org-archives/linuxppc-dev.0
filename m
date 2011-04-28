Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5B51B6FC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 07:15:04 +1000 (EST)
Subject: Re: device not available because of BAR 0 collisions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <4DB9D7ED.5090208@harris.com>
References: <4DB5D548.7020303@harris.com>
	<1303776114.2513.152.camel@pasglop>  <4DB6CAD0.5030102@harris.com>
	<1303861178.2513.171.camel@pasglop> <4DB873B6.1000809@harris.com>
	<4DB9A3F1.9070300@harris.com> <1304024141.2513.196.camel@pasglop>
	<4DB9D7ED.5090208@harris.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Apr 2011 07:14:31 +1000
Message-ID: <1304025271.2513.199.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-04-28 at 17:11 -0400, Steven A. Falco wrote:

> It is in __dev_sort_resources() in setup-bus.c
> 
> There is this test:
> 
> 	/* Don't touch classless devices or host bridges or ioapics.  */
> 	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
> 		return;
> 
> where PCI_CLASS_NOT_DEFINED is 0x0000.  So basically Linux skips over allocating
> anything with a class of 0.

Ah nice. Can you try the quirk ?

Cheers,
Ben.

> 	Steve
> 
> > 
> >> My choices appear to be:
> >>
> >> 1) Fix the ASIC (yeah, right)
> >>
> >> 2) Force Linux to use the U-Boot settings
> >>
> >> 3) Hack Linux to set up a device with a bogus class.
> >>
> >> I'm not sure why this hardware works in x86 - I guess it is less
> >> fussy.
> > 
> > x86 probably just re-uses whatever setting the BIOS does, but I'm still
> > a bit surprised by your class code story.
> > 
> > I supose you can do a PCI header quirk that overrides the class code in
> > struct pci_dev. Something like:
> > 
> > static void __devinit quirk_your_asic_class(struct pci_dev *dev)
> > {
> > 	dev->class = foobar;
> > }
> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_xxx, PCI_DEVICE_ID_yyy, quirk_your_asic_class);
> > 
> > But I'd like to figure out where that is tested bcs I haven't found so
> > far...
> > 
> >> 	Steve
> >>
> >>>>>>>
> >>>>>>> I see in setup-res.c that this message comes out when there is no
> >>>>>>> parent for
> >>>>>>> a device resource.
> >>>>>>
> >>>>>>  .../...
> >>>>>>
> >>>>>> It mostly happens in arch/powerpc/kernel/pci-common.c and the generic
> >>>>>> setup-res.c
> >>>>>>
> >>>>>> Try #define DEBUG at the top (before the #includes) of pci-common.c and
> >>>>>> pci_32.c (remove the exiting #undef in the last one) and send us the
> >>>>>> full dmesg log, along with the output of cat /proc/iomem
> >>>>
> >>>> Have you set any specific flags ? IE. Modified the value of
> >>>> ppc_pci_flags from what the 4xx code sets originally ?
> >>>
> >>> For fun, I just tried changing:
> >>>
> >>> ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
> >>>
> >>> to:
> >>>
> >>> ppc_pci_set_flags(PPC_PCI_PROBE_ONLY);
> >>>
> >>> I realize that is the exact opposite of what you were suggesting, but
> >>> please bear with me for a bit.
> >>>
> >>> I also changed the PCIE 0 ranges from:
> >>>
> >>> ranges = <0x02000000 0x00000000 0x80000000 0x90000000 0x00000000 0x10000000
> >>>           0x01000000 0x00000000 0x00000000 0xe8010000 0x00000000 0x00010000>;
> >>>
> >>> ranges = <0x02000000 0x00000000 0x90000000 0x90000000 0x00000000 0x10000000
> >>>           0x01000000 0x00000000 0x00000000 0xe8010000 0x00000000 0x00010000>;
> >>>
> >>> I changed the ranges not because I wanted a 1:1 map, but because 90000000 is
> >>> what U-Boot chooses when it scans PCIe 1.
> >>>
> >>> At this point, everything is working.  Here is /proc/iomap:
> >>>
> >>> 90000000-9fffffff : /plb/pciex@0c0000000
> >>>   90000000-94ffffff : PCI Bus 0001:41
> >>>     90000000-9001ffff : 0001:41:00.0
> >>>     90100000-94ffffff : PCI Bus 0001:42
> >>>       90100000-92ffffff : PCI Bus 0001:43
> >>>         91000000-91ffffff : 0001:43:00.0  //<--- was missing before
> >>>         92000000-92ffffff : 0001:43:00.0  //<--- was missing before
> >>>       93000000-94ffffff : PCI Bus 0001:44
> >>>         93000000-93ffffff : 0001:44:00.0  //<--- was missing before
> >>>         94000000-94ffffff : 0001:44:00.0  //<--- was missing before
> >>> e0000000-e7ffffff : /plb/pciex@0a0000000
> >>>   e0000000-e7ffffff : PCI Bus 0000:01
> >>>     e0000000-e00fffff : 0000:01:00.0
> >>>     e0100000-e01fffff : 0000:01:00.0
> >>>     e4000000-e7ffffff : 0000:01:00.0
> >>> ef600200-ef600207 : serial
> >>> ef600300-ef600307 : serial
> >>> ef600600-ef600606 : spi_ppc4xx_of
> >>> ef6c0000-ef6cffff : dwc_otg.0
> >>>   ef6c0000-ef6cffff : dwc_otg
> >>> fc000000-ffffffff : fc000000.nor_flash
> >>>
> >>> Now I see the bars for the ASICs (flagged above).  I could stop here,
> >>> and declare success, but I don't really like this solution, because it
> >>> requires me to be sure the dts has the same bus addresses that U-Boot
> >>> will choose.  Seems risky.
> >>>
> >>> Tentative conclusion:  Either I still have something set wrong in my dts
> >>> or there is a bug in the Linux PCI bus mapping code.
> >>>
> >>> 	Steve
> >>>
> >>>>
> >>>> It does look to me like some of your device BARs have been setup already
> >>>> by the firmware in a way that conflict with the way you configure your
> >>>> ranges, and the kernel doesn't appear to detect nor try to remap that
> >>>> which would happen if you have the "probe only" flag set.
> >>>>
> >>>> IE. On your c0000000 bus, you have memory at 90000000 CPU space mapped
> >>>> to 80000000 PCI space. However, when probing, the kernel finds:
> >>>>
> >>>> pci 0001:41:00.0: reg 10 32bit mmio: [0x90000000-0x9001ffff]
> >>>>
> >>>> IE. A BAR was already set with a value of 90000000 PCI-side which is out
> >>>> of the bounds you have for your bus.
> >>>>
> >>>> Maybe you really want to configure that second bus to have CPU 90000000
> >>>> mapped to 90000000 PCI-side ? (IE. a 1:1 mapping). That would be
> >>>> something to fix in your "ranges" property.
> >>>>
> >>>> Cheers,
> >>>> Ben.
> >>>
> >>>
> >>
> >>
> > 
> > 
> > 
> 
> 
