Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C1B30DDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 23:41:13 +1000 (EST)
Subject: Re: [PATCH 3/3] 82xx: SBCPQ2 board platform support
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707171419.05061.arnd@arndb.de>
References: <469B3401.9030602@windriver.com>
	<200707170327.41648.arnd@arndb.de> <1184655499.18501.17.camel@mark>
	<200707171419.05061.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 21:41:01 +0800
Message-Id: <1184679661.18501.41.camel@mark>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > The rtc M48T59 driver is not specific to my board, it is probably used
> > by other board. So I can't register the rtc intr handler as the mcheck
> > exception handler. And in the other side, there are also other machine
> > check sources, right?
> > 
> > So here I add a platform mcheck hook for rtc intr handler. Yeah, it is
> > really scary and confusing:-)
> 
> I think it would really be easier to just make the m48t59 irq handler
> a global function, and keep it out of the regular interrupt logic.
> 
> Then your sbcpq2_mach_check() basically becomes trivial like
> 
> static int sbcpq2_mach_check(struct pt_regs *regs)
> {
> 	return m48t59_irq(NO_IRQ, NULL);
> }
> 
> This has the advantage that you don't need to wait for the
> m48t59 driver to be initialized first, instead you will just
> get a link failure it that driver is not already built into the
> kernel.
> 

Since the rtc m48t59 driver has already gone into the -mm source tree,
and I think, it is an ugly way to make the irq handler a global
function:-)

If the driver is not built-in, and I still get the mach check exception,
it will turn out that other factors are causing mach check exception,
then just like my original codes, the kernel will not survive this
machine check, right?

> > > > +static void __init sbcpq2_init_IRQ(void)
> > > > +{
> > > > +	struct device_node *np;
> > > > +	struct resource res;
> > > > +
> > > > +	np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
> > > > +	if (np == NULL) {
> > > > +		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
> > > > +		return;
> > > > +	}
> > > 
> > > This looks like your device tree is wrong. Shouldn't the interrupt
> > > controller have device_type="interrupt-controller" and a specific
> > > compatible property instead of having the name in the device_type?
> > > 
> > 
> > Here, I just copy the codes from mpc82xx_ads, is there anything wrong?
> 
> I just checked the Recommended Practice document for interrupt mapping
> and it seems that it's ok. The interrupt controller needs to have
> an property named "interrupt-controller", but does not need a specific
> device_type. So it appears to be correct here.
> 

Thanks a lot for your good adivce, I will try.


> > > > +	/* Boot Flash is the on-board flash */
> > > > +	mc->memc_br0 = (SBCPQ2_BOOT_FLASH_BASE & 0xFFFF8000) | 0x0801;
> > > > +	mc->memc_or0 = 0xFFE00896;
> > > 
> > > consequently, this needs to use out_be32 or similar.
> > > Where does SBCPQ2_BOOT_FLASH_BASE come from? Shouldn't that be set
> > > up by the boot loader to match the device tree?
> > 
> > Fixed. out_be32 is used.
> 
> btw, it would be good if you can run your code through the 'sparse'
> checker. It will warn about this type of problem. I think I saw all
> that you have added here, but I may have missed some, and sparse
> can also find other problems.  Just install the tool as it comes
> with your distro and build the kernel with the 'C=1' make option.
> 
> > The reason why they are needed is because some 
> > legacy u-boot for this board probably was setting up the wrong memory
> > map.
> 
> Hmm, will those legacy u-boot version be able to even boot this kernel?
> The device tree looks like it needs to have some variables set by u-boot,
> so I'd guess you don't need to worry about old versions that don't
> set those either.

Actually, the current u-boot 1.2.0 for this board is ported from that
legacy one, and I don't check the details to assure that u-boot's setup
is all right. So here I just want to double assure everything goes
correct.

Thanks
Mark Zhan
