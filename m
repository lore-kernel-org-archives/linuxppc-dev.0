Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9rcW6hy0zDr35
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 02:55:55 +1000 (AEST)
Message-Id: <b6520cb1cce56cf55cec6affaf44ce2de8d9502b.1471020647.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1471020646.git.christophe.leroy@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/6] powerpc/8xx: Move additional DTLBMiss handlers out of
 exception area
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Aug 2016 18:55:52 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When all options are activated, there is not enough space for the
DTLBMiss handlers that handles IMMR area and linear RAM pages in the
exception area. So lets move them after .0x2000

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 84 +++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 708fd43..5f122e6 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -381,26 +381,6 @@ InstructionTLBMiss:
 	EXCEPTION_EPILOG_0
 	rfi
 
-/*
- * Bottom part of DataStoreTLBMiss handler for IMMR area
- * not enough space in the DataStoreTLBMiss area
- */
-DTLBMissIMMR:
-	mtcr	r10
-	/* Set 512k byte guarded page and mark it valid */
-	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
-	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
-	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
-			  _PAGE_PRESENT | _PAGE_NO_CACHE
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
-
-	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	EXCEPTION_EPILOG_0
-	rfi
-
 	. = 0x1200
 DataStoreTLBMiss:
 	EXCEPTION_PROLOG_0
@@ -419,7 +399,7 @@ DataStoreTLBMiss:
 _ENTRY(DTLBMiss_jmp)
 	beq-	DTLBMissIMMR
 #endif
-	bge-	cr7, 4f
+	bge-	cr7, DTLBMissLinear
 
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 3:
@@ -486,27 +466,6 @@ _ENTRY(DTLBMiss_jmp)
 	EXCEPTION_EPILOG_0
 	rfi
 
-4:
-_ENTRY(DTLBMiss_cmp)
-	cmpli	cr0, r11, (PAGE_OFFSET + 0x1800000)@h
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
-	bge-	3b
-
-	mtcr	r10
-	/* Set 8M byte page and mark it valid */
-	li	r10, MD_PS8MEG | MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
-	mfspr	r10, SPRN_MD_EPN
-	rlwinm	r10, r10, 0, 0x0f800000		/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
-			  _PAGE_PRESENT
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
-
-	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	EXCEPTION_EPILOG_0
-	rfi
-
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
@@ -568,6 +527,47 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 
 	. = 0x2000
 
+/*
+ * Bottom part of DataStoreTLBMiss handlers for IMMR area and linear RAM.
+ * not enough space in the DataStoreTLBMiss area.
+ */
+DTLBMissIMMR:
+	mtcr	r10
+	/* Set 512k byte guarded page and mark it valid */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
+	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
+	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
+	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+			  _PAGE_PRESENT | _PAGE_NO_CACHE
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	EXCEPTION_EPILOG_0
+	rfi
+
+DTLBMissLinear:
+_ENTRY(DTLBMiss_cmp)
+	cmpli	cr0, r11, (PAGE_OFFSET + 0x1800000)@h
+	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	bge-	3b
+
+	mtcr	r10
+	/* Set 8M byte page and mark it valid */
+	li	r10, MD_PS8MEG | MD_SVALID
+	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
+	mfspr	r10, SPRN_MD_EPN
+	rlwinm	r10, r10, 0, 0x0f800000		/* 8xx supports max 256Mb RAM */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+			  _PAGE_PRESENT
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	EXCEPTION_EPILOG_0
+	rfi
+
 /* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
  * by decoding the registers used by the dcbx instruction and adding them.
  * DAR is set to the calculated address.
-- 
2.1.0
