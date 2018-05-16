Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96z2xBHzF14y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:47 +1000 (AEST)
Message-Id: <09656b46a6d74d05fd14ea59a846e8fa37fe30e0.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/14] powerpc/8xx: reunify TLB handler routines
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:43 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each handler must not exceed 64 instructions to fit into the main
exception area.
Following the significant size reduction of TLB handler routines,
the side handlers can be brought back close to the main part.

In the worst case:
Main part of ITLB handler is 45 insn, side part is 9 insn ==> total 54
Main part of DTLB handler is 37 insn, side part is 23 insn ==> total 60

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 108 ++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 66a27044d105..0c3cfaa4e6f3 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -388,6 +388,23 @@ _ENTRY(itlb_miss_perf)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 
+#ifndef CONFIG_PIN_TLB_TEXT
+ITLBMissLinear:
+	mtcr	r11
+	/* Set 8M byte page and mark it valid */
+	li	r11, MI_PS8MEG | MI_SVALID
+	mtspr	SPRN_MI_TWC, r11
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+			  _PAGE_PRESENT
+	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
+
+_ENTRY(itlb_miss_exit_2)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+#endif
+
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
@@ -463,6 +480,41 @@ _ENTRY(dtlb_miss_perf)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 
+DTLBMissIMMR:
+	mtcr	r11
+	/* Set 512k byte guarded page and mark it valid */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
+	mtspr	SPRN_MD_TWC, r10
+	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
+	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+			  _PAGE_PRESENT | _PAGE_NO_CACHE
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+_ENTRY(dtlb_miss_exit_2)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+
+DTLBMissLinear:
+	mtcr	r11
+	/* Set 8M byte page and mark it valid */
+	li	r11, MD_PS8MEG | MD_SVALID
+	mtspr	SPRN_MD_TWC, r11
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+			  _PAGE_PRESENT
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+_ENTRY(dtlb_miss_exit_3)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -565,62 +617,6 @@ InstructionBreakpoint:
 
 	. = 0x2000
 
-/*
- * Bottom part of DataStoreTLBMiss handlers for IMMR area and linear RAM.
- * not enough space in the DataStoreTLBMiss area.
- */
-DTLBMissIMMR:
-	mtcr	r11
-	/* Set 512k byte guarded page and mark it valid */
-	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
-	mtspr	SPRN_MD_TWC, r10
-	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
-	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
-			  _PAGE_PRESENT | _PAGE_NO_CACHE
-	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
-	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-_ENTRY(dtlb_miss_exit_2)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-
-DTLBMissLinear:
-	mtcr	r11
-	/* Set 8M byte page and mark it valid */
-	li	r11, MD_PS8MEG | MD_SVALID
-	mtspr	SPRN_MD_TWC, r11
-	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
-			  _PAGE_PRESENT
-	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
-	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-_ENTRY(dtlb_miss_exit_3)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-
-#ifndef CONFIG_PIN_TLB_TEXT
-ITLBMissLinear:
-	mtcr	r11
-	/* Set 8M byte page and mark it valid */
-	li	r11, MI_PS8MEG | MI_SVALID
-	mtspr	SPRN_MI_TWC, r11
-	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
-			  _PAGE_PRESENT
-	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
-
-_ENTRY(itlb_miss_exit_2)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-#endif
-
 /* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
  * by decoding the registers used by the dcbx instruction and adding them.
  * DAR is set to the calculated address.
-- 
2.13.3
