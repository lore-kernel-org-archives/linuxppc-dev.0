Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttfFx1LbnzDqWC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 16:17:40 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/9] powerpc/64: Fix naming of cache block vs. cache line
Date: Wed,  4 Jan 2017 16:15:30 +1100
Message-Id: <20170104051535.9454-4-benh@kernel.crashing.org>
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

In a number of places we called "cache line size" what is actually
the cache block size, which in the powerpc architecture, means the
effective size to use with cache management instructions (it can
be different from the actual cache line size).

We fix the naming across the board and properly retrieve both
pieces of information when available in the device-tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/cache.h   | 12 ++++---
 arch/powerpc/include/asm/page_64.h |  4 +--
 arch/powerpc/kernel/align.c        |  2 +-
 arch/powerpc/kernel/asm-offsets.c  | 12 +++----
 arch/powerpc/kernel/misc_64.S      | 28 ++++++++--------
 arch/powerpc/kernel/setup_64.c     | 65 +++++++++++++++++++++-----------------
 arch/powerpc/kernel/vdso.c         | 10 +++---
 arch/powerpc/lib/copypage_64.S     |  4 +--
 arch/powerpc/lib/string_64.S       |  6 ++--
 9 files changed, 75 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index ffbafbf..c74ebc2 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -30,12 +30,14 @@
 struct ppc64_caches {
 	u32	dsize;			/* L1 d-cache size */
 	u32	dline_size;		/* L1 d-cache line size	*/
-	u32	log_dline_size;
-	u32	dlines_per_page;
+	u32	dblock_size;		/* L1 d-cache block size */
+	u32	log_dblock_size;
+	u32	dblocks_per_page;
 	u32	isize;			/* L1 i-cache size */
-	u32	iline_size;		/* L1 i-cache line size	*/
-	u32	log_iline_size;
-	u32	ilines_per_page;
+	u32	iline_size;		/* L1 d-cache line size	*/
+	u32	iblock_size;		/* L1 i-cache block size */
+	u32	log_iblock_size;
+	u32	iblocks_per_page;
 };
 
 extern struct ppc64_caches ppc64_caches;
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index dd5f071..c50a666 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -47,14 +47,14 @@ static inline void clear_page(void *addr)
 	unsigned long iterations;
 	unsigned long onex, twox, fourx, eightx;
 
-	iterations = ppc64_caches.dlines_per_page / 8;
+	iterations = ppc64_caches.dblocks_per_page / 8;
 
 	/*
 	 * Some verisions of gcc use multiply instructions to
 	 * calculate the offsets so lets give it a hand to
 	 * do better.
 	 */
-	onex = ppc64_caches.dline_size;
+	onex = ppc64_caches.dblock_size;
 	twox = onex << 1;
 	fourx = onex << 2;
 	eightx = onex << 3;
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 033f338..a617751 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -204,7 +204,7 @@ static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
 	int i, size;
 
 #ifdef __powerpc64__
-	size = ppc64_caches.dline_size;
+	size = ppc64_caches.dblock_size;
 #else
 	size = L1_CACHE_BYTES;
 #endif
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b89d14c..e2a881f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -160,12 +160,12 @@ int main(void)
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 
 #ifdef CONFIG_PPC64
-	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
-	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
-	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
-	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
-	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
-	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
+	DEFINE(DCACHEL1BLOCKSIZE, offsetof(struct ppc64_caches, dblock_size));
+	DEFINE(DCACHEL1LOGBLOCKSIZE, offsetof(struct ppc64_caches, log_dblock_size));
+	DEFINE(DCACHEL1BLOCKSPERPAGE, offsetof(struct ppc64_caches, dblocks_per_page));
+	DEFINE(ICACHEL1BLOCKSIZE, offsetof(struct ppc64_caches, iblock_size));
+	DEFINE(ICACHEL1LOGBLOCKSIZE, offsetof(struct ppc64_caches, log_iblock_size));
+	DEFINE(ICACHEL1BLOCKSPERPAGE, offsetof(struct ppc64_caches, iblocks_per_page));
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
 	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index cb19515..70bc6f1 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -79,12 +79,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
  * each other.
  */
  	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1LINESIZE(r10)/* Get cache line size */
+	lwz	r7,DCACHEL1BLOCKSIZE(r10)/* Get cache block size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGLINESIZE(r10)	/* Get log-2 of cache line size */
+	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of cache block size */
 	srw.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mtctr	r8
@@ -95,12 +95,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 
 /* Now invalidate the instruction cache */
 	
-	lwz	r7,ICACHEL1LINESIZE(r10)	/* Get Icache line size */
+	lwz	r7,ICACHEL1BLOCKSIZE(r10)	/* Get Icache block size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5
-	lwz	r9,ICACHEL1LOGLINESIZE(r10)	/* Get log-2 of Icache line size */
+	lwz	r9,ICACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of Icache block size */
 	srw.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mtctr	r8
