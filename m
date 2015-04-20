Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 510361A1169
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:54:47 +1000 (AEST)
Message-Id: <c8e529bf94151c9f4915a1fff3e569f980c64793.1429287689.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
In-Reply-To: <cover.1429287689.git.christophe.leroy@c-s.fr>
References: <cover.1429287689.git.christophe.leroy@c-s.fr>
Subject: [PATCH RESEND v5 4/5] powerpc/8xx: Use SPRG2 instead of DAR for
 saving r3
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Mon, 20 Apr 2015 07:54:44 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now have SPRG2 available as in it not used anymore for saving CR, so we don't
need to crash DAR anymore for saving r3 for CPU6 ERRATA handling.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 150d03f..ba2dc53 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -309,7 +309,7 @@ SystemCall:
 
 InstructionTLBMiss:
 #ifdef CONFIG_8xx_CPU6
-	mtspr	SPRN_DAR, r3
+	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
 
@@ -362,8 +362,7 @@ InstructionTLBMiss:
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	mfspr	r3, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	EXCEPTION_EPILOG_0
 	rfi
@@ -371,7 +370,7 @@ InstructionTLBMiss:
 	. = 0x1200
 DataStoreTLBMiss:
 #ifdef CONFIG_8xx_CPU6
-	mtspr	SPRN_DAR, r3
+	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
 	mfcr	r10
@@ -438,7 +437,7 @@ DataStoreTLBMiss:
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	mfspr	r3, SPRN_DAR
+	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
-- 
2.1.0
