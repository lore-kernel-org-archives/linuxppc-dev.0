Message-ID: <A109131318C4D1119AC20060088DECE330F493@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Software Emulation Kernel Panic--specific information
Date: Wed, 21 Jun 2000 12:26:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings!

When we have our Kernel Mode Software FPU Emulation panic, we get the
following information.

The NIP, LR, and TRAP always seem to be set to the same values (others
vary). I assume those values are physical addresses.

If so, from System.map, the NIP seems to be between c0001f00 t Trap_1f and
c0002000 T transfer_to_handler.
The LR seems to be between c0000900 t Decrementer and c0000a00 t Trap_0a.
The TRAP is set to our Software Emulation trap, c0001000 t SoftEmu.

I can't make sense of this, since I don't fully understand what the
relationship of NIP and LR are.  Does the LR address refer to the return
address after the exception? Does this mean the exception happened in the
Decrementer timer interrupt? Why is the NIP set to a value between Trap_1f
and transfer_to_handler?

I need your expertise!

NIP: 00001FFC XER: 8000FF7F LR: 00000988 REGS: c0e87c90 TRAP: 1000
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0e86000[7] 'rc.sysinit' mm->pgd c0e8b000 Last syscall: 67
last math 00000000
GPR00: 00000000 C0E87D40 C0E86000 C0E87D50 0189EE34 C0133404 C0E88278
C0E8B000
GPR08: C00DA634 00FBA9E1 00FBA9E1 00FBA9E1 3555F593 018A31D0 00000000
00000D08
GPR16: 000000C1 01005000 0100A400 00300008 00001032 00E87D40 C00162F0
00009032
GPR24: 0189EE34 C0E88278 C0615760 00FBA8A1 C0FBA000 C0E86000 C0F5F000
C0132510
Call backtrace:
C0E87DF0 C0016204 C0016A98 C0009098 C0002544 018A4490 300E88A4
0180C6D4 0180C5D8 01803250 01802B64 01801D80
Instruction DUMP:

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
