Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B23F42C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:16 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/10] powerpc/booke64: Fix exception numbers
Date: Thu, 13 Mar 2014 19:00:42 -0500
Message-ID: <1394755249-8856-4-git-send-email-scottwood@freescale.com>
In-Reply-To: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

altivec_unavailable was commented as 0xf20 but the code uses 0x200.
Note that 0xf20 is also used by ap_unavailable.

altivec_assist was commented as 0x1700 but the code uses 0x220.

critical_input was commented as 0x580 but the code uses 0x100.

machine_check was commented and implemented as 0x200, which conflicts
with altivec_assist (it only builds because MC_EXCEPTION_PROLOG is
commented out).  Changed to the fixed IVOR value of 0x000.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 6772512..41380a4 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -299,8 +299,8 @@ exception_marker:
 	.balign	0x1000
 	.globl interrupt_base_book3e
 interrupt_base_book3e:					/* fake trap */
-	EXCEPTION_STUB(0x000, machine_check)		/* 0x0200 */
-	EXCEPTION_STUB(0x020, critical_input)		/* 0x0580 */
+	EXCEPTION_STUB(0x000, machine_check)
+	EXCEPTION_STUB(0x020, critical_input)		/* 0x0100 */
 	EXCEPTION_STUB(0x040, debug_crit)		/* 0x0d00 */
 	EXCEPTION_STUB(0x060, data_storage)		/* 0x0300 */
 	EXCEPTION_STUB(0x080, instruction_storage)	/* 0x0400 */
@@ -315,8 +315,8 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x1a0, watchdog)			/* 0x09f0 */
 	EXCEPTION_STUB(0x1c0, data_tlb_miss)
 	EXCEPTION_STUB(0x1e0, instruction_tlb_miss)
-	EXCEPTION_STUB(0x200, altivec_unavailable)	/* 0x0f20 */
-	EXCEPTION_STUB(0x220, altivec_assist)		/* 0x1700 */
+	EXCEPTION_STUB(0x200, altivec_unavailable)
+	EXCEPTION_STUB(0x220, altivec_assist)
 	EXCEPTION_STUB(0x260, perfmon)
 	EXCEPTION_STUB(0x280, doorbell)
 	EXCEPTION_STUB(0x2a0, doorbell_crit)
@@ -343,9 +343,9 @@ interrupt_end_book3e:
 
 /* Machine Check Interrupt */
 	START_EXCEPTION(machine_check);
-	MC_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_MACHINE_CHECK,
+	MC_EXCEPTION_PROLOG(0x000, BOOKE_INTERRUPT_MACHINE_CHECK,
 			    PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
+//	EXCEPTION_COMMON(0x000, PACA_EXMC, INTS_DISABLE)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	CHECK_NAPPING();
-- 
1.8.3.2