@@ -125,12 +125,12 @@ _GLOBAL(flush_dcache_range)
  * Different systems have different cache line sizes
  */
  	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1LINESIZE(r10)	/* Get dcache line size */
+	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGLINESIZE(r10)	/* Get log-2 of dcache line size */
+	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of dcache block size */
 	srw.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mtctr	r8
@@ -152,12 +152,12 @@ _GLOBAL(flush_dcache_range)
  */
 _GLOBAL(flush_dcache_phys_range)
  	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1LINESIZE(r10)	/* Get dcache line size */
+	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGLINESIZE(r10)	/* Get log-2 of dcache line size */
+	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of dcache block size */
 	srw.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mfmsr	r5			/* Disable MMU Data Relocation */
@@ -180,12 +180,12 @@ _GLOBAL(flush_dcache_phys_range)
 
 _GLOBAL(flush_inval_dcache_range)
  	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1LINESIZE(r10)	/* Get dcache line size */
+	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGLINESIZE(r10)/* Get log-2 of dcache line size */
+	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)/* Get log-2 of dcache block size */
 	srw.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	sync
@@ -221,8 +221,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 /* Flush the dcache */
  	ld	r7,PPC64_CACHES@toc(r2)
 	clrrdi	r3,r3,PAGE_SHIFT           	    /* Page align */
-	lwz	r4,DCACHEL1LINESPERPAGE(r7)	/* Get # dcache lines per page */
-	lwz	r5,DCACHEL1LINESIZE(r7)		/* Get dcache line size */
+	lwz	r4,DCACHEL1BLOCKSPERPAGE(r7)	/* Get # dcache blocks per page */
+	lwz	r5,DCACHEL1BLOCKSIZE(r7)	/* Get dcache block size */
 	mr	r6,r3
 	mtctr	r4
 0:	dcbst	0,r6
@@ -232,8 +232,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 
 /* Now invalidate the icache */	
 
-	lwz	r4,ICACHEL1LINESPERPAGE(r7)	/* Get # icache lines per page */
-	lwz	r5,ICACHEL1LINESIZE(r7)		/* Get icache line size */
+	lwz	r4,ICACHEL1BLOCKSPERPAGE(r7)	/* Get # icache blocks per page */
+	lwz	r5,ICACHEL1BLOCKSIZE(r7)	/* Get icache block size */
 	mtctr	r4
 1:	icbi	0,r3
 	add	r3,r3,r5
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 222bbb0..e7e5c1b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -78,10 +78,10 @@ int spinning_secondaries;
 u64 ppc64_pft_size;
 
 struct ppc64_caches ppc64_caches = {
-	.dline_size = 0x40,
-	.log_dline_size = 6,
-	.iline_size = 0x40,
-	.log_iline_size = 6
+	.dblock_size = 0x40,
+	.log_dblock_size = 6,
+	.iblock_size = 0x40,
+	.log_iblock_size = 6
 };
 EXPORT_SYMBOL_GPL(ppc64_caches);
 
