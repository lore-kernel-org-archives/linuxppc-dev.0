Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 522E21A009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 19:02:06 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v4 09/21] powerpc/8xx: Optimize verification in FixupDAR
Message-Id: <20140919083608.3DC9B1AB030@localhost.localdomain>
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

By XORing the upper part of the instruction code, we get a value that can
directly be verified with the second test and we can remove the first test.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes in v2:
- None

Changes in v3:
- None

Changes in v4:
- None

 arch/powerpc/kernel/head_8xx.S |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index e5a250c..5037420 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -542,10 +542,8 @@ FixupDAR:/* Entry point for dcbx workaround. */
 /* Check if it really is a dcbx instruction. */
 /* dcbt and dcbtst does not generate DTLB Misses/Errors,
  * no need to include them here */
-	srwi	r10, r11, 26	/* check if major OP code is 31 */
-	cmpwi	cr0, r10, 31
-	bne-	141f
-	rlwinm	r10, r11, 0, 21, 30
+	xoris	r10, r11, 0x7c00	/* check if major OP code is 31 */
+	rlwinm	r10, r10, 0, 21, 5
 	cmpwi	cr0, r10, 2028	/* Is dcbz? */
 	beq+	142f
 	cmpwi	cr0, r10, 940	/* Is dcbi? */
-- 
1.7.1
