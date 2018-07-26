Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsgQ0hQgzF0q0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:01:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH] powerpc/64s: Make unrecoverable SLB miss less confusing
Date: Thu, 26 Jul 2018 23:01:51 +1000
Message-Id: <20180726130151.16410-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we take an SLB miss while MSR[RI]=0 we can't recover and have to
oops. Currently this is reported by faking up a 0x4100 exception, eg:

  Unrecoverable exception 4100 at 0
  Oops: Unrecoverable exception, sig: 6 [#1]
  ...
  CPU: 0 PID: 1262 Comm: sh Not tainted 4.18.0-rc3-gcc-7.3.1-00098-g7fc2229fb2ab-dirty #9
  NIP:  0000000000000000 LR: c00000000000b9e4 CTR: 00007fff8bb971b0
  REGS: c0000000ee02bbb0 TRAP: 4100
  ...
  LR [c00000000000b9e4] system_call+0x5c/0x70

The 0x4100 value was chosen back in 2004 as part of the fix for the
"mega bug" - "ppc64: Fix SLB reload bug". Back then it was obvious
that 0x4100 was not a real trap value, as the highest actual trap was
less than 0x2000.

Since then however the architecture has changed and now we have
"virtual mode" or "relon" exceptions, in which exceptions can be
delivered with the MMU on starting at 0x4000.

At a glance 0x4100 looks like a virtual mode 0x100 exception, aka
system reset exception. A close reading of the architecture will show
that system reset exceptions can't be delivered in virtual mode, and
so 0x4100 is not a valid trap number. But that's not immediately
obvious. There's also nothing about 0x4100 that suggests SLB miss.

So to make things a bit less confusing switch to a fake but unique and
hopefully more helpful numbering. For data SLB misses we report a
0x390 trap and for instruction we report 0x490. Compared to 0x380 and
0x480 for the actual data & instruction SLB exceptions.

Also add a C handler that prints a more explicit message. The end
result is something like:

  Oops: Unrecoverable SLB miss (MSR[RI]=0), sig: 6 [#3]
  ...
  CPU: 0 PID: 1262 Comm: sh Not tainted 4.18.0-rc3-gcc-7.3.1-00098-g7fc2229fb2ab-dirty #9
  NIP:  0000000000000000 LR: c00000000000b9e4 CTR: 0000000000000000
  REGS: c0000000f19a3bb0 TRAP: 0490
  ...
  LR [c00000000000b9e4] system_call+0x5c/0x70

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/asm-prototypes.h | 1 +
 arch/powerpc/kernel/exceptions-64s.S      | 7 +++++--
 arch/powerpc/kernel/traps.c               | 6 ++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7841b8a60657..ffba4a6ee619 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -74,6 +74,7 @@ void facility_unavailable_exception(struct pt_regs *regs);
 void TAUException(struct pt_regs *regs);
 void altivec_assist_exception(struct pt_regs *regs);
 void unrecoverable_exception(struct pt_regs *regs);
+void unrecoverable_slb_miss(struct pt_regs *regs);
 void kernel_bad_stack(struct pt_regs *regs);
 void system_reset_exception(struct pt_regs *regs);
 void machine_check_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a6fa85916273..8e1396433eb4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -743,11 +743,14 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	b	.
 
 EXC_COMMON_BEGIN(unrecov_slb)
-	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
+	EXCEPTION_PROLOG_COMMON(0x390, PACA_EXSLB)
 	RECONCILE_IRQ_STATE(r10, r11)
 	bl	save_nvgprs
+	beq	cr6, 1f		// cr6.eq is set for a data SLB miss ...
+	li	r10, 0x490	// else fix trap number for instruction SLB miss
+	std	r10, _TRAP(r1)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
+	bl	unrecoverable_slb_miss
 	b	1b
 
 EXC_COMMON_BEGIN(large_addr_slb)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..0b1724a0b001 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2061,6 +2061,12 @@ void unrecoverable_exception(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(unrecoverable_exception);
 
+void unrecoverable_slb_miss(struct pt_regs *regs)
+{
+	die("Unrecoverable SLB miss (MSR[RI]=0)", regs, SIGABRT);
+}
+NOKPROBE_SYMBOL(unrecoverable_slb_miss);
+
 #if defined(CONFIG_BOOKE_WDT) || defined(CONFIG_40x)
 /*
  * Default handler for a Watchdog exception,
-- 
2.14.1
