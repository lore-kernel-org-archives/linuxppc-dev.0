Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B477BB7BE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 16:20:16 +1000 (EST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B236DDDD3
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:16 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id n6V6IE5F014559
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:18:14 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6V6KEXg1277994
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:14 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6V6KDBQ027853
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:14 +1000
Date: Fri, 31 Jul 2009 16:18:54 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 3/6] Modify ptrace code to use Hardware Breakpoint
	interfaces
Message-ID: <20090731061854.GI3950@yookeroo.seuss>
References: <20090726235854.574539012@prasadkr_t60p.in.ibm.com>
	<20090727001324.GD13562@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090727001324.GD13562@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 27, 2009 at 05:48:27AM +0530, K.Prasad wrote:
> Modify the ptrace code to use the hardware breakpoint interfaces for user-space.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/ptrace.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> @@ -37,6 +37,7 @@
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  #include <asm/system.h>
> +#include <asm/hw_breakpoint.h>
>  
>  /*
>   * does not yet catch signals sent when the child dies.
> @@ -757,11 +758,24 @@ void user_disable_single_step(struct tas
>  
>  void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
>  {
> +	/*
> +	 * Unregister the breakpoint request here since ptrace has defined a
> +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> +	 * We don't have to do anything here
> +	 */
> +	unregister_user_hw_breakpoint(current, bp);
> +	kfree(bp);

This unregisters the breakpoint, but doesn't actually abort the
current breakpoint handling sequence it's invoked from.  So, if your
breakpoint handler was invoked at all, which as previously mentioned,
I don't think it is, wouldn't this result in *two* SIGTRAPs from a
ptrace breakpoint: one issued before the trapping instruction from
do_dabr() and another afterwards from your step-over code.

>  }
>  
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  			       unsigned long data)
>  {
> +#ifdef CONFIG_PPC64
> +	struct thread_struct *thread = &(task->thread);
> +	struct hw_breakpoint *bp;
> +	int ret;
> +#endif
>  	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
>  	 *  For embedded processors we support one DAC and no IAC's at the
>  	 *  moment.
> @@ -791,6 +805,35 @@ int ptrace_set_debugreg(struct task_stru
>  	if (data && !(data & DABR_TRANSLATION))
>  		return -EIO;
>  
> +#ifdef CONFIG_PPC64
> +	bp = thread->hbp[0];
> +	if (data == 0) {
> +		if (bp) {
> +			unregister_user_hw_breakpoint(task, bp);
> +			kfree(bp);
> +		}
> +		return 0;
> +	}
> +
> +	if (bp) {
> +		bp->info.type = data & HW_BREAKPOINT_RW;
> +		task->thread.dabr = bp->info.address = data;
> +		return modify_user_hw_breakpoint(task, bp);
> +	}
> +	bp = kzalloc(sizeof(struct hw_breakpoint), GFP_KERNEL);
> +	if (!bp)
> +		return -ENOMEM;
> +
> +	/* Store the type of breakpoint */
> +	bp->info.type = data & HW_BREAKPOINT_RW;
> +	bp->triggered = ptrace_triggered;
> +	task->thread.dabr = bp->info.address = data;
> +
> +	ret = register_user_hw_breakpoint(task, bp);
> +	if (ret)
> +		return ret;
> +#endif /* CONFIG_PPC64 */
> +
>  	/* Move contents to the DABR register */
>  	task->thread.dabr = data;
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
