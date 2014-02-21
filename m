Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EEF422C0304
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 08:53:35 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] powerpc: Added PCI MSI support using the HSTA module
Date: Fri, 21 Feb 2014 22:53:00 +0100
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
 <1574137.lzDhNaVqIe@wuerfel> <1393015286.6771.110.camel@pasglop>
In-Reply-To: <1393015286.6771.110.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201402212253.01101.arnd@arndb.de>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 February 2014, Benjamin Herrenschmidt wrote:
> On Fri, 2014-02-21 at 15:33 +0100, Arnd Bergmann wrote:
> 
> > > @@ -242,8 +264,10 @@
> > >  			ranges = <0x02000000 0x00000000 0x80000000 0x00000110 0x80000000 0x0 0x80000000
> > >  			          0x01000000 0x0        0x0        0x00000140 0x0        0x0 0x00010000>;
> > >  
> > > -			/* Inbound starting at 0 to memsize filled in by zImage */
> > > -			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
> > > +			/* Inbound starting at 0x0 to 0x40000000000. In order to use MSI
> > > +			 * PCI devices must be able to write to the HSTA module.
> > > +			 */
> > > +			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x400 0x0>;
> 
> Should we (provided it's possible in HW) create two ranges instead ? One
> covering RAM and one covering MSIs ? To avoid stray DMAs whacking random
> HW registers in the chip ...
> 
> > >  			/* This drives busses 0 to 0xf */
> > >  			bus-range = <0x0 0xf>;
> > 
> > Ah, I first only saw the line you are removing and was about
> > to suggest what you do anyway. Great!
> > 
> > > diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> > > index 54ec1d5..7cc3acc 100644
> > > --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> > > +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> > > @@ -176,8 +176,12 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
> > >  		return -ENXIO;
> > >  	}
> > >  
> > > -	/* Check that we are fully contained within 32 bits space */
> > > -	if (res->end > 0xffffffff) {
> > > +	/* Check that we are fully contained within 32 bits space if we are not
> > > +	 * running on a 460sx or 476fpe which have 64 bit bus addresses.
> > > +	 */
> > > +	if (res->end > 0xffffffff &&
> > > +	    !(of_device_is_compatible(hose->dn, "ibm,plb-pciex-460sx")
> > > +	      || of_device_is_compatible(hose->dn, "ibm,plb-pciex-476fpe"))) {
> > >  		printk(KERN_ERR "%s: dma-ranges outside of 32 bits space\n",
> > >  		       hose->dn->full_name);
> > >  		return -ENXIO;
> > 
> > A more general question for BenH: Apparently this PCI implementation is
> > getting reused on arm64 for APM X-Gene. Do you see any value in trying to
> > share host controller drivers like this one across powerpc and arm64?
> 
> I would start duplicating, and see how much common code remains... Then
> eventually merge.

Ok.

> > It's possible we are going to see the same situation with fsl_pci in the
> > future, if arm and powerpc qoriq chips use the same peripherals. My
> > plan for arm64 right now is to make PCI work without any code in arch/,
> > just using new helper functions in drivers/pci and sticking the host
> > drivers into drivers/pci/host as we started doing for arm32, but it
> > can require significant work to make those drivers compatible with
> > the powerpc pci-common.c.
> 
> powerpc pci-common.c is shrinking :-) At least the address remapping is
> all in the core now, we could move more over I suppose...

Ah, good. We're currently trying to work out a generic way to parse
the DT and ioremap the I/O windows. That could probably be shared
and while I hope what we need on arm64 is compatible with what you
need on powerpc, I may always miss something. I'll make sure to add
you to the discussions.

Some parts are easier because we assume that we always scan the
entire PCI bus ourselves and don't do PCI_PROBE_DEVTREE. 
Other parts are harder because for the generic case we actually
want to support loading and unloading host bridge drivers,
as well as supporting any combination of host bridges in the
same system without platform specific code.

	Arnd
