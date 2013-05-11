Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16B562C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 09:26:37 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc: move the patch_exception to a common place
Date: Sun, 12 May 2013 07:26:22 +0800
Message-ID: <1368314784-971-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368314784-971-1-git-send-email-haokexin@gmail.com>
References: <1368314784-971-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So that it can be used by other codes. No function change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/code-patching.h |  7 +++++++
 arch/powerpc/lib/code-patching.c         | 15 +++++++++++++++
 arch/powerpc/mm/tlb_nohash.c             | 19 -------------------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index a6f8c7a..97e02f9 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -34,6 +34,13 @@ int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
 unsigned long branch_target(const unsigned int *instr);
 unsigned int translate_branch(const unsigned int *dest,
 			      const unsigned int *src);
+#ifdef CONFIG_PPC_BOOK3E_64
+void __patch_exception(int exc, unsigned long addr);
+#define patch_exception(exc, name) do { \
+	extern unsigned int name; \
+	__patch_exception((exc), (unsigned long)&name); \
+} while (0)
+#endif
 
 static inline unsigned long ppc_function_entry(void *func)
 {
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 17e5b23..d5edbeb 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -159,6 +159,21 @@ unsigned int translate_branch(const unsigned int *dest, const unsigned int *src)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_BOOK3E_64
+void __patch_exception(int exc, unsigned long addr)
+{
+	extern unsigned int interrupt_base_book3e;
+	unsigned int *ibase = &interrupt_base_book3e;
+
+	/* Our exceptions vectors start with a NOP and -then- a branch
+	 * to deal with single stepping from userspace which stops on
+	 * the second instruction. Thus we need to patch the second
+	 * instruction of the exception, not the first one
+	 */
+
+	patch_branch(ibase + (exc / 4) + 1, addr, 0);
+}
+#endif
 
 #ifdef CONFIG_CODE_PATCHING_SELFTEST
 
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 6888cad..0658aad 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -518,25 +518,6 @@ static void setup_page_sizes(void)
 	}
 }
 
-static void __patch_exception(int exc, unsigned long addr)
-{
-	extern unsigned int interrupt_base_book3e;
- 	unsigned int *ibase = &interrupt_base_book3e;
- 
-	/* Our exceptions vectors start with a NOP and -then- a branch
-	 * to deal with single stepping from userspace which stops on
-	 * the second instruction. Thus we need to patch the second
-	 * instruction of the exception, not the first one
-	 */
-
-	patch_branch(ibase + (exc / 4) + 1, addr, 0);
-}
-
-#define patch_exception(exc, name) do { \
-	extern unsigned int name; \
-	__patch_exception((exc), (unsigned long)&name); \
-} while (0)
-
 static void setup_mmu_htw(void)
 {
 	/* Check if HW tablewalk is present, and if yes, enable it by:
-- 
1.8.1.4
