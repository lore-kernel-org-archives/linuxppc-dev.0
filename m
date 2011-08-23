Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B941B6F86
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:09:02 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7N53YV7017150
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:03:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7N57bs81388708
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:07:39 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7N58rqG017571
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 15:08:53 +1000
Date: Tue, 23 Aug 2011 15:08:50 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces
	for new PPC ptrace flags
Message-ID: <20110823050850.GS30097@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075136.GB21817@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110819075136.GB21817@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2011 at 01:21:36PM +0530, K.Prasad wrote:
> PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
> PowerPC specific ptrace flags that use the watchpoint register. While they are
> targeted primarily towards BookE users, user-space applications such as GDB
> have started using them for BookS too.
> 
> This patch enables the use of generic hardware breakpoint interfaces for these
> new flags. The version number of the associated data structures
> "ppc_hw_breakpoint" and "ppc_debug_info" is incremented to denote new semantics.

So, the structure itself doesn't seem to have been extended.  I don't
understand what the semantic difference is - your patch comment needs
to explain this clearly.

> Apart from the usual benefits of using generic hw-breakpoint interfaces, these
> changes allow debuggers (such as GDB) to use a common set of ptrace flags for
> their watchpoint needs and allow more precise breakpoint specification (length
> of the variable can be specified).

What is the mechanism for implementing the range breakpoint on book3s?

