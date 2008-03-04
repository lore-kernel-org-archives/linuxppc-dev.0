Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 5CCA7DDEF1
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 01:39:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: locking problem in sata_sil24?
Date: Tue, 4 Mar 2008 08:39:57 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0410A6BA@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

linuxppc-dev-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
> Now I get an "inconsistent locking state", but I need help in
> trying to
> fiure out what I should look for.

I did figure out htat lockdep only complains about inonsistent locking
state when PREEMPT_RT paches are applied.
Now I just need some help interpreting this output so I can find what
lock and why it is inconsitent.
I _really_ want to run the rt patches...

>=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [ INFO: inconsistent lock state ]
> [ 2.6.24-rt1 #12
> ---------------------------------
> inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>  (&host->lock){+-..}, at: [<c01c8e14>] sil24_interrupt+0x68/0x53c
> {hardirq-on-W} state was registered at:
>   [<c0047724>] __lock_acquire+0x494/0xc04
>   [<c0047ee8>] lock_acquire+0x54/0x78
>   [<c025c8f0>] rt_spin_lock+0x34/0x54
>   [<c01b45ac>] ata_dev_init+0x38/0x88
>   [<c01b467c>] ata_link_init+0x80/0xa4
>   [<c01b4840>] ata_port_alloc+0x1a0/0x1bc
>   [<c01b48f4>] ata_host_alloc+0x98/0xf8
>   [<c01b4974>] ata_host_alloc_pinfo+0x20/0x104
>   [<c01c83b4>] sil24_init_one+0x128/0x390
>   [<c01802f0>] pci_device_probe+0x70/0xa8
>   [<c0197d10>] driver_probe_device+0x104/0x1ac
>   [<c0197e0c>] __driver_attach+0x54/0x8c
>   [<c0197030>] bus_for_each_dev+0x58/0xa0
>   [<c0197adc>] driver_attach+0x2c/0x44
>   [<c0197778>] bus_add_driver+0xb4/0x1b8
>   [<c01980b8>] driver_register+0x7c/0x114
>   [<c01803bc>] __pci_register_driver+0x60/0x78
>   [<c031e620>] sil24_init+0x2c/0x44
>   [<c030a2c8>] kernel_init+0xdc/0x334
>   [<c0010408>] kernel_thread+0x44/0x60
> irq event stamp: 16174
> hardirqs last  enabled at (16173): [<c0046d18>]
> trace_hardirqs_on+0x1c/0x34
> hardirqs last disabled at (16174): [<c0045554>]
> trace_hardirqs_off+0x1c/0x34
> softirqs last  enabled at (0): [<00000000>] 0x0
> softirqs last disabled at (0): [<00000000>] 0x0
>=20
> other info that might help us debug this:
> no locks held by swapper/0.
>=20
> stack backtrace:
> Call Trace:
> [c0357ca0] [c0008474] show_stack+0x54/0x18c (unreliable)
> [c0357cd0] [c00085cc] dump_stack+0x20/0x38
> [c0357ce0] [c00460a0] print_usage_bug+0x130/0x14c
> [c0357d10] [c0046674] mark_lock+0xf0/0x4ec
> [c0357d30] [c004769c] __lock_acquire+0x40c/0xc04
> [c0357d80] [c0047ee8] lock_acquire+0x54/0x78
> [c0357da0] [c025c8f0] rt_spin_lock+0x34/0x54
> [c0357dc0] [c01c8e14] sil24_interrupt+0x68/0x53c
> [c0357e00] [c00529e0] handle_IRQ_event+0x6c/0x114
> [c0357e30] [c0052bcc] __do_IRQ+0x144/0x1c4
> [c0357e50] [c0017d88] apmax_int_irq_demux+0x90/0xb8
> [c0357e70] [c00063f0] do_IRQ+0x6c/0xb0
> [c0357e80] [c0010cfc] ret_from_except+0x0/0x28
> --- Exception: 501 at check_critical_timing+0x184/0x190
>     LR =3D check_critical_timing+0x15c/0x190
> [c0357f80] [c00519a4] touch_critical_timing+0x5c/0xb0
> [c0357fa0] [c00096c4] cpu_idle+0xe4/0x124
> [c0357fb0] [c0003bcc] rest_init+0x78/0xac
> [c0357fc0] [c030ab9c] start_kernel+0x2c4/0x2dc
> [c0357ff0] [00003438] 0x3438


> ------------[ cut here ]------------
> kernel BUG at kernel/rtmutex.c:692!
> Oops: Exception in kernel mode, sig: 5 [#1]
> PREEMPT Innovative Systems ApMax
> Modules linked in:
> NIP: c025c340 LR: c025c318 CTR: c01c8dac
> REGS: ef859ad0 TRAP: 0700   Not tainted  (2.6.24-rt1)
> MSR: 00021032 <ME,IR,DR>  CR: 28004042  XER: 20000000
> TASK =3D ef852090[8] 'softirq-block/0' THREAD: ef858000
> GPR00: 00000001 ef859b80 ef852090 00000000 00000000 00000000 00000000
> 00000002 GPR08: 00000001 ef852090 ef852090 ef859b80 00000000 ffffffff
> 0fffd000 00000028 GPR16: 00800564 00800000 00000000 007fff00 00000000
> 00000001 ef8bc000 ef3ac2f0 GPR24: 00000011 00000000 00000000 ef3f77e0
> ef858000 00001032 ef3ac2f0 ef859b80 NIP [c025c340]
> rt_spin_lock_slowlock+0x7c/0x1c0=20
> LR [c025c318] rt_spin_lock_slowlock+0x54/0x1c0
> Call Trace:
> [ef859b80] [c025c318] rt_spin_lock_slowlock+0x54/0x1c0 (unreliable)
> [ef859be0] [c025c78c] __rt_spin_lock+0x80/0x98
> [ef859bf0] [c025c8f8] rt_spin_lock+0x3c/0x54
> [ef859c10] [c01c8e14] sil24_interrupt+0x68/0x53c
> [ef859c50] [c00529e0] handle_IRQ_event+0x6c/0x114
> [ef859c80] [c0052bcc] __do_IRQ+0x144/0x1c4
> [ef859ca0] [c0017d88] apmax_int_irq_demux+0x90/0xb8
> [ef859cc0] [c00063f0] do_IRQ+0x6c/0xb0
> [ef859cd0] [c0010cfc] ret_from_except+0x0/0x28
> --- Exception: 501 at ata_qc_issue+0x140/0x684
>     LR =3D ata_scsi_translate+0x138/0x184
> [ef859d90] [ef385960] 0xef385960 (unreliable)
> [ef859dd0] [c01bd7a0] ata_scsi_translate+0x138/0x184
> [ef859e00] [c01c0d0c] ata_scsi_queuecmd+0x210/0x240
> [ef859e20] [c01a46d4] scsi_dispatch_cmd+0x1d0/0x240
> [ef859e40] [c01aaecc] scsi_request_fn+0x274/0x340
> [ef859e60] [c0160b9c] blk_run_queue+0x68/0xac
> [ef859e80] [c01a8ee0] scsi_run_queue+0x1cc/0x1e4
> [ef859eb0] [c01a9678] scsi_next_command+0x3c/0x5c
> [ef859ed0] [c01a987c] scsi_end_request+0xd4/0xf4
> [ef859ef0] [c01a9c30] scsi_io_completion+0xf4/0x320
> [ef859f30] [c01a3f78] scsi_finish_command+0x94/0xac
> [ef859f50] [c01aa5d4] scsi_softirq_done+0xd4/0xec
> [ef859f70] [c015c83c] blk_done_softirq+0x8c/0xbc
> [ef859f90] [c0026008] ksoftirqd+0x168/0x27c
> [ef859fd0] [c00386d0] kthread+0x50/0x90
> [ef859ff0] [c0010408] kernel_thread+0x44/0x60
> Instruction dump:
> 7fc3f378 4bdefce9 2f830000 41be0010 7fc3f378 7fa4eb78 48000140
> 801e002c 5400003a 7c001278 7c000034 5400d97e <0f000000> 38000004
> 901f0008 801f0008 Kernel panic - not syncing: Fatal exception in
> interrupt=20
> Call Trace:
> [ef8598f0] [c0008474] show_stack+0x54/0x18c (unreliable)
> [ef859920] [c00085cc] dump_stack+0x20/0x38
> [ef859930] [c001f198] panic+0x94/0x178
> [ef859980] [c000e4d0] die+0x178/0x184
> [ef8599a0] [c000e6d8] _exception+0x5c/0x17c
> [ef859a90] [c000eadc] program_check_exception+0x154/0x504
> [ef859ac0] [c0010cb0] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at rt_spin_lock_slowlock+0x7c/0x1c0
>     LR =3D rt_spin_lock_slowlock+0x54/0x1c0
> [ef859be0] [c025c78c] __rt_spin_lock+0x80/0x98
> [ef859bf0] [c025c8f8] rt_spin_lock+0x3c/0x54
> [ef859c10] [c01c8e14] sil24_interrupt+0x68/0x53c
> [ef859c50] [c00529e0] handle_IRQ_event+0x6c/0x114
> [ef859c80] [c0052bcc] __do_IRQ+0x144/0x1c4
> [ef859ca0] [c0017d88] apmax_int_irq_demux+0x90/0xb8
> [ef859cc0] [c00063f0] do_IRQ+0x6c/0xb0
> [ef859cd0] [c0010cfc] ret_from_except+0x0/0x28
> --- Exception: 501 at ata_qc_issue+0x140/0x684
>     LR =3D ata_scsi_translate+0x138/0x184
> [ef859d90] [ef385960] 0xef385960 (unreliable)
> [ef859dd0] [c01bd7a0] ata_scsi_translate+0x138/0x184
> [ef859e00] [c01c0d0c] ata_scsi_queuecmd+0x210/0x240
> [ef859e20] [c01a46d4] scsi_dispatch_cmd+0x1d0/0x240
> [ef859e40] [c01aaecc] scsi_request_fn+0x274/0x340
> [ef859e60] [c0160b9c] blk_run_queue+0x68/0xac
> [ef859e80] [c01a8ee0] scsi_run_queue+0x1cc/0x1e4
> [ef859eb0] [c01a9678] scsi_next_command+0x3c/0x5c
> [ef859ed0] [c01a987c] scsi_end_request+0xd4/0xf4
> [ef859ef0] [c01a9c30] scsi_io_completion+0xf4/0x320
> [ef859f30] [c01a3f78] scsi_finish_command+0x94/0xac
> [ef859f50] [c01aa5d4] scsi_softirq_done+0xd4/0xec
> [ef859f70] [c015c83c] blk_done_softirq+0x8c/0xbc
> [ef859f90] [c0026008] ksoftirqd+0x168/0x27c
> [ef859fd0] [c00386d0] kthread+0x50/0x90
> [ef859ff0] [c0010408] kernel_thread+0x44/0x60
> Rebooting in 180 seconds..
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
