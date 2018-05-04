Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crzj70vjzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:34:09 +1000 (AEST)
Message-Id: <169393618e2097260ef83f3489abc5a707d3107c.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  07/17] powerpc: make ioremap_bot common to PPC32 and PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:04 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today, early ioremap maps from IOREMAP_BASE down to up on PPC64
and from IOREMAP_TOP up to down on PPC32

This patchs modifies PPC32 behaviour to get same behaviour as PPC64

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 16 +++++++++-------
 arch/powerpc/include/asm/nohash/32/pgtable.h | 20 ++++++++------------
 arch/powerpc/mm/dma-noncoherent.c            |  2 +-
 arch/powerpc/mm/dump_linuxpagetables.c       |  6 +++---
 arch/powerpc/mm/init_32.c                    |  6 +++++-
 arch/powerpc/mm/ioremap.c                    | 22 ++++++++++------------
 arch/powerpc/mm/mem.c                        |  7 ++++---
 7 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c615abdce119..6cf962ec7a20 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -54,16 +54,17 @@
 #else
 #define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
 #endif
+#define IOREMAP_BASE	VMALLOC_BASE
 
 /*
- * ioremap_bot starts at that address. Early ioremaps move down from there,
- * until mem_init() at which point this becomes the top of the vmalloc
+ * ioremap_bot starts at IOREMAP_BASE. Early ioremaps move up from there,
+ * until mem_init() at which point this becomes the bottom of the vmalloc
  * and ioremap space
  */
 #ifdef CONFIG_NOT_COHERENT_CACHE
-#define IOREMAP_TOP	((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
+#define IOREMAP_END	((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
 #else
-#define IOREMAP_TOP	KVIRT_TOP
+#define IOREMAP_END	KVIRT_TOP
 #endif
 
 /*
@@ -85,11 +86,12 @@
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
 #ifdef PPC_PIN_SIZE
-#define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#define VMALLOC_BASE (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #else
-#define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#define VMALLOC_BASE ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #endif
-#define VMALLOC_END	ioremap_bot
+#define VMALLOC_START	ioremap_bot
+#define VMALLOC_END	IOREMAP_END
 
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 140f8e74b478..b413abcd5a09 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -80,10 +80,11 @@ extern int icache_44x_need_flush;
  * and ioremap space
  */
 #ifdef CONFIG_NOT_COHERENT_CACHE
-#define IOREMAP_TOP	((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
+#define IOREMAP_END	((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
 #else
-#define IOREMAP_TOP	KVIRT_TOP
+#define IOREMAP_END	KVIRT_TOP
 #endif
+#define IOREMAP_BASE	VMALLOC_BASE
 
 /*
  * Just any arbitrary offset to the start of the vmalloc VM area: the
@@ -94,21 +95,16 @@ extern int icache_44x_need_flush;
  * area for the same reason. ;)
  *
  * We no longer map larger than phys RAM with the BATs so we don't have
- * to worry about the VMALLOC_OFFSET causing problems.  We do have to worry
- * about clashes between our early calls to ioremap() that start growing down
- * from IOREMAP_TOP being run into the VM area allocations (growing upwards
- * from VMALLOC_START).  For this reason we have ioremap_bot to check when
- * we actually run into our mappings setup in the early boot with the VM
- * system.  This really does become a problem for machines with good amounts
- * of RAM.  -- Cort
+ * to worry about the VMALLOC_OFFSET causing problems.
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
 #ifdef PPC_PIN_SIZE
-#define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#define VMALLOC_BASE (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #else
-#define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#define VMALLOC_BASE ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #endif
-#define VMALLOC_END	ioremap_bot
+#define VMALLOC_START	ioremap_bot
+#define VMALLOC_END	IOREMAP_END
 
 /*
  * Bits in a linux-style PTE.  These match the bits in the
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 382528475433..d0a8fe74f5a0 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -43,7 +43,7 @@
  * can be further configured for specific applications under
  * the "Advanced Setup" menu. -Matt
  */
