Return-Path: <dvhltc@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8BF4B70A3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Aug 2010 08:20:24 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7NM1M6e005056
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Aug 2010 18:01:22 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7NMKL4l347944
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Aug 2010 18:20:21 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7NMKK1v032552
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Aug 2010 18:20:21 -0400
Message-ID: <4C72F420.4040300@us.ibm.com>
Date: Mon, 23 Aug 2010 15:20:16 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
In-Reply-To: <20100819155824.GD2690@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 08/19/2010 08:58 AM, Ankita Garg wrote:
> Hi Darren,
>
> On Thu, Jul 22, 2010 at 11:24:13AM -0700, Darren Hart wrote:
>>
>> With some instrumentation we were able to determine that the
>> preempt_count() appears to change across the extended_cede_processor()
>> call.  Specifically across the plpar_hcall_norets(H_CEDE) call. On
>> PREEMPT_RT we call this with preempt_count=1 and return with
>> preempt_count=0xffffffff. On mainline with CONFIG_PREEMPT=y, the value
>> is different (0x65) but is still incorrect.
>
> I was trying to reproduce this issue on a 2.6.33.7-rt29 kernel. I could
> easily reproduce this on the RT kernel and not the non-RT kernel.
> However, I hit it every single time I did a cpu online operation. I also
> noticed that the issue persists even when I disable H_CEDE by passing
> the "cede_offline=0" kernel commandline parameter. Could you pl confirm
> if you observe the same in your setup ?

with the following patches:
[root@igoort1 linux-2.6-combined]# quilt applied
patches/0001-wms-fix01.patch
patches/powerpc-increase-pseries_cpu_die-delay.patch
patches/powerpc-enable-preemption-before-cpu_die.patch
patches/powerpc-silence-__cpu_up-under-normal-operation.patch
patches/powerpc-silence-xics_migrate_irqs_away-during-cpu-offline.patch
patches/powerpc-wait-for-cpu-to-go-inactive.patch
patches/powerpc-disable-decrementer-on-offline.patch
patches/powerpc-cpu_die-preempt-hack.patch
patches/powerpc-cede-processor-inst.patch
patches/irq-preempt-inst.patch
patches/disable-decrementer-in-cpu_die.patch
patches/powerpc-hard_irq_disable.patch
[root@igoort1 linux-2.6-combined]# quilt unapplied
patches/powerpc-debug-replace-cede-with-mdelay.patch
patches/powerpc-pad-thread_info.patch

applied to tip/rt/head (2.6.33-rt ish) I will see the following crash 
after 3 or 4 runs:

<3>Badness at kernel/sched.c:3720
<4>NIP: c0000000006986f8 LR: c0000000006986dc CTR: c00000000006ec34
<4>REGS: c00000008e7a7e50 TRAP: 0700   Not tainted 
(2.6.33-rt-dvhrt08-02358-g61223dd-dirty)
<4>MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000022  XER: 00000000
<4>TASK = c00000010e7080c0[0] 'swapper' THREAD: c00000008e7a8000 CPU: 3
<4>GPR00: 0000000000000000 c00000008e7a80d0 c000000000b54fa0 
0000000000000001
<4>GPR04: 0000000000000000 0000000000000032 0000000000000000 
000000000000000f
<4>GPR08: c00000008eb68d00 c000000000ca5420 0000000000000001 
c000000000bc22e8
<4>GPR12: 8000000000009032 c000000000ba4a80 c00000008e7a8a70 
0000000000000003
<4>GPR16: fffffffffffff9ba c00000010e7080c0 0000000000000000 
7fffffffffffffff
<4>GPR20: 0000000000000000 0000000000000001 0000000000000003 
c000000001042c80
<4>GPR24: 0000000000000000 c00000008eb686a0 0000000000000003 
0000000000000001
<4>GPR28: 0000000000000000 0000000000000001 c000000000ad7628 
c00000008e7a80d0
<4>NIP [c0000000006986f8] .sub_preempt_count+0x6c/0xdc
<4>LR [c0000000006986dc] .sub_preempt_count+0x50/0xdc
<4>Call Trace:
<4>Instruction dump:
<4>78290464 80090014 7f80e800 40fc002c 4bd08a99 60000000 2fa30000 419e0068
<4>e93e87e0 80090000 2f800000 409e0058 <0fe00000> 48000050 2b9d00fe 41fd0038
<1>Unable to handle kernel paging request for data at address 
0xc000018000ba44c0
<1>Faulting instruction address: 0xc00000000006aae4

