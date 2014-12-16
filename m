Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id ED8781A0184
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 02:03:47 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH 06/11] powerpc/8xx: Remove duplicated code in set_context()
Message-Id: <20141216150339.097E61A5E05@localhost.localdomain>
Date: Tue, 16 Dec 2014 16:03:39 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/kernel/head_8xx.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index aa45225..b227902e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -848,23 +848,21 @@ _GLOBAL(set_context)
 
 	li	r5, (swapper_pg_dir-PAGE_OFFSET)@l
 	sub	r4, r4, r5
+	tophys	(r4, r4)
 #ifdef CONFIG_8xx_CPU6
 	lis	r6, cpu6_errata_word@h
 	ori	r6, r6, cpu6_errata_word@l
-	tophys	(r4, r4)
 	li	r7, 0x3f80
 	stw	r7, 12(r6)
 	lwz	r7, 12(r6)
+#endif
         mtspr   SPRN_M_TW, r4               /* Update MMU base address */
+#ifdef CONFIG_8xx_CPU6
 	li	r7, 0x3380
 	stw	r7, 12(r6)
 	lwz	r7, 12(r6)
-        mtspr   SPRN_M_CASID, r3             /* Update context */
-#else
-        mtspr   SPRN_M_CASID,r3		/* Update context */
-	tophys	(r4, r4)
-	mtspr	SPRN_M_TW, r4		/* and pgd */
 #endif
+        mtspr   SPRN_M_CASID, r3             /* Update context */
 	SYNC
 	blr
 
-- 
2.1.0
