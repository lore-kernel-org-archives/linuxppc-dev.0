Return-Path: <dvhltc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EEEAB716C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 16:04:37 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o825o4Dp023835
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 01:50:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8264WQA307574
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 02:04:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8264Vmg004035
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 02:04:32 -0400
Message-ID: <4C7F3E6C.3010905@us.ibm.com>
Date: Wed, 01 Sep 2010 23:04:28 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com> <4C7E9FC1.60004@us.ibm.com>
	<1283371161.2356.53.camel@gandalf.stny.rr.com>	
	<4C7EBAA8.7030601@us.ibm.com> <11579.1283389322@neuling.org>
	<1283400367.2356.69.camel@gandalf.stny.rr.com>
In-Reply-To: <1283400367.2356.69.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
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

On 09/01/2010 09:06 PM, Steven Rostedt wrote:
> On Thu, 2010-09-02 at 11:02 +1000, Michael Neuling wrote:
> 
>> We need to call smp_startup_cpu on boot when we the cpus are still in
>> FW.  smp_startup_cpu does this for us on boot.
>>
>> I'm wondering if we just need to move the test down a bit to make sure
>> the preempt_count is set.  I've not been following this thread, but
>> maybe this might work?
> 
> Egad no! Setting the preempt_count to zero _is_ the bug. I think Darren
> even said that adding the exit prevented the bug (although now he's
> hitting a hard lockup someplace else). The original code he was using
> did not have the condition to return for kexec. It was just a
> coincidence that this code helped in bringing a CPU back online.
> 
>>
>> Untested patch below...
>>
>> Mikey
>>
>> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
>> index 0317cce..3afaba4 100644
>> --- a/arch/powerpc/platforms/pseries/smp.c
>> +++ b/arch/powerpc/platforms/pseries/smp.c
>> @@ -104,18 +104,18 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
>>  
>>  	pcpu = get_hard_smp_processor_id(lcpu);
>>  
>> -	/* Check to see if the CPU out of FW already for kexec */
>> -	if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
>> -		cpumask_set_cpu(lcpu, of_spin_mask);
>> -		return 1;
>> -	}
>> -
>>  	/* Fixup atomic count: it exited inside IRQ handler. */
>>  	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
> 
> We DON'T want to do the above. It's nasty! This is one CPU's task
> touching an intimate part of another CPU's task. It's equivalent of me
> putting my hand down you wife's blouse. It's offensive, and rude.
> 
> OK, if the CPU was never online, then you can do what you want. But what
> we see is that this fails on CPU hotplug.  You stop a CPU, and it goes
> into this cede_processor() call. When you wake it up, suddenly the task
> on that woken CPU has its preempt count fscked up.  This was really
> really hard to debug. We thought it was stack corruption or something.
> But it ended up being that this code has one CPU touching the breasts of
> another CPU. This code is a pervert!
> 
> What the trace clearly showed, was that we take down a CPU, and in doing
> so, the code on that CPU set the preempt count to 1, and it expected to
> have it as 1 when it returned. But the code that kicked started this CPU
> back to life (bring the CPU back online), set the preempt count on the
> task of that CPU to 0, and screwed everything up.


Right, what Steve said.

This patch resolved the problem, but it did so inadvertently while
trying to fix kexec. I'm wondering if the offline/online code needs to
be updated to never call smp_startup_cpu(). Or perhaps this is the right
fix, and the comment needs to be cleaned up so that it isn't only for
kexec.

With this in place, we no longer see the preempt_count dropping below
zero. However, if I offline/online a CPU about 246 times I hit the
opposite problem, a preempt_count() overflow. There appears to be a
missing preempt_enable() somewhere in the offline/online paths.

On 2.6.33.7 with CONFIG_PREEMPT=y I run the following test:

# cat offon_loop.sh 
#!/bin/sh
for i in `seq 100`; do
        echo "Iteration $i"
        echo 0 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu1/online
done

And see the overflow:

Iteration 238
Iteration 239
Iteration 240

Message from syslogd@igoort1 at Sep  1 17:36:45 ...
 kernel:------------[ cut here ]------------
Iteration 241
Iteration 242
Iteration 243
Iteration 244
Iteration 245

With the following on the console. This is the:
	/*
	 * Spinlock count overflowing soon?
	 */
	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
				PREEMPT_MASK - 10);
test. Max preempt count is 256.

Somewhere we are now MISSING a sub_preempt_count() or preempt_enable().

