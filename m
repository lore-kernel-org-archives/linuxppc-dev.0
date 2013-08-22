Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F3142C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:30:58 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc: purge all the prefetched instructions for the
 coherent icache flush
Date: Thu, 22 Aug 2013 09:30:35 +0800
Message-ID: <1377135035-4497-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <20130821114915.GC32546@pek-khao-d1.corp.ad.wrs.com>
References: <20130821114915.GC32546@pek-khao-d1.corp.ad.wrs.com>
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

As Benjamin Herrenschmidt has indicated, we still need a dummy icbi to
purge all the prefetched instructions from the ifetch buffers for the
snooping icache. We also need a sync before the icbi to order the
actual stores to memory that might have modified instructions with
the icbi.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/cache.h | 14 +++++++++++++-
 arch/powerpc/kernel/misc_32.S    |  4 +++-
 arch/powerpc/kernel/misc_64.S    |  3 ++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 9e495c9..ed0afc1 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -41,8 +41,20 @@ struct ppc64_caches {
 extern struct ppc64_caches ppc64_caches;
 #endif /* __powerpc64__ && ! __ASSEMBLY__ */
 
-#if !defined(__ASSEMBLY__)
+#if defined(__ASSEMBLY__)
+/*
+ * For a snooping icache, we still need a dummy icbi to purge all the
+ * prefetched instructions from the ifetch buffers. We also need a sync
+ * before the icbi to order the the actual stores to memory that might
+ * have modified instructions with the icbi.
+ */
+#define PURGE_PREFETCHED_INS	\
+	sync;			\
+	icbi	0,r3;		\
+	sync;			\
+	isync
 
+#else
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
 #ifdef CONFIG_6xx
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 777d999..d1e819b 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -329,7 +329,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  */
 _KPROBE(flush_icache_range)
 BEGIN_FTR_SECTION
-	isync
+	PURGE_PREFETCHED_INS
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	li	r5,L1_CACHE_BYTES-1
@@ -433,6 +433,7 @@ _GLOBAL(invalidate_dcache_range)
  */
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
+	PURGE_PREFETCHED_INS
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address */
@@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
  */
 _GLOBAL(__flush_dcache_icache_phys)
 BEGIN_FTR_SECTION
+	PURGE_PREFETCHED_INS
 	blr					/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	mfmsr	r10
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 992a78e..f9e8770 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -69,6 +69,7 @@ PPC64_CACHES:
 
 _KPROBE(flush_icache_range)
 BEGIN_FTR_SECTION
+	PURGE_PREFETCHED_INS
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 /*
@@ -208,7 +209,7 @@ _GLOBAL(flush_inval_dcache_range)
  */
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
-	isync
+	PURGE_PREFETCHED_INS
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 /*
-- 
1.8.3.1
