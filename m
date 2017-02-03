Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDZJ1znkzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:06:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 5/9] powerpc/64: Retrieve number of L1 cache sets from
 device-tree
Date: Fri,  3 Feb 2017 22:05:55 +1100
Message-Id: <1486119959-21662-5-git-send-email-mpe@ellerman.id.au>
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

It will be used to calculate the associativity

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cache.h |  2 ++
 arch/powerpc/kernel/setup_64.c   | 28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 25ee433a8261..1fa364340146 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -36,11 +36,13 @@ struct ppc64_caches {
 	u32	dblock_size;		/* L1 d-cache block size */
 	u32	log_dblock_size;
 	u32	dblocks_per_page;
+	u32	dsets;
 	u32	isize;			/* L1 i-cache size */
 	u32	iline_size;		/* L1 d-cache line size	*/
 	u32	iblock_size;		/* L1 i-cache block size */
 	u32	log_iblock_size;
 	u32	iblocks_per_page;
+	u32	isets;
 };
 
 extern struct ppc64_caches ppc64_caches;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 08cccb2501e7..75c9a8641ba1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -412,14 +412,18 @@ void __init initialize_cache_info(void)
 		 * d-cache and i-cache sizes... -Peter
 		 */
 		if (num_cpus == 1) {
-			const __be32 *sizep, *lsizep, *bsizep;
-			u32 size, lsize, bsize;
+			const __be32 *sizep, *lsizep, *bsizep, *setsp;
+			u32 size, lsize, bsize, sets;
 
 			size = 0;
+			sets = -1u;
 			lsize = bsize = cur_cpu_spec->dcache_bsize;
 			sizep = of_get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = be32_to_cpu(*sizep);
+			setsp = of_get_property(np, "d-cache-sets", NULL);
+			if (setsp != NULL)
+				sets = be32_to_cpu(*setsp);
 			bsizep = of_get_property(np, "d-cache-block-size",
 						 NULL);
 			lsizep = of_get_property(np, "d-cache-line-size",
@@ -435,17 +439,32 @@ void __init initialize_cache_info(void)
 				    "sizep: %p, bsizep: %p, lsizep: %p\n",
 				    sizep, bsizep, lsizep);
 
+			/*
+			 * OF is weird .. it represents fully associative caches
+			 * as "1 way" which doesn't make much sense and doesn't
+			 * leave room for direct mapped. We'll assume that 0
+			 * in OF means direct mapped for that reason.
+			 */
+			if (sets == 1)
+				sets = 0;
+			else if (sets == 0)
+				sets = 1;
 			ppc64_caches.dsize = size;
+			ppc64_caches.dsets = sets;
 			ppc64_caches.dline_size = lsize;
 			ppc64_caches.dblock_size = bsize;
 			ppc64_caches.log_dblock_size = __ilog2(bsize);
 			ppc64_caches.dblocks_per_page = PAGE_SIZE / bsize;
 
 			size = 0;
+			sets = -1u;
 			lsize = bsize = cur_cpu_spec->icache_bsize;
 			sizep = of_get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = be32_to_cpu(*sizep);
+			setsp = of_get_property(np, "i-cache-sets", NULL);
+			if (setsp != NULL)
+				sets = be32_to_cpu(*setsp);
 			bsizep = of_get_property(np, "i-cache-block-size",
 						 NULL);
 			lsizep = of_get_property(np, "i-cache-line-size",
@@ -461,7 +480,12 @@ void __init initialize_cache_info(void)
 				    "sizep: %p, bsizep: %p, lsizep: %p\n",
 				    sizep, bsizep, lsizep);
 
+			if (sets == 1)
+				sets = 0;
+			else if (sets == 0)
+				sets = 1;
 			ppc64_caches.isize = size;
+			ppc64_caches.isets = sets;
 			ppc64_caches.iline_size = lsize;
 			ppc64_caches.iblock_size = bsize;
 			ppc64_caches.log_iblock_size = __ilog2(bsize);
-- 
2.7.4
