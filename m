Return-Path: <linux-ppc@castalie.org>
Received: from tloen.castalie.org (tloen.castalie.org [213.41.240.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FACADDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 05:14:31 +1000 (EST)
Received: from mlejnas.priv.castalie.org ([192.168.12.8])
	by tloen.castalie.org with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.63)
	(envelope-from <linux-ppc@castalie.org>) id 1IAVke-0001cr-56
	for linuxppc-dev@ozlabs.org; Mon, 16 Jul 2007 20:56:56 +0200
Date: Mon, 16 Jul 2007 20:56:53 +0200
From: Simon Vallet <linux-ppc@castalie.org>
To: linuxppc-dev@ozlabs.org
Subject: Help needed interpreting weird kOops
Message-ID: <20070716205653.2e925a0b@mlejnas.priv.castalie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

still working on mapping a Mach-O driver to ELF, I'm seeing a weird
kOops when insmod'ing the driver :

Jul 16 20:16:07 tertius kernel: Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
Jul 16 20:16:07 tertius kernel: PREEMPT 
Jul 16 20:16:07 tertius kernel: Modules linked in: unicorn_pci_atm(P)
Jul 16 20:16:07 tertius kernel: NIP: F661CD6C LR: F661CD5C CTR: 000000D0
Jul 16 20:16:07 tertius kernel: REGS: ee86db70 TRAP: 0801   Tainted: P       (2.6.20-rc3-sjv1-gc6b33cc4-dirty)
Jul 16 20:16:07 tertius kernel: MSR: 00009032 <EE,ME,IR,DR>  CR: 24004288  XER: 00000000
Jul 16 20:16:07 tertius kernel: TASK = effcd790[1397] 'insmod' THREAD: ee86c000
Jul 16 20:16:07 tertius kernel: GPR00: F661CD5C EE86DC20 EFFCD790 00000008 F66885B0 00000104 EE9D3D60 EE9D269C 
Jul 16 20:16:07 tertius kernel: GPR08: EE9D23B4 F6684B38 000000D0 EE86C000 F664D9CC 
Jul 16 20:16:07 tertius kernel: NIP [F661CD6C] _ZN19InterruptDispatcher5resetEv+0x3c/0xb4 [unicorn_pci_atm]
Jul 16 20:16:07 tertius kernel: LR [F661CD5C] _ZN19InterruptDispatcher5resetEv+0x2c/0xb4 [unicorn_pci_atm]
Jul 16 20:16:07 tertius kernel: Call Trace:
Jul 16 20:16:07 tertius kernel: [EE86DC20] [F661CD5C] _ZN19InterruptDispatcher5resetEv+0x2c/0xb4 [unicorn_pci_atm] (unreliable)
Jul 16 20:16:07 tertius kernel: [EE86DC70] [10019678] 0x10019678
Jul 16 20:16:07 tertius kernel: [EE86DCC0] [F66C0000] fineGainConversionTable.728+0x664/0xfffc2294 [unicorn_pci_atm]
Jul 16 20:16:07 tertius kernel: [EE86DD30] [F6623444] _ZN17ModemSubsystemItfC1EmPtm+0x44/0xd8 [unicorn_pci_atm]
Jul 16 20:16:07 tertius kernel: [EE86DD90] [F65EEDA8] AMSW_Modem_SW_Init+0x110/0x1f8 [unicorn_pci_atm]
Jul 16 20:16:07 tertius kernel: [EE86DE00] [C002B16C] printk+0x50/0x60
Jul 16 20:16:07 tertius kernel: [EE86DE40] [F105252C] unicorn_pci_init+0x52c/0xb08 [unicorn_pci_atm]
Jul 16 20:16:07 tertius kernel: [EE86DE90] [C004E340] sys_init_module+0x16c/0x1610
Jul 16 20:16:07 tertius kernel: [EE86DF40] [C00112B0] ret_from_syscall+0x0/0x38
Jul 16 20:16:07 tertius kernel: --- Exception: c01 at 0xff6cfc8
Jul 16 20:16:07 tertius kernel:     LR = 0x10000e54
Jul 16 20:16:07 tertius kernel: Instruction dump:
Jul 16 20:16:07 tertius kernel: 9421ffb0 7c7f1b78 3c60f669 38630948 48000089 7fe3fb78 48000071 4800005d 
Jul 16 20:16:07 tertius kernel: 394000d0 3d20f668 7d4903a6 39294b38 <c8090000> 39600000 38000004 917f0008

Having learned more PPC assembly than I probably wished, I checked
 the code until _ZN17ModemSubsystemItfC1EmPtm+0x44, which disassembles 
to this (arg addresses are relative to the beginning of .text/0xf65c4000):

0xf6623440: 48 00 00 89     bl      0x5f4c8    [ branch island, un-optimized from JBSR ]
0xf6623444: 80 61 00 38     l       r3,56(r1)
[...]

[ this is the branch island ]
0xf66234c8: 3d 80 f6 64     liu     r12,0xf664
0xf66234cc: 61 8c e1 54     oril    r12,r12,0xe154
0xf66234d0: 7d 89 03 a6     mtctr   r12

mtctr branches to a memory-allocation function which does seem to behave
correctly (it is called multiple times before that). But somehow from
this point everything seems corrupted: the stack trace seems to show a 
jump into the .data section (fineGainConversionTable), which could be explained
by a bad relocation, but I didn't see any obvious problems on this side.

So I have to assume that the stack is somehow corrupted, but I can't explain
how this happens, at least in this portion of code. Any hint ?


Simon
