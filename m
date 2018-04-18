Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RHyj0yZyzF21B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 09:15:08 +1000 (AEST)
Message-ID: <1524093296.11062.358.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc64s: Print exception vector name alongside the
 trap number
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 19 Apr 2018 09:14:56 +1000
In-Reply-To: <20180418090205.30844-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20180418090205.30844-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-18 at 14:32 +0530, Naveen N. Rao wrote:
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static char *print_trap(unsigned long trapno)
> +{
> +	trapno &= 0xff0;
> +	switch (trapno) {
> +		case 0x100:	return "SRESET";
> +		case 0x200:	return "MCE";
> +		case 0x300:	return "DSI";
> +		case 0x380:	return "DSISLB";
> +		case 0x400:	return "ISI";
> +		case 0x480:	return "ISISLB";

380 and 480 should probably be "DSEG" and "ISEG" ... they may or may
not involve the SLB.

> +		case 0x500:	return "EXT";
> +		case 0x600:	return "ALIGN";
> +		case 0x700:	return "PCHECK";
> +		case 0x800:	return "FP";
> +		case 0x900:	return "DEC";
> +		case 0x980:	return "HDEC";
> +		case 0xa00:	return "DBELL";
> +		case 0xc00:	return "SC";
> +		case 0xd00:	return "SSTEP";
> +		case 0xe00:	return "HDSI";
> +		case 0xe20:	return "HISI";
> +		case 0xe40:	return "HEMUL";
> +		case 0xe60:	return "HMI";
> +		case 0xe80:	return "HDBELL";
> +		case 0xea0:	return "HVIRT";
> +		case 0xf00:	return "PMI";
> +		case 0xf20:	return "ALTIVEC";
> +		case 0xf40:	return "VSX";
> +		case 0xf60:	return "UNAVAIL";
> +		case 0xf80:	return "HUNAVAIL";
> +	}
> +	return "UNKNOWN";
> +}
> +#endif
> +
>  void show_regs(struct pt_regs * regs)
>  {
>  	int i, trap;
> @@ -1422,8 +1458,14 @@ void show_regs(struct pt_regs * regs)
>  
>  	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
>  	       regs->nip, regs->link, regs->ctr);
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	printk("REGS: %px TRAP: %04lx (%s)  %s  (%s)\n",
> +	       regs, regs->trap, print_trap(regs->trap), print_tainted(),
> +	       init_utsname()->release);
> +#else
>  	printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
>  	       regs, regs->trap, print_tainted(), init_utsname()->release);
> +#endif
>  	printk("MSR:  "REG" ", regs->msr);
>  	print_msr_bits(regs->msr);
>  	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
