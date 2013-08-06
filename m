Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3C9F2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 20:24:48 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: move the testing of CPU_FTR_COHERENT_ICACHE into
 __flush_icache_range
Date: Tue, 6 Aug 2013 18:23:30 +0800
Message-ID: <1375784612-14399-2-git-send-email-haokexin@gmail.com>
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

In function flush_icache_range(), we use cpu_has_feature() to test
the feature bit of CPU_FTR_COHERENT_ICACHE. But this seems not optimal
for two reasons:
 a) For ppc32, the function __flush_icache_range() already do this
    check with the macro END_FTR_SECTION_IFSET.
 b) Compare with the cpu_has_feature(), the method of using macro
    END_FTR_SECTION_IFSET will not introduce any runtime overhead.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/cacheflush.h | 3 +--
 arch/powerpc/kernel/misc_64.S         | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index b843e35..60b620d 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -35,8 +35,7 @@ extern void __flush_disable_L1(void);
 extern void __flush_icache_range(unsigned long, unsigned long);
 static inline void flush_icache_range(unsigned long start, unsigned long stop)
 {
-	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
-		__flush_icache_range(start, stop);
+	__flush_icache_range(start, stop);
 }
 
 extern void flush_icache_user_range(struct vm_area_struct *vma,
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 6820e45..74d87f1 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -68,7 +68,9 @@ PPC64_CACHES:
  */
 
 _KPROBE(__flush_icache_range)
-
+BEGIN_FTR_SECTION
+	blr
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 /*
  * Flush the data cache to memory 
  * 
-- 
1.8.3.1
