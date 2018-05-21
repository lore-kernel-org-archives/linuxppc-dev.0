Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q8Z51Xr7zF0wY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 16:51:08 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id v24-v6so8230473plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 23:51:08 -0700 (PDT)
Date: Mon, 21 May 2018 16:50:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, Stephen Rothwell  <sfr@canb.auug.org.au>, mpe
 <mpe@ellerman.id.au>, sachinp  <sachinp@linux.vnet.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [next-20180517][ppc] watchdog: CPU 88 self-detected hard LOCKUP
 @ update_cfs_group+0x30/0x150
Message-ID: <20180521165056.5f3dceeb@roar.ozlabs.ibm.com>
In-Reply-To: <1526883300.19317.18.camel@abdul>
References: <1526883300.19317.18.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ah, it's POWER8.

I'm betting we have a bug with nohz timer offloading somewhere.

I *think* we may have seen similar on P9 as well, but that may be
related to problems with stop states.

Can you reproduce it easily? I'm thinking maybe adding some
tracepoints that track decrementer settings and interrupts, and
nohz offload activity might show something up.

Thanks,
Nick


On Mon, 21 May 2018 11:45:00 +0530
Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:

> Greeting's
> 
> Offlate we are seeing hard hard lockup trace messages on our powerpc
> bare-metal machine for both linux-next and mainline kernel
> 
> Machine Type: Power 8 Bare-metal (minsky)
> kernel: 4.17.0-rc5-next-20180517
> gcc: 4.8.5
> config: attached
> test: the exact scenario which is triggering these traces is not known
> 
> trace logs:
> -----------
> Watchdog: CPU 88 TB:20328455213119, last heartbeat TB:20323303945487 (10061ms ago)
> Modules linked in: btrfs xor zstd_decompress zstd_compress xxhash
> lzo_compress raid6_pq dm_snapshot dm_bufio nvme bnx2x iptable_mangle
> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
> nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_filter dm_mirror
> dm_region_hash dm_log dm_service_time vmx_crypto powernv_rng rng_core
> dm_multipath kvm_hv kvm binfmt_misc nfsd ip_tables x_tables autofs4 xfs
> lpfc crc_t10dif crct10dif_generic nvme_fc nvme_fabrics mdio libcrc32c
> nvme_core crct10dif_common [last unloaded: nvme]
> CPU: 88 PID: 0 Comm: swapper/88 Not tainted 4.17.0-rc5-next-20180517-autotest-autotest #1
> NIP:  c000000000131a80 LR: c0000000001376b8 CTR: c0000000008284c0
> REGS: c000003fff42fd80 TRAP: 0900   Not tainted  (4.17.0-rc5-next-20180517-autotest-autotest)
> MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 22042044  XER: 20000000
> CFAR: c0000000001376b4 SOFTE: 1
> GPR00: c000000000137b64 c000003ca93236a0 c000000001086c00 c000003c907bdc00
> GPR04: c000003c907bdc00 c000003ffbf23a68 0000000000000000 c000001f4f540400
> GPR08: 0000000000100000 c000003c907bde00 0000000000000400 c000003c907bde30
> GPR12: c0000000008284c0 c000003fff74f880 c0000000008284c0 c000003ffbf260b8
> GPR16: c000003ffbf27580 0000000000000001 0000000000000000 000000000000ba7e
> GPR20: 000000000000ba7e 0000000000000001 c000001f4ac55900 c000003ffbf27580
> GPR24: afb504000afb5041 0000000000000001 0000000000000000 0000000000000001
> GPR28: 0000000000000001 0000000000000000 c000003ffbf27600 c000003c907bdc00
> NIP [c000000000131a80] update_cfs_group+0x30/0x150
> LR [c0000000001376b8] enqueue_task_fair+0x3c8/0x1390
> Call Trace:
> [c000003ca93236a0] [c000000000137b64] enqueue_task_fair+0x874/0x1390 (unreliable)
> [c000003ca9323790] [c000000000128870] activate_task+0x80/0x120
> [c000003ca9323810] [c000000000128db8] ttwu_do_activate+0x68/0xc0
> [c000003ca9323850] [c00000000012a208] try_to_wake_up+0x238/0x5c0
> [c000003ca93238d0] [c0000000001853b0] hrtimer_wakeup+0x30/0x60
> [c000003ca93238f0] [c000000000185094] __hrtimer_run_queues+0x124/0x350
> [c000003ca9323970] [c000000000185e3c] hrtimer_interrupt+0x11c/0x2f0
> [c000003ca9323a20] [c000000000023290] __timer_interrupt+0x90/0x270
> [c000003ca9323a70] [c000000000023900] timer_interrupt+0xa0/0xe0
> [c000003ca9323aa0] [c000000000009348] decrementer_common+0x158/0x160
> --- interrupt: 901 at replay_interrupt_return+0x0/0x4
>     LR = arch_local_irq_restore+0x74/0x90
> [c000003ca9323d90] [c00000000019a92c] tick_nohz_idle_stop_tick+0x17c/0x360 (unreliable)
> [c000003ca9323db0] [c00000000082b668] cpuidle_enter_state+0x108/0x3c0
> [c000003ca9323e10] [c000000000130104] call_cpuidle+0x44/0x80
> [c000003ca9323e30] [c000000000130698] do_idle+0x2f8/0x3a0
> [c000003ca9323ec0] [c000000000130914] cpu_startup_entry+0x34/0x40
> [c000003ca9323ef0] [c0000000000432a4] start_secondary+0x4d4/0x520
> [c000003ca9323f90] [c00000000000b270] start_secondary_prolog+0x10/0x14
> Instruction dump:
> 3c4c00f5 384251b0 e9230160 7c641b78 2fa90000 4d9e0020 e9490000 e8c900a0
> e8e901d0 794ab282 e9070100 7faa3040 <419c0100> e8c70180 e8e90180 7ca851d2
> 
>  kernel:watchdog: CPU 88 self-detected hard LOCKUP @ update_cfs_group+0x30/0x150
> 
>  kernel:watchdog: CPU 88 TB:20328455213119, last heartbeat TB:20323303945487 (10061ms ago)
> 
> watchdog: CPU 88 became unstuck TB:20328505869807
> CPU: 88 PID: 0 Comm: swapper/88 Not tainted 4.17.0-rc5-next-20180517-autotest-autotest #1
> NIP:  c00000000000aeec LR: c000000000016644 CTR: c000000000022be0
> REGS: c000003ca9323b10 TRAP: 0901   Not tainted  (4.17.0-rc5-next-20180517-autotest-autotest)
> MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42004084  XER: 00000000
> CFAR: c000000000185fe4 SOFTE: 0
> GPR00: c00000000082b668 c000003ca9323d90 c000000001086c00 0000000000000900
> GPR04: b000000000001033 c000000000093f80 0000000000000001 0000000000000008
> GPR08: 0000000000000000 c000000000d86c84 0000000000000000 c000003ffbf27630
> GPR12: c000000000022be0 c000003fff74f880
> NIP [c00000000000aeec] replay_interrupt_return+0x0/0x4
> LR [c000000000016644] arch_local_irq_restore+0x74/0x90
> Call Trace:
> [c000003ca9323d90] [c00000000019a92c] tick_nohz_idle_stop_tick+0x17c/0x360 (unreliable)
> [c000003ca9323db0] [c00000000082b668] cpuidle_enter_state+0x108/0x3c0
> [c000003ca9323e10] [c000000000130104] call_cpuidle+0x44/0x80
> [c000003ca9323e30] [c000000000130698] do_idle+0x2f8/0x3a0
> [c000003ca9323ec0] [c000000000130910] cpu_startup_entry+0x30/0x40
> [c000003ca9323ef0] [c0000000000432a4] start_secondary+0x4d4/0x520
> [c000003ca9323f90] [c00000000000b270] start_secondary_prolog+0x10/0x14
> Instruction dump:
> 7d200026 618c8000 2c030900 4182e328 2c030500 4182dd40 2c030f00 4182f1e8
> 2c030a00 4182ff9c 2c030e60 4182edb8 <4e800020> 7c781b78 48000395 480003ad
> 
>  kernel:watchdog: CPU 88 became unstuck TB:20328505869807
> 
> watchdog: CPU 96 self-detected hard LOCKUP @ tick_nohz_next_event+0x38/0x200
> watchdog: CPU 96 TB:23470018682939, last heartbeat TB:23464816758804 (10160ms ago)
> Modules linked in: btrfs xor zstd_decompress zstd_compress xxhash
> lzo_compress raid6_pq dm_snapshot dm_bufio nvme bnx2x iptable_mangle
> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
> nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_filter dm_mirror
> dm_region_hash dm_log dm_service_time vmx_crypto powernv_rng rng_core
> dm_multipath kvm_hv kvm binfmt_misc nfsd ip_tables x_tables autofs4 xfs
> lpfc crc_t10dif crct10dif_generic nvme_fc nvme_fabrics mdio libcrc32c
> nvme_core crct10dif_common [last unloaded: nvme]
> CPU: 96 PID: 0 Comm: swapper/96 Not tainted 4.17.0-rc5-next-20180517-autotest-autotest #1
> NIP:  c000000000199df8 LR: c00000000019ad3c CTR: c00000000082d5a0
> REGS: c000003fff3cfd80 TRAP: 0900   Not tainted  (4.17.0-rc5-next-20180517-autotest-autotest)
> MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 22004084  XER: 00000000
> CFAR: c00000000019ad38 SOFTE: 1
> GPR00: c00000000019ad3c c000003ca9343d50 c000000001086c00 c000003ffc113880
> GPR04: 0000000000000060 0000000000000000 0000003ffb3a0000 c000000001196c00
> GPR08: c0000000010b3b00 c000000000d86c80 c0000000010b3b80 c000003ffc127630
> GPR12: c00000000082d5a0 c000003fff748f80 c000003ca9343f90 c0000000012f6020
> GPR16: c000003ffcc08cb0 c0000000000410b0 c0000000000410b0 c000000000d65260
> GPR20: 0000000000000001 c000000000fcf820 c000003ca9340000 c000003ca9340080
> GPR24: c000000000d862e8 0000000077359400 c000003ffc1260d8 c000000000fcf820
> GPR28: 0000000000000060 0000000000000060 c000003ffc113880 c000003ffc113880
> NIP [c000000000199df8] tick_nohz_next_event+0x38/0x200
> LR [c00000000019ad3c] tick_nohz_get_sleep_length+0xac/0x100
> Call Trace:
> [c000003ca9343d50] [c00000000019ad04] tick_nohz_get_sleep_length+0x74/0x100 (unreliable)
> [c000003ca9343d90] [c00000000082d668] menu_select+0xc8/0x7f0
> [c000003ca9343e10] [c00000000082b950] cpuidle_select+0x30/0x50
> [c000003ca9343e30] [c000000000130664] do_idle+0x2c4/0x3a0
> [c000003ca9343ec0] [c000000000130914] cpu_startup_entry+0x34/0x40
> [c000003ca9343ef0] [c0000000000432a4] start_secondary+0x4d4/0x520
> [c000003ca9343f90] [c00000000000b270] start_secondary_prolog+0x10/0x14
> Instruction dump:
> 7c0802a6 fb81ffe0 fbc1fff0 3ce20011 fba1ffe8 fbe1fff8 7c7e1b78 7c9c2378
> 3d420003 394acf80 3d020003 3908cf00 <38e7ff08> f8010010 f821ffb1 812a0000
> watchdog: CPU 96 became unstuck TB:23470021067039
> CPU: 96 PID: 0 Comm: swapper/96 Not tainted 4.17.0-rc5-next-20180517-autotest-autotest #1
> NIP:  c00000000000aeec LR: c000000000016644 CTR: c00000000082d5a0
> REGS: c000003ca9343ad0 TRAP: 0901   Not tainted  (4.17.0-rc5-next-20180517-autotest-autotest)
> MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42004024  XER: 20000000
> CFAR: c00000000000c1bc SOFTE: 0
> GPR00: c00000000082e4e8 c000003ca9343d50 c000000001086c00 0000000000000900
> GPR04: c000000000fcf820 0000000000000000 0000000000000001 0000000000000808
> GPR08: 0000000000000000 c000000000d86c80 c0000000010b3b80 c000003ffc127630
> GPR12: c00000000082d5a0 c000003fff748f80
> 
> NIP [c00000000000aeec] replay_interrupt_return+0x0/0x4
> LR [c000000000016644] arch_local_irq_restore+0x74/0x90
> Call Trace:
> [c000003ca9343d50] [c00000000019ad4c] tick_nohz_get_sleep_length+0xbc/0x100 (unreliable)
> [c000003ca9343d70] [c00000000082e4e8] snooze_loop+0x48/0x190
> [c000003ca9343db0] [c00000000082b618] cpuidle_enter_state+0xb8/0x3c0
> [c000003ca9343e10] [c000000000130104] call_cpuidle+0x44/0x80
> [c000003ca9343e30] [c000000000130698] do_idle+0x2f8/0x3a0
> ...
> [c000003ca9343ec0] [c000000000130914] cpu_startup_entry+0x34/0x40
> 
> [c000003ca9343ef0] [c0000000000432a4] start_secondary+0x4d4/0x520
>  kernel:watchdog[44665.478148] [c000003ca9343f90] [c00000000000b270] start_secondary_prolog+0x10/0x14
>  Instruction dump: CPU 96 self-det
>  7d200026 618c8000 2c030900 4182e328 2c030500 4182dd40 2c030f00 4182f1e8
> ted hard LOCKUP[44665.478356] 2c030a00 4182ff9c 2c030e60 4182edb8 <4e800020> 7c781b78 48000395 480003ad
>  @ tick_nohz_next_event+0x38/0x200
> 
>  kernel:watchdog: CPU 96 TB:23470018682939, last heartbeat TB:23464816758804 (10160ms ago
> 