@@ -404,59 +404,66 @@ void __init initialize_cache_info(void)
 		 * d-cache and i-cache sizes... -Peter
 		 */
 		if (num_cpus == 1) {
-			const __be32 *sizep, *lsizep;
-			u32 size, lsize;
+			const __be32 *sizep, *lsizep, *bsizep;
+			u32 size, lsize, bsize;
 
 			size = 0;
-			lsize = cur_cpu_spec->dcache_bsize;
+			lsize = bsize = cur_cpu_spec->dcache_bsize;
 			sizep = of_get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = be32_to_cpu(*sizep);
-			lsizep = of_get_property(np, "d-cache-block-size",
+			bsizep = of_get_property(np, "d-cache-block-size",
 						 NULL);
-			/* fallback if block size missing */
-			if (lsizep == NULL)
-				lsizep = of_get_property(np,
-							 "d-cache-line-size",
-							 NULL);
+			lsizep = of_get_property(np, "d-cache-line-size",
+						 NULL);
+			if (bsizep == NULL)
+				bsizep = lsizep;
 			if (lsizep != NULL)
 				lsize = be32_to_cpu(*lsizep);
-			if (sizep == NULL || lsizep == NULL)
+			if (bsizep != NULL)
+				bsize = be32_to_cpu(*bsizep);
+			if (sizep == NULL || bsizep == NULL || lsizep == NULL)
 				DBG("Argh, can't find dcache properties ! "
-				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
+				    "sizep: %p, bsizep: %p, lsizep: %p\n",
+				    sizep, bsizep, lsizep);
 
 			ppc64_caches.dsize = size;
 			ppc64_caches.dline_size = lsize;
-			ppc64_caches.log_dline_size = __ilog2(lsize);
-			ppc64_caches.dlines_per_page = PAGE_SIZE / lsize;
+			ppc64_caches.dblock_size = bsize;
+			ppc64_caches.log_dblock_size = __ilog2(bsize);
+			ppc64_caches.dblocks_per_page = PAGE_SIZE / bsize;
 
 			size = 0;
-			lsize = cur_cpu_spec->icache_bsize;
+			lsize = bsize = cur_cpu_spec->icache_bsize;
 			sizep = of_get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = be32_to_cpu(*sizep);
-			lsizep = of_get_property(np, "i-cache-block-size",
+			bsizep = of_get_property(np, "i-cache-block-size",
+						 NULL);
+			lsizep = of_get_property(np, "i-cache-line-size",
 						 NULL);
-			if (lsizep == NULL)
-				lsizep = of_get_property(np,
-							 "i-cache-line-size",
-							 NULL);
+			if (bsizep == NULL)
+				bsizep = lsizep;
 			if (lsizep != NULL)
 				lsize = be32_to_cpu(*lsizep);
-			if (sizep == NULL || lsizep == NULL)
+			if (bsizep != NULL)
+				bsize = be32_to_cpu(*bsizep);
+			if (sizep == NULL || bsizep == NULL || lsizep == NULL)
 				DBG("Argh, can't find icache properties ! "
-				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
+				    "sizep: %p, bsizep: %p, lsizep: %p\n",
+				    sizep, bsizep, lsizep);
 
 			ppc64_caches.isize = size;
 			ppc64_caches.iline_size = lsize;
-			ppc64_caches.log_iline_size = __ilog2(lsize);
-			ppc64_caches.ilines_per_page = PAGE_SIZE / lsize;
+			ppc64_caches.iblock_size = bsize;
+			ppc64_caches.log_iblock_size = __ilog2(bsize);
+			ppc64_caches.iblocks_per_page = PAGE_SIZE / bsize;
 		}
 	}
 
 	/* For use by binfmt_elf */
-	dcache_bsize = ppc64_caches.dline_size;
-	icache_bsize = ppc64_caches.iline_size;
+	dcache_bsize = ppc64_caches.dblock_size;
+	icache_bsize = ppc64_caches.iblock_size;
 
 	DBG(" <- initialize_cache_info()\n");
 }
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4111d30..9c0a857 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -740,12 +740,10 @@ static int __init vdso_init(void)
 	vdso_data->dcache_line_size = ppc64_caches.dline_size;
 	vdso_data->icache_size = ppc64_caches.isize;
 	vdso_data->icache_line_size = ppc64_caches.iline_size;
-
-	/* XXXOJN: Blocks should be added to ppc64_caches and used instead */
-	vdso_data->dcache_block_size = ppc64_caches.dline_size;
-	vdso_data->icache_block_size = ppc64_caches.iline_size;
-	vdso_data->dcache_log_block_size = ppc64_caches.log_dline_size;
-	vdso_data->icache_log_block_size = ppc64_caches.log_iline_size;
+	vdso_data->dcache_block_size = ppc64_caches.dblock_size;
+	vdso_data->icache_block_size = ppc64_caches.iblock_size;
+	vdso_data->dcache_log_block_size = ppc64_caches.log_dblock_size;
+	vdso_data->icache_log_block_size = ppc64_caches.log_iblock_size;
 
 	/*
 	 * Calculate the size of the 64 bits vDSO
diff --git a/arch/powerpc/lib/copypage_64.S b/arch/powerpc/lib/copypage_64.S
index a3c4dc4..0c3bd46 100644
--- a/arch/powerpc/lib/copypage_64.S
+++ b/arch/powerpc/lib/copypage_64.S
@@ -25,8 +25,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
 	ori	r5,r5,PAGE_SIZE@l
 BEGIN_FTR_SECTION
 	ld      r10,PPC64_CACHES@toc(r2)
-	lwz	r11,DCACHEL1LOGLINESIZE(r10)	/* log2 of cache line size */
-	lwz     r12,DCACHEL1LINESIZE(r10)	/* get cache line size */
+	lwz	r11,DCACHEL1LOGBLOCKSIZE(r10)	/* log2 of cache block size */
+	lwz     r12,DCACHEL1BLOCKSIZE(r10)	/* get cache block size */
 	li	r9,0
 	srd	r8,r5,r11
 
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index 7bd9549..9907379 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -159,9 +159,9 @@ err2;	std	r0,0(r3)
 	addi	r3,r3,8
 	addi	r4,r4,-8
 
-	/* Destination is 16 byte aligned, need to get it cacheline aligned */
-11:	lwz	r7,DCACHEL1LOGLINESIZE(r5)
-	lwz	r9,DCACHEL1LINESIZE(r5)
+	/* Destination is 16 byte aligned, need to get it cache block aligned */
+11:	lwz	r7,DCACHEL1LOGBLOCKSIZE(r5)
+	lwz	r9,DCACHEL1BLOCKSIZE(r5)
 
 	/*
 	 * With worst case alignment the long clear loop takes a minimum
-- 
2.9.3
