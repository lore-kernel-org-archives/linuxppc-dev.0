Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDZM67r0zDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:06:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 9/9] powerpc: Add new cache geometry aux vectors
Date: Fri,  3 Feb 2017 22:05:59 +1100
Message-Id: <1486119959-21662-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
References: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This adds AUX vectors for the L1I,D, L2 and L3 cache levels
providing for each cache level the size of the cache in bytes
and the geometry (line size and number of ways).

We chose to not use the existing alpha/sh definition which
packs all the information in a single entry per cache level as
it is too restricted to represent some of the geometries used
on POWER.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cache.h       |  1 +
 arch/powerpc/include/asm/elf.h         | 20 ++++++++++++++++++++
 arch/powerpc/include/uapi/asm/auxvec.h | 33 ++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/setup_64.c         |  5 +++++
 4 files changed, 58 insertions(+), 1 deletion(-)

v3: The initialisation of assoc is done in init_cache_info() which we also use
    for the hardcoded p8 values, so assoc is correctly initialised on p8. (mpe)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index d7cf60f87604..5a90292afbad 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -38,6 +38,7 @@ struct ppc_cache_info {
 	u32 log_block_size;
 	u32 blocks_per_page;
 	u32 sets;
+	u32 assoc;
 };
 
 struct ppc64_caches {
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 730c27ed10e1..93b9b84568e8 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -136,6 +136,25 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #endif /* CONFIG_SPU_BASE */
 
+#ifdef CONFIG_PPC64
+
+#define get_cache_geometry(level) \
+	(ppc64_caches.level.assoc << 16 | ppc64_caches.level.line_size)
+
+#define ARCH_DLINFO_CACHE_GEOMETRY					\
+	NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);		\
+	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY, get_cache_geometry(l1i));	\
+	NEW_AUX_ENT(AT_L1D_CACHESIZE, ppc64_caches.l1i.size);		\
+	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY, get_cache_geometry(l1i));	\
+	NEW_AUX_ENT(AT_L2_CACHESIZE, ppc64_caches.l2.size);		\
+	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY, get_cache_geometry(l2));	\
+	NEW_AUX_ENT(AT_L3_CACHESIZE, ppc64_caches.l3.size);		\
+	NEW_AUX_ENT(AT_L3_CACHEGEOMETRY, get_cache_geometry(l3))
+
+#else
+#define ARCH_DLINFO_CACHE_GEOMETRY
+#endif
+
 /*
  * The requirements here are:
  * - keep the final alignment of sp (sp & 0xf)
@@ -156,6 +175,7 @@ do {									\
 	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
 	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
 	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
+	ARCH_DLINFO_CACHE_GEOMETRY;					\
 } while (0)
 
 #endif /* _ASM_POWERPC_ELF_H */
diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
index ce17d2c9eb4e..be6e94ecec42 100644
--- a/arch/powerpc/include/uapi/asm/auxvec.h
+++ b/arch/powerpc/include/uapi/asm/auxvec.h
@@ -16,6 +16,37 @@
  */
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
+/*
+ * AT_*CACHEBSIZE above represent the cache *block* size which is
+ * the size that is affected by the cache management instructions.
+ *
+ * It doesn't nececssarily matches the cache *line* size which is
+ * more of a performance tuning hint. Additionally the latter can
+ * be different for the different cache levels.
+ *
+ * The set of entries below represent more extensive information
+ * about the caches, in the form of two entry per cache type,
+ * one entry containing the cache size in bytes, and the other
+ * containing the cache line size in bytes in the bottom 16 bits
+ * and the cache associativity in the next 16 bits.
+ *
+ * The associativity is such that if N is the 16-bit value, the
+ * cache is N way set associative. A value if 0xffff means fully
+ * associative, a value of 1 means directly mapped.
+ *
+ * For all these fields, a value of 0 means that the information
+ * is not known.
+ */
+
+#define AT_L1I_CACHESIZE	40
+#define AT_L1I_CACHEGEOMETRY	41
+#define AT_L1D_CACHESIZE	42
+#define AT_L1D_CACHEGEOMETRY	43
+#define AT_L2_CACHESIZE		44
+#define AT_L2_CACHEGEOMETRY	45
+#define AT_L3_CACHESIZE		46
+#define AT_L3_CACHEGEOMETRY	47
+
+#define AT_VECTOR_SIZE_ARCH	14 /* entries in ARCH_DLINFO */
 
 #endif
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 364fbffd7e83..b9855f1b290a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -411,6 +411,11 @@ static void init_cache_info(struct ppc_cache_info *info, u32 size, u32 lsize,
 	info->block_size = bsize;
 	info->log_block_size = __ilog2(bsize);
 	info->blocks_per_page = PAGE_SIZE / bsize;
+
+	if (sets == 0)
+		info->assoc = 0xffff;
+	else
+		info->assoc = size / (sets * lsize);
 }
 
 static bool __init parse_cache_info(struct device_node *np,
-- 
2.7.4
