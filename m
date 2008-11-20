Return-Path: <ricardo.ribalda@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by ozlabs.org (Postfix) with ESMTP id A584ADDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 23:11:36 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so408266mue.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 04:11:33 -0800 (PST)
Message-ID: <aa76a2be0811200411m629b6a6bt31b3c9d7140b8c20@mail.gmail.com>
Date: Thu, 20 Nov 2008 13:11:32 +0100
From: Ricardo <ricardo.ribalda@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel completely crashes after accessing an unmapped area.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All:

 I am using the paulus tree popwerpc linux kernel for a ppc440 cpu
located in a Virtex5 FPGA.

 While developing some drivers (a simple gpio device) I have notice
that if I try to access an unmapped area (an address without any
register/device attached), the system completely crashes... I remember
that doing the same with a ppc400 cpu the system showed a
"Instruction/Data bus error" and continue working.

 My question: The ppc440 cannot recover from this types of errors or
is a kernel missing feature/bug?

               Thanks and Best regards


[   24.770976] Oops: Machine check, sig: 7 [#1]
[   24.773932] PREEMPT Xilinx Virtex440
[   24.777473] Modules linked in: spidev xilinx_spi spi_bitbang
[   24.783093] NIP: 00000000 LR: 10000858 CTR: c015ba80
[   24.788022] REGS: c3ffdf10 TRAP: 0202   Not tainted  (2.6.27)
[   24.793716] MSR: 00000000 <>  CR: 22000422  XER: 20000000
[   24.799077] TASK = c38d7000[2109] 'md.l' THREAD: c33ce000
[   24.804258] GPR00: a5a5a5a5 bf8bcb40 48026480 4801e000 10000858 22000424 480
[   24.812552] GPR08: 0002d000 4801e000 00000000 c33ce000 c33ce000 10018ea0 03f
[   24.820846] GPR16: dbfa3fff 00000000 00000000 00000000 00000000 00000000 100
[   24.829140] GPR24: 4800e454 bf8bce00 00000002 bf8bce14 00000000 4802cce0 0ff
[   24.837614] NIP [00000000] 0x0
[   24.840634] LR [10000858] 0x10000858
[   24.844174] Call Trace:
[   24.846594] Instruction dump:
[   24.849532] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   24.857220] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   24.864915] ---[ end trace 90dba81f5381e59d ]---
[   24.869505] Oops: Machine check, sig: 7 [#2]
[   24.873722] PREEMPT Xilinx Virtex440
[   24.877265] Modules linked in: spidev xilinx_spi spi_bitbang
[   24.882883] NIP: 00000000 LR: c000da24 CTR: 00018486
[   24.887812] REGS: c3ffdf10 TRAP: 0202   Tainted: G      D    (2.6.27)
[   24.894199] MSR: 00000000 <>  CR: 44040428  XER: 00000000
[   24.899559] TASK = c38d7000[2109] 'md.l' THREAD: c33ce000
[   24.904740] GPR00: 08000000 c3ffdd00 c38d7000 c3ffdd10 00000001 00000000 000
[   24.913035] GPR08: 00000034 c000da24 00021002 c000a150 c38d7208 10018ea0 03f
[   24.921329] GPR16: dbfa3fff 00000000 00000000 00000000 00000000 00000000 100
[   24.929624] GPR24: c3ffc034 00000001 c030a798 c030a7a4 c3ffc000 c030a89c c02
[   24.938093] NIP [00000000] 0x0
[   24.941133] LR [c000da24] ret_from_except+0x0/0x18
[   24.945866] Call Trace:
[   24.948286] Instruction dump:
[   24.951223] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   24.958913] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   24.966604] ---[ end trace 90dba81f5381e59d ]---
[   24.971183] Fixing recursive fault but reboot is needed!
[   24.976476] Oops: Machine check, sig: 7 [#3]
[   24.980685] PREEMPT Xilinx Virtex440
[   24.984228] Modules linked in: spidev xilinx_spi spi_bitbang
[   24.989847] NIP: 00000000 LR: c000da24 CTR: c0029e78
[   24.994775] REGS: c3ffdf10 TRAP: 0202   Tainted: G      D    (2.6.27)
[   25.001163] MSR: 00000000 <>  CR: 442f2082  XER: 00000000
[   25.006523] TASK = c3822400[3] 'ksoftirqd/0' THREAD: c382c000
[   25.012049] GPR00: 00000000 c382de80 c3822400 c382de90 c38d7000 c0302c70 000
[   25.020344] GPR08: 00000098 c000da24 00021002 c0003ee4 c3822608 8fdd0dff c03
[   25.028638] GPR16: c0302c40 c3822558 c382c034 c02e0000 c0302c40 c0300000 c03
[   25.036933] GPR24: c0040000 c02e506c c3285ba0 c382c000 c02e24b0 00000002 c38
[   25.045401] NIP [00000000] 0x0
[   25.048430] LR [c000da24] ret_from_except+0x0/0x18
[   25.053175] Call Trace:
[   25.055599] [c382de80] [c3822400] 0xc3822400 (unreliable)
[   25.060967] [c382df40] [c0006310] __switch_to+0x54/0x78
[   25.066146] [c382df60] [c02450c0] schedule+0x194/0x3ac
[   25.071243] [c382dfb0] [c0033098] ksoftirqd+0x108/0x194
[   25.076436] [c382dfd0] [c0045504] kthread+0x48/0x84
[   25.081264] [c382dff0] [c000d1a0] kernel_thread+0x4c/0x68
[   25.086612] Instruction dump:
[   25.089549] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.097239] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.104931] ---[ end trace 90dba81f5381e59d ]---
[   25.109512] note: ksoftirqd/0[3] exited with preempt_count 2
[   25.115136] Oops: Machine check, sig: 7 [#4]
[   25.119357] PREEMPT Xilinx Virtex440
[   25.122900] Modules linked in: spidev xilinx_spi spi_bitbang
[   25.128519] NIP: 00000000 LR: c000da24 CTR: 00018486
[   25.133447] REGS: c3ffdf10 TRAP: 0202   Tainted: G      D    (2.6.27)
[   25.139835] MSR: 00000000 <>  CR: 44242022  XER: 20000000
[   25.145194] TASK = c3822400[3] 'ksoftirqd/0' THREAD: c382c000
[   25.150721] GPR00: c003077c c3ffddc0 c3822400 c3ffddd0 00000000 00000000 000
[   25.159016] GPR08: 00000036 c000da24 00021002 c0003ee4 c3822608 8fdd0dff c03
[   25.167310] GPR16: c0302c40 c3822558 c382c034 c02e0000 c0302c40 c0300000 c03
[   25.175605] GPR24: c38224e0 c38224f4 c3822c00 c3ffdf10 c3ffc000 c38224e0 c38
[   25.184073] NIP [00000000] 0x0
[   25.187102] LR [c000da24] ret_from_except+0x0/0x18
[   25.191847] Call Trace:
[   25.194266] Instruction dump:
[   25.197204] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.204893] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.212585] ---[ end trace 90dba81f5381e59d ]---
[   25.217164] Fixing recursive fault but reboot is needed!
[   25.222437] BUG: scheduling while atomic: ksoftirqd/0/3/0x00000003
[   25.228567] Modules linked in: spidev xilinx_spi spi_bitbang
[   25.234184] Call Trace:
[   25.236610] Oops: Machine check, sig: 7 [#5]
[   25.240836] PREEMPT Xilinx Virtex440
[   25.244378] Modules linked in: spidev xilinx_spi spi_bitbang
[   25.249997] NIP: 00000000 LR: c000da24 CTR: c0029e78
[   25.254925] REGS: c3ffdf10 TRAP: 0202   Tainted: G      D    (2.6.27)
[   25.261313] MSR: 00000000 <>  CR: 442f2022  XER: 00000000
[   25.266673] TASK = c3822000[4] 'events/0' THREAD: c382e000
[   25.271940] GPR00: 00000000 c382fe60 c3822000 c382fe70 c3822400 c0302c70 000
[   25.280235] GPR08: 00000131 c000da24 00021002 c0003ee4 c3822208 8fdd0dff c03
[   25.288529] GPR16: c0302c40 c3822158 c382e034 c02e0000 c0302c40 c0300000 c03
[   25.296824] GPR24: c0040000 c02e506c c3285ba0 c382e000 c3842000 00000002 c38
[   25.305293] NIP [00000000] 0x0
[   25.308321] LR [c000da24] ret_from_except+0x0/0x18
[   25.313066] Call Trace:
[   25.315509] [c382fe60] [c016374c] n_tty_receive_buf+0x2b8/0xf68 (unreliable)
[   25.322492] [c382ff20] [c0006310] __switch_to+0x54/0x78
[   25.327674] [c382ff40] [c02450c0] schedule+0x194/0x3ac
[   25.332774] [c382ff90] [c0041684] worker_thread+0x9c/0xd0
[   25.338130] [c382ffd0] [c0045504] kthread+0x48/0x84
[   25.342968] [c382fff0] [c000d1a0] kernel_thread+0x4c/0x68
[   25.348318] Instruction dump:
[   25.351255] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.358945] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.366636] ---[ end trace 90dba81f5381e59d ]---
[   25.371217] note: events/0[4] exited with preempt_count 2
[   25.376577] Oops: Machine check, sig: 7 [#6]
[   25.380804] PREEMPT Xilinx Virtex440
[   25.384346] Modules linked in: spidev xilinx_spi spi_bitbang
[   25.389965] NIP: 00000000 LR: c000da24 CTR: 00018486
[   25.394893] REGS: c3ffdf10 TRAP: 0202   Tainted: G      D    (2.6.27)
[   25.401281] MSR: 00000000 <>  CR: 44242022  XER: 20000000
[   25.406641] TASK = c3822000[4] 'events/0' THREAD: c382e000
[   25.411908] GPR00: c003077c c3ffddc0 c3822000 c3ffddd0 00000000 00000000 000
[   25.420203] GPR08: 00000036 c000da24 00021002 c0003ee4 c3822208 8fdd0dff c03
[   25.428497] GPR16: c0302c40 c3822158 c382e034 c02e0000 c0302c40 c0300000 c03
[   25.436792] GPR24: c38220e0 c38220f4 c3822c00 c3ffdf10 c3ffc000 c38220e0 c38
[   25.445261] NIP [00000000] 0x0
[   25.448289] LR [c000da24] ret_from_except+0x0/0x18
[   25.453034] Call Trace:
[   25.455454] Instruction dump:
[   25.458391] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.466081] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.473772] ---[ end trace 90dba81f5381e59d ]---
[   25.478351] Fixing recursive fault but reboot is needed!
[   25.483623] BUG: scheduling while atomic: events/0/4/0x00000003
[   25.489495] Modules linked in: spidev xilinx_spi spi_bitbang
[   25.495111] Call Trace:
[   25.497540] Oops: Machine check, sig: 7 [#7]
[   25.501764] PREEMPT Xilinx Virtex440
[   25.505306] Modules linked in: spidev xilinx_spi spi_bitbang
[   25.510925] NIP: 00000000 LR: c000da24 CTR: c0026934
[   25.515853] REGS: c3ffdf10 TRAP: 0202   Tainted: G      D    (2.6.27)
[   25.522241] MSR: 00000000 <>  CR: 442f2022  XER: 00000000
[   25.527601] TASK = c02e24b0[0] 'swapper' THREAD: c02fa000
[   25.532782] GPR00: 00000000 c02fbe50 c02e24b0 c02fbe60 c3822000 c3822030 000
[   25.541077] GPR08: 00000000 c000da24 00021002 c0003ee4 c02e26b8 8fdd0dff c03
[   25.549371] GPR16: c0302c40 c02e2608 c02fa034 00000000 c0302c40 c0300000 c03
[   25.557665] GPR24: 00000000 03ff8ca4 c3285ba0 c02fa000 c3822000 00000002 c38
[   25.566134] NIP [00000000] 0x0
[   25.569163] LR [c000da24] ret_from_except+0x0/0x18
[   25.573908] Call Trace:
[   25.576334] [c02fbe50] [c003327c] __do_softirq+0x78/0xe4 (unreliable)
[   25.582728] [c02fbf10] [c0006310] __switch_to+0x54/0x78
[   25.587911] [c02fbf30] [c02450c0] schedule+0x194/0x3ac
[   25.593011] [c02fbf80] [c0006cac] cpu_idle+0xcc/0xe8
[   25.597940] [c02fbfa0] [c0247474] __got2_end+0x7c/0x90
[   25.603036] [c02fbfc0] [c02bc804] start_kernel+0x238/0x2b8
[   25.608475] [c02fbff0] [c00001e8] skpinv+0x190/0x1cc
[   25.613393] Instruction dump:
[   25.616330] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.624020] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[   25.631712] ---[ end trace 90dba81f5381e59d ]---
[   25.636293] Kernel panic - not syncing: Attempted to kill the idle task!
[   25.642945] Rebooting in 180 seconds..Oops: Exception in kernel mode, sig: 1]
[  205.666054] PREEMPT Xilinx Virtex440
[  205.669593] Modules linked in: spidev xilinx_spi spi_bitbang
[  205.675213] NIP: fffffffc LR: c000c0d8 CTR: c001593c
[  205.680144] REGS: c3ffdd60 TRAP: 0700   Tainted: G      D    (2.6.27)
[  205.686528] MSR: 00000000 <>  CR: 222f2088  XER: 20000000
[  205.691887] TASK = c02e24b0[0] 'swapper' THREAD: c02fa000
[  205.697069] GPR00: 30000000 c3ffde10 c02e24b0 00000000 0000002e 00000029 c01
[  205.705363] GPR08: 00000030 c0300000 0000462d c0300000 842f2042 8fdd0dff c03
[  205.713658] GPR16: c0302c40 c02e2608 c02fa034 00000000 c0302c40 c0300000 c03
[  205.721952] GPR24: 00000000 03ff8ca4 00000007 c3ffdf10 0002bf20 00000001 c03
[  205.730426] NIP [fffffffc] 0xfffffffc
[  205.734058] LR [c000c0d8] machine_restart+0x34/0x48
[  205.738886] Call Trace:
[  205.741306] Instruction dump:
[  205.744244] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[  205.751932] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[  205.759627] ---[ end trace 90dba81f5381e59d ]---
[  205.764206] Kernel panic - not syncing: Attempted to kill the idle task!
[  205.770857] Rebooting in 180 seconds..Oops: Exception in kernel mode, sig: 1]
[  385.793958] PREEMPT Xilinx Virtex440
[  385.797497] Modules linked in: spidev xilinx_spi spi_bitbang
[  385.803117] NIP: fffffffc LR: c000c0d8 CTR: c001593c
[  385.808048] REGS: c3ffdae0 TRAP: 0700   Tainted: G      D    (2.6.27)
[  385.814432] MSR: 00000000 <>  CR: 222f2088  XER: 20000000
[  385.819791] TASK = c02e24b0[0] 'swapper' THREAD: c02fa000
[  385.824973] GPR00: 30000000 c3ffdb90 c02e24b0 00000000 0000002e 00000029 c01
[  385.833267] GPR08: 00000030 c0300000 00004b67 c0300000 842f2042 8fdd0dff c03
[  385.841561] GPR16: c0302c40 c02e2608 c02fa034 00000000 c0302c40 c0300000 c03
[  385.849856] GPR24: 00000000 03ff8ca4 0000000b c3ffdd60 0002bf20 00000001 c03
[  385.858330] NIP [fffffffc] 0xfffffffc
[  385.861960] LR [c000c0d8] machine_restart+0x34/0x48
[  385.866790] Call Trace:
[  385.869209] Instruction dump:
[  385.872148] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[  385.879836] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X
[  385.887531] ---[ end trace 90dba81f5381e59d ]---
[  385.892109] Kernel panic - not syncing: Attempted to kill the idle task!
[  385.898761] Rebooting in 180 seconds..Oops: Exception in kernel mode, sig: 1]

-- 
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
