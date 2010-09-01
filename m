Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id BCEB2B716C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 06:11:31 +1000 (EST)
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
From: Steven Rostedt <rostedt@goodmis.org>
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <4C7E9FC1.60004@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com>  <4C7E9FC1.60004@us.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 01 Sep 2010 15:59:21 -0400
Message-ID: <1283371161.2356.53.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>, linuxppc-dev@ozlabs.org,
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

On Wed, 2010-09-01 at 11:47 -0700, Darren Hart wrote:

> from tip/rt/2.6.33 causes the preempt_count() to change across the cede
> call.  This patch appears to prevents the proxy preempt_count assignment
> from happening. This non-local-cpu assignment to 0 would cause an
> underrun of preempt_count() if the local-cpu had disabled preemption
> prior to the assignment and then later tried to enable it. This appears
> to be the case with the stack of __trace_hcall* calls preceeding the
> return from extended_cede_processor() in the latency format trace-cmd
> report:
> 
>   <idle>-0       1d....   201.252737: function:             .cpu_die

Note, the above 1d.... is a series of values. The first being the CPU,
the next if interrupts are disabled, the next if the NEED_RESCHED flag
is set, the next is softirqs enabled or disabled, next the
preempt_count, and finally the lockdepth count.

Here we only care about the preempt_count, which is zero when '.' and a
number if it is something else. It is the second to last field in that
list.


>   <idle>-0       1d....   201.252738: function:                .pseries_mach_cpu_die
>   <idle>-0       1d....   201.252740: function:                   .idle_task_exit
>   <idle>-0       1d....   201.252741: function:                      .switch_slb
>   <idle>-0       1d....   201.252742: function:                   .xics_teardown_cpu
>   <idle>-0       1d....   201.252743: function:                      .xics_set_cpu_priority
>   <idle>-0       1d....   201.252744: function:             .__trace_hcall_entry
>   <idle>-0       1d..1.   201.252745: function:                .probe_hcall_entry

                       ^
                preempt_count set to 1

>   <idle>-0       1d..1.   201.252746: function:             .__trace_hcall_exit
>   <idle>-0       1d..2.   201.252747: function:                .probe_hcall_exit
>   <idle>-0       1d....   201.252748: function:             .__trace_hcall_entry
>   <idle>-0       1d..1.   201.252748: function:                .probe_hcall_entry
>   <idle>-0       1d..1.   201.252750: function:             .__trace_hcall_exit
>   <idle>-0       1d..2.   201.252751: function:                .probe_hcall_exit
>   <idle>-0       1d....   201.252752: function:             .__trace_hcall_entry
>   <idle>-0       1d..1.   201.252753: function:                .probe_hcall_entry
                   ^   ^
                  CPU  preempt_count

Entering the function probe_hcall_entry() the preempt_count is 1 (see
below). But probe_hcall_entry does:

	h = &get_cpu_var(hcall_stats)[opcode / 4];

Without doing the put (which it does in probe_hcall_exit())

So exiting the probe_hcall_entry() the prempt_count is 2.
The trace_hcall_entry() will do a preempt_enable() making it leave as 1.


>   offon.sh-3684  6.....   201.466488: bprint:               .smp_pSeries_kick_cpu : resetting pcnt to 0 for cpu 1

This is CPU 6, changing the preempt count from 1 to 0.

> 
> preempt_count() is reset from 1 to 0 by smp_startup_cpu() without the
> QCSS_NOT_STOPPED check from the patch above.
> 
>   <idle>-0       1d....   201.466503: function:             .__trace_hcall_exit

Note: __trace_hcall_exit() and __trace_hcall_entry() basically do:

 preempt_disable();
 call probe();
 preempt_enable();


>   <idle>-0       1d..1.   201.466505: function:                .probe_hcall_exit

The preempt_count of 1 entering the probe_hcall_exit() is because of the
preempt_disable() shown above. It should have been entered as a 2.

But then it does:


	put_cpu_var(hcall_stats);

making preempt_count 0.

But the preempt_enable() in the trace_hcall_exit() causes this to be -1.


>   <idle>-0       1d.Hff.   201.466507: bprint:               .pseries_mach_cpu_die : after cede: ffffffff
> 
> With the preempt_count() being one less than it should be, the final
> preempt_enable() in the trace_hcall path drops preempt_count to
> 0xffffffff, which of course is an illegal value and leads to a crash.

I'm confused to how this works in mainline?

-- Steve

> 
> I don't know if the patch above is the "right fix" for this or not as
> don't yet understand why this occurs only with PREEMPT_RT and not in
> mainline. Once we sort that out, we may need a more specific fix.
