Date: Thu, 25 Mar 2004 20:13:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Mode Software Emulation NIP: 00001FFC - cache coherency problem on m8xx processors
Message-ID: <20040325231357.GA22460@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We encountered a problem with our MPC855T based appliances under heavy
load. The crashes looked like this:

Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: 00001FFC XER: 20000000 LR: 00000590 SP: C0D99DC0 REGS: c0d99d10 TRAP:1000    Not tainted
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0d98000[115] 'webs' Last syscall: 102
last math 00000000 last altivec 00000000
GPR00: 00000001 C0D99DC0 C0D98000 C0D99DD0 00000000 00000001 000005A8
00000000
GPR08: C59ED4F0 00000000 00000000 00000002 00000000 1007335C 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 00D99DC0 C00CFFFC
00009032
GPR24: C00027C0 10049C90 00000000 00000002 000005A8 C653D000 C59ED630
C653D0D8
Call backtrace:
C00E2470 C00CFFBC C00C4610 C00E25A4 C00A2A00 C00A3024 C000281C
00000001 100330A4 10033B1C 10041F40 10029418 1002E530 1003FA7C
1003F240 1003F140 1003485C 100346A4 1000234C 0FBE7FDC 00000000


The kernel crashed trying to execute address "00001FFC". I have seen similar
reports on linux PPC lists archives. The problem is that "bl transfer_to_handler"
(transfer_to_handler is at "2000") was jumping to "1FFC" instead, in some rare ocasions
(only under heavy network/memory activity).

After thinking for a while and talking to Dan Malek, it seems "isync" instructions before
"bl transfer_to_handler" are required to avoid cache coherency problems.

I'm not exactly sure why we were jumping to "1FFC" instead of "2000",
but adding "isync" before "bl transfer_to_handler" in both DecrementTimer
and HardwareInterrupt fixed the problem for us.

On the following patch against 2.4.25 I also add "isync" to FINISH_EXCEPTION define, for safety.

The performance impact of this is hardly noticeable.

It seems Dan is OK including this into linuxppc-2.4 repository. We also want
to add this to 2.6 when the m8xx support gets fixed.

Regards,

--- head_8xx.S.orig     2004-03-25 18:30:49.323575664 -0300
+++ head_8xx.S  2004-03-25 18:32:00.464760560 -0300
@@ -172,6 +172,7 @@
  */

 #define FINISH_EXCEPTION(func)                 \
+       isync;                                  \
        bl      transfer_to_handler;            \
        .long   func;                           \
        .long   ret_from_except
@@ -228,6 +229,7 @@
        addi    r3,r1,STACK_FRAME_OVERHEAD
        li      r20,MSR_KERNEL
        li      r4,0
+       isync
        bl      transfer_to_handler
        .globl  do_IRQ_intercept
 do_IRQ_intercept:
@@ -265,6 +267,7 @@
        EXCEPTION_PROLOG
        addi    r3,r1,STACK_FRAME_OVERHEAD
        li      r20,MSR_KERNEL
+       isync
        bl      transfer_to_handler
        .globl  timer_interrupt_intercept
 timer_interrupt_intercept:


----- End forwarded message -----

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
