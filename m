Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id B226F1A03BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 01:02:17 +1100 (AEDT)
Message-Id: <1185708af6cc237ced3ea854da49d9b149c1c6a7.1446893433.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1446893426.git.christophe.leroy@c-s.fr>
References: <cover.1446893426.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 20/23] powerpc32: move xxxxx_dcache_range() functions inline
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Nov 2015 14:32:40 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

flush/clean/invalidate _dcache_range() functions are all very
similar and are quite short. They are mainly used in __dma_sync()
perf_event locate them in the top 3 consumming functions during
heavy ethernet activity

They are good candidate for inlining, as __dma_sync() does
almost nothing but calling them

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: new
v3: no change

 arch/powerpc/include/asm/cacheflush.h | 52 ++++++++++++++++++++++++++--
 arch/powerpc/kernel/misc_32.S         | 65 -----------------------------------
 arch/powerpc/kernel/ppc_ksyms.c       |  2 ++
 3 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 6229e6b..97c9978 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -47,12 +47,58 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
 }
 #endif
 
-extern void flush_dcache_range(unsigned long start, unsigned long stop);
 #ifdef CONFIG_PPC32
-extern void clean_dcache_range(unsigned long start, unsigned long stop);
-extern void invalidate_dcache_range(unsigned long start, unsigned long stop);
+/*
+ * Write any modified data cache blocks out to memory and invalidate them.
+ * Does not invalidate the corresponding instruction cache blocks.
+ */
+static inline void flush_dcache_range(unsigned long start, unsigned long stop)
+{
+	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
+	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	unsigned long i;
+
+	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+		dcbf(addr);
+	mb();	/* sync */
+}
+
+/*
+ * Write any modified data cache blocks out to memory.
+ * Does not invalidate the corresponding cache lines (especially for
+ * any corresponding instruction cache).
+ */
+static inline void clean_dcache_range(unsigned long start, unsigned long stop)
+{
+	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
+	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	unsigned long i;
+
+	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+		dcbst(addr);
+	mb();	/* sync */
+}
+
+/*
+ * Like above, but invalidate the D-cache.  This is used by the 8xx
+ * to invalidate the cache so the PPC core doesn't get stale data
+ * from the CPM (no cache snooping here :-).
+ */
+static inline void invalidate_dcache_range(unsigned long start,
+					   unsigned long stop)
+{
+	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
+	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	unsigned long i;
+
+	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+		dcbi(addr);
+	mb();	/* sync */
+}
+
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
+extern void flush_dcache_range(unsigned long start, unsigned long stop);
 extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
 extern void flush_dcache_phys_range(unsigned long start, unsigned long stop);
 #endif
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index ce3ca08..1728f61 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -375,71 +375,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	isync
 	blr
 /*
- * Write any modified data cache blocks out to memory.
- * Does not invalidate the corresponding cache lines (especially for
- * any corresponding instruction cache).
- *
- * clean_dcache_range(unsigned long start, unsigned long stop)
- */
-_GLOBAL(clean_dcache_range)
-	li	r5,L1_CACHE_BYTES-1
-	andc	r3,r3,r5
-	subf	r4,r3,r4
-	add	r4,r4,r5
-	srwi.	r4,r4,L1_CACHE_SHIFT
-	beqlr
-	mtctr	r4
-
-1:	dcbst	0,r3
-	addi	r3,r3,L1_CACHE_BYTES
-	bdnz	1b
-	sync				/* wait for dcbst's to get to ram */
-	blr
-
-/*
- * Write any modified data cache blocks out to memory and invalidate them.
- * Does not invalidate the corresponding instruction cache blocks.
- *
- * flush_dcache_range(unsigned long start, unsigned long stop)
- */
-_GLOBAL(flush_dcache_range)
-	li	r5,L1_CACHE_BYTES-1
-	andc	r3,r3,r5
-	subf	r4,r3,r4
-	add	r4,r4,r5
-	srwi.	r4,r4,L1_CACHE_SHIFT
-	beqlr
-	mtctr	r4
-
-1:	dcbf	0,r3
-	addi	r3,r3,L1_CACHE_BYTES
-	bdnz	1b
-	sync				/* wait for dcbst's to get to ram */
-	blr
-
-/*
- * Like above, but invalidate the D-cache.  This is used by the 8xx
- * to invalidate the cache so the PPC core doesn't get stale data
- * from the CPM (no cache snooping here :-).
- *
- * invalidate_dcache_range(unsigned long start, unsigned long stop)
- */
-_GLOBAL(invalidate_dcache_range)
-	li	r5,L1_CACHE_BYTES-1
-	andc	r3,r3,r5
-	subf	r4,r3,r4
-	add	r4,r4,r5
-	srwi.	r4,r4,L1_CACHE_SHIFT
-	beqlr
-	mtctr	r4
-
-1:	dcbi	0,r3
-	addi	r3,r3,L1_CACHE_BYTES
-	bdnz	1b
-	sync				/* wait for dcbi's to get to ram */
-	blr
-
-/*
  * Flush a particular page from the data cache to RAM.
  * Note: this is necessary because the instruction cache does *not*
  * snoop from the data cache.
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 202963e..0546947 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -6,7 +6,9 @@
 #include <asm/cacheflush.h>
 #include <asm/epapr_hcalls.h>
 
+#ifdef CONFIG_PPC64
 EXPORT_SYMBOL(flush_dcache_range);
+#endif
 EXPORT_SYMBOL(flush_icache_range);
 
 EXPORT_SYMBOL(empty_zero_page);
-- 
2.1.0
