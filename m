Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHW4f6XmZzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 15:06:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 06/10] powerpc: nmi_enter for system reset
In-Reply-To: <20161219183011.28310-7-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
 <20161219183011.28310-7-npiggin@gmail.com>
Date: Tue, 07 Feb 2017 15:06:58 +1100
Message-ID: <878tpifxul.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> System reset is a non-maskable interrupt from Linux's point of view
> (occurs under local_irq_disable()), so it should use nmi_enter/exit.
...
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 802aa6bbe97b..c65c88fb6482 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -278,6 +278,14 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>  
>  void system_reset_exception(struct pt_regs *regs)
>  {
> +	/*
> +	 * Avoid crashes in case of nested NMI exceptions. Recoverability
> +	 * is determined by RI and in_nmi
> +	 */
> +	bool nested = in_nmi();
> +	if (!nested)
> +		nmi_enter();
> +
>  	/* See if any machine dependent calls */
>  	if (ppc_md.system_reset_exception) {
>  		if (ppc_md.system_reset_exception(regs))


This breaks my QS22 (Cell blade), I get lots of RCU stalls such as:

  INFO: rcu_sched self-detected stall on CPU
  	0-...: (5249 ticks this GP) idle=ad6/1/1 softirq=3/3 fqs=3 
  	 (t=5250 jiffies g=-298 c=-299 q=1289)
  rcu_sched kthread starved for 5234 jiffies! g18446744073709551318 c18446744073709551317 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
  rcu_sched       S    0     8      2 0x00000800
  Call Trace:
  [c0000003fb9d7950] [c000000000014730] .__switch_to+0x218/0x2b0
  [c0000003fb9d7a00] [c0000000006a0668] .__schedule+0x268/0x778
  [c0000003fb9d7ae0] [c0000000006a0bb0] .schedule+0x38/0xb0
  [c0000003fb9d7b60] [c0000000006a7ba4] .schedule_timeout+0x184/0x2f0
  [c0000003fb9d7c50] [c000000000106c5c] .rcu_gp_kthread+0x5ec/0xa60
  [c0000003fb9d7d70] [c0000000000c69d0] .kthread+0x148/0x188
  [c0000003fb9d7e30] [c00000000000ba70] .ret_from_kernel_thread+0x58/0x68

And I never get to userspace.

This is because cbe_system_reset_exception() doesn't like being called
after nmi_enter() - though I don't know exactly what the problem is.

Moving the nmi_enter() after the ppc_md hook (and fixing up the goto
etc.) fixes it, but that's not really a great solution.

I suspect it will also break pasemi, because it does something similar.

I'm not clear on how best to fix it ATM.

cheers
