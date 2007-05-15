Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64082DDEC4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:47:31 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4G0nCkU6193380
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:49:12 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4G0p0KI063156
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:51:01 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4G0lTP6024600
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:47:29 +1000
Date: Wed, 16 May 2007 09:09:30 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] Derive ebc ranges property from EBC registers
Message-ID: <20070515230930.GB20290@localhost.localdomain>
References: <20070515045415.5B05ADDECE@ozlabs.org>
	<1179233998.3084.28.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179233998.3084.28.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 07:59:58AM -0500, Josh Boyer wrote:
> On Tue, 2007-05-15 at 14:54 +1000, David Gibson wrote:
> >  void ebony_init(void *mac0, void *mac1)
> > Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:38:39.000000000 +1000
> > +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:56.000000000 +1000
> > @@ -136,11 +136,9 @@
> >  				#address-cells = <2>;
> >  				#size-cells = <1>;
> >  				clock-frequency = <0>; // Filled in by zImage
> > -				ranges = <0 00000000 fff00000 100000
> > -					  1 00000000 48000000 100000
> > -					  2 00000000 ff800000 400000
> > -					  3 00000000 48200000 100000
> > -					  7 00000000 48300000 100000>;
> > +				// ranges property is supplied by zImage
> > +				// based on firmware's configuration of the
> > +				// EBC bridge
> 
> Do we want a "ranges;" here as a placeholder?  I don't see where it's
> absolutely required, but it makes me feel better for some reason...

Absolutely not.  An empty ranges property indicates that the child bus
address space is the same as the parent bus address space.  If we're
using the chip-select/offset addressing form for the EBC peripherals,
that's manifestly not the case.

> > +
> > +/* Read 4xx EBC bus bridge registers to get mappings of the peripheral
> > + * banks into the OPB address space */
> > +void ibm4xx_fixup_ebc_ranges(const char *ebc)
> > +{
> > +	void *devp;
> > +	u32 bxcr;
> > +	u32 ranges[EBC_NUM_BANKS*4];
> > +	u32 *p = ranges;
> > +	int i;
> > +
> > +	for (i = 0; i < EBC_NUM_BANKS; i++) {
> > +		mtdcr(DCRN_EBC0_CFGADDR, EBC_BXCR(i));
> > +		bxcr = mfdcr(DCRN_EBC0_CFGDATA);
> > +
> > +		if ((bxcr & EBC_BXCR_BU) != EBC_BXCR_BU_OFF) {
> > +			*p++ = i;
> > +			*p++ = 0;
> > +			*p++ = bxcr & EBC_BXCR_BAS;
> > +			*p++ = EBC_BXCR_BANK_SIZE(bxcr);
> > +		}
> > +	}
> > +
> > +	devp = finddevice(ebc);
> > +	if (! devp)
> > +		fatal("Couldn't locate EBC node %s\n\r", ebc);
> > +
> > +	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
> > +}
> 
> So this sets the ranges for the EBC bus, but not the "regs" properties
> of the child nodes.  Without that, the child nodes will not be mapped to
> the correct addresses...

Well, no, the child reg properties can't be deduced from the EBC
registers.

> Did you have a plan on how to fixup the child "regs" properties so that
> when the DIP switches are flipped around, the children show up
> correctly?

Well, on Ebony (AFAICT), the only child reg property that might need
adjustment is the small flash.  My MTD enabling patch includes some
code in the boot wrapper to toggle the appropriate bit in it's reg
property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
