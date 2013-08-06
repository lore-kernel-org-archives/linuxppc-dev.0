Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB8112C0102
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 20:24:54 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc: remove the symbol __flush_icache_range
Date: Tue, 6 Aug 2013 18:23:31 +0800
Message-ID: <1375784612-14399-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
References: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And now the function flush_icache_range() is just a wrapper which
only invoke the function __flush_icache_range() directly. So we
don't have reason to keep it anymore.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/cacheflush.h | 7 +------
 arch/powerpc/kernel/misc_32.S         | 2 +-
 arch/powerpc/kernel/misc_64.S         | 2 +-
 arch/powerpc/kernel/ppc_ksyms.c       | 1 -
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 60b620d..5b93122 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -32,12 +32,7 @@ extern void flush_dcache_page(struct page *page);
 
 extern void __flush_disable_L1(void);
 
-extern void __flush_icache_range(unsigned long, unsigned long);
-static inline void flush_icache_range(unsigned long start, unsigned long stop)
-{
-	__flush_icache_range(start, stop);
-}
-
+extern void flush_icache_range(unsigned long, unsigned long);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 				    struct page *page, unsigned long addr,
 				    int len);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index e469f30..3f70dbf 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -327,7 +327,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  *
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
-_KPROBE(__flush_icache_range)
+_KPROBE(flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 74d87f1..a781566 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -67,7 +67,7 @@ PPC64_CACHES:
  *   flush all bytes from start through stop-1 inclusive
  */
 
-_KPROBE(__flush_icache_range)
+_KPROBE(flush_icache_range)
 BEGIN_FTR_SECTION
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c296665..380a6f9 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -111,7 +111,6 @@ EXPORT_SYMBOL(giveup_spe);
 #ifndef CONFIG_PPC64
 EXPORT_SYMBOL(flush_instruction_cache);
 #endif
-EXPORT_SYMBOL(__flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
 
 #ifdef CONFIG_SMP
-- 
1.8.3.1
