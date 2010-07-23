Return-Path: <willschm@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 826EFB7115
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 00:39:53 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6NENLJv000822
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:23:21 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6NEdos6283810
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:39:50 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6NEdmPr001128
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:39:50 -0400
In-Reply-To: <4C48DADE.1050409@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
To: dvhltc@linux.vnet.ibm.com
Message-ID: <OF05098931.134CCA5B-ON86257769.004FED9E-86257769.00508C16@us.ibm.com>
From: Will Schmidt <willschm@us.ibm.com>
Date: Fri, 23 Jul 2010 09:39:47 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dvhltc@linux.vnet.ibm.com wrote on 07/22/2010 06:57:18 PM:
> Subject
>
> Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
> CONFIG_PREEMPT on pseries
>
> On 07/22/2010 03:25 PM, Benjamin Herrenschmidt wrote:
> > On Thu, 2010-07-22 at 11:24 -0700, Darren Hart wrote:
> >>
> >> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
> >> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
> >
> > The preempt count is on the thread info at the bottom of the stack.
> >
> > Can you check the stack pointers ?
>
> Hi Ben, thanks for looking.
>
> I instrumented the area around extended_cede_processor() as follows
> (please confirm I'm getting the stack pointer correctly).
>
> while (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
>    asm("mr %0,1" : "=r" (sp));
>    printk("before H_CEDE current->stack: %lx, pcnt: %x\n", sp,
> preempt_count());
>    extended_cede_processor(cede_latency_hint);
>    asm("mr %0,1" : "=r" (sp));
>    printk("after H_CEDE current->stack: %lx, pcnt: %x\n", sp,
> preempt_count());
>  }
>
>
> On Mainline (2.6.33.6, CONFIG_PREEMPT=y) I see this:
> Jul 22 18:37:08 igoort1 kernel: before H_CEDE current->stack:
> c00000010e9e3ce0, pcnt: 1
> Jul 22 18:37:08 igoort1 kernel: after H_CEDE current->stack:
> c00000010e9e3ce0, pcnt: 1
>
> This surprised me as preempt_count is 1 before and after, so no
> corruption appears to occur on mainline. This makes the pcnt of 65 I see
> without the preempt_count()=0 hack very strange. I ran several hundred
> off/on cycles. The issue of preempt_count being 1 is still addressed by
> this patch however.
>
> On PREEMPT_RT (2.6.33.5-rt23 - tglx, sorry, rt/2.6.33 next time,
promise):
> Jul 22 18:51:11 igoort1 kernel: before H_CEDE current->stack:
> c000000089bcfcf0, pcnt: 1
> Jul 22 18:51:11 igoort1 kernel: after H_CEDE current->stack:
> c000000089bcfcf0, pcnt: ffffffff

I'm not seeing the preempt_count value corrupted with my current set of
debug, however, I have added buffers to the thread_info struct, so
wonder if I've moved the preempt_count variable out of the way of
the corruption.  (Still investigating that point..)

<Why..   because I had been trying to set a DABR on the preempt_count
value to catch the corrupter, and due to hits on the nearby _flags fields,
getting
false positives..>


struct thread_info {
|-------struct task_struct *task;|------|-------/* main task structure */
|-------struct exec_domain *exec_domain;|-------/* execution domain */
|-------int|----|-------cpu;|---|-------|-------/* cpu we're on */
|-------int|----|-------pad_buffer[64];
|-------int|----|-------preempt_count;|-|-------/* 0 => preemptable,
|-------|-------|-------|-------|-------|-------   <0 => BUG */
|-------int|----|-------pad_buffer2[256];
|-------struct restart_block restart_block;
|-------unsigned long|--local_flags;|---|-------/* private flags for thread
*/

|-------/* low level flags - has atomic operations done on it */
|-------unsigned long|--flags ____cacheline_aligned_in_smp;
};


>
> In both cases the stack pointer appears unchanged.
>
> Note: there is a BUG triggered in between these statements as the
> preempt_count causes the printk to trigger:
> Badness at kernel/sched.c:5572
>
> Thanks,
>
> --
> Darren Hart
> IBM Linux Technology Center
> Real-Time Linux Team