> [Edjunior: Identified an issue in the patch with the sanity check for version
> numbers]
> 
> Tested-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  Documentation/powerpc/ptrace.txt |   16 ++++++
>  arch/powerpc/kernel/ptrace.c     |  104 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 112 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
> index f4a5499..97301ae 100644
> --- a/Documentation/powerpc/ptrace.txt
> +++ b/Documentation/powerpc/ptrace.txt
> @@ -127,6 +127,22 @@ Some examples of using the structure to:
>    p.addr2           = (uint64_t) end_range;
>    p.condition_value = 0;
>  
> +- set a watchpoint in server processors (BookS) using version 2
> +
> +  p.version         = 2;
> +  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
> +  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
> +  or
> +  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_EXACT;
> +
> +  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
> +  p.addr            = (uint64_t) begin_range;
> +  /* For PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE addr2 needs to be specified, where
> +   * addr2 - addr <= 8 Bytes.
> +   */
> +  p.addr2           = (uint64_t) end_range;
> +  p.condition_value = 0;
> +
>  3. PTRACE_DELHWDEBUG
>  
>  Takes an integer which identifies an existing breakpoint or watchpoint
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 05b7dd2..18d28b6 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -1339,11 +1339,17 @@ static int set_dac_range(struct task_struct *child,
>  static long ppc_set_hwdebug(struct task_struct *child,
>  		     struct ppc_hw_breakpoint *bp_info)
>  {
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	int ret, len = 0;
> +	struct thread_struct *thread = &(child->thread);
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */

I'm confused.  This compiled before on book3s, and I don't see any
changes to Makefile or Kconfig in the patch that will result in this
code compiling  when it previously didn't   Why are these new guards
added?

>  #ifndef CONFIG_PPC_ADV_DEBUG_REGS
>  	unsigned long dabr;
>  #endif
>  
> -	if (bp_info->version != 1)
> +	if ((bp_info->version != 1) && (bp_info->version != 2))
>  		return -ENOTSUPP;
>  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>  	/*
> @@ -1382,13 +1388,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
>  	 */
>  	if ((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0 ||
>  	    (bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0 ||
> -	    bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT ||
>  	    bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE)
>  		return -EINVAL;
>  
> -	if (child->thread.dabr)
> -		return -ENOSPC;
> -

You remove this test to see if the single watchpoint slot is already
in use, but I don't see another test replacing it.

>  	if ((unsigned long)bp_info->addr >= TASK_SIZE)
>  		return -EIO;
>  
> @@ -1398,15 +1400,86 @@ static long ppc_set_hwdebug(struct task_struct *child,
>  		dabr |= DABR_DATA_READ;
>  	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
>  		dabr |= DABR_DATA_WRITE;
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	if (bp_info->version == 1)
> +		goto version_one;

There are several legitimate uses of goto in the kernel, but this is
definitely not one of them.  You're essentially using it to put the
old and new versions of the same function in one block.  Nasty.

> +	if (ptrace_get_breakpoints(child) < 0)
> +		return -ESRCH;
>  
> -	child->thread.dabr = dabr;
> +	bp = thread->ptrace_bps[0];
> +	if (!bp_info->addr) {
> +		if (bp) {
> +			unregister_hw_breakpoint(bp);
> +			thread->ptrace_bps[0] = NULL;
> +		}
> +		ptrace_put_breakpoints(child);
> +		return 0;

Why are you making setting a 0 watchpoint remove the existing one (I
think that's what this does).  I thought there was an explicit del
breakpoint operation instead.

> +	}
> +	/*
> +	 * Check if the request is for 'range' breakpoints. We can
> +	 * support it if range < 8 bytes.
> +	 */
> +	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
> +		len = bp_info->addr2 - bp_info->addr;

So you compute the length here, but I don't see you ever test if it is
< 8 and return an error.

> +	else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
> +			ptrace_put_breakpoints(child);
> +			return -EINVAL;
> +		}
> +	if (bp) {
> +		attr = bp->attr;
> +		attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> +		arch_bp_generic_fields(dabr &
> +					(DABR_DATA_WRITE | DABR_DATA_READ),
> +							&attr.bp_type);
> +		attr.bp_len = len;
> +		ret =  modify_user_hw_breakpoint(bp, &attr);
> +		if (ret) {
> +			ptrace_put_breakpoints(child);
> +			return ret;
> +		}
> +		thread->ptrace_bps[0] = bp;
> +		ptrace_put_breakpoints(child);
> +		thread->dabr = dabr;
> +		return 0;
> +	}
>  
> +	/* Create a new breakpoint request if one doesn't exist already */
> +	hw_breakpoint_init(&attr);
> +	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;

You seem to be silently masking the given address, which seems
completely wrong.

> +	attr.bp_len = len;
> +	arch_bp_generic_fields(dabr & (DABR_DATA_WRITE | DABR_DATA_READ),
> +								&attr.bp_type);
> +
> +	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
> +					       ptrace_triggered, NULL, child);
> +	if (IS_ERR(bp)) {
> +		thread->ptrace_bps[0] = NULL;
> +		ptrace_put_breakpoints(child);
> +		return PTR_ERR(bp);
> +	}
> +
> +	ptrace_put_breakpoints(child);
> +	return 1;
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> +
> +version_one:
> +	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
> +		return -EINVAL;
> +
> +	if (child->thread.dabr)
> +		return -ENOSPC;
> +
> +	child->thread.dabr = dabr;
>  	return 1;
>  #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
>  }
>  
>  static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
>  {
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	struct thread_struct *thread = &(child->thread);
> +	struct perf_event *bp;
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>  	int rc;
>  
> @@ -1426,10 +1499,24 @@ static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
>  #else
>  	if (data != 1)
>  		return -EINVAL;
> +
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	if (ptrace_get_breakpoints(child) < 0)
> +		return -ESRCH;
> +
> +	bp = thread->ptrace_bps[0];
> +	if (bp) {
> +		unregister_hw_breakpoint(bp);
> +		thread->ptrace_bps[0] = NULL;
> +	}
> +	ptrace_put_breakpoints(child);
> +	return 0;
> +#else /* CONFIG_HAVE_HW_BREAKPOINT */
>  	if (child->thread.dabr == 0)
>  		return -ENOENT;
>  
>  	child->thread.dabr = 0;
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  
>  	return 0;
>  #endif
> @@ -1536,7 +1623,8 @@ long arch_ptrace(struct task_struct *child, long request,
>  	case PPC_PTRACE_GETHWDBGINFO: {
>  		struct ppc_debug_info dbginfo;
>  
> -		dbginfo.version = 1;
> +		/* We return the highest version number supported */
> +		dbginfo.version = 2;
>  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>  		dbginfo.num_instruction_bps = CONFIG_PPC_ADV_DEBUG_IACS;
>  		dbginfo.num_data_bps = CONFIG_PPC_ADV_DEBUG_DACS;
> @@ -1560,7 +1648,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  		dbginfo.data_bp_alignment = 4;
>  #endif
>  		dbginfo.sizeof_condition = 0;
> -		dbginfo.features = 0;
> +		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
>  #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
>  
>  		if (!access_ok(VERIFY_WRITE, datavp,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
