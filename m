Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 76D201A0B11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 18:36:15 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v4 10/21] powerpc/8xx: Duplicate two insns instead of branching
Message-Id: <20140919083608.6C7BA1AB03B@localhost.localdomain>
Date: Fri, 19 Sep 2014 10:36:08 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Branching takes two cycles on MPC8xx. Lets duplicate the two instructions
and avoid the branching.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes in v2:
- None

Changes in v3:
- None

Changes in v4:
- None

 arch/powerpc/kernel/head_8xx.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5037420..4a49ff3 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -638,9 +638,11 @@ modified_instr:
 
 	/* special handling for r10,r11 since these are modified already */
 153:	mfspr	r11, SPRN_SPRG_SCRATCH1	/* load r11 from SPRN_SPRG_SCRATCH1 */
-	b	155f
+	add	r10, r10, r11	/* add it */
+	mfctr	r11		/* restore r11 */
+	b	151b
 154:	mfspr	r11, SPRN_SPRG_SCRATCH0	/* load r10 from SPRN_SPRG_SCRATCH0 */
-155:	add	r10, r10, r11	/* add it */
+	add	r10, r10, r11	/* add it */
 	mfctr	r11		/* restore r11 */
 	b	151b
 #endif
-- 
1.7.1
