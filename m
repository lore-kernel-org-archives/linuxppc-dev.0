Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDdRv3b8hzDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:43:07 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sDdRt23RYz9t0m
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2016 15:43:06 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 08/10] powerpc/64: Clean up ppc64_caches using a struct
 per cache
Date: Wed, 17 Aug 2016 15:39:15 +1000
Message-Id: <1471412357-3477-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
References: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have two set of identical struct members for the I and D sides
and mostly identical bunches of code to parse the device-tree to
populate them. Instead make a ppc_cache_info structure with one
copy for I and one for D

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/cache.h   |  24 ++---
 arch/powerpc/include/asm/page_64.h |   4 +-
 arch/powerpc/kernel/align.c        |   2 +-
 arch/powerpc/kernel/asm-offsets.c  |  12 +--
 arch/powerpc/kernel/setup_64.c     | 197 +++++++++++++++++--------------------
 arch/powerpc/kernel/vdso.c         |  16 +--
 6 files changed, 121 insertions(+), 134 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index ceb1244..ceb7376 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -27,19 +27,19 @@
 #define	SMP_CACHE_BYTES		L1_CACHE_BYTES
 
 #if defined(__powerpc64__) && !defined(__ASSEMBLY__)
+
+struct ppc_cache_info {
+	u32 size;
+	u32 line_size;
+	u32 block_size;	/* L1 only */
+	u32 log_block_size;
+	u32 blocks_per_page;
+	u32 sets;
+};
+
 struct ppc64_caches {
-	u32	dsize;			/* L1 d-cache size */
-	u32	dline_size;		/* L1 d-cache line size	*/
-	u32	dblock_size;		/* L1 d-cache block size */
-	u32	log_dblock_size;
-	u32	dblocks_per_page;
-	u32	dsets;
-	u32	isize;			/* L1 i-cache size */
-	u32	iline_size;		/* L1 d-cache line size	*/
-	u32	iblock_size;		/* L1 i-cache block size */
-	u32	log_iblock_size;
-	u32	iblocks_per_page;
-	u32	isets;
+	struct ppc_cache_info l1d;
+	struct ppc_cache_info l1i;
 };
 
 extern struct ppc64_caches ppc64_caches;
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index c50a666..3e83d2a 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -47,14 +47,14 @@ static inline void clear_page(void *addr)
 	unsigned long iterations;
 	unsigned long onex, twox, fourx, eightx;
 
-	iterations = ppc64_caches.dblocks_per_page / 8;
+	iterations = ppc64_caches.l1d.blocks_per_page / 8;
 
 	/*
 	 * Some verisions of gcc use multiply instructions to
 	 * calculate the offsets so lets give it a hand to
 	 * do better.
 	 */
-	onex = ppc64_caches.dblock_size;
+	onex = ppc64_caches.l1d.block_size;
 	twox = onex << 1;
 	fourx = onex << 2;
 	eightx = onex << 3;
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index a617751..7806211 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -204,7 +204,7 @@ static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
 	int i, size;
 
 #ifdef __powerpc64__
-	size = ppc64_caches.dblock_size;
+	size = ppc64_caches.l1d.block_size;
 #else
 	size = L1_CACHE_BYTES;
 #endif
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e2a881f..100261b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -160,12 +160,12 @@ int main(void)
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 
 #ifdef CONFIG_PPC64
