Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id BF1E51A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 20:57:37 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v2 01/11] powerpc/8xx: remove remaining unnecessary code in
 FixupDAR
Message-Id: <20150120095733.D4A431A5E82@localhost.localdomain>
Date: Tue, 20 Jan 2015 10:57:33 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 33fb845a6f01 ("powerpc/8xx: Don't use MD_TWC for walk"), MD_EPN and
MD_TWC are not writen anymore in FixupDAR so saving r3 has become useless.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: no change

 arch/powerpc/kernel/head_8xx.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3d4b8ee..79b8a23 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -532,9 +532,6 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  /* define if you don't want to use self modifying code */
 #define NO_SELF_MODIFYING_CODE
 FixupDAR:/* Entry point for dcbx workaround. */
-#ifdef CONFIG_8xx_CPU6
-	mtspr	SPRN_DAR, r3
-#endif
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
@@ -551,9 +548,6 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	/* Extract level 2 index */
 	rlwinm	r11, r11, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
 	lwzx	r11, r10, r11	/* Get the pte */
-#ifdef CONFIG_8xx_CPU6
-	mfspr	r3, SPRN_DAR
-#endif
 	/* concat physical page address(r11) and page offset(r10) */
 	mfspr	r10, SPRN_SRR0
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT, 31
-- 
2.1.0
