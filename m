Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttfDn0McxzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 16:16:40 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 9/9] powerpc: A new cache shape aux vectors
Date: Wed,  4 Jan 2017 16:15:35 +1100
Message-Id: <20170104051535.9454-9-benh@kernel.crashing.org>
In-Reply-To: <20170104051535.9454-1-benh@kernel.crashing.org>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The definition is loosely based on sh and alpha, modified to
accomodate larger associativity and cache size for future-proofing.

We currently set all the values to -1 which indicates that the
information isn't available.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/cache.h       |  1 +
 arch/powerpc/include/asm/elf.h         | 17 ++++++++++++++++-
 arch/powerpc/include/uapi/asm/auxvec.h | 33 ++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/setup-common.c     |  5 ++++-
 arch/powerpc/kernel/setup_64.c         |  4 ++++
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 3987bd9..1557d26 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -35,6 +35,7 @@ struct ppc_cache_info {
 	u32 log_block_size;
 	u32 blocks_per_page;
 	u32 sets;
+	u32 assoc;
 };
 
 struct ppc64_caches {
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 730c27e..27dece6 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -108,13 +108,17 @@ do {								\
  */
 # define elf_read_implies_exec(ex, exec_stk) (is_32bit_task() ? \
 		(exec_stk == EXSTACK_DEFAULT) : 0)
-#else 
+#else
 # define elf_read_implies_exec(ex, exec_stk) (exec_stk == EXSTACK_DEFAULT)
 #endif /* __powerpc64__ */
 
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
+extern long il1cache_shape;
+extern long dl1cache_shape;
+extern long l2cache_shape;
+extern long l3cache_shape;
 
 /* vDSO has arch_setup_additional_pages */
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
@@ -136,6 +140,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #endif /* CONFIG_SPU_BASE */
 
+#define get_cache_shape(level) \
+	(ppc64_caches.level.assoc << 16 | ppc64_caches.level.line_size)
+
 /*
  * The requirements here are:
  * - keep the final alignment of sp (sp & 0xf)
@@ -156,6 +163,14 @@ do {									\
 	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
 	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
 	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
+	NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);		\
+	NEW_AUX_ENT(AT_L1I_CACHESHAPE, get_cache_shape(l1i));		\
+	NEW_AUX_ENT(AT_L1D_CACHESIZE, ppc64_caches.l1i.size);		\
+	NEW_AUX_ENT(AT_L1D_CACHESHAPE, get_cache_shape(l1i));		\
+	NEW_AUX_ENT(AT_L2_CACHESIZE, ppc64_caches.l2.size);		\
+	NEW_AUX_ENT(AT_L2_CACHESHAPE, get_cache_shape(l2));		\
+	NEW_AUX_ENT(AT_L3_CACHESIZE, ppc64_caches.l3.size);		\
+	NEW_AUX_ENT(AT_L3_CACHESHAPE, get_cache_shape(l3));		\
 } while (0)
 
 #endif /* _ASM_POWERPC_ELF_H */
diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
index ce17d2c..79183d2 100644
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
+#define AT_L1I_CACHESHAPE	41
+#define AT_L1D_CACHESIZE	42
+#define AT_L1D_CACHESHAPE	43
+#define AT_L2_CACHESIZE		44
+#define AT_L2_CACHESHAPE	45
+#define AT_L3_CACHESIZE		46
+#define AT_L3_CACHESHAPE	47
+
+#define AT_VECTOR_SIZE_ARCH	14 /* entries in ARCH_DLINFO */
 
 #endif
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index e0eeed4..cfa2a06 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -94,7 +94,10 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
 int dcache_bsize;
 int icache_bsize;
 int ucache_bsize;
-
+long il1cache_shape = -1;
+long dl1cache_shape = -1;
+long l2cache_shape = -1;
+long l3cache_shape = -1;
 
 unsigned long klimit = (unsigned long) _end;
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b3c93d8..16cb0b7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -451,6 +451,10 @@ static bool __init parse_cache_info(struct device_node *np,
 	info->block_size = bsize;
 	info->log_block_size = __ilog2(bsize);
 	info->blocks_per_page = PAGE_SIZE / bsize;
+	if (sets == 0)
+		info->assoc = 0xffff;
+	else
+		info->assoc = size / (sets * lsize);
 
 	return success;
 }
-- 
2.9.3
