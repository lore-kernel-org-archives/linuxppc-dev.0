Return-Path: <dvhltc@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F117B712D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 17:13:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7V711GR006953
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 01:01:01 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o7V7Cvm9261406
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 01:12:57 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7V7CtkL009022
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 01:12:57 -0600
Message-ID: <4C7CAB72.2050305@us.ibm.com>
Date: Tue, 31 Aug 2010 00:12:50 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
In-Reply-To: <20100819155824.GD2690@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
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

This matches my experience.

> However, I hit it every single time I did a cpu online operation. I also
> noticed that the issue persists even when I disable H_CEDE by passing
> the "cede_offline=0" kernel commandline parameter. Could you pl confirm
> if you observe the same in your setup ?

Yes, this is my experience as well.

> 
> However, the issue still remains. Will spend few cycles looking into
> this issue.
> 

I've spent today trying to collect some useful traces. I consistently
see the preempt_count() change to 0xffffffff across the H_CEDE call, but
the irq and sched events (to ftrace) do not indicate anything else
running on the CPU that could change that.

  <idle>-0       1d.h1. 11408us : irq_handler_entry: irq=16 name=IPI
  <idle>-0       1d.h1. 11411us : irq_handler_exit: irq=16 ret=handled
  ...            <other cpus>
  <idle>-0       1d.... 22101us : .pseries_mach_cpu_die: start
  <idle>-0       1d.... 22108us : .pseries_mach_cpu_die: cpu 1 (hwid 1) ceding for offline with hint 2
  ...            <other cpus>
  <idle>-0       1d.Hff. 33804us : .pseries_mach_cpu_die: returned from cede with pcnt: ffffffff
  <idle>-0       1d.Hff. 33805us : .pseries_mach_cpu_die: forcing pcnt to 0
  <idle>-0       1d.... 33807us : .pseries_mach_cpu_die: cpu 1 (hwid 1) returned from cede.
  <idle>-0       1d.... 33808us : .pseries_mach_cpu_die: Decrementer value = 7fa49474 Timebase value = baefee6c88113
  <idle>-0       1d.... 33809us : .pseries_mach_cpu_die: cpu 1 (hwid 1) got prodded to go online
  <idle>-0       1d.... 33816us : .pseries_mach_cpu_die: calling start_seconday, pcnt: 0
  <idle>-0       1d.... 33816us : .pseries_mach_cpu_die: forcing pcnt to 0

