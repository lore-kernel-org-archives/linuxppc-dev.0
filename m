Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F3D01B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 10:37:09 +1000 (EST)
Message-ID: <1336696621.3881.72.camel@pasglop>
Subject: Re: [BUG] powerpc: perf record crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 11 May 2012 10:37:01 +1000
In-Reply-To: <20120511002354.GA8895@us.ibm.com>
References: <20120511002354.GA8895@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-10 at 17:23 -0700, Sukadev Bhattiprolu wrote:
> I get this crash when I run on 3.4.0-rc5 on a P6.
> 
> 	./perf record -a -d -- ./perf bench sched all
> 
> I rebuilt 'perf' locally after building the kernel 3.4.0-rc5.
> 
> Sometimes it occurs on the first attempt, sometimes on the second.
> Pls let me know if I can provide any other debug info.

It looks like the same bug that Wang Sheng-Hui <shhuiw@gmail.com>
reported, I'm still tracking it. I pushed a patch upstream that I
thought fixed it but according to Wang, it's still around.

Looking at it now.

Cheers,
Ben.
 
> ----
> 
> Red Hat Enterprise Linux Server release 6.2 (Santiago)
> Kernel 3.4.0-rc5-mainline on an ppc64
> 
> stormy2 login: kernel BUG at arch/powerpc/kernel/irq.c:188!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=1024 NUMA pSeries
> Modules linked in: ipv6 bnx2 ses enclosure sg ehea ext4 jbd2 mbcache sd_mod crc_t10dif ipr radeon drm_kms_helper ttm drm i2c_algo_bit i2c_core power_supply dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_wait_scan]
> NIP: c00000000000ea9c LR: c000000000010548 CTR: 0000000000000000
> REGS: c00000006de879f0 TRAP: 0700   Not tainted  (3.4.0-rc5-mainline)
> MSR: 8000000000021032 <SF,ME,IR,DR,RI>  CR: 22000088  XER: 00000000
> SOFTE: 0
> CFAR: 0000000000003318
> TASK = c00000006de62d50[0] 'swapper/7' THREAD: c00000006de84000 CPU: 7
> GPR00: 0000000000000001 c00000006de87c70 c000000000c47d88 0000000000000500 
> GPR04: 000000000bf87ff4 0000000000000000 0000000000000007 000e1cfe2fc642ff 
> GPR08: 00000000007e0000 c000000006df1500 0000000000000001 0000000000000000 
> GPR12: 0000000042000088 c000000006df1500 c00000006de87f90 0000000006f042c0 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 0000000000000000 8000000000009032 
> GPR24: c00000006de84000 0000000000000000 c000000000e356d0 c000000000cd0318 
> GPR28: c0000000006229b8 c000000000b55f58 c000000000bce190 c000000000ff8eb0 
> NIP [c00000000000ea9c] .__check_irq_replay+0x7c/0x90
> LR [c000000000010548] .arch_local_irq_restore+0x38/0x90
> Call Trace:
> [c00000006de87c70] [00000000832e13f4] 0x832e13f4 (unreliable)
> [c00000006de87ce0] [c0000000004ca118] .cpuidle_idle_call+0x1f8/0x380
> [c00000006de87da0] [c000000000055450] .pSeries_idle+0x10/0x40
> [c00000006de87e10] [c000000000017ce8] .cpu_idle+0x178/0x290
> [c00000006de87ed0] [c0000000006081f0] .start_secondary+0x350/0x35c
> [c00000006de87f90] [c00000000000936c] .start_secondary_prolog+0x10/0x14
> Instruction dump:
> 4e800020 7da96b78 8809022b 794bf7e3 38600500 5400e87e 5400183e 9809022b 
> 4082ffdc 880d022b 7c0000d0 78000fe0 <0b000000> 38600000 4bffffc4 60000000 
> ---[ end trace 39f49db612f9ab0f ]---
> 
> Kernel panic - not syncing: Attempted to kill the idle task!
> panic occurred, switching back to text console
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Current pid: 6199 comm: perf / Idle pid: 0 comm: swapper/7
> ------------[ cut here ]------------
> WARNING: at kernel/rcutree.c:465
> Modules linked in: ipv6 bnx2 ses enclosure sg ehea ext4 jbd2 mbcache sd_mod crc_t10dif ipr radeon drm_kms_helper ttm drm i2c_algo_bit i2c_core power_supply dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_wait_scan]
> NIP: c000000000110aa0 LR: c000000000110a9c CTR: c000000000060f40
> REGS: c000000068b96e00 TRAP: 0700   Tainted: G      D       (3.4.0-rc5-mainline)
> MSR: 8000000000021032 <SF,ME,IR,DR,RI>  CR: 28022482  XER: 0000000a
> SOFTE: 0
> CFAR: c000000000602cc4
> TASK = c000000059620090[6199] 'perf' THREAD: c000000068b94000 CPU: 7
> GPR00: c000000000110a9c c000000068b97080 c000000000c47d88 000000000000003d 
> GPR04: 0000000000000000 0000000000000000 0000000000000000 800000000b2a3d80 
> GPR08: 0000000000000000 c000000000804208 000000000002ef30 00000000007e0000 
> GPR12: 0000000024022488 c000000006df1500 c000000069c8db00 c000000000815b80 
> GPR16: c000000000815b80 0000000000000000 c000000068b97750 c000000000caed60 
> GPR20: c000000068b94080 0000000000000001 0000000000000000 0000000000000004 
> GPR24: c000000000815b80 c000000000cacad8 c000000068b94000 0000000000000000 
> GPR28: c0000000008155f0 c00000006de62d50 c000000000bd5c40 c000000000b88053 
> NIP [c000000000110aa0] .rcu_idle_exit_common+0xc0/0x100
> LR [c000000000110a9c] .rcu_idle_exit_common+0xbc/0x100
> Call Trace:
> [c000000068b97080] [c000000000110a9c] .rcu_idle_exit_common+0xbc/0x100 (unreliable)
> [c000000068b97110] [c000000000110b98] .rcu_irq_enter+0xb8/0xe0
> [c000000068b97190] [c00000000007b5ec] .irq_enter+0x1c/0xc0
> [c000000068b97220] [c000000000010024] .do_IRQ+0x64/0x2e0
> [c000000068b972e0] [c0000000000038c0] hardware_interrupt_common+0x140/0x180
> --- Exception: 501 at .arch_local_irq_restore+0x74/0x90
>     LR = .arch_local_irq_restore+0x74/0x90
> [c000000068b975d0] [c0000000000b35e8] .update_rq_clock+0x48/0x80 (unreliable)
> [c000000068b97640] [c0000000000b319c] .finish_task_switch+0x7c/0x150
> [c000000068b976e0] [c0000000005f62b0] .__schedule+0x2f0/0x6e0
> [c000000068b97960] [c0000000001d0ac4] .pipe_wait+0x64/0xa0
> [c000000068b97a20] [c0000000001d1578] .pipe_read+0x3d8/0x670
> [c000000068b97b50] [c0000000001c35a4] .do_sync_read+0xb4/0x140
> [c000000068b97ce0] [c0000000001c475c] .vfs_read+0xec/0x1e0
> [c000000068b97d80] [c0000000001c4978] .SyS_read+0x58/0xd0
> [c000000068b97e30] [c0000000000097dc] syscall_exit+0x0/0x38
> Instruction dump:
> 881f000e 2f800001 41feffbc e92d0200 e8ad0200 e889022e e8dd022e e87e8120 
> 38a503c8 38fd03c8 484f21fd 60000000 <0fe00000> 38000001 981f000e 4bffff88 
> ---[ end trace 39f49db612f9ab10 ]---
> Current pid: 6199 comm: perf / Idle pid: 0 comm: swapper/7
> ------------[ cut here ]------------
> WARNING: at kernel/rcutree.c:355
> Modules linked in: ipv6 bnx2 ses enclosure sg ehea ext4 jbd2 mbcache sd_mod crc_t10dif ipr radeon drm_kms_helper ttm drm i2c_algo_bit i2c_core power_supply dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_wait_scan]
> NIP: c000000000110d80 LR: c000000000110d7c CTR: c000000000060f40
> REGS: c000000068b96e10 TRAP: 0700   Tainted: G      D W     (3.4.0-rc5-mainline)
> MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 28022482  XER: 0000000a
> SOFTE: 0
> CFAR: c000000000602cc4
> TASK = c000000059620090[6199] 'perf' THREAD: c000000068b94000 CPU: 7
> GPR00: c000000000110d7c c000000068b97090 c000000000c47d88 000000000000003d 
> GPR04: 0000000000000000 0000000000000000 0000000000000000 800000000b2a3d80 
> GPR08: 0000000000000000 c000000000804208 00000000000399f0 00000000007e0000 
> GPR12: 0000000028022488 c000000006df1500 c000000069c8db00 c000000000815b80 
> GPR16: c000000000815b80 0000000000000000 c000000068b97750 c000000000caed60 
> GPR20: c000000068b94080 0000000000000001 0000000000000010 c000000068b94100 
> GPR24: 0000000000000000 c000000068b94000 c0000000e7fac000 0000000000000000 
> GPR28: c00000006de62d50 c000000000b88053 c000000000bd5c40 c000000000fe4bf8 
> NIP [c000000000110d80] .rcu_idle_enter_common+0xd0/0x110
> LR [c000000000110d7c] .rcu_idle_enter_common+0xcc/0x110
> Call Trace:
> [c000000068b97090] [c000000000110d7c] .rcu_idle_enter_common+0xcc/0x110 (unreliable)
> [c000000068b97120] [c000000000110e74] .rcu_irq_exit+0xb4/0xe0
> [c000000068b971a0] [c00000000007b3ec] .irq_exit+0x8c/0xf0
> [c000000068b97220] [c000000000010094] .do_IRQ+0xd4/0x2e0
> [c000000068b972e0] [c0000000000038c0] hardware_interrupt_common+0x140/0x180
> --- Exception: 501 at .arch_local_irq_restore+0x74/0x90
>     LR = .arch_local_irq_restore+0x74/0x90
> [c000000068b975d0] [c0000000000b35e8] .update_rq_clock+0x48/0x80 (unreliable)
> [c000000068b97640] [c0000000000b319c] .finish_task_switch+0x7c/0x150
> [c000000068b976e0] [c0000000005f62b0] .__schedule+0x2f0/0x6e0
> [c000000068b97960] [c0000000001d0ac4] .pipe_wait+0x64/0xa0
> [c000000068b97a20] [c0000000001d1578] .pipe_read+0x3d8/0x670
> [c000000068b97b50] [c0000000001c35a4] .do_sync_read+0xb4/0x140
> [c000000068b97ce0] [c0000000001c475c] .vfs_read+0xec/0x1e0
> [c000000068b97d80] [c0000000001c4978] .SyS_read+0x58/0xd0
> [c000000068b97e30] [c0000000000097dc] syscall_exit+0x0/0x38
> Instruction dump:
> 881d0011 2f800001 41feff8c e92d0200 e8ad0200 e889022e e8dc022e e87e8120 
> 38a503c8 38fc03c8 484f1f1d 60000000 <0fe00000> 38000001 981d0011 4bffff58 
> ---[ end trace 39f49db612f9ab11 ]---
> Rebooting in 10 seconds..
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