Badness at kernel/sched.c:5372
NIP: c000000000694f14 LR: c000000000694ef8 CTR: c00000000005b0a0
REGS: c00000008e776ae0 TRAP: 0700   Not tainted  (2.6.33.7-dirty)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000082  XER: 00000000
TASK = c00000010e6fc040[0] 'swapper' THREAD: c00000008e774000 CPU: 1
GPR00: 0000000000000000 c00000008e776d60 c000000000af2ab8 0000000000000001
GPR04: c00000008e776fb8 0000000000000004 0000000000000001 ffffffffff676980
GPR08: 0000000000000400 c000000000bcd930 0000000000000001 c000000000b2d360
GPR12: 0000000000000002 c000000000b0f680 0000000000000000 000000000f394acc
GPR16: 0000000000000000 0000000000000000 0000000000000000 c00000008e777880
GPR20: c000000000e05160 c00000008e777870 7fffffffffffffff c000000000b0f480
GPR24: c0000000009da400 0000000000000002 0000000000000000 0000000000000001
GPR28: c00000008e776fb8 0000000000000001 c000000000a75bf0 c00000008e776d60
NIP [c000000000694f14] .add_preempt_count+0xc0/0xe0
LR [c000000000694ef8] .add_preempt_count+0xa4/0xe0
Call Trace:
[c00000008e776d60] [c00000008e776e00] 0xc00000008e776e00 (unreliable)
[c00000008e776df0] [c00000000005b0d8] .probe_hcall_entry+0x38/0x94
[c00000008e776e80] [c00000000004ef70] .__trace_hcall_entry+0x80/0xd4
[c00000008e776f10] [c00000000004f96c] .plpar_hcall_norets+0x50/0xd0
[c00000008e776f80] [c000000000055044] .smp_xics_message_pass+0x110/0x244
[c00000008e777030] [c000000000034824] .smp_send_reschedule+0x5c/0x78
[c00000008e7770c0] [c00000000006a6bc] .resched_task+0xb4/0xd8
[c00000008e777150] [c00000000006a840] .check_preempt_curr_idle+0x2c/0x44
[c00000008e7771e0] [c00000000007a868] .try_to_wake_up+0x460/0x548
[c00000008e7772b0] [c00000000007a98c] .default_wake_function+0x3c/0x54
[c00000008e777350] [c0000000000ab3b0] .autoremove_wake_function+0x44/0x84
[c00000008e777400] [c00000000006449c] .__wake_up_common+0x7c/0xf4
[c00000008e7774c0] [c00000000006a5d8] .__wake_up+0x60/0x90
[c00000008e777570] [c0000000000810dc] .printk_tick+0x84/0xa8
[c00000008e777600] [c000000000095c90] .update_process_times+0x64/0xa4
[c00000008e7776a0] [c0000000000bdcec] .tick_sched_timer+0xd0/0x120
[c00000008e777750] [c0000000000afe7c] .__run_hrtimer+0x1a0/0x29c
[c00000008e777800] [c0000000000b02a4] .hrtimer_interrupt+0x124/0x278
[c00000008e777900] [c00000000002ea90] .timer_interrupt+0x1dc/0x2e4
[c00000008e7779a0] [c000000000003700] decrementer_common+0x100/0x180
--- Exception: 901 at .raw_local_irq_restore+0x48/0x54
    LR = .cpu_idle+0x12c/0x208
[c00000008e777c90] [c000000000b21130] ppc_md+0x0/0x240 (unreliable)
[c00000008e777cd0] [c000000000016a60] .cpu_idle+0x120/0x208
[c00000008e777d70] [c00000000069dbec] .start_secondary+0x394/0x3d4
[c00000008e777e30] [c000000000008278] .start_secondary_resume+0x10/0x14
Instruction dump:
409e0034 78630620 2ba300f4 40fd0028 4bd0b711 60000000 2fa30000 419e0018
e93e8880 80090000 2f800000 409e0008 <0fe00000> 383f0090 e8010010 7c0803a6

BUG: scheduling while atomic: swapper/0/0x000000f0
Modules linked in: autofs4 binfmt_misc dm_mirror dm_region_hash dm_log [last unloaded: scsi_wait_scan]
Call Trace:
[c00000008e7779a0] [c000000000014280] .show_stack+0xd8/0x218 (unreliable)
[c00000008e777a80] [c0000000006980b0] .dump_stack+0x28/0x3c
[c00000008e777b00] [c000000000071954] .__schedule_bug+0x94/0xb8
[c00000008e777b90] [c00000000068db40] .schedule+0xf8/0xbf4
[c00000008e777cd0] [c000000000016b34] .cpu_idle+0x1f4/0x208
[c00000008e777d70] [c00000000069dbec] .start_secondary+0x394/0x3d4
[c00000008e777e30] [c000000000008278] .start_secondary_resume+0x10/0x14

I'll spend tomorrow collecting traces and trying to see who's groping who this time...

--
Darren



> 
> -- Steve
> 
> 
>>  
>>  	if (get_cpu_current_state(lcpu) == CPU_STATE_INACTIVE)
>>  		goto out;
>>  
>> +	/* Check to see if the CPU out of FW already for kexec */
>> +	if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
>> +		cpumask_set_cpu(lcpu, of_spin_mask);
>> +		return 1;
>> +	}
>> +
>>  	/* 
>>  	 * If the RTAS start-cpu token does not exist then presume the
>>  	 * cpu is already spinning.
>>
> 
> 


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