---------------------------------
Modules linked in: autofs4 binfmt_misc dm_mirror dm_region_hash dm_log [last unloaded: scsi_wait_scan]
NIP: c00000000006aa50 LR: c00000000006ac40 CTR: c00000000006ac14
REGS: c00000008e79ffc0 TRAP: 0300   Not tainted  (2.6.33-rt-dvhrt16-02358-g61223dd-dirty)
MSR: 8000000000001032 <ME,IR,DR>  CR: 28000022  XER: 00000000
DAR: c000018000ba44c0, DSISR: 0000000040000000
TASK = c00000010e6de040[0] 'swapper' THREAD: c00000008e7a0000 CPU: 1
GPR00: 0000018000000040 c00000008e7a0240 c000000000b55008 c00000010e6de040
GPR04: c000000085d800c0 0000000000000000 0000000000000000 000000000000000f
GPR08: 0000018000000000 c00000008e7a0000 c000000000ba4480 c000000000a32c80
GPR12: 8000000000009032 c000000000ba4680 c00000008e7a08f0 0000000000000001
GPR16: fffffffffffff2fa c00000010e6de040 0000000000000000 7fffffffffffffff
GPR20: 0000000000000000 0000000000000001 0000000000000001 c000000000f42c80
GPR24: c0000000850b7638 0000000000000000 0000000000000000 0000000000000001
GPR28: c000000000f42c80 c00000010e6de040 c000000000ad7698 c00000008e7a0240
NIP [c00000000006aa50] .resched_task+0x48/0xd8
LR [c00000000006ac40] .check_preempt_curr_idle+0x2c/0x44
Call Trace:
Instruction dump:
f821ff71 7c3f0b78 ebc2ab28 7c7d1b78 60000000 60000000 e95e8008 e97e8000
e93d0008 81090010 79084da4 38080040 <7d4a002a> 7c0b502e 7c000074 7800d182
---[ end trace 6d3f1cddaa17382c ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Call Trace:
Rebooting in 180 seconds..



When running with the function plugin I had to stop the trace
immediately before entering start_secondary after an online or my traces
would not include the pseries_mach_cpu_die function, nor the tracing I
added there (possibly buffer size, I am using 2048). The following trace
was collected using "trace-cmd record -p function -e irq -e sched" and
has been filtered to only show CPU [001] (the CPU undergoing the
offline/online test, and the one seeing preempt_count (pcnt) go to
ffffffff after cede. The function tracer does not indicate anything
running on the CPU other than the HCALL - unless the __trace_hcall*
commands might be to blame. Can a POWER guru comment?

          <idle>-0     [001]   417.625286: function:             .cpu_die
          <idle>-0     [001]   417.625287: function:                .pseries_mach_cpu_die
          <idle>-0     [001]   417.625290: bprint:               .pseries_mach_cpu_die : start
          <idle>-0     [001]   417.625291: function:                   .idle_task_exit
          <idle>-0     [001]   417.625292: function:                      .switch_slb
          <idle>-0     [001]   417.625294: function:                   .xics_teardown_cpu
          <idle>-0     [001]   417.625294: function:                      .xics_set_cpu_priority
          <idle>-0     [001]   417.625295: function:             .__trace_hcall_entry
          <idle>-0     [001]   417.625296: function:                .probe_hcall_entry
          <idle>-0     [001]   417.625297: function:             .__trace_hcall_exit
          <idle>-0     [001]   417.625298: function:                .probe_hcall_exit
          <idle>-0     [001]   417.625299: function:             .__trace_hcall_entry
          <idle>-0     [001]   417.625300: function:                .probe_hcall_entry
          <idle>-0     [001]   417.625301: function:             .__trace_hcall_exit
          <idle>-0     [001]   417.625302: function:                .probe_hcall_exit
          <idle>-0     [001]   417.625305: bprint:               .pseries_mach_cpu_die : cpu 1 (hwid 1) ceding for offline with hint 2
          <idle>-0     [001]   417.625307: bprint:               .pseries_mach_cpu_die : calling extended cede, pcnt: 0
          <idle>-0     [001]   417.625308: function:             .__trace_hcall_entry
          <idle>-0     [001]   417.625308: function:                .probe_hcall_entry
          <idle>-0     [001]   417.837734: function:             .__trace_hcall_exit
          <idle>-0     [001]   417.837736: function:                .probe_hcall_exit
          <idle>-0     [001]   417.837740: bprint:               .pseries_mach_cpu_die : returned from cede with pcnt: ffffffff
          <idle>-0     [001]   417.837742: bprint:               .pseries_mach_cpu_die : forcing pcnt to 0
          <idle>-0     [001]   417.837743: bprint:               .pseries_mach_cpu_die : cpu 1 (hwid 1) returned from cede.
          <idle>-0     [001]   417.837745: bprint:               .pseries_mach_cpu_die : Decrementer value = 79844cbf Timebase value = bb3cf7ab2771c
          <idle>-0     [001]   417.837747: bprint:               .pseries_mach_cpu_die : cpu 1 (hwid 1) got prodded to go online
          <idle>-0     [001]   417.837749: function:             .__trace_hcall_entry
          <idle>-0     [001]   417.837749: function:                .probe_hcall_entry
          <idle>-0     [001]   417.837755: function:             .__trace_hcall_exit
          <idle>-0     [001]   417.837755: function:                .probe_hcall_exit
          <idle>-0     [001]   417.837757: bprint:               .pseries_mach_cpu_die : calling start_seconday, pcnt: 0
          <idle>-0     [001]   417.837758: bprint:               .pseries_mach_cpu_die : forcing pcnt to 0



I replaced the extended_cede_processor() call with mdelay(2). When I do
that, I don't see the preempt_count() change across the mdelay(2) call.
However, the system still eventually crashes in sub_preempt_count().
This appears to be independent of if preempt_count changes across
CEDE (since it doesn't occur across mdelay). I will try with larger
values of mdelay tomorrow to see if a longer delay will experience the
preempt_count value change.

Badness at kernel/sched.c:3726
NIP: c000000000698684 LR: c000000000698668 CTR: c00000000007a89c
REGS: c00000008e7a0170 TRAP: 0700   Not tainted  (2.6.33-rt-dvhrt16-02358-g61223dd-dirty)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000022  XER: 00000000
TASK = c00000010e6de040[0] 'swapper' THREAD: c00000008e7a0000 CPU: 1
GPR00: 0000000000000000 c00000008e7a03f0 c000000000b55008 0000000000000001
GPR04: 0000000000000000 0000000000000000 0000000000000000 000000000000000f
GPR08: 0000000000000200 c000000000ca5420 0000000000000001 c000000000bc22f0
GPR12: 8000000000009032 c000000000ba4680 c00000008e7a0a10 0000000000000001
GPR16: fffffffffffff4d1 c00000010e6de040 0000000000000000 7fffffffffffffff
GPR20: 0000000000000000 0000000000000001 0000000000000001 c000000000f42c80
GPR24: 0000000000000001 0000000000000000 0000000000000000 0000000000000001
GPR28: c000000000f42c80 0000000000000001 c000000000ad7698 c00000008e7a03f0
NIP [c000000000698684] .sub_preempt_count+0xa8/0xdc
LR [c000000000698668] .sub_preempt_count+0x8c/0xdc
Call Trace:
Instruction dump:
41fd0038 78000620 2fa00000 40fe002c 4bd08a61 60000000 2fa30000 419e002c
e93e87e8 80090000 2f800000 409e001c <0fe00000> 48000014 78290464 80090014
Unable to handle kernel paging request for data at address 0xc000018000ba44c0
Faulting instruction address: 0xc00000000006aa1c
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT SMP NR_CPUS=128 NUMA pSeries
last sysfs file:line



-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