-	DEFINE(DCACHEL1BLOCKSIZE, offsetof(struct ppc64_caches, dblock_size));
-	DEFINE(DCACHEL1LOGBLOCKSIZE, offsetof(struct ppc64_caches, log_dblock_size));
-	DEFINE(DCACHEL1BLOCKSPERPAGE, offsetof(struct ppc64_caches, dblocks_per_page));
-	DEFINE(ICACHEL1BLOCKSIZE, offsetof(struct ppc64_caches, iblock_size));
-	DEFINE(ICACHEL1LOGBLOCKSIZE, offsetof(struct ppc64_caches, log_iblock_size));
-	DEFINE(ICACHEL1BLOCKSPERPAGE, offsetof(struct ppc64_caches, iblocks_per_page));
+	DEFINE(DCACHEL1BLOCKSIZE, offsetof(struct ppc64_caches, l1d.block_size));
+	DEFINE(DCACHEL1LOGBLOCKSIZE, offsetof(struct ppc64_caches, l1d.log_block_size));
+	DEFINE(DCACHEL1BLOCKSPERPAGE, offsetof(struct ppc64_caches, l1d.blocks_per_page));
+	DEFINE(ICACHEL1BLOCKSIZE, offsetof(struct ppc64_caches, l1i.block_size));
+	DEFINE(ICACHEL1LOGBLOCKSIZE, offsetof(struct ppc64_caches, l1i.log_block_size));
+	DEFINE(ICACHEL1BLOCKSPERPAGE, offsetof(struct ppc64_caches, l1i.blocks_per_page));
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
 	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2079e2e..80a20b9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -78,10 +78,14 @@ int spinning_secondaries;
 u64 ppc64_pft_size;
 
 struct ppc64_caches ppc64_caches = {
-	.dblock_size = 0x40,
-	.log_dblock_size = 6,
-	.iblock_size = 0x40,
-	.log_iblock_size = 6
+	.l1d = {
+		.block_size = 0x40,
+		.log_block_size = 6,
+	},
+	.l1i = {
+		.block_size = 0x40,
+		.log_block_size = 6
+	},
 };
 EXPORT_SYMBOL_GPL(ppc64_caches);
 
@@ -382,18 +386,18 @@ void smp_release_cpus(void)
 }
 #endif /* CONFIG_SMP || CONFIG_KEXEC */
 
