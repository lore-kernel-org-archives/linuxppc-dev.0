Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74538B70FE
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:38:39 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Dan Malek <ppc6dev@digitaldans.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/3] 8xx: replace _PAGE_EXEC with _PAGE_PSE
Date: Mon, 10 Oct 2011 13:38:32 +0200
Message-Id: <1318246714-5015-2-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need this bit for large pages(8MB). Adjust TLB code
to not clear bit 28 Mx_RPN

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    8 ++++----
 include/asm-ppc/pgtable.h  |    6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 36089cc..8e3fe40 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -387,13 +387,13 @@ InstructionTLBMiss:
 4:
 #endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21 and 28 must be clear.
+	 * Software indicator bit 21 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
 2:	li	r21, 0x00f0
-	rlwimi	r20, r21, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
+	rlwimi	r20, r21, 0, 0x07f0	/* Set 24-27, clear 21-23 */
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	MI_RPN, r20	/* Update TLB entry */
 
@@ -475,7 +475,7 @@ DataStoreTLBMiss:
 	xori	r20, r20, _PAGE_RW | 0x200
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 22 and 28 must be clear.
+	 * Software indicator bit 22 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
@@ -483,7 +483,7 @@ DataStoreTLBMiss:
 finish_DTLB:
 2:	li	r21, 0x00f0
 	mtspr	DAR, r21	/* Tag DAR */
-	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
+	rlwimi	r20, r21, 0, 0x00f0	/* Set 24-27 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r20	/* Update TLB entry */
 
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index b94e8a8..1a0ca7b 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -297,11 +297,11 @@ extern unsigned long vmalloc_start;
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
+#define _PAGE_PSE	0x0008	/* Large Page, 8MB */
 
 /* These four software bits must be masked out when the entry is loaded
  * into the TLB, 1 SW bits left(0x0080).
  */
-#define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
 #define _PAGE_GUARDED	0x0010	/* software: guarded access */
 #define _PAGE_ACCESSED	0x0020	/* software: page referenced */
 #define _PAGE_WRITETHRU	0x0040	/* software: caching is write through */
@@ -359,6 +359,10 @@ extern unsigned long vmalloc_start;
 #define _PAGE_EXEC	0
 #endif
 
+#ifndef _PAGE_PSE
+#define _PAGE_PSE	0
+#endif
+
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
-- 
1.7.3.4
