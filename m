Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 348841A0371
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 02:03:52 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH 10/11] powerpc/8xx: Use SPRG2 instead of DAR for saving r3
Message-Id: <20141216150340.33BC31A5E04@localhost.localdomain>
Date: Tue, 16 Dec 2014 16:03:40 +0100 (CET)
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
index a073918..dbe110e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -310,7 +310,7 @@ SystemCall:
 InstructionTLBMiss:
 	EXCEPTION_PROLOG_0
 #ifdef CONFIG_8xx_CPU6
-	mtspr	SPRN_DAR, r3
+	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 
 	/* If we are faulting a kernel address, we have to use the
@@ -374,8 +374,7 @@ InstructionTLBMiss:
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	mfspr	r3, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	EXCEPTION_EPILOG_0
 	rfi
@@ -388,7 +387,7 @@ DataStoreTLBMiss:
 	 * kernel page tables.
 	 */
 #ifdef CONFIG_8xx_CPU6
-	mtspr	SPRN_DAR, r3
+	mtspr	SPRN_SPRG_SCRATCH2, r3
 	mfcr	r3
 	mfspr	r10, SPRN_MD_EPN
 	andis.	r11, r10, 0x8000
@@ -461,7 +460,7 @@ DataStoreTLBMiss:
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	mfspr	r3, SPRN_DAR
+	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
-- 
2.1.0
