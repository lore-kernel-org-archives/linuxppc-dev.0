Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNDTD3SFgzDvw8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 16:25:51 +1100 (AEDT)
Date: Tue, 22 Nov 2016 14:25:37 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev@lists.ozlabs.org, Ananth N
 Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc: kprobes: invoke handlers directly
Message-Id: <20161122142537.42e365a22d866026aa726bfe@kernel.org>
In-Reply-To: <1bde4adb6da9695007f409af9ea4db6be400ca54.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
References: <9dd0626d840e60b15603d767ce1576630fe1376d.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <1bde4adb6da9695007f409af9ea4db6be400ca54.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Naveen,

On Mon, 21 Nov 2016 22:36:41 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> ... rather than through notify_die(), to reduce path taken for handling
> kprobes. Similar to commit 6f6343f53d13 ("kprobes/x86: Call exception
> handlers directly from do_int3/do_debug").
> 
> While at it, rename post_kprobe_handler() to kprobe_post_handler() for
> more uniform naming.
> 
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes since v1:
> - Removed CONFIG_KPROBES guard in traps.c
> - Introduce CONFIG_KPROBES guard in asm/kprobes.h to prevent conflicts when
>   including both linux/kprobes.h as well as asm/kprobes.h
> 
>  arch/powerpc/include/asm/kprobes.h |  7 +++++++
>  arch/powerpc/kernel/kprobes.c      | 29 +++++++----------------------
>  arch/powerpc/kernel/traps.c        | 13 +++++++++++++
>  3 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index 2c9759bd..da30dc3 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -32,6 +32,7 @@
>  #include <asm/probes.h>
>  #include <asm/code-patching.h>
>  
> +#ifdef CONFIG_KPROBES
>  #define  __ARCH_WANT_KPROBES_INSN_SLOT
>  
>  struct pt_regs;
> @@ -127,5 +128,11 @@ struct kprobe_ctlblk {
>  extern int kprobe_exceptions_notify(struct notifier_block *self,
>  					unsigned long val, void *data);
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> +extern int kprobe_handler(struct pt_regs *regs);
> +extern int kprobe_post_handler(struct pt_regs *regs);
> +#else
> +static int kprobe_handler(struct pt_regs *regs) { return 0; }
> +static int kprobe_post_handler(struct pt_regs *regs) { return 0; }

These should be "static inline int kprobe_...", you lost 'inline' here.
Others are OK for me.

Thanks,

> +#endif /* CONFIG_KPROBES */
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_KPROBES_H */
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 9479d8e..ad108b8 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -140,13 +140,16 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  	regs->link = (unsigned long)kretprobe_trampoline;
>  }
>  
> -static int __kprobes kprobe_handler(struct pt_regs *regs)
> +int __kprobes kprobe_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *p;
>  	int ret = 0;
>  	unsigned int *addr = (unsigned int *)regs->nip;
>  	struct kprobe_ctlblk *kcb;
>  
> +	if (user_mode(regs))
> +		return 0;
> +
>  	/*
>  	 * We don't want to be preempted for the entire
>  	 * duration of kprobe processing
> @@ -359,12 +362,12 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
>   * single-stepped a copy of the instruction.  The address of this
>   * copy is p->ainsn.insn.
>   */
> -static int __kprobes post_kprobe_handler(struct pt_regs *regs)
> +int __kprobes kprobe_post_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *cur = kprobe_running();
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  
> -	if (!cur)
> +	if (!cur || user_mode(regs))
>  		return 0;
>  
>  	/* make sure we got here for instruction we have a kprobe on */
> @@ -470,25 +473,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  				       unsigned long val, void *data)
>  {
> -	struct die_args *args = (struct die_args *)data;
> -	int ret = NOTIFY_DONE;
> -
> -	if (args->regs && user_mode(args->regs))
> -		return ret;
> -
> -	switch (val) {
> -	case DIE_BPT:
> -		if (kprobe_handler(args->regs))
> -			ret = NOTIFY_STOP;
> -		break;
> -	case DIE_SSTEP:
> -		if (post_kprobe_handler(args->regs))
> -			ret = NOTIFY_STOP;
> -		break;
> -	default:
> -		break;
> -	}
> -	return ret;
> +	return NOTIFY_DONE;
>  }
>  
>  unsigned long arch_deref_entry_point(void *entry)
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 91d278c..38d5fbf 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -64,6 +64,7 @@
>  #include <asm/asm-prototypes.h>
>  #include <asm/hmi.h>
>  #include <sysdev/fsl_pci.h>
> +#include <asm/kprobes.h>
>  
>  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
>  int (*__debugger)(struct pt_regs *regs) __read_mostly;
> @@ -824,6 +825,9 @@ void single_step_exception(struct pt_regs *regs)
>  
>  	clear_single_step(regs);
>  
> +	if (kprobe_post_handler(regs))
> +		return;
> +
>  	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
>  					5, SIGTRAP) == NOTIFY_STOP)
>  		goto bail;
> @@ -1177,6 +1181,9 @@ void program_check_exception(struct pt_regs *regs)
>  		if (debugger_bpt(regs))
>  			goto bail;
>  
> +		if (kprobe_handler(regs))
> +			goto bail;
> +
>  		/* trap exception */
>  		if (notify_die(DIE_BPT, "breakpoint", regs, 5, 5, SIGTRAP)
>  				== NOTIFY_STOP)
> @@ -1745,6 +1752,9 @@ void DebugException(struct pt_regs *regs, unsigned long debug_status)
>  			return;
>  		}
>  
> +		if (kprobe_post_handler(regs))
> +			return;
> +
>  		if (notify_die(DIE_SSTEP, "block_step", regs, 5,
>  			       5, SIGTRAP) == NOTIFY_STOP) {
>  			return;
> @@ -1759,6 +1769,9 @@ void DebugException(struct pt_regs *regs, unsigned long debug_status)
>  		/* Clear the instruction completion event */
>  		mtspr(SPRN_DBSR, DBSR_IC);
>  
> +		if (kprobe_post_handler(regs))
> +			return;
> +
>  		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
>  			       5, SIGTRAP) == NOTIFY_STOP) {
>  			return;
> -- 
> 2.10.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
