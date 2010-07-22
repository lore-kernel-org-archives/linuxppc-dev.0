Return-Path: <dvhltc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95532100815
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 09:57:29 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6MNn03o006124
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 17:49:00 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6MNvNKI163810
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 17:57:23 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6N00e4Z016084
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 18:00:41 -0600
Message-ID: <4C48DADE.1050409@us.ibm.com>
Date: Thu, 22 Jul 2010 16:57:18 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
In-Reply-To: <1279837509.1970.24.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2010 03:25 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-22 at 11:24 -0700, Darren Hart wrote:
>>
>> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
>> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
> 
> The preempt count is on the thread info at the bottom of the stack.
> 
> Can you check the stack pointers ?

Hi Ben, thanks for looking.

I instrumented the area around extended_cede_processor() as follows
(please confirm I'm getting the stack pointer correctly).

while (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
	asm("mr %0,1" : "=r" (sp));
	printk("before H_CEDE current->stack: %lx, pcnt: %x\n", sp, preempt_count());  
	extended_cede_processor(cede_latency_hint);
	asm("mr %0,1" : "=r" (sp));
	printk("after H_CEDE current->stack: %lx, pcnt: %x\n", sp, preempt_count());
 }


On Mainline (2.6.33.6, CONFIG_PREEMPT=y) I see this:
Jul 22 18:37:08 igoort1 kernel: before H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
Jul 22 18:37:08 igoort1 kernel: after H_CEDE current->stack:  c00000010e9e3ce0, pcnt: 1

This surprised me as preempt_count is 1 before and after, so no
corruption appears to occur on mainline. This makes the pcnt of 65 I see
without the preempt_count()=0 hack very strange. I ran several hundred
off/on cycles. The issue of preempt_count being 1 is still addressed by
this patch however.

On PREEMPT_RT (2.6.33.5-rt23 - tglx, sorry, rt/2.6.33 next time, promise):
Jul 22 18:51:11 igoort1 kernel: before H_CEDE current->stack: c000000089bcfcf0, pcnt: 1
Jul 22 18:51:11 igoort1 kernel: after H_CEDE current->stack:  c000000089bcfcf0, pcnt: ffffffff

In both cases the stack pointer appears unchanged.

Note: there is a BUG triggered in between these statements as the
preempt_count causes the printk to trigger:
Badness at kernel/sched.c:5572

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
