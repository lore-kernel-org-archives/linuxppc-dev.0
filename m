Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCF75DE2F0
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 05:50:44 +1000 (EST)
Received: from mailhub3.br.ibm.com (unknown [9.18.232.110])
	by igw3.br.ibm.com (Postfix) with ESMTP id E962B39015A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 16:31:55 -0300 (BRST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m6PJoPwR2015446
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 16:50:30 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6PJoJkA008461
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 16:50:19 -0300
Subject: Re: [PATCH] powerpc: clean up the Book-E HW watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0807251425390.29749@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807251425390.29749@blarg.am.freescale.net>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 16:50:18 -0300
Message-Id: <1217015418.29012.67.camel@gargoyle>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Works for me.

I presume you had positive results on the Book-E as well.

By the way, thanks for cleaning it up.

Luis

On Fri, 2008-07-25 at 14:27 -0500, Kumar Gala wrote:
> * CONFIG_BOOKE is selected by CONFIG_44x so we dont need both
> * Fixed a few comments
> * Go back to only using DBCR0_IDM to determine if we are using
>   debug resources.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Luis, can you test this on 44x.  I don't expect any breakage.
> 
> - k
> 
>  arch/powerpc/kernel/entry_32.S |    6 +++---
>  arch/powerpc/kernel/process.c  |    8 ++++----
>  arch/powerpc/kernel/ptrace.c   |    7 ++++---
>  arch/powerpc/kernel/signal.c   |    2 +-
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 81c8324..da52269 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -148,7 +148,7 @@ transfer_to_handler:
>  	/* Check to see if the dbcr0 register is set up to debug.  Use the
>  	   internal debug mode bit to do this. */
>  	lwz	r12,THREAD_DBCR0(r12)
> -	andis.	r12,r12,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
> +	andis.	r12,r12,DBCR0_IDM@h
>  	beq+	3f
>  	/* From user and task is ptraced - load up global dbcr0 */
>  	li	r12,-1			/* clear all pending debug events */
> @@ -292,7 +292,7 @@ syscall_exit_cont:
>  	/* If the process has its own DBCR0 value, load it up.  The internal
>  	   debug mode bit tells us that dbcr0 should be loaded. */
>  	lwz	r0,THREAD+THREAD_DBCR0(r2)
> -	andis.	r10,r0,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
> +	andis.	r10,r0,DBCR0_IDM@h
>  	bnel-	load_dbcr0
>  #endif
>  #ifdef CONFIG_44x
> @@ -720,7 +720,7 @@ restore_user:
>  	/* Check whether this process has its own DBCR0 value.  The internal
>  	   debug mode bit tells us that dbcr0 should be loaded. */
>  	lwz	r0,THREAD+THREAD_DBCR0(r2)
> -	andis.	r10,r0,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
> +	andis.	r10,r0,DBCR0_IDM@h
>  	bnel-	load_dbcr0
>  #endif
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index db2497c..e030f3b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -254,7 +254,7 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
>  		return;
> 
>  	/* Clear the DAC and struct entries.  One shot trigger */
> -#if (defined(CONFIG_44x) || defined(CONFIG_BOOKE))
> +#if defined(CONFIG_BOOKE)
>  	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
>  							| DBCR0_IDM));
>  #endif
> @@ -286,7 +286,7 @@ int set_dabr(unsigned long dabr)
>  	mtspr(SPRN_DABR, dabr);
>  #endif
> 
> -#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE)
>  	mtspr(SPRN_DAC1, dabr);
>  #endif
> 
> @@ -373,7 +373,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
>  		set_dabr(new->thread.dabr);
> 
> -#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE)
>  	/* If new thread DAC (HW breakpoint) is the same then leave it */
>  	if (new->thread.dabr)
>  		set_dabr(new->thread.dabr);
> @@ -568,7 +568,7 @@ void flush_thread(void)
>  		current->thread.dabr = 0;
>  		set_dabr(0);
> 
> -#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE)
>  		current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W);
>  #endif
>  	}
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index a5d0e78..66204cb 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -717,7 +717,7 @@ void user_disable_single_step(struct task_struct *task)
>  	struct pt_regs *regs = task->thread.regs;
> 
> 
> -#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE)
>  	/* If DAC then do not single step, skip */
>  	if (task->thread.dabr)
>  		return;
> @@ -744,10 +744,11 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  	if (addr > 0)
>  		return -EINVAL;
> 
> +	/* The bottom 3 bits in dabr are flags */
>  	if ((data & ~0x7UL) >= TASK_SIZE)
>  		return -EIO;
> 
> -#ifdef CONFIG_PPC64
> +#ifndef CONFIG_BOOKE
> 
>  	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
>  	 *  It was assumed, on previous implementations, that 3 bits were
> @@ -769,7 +770,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  	task->thread.dabr = data;
> 
>  #endif
> -#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE)
> 
>  	/* As described above, it was assumed 3 bits were passed with the data
>  	 *  address, but we will assume only the mode bits will be passed
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 7aada78..2b5eaa6 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -147,7 +147,7 @@ int do_signal(sigset_t *oldset, struct pt_regs *regs)
>  	 */
>  	if (current->thread.dabr) {
>  		set_dabr(current->thread.dabr);
> -#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE)
>  		mtspr(SPRN_DBCR0, current->thread.dbcr0);
>  #endif
>  	}
