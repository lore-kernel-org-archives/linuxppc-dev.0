Return-Path: <dvhltc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B2C6B70ED
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 04:47:40 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o81ITSj7026012
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Sep 2010 14:29:28 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o81IlaNA306310
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Sep 2010 14:47:36 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o81IlYVb004874
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Sep 2010 14:47:36 -0400
Message-ID: <4C7E9FC1.60004@us.ibm.com>
Date: Wed, 01 Sep 2010 11:47:29 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com>
In-Reply-To: <4C7E6CCC.8090700@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Ankita Garg <ankita@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2010 08:10 AM, Darren Hart wrote:
> On 08/31/2010 10:54 PM, Michael Ellerman wrote:
>> On Tue, 2010-08-31 at 00:12 -0700, Darren Hart wrote:
>> ..
>>>
>>> When running with the function plugin I had to stop the trace
>>> immediately before entering start_secondary after an online or my traces
>>> would not include the pseries_mach_cpu_die function, nor the tracing I
>>> added there (possibly buffer size, I am using 2048). The following trace
>>> was collected using "trace-cmd record -p function -e irq -e sched" and
>>> has been filtered to only show CPU [001] (the CPU undergoing the
>>> offline/online test, and the one seeing preempt_count (pcnt) go to
>>> ffffffff after cede. The function tracer does not indicate anything
>>> running on the CPU other than the HCALL - unless the __trace_hcall*
>>> commands might be to blame. 
>>
>> It's not impossible. Though normally they're disabled right, so the only
>> reason they're running is because you're tracing. So if they are causing
>> the bug then that doesn't explain why you see it normally.
>>
>> Still, might be worth disabling just the hcall tracepoints just to be
>> 100% sure.
> 
> A couple of updates. I was working from tip/rt/head, which has been
> stale for some months now. I switched to tip/rt/2.6.33 and the
> preempt_count() change over cede went away. I now see the live hang that
> Will has reported.
> 
> Before I dive into the live hang, I want to understand what fixed the
> preempt_count() change. That might start pointing us in the right
> direction for the live hang.
> 
> I did an inverted git bisect between tip/rt/head and tip/rt/2.6.33 to
> try and locate the fix. I've narrowed it down to the 2.6.33.6 merge:
> 
> # git show 7e1af1172bbd4109d09ac515c5d376f633da7cff
> commit 7e1af1172bbd4109d09ac515c5d376f633da7cff
> Merge: d8e94db 9666790
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Jul 13 16:01:16 2010 +0200
> 
>     Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.33.y
> 
>     Conflicts:
>         Makefile
> 
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> 
> Visual inspection yields two patches of interest:
> 
> f8b67691828321f5c85bb853283aa101ae673130
> powerpc/pseries: Make query-cpu-stopped callable outside hotplug cpu
> 
> aef40e87d866355ffd279ab21021de733242d0d5
> powerpc/pseries: Only call start-cpu when a CPU is stopped
> 
> I'm going to try reverting these today and see if they addressed the
> issue indirectly.

Removing:

aef40e87d866355ffd279ab21021de733242d0d5
powerpc/pseries: Only call start-cpu when a CPU is stopped

--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -82,6 +82,12 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 
        pcpu = get_hard_smp_processor_id(lcpu);
 
+       /* Check to see if the CPU out of FW already for kexec */

This comment is really confusing to me. I _think_ it is saying that this test
determines if the CPU is done executing firmware code and has begun executing
OS code.... Is that right?

+       if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
+               cpu_set(lcpu, of_spin_map);
+               return 1;
+       }
+
        /* Fixup atomic count: it exited inside IRQ handler. */
        task_thread_info(paca[lcpu].__current)->preempt_count   = 0;

from tip/rt/2.6.33 causes the preempt_count() to change across the cede
call.  This patch appears to prevents the proxy preempt_count assignment
from happening. This non-local-cpu assignment to 0 would cause an
underrun of preempt_count() if the local-cpu had disabled preemption
prior to the assignment and then later tried to enable it. This appears
to be the case with the stack of __trace_hcall* calls preceeding the
return from extended_cede_processor() in the latency format trace-cmd
report:

  <idle>-0       1d....   201.252737: function:             .cpu_die
  <idle>-0       1d....   201.252738: function:                .pseries_mach_cpu_die
  <idle>-0       1d....   201.252740: function:                   .idle_task_exit
  <idle>-0       1d....   201.252741: function:                      .switch_slb
  <idle>-0       1d....   201.252742: function:                   .xics_teardown_cpu
  <idle>-0       1d....   201.252743: function:                      .xics_set_cpu_priority
  <idle>-0       1d....   201.252744: function:             .__trace_hcall_entry
  <idle>-0       1d..1.   201.252745: function:                .probe_hcall_entry
  <idle>-0       1d..1.   201.252746: function:             .__trace_hcall_exit
  <idle>-0       1d..2.   201.252747: function:                .probe_hcall_exit
  <idle>-0       1d....   201.252748: function:             .__trace_hcall_entry
  <idle>-0       1d..1.   201.252748: function:                .probe_hcall_entry
  <idle>-0       1d..1.   201.252750: function:             .__trace_hcall_exit
  <idle>-0       1d..2.   201.252751: function:                .probe_hcall_exit
  <idle>-0       1d....   201.252752: function:             .__trace_hcall_entry
  <idle>-0       1d..1.   201.252753: function:                .probe_hcall_entry
  offon.sh-3684  6.....   201.466488: bprint:               .smp_pSeries_kick_cpu : resetting pcnt to 0 for cpu 1

preempt_count() is reset from 1 to 0 by smp_startup_cpu() without the
QCSS_NOT_STOPPED check from the patch above.

  <idle>-0       1d....   201.466503: function:             .__trace_hcall_exit
  <idle>-0       1d..1.   201.466505: function:                .probe_hcall_exit
  <idle>-0       1d.Hff.   201.466507: bprint:               .pseries_mach_cpu_die : after cede: ffffffff

With the preempt_count() being one less than it should be, the final
preempt_enable() in the trace_hcall path drops preempt_count to
0xffffffff, which of course is an illegal value and leads to a crash.

I don't know if the patch above is the "right fix" for this or not as
don't yet understand why this occurs only with PREEMPT_RT and not in
mainline. Once we sort that out, we may need a more specific fix.

Many thanks to Steven Rostedt for pouring over the trace and the trace
code with me.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
