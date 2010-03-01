Return-Path: <olof@lixom.net>
Date: Mon, 1 Mar 2010 15:08:11 -0600
From: Olof Johansson <olof@lixom.net>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 04/13] powerpc/476: add machine check handler for
	47x core
Message-ID: <20100301210811.GA6699@lixom.net>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191323.20987.13284.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100301191323.20987.13284.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 01, 2010 at 05:13:23AM -0700, Dave Kleikamp wrote:
> powerpc/476: add machine check handler for 47x core
> 
> From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> 
> The 47x core's MCSR varies from 44x, so it needs it's own machine check
> handler.


> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -376,6 +376,44 @@ int machine_check_440A(struct pt_regs *regs)
>  	}
>  	return 0;
>  }
> +
> +int machine_check_47x(struct pt_regs *regs)
> +{
> +	unsigned long reason = get_mc_reason(regs);
> +
> +	printk("Machine check in kernel mode.\n");

It's quite possible that the other machine check handlers don't have
printk KERN_-levels on them but it would be a good idea to use them here.

> +	if (reason & ESR_IMCP){
> +		printk("Instruction Synchronous Machine Check exception\n");
> +		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
> +	}
> +	else {

} else {

Or, rather, add an early return above and you can just remove one level of indentation below.


> +		u32 mcsr = mfspr(SPRN_MCSR);
> +		if (mcsr & MCSR_IB)
> +			printk("Instruction Read PLB Error\n");
> +		if (mcsr & MCSR_DRB)
> +			printk("Data Read PLB Error\n");
> +		if (mcsr & MCSR_DWB)
> +			printk("Data Write PLB Error\n");
> +		if (mcsr & MCSR_TLBP)
> +			printk("TLB Parity Error\n");
> +		if (mcsr & MCSR_ICP){
> +			flush_instruction_cache();
> +			printk("I-Cache Parity Error\n");
> +		}
> +		if (mcsr & MCSR_DCSP)
> +			printk("D-Cache Search Parity Error\n");
> +		if (mcsr & PPC47x_MCSR_GPR)
> +			printk("GPR Parity Error\n");
> +		if (mcsr & PPC47x_MCSR_FPR)
> +			printk("FPR Parity Error\n");
> +		if (mcsr & PPC47x_MCSR_IMP)
> +			printk("Machine Check exception is imprecise\n");
> +
> +		/* Clear MCSR */
> +		mtspr(SPRN_MCSR, mcsr);
> +	}
> +	return 0;
> +}
