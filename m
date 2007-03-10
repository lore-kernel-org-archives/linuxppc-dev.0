Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67215DDF36
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 15:08:05 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l2A4OlN3318470
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 15:24:47 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2A4BYFP162540
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 15:11:34 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2A483lD001597
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 15:08:03 +1100
Date: Sat, 10 Mar 2007 15:08:02 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070310040802.GB17083@localhost.localdomain>
References: <20070305032452.EDB2BDDF1D@ozlabs.org>
	<1173462611.4861.51.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173462611.4861.51.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2007 at 11:50:11AM -0600, Josh Boyer wrote:
> On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> > Index: working-2.6/arch/powerpc/boot/ebony.c
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ working-2.6/arch/powerpc/boot/ebony.c	2007-02-26 13:46:05.000000000 +1100
> 
> > +
> > +static inline u32 mfpvr(void)
> > +{
> > +	u32 pvr;
> > +	asm volatile ("mfpvr	%0" : "=r"(pvr));
> > +	return pvr;
> > +}
> 
> This could probably go in a generic util.h file.

Yes.  I just wasn't sure where, so left it there for now.

> > +void poke_tree(const char *path, const char *name, void *val, int size)
> > +{
> > +	void *devp;
> > +	int ret;
> > +
> > +	devp = finddevice(path);
> > +	if (! devp) {
> > +		printf("Couldn't find node %s to poke\n\r", path);
> > +		exit();
> > +	}
> > +
> > +	ret = setprop(devp, name, val, size);
> > +	if (ret != 0) {
> > +		printf("Couldn't set %s property in %s\n\r", name, path);
> > +		exit();
> > +	}
> > +}
> > +
> > +#define poke_tree_val(path, name, val)	\
> > +	do { \
> > +		typeof(val) x = val; \
> > +		poke_tree((path),(name),&x,sizeof(x)); \
> > +	} while (0)
> > +
> > +/* Read the 44x memory controller to get size of system memory. */
> > +static void ibm44x_fixup_memsize(void)
> > +{
> > +	int i;
> > +	unsigned long memsize, bank_config;
> > +	u32 memreg[3];
> > +
> > +	memsize = 0;
> > +	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
> > +		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
> > +		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
> > +
> > +		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
> > +			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
> > +	}
> > +
> > +	printf("PPC44X: %dM RAM\n\r", memsize / 1024 / 1024);
> > +	memreg[0] = memreg[1] = 0;
> > +	memreg[2] = memsize;
> > +	poke_tree("/memory", "reg", memreg, sizeof(memreg));
> > +}
> 
> Is it possible to pull these three out into a 4xx_misc.c file?  The
> exact same memory fixup can be used on boards other than Ebony (Bamboo
> for example).

Yeah, I've been expecting to move those into a general use file,
something like that.  But I was going to wait until the second board
came along to see what's really common.  Oh, plus I'm not sure what to
do with the poke_tree() functions - they're not 44x specific at all,
but I'm wondering if they want cleaning up before being exported to
everybody.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
