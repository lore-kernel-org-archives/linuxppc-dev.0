Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltvp3WrnzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:26 +1000 (AEST)
In-Reply-To: <1526628925-31075-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anju@linux.vnet.ibm.com
Subject: Re: powerpc/perf: Remove sched_task function defined for thread-imc
Message-Id: <41ltvn5yhdz9s3Z@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-18 at 07:35:25 UTC, Anju T Sudhakar wrote:
> Call trace observed while running perf-fuzzer:
> 
> [  329.228068] CPU: 43 PID: 9088 Comm: perf_fuzzer Not tainted 4.13.0-32-generic #35~lp1746225
> [  329.228070] task: c000003f776ac900 task.stack: c000003f77728000
> [  329.228071] NIP: c000000000299b70 LR: c0000000002a4534 CTR: c00000000029bb80
> [  329.228073] REGS: c000003f7772b760 TRAP: 0700   Not tainted  (4.13.0-32-generic)
> [  329.228073] MSR: 900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
> [  329.228079]   CR: 24008822  XER: 00000000
> [  329.228080] CFAR: c000000000299a70 SOFTE: 0
> GPR00: c0000000002a4534 c000003f7772b9e0 c000000001606200 c000003fef858908
> GPR04: c000003f776ac900 0000000000000001 ffffffffffffffff 0000003fee730000
> GPR08: 0000000000000000 0000000000000000 c0000000011220d8 0000000000000002
> GPR12: c00000000029bb80 c000000007a3d900 0000000000000000 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 0000000000000000 0000000000000000 c000003f776ad090 c000000000c71354
> GPR24: c000003fef716780 0000003fee730000 c000003fe69d4200 c000003f776ad330
> GPR28: c0000000011220d8 0000000000000001 c0000000014c6108 c000003fef858900
> [  329.228098] NIP [c000000000299b70] perf_pmu_sched_task+0x170/0x180
> [  329.228100] LR [c0000000002a4534] __perf_event_task_sched_in+0xc4/0x230
> [  329.228101] Call Trace:
> [  329.228102] [c000003f7772b9e0] [c0000000002a0678] perf_iterate_sb+0x158/0x2a0 (unreliable)
> [  329.228105] [c000003f7772ba30] [c0000000002a4534] __perf_event_task_sched_in+0xc4/0x230
> [  329.228107] [c000003f7772bab0] [c0000000001396dc] finish_task_switch+0x21c/0x310
> [  329.228109] [c000003f7772bb60] [c000000000c71354] __schedule+0x304/0xb80
> [  329.228111] [c000003f7772bc40] [c000000000c71c10] schedule+0x40/0xc0
> [  329.228113] [c000003f7772bc60] [c0000000001033f4] do_wait+0x254/0x2e0
> [  329.228115] [c000003f7772bcd0] [c000000000104ac0] kernel_wait4+0xa0/0x1a0
> [  329.228117] [c000003f7772bd70] [c000000000104c24] SyS_wait4+0x64/0xc0
> [  329.228121] [c000003f7772be30] [c00000000000b184] system_call+0x58/0x6c
> [  329.228121] Instruction dump:
> [  329.228123] 3beafea0 7faa4800 409eff18 e8010060 eb610028 ebc10040 7c0803a6 38210050
> [  329.228127] eb81ffe0 eba1ffe8 ebe1fff8 4e800020 <0fe00000> 4bffffbc 60000000 60420000
> [  329.228131] ---[ end trace 8c46856d314c1811 ]---
> [  375.755943] hrtimer: interrupt took 31601 ns
> 
> 
> The context switch call-backs for thread-imc are defined in sched_task function.
> So when thread-imc events are grouped with software pmu events,
> perf_pmu_sched_task hits the WARN_ON_ONCE condition, since software PMUs are
> assumed not to have a sched_task defined. 
>  
> Patch to move the thread_imc enable/disable opal call back from sched_task to
> event_[add/del] function
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Tested-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7ccc4fe5ff9e3a134e863beed0dba1

cheers
