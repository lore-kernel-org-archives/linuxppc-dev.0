Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id E75B31A0AA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 17:05:09 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 16/20] powerpc/8xx: Implement 16k pages
Message-Id: <20140808070345.3A7F51ABD4C@localhost.localdomain>
Date: Fri,  8 Aug 2014 09:03:45 +0200 (CEST)
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

This patch activates the handling of 16k pages on the MPC8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/Kconfig               |    2 +-
 arch/powerpc/include/asm/mmu-8xx.h |    2 ++
 arch/powerpc/kernel/head_8xx.S     |    4 ++++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5f44d3b..dc5f64e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -518,7 +518,7 @@ config PPC_4K_PAGES
 	bool "4k page size"
 
 config PPC_16K_PAGES
-	bool "16k page size" if 44x
+	bool "16k page size" if 44x || PPC_8xx
 
 config PPC_64K_PAGES
 	bool "64k page size" if 44x || PPC_STD_MMU_64 || PPC_BOOK3E_64
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 3d11d3c..986b9e1 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -56,6 +56,7 @@
  * additional information from the MI_EPN, and MI_TWC registers.
  */
 #define SPRN_MI_RPN	790
+#define MI_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
 
 /* Define an RPN value for mapping kernel memory to large virtual
  * pages for boot initialization.  This has real page number of 0,
@@ -129,6 +130,7 @@
  * additional information from the MD_EPN, and MD_TWC registers.
  */
 #define SPRN_MD_RPN	798
+#define MD_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
 
 /* This is a temporary storage register that could be used to save
  * a processor working register during a tablewalk.
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index a8945af..82e4139 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -45,7 +45,11 @@
  * Value for the bits that have fixed value in RPN entries.
  * Also used for tagging DAR for DTLBerror.
  */
+#ifdef CONFIG_PPC_16K_PAGES
+#define RPN_PATTERN	(0x00f0 | MD_SPS16K)
+#else
 #define RPN_PATTERN	0x00f0
+#endif
 
 	__HEAD
 _ENTRY(_stext);
-- 
1.7.1
