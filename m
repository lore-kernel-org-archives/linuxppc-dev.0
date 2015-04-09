Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0148.outbound.protection.outlook.com [157.56.110.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 174C51A0332
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 17:44:50 +1000 (AEST)
Message-ID: <55262DD3.2050707@freescale.com>
Date: Thu, 9 Apr 2015 10:44:19 +0300
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>			
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>			
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>			
 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>		
 <1424999159.4698.78.camel@freescale.com> <55158E6D.40304@freescale.com>	
 <1428016310.22867.289.camel@freescale.com> <551E4A41.1080705@freescale.com>
 <1428096375.22867.369.camel@freescale.com>
In-Reply-To: <1428096375.22867.369.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.04.2015 00:26, Scott Wood wrote:
> On Fri, 2015-04-03 at 11:07 +0300, Purcareata Bogdan wrote:
>> On 03.04.2015 02:11, Scott Wood wrote:
>>> On Fri, 2015-03-27 at 19:07 +0200, Purcareata Bogdan wrote:
>>>> On 27.02.2015 03:05, Scott Wood wrote:
>>>>> On Thu, 2015-02-26 at 14:31 +0100, Sebastian Andrzej Siewior wrote:
>>>>>> On 02/26/2015 02:02 PM, Paolo Bonzini wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 24/02/2015 00:27, Scott Wood wrote:
>>>>>>>> This isn't a host PIC driver.  It's guest PIC emulation, some of which
>>>>>>>> is indeed not suitable for a rawlock (in particular, openpic_update_irq
>>>>>>>> which loops on the number of vcpus, with a loop body that calls
>>>>>>>> IRQ_check() which loops over all pending IRQs).
>>>>>>>
>>>>>>> The question is what behavior is wanted of code that isn't quite
>>>>>>> RT-ready.  What is preferred, bugs or bad latency?
>>>>>>>
>>>>>>> If the answer is bad latency (which can be avoided simply by not running
>>>>>>> KVM on a RT kernel in production), patch 1 can be applied.  If the
>>>>>> can be applied *but* makes no difference if applied or not.
>>>>>>
>>>>>>> answer is bugs, patch 1 is not upstream material.
>>>>>>>
>>>>>>> I myself prefer to have bad latency; if something takes a spinlock in
>>>>>>> atomic context, that spinlock should be raw.  If it hurts (latency),
>>>>>>> don't do it (use the affected code).
>>>>>>
>>>>>> The problem, that is fixed by this s/spin_lock/raw_spin_lock/, exists
>>>>>> only in -RT. There is no change upstream. In general we fix such things
>>>>>> in -RT first and forward the patches upstream if possible. This convert
>>>>>> thingy would be possible.
>>>>>> Bug fixing comes before latency no matter if RT or not. Converting
>>>>>> every lock into a rawlock is not always the answer.
>>>>>> Last thing I read from Scott is that he is not entirely sure if this is
>>>>>> the right approach or not and patch #1 was not acked-by him either.
>>>>>>
>>>>>> So for now I wait for Scott's feedback and maybe a backtrace :)
>>>>>
>>>>> Obviously leaving it in a buggy state is not what we want -- but I lean
>>>>> towards a short term "fix" of putting "depends on !PREEMPT_RT" on the
>>>>> in-kernel MPIC emulation (which is itself just an optimization -- you
>>>>> can still use KVM without it).  This way people don't enable it with RT
>>>>> without being aware of the issue, and there's more of an incentive to
>>>>> fix it properly.
>>>>>
>>>>> I'll let Bogdan supply the backtrace.
>>>>
>>>> So about the backtrace. Wasn't really sure how to "catch" this, so what
>>>> I did was to start a 24 VCPUs guest on a 24 CPU board, and in the guest
>>>> run 24 netperf flows with an external back to back board of the same
>>>> kind. I assumed this would provide the sufficient VCPUs and external
>>>> interrupt to expose an alleged culprit.
>>>>
>>>> With regards to measuring the latency, I thought of using ftrace,
>>>> specifically the preemptirqsoff latency histogram. Unfortunately, I
>>>> wasn't able to capture any major differences between running a guest
>>>> with in-kernel MPIC emulation (with the openpic raw_spinlock_conversion
>>>> applied) vs. no in-kernel MPIC emulation. Function profiling
>>>> (trace_stat) shows that in the second case there's a far greater time
>>>> spent in kvm_handle_exit (100x), but overall, the maximum latencies for
>>>> preemptirqsoff don't look that much different.
>>>>
>>>> Here are the max numbers (preemptirqsoff) for the 24 CPUs, on the host
>>>> RT Linux, sorted in descending order, expressed in microseconds:
>>>>
>>>> In-kernel MPIC		QEMU MPIC
>>>> 3975			5105
>>>
>>> What are you measuring?  Latency in the host, or in the guest?
>>
>> This is in the host kernel.
>
> Those are terrible numbers in both cases.  Can you use those tracing
> tools to find out what the code path is for QEMU MPIC?

After more careful inspection, I noticed that those big-big numbers
(couple of milliseconds) are isolated cases, and in fact 99.99% of those
latencies top to somewhere around 800us. I also have a feeling that the
isolated huge latencies might have something to do with
enabling/disabling tracing, since those numbers don't come up at all in
the actual trace output, only in the latency histogram. From what I
know, there are two separate mechanisms - the function tracer and the
latency histogram.

Now, about that max 800us - there are 2 things that are enabled by
default, and can cause bad latency:
1. scheduler load balancing - latency can top to up to 800us (as seen in
the trace output).
2. RT throttling - which calls sched_rt_period_timer, which cycles
through the runqueues of all CPUs - latency can top to 600us.

I'm mentioning these since the trace output for the max preemptirqsoff
period was always "stolen" by these activities, basically hiding
anything related to the kvm in-kernel openpic.

I disabled both of them, and now the max preemptirqsoff trace shows a
transition between a vhost thread and the qemu process, involving a
timer and external interrupt (do_irq), which you can see at the end of
this e-mail. Not much particularly related to the kvm openpic (but
perhaps I'm not able to understand it entirely). The trace for QEMU
MPIC looks pretty much the same.

So at this point I was getting kinda frustrated so I decided to measure
the time spend in kvm_mpic_write and kvm_mpic_read. I assumed these were
the main entry points in the in-kernel MPIC and were basically executed
while holding the spinlock. The scenario was the same - 24 VCPUs guest,
with 24 virtio+vhost interfaces, only this time I ran 24 ping flood
threads to another board instead of netperf. I assumed this would impose
a heavier stress.

The latencies look pretty ok, around 1-2 us on average, with the max
shown below:

.kvm_mpic_read	14.560
.kvm_mpic_write	12.608

Those are also microseconds. This was run for about 15 mins.

 From what it looks like, the in-kernel MPIC isn't all that bad, even for
a guest with a large number of VCPUs and a lot of external interrupts.
Bigger latencies can be caused by scheduling mechanisms, but I guess
this isn't something we can avoid entirely, only optimize.

Looking forward to your feedback and comments.

Thanks,
Bogdan P.

# tracer: preemptirqsoff
#
# preemptirqsoff latency trace v1.1.5 on 3.12.19-rt30-156196-gbc48ad3f-dirty
# --------------------------------------------------------------------
# latency: 364 us, #322/322, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:24)
#    -----------------
#    | task: qemu-system-ppc-4055 (uid:0 nice:0 policy:2 rt_prio:95)
#    -----------------
#  => started at: .__schedule
#  => ended at:   .__schedule
#
#
#                   _--------=> CPU#
#                  / _-------=> irqs-off
#                 | / _------=> need-resched
#                 || / _-----=> need-resched_lazy
#                 ||| / _----=> hardirq/softirq
#                 |||| / _---=> preempt-depth
#                 ||||| / _--=> preempt-lazy-depth
#                 |||||| / _-=> migrate-disable
#                 ||||||| /     delay
#  cmd     pid    |||||||| time  |   caller
#     \   /      ||||||||  \   |   /
    <...>-4170    0....1..    0us+: .__schedule
    <...>-4170    0d...3..    3us : .deactivate_task <-.__schedule
    <...>-4170    0d...3..    4us : .dequeue_task <-.__schedule
    <...>-4170    0d...3..    5us : .update_rq_clock.part.64 <-.dequeue_task
    <...>-4170    0d...3..    6us : .dequeue_task_fair <-.dequeue_task
    <...>-4170    0d...3..    6us : .update_curr <-.dequeue_task_fair
    <...>-4170    0d...3..    7us : .update_min_vruntime <-.update_curr
    <...>-4170    0d...3..    8us : .cpuacct_charge <-.update_curr
    <...>-4170    0d...3..    9us : .__rcu_read_lock <-.cpuacct_charge
    <...>-4170    0d...3..   10us : .__rcu_read_unlock <-.cpuacct_charge
    <...>-4170    0d...3..   11us : .__compute_runnable_contrib <-.dequeue_task_fair
    <...>-4170    0d...3..   12us : .__update_entity_load_avg_contrib <-.dequeue_task_fair
    <...>-4170    0d...3..   13us : .update_cfs_rq_blocked_load <-.dequeue_task_fair
    <...>-4170    0d...3..   14us : .clear_buddies <-.dequeue_task_fair
    <...>-4170    0d...3..   16us : .account_entity_dequeue <-.dequeue_task_fair
    <...>-4170    0d...3..   17us : .update_min_vruntime <-.dequeue_task_fair
    <...>-4170    0d...3..   18us : .update_cfs_shares <-.dequeue_task_fair
    <...>-4170    0d...3..   19us : .__compute_runnable_contrib <-.dequeue_task_fair
    <...>-4170    0d...3..   20us : .hrtick_update <-.dequeue_task
    <...>-4170    0d...3..   21us : .put_prev_task_fair <-.__schedule
    <...>-4170    0d...3..   22us : .pick_next_task_fair <-.__schedule
    <...>-4170    0d...3..   23us : .clear_buddies <-.pick_next_task_fair
    <...>-4170    0d...3..   24us+: .__dequeue_entity <-.pick_next_task_fair
    <...>-4170    0d...3..   26us : .switch_mmu_context <-.__schedule
    <...>-4170    0d...3..   27us : ._raw_spin_lock <-.switch_mmu_context
    <...>-4170    0d...3..   28us : .__raw_spin_lock <-.switch_mmu_context
    <...>-4170    0d...3..   29us : .add_preempt_count <-.__raw_spin_lock
    <...>-4170    0d...4..   30us : .sub_preempt_count <-.switch_mmu_context
    <...>-4170    0d...3..   31us : .__switch_to <-.__schedule
    <...>-4170    0d...3..   32us+: .switch_booke_debug_regs <-.__switch_to
    <...>-4171    0d...3..   33us : .finish_task_switch <-.__schedule
    <...>-4171    0d...3..   34us : .vtime_common_task_switch <-.finish_task_switch
    <...>-4171    0d...3..   36us : .account_system_time <-.vtime_account_system
    <...>-4171    0d...3..   37us : .in_serving_softirq <-.account_system_time
    <...>-4171    0d...3..   38us : .cpuacct_account_field <-.account_system_time
    <...>-4171    0d...3..   39us : .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0d...3..   40us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0d...3..   41us : .account_user_time <-.vtime_account_user
    <...>-4171    0d...3..   42us : .cpuacct_account_field <-.account_user_time
    <...>-4171    0d...3..   43us : .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0d...3..   44us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0d...3..   45us+: ._raw_spin_unlock_irq <-.finish_task_switch
    <...>-4171    0d...3..   46us+: .do_IRQ <-exc_0x500_common
    <...>-4171    0d...3..   48us : .__do_irq <-.call_do_irq
    <...>-4171    0d...3..   49us : .irq_enter <-.__do_irq
    <...>-4171    0d...3..   50us : .rcu_irq_enter <-.irq_enter
    <...>-4171    0d...3..   52us : .vtime_common_account_irq_enter <-.irq_enter
    <...>-4171    0d...3..   53us : .account_system_time <-.vtime_account_system
    <...>-4171    0d...3..   54us : .in_serving_softirq <-.account_system_time
    <...>-4171    0d...3..   55us : .cpuacct_account_field <-.account_system_time
    <...>-4171    0d...3..   56us : .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0d...3..   57us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0d...3..   58us : .add_preempt_count <-.irq_enter
    <...>-4171    0d..h3..   59us : .mpic_get_coreint_irq <-.__do_irq
    <...>-4171    0d..h3..   60us : .irq_to_desc <-.__do_irq
    <...>-4171    0d..h3..   61us : .handle_fasteoi_irq <-.__do_irq
    <...>-4171    0d..h3..   62us : ._raw_spin_lock <-.handle_fasteoi_irq
    <...>-4171    0d..h3..   63us : .__raw_spin_lock <-.handle_fasteoi_irq
    <...>-4171    0d..h3..   64us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0d..h4..   65us+: .mpic_mask_irq <-.handle_fasteoi_irq
    <...>-4171    0d..h4..   66us : .handle_irq_event <-.handle_fasteoi_irq
    <...>-4171    0d..h4..   67us : .sub_preempt_count <-.handle_irq_event
    <...>-4171    0d..h3..   68us : .handle_irq_event_percpu <-.handle_irq_event
    <...>-4171    0d..h3..   70us : .irq_default_primary_handler <-.handle_irq_event_percpu
    <...>-4171    0d..h3..   71us : .wake_up_process <-.handle_irq_event_percpu
    <...>-4171    0d..h3..   72us : .try_to_wake_up <-.handle_irq_event_percpu
    <...>-4171    0d..h3..   73us : ._raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0d..h3..   74us : .__raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0d..h3..   75us : .add_preempt_count <-.__raw_spin_lock_irqsave
    <...>-4171    0d..h4..   76us : .select_task_rq_rt <-.try_to_wake_up
    <...>-4171    0d..h4..   77us : ._raw_spin_lock <-.try_to_wake_up
    <...>-4171    0d..h4..   78us : .__raw_spin_lock <-.try_to_wake_up
    <...>-4171    0d..h4..   79us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0d..h5..   80us : .ttwu_do_activate.constprop.71 <-.try_to_wake_up
    <...>-4171    0d..h5..   81us : .activate_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0d..h5..   82us : .enqueue_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0d..h5..   83us : .update_rq_clock.part.64 <-.enqueue_task
    <...>-4171    0d..h5..   84us : .enqueue_task_rt <-.enqueue_task
    <...>-4171    0d..h5..   85us : .dequeue_rt_stack <-.enqueue_task_rt
    <...>-4171    0d..h5..   86us+: .cpupri_set <-.enqueue_task_rt
    <...>-4171    0d..h5..   88us : .update_rt_migration <-.enqueue_task_rt
    <...>-4171    0d..h5..   89us : .ttwu_do_wakeup <-.try_to_wake_up
    <...>-4171    0d..h5..   90us : .check_preempt_curr <-.ttwu_do_wakeup
    <...>-4171    0d..h5..   91us : .resched_task <-.check_preempt_curr
    <...>-4171    0d..h5..   92us : .task_woken_rt <-.ttwu_do_wakeup
    <...>-4171    0d..h5..   93us : .sub_preempt_count <-.try_to_wake_up
    <...>-4171    0d..h4..   94us : ._raw_spin_unlock_irqrestore <-.try_to_wake_up
    <...>-4171    0d..h4..   95us : .sub_preempt_count <-._raw_spin_unlock_irqrestore
    <...>-4171    0d..h3..   97us : .note_interrupt <-.handle_irq_event_percpu
    <...>-4171    0d..h3..   98us : ._raw_spin_lock <-.handle_irq_event
    <...>-4171    0d..h3..   99us : .__raw_spin_lock <-.handle_irq_event
    <...>-4171    0d..h3..  100us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0d..h4..  101us : .cond_unmask_irq <-.handle_fasteoi_irq
    <...>-4171    0d..h4..  102us+: .mpic_end_irq <-.handle_fasteoi_irq
    <...>-4171    0d..h4..  103us : .sub_preempt_count <-.handle_fasteoi_irq
    <...>-4171    0d..h3..  104us : .irq_exit <-.__do_irq
    <...>-4171    0d..h3..  105us : .account_system_time <-.vtime_account_system
    <...>-4171    0d..h3..  106us : .cpuacct_account_field <-.account_system_time
    <...>-4171    0d..h3..  107us+: .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0d..h3..  109us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0d..h3..  110us : .sub_preempt_count <-.irq_exit
    <...>-4171    0d...3..  111us+: .rcu_irq_exit <-.irq_exit
    <...>-4171    0dN..3..  113us : .irq_enter <-.timer_interrupt
    <...>-4171    0dN..3..  114us : .rcu_irq_enter <-.irq_enter
    <...>-4171    0dN..3..  115us : .vtime_common_account_irq_enter <-.irq_enter
    <...>-4171    0dN..3..  116us : .account_system_time <-.vtime_account_system
    <...>-4171    0dN..3..  118us : .in_serving_softirq <-.account_system_time
    <...>-4171    0dN..3..  119us : .cpuacct_account_field <-.account_system_time
    <...>-4171    0dN..3..  120us : .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0dN..3..  121us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0dN..3..  122us : .add_preempt_count <-.irq_enter
    <...>-4171    0dN.h3..  123us : .hrtimer_interrupt <-.timer_interrupt
    <...>-4171    0dN.h3..  124us : ._raw_spin_lock <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  126us : .__raw_spin_lock <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  127us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h4..  128us : .ktime_get_update_offsets <-.hrtimer_interrupt
    <...>-4171    0dN.h4..  129us : .__run_hrtimer <-.hrtimer_interrupt
    <...>-4171    0dN.h4..  130us : .__remove_hrtimer <-.__run_hrtimer
    <...>-4171    0dN.h4..  131us : .sub_preempt_count <-.__run_hrtimer
    <...>-4171    0dN.h3..  133us : .tick_sched_timer <-.__run_hrtimer
    <...>-4171    0dN.h3..  134us : .ktime_get <-.tick_sched_timer
    <...>-4171    0dN.h3..  135us : ._raw_spin_lock <-.tick_sched_timer
    <...>-4171    0dN.h3..  136us : .__raw_spin_lock <-.tick_sched_timer
    <...>-4171    0dN.h3..  137us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h4..  138us : .add_preempt_count <-.tick_sched_timer
    <...>-4171    0dN.h5..  139us : .do_timer <-.tick_sched_timer
    <...>-4171    0dN.h5..  140us : ._raw_spin_lock_irqsave <-.do_timer
    <...>-4171    0dN.h5..  141us : .__raw_spin_lock_irqsave <-.do_timer
    <...>-4171    0dN.h5..  142us : .add_preempt_count <-.__raw_spin_lock_irqsave
    <...>-4171    0dN.h6..  144us : .ntp_tick_length <-.do_timer
    <...>-4171    0dN.h6..  145us : .ntp_tick_length <-.do_timer
    <...>-4171    0dN.h6..  146us : .ntp_tick_length <-.do_timer
    <...>-4171    0dN.h6..  147us : .add_preempt_count <-.do_timer
    <...>-4171    0dN.h7..  148us+: .timekeeping_update.constprop.7 <-.do_timer
    <...>-4171    0dN.h7..  150us : .raw_notifier_call_chain <-.timekeeping_update.constprop.7
    <...>-4171    0dN.h7..  151us : .notifier_call_chain <-.timekeeping_update.constprop.7
    <...>-4171    0dN.h7..  152us : .sub_preempt_count <-.do_timer
    <...>-4171    0dN.h6..  153us : ._raw_spin_unlock_irqrestore <-.do_timer
    <...>-4171    0dN.h6..  154us : .sub_preempt_count <-._raw_spin_unlock_irqrestore
    <...>-4171    0dN.h5..  155us : .calc_global_load <-.do_timer
    <...>-4171    0dN.h5..  157us : .sub_preempt_count <-.tick_sched_timer
    <...>-4171    0dN.h4..  158us : .sub_preempt_count <-.tick_sched_timer
    <...>-4171    0dN.h3..  159us : .update_process_times <-.tick_sched_timer
    <...>-4171    0dN.h3..  160us : .account_user_time <-.vtime_account_user
    <...>-4171    0dN.h3..  161us : .cpuacct_account_field <-.account_user_time
    <...>-4171    0dN.h3..  162us : .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0dN.h3..  163us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0dN.h3..  164us : .scheduler_tick <-.update_process_times
    <...>-4171    0dN.h3..  166us : ._raw_spin_lock <-.scheduler_tick
    <...>-4171    0dN.h3..  167us : .__raw_spin_lock <-.scheduler_tick
    <...>-4171    0dN.h3..  168us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h4..  169us : .task_tick_fair <-.scheduler_tick
    <...>-4171    0dN.h4..  170us : .update_curr <-.task_tick_fair
    <...>-4171    0dN.h4..  171us : .update_min_vruntime <-.update_curr
    <...>-4171    0dN.h4..  172us : .cpuacct_charge <-.update_curr
    <...>-4171    0dN.h4..  173us : .__rcu_read_lock <-.cpuacct_charge
    <...>-4171    0dN.h4..  174us : .__rcu_read_unlock <-.cpuacct_charge
    <...>-4171    0dN.h4..  176us : .update_cfs_rq_blocked_load <-.task_tick_fair
    <...>-4171    0dN.h4..  177us : .update_cfs_shares <-.task_tick_fair
    <...>-4171    0dN.h4..  178us : .update_cpu_load_active <-.scheduler_tick
    <...>-4171    0dN.h4..  179us : .sched_avg_update <-.update_cpu_load_active
    <...>-4171    0dN.h4..  180us : .sub_preempt_count <-.scheduler_tick
    <...>-4171    0dN.h3..  182us : .trigger_load_balance <-.scheduler_tick
    <...>-4171    0dN.h3..  183us : .run_local_timers <-.update_process_times
    <...>-4171    0dN.h3..  184us : .hrtimer_run_queues <-.run_local_timers
    <...>-4171    0dN.h3..  185us : .rt_spin_trylock <-.run_local_timers
    <...>-4171    0dN.h3..  186us : .rt_mutex_trylock <-.run_local_timers
    <...>-4171    0dN.h3..  187us : .raise_softirq <-.run_local_timers
    <...>-4171    0dN.h3..  188us : .raise_softirq_irqoff <-.raise_softirq
    <...>-4171    0dN.h3..  189us : .do_raise_softirq_irqoff <-.raise_softirq_irqoff
    <...>-4171    0dN.h3..  191us : .rt_spin_unlock_after_trylock_in_irq <-.run_local_timers
    <...>-4171    0dN.h3..  192us : .rcu_check_callbacks <-.update_process_times
    <...>-4171    0dN.h3..  193us : .rcu_bh_qs <-.rcu_check_callbacks
    <...>-4171    0dN.h3..  194us : .cpu_needs_another_gp <-.rcu_check_callbacks
    <...>-4171    0dN.h3..  195us : .invoke_rcu_core <-.rcu_check_callbacks
    <...>-4171    0dN.h3..  197us : .wake_up_process <-.invoke_rcu_core
    <...>-4171    0dN.h3..  198us : .try_to_wake_up <-.invoke_rcu_core
    <...>-4171    0dN.h3..  199us : ._raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0dN.h3..  200us : .__raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0dN.h3..  201us : .add_preempt_count <-.__raw_spin_lock_irqsave
    <...>-4171    0dN.h4..  202us : .task_waking_fair <-.try_to_wake_up
    <...>-4171    0dN.h4..  204us : .select_task_rq_fair <-.try_to_wake_up
    <...>-4171    0dN.h4..  205us : ._raw_spin_lock <-.try_to_wake_up
    <...>-4171    0dN.h4..  206us : .__raw_spin_lock <-.try_to_wake_up
    <...>-4171    0dN.h4..  207us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h5..  208us : .ttwu_do_activate.constprop.71 <-.try_to_wake_up
    <...>-4171    0dN.h5..  209us : .activate_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0dN.h5..  210us : .enqueue_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0dN.h5..  211us : .enqueue_task_fair <-.enqueue_task
    <...>-4171    0dN.h5..  213us : .update_curr <-.enqueue_task_fair
    <...>-4171    0dN.h5..  214us : .__compute_runnable_contrib <-.enqueue_task_fair
    <...>-4171    0dN.h5..  215us : .__update_entity_load_avg_contrib <-.enqueue_task_fair
    <...>-4171    0dN.h5..  216us : .update_cfs_rq_blocked_load <-.enqueue_task_fair
    <...>-4171    0dN.h5..  217us : .account_entity_enqueue <-.enqueue_task_fair
    <...>-4171    0dN.h5..  218us : .update_cfs_shares <-.enqueue_task_fair
    <...>-4171    0dN.h5..  220us : .__enqueue_entity <-.enqueue_task_fair
    <...>-4171    0dN.h5..  221us : .hrtick_update <-.enqueue_task
    <...>-4171    0dN.h5..  222us : .ttwu_do_wakeup <-.try_to_wake_up
    <...>-4171    0dN.h5..  223us : .check_preempt_curr <-.ttwu_do_wakeup
    <...>-4171    0dN.h5..  224us : .check_preempt_wakeup <-.check_preempt_curr
    <...>-4171    0dN.h5..  225us : .sub_preempt_count <-.try_to_wake_up
    <...>-4171    0dN.h4..  226us : ._raw_spin_unlock_irqrestore <-.try_to_wake_up
    <...>-4171    0dN.h4..  227us : .sub_preempt_count <-._raw_spin_unlock_irqrestore
    <...>-4171    0dN.h3..  229us : .run_posix_cpu_timers <-.update_process_times
    <...>-4171    0dN.h3..  230us : .hrtimer_forward <-.tick_sched_timer
    <...>-4171    0dN.h3..  231us : .ktime_add_safe <-.hrtimer_forward
    <...>-4171    0dN.h3..  232us : .ktime_add_safe <-.hrtimer_forward
    <...>-4171    0dN.h3..  233us : ._raw_spin_lock <-.__run_hrtimer
    <...>-4171    0dN.h3..  234us : .__raw_spin_lock <-.__run_hrtimer
    <...>-4171    0dN.h3..  235us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h4..  237us : .enqueue_hrtimer <-.__run_hrtimer
    <...>-4171    0dN.h4..  238us+: .sub_preempt_count <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  240us : .tick_program_event <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  241us : .clockevents_program_event <-.tick_program_event
    <...>-4171    0dN.h3..  242us : .ktime_get <-.clockevents_program_event
    <...>-4171    0dN.h3..  243us : ._raw_spin_lock <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  244us : .__raw_spin_lock <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  245us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h4..  246us : .ktime_get_update_offsets <-.hrtimer_interrupt
    <...>-4171    0dN.h4..  248us : .__run_hrtimer <-.hrtimer_interrupt
    <...>-4171    0dN.h4..  249us : .__remove_hrtimer <-.__run_hrtimer
    <...>-4171    0dN.h4..  250us : .sub_preempt_count <-.__run_hrtimer
    <...>-4171    0dN.h3..  251us : .kvmppc_decrementer_wakeup <-.__run_hrtimer
    <...>-4171    0dN.h3..  252us : .kvmppc_decrementer_func <-.kvmppc_decrementer_wakeup
    <...>-4171    0dN.h3..  253us : .kvmppc_set_tsr_bits <-.kvmppc_decrementer_wakeup
    <...>-4171    0dN.h3..  254us : .kvm_vcpu_kick <-.kvmppc_set_tsr_bits
    <...>-4171    0dN.h3..  256us : .__swait_wake <-.kvm_vcpu_kick
    <...>-4171    0dN.h3..  257us : ._raw_spin_lock_irqsave <-.__swait_wake
    <...>-4171    0dN.h3..  258us : .__raw_spin_lock_irqsave <-.__swait_wake
    <...>-4171    0dN.h3..  259us : .add_preempt_count <-.__raw_spin_lock_irqsave
    <...>-4171    0dN.h4..  260us : .__swait_wake_locked <-.__swait_wake
    <...>-4171    0dN.h4..  261us : .wake_up_state <-.__swait_wake_locked
    <...>-4171    0dN.h4..  262us : .try_to_wake_up <-.__swait_wake_locked
    <...>-4171    0dN.h4..  263us : ._raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0dN.h4..  264us : .__raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0dN.h4..  265us : .add_preempt_count <-.__raw_spin_lock_irqsave
    <...>-4171    0dN.h5..  267us : .select_task_rq_rt <-.try_to_wake_up
    <...>-4171    0dN.h5..  268us : ._raw_spin_lock <-.try_to_wake_up
    <...>-4171    0dN.h5..  269us : .__raw_spin_lock <-.try_to_wake_up
    <...>-4171    0dN.h5..  270us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h6..  271us : .ttwu_do_activate.constprop.71 <-.try_to_wake_up
    <...>-4171    0dN.h6..  272us : .activate_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0dN.h6..  273us : .enqueue_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0dN.h6..  274us : .enqueue_task_rt <-.enqueue_task
    <...>-4171    0dN.h6..  276us : .dequeue_rt_stack <-.enqueue_task_rt
    <...>-4171    0dN.h6..  277us+: .cpupri_set <-.enqueue_task_rt
    <...>-4171    0dN.h6..  278us : .update_rt_migration <-.enqueue_task_rt
    <...>-4171    0dN.h6..  280us : .ttwu_do_wakeup <-.try_to_wake_up
    <...>-4171    0dN.h6..  281us : .check_preempt_curr <-.ttwu_do_wakeup
    <...>-4171    0dN.h6..  282us : .resched_task <-.check_preempt_curr
    <...>-4171    0dN.h6..  283us : .task_woken_rt <-.ttwu_do_wakeup
    <...>-4171    0dN.h6..  284us : .sub_preempt_count <-.try_to_wake_up
    <...>-4171    0dN.h5..  285us : ._raw_spin_unlock_irqrestore <-.try_to_wake_up
    <...>-4171    0dN.h5..  287us : .sub_preempt_count <-._raw_spin_unlock_irqrestore
    <...>-4171    0dN.h4..  288us : ._raw_spin_unlock_irqrestore <-.__swait_wake
    <...>-4171    0dN.h4..  289us : .sub_preempt_count <-._raw_spin_unlock_irqrestore
    <...>-4171    0dN.h3..  290us : .add_preempt_count <-.kvm_vcpu_kick
    <...>-4171    0dN.h4..  291us : .sub_preempt_count <-.kvm_vcpu_kick
    <...>-4171    0dN.h3..  292us : ._raw_spin_lock <-.__run_hrtimer
    <...>-4171    0dN.h3..  293us : .__raw_spin_lock <-.__run_hrtimer
    <...>-4171    0dN.h3..  294us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN.h4..  296us : .sub_preempt_count <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  297us : .tick_program_event <-.hrtimer_interrupt
    <...>-4171    0dN.h3..  298us : .clockevents_program_event <-.tick_program_event
    <...>-4171    0dN.h3..  299us : .ktime_get <-.clockevents_program_event
    <...>-4171    0dN.h3..  300us : .irq_exit <-.timer_interrupt
    <...>-4171    0dN.h3..  301us : .account_system_time <-.vtime_account_system
    <...>-4171    0dN.h3..  303us : .cpuacct_account_field <-.account_system_time
    <...>-4171    0dN.h3..  304us : .__rcu_read_lock <-.cpuacct_account_field
    <...>-4171    0dN.h3..  305us : .__rcu_read_unlock <-.cpuacct_account_field
    <...>-4171    0dN.h3..  306us : .sub_preempt_count <-.irq_exit
    <...>-4171    0dN..3..  307us : .wakeup_softirqd <-.irq_exit
    <...>-4171    0dN..3..  308us : .wake_up_process <-.wakeup_softirqd
    <...>-4171    0dN..3..  309us : .try_to_wake_up <-.wakeup_softirqd
    <...>-4171    0dN..3..  310us : ._raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0dN..3..  312us : .__raw_spin_lock_irqsave <-.try_to_wake_up
    <...>-4171    0dN..3..  313us : .add_preempt_count <-.__raw_spin_lock_irqsave
    <...>-4171    0dN..4..  314us : .select_task_rq_rt <-.try_to_wake_up
    <...>-4171    0dN..4..  315us : ._raw_spin_lock <-.try_to_wake_up
    <...>-4171    0dN..4..  316us : .__raw_spin_lock <-.try_to_wake_up
    <...>-4171    0dN..4..  317us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0dN..5..  318us : .ttwu_do_activate.constprop.71 <-.try_to_wake_up
    <...>-4171    0dN..5..  319us : .activate_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0dN..5..  320us : .enqueue_task <-.ttwu_do_activate.constprop.71
    <...>-4171    0dN..5..  321us : .enqueue_task_rt <-.enqueue_task
    <...>-4171    0dN..5..  322us : .dequeue_rt_stack <-.enqueue_task_rt
    <...>-4171    0dN..5..  323us : .update_rt_migration <-.enqueue_task_rt
    <...>-4171    0dN..5..  325us : .ttwu_do_wakeup <-.try_to_wake_up
    <...>-4171    0dN..5..  326us : .check_preempt_curr <-.ttwu_do_wakeup
    <...>-4171    0dN..5..  327us : .resched_task <-.check_preempt_curr
    <...>-4171    0dN..5..  328us : .task_woken_rt <-.ttwu_do_wakeup
    <...>-4171    0dN..5..  329us : .sub_preempt_count <-.try_to_wake_up
    <...>-4171    0dN..4..  330us : ._raw_spin_unlock_irqrestore <-.try_to_wake_up
    <...>-4171    0dN..4..  331us : .sub_preempt_count <-._raw_spin_unlock_irqrestore
    <...>-4171    0dN..3..  332us+: .rcu_irq_exit <-.irq_exit
    <...>-4171    0dN..3..  336us : .put_prev_task_fair <-.__schedule
    <...>-4171    0dN..3..  337us : .update_curr <-.put_prev_task_fair
    <...>-4171    0dN..3..  338us : .__enqueue_entity <-.put_prev_task_fair
    <...>-4171    0dN..3..  339us : .pick_next_task_stop <-.__schedule
    <...>-4171    0dN..3..  341us : .pick_next_task_rt <-.__schedule
    <...>-4171    0d...3..  342us : .switch_mmu_context <-.__schedule
    <...>-4171    0d...3..  343us : ._raw_spin_lock <-.switch_mmu_context
    <...>-4171    0d...3..  344us : .__raw_spin_lock <-.switch_mmu_context
    <...>-4171    0d...3..  345us : .add_preempt_count <-.__raw_spin_lock
    <...>-4171    0d...4..  346us : .sub_preempt_count <-.switch_mmu_context
    <...>-4171    0d...3..  347us : .__switch_to <-.__schedule
    <...>-4171    0d...3..  348us+: .switch_booke_debug_regs <-.__switch_to
qemu-sys-4055    0d...3..  350us : .finish_task_switch <-.__schedule
qemu-sys-4055    0d...3..  352us : .vtime_common_task_switch <-.finish_task_switch
qemu-sys-4055    0d...3..  353us : .account_system_time <-.vtime_account_system
qemu-sys-4055    0d...3..  354us : .in_serving_softirq <-.account_system_time
qemu-sys-4055    0d...3..  355us : .cpuacct_account_field <-.account_system_time
qemu-sys-4055    0d...3..  355us : .__rcu_read_lock <-.cpuacct_account_field
qemu-sys-4055    0d...3..  356us : .__rcu_read_unlock <-.cpuacct_account_field
qemu-sys-4055    0d...3..  357us : .account_user_time <-.vtime_account_user
qemu-sys-4055    0d...3..  358us : .cpuacct_account_field <-.account_user_time
qemu-sys-4055    0d...3..  359us : .__rcu_read_lock <-.cpuacct_account_field
qemu-sys-4055    0d...3..  360us : .__rcu_read_unlock <-.cpuacct_account_field
qemu-sys-4055    0d...3..  361us+: ._raw_spin_unlock_irq <-.finish_task_switch
qemu-sys-4055    0....1..  364us+: .__schedule
qemu-sys-4055    0....1..  366us+: .trace_preempt_on <-.__schedule
qemu-sys-4055    0....1..  369us : <stack trace>
