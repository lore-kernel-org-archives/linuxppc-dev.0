Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id AB2D5DDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 11:02:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] 82xx: some 82xx platform hook functions can be shared
	by different boards
Date: Tue, 17 Jul 2007 02:59:46 +0200
References: <469B33F2.9040306@windriver.com>
In-Reply-To: <469B33F2.9040306@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707170259.47098.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 16 July 2007, Mark Zhan wrote:

> @@ -96,7 +94,7 @@
>   	pvid = mfspr(SPRN_PVR);
>   	svid = mfspr(SPRN_SVR);
> 
> -	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> +	seq_printf(m, "Vendor\t\t: %s\n", CPUINFO_VENDOR);
>   	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
>   	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
>   	seq_printf(m, "SVR\t\t: 0x%x\n", svid);

This is a step in the wrong direction. CPUINFO_{VENDOR,MACHINE}
comes from a platform specific header file, so you can not
use these definitions in platform independent code without
breaking multiplatform kernels.

One possible solution would be a platform specific show_cpuinfo()
function that calls a generic 82xx version and passes in the
two values. Even better would be to just dump whatever string
you find in the /model property in the device tree.

> +
> +#define RMR_CSRE 0x00000001
> +
> +void mpc82xx_restart(char *cmd)
> +{
> +	__volatile__ unsigned char dummy;
> +
> +	local_irq_disable();
> +	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
> +
> +	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
> +	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
> +	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
> +	printk("Restart failed\n");
> +	while (1) ;
> +}

I know you're just moving that code, but it looks horribly wrong
nonetheless. cpm2_immr is an __iomem variable, so you must not
dereference it but instead should use the in_8() macro to
access it.

Once you get that right, you don't need the volatile variable
any more.

> +void mpc82xx_halt(void)
> +{
> +	local_irq_disable();
> +	while (1) ;
> +}

Here, as in the function above, there should at least be a cpu_relax()
in the final loop. If the CPU has a nap functionality or something
similar, that would be even better.

	Arnd <><