This occurs with or without the cede_offline=0 parameter.

Also, in a similar experiment which seems to corroborate your results, 
suggesting the HCEDE call is not necessarily to blame here.

I had replaced the HCEDE call with a mdelay(2) and still ran into 
issues. I didn't see the preempt count change, but I do see the 
rtmutex.c:684 bug.

cpu 0x0: Vector: 300 (Data Access) at [c000000000b53ef0]
     pc: c00000000006aa54: .resched_task+0x48/0xd8
     lr: c00000000006ac44: .check_preempt_curr_idle+0x2c/0x44
     sp: c000000000b54170
    msr: 8000000000001032
    dar: c000018000ba44c0
  dsisr: 40000000
   current = 0xc000000000aa1410
   paca    = 0xc000000000ba4480
     pid   = 0, comm = swapper
enter ? for help
[c000000000b54200] c00000000006ac44 .check_preempt_curr_idle+0x2c/0x44
[c000000000b54290] c00000000007b494 .try_to_wake_up+0x430/0x540
[c000000000b54360] c00000000007b754 .wake_up_process+0x34/0x48
[c000000000b543f0] c000000000089fa8 .wakeup_softirqd+0x78/0x9c
[c000000000b54480] c00000000008a2c4 .raise_softirq+0x7c/0xb8
[c000000000b54520] c0000000000977b0 .run_local_timers+0x2c/0x4c
[c000000000b545a0] c000000000097828 .update_process_times+0x58/0x9c
[c000000000b54640] c0000000000beb3c .tick_sched_timer+0xd0/0x120
[c000000000b546f0] c0000000000b08b8 .__run_hrtimer+0x1a0/0x29c
[c000000000b547a0] c0000000000b1258 .hrtimer_interrupt+0x21c/0x394
[c000000000b548d0] c0000000000304c4 .timer_interrupt+0x1ec/0x2f8
[c000000000b54980] c000000000003700 decrementer_common+0x100/0x180
--- Exception: 901 (Decrementer) at c0000000000100f8 
.raw_local_irq_restore+0x74/0x8c
[c000000000b54d00] c000000000017d14 .cpu_idle+0x12c/0x220
[c000000000b54da0] c0000000006a1768 .start_secondary+0x3d8/0x418
[c000000000b54e60] c00000000005c1f0 .pseries_mach_cpu_die+0x244/0x318
[c000000000b54f10] c00000000001e7e0 .cpu_die+0x4c/0x68
[c000000000b54f90] c000000000017de0 .cpu_idle+0x1f8/0x220
... repeated multiple times ...


> However, the issue still remains. Will spend few cycles looking into
> this issue.

Appreciate it, the more eyes the better on this one.

--
Darren

>>
>> Also of interest is that this path
>> cpu_idle()->cpu_die()->pseries_mach_cpu_die() to start_secondary()
>> enters with a preempt_count=1 if it wasn't corrupted across the hcall.
>> The early boot path from _start however appears to call
>> start_secondary() with a preempt_count of 0.
>>
>> The following patch is most certainly not correct, but it does eliminate
>> the situation on mainline 100% of the time (there is still a 25%
>> reproduction rate on PREEMPT_RT). Can someone comment on:
>>
>> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
>> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
>>
>> Hacked-up-by: Darren Hart<dvhltc@us.ibm.com>
>>
>> Index: linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> ===================================================================
>> --- linux-2.6.33.6.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -138,6 +138,7 @@ static void pseries_mach_cpu_die(void)
>>   			 * Kernel stack will be reset and start_secondary()
>>   			 * will be called to continue the online operation.
>>   			 */
>> +			preempt_count() = 0;
>>   			start_secondary_resume();
>>   		}
>>   	}
>>
>>
>


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
