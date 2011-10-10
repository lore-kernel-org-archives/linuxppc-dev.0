Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CDF19B71D8
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:41 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 09/14] 8xx: Restore _PAGE_WRITETHRU
Date: Mon, 10 Oct 2011 13:30:15 +0200
Message-Id: <1318246220-4839-10-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

8xx has not had WRITETHRU due to lack of bits in the pte.
After the recent rewrite of the 8xx TLB code, there are
two bits left. Use one of them to WRITETHRU.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    8 ++++++++
 include/asm-ppc/pgtable.h  |    5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 86bc727..402158d 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -443,6 +443,10 @@ DataStoreTLBMiss:
 	 * above.
 	 */
 	rlwimi	r21, r20, 0, 27, 27
+	/* Insert the WriteThru flag into the TWC from the Linux PTE.
+	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
+	 */
+	rlwimi	r21, r20, 32-5, 30, 30
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 
@@ -579,6 +583,10 @@ DARFixed:
 	 * It is bit 27 of both the Linux PTE and the TWC
 	 */
 	rlwimi	r21, r20, 0, 27, 27
+	/* Insert the WriteThru flag into the TWC from the Linux PTE.
+	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
+	 */
+	rlwimi	r21, r20, 32-5, 30, 30
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 	mfspr	r21, MD_TWC		/* get the pte address again */
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 2ba37d3..6cfc5fc 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -298,12 +298,13 @@ extern unsigned long vmalloc_start;
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
 
-/* These three software bits must be masked out when the entry is loaded
- * into the TLB, 2 SW bits free.
+/* These four software bits must be masked out when the entry is loaded
+ * into the TLB, 1 SW bits left(0x0080).
  */
 #define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
 #define _PAGE_GUARDED	0x0010	/* software: guarded access */
 #define _PAGE_ACCESSED	0x0020	/* software: page referenced */
+#define _PAGE_WRITETHRU	0x0040	/* software: caching is write through */
 
 /* Setting any bits in the nibble with the follow two controls will
  * require a TLB exception handler change.  It is assumed unused bits
-- 
1.7.3.4