-static long format_cache_shape(u32 size, u32 sets, u32 lsize)
+static long format_cache_shape(struct ppc_cache_info *info)
 {
 	long result = 0;
-	u32 log2size = __ilog2(lsize);
+	u32 log2size = __ilog2(info->line_size);
 	u32 ways;
 
-	if (size == 0 || sets == 0)
+	if (info->size == 0 || info->sets == 0)
 		return -1;
-	if (sets == 1)
+	if (info->sets == 1)
 		ways = 0;
 	else
-		ways = size / (lsize * sets);
+		ways = info->size / (info->line_size * info->sets);
 	if (ways < 0x2ff)
 		result |= ways;
 	else
@@ -402,8 +406,8 @@ static long format_cache_shape(u32 size, u32 sets, u32 lsize)
 		result |= (log2size << 10);
 	else
 		result |= 0x3c00;
-	if (size >= 1024)
-		result |= (size >> 10) << 14;
+	if (info->size >= 1024)
+		result |= (info->size >> 10) << 14;
 	else
 		result |= 0xfffffc000ul;
 
@@ -417,110 +421,93 @@ static long format_cache_shape(u32 size, u32 sets, u32 lsize)
  * cache informations about the CPU that will be used by cache flush
  * routines and/or provided to userland
  */
+
+static bool __init parse_cache_info(struct device_node *np,
+				    bool icache,
+				    struct ppc_cache_info *info)
+{
+	static const char *ipropnames[] __initdata = {
+		"i-cache-size",
+		"i-cache-sets",
+		"i-cache-block-size",
+		"i-cache-line-size",
+	};
+	static const char *dpropnames[] __initdata = {
+		"d-cache-size",
+		"d-cache-sets",
+		"d-cache-block-size",
+		"d-cache-line-size",
+	};
+	const char **propnames = icache ? ipropnames : dpropnames;
+	const __be32 *sizep, *lsizep, *bsizep, *setsp;
+	u32 size, lsize, bsize, sets;
+	bool success = true;
+
+	size = 0;
+	sets = -1u;
+	lsize = bsize = cur_cpu_spec->dcache_bsize;
+	sizep = of_get_property(np, propnames[0], NULL);
+	if (sizep != NULL)
+		size = be32_to_cpu(*sizep);
+	setsp = of_get_property(np, propnames[1], NULL);
+	if (setsp != NULL)
+		sets = be32_to_cpu(*setsp);
+	bsizep = of_get_property(np, propnames[2], NULL);
+	lsizep = of_get_property(np, propnames[3], NULL);
+	if (bsizep == NULL)
+		bsizep = lsizep;
+	if (lsizep != NULL)
+		lsize = be32_to_cpu(*lsizep);
+	if (bsizep != NULL)
+		bsize = be32_to_cpu(*bsizep);
+	if (sizep == NULL || bsizep == NULL || lsizep == NULL)
+		success = false;
+
+	/* OF is weird .. it represents fully associative caches
+	 * as "1 way" which doesn't make much sense and doesn't
+	 * leave room for direct mapped. We'll assume that 0
+	 * in OF means direct mapped for that reason.
+	 */
+	if (sets == 1)
+		sets = 0;
+	else if (sets == 0)
+		sets = 1;
+
+	info->size = size;
+	info->sets = sets;
+	info->line_size = lsize;
+	info->block_size = bsize;
+	info->log_block_size = __ilog2(bsize);
+	info->blocks_per_page = PAGE_SIZE / bsize;
+
+	return success;
+}
+
 void __init initialize_cache_info(void)
 {
 	struct device_node *np;
-	unsigned long num_cpus = 0;
 
 	DBG(" -> initialize_cache_info()\n");
 
-	for_each_node_by_type(np, "cpu") {
-		num_cpus += 1;
+	np  = of_find_node_by_type(NULL, "cpu");
 
-		/*
-		 * We're assuming *all* of the CPUs have the same
-		 * d-cache and i-cache sizes... -Peter
-		 */
-		if (num_cpus == 1) {
-			const __be32 *sizep, *lsizep, *bsizep, *setsp;
-			u32 size, lsize, bsize, sets;
-
-			size = 0;
-			sets = -1u;
-			lsize = bsize = cur_cpu_spec->dcache_bsize;
-			sizep = of_get_property(np, "d-cache-size", NULL);
-			if (sizep != NULL)
-				size = be32_to_cpu(*sizep);
-			setsp = of_get_property(np, "d-cache-sets", NULL);
-			if (setsp != NULL)
-				sets = be32_to_cpu(*setsp);
-			bsizep = of_get_property(np, "d-cache-block-size",
-						 NULL);
-			lsizep = of_get_property(np, "d-cache-line-size",
-						 NULL);
-			if (bsizep == NULL)
-				bsizep = lsizep;
-			if (lsizep != NULL)
-				lsize = be32_to_cpu(*lsizep);
-			if (bsizep != NULL)
-				bsize = be32_to_cpu(*bsizep);
-			if (sizep == NULL || bsizep == NULL || lsizep == NULL)
-				DBG("Argh, can't find dcache properties ! "
-				    "sizep: %p, bsizep: %p, lsizep: %p\n",
-				    sizep, bsizep, lsizep);
-
-			/* OF is weird .. it represents fully associative caches
-			 * as "1 way" which doesn't make much sense and doesn't
-			 * leave room for direct mapped. We'll assume that 0
-			 * in OF means direct mapped for that reason.
-			 */
-			if (sets == 1)
-				sets = 0;
-			else if (sets == 0)
-				sets = 1;
-			ppc64_caches.dsize = size;
-			ppc64_caches.dsets = sets;
-			ppc64_caches.dline_size = lsize;
-			ppc64_caches.dblock_size = bsize;
-			ppc64_caches.log_dblock_size = __ilog2(bsize);
-			ppc64_caches.dblocks_per_page = PAGE_SIZE / bsize;
-
-			size = 0;
-			sets = -1u;
-			lsize = bsize = cur_cpu_spec->icache_bsize;
-			sizep = of_get_property(np, "i-cache-size", NULL);
-			if (sizep != NULL)
-				size = be32_to_cpu(*sizep);
-			setsp = of_get_property(np, "i-cache-sets", NULL);
-			if (setsp != NULL)
-				sets = be32_to_cpu(*setsp);
-			bsizep = of_get_property(np, "i-cache-block-size",
-						 NULL);
-			lsizep = of_get_property(np, "i-cache-line-size",
-						 NULL);
-			if (bsizep == NULL)
-				bsizep = lsizep;
-			if (lsizep != NULL)
-				lsize = be32_to_cpu(*lsizep);
-			if (bsizep != NULL)
-				bsize = be32_to_cpu(*bsizep);
-			if (sizep == NULL || bsizep == NULL || lsizep == NULL)
-				DBG("Argh, can't find icache properties ! "
-				    "sizep: %p, bsizep: %p, lsizep: %p\n",
-				    sizep, bsizep, lsizep);
-
-			if (sets == 1)
-				sets = 0;
-			else if (sets == 0)
-				sets = 1;
-			ppc64_caches.isize = size;
-			ppc64_caches.isets = sets;
-			ppc64_caches.iline_size = lsize;
-			ppc64_caches.iblock_size = bsize;
-			ppc64_caches.log_iblock_size = __ilog2(bsize);
-			ppc64_caches.iblocks_per_page = PAGE_SIZE / bsize;
-		}
+	/*
+	 * We're assuming *all* of the CPUs have the same
+	 * d-cache and i-cache sizes... -Peter
+	 */
+	if (np) {
+		if (!parse_cache_info(np, false, &ppc64_caches.l1d))
+			DBG("Argh, can't find dcache properties !\n");
+
+		if (!parse_cache_info(np, true, &ppc64_caches.l1i))
+			DBG("Argh, can't find icache properties !\n");
 	}
 
 	/* For use by binfmt_elf */
-	dcache_bsize = ppc64_caches.dblock_size;
-	icache_bsize = ppc64_caches.iblock_size;
-	il1cache_shape = format_cache_shape(ppc64_caches.isize,
-					    ppc64_caches.isets,
-					    ppc64_caches.iline_size);
-	dl1cache_shape = format_cache_shape(ppc64_caches.dsize,
-					    ppc64_caches.dsets,
-					    ppc64_caches.dline_size);
+	dcache_bsize = ppc64_caches.l1d.block_size;
+	icache_bsize = ppc64_caches.l1i.block_size;
+	dl1cache_shape = format_cache_shape(&ppc64_caches.l1d);
+	il1cache_shape = format_cache_shape(&ppc64_caches.l1i);
 
 	DBG(" <- initialize_cache_info()\n");
 }
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 9c0a857..22b01a3 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -736,14 +736,14 @@ static int __init vdso_init(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		vdso_data->platform |= 1;
 	vdso_data->physicalMemorySize = memblock_phys_mem_size();
-	vdso_data->dcache_size = ppc64_caches.dsize;
-	vdso_data->dcache_line_size = ppc64_caches.dline_size;
-	vdso_data->icache_size = ppc64_caches.isize;
-	vdso_data->icache_line_size = ppc64_caches.iline_size;
-	vdso_data->dcache_block_size = ppc64_caches.dblock_size;
-	vdso_data->icache_block_size = ppc64_caches.iblock_size;
-	vdso_data->dcache_log_block_size = ppc64_caches.log_dblock_size;
-	vdso_data->icache_log_block_size = ppc64_caches.log_iblock_size;
+	vdso_data->dcache_size = ppc64_caches.l1d.size;
+	vdso_data->dcache_line_size = ppc64_caches.l1d.line_size;
+	vdso_data->icache_size = ppc64_caches.l1i.size;
+	vdso_data->icache_line_size = ppc64_caches.l1i.line_size;
+	vdso_data->dcache_block_size = ppc64_caches.l1d.block_size;
+	vdso_data->icache_block_size = ppc64_caches.l1i.block_size;
+	vdso_data->dcache_log_block_size = ppc64_caches.l1d.log_block_size;
+	vdso_data->icache_log_block_size = ppc64_caches.l1i.log_block_size;
 
 	/*
 	 * Calculate the size of the 64 bits vDSO
-- 
2.7.4
