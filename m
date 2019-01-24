Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F6C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 17:05:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C3D20861
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 17:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C3D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lpSq2SYXzDqLT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 04:05:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43lpR36mTBzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 04:04:14 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9637E1596;
 Thu, 24 Jan 2019 09:04:13 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0223F237;
 Thu, 24 Jan 2019 09:04:11 -0800 (PST)
Date: Thu, 24 Jan 2019 17:04:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v14 05/12] powerpc: prep stack walkers for
 THREAD_INFO_IN_TASK
Message-ID: <20190124170409.GC5531@lakrids.cambridge.arm.com>
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
 <685ac94ceb1dfac43fbd2ee11a987cbaca63ab0b.1548346225.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685ac94ceb1dfac43fbd2ee11a987cbaca63ab0b.1548346225.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 24, 2019 at 04:19:39PM +0000, Christophe Leroy wrote:
> [text copied from commit 9bbd4c56b0b6
> ("arm64: prep stack walkers for THREAD_INFO_IN_TASK")]
> 
> When CONFIG_THREAD_INFO_IN_TASK is selected, task stacks may be freed
> before a task is destroyed. To account for this, the stacks are
> refcounted, and when manipulating the stack of another task, it is
> necessary to get/put the stack to ensure it isn't freed and/or re-used
> while we do so.
> 
> This patch reworks the powerpc stack walking code to account for this.
> When CONFIG_THREAD_INFO_IN_TASK is not selected these perform no
> refcounting, and this should only be a structural change that does not
> affect behaviour.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I'm not familiar with the powerpc code, but AFAICT this is analagous to
the arm64 code, and I'm not aware of any special caveats. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/powerpc/kernel/process.c    | 23 +++++++++++++++++++++--
>  arch/powerpc/kernel/stacktrace.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ce393df243aa..4ffbb677c9f5 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2027,7 +2027,7 @@ int validate_sp(unsigned long sp, struct task_struct *p,
>  
>  EXPORT_SYMBOL(validate_sp);
>  
> -unsigned long get_wchan(struct task_struct *p)
> +static unsigned long __get_wchan(struct task_struct *p)
>  {
>  	unsigned long ip, sp;
>  	int count = 0;
> @@ -2053,6 +2053,20 @@ unsigned long get_wchan(struct task_struct *p)
>  	return 0;
>  }
>  
> +unsigned long get_wchan(struct task_struct *p)
> +{
> +	unsigned long ret;
> +
> +	if (!try_get_task_stack(p))
> +		return 0;
> +
> +	ret = __get_wchan(p);
> +
> +	put_task_stack(p);
> +
> +	return ret;
> +}
> +
>  static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
>  
>  void show_stack(struct task_struct *tsk, unsigned long *stack)
> @@ -2067,6 +2081,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  	int curr_frame = 0;
>  #endif
>  
> +	if (!try_get_task_stack(tsk))
> +		return;
> +
>  	sp = (unsigned long) stack;
>  	if (tsk == NULL)
>  		tsk = current;
> @@ -2081,7 +2098,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  	printk("Call Trace:\n");
>  	do {
>  		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
> -			return;
> +			break;
>  
>  		stack = (unsigned long *) sp;
>  		newsp = stack[0];
> @@ -2121,6 +2138,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  
>  		sp = newsp;
>  	} while (count++ < kstack_depth_to_print);
> +
> +	put_task_stack(tsk);
>  }
>  
>  #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index e2c50b55138f..a5745571e06e 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -67,12 +67,17 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  {
>  	unsigned long sp;
>  
> +	if (!try_get_task_stack(tsk))
> +		return;
> +
>  	if (tsk == current)
>  		sp = current_stack_pointer();
>  	else
>  		sp = tsk->thread.ksp;
>  
>  	save_context_stack(trace, sp, tsk, 0);
> +
> +	put_task_stack(tsk);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
>  
> @@ -84,9 +89,8 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
>  EXPORT_SYMBOL_GPL(save_stack_trace_regs);
>  
>  #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
> -int
> -save_stack_trace_tsk_reliable(struct task_struct *tsk,
> -				struct stack_trace *trace)
> +static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
> +					   struct stack_trace *trace)
>  {
>  	unsigned long sp;
>  	unsigned long stack_page = (unsigned long)task_stack_page(tsk);
> @@ -193,6 +197,25 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  	}
>  	return 0;
>  }
> +
> +int save_stack_trace_tsk_reliable(struct task_struct *tsk,
> +				  struct stack_trace *trace)
> +{
> +	int ret;
> +
> +	/*
> +	 * If the task doesn't have a stack (e.g., a zombie), the stack is
> +	 * "reliably" empty.
> +	 */
> +	if (!try_get_task_stack(tsk))
> +		return 0;
> +
> +	ret = __save_stack_trace_tsk_reliable(trace, tsk);
> +
> +	put_task_stack(tsk);
> +
> +	return ret;
> +}
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
>  #endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
>  
> -- 
> 2.13.3
> 
