Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 365592C05D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 16:33:27 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id rA55XMYQ008317
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Nov 2013 23:33:23 -0600
Message-ID: <1383629602.4776.87.camel@pasglop>
Subject: [PATCH] powerpc: Fix fatal SLB miss when restoring PPR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 05 Nov 2013 16:33:22 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When restoring the PPR value, we incorrectly access the thread structure
at a time where MSR:RI is clear, which means we cannot recover from nested
faults. However the thread structure isn't covered by the "bolted" SLB
entries and thus accessing can fault.

This fixes it by splitting the code so that the PPR value is loaded into
a GPR before MSR:RI is cleared.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--- 

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 8deaaad..3c1acc3 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -406,13 +406,6 @@ BEGIN_FTR_SECTION_NESTED(945)						\
 	std	ra,TASKTHREADPPR(rb);					\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
 
-#define RESTORE_PPR(ra, rb)						\
-BEGIN_FTR_SECTION_NESTED(946)						\
-	ld	ra,PACACURRENT(r13);					\
-	ld	rb,TASKTHREADPPR(ra);					\
-	mtspr	SPRN_PPR,rb;	/* Restore PPR */			\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
-
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 12679cd..bbfb029 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -818,6 +818,12 @@ fast_exception_return:
 	andi.	r0,r3,MSR_RI
 	beq-	unrecov_restore
 
+	/* Load PPR from thread struct before we clear MSR:RI */
+BEGIN_FTR_SECTION
+	ld	r2,PACACURRENT(r13)
+	ld	r2,TASKTHREADPPR(r2)
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
+
 	/*
 	 * Clear RI before restoring r13.  If we are returning to
 	 * userspace and we take an exception after restoring r13,
@@ -838,8 +844,10 @@ fast_exception_return:
 	 */
 	andi.	r0,r3,MSR_PR
 	beq	1f
+BEGIN_FTR_SECTION
+	mtspr	SPRN_PPR,r2	/* Restore PPR */
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r2, r4)
-	RESTORE_PPR(r2, r4)
 	REST_GPR(13, r1)
 1:
 	mtspr	SPRN_SRR1,r3
