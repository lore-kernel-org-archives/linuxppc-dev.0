Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 May 2007 13:22:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Message-ID: <20070507032206.GB21287@localhost.localdomain>
References: <20070504055455.GA25922@localhost.localdomain>
	<20070504055733.8FB7EDDFFD@ozlabs.org>
	<20070504143645.GA10645@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070504143645.GA10645@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 04, 2007 at 09:36:45AM -0500, Olof Johansson wrote:
> Hi,
> 
> Not much actual board support code in here, nice and clean. :-) Seems
> like most of this was boot wrapper enhancements.

Mostly, yes.  There will be more in-kernel support code coming
eventually, when we get PCI, the RTC and various other peripherals
going.

> Some comments below.
> 
> 
> -Olof
> 
> On Fri, May 04, 2007 at 03:57:33PM +1000, David Gibson wrote:
> 
> > Index: working-2.6/arch/powerpc/kernel/head_44x.S
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-05-03 10:19:32.000000000 +1000
> > +++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-05-04 13:46:51.000000000 +1000
> > @@ -709,16 +709,6 @@ _GLOBAL(giveup_fpu)
> >  	blr
> >  #endif
> >  
> > -/*
> > - * extern void abort(void)
> > - *
> > - * At present, this routine just applies a system reset.
> > - */
> > -_GLOBAL(abort)
> > -        mfspr   r13,SPRN_DBCR0
> > -        oris    r13,r13,DBCR0_RST_SYSTEM@h
> > -        mtspr   SPRN_DBCR0,r13
> > -
> 
> Looks like this rename is really separate from the platform support. Maybe
> post it as such in a patch before this one?

Hrm, I suppose I could.  Is it really worth it?

> Also, I know it was just a rename but you might want to add a "b ."
> after it, if for some reason the reset doesn't happen instantly to avoid
> executing random code afterwards.

Added.

[snip]
> > +static struct of_device_id ebony_of_bus[] = {
> > +	{ .type = "ibm,plb", },
> > +	{ .type = "ibm,opb", },
> > +	{ .type = "ibm,ebc", },
> > +	{},
> > +};
> > +
> > +static int __init ebony_device_probe(void)
> > +{
> > +	if (! machine_is(ebony))
> 
> Extra space after !

Fixed.

[snip]
> > Index: working-2.6/arch/powerpc/platforms/Makefile
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/platforms/Makefile	2007-02-14 10:58:22.000000000 +1100
> > +++ working-2.6/arch/powerpc/platforms/Makefile	2007-05-04 13:46:51.000000000 +1000
> > @@ -6,7 +6,8 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
> >  endif
> >  endif
> >  obj-$(CONFIG_PPC_CHRP)		+= chrp/
> > -obj-$(CONFIG_4xx)		+= 4xx/
> > +#obj-$(CONFIG_4xx)		+= 4xx/
> 
> Hmm?

Contrary to the comment in arch/powerpc/platforms/4xx/Makefile, an
empty Makefile does *not* compile correctly within Kbuild.  It's
commented out so we build again, obviously it will need to go back in
once there's any code that actually works in
arch/powerpc/platforms/4xx.

[snip]
> > Index: working-2.6/arch/powerpc/boot/dcr.h
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ working-2.6/arch/powerpc/boot/dcr.h	2007-05-04 13:46:51.000000000 +1000
> > @@ -0,0 +1,85 @@
> > +#ifndef _PPC_BOOT_DCR_H_
> > +#define _PPC_BOOT_DCR_H_
> > +
> > +#define mfdcr(rn) \
> > +	({	\
> > +		unsigned long rval; \
> > +		asm volatile("mfdcr %0,%1" : "=r"(rval) : "i"(rn)); \
> > +		rval; \
> > +	})
> > +#define mtdcr(rn, val) \
> > +	asm volatile("mtdcr %0,%1" : : "i"(rn), "r"(val))
> > +
> > +/* 440GP/440GX SDRAM controller DCRs */
> > +#define DCRN_SDRAM0_CFGADDR				0x010
> > +#define DCRN_SDRAM0_CFGDATA				0x011
> > +
> > +#define 	SDRAM0_B0CR				0x40
> > +#define 	SDRAM0_B1CR				0x44
> > +#define 	SDRAM0_B2CR				0x48
> > +#define 	SDRAM0_B3CR				0x4c
> > +
> > +static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR, SDRAM0_B2CR, SDRAM0_B3CR };
> > +
> > +#define			SDRAM_CONFIG_BANK_ENABLE        0x00000001
> > +#define			SDRAM_CONFIG_SIZE_MASK          0x000e0000
> > +#define			SDRAM_CONFIG_BANK_SIZE(reg)	\
> > +	(0x00400000 << ((reg & SDRAM_CONFIG_SIZE_MASK) >> 17))
> 
> Lots of tabs here? Other powerpc code tends to use
> <tab><space><space><space> for the register field defines indentation.
> 
> Same for below.

Yeah, I suppose they do.  Spacing revised through this file.

> > +
> > +/* 440GP Clock, PM, chip control */
> > +#define DCRN_CPC0_SR					0x0b0
> > +#define DCRN_CPC0_ER					0x0b1
> > +#define DCRN_CPC0_FR					0x0b2
> > +#define DCRN_CPC0_SYS0					0x0e0
> > +#define		CPC0_SYS0_TUNE				0xffc00000
> > +#define		CPC0_SYS0_FBDV_MASK			0x003c0000
> > +#define		CPC0_SYS0_FBDV(reg)			\
> > +	((((((reg) & CPC0_SYS0_FBDV_MASK) >> 18) - 1) & 0xf) + 1)
> 
> Would you mind a short comment about why the above math is needed?

Ok, I've regrouped all those macros together, and added:

/* Helper macros to compute the actual clock divider values from the
 * encodings in the CPC0 register */

[snip]
> > +#define SPRN_DBCR0		0x134
> > +#define   DBCR0_RST_SYSTEM	0x30000000
> > +
> > +static void ebony_exit(void)
> > +{
> > +	unsigned long tmp;
> > +
> > +	asm volatile (
> > +		"mfspr	%0,%1\n"
> > +		"oris	%0,%0,%2@h\n"
> > +		"mtspr	%1,%0"
> > +		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
> 
> You don't have to pass in the constants here, you can specify them in
> the asm. Makes it a little more readable.

As discussed in that other thread, not quite as easy as it sounds.
Unless, possibly, you use some abomination like asm volatile("#include
...")

[snip]

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
