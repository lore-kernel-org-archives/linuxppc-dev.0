Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1E01B7D6C
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:38:20 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4O3eMFY001167
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 09:10:22 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4O4cHAx3002380
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 10:08:17 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4O4cGkQ023149
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:38:16 +1000
Date: Mon, 24 May 2010 10:08:12 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC Patch 2/5] PPC64-HWBKPT: Implement hw-breakpoints for
	PowerPC Book III S
Message-ID: <20100524043812.GA21098@in.ibm.com>
References: <20100524034520.964014525@linux.vnet.ibm.com>
	<20100524040225.GC20873@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100524040225.GC20873@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 24, 2010 at 09:32:25AM +0530, K.Prasad wrote:
> Implement perf-events based hw-breakpoint interfaces for PowerPC Book III S
> processors. These interfaces help arbitrate requests from various users and
> schedules them as appropriate.
> 
<snipped>
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_handler(struct die_args *args)
> +{
> +	bool is_kernel, is_ptrace_bp = false;
> +	int rc = NOTIFY_STOP;
> +	struct perf_event *bp;
> +	struct pt_regs *regs = args->regs;
> +	unsigned long dar = regs->dar;
> +	int stepped = 1;
> +	struct arch_hw_breakpoint *info;
> +
> +	/* Disable breakpoints during exception handling */
> +	set_dabr(0);
> +	/*
> +	 * The counter may be concurrently released but that can only
> +	 * occur from a call_rcu() path. We can then safely fetch
> +	 * the breakpoint, use its callback, touch its counter
> +	 * while we are in an rcu_read_lock() path.
> +	 */
> +	rcu_read_lock();
> +
> +	bp = __get_cpu_var(bp_per_reg);
> +	if (!bp)
> +		goto out;
> +	info = counter_arch_bp(bp);
> +	is_kernel = is_kernel_addr(bp->attr.bp_addr);
> +	is_ptrace_bp = (bp->overflow_handler == ptrace_triggered) ?
> +			true : false;
> +
> +	/*
> +	 * Verify if dar lies within the address range occupied by the symbol
> +	 * being watched to filter extraneous exceptions.
> +	 */
> +	if (!((bp->attr.bp_addr <= dar) &&
> +	    (dar <= (bp->attr.bp_addr + bp->attr.bp_len))) &&
> +	    (!is_ptrace_bp))
> +		/*
> +		 * This exception is triggered not because of a memory access on
> +		 * the monitored variable but in the double-word address range
> +		 * in which it is contained. We will consume this exception,
> +		 * considering it as 'noise'.
> +		 */
> +		goto restore_bp;
> +
> +	/*
> +	 * Return early after invoking user-callback function without restoring
> +	 * DABR if the breakpoint is from ptrace which always operates in
> +	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
> +	 * generated in do_dabr().
> +	 */
> +	if (is_ptrace_bp) {
> +		perf_bp_event(bp, regs);
> +		rc = NOTIFY_DONE;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Do not emulate user-space instructions from kernel-space,
> +	 * instead single-step them.
> +	 */
> +	if (!is_kernel) {
> +		bp->ctx->task->thread.last_hit_ubp = bp;
> +		regs->msr |= MSR_SE;
> +		goto out;
> +	}
> +
> +	stepped = emulate_step(regs, regs->nip);
> +	/* emulate_step() could not execute it, single-step them */
> +	if (stepped == 0) {

As I was responding to one of the previous mails, I realised that I
had not made changes here as Paul Mackerras had suggested
(reference linuxppc-dev message-id:
20100520131003.GB29903@brick.ozlabs.ibm.com) i.e. uninstall breakpoint
if single-stepping failed.

I'll quickly send out a revised patch as a reply to this one. Regrets
for the confusion caused.

Thanks,
K.Prasad

> +		regs->msr |= MSR_SE;
> +		__get_cpu_var(last_hit_bp) = bp;
> +		goto out;
> +	}
> +	/*
> +	 * As a policy, the callback is invoked in a 'trigger-after-execute'
> +	 * fashion
> +	 */
> +	perf_bp_event(bp, regs);
> +
> +restore_bp:
> +	set_dabr(info->address | info->type | DABR_TRANSLATION);
> +out:
> +	rcu_read_unlock();
> +	return rc;
> +}