-#define CONSISTENT_BASE		(IOREMAP_TOP)
+#define CONSISTENT_BASE		(IOREMAP_END)
 #define CONSISTENT_END 		(CONSISTENT_BASE + CONFIG_CONSISTENT_SIZE)
 #define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
 
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 876e2a3c79f2..6022adb899b7 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -452,11 +452,11 @@ static void populate_markers(void)
 	address_markers[i++].start_address =  VMEMMAP_BASE;
 #endif
 #else /* !CONFIG_PPC64 */
+	address_markers[i++].start_address = IOREMAP_BASE;
 	address_markers[i++].start_address = ioremap_bot;
-	address_markers[i++].start_address = IOREMAP_TOP;
 #ifdef CONFIG_NOT_COHERENT_CACHE
-	address_markers[i++].start_address = IOREMAP_TOP;
-	address_markers[i++].start_address = IOREMAP_TOP +
+	address_markers[i++].start_address = IOREMAP_END;
+	address_markers[i++].start_address = IOREMAP_END +
 					     CONFIG_CONSISTENT_SIZE;
 #endif
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 3e59e5d64b01..7fb9e5a9852a 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -172,7 +172,11 @@ void __init MMU_init(void)
 	mapin_ram();
 
 	/* Initialize early top-down ioremap allocator */
-	ioremap_bot = IOREMAP_TOP;
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		high_memory = (void *) __va(lowmem_end_addr);
+	else
+		high_memory = (void *) __va(memblock_end_of_DRAM());
+	ioremap_bot = IOREMAP_BASE;
 
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:exit", 0x211);
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index f8dc9638c598..153657db084e 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -27,10 +27,13 @@
 
 #include "mmu_decl.h"
 
-#ifdef CONFIG_PPC32
-
+#if defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC32)
 unsigned long ioremap_bot;
-EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
+#else
+unsigned long ioremap_bot = IOREMAP_BASE;
+#endif
+
+#ifdef CONFIG_PPC32
 
 void __iomem *
 __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
@@ -51,7 +54,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	/*
 	 * Choose an address to map it to.
 	 * Once the vmalloc system is running, we use it.
-	 * Before then, we use space going down from IOREMAP_TOP
+	 * Before then, we use space going up from IOREMAP_BASE
 	 * (ioremap_bot records where we're up to).
 	 */
 	p = addr & PAGE_MASK;
@@ -96,7 +99,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 		area->phys_addr = p;
 		v = (unsigned long) area->addr;
 	} else {
-		v = (ioremap_bot -= size);
+		v = ioremap_bot;
+		ioremap_bot += size;
 	}
 
 	/*
@@ -125,19 +129,13 @@ void __iounmap(volatile void __iomem *addr)
 	if (v_block_mapped((unsigned long)addr))
 		return;
 
-	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
+	if ((unsigned long) addr >= ioremap_bot)
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
 }
 EXPORT_SYMBOL(__iounmap);
 
 #else
 
-#ifdef CONFIG_PPC_BOOK3S_64
-unsigned long ioremap_bot;
-#else /* !CONFIG_PPC_BOOK3S_64 */
-unsigned long ioremap_bot = IOREMAP_BASE;
-#endif
-
 /**
  * __ioremap_at - Low level function to establish the page tables
  *                for an IO mapping
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c3c39b02b2ba..b680aa78a4ac 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -345,8 +345,9 @@ void __init mem_init(void)
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(0);
 #endif
-
+#ifdef CONFIG_PPC64
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
+#endif
 	set_max_mapnr(max_pfn);
 	free_all_bootmem();
 
@@ -383,10 +384,10 @@ void __init mem_init(void)
 #endif /* CONFIG_HIGHMEM */
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
-		IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
+		IOREMAP_END, IOREMAP_END + CONFIG_CONSISTENT_SIZE);
 #endif /* CONFIG_NOT_COHERENT_CACHE */
 	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
-		ioremap_bot, IOREMAP_TOP);
+		IOREMAP_BASE, ioremap_bot);
 	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
 		VMALLOC_START, VMALLOC_END);
 #endif /* CONFIG_PPC32 */
-- 
2.13.3
