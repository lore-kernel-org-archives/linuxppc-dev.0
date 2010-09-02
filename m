Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
In-reply-to: <4C7EBAA8.7030601@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com> <4C7E9FC1.60004@us.ibm.com>
	<1283371161.2356.53.camel@gandalf.stny.rr.com>
	<4C7EBAA8.7030601@us.ibm.com>
Date: Thu, 02 Sep 2010 11:02:02 +1000
Message-ID: <11579.1283389322@neuling.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
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



In message <4C7EBAA8.7030601@us.ibm.com> you wrote:
> On 09/01/2010 12:59 PM, Steven Rostedt wrote:
> > On Wed, 2010-09-01 at 11:47 -0700, Darren Hart wrote:
> > 
> >> from tip/rt/2.6.33 causes the preempt_count() to change across the cede
> >> call.  This patch appears to prevents the proxy preempt_count assignment
> >> from happening. This non-local-cpu assignment to 0 would cause an
> >> underrun of preempt_count() if the local-cpu had disabled preemption
> >> prior to the assignment and then later tried to enable it. This appears
> >> to be the case with the stack of __trace_hcall* calls preceeding the
> >> return from extended_cede_processor() in the latency format trace-cmd
> >> report:
> >>
> >>   <idle>-0       1d....   201.252737: function:             .cpu_die
> > 
> > Note, the above 1d.... is a series of values. The first being the CPU,
> > the next if interrupts are disabled, the next if the NEED_RESCHED flag
> > is set, the next is softirqs enabled or disabled, next the
> > preempt_count, and finally the lockdepth count.
> > 
> > Here we only care about the preempt_count, which is zero when '.' and a
> > number if it is something else. It is the second to last field in that
> > list.
> > 
> > 
> >>   <idle>-0       1d....   201.252738: function:                .pseries_ma
ch_cpu_die
> >>   <idle>-0       1d....   201.252740: function:                   .idle_ta
sk_exit
> >>   <idle>-0       1d....   201.252741: function:                      .swit
ch_slb
> >>   <idle>-0       1d....   201.252742: function:                   .xics_te
ardown_cpu
> >>   <idle>-0       1d....   201.252743: function:                      .xics
_set_cpu_priority
> >>   <idle>-0       1d....   201.252744: function:             .__trace_hcall
_entry
> >>   <idle>-0       1d..1.   201.252745: function:                .probe_hcal
l_entry
> > 
> >                        ^
> >                 preempt_count set to 1
> > 
> >>   <idle>-0       1d..1.   201.252746: function:             .__trace_hcall
_exit
> >>   <idle>-0       1d..2.   201.252747: function:                .probe_hcal
l_exit
> >>   <idle>-0       1d....   201.252748: function:             .__trace_hcall
_entry
> >>   <idle>-0       1d..1.   201.252748: function:                .probe_hcal
l_entry
> >>   <idle>-0       1d..1.   201.252750: function:             .__trace_hcall
_exit
> >>   <idle>-0       1d..2.   201.252751: function:                .probe_hcal
l_exit
> >>   <idle>-0       1d....   201.252752: function:             .__trace_hcall
_entry
> >>   <idle>-0       1d..1.   201.252753: function:                .probe_hcal
l_entry
> >                    ^   ^
> >                   CPU  preempt_count
> > 
> > Entering the function probe_hcall_entry() the preempt_count is 1 (see
> > below). But probe_hcall_entry does:
> > 
> > 	h = &get_cpu_var(hcall_stats)[opcode / 4];
> > 
> > Without doing the put (which it does in probe_hcall_exit())
> > 
> > So exiting the probe_hcall_entry() the prempt_count is 2.
> > The trace_hcall_entry() will do a preempt_enable() making it leave as 1.
> > 
> > 
> >>   offon.sh-3684  6.....   201.466488: bprint:               .smp_pSeries_k
ick_cpu : resetting pcnt to 0 for cpu 1
> > 
> > This is CPU 6, changing the preempt count from 1 to 0.
> > 
> >>
> >> preempt_count() is reset from 1 to 0 by smp_startup_cpu() without the
> >> QCSS_NOT_STOPPED check from the patch above.
> >>
> >>   <idle>-0       1d....   201.466503: function:             .__trace_hcall
_exit
> > 
> > Note: __trace_hcall_exit() and __trace_hcall_entry() basically do:
> > 
> >  preempt_disable();
> >  call probe();
> >  preempt_enable();
> > 
> > 
> >>   <idle>-0       1d..1.   201.466505: function:                .probe_hcal
l_exit
> > 
> > The preempt_count of 1 entering the probe_hcall_exit() is because of the
> > preempt_disable() shown above. It should have been entered as a 2.
> > 
> > But then it does:
> > 
> > 
> > 	put_cpu_var(hcall_stats);
> > 
> > making preempt_count 0.
> > 
> > But the preempt_enable() in the trace_hcall_exit() causes this to be -1.
> > 
> > 
> >>   <idle>-0       1d.Hff.   201.466507: bprint:               .pseries_mach
_cpu_die : after cede: ffffffff
> >>
> >> With the preempt_count() being one less than it should be, the final
> >> preempt_enable() in the trace_hcall path drops preempt_count to
> >> 0xffffffff, which of course is an illegal value and leads to a crash.
> > 
> > I'm confused to how this works in mainline?
> 
> Turns out it didn't. 2.6.33.5 with CONFIG_PREEMPT=y sees this exact same
> behavior. The following, part of the 2.6.33.6 stable release, prevents
> this from happening:
> 
> aef40e87d866355ffd279ab21021de733242d0d5
> powerpc/pseries: Only call start-cpu when a CPU is stopped
> 
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -82,6 +82,12 @@ static inline int __devinit smp_startup_cpu(unsigned
> int lcpu)
> 
>         pcpu = get_hard_smp_processor_id(lcpu);
> 
> +       /* Check to see if the CPU out of FW already for kexec */
> +       if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
> +               cpu_set(lcpu, of_spin_map);
> +               return 1;
> +       }
> +
>         /* Fixup atomic count: it exited inside IRQ handler. */
>         task_thread_info(paca[lcpu].__current)->preempt_count   = 0;
> 
> The question is now, Is this the right fix? If so, perhaps we can update
> the comment to be a bit more clear and not refer solely to kexec.
> 
> Michael Neuling, can you offer any thoughts here? We hit this EVERY
> TIME, which makes me wonder if the offline/online path could do this
> without calling smp_startup_cpu at all.

We need to call smp_startup_cpu on boot when we the cpus are still in
FW.  smp_startup_cpu does this for us on boot.

I'm wondering if we just need to move the test down a bit to make sure
the preempt_count is set.  I've not been following this thread, but
maybe this might work?

Untested patch below...

Mikey

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 0317cce..3afaba4 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -104,18 +104,18 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 
 	pcpu = get_hard_smp_processor_id(lcpu);
 
-	/* Check to see if the CPU out of FW already for kexec */
-	if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
-		cpumask_set_cpu(lcpu, of_spin_mask);
-		return 1;
-	}
-
 	/* Fixup atomic count: it exited inside IRQ handler. */
 	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
 
 	if (get_cpu_current_state(lcpu) == CPU_STATE_INACTIVE)
 		goto out;
 
+	/* Check to see if the CPU out of FW already for kexec */
+	if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
+		cpumask_set_cpu(lcpu, of_spin_mask);
+		return 1;
+	}
+
 	/* 
 	 * If the RTAS start-cpu token does not exist then presume the
 	 * cpu is already spinning.
