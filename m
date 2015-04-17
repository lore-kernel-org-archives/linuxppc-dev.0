Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 837B71A1706
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 02:33:01 +1000 (AEST)
Message-Id: <1189dbe5a19e8170873f48fd8bd450c2174db9b9.1429287688.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1429287688.git.christophe.leroy@c-s.fr>
References: <cover.1429287688.git.christophe.leroy@c-s.fr>
Subject: [PATCH v5 2/5] powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Fri, 17 Apr 2015 18:32:54 +0200 (CEST)
From: christophe.leroy@c-s.fr (root)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to be able to reduce scope during which CR is saved, we take
CR saving/restoring out of exception PROLOG and EPILOG

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1279018..5a69c5e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -116,13 +116,13 @@ turn_on_mmu:
  */
 #define EXCEPTION_PROLOG	\
 	EXCEPTION_PROLOG_0;	\
+	mfcr	r10;		\
 	EXCEPTION_PROLOG_1;	\
 	EXCEPTION_PROLOG_2
 
 #define EXCEPTION_PROLOG_0	\
 	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
-	mtspr	SPRN_SPRG_SCRATCH1,r11;	\
-	mfcr	r10
+	mtspr	SPRN_SPRG_SCRATCH1,r11
 
 #define EXCEPTION_PROLOG_1	\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
@@ -162,7 +162,6 @@ turn_on_mmu:
  * Exception exit code.
  */
 #define EXCEPTION_EPILOG_0	\
-	mtcr	r10;		\
 	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
 	mfspr	r11,SPRN_SPRG_SCRATCH1
 
@@ -313,6 +312,7 @@ InstructionTLBMiss:
 	mtspr	SPRN_DAR, r3
 #endif
 	EXCEPTION_PROLOG_0
+	mfcr	r10
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
@@ -363,6 +363,7 @@ InstructionTLBMiss:
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH2
+	mtcr	r10
 	EXCEPTION_EPILOG_0
 	rfi
 
@@ -372,6 +373,7 @@ DataStoreTLBMiss:
 	mtspr	SPRN_DAR, r3
 #endif
 	EXCEPTION_PROLOG_0
+	mfcr	r10
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mfspr	r10, SPRN_MD_EPN
 
@@ -437,6 +439,7 @@ DataStoreTLBMiss:
 #endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	mfspr	r10, SPRN_SPRG_SCRATCH2
+	mtcr	r10
 	EXCEPTION_EPILOG_0
 	rfi
 
@@ -462,6 +465,7 @@ InstructionTLBError:
 	. = 0x1400
 DataTLBError:
 	EXCEPTION_PROLOG_0
+	mfcr	r10
 
 	mfspr	r11, SPRN_DAR
 	cmpwi	cr0, r11, RPN_PATTERN
-- 
2.1.0
