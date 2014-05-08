Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7ECF140102
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 17:40:37 +1000 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2 v3] powerpc: Enable NO_BOOTMEM
Date: Thu, 8 May 2014 02:06:39 -0500
Message-ID: <1399532799-1557-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1399532799-1557-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1399532799-1557-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently bootmem is just a wrapper around/on top of memblock. This
eliminates from the build/kernel image the bootmem code and the
initialization wrapper code just as other ARHC(es) did: x86, arm,
etc

For now only cover !NUMA systems

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

v2: Acknowledge that NUMA systems/builds are not covered by this patch

v3: Don't re-define NO_BOOTMEM
    Update the commit message

 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/mm/mem.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e099899..3499303 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -105,6 +105,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
 	select HAVE_ARCH_TRACEHOOK
+	select NO_BOOTMEM if !NUMA
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_ATTRS
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index eaf5d1d8..d3e1d5f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -187,10 +187,12 @@ EXPORT_SYMBOL_GPL(walk_system_ram_range);
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 void __init do_init_bootmem(void)
 {
+#ifndef CONFIG_NO_BOOTMEM
 	unsigned long start, bootmap_pages;
 	struct memblock_region *reg;
 	int boot_mapsize;
 	phys_addr_t _total_lowmem;
+#endif
 	phys_addr_t _lowmem_end_addr;
 
 #ifndef CONFIG_HIGHMEM
@@ -203,6 +205,7 @@ void __init do_init_bootmem(void)
 	max_low_pfn = _lowmem_end_addr >> PAGE_SHIFT;
 	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
 
+#ifndef CONFIG_NO_BOOTMEM
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
 	 * bitmap required as (Total Memory) / PAGE_SIZE / BITS_PER_BYTE.
@@ -214,12 +217,14 @@ void __init do_init_bootmem(void)
 	start = memblock_alloc(bootmap_pages << PAGE_SHIFT, PAGE_SIZE);
 
 	boot_mapsize = init_bootmem_node(NODE_DATA(0), start >> PAGE_SHIFT, min_low_pfn, max_low_pfn);
+#endif
 
 	/* Place all memblock_regions in the same node and merge contiguous
 	 * memblock_regions
 	 */
 	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);
 
+#ifndef CONFIG_NO_BOOTMEM
 	/* Add all physical memory to the bootmem map, mark each area
 	 * present.
 	 */
@@ -234,11 +239,14 @@ void __init do_init_bootmem(void)
 			reserve_bootmem(reg->base, trunc_size, BOOTMEM_DEFAULT);
 		}
 	}
+#endif
 
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
 
+#ifndef CONFIG_NO_BOOTMEM
 	init_bootmem_done = 1;
+#endif
 }
 
 /* mark pages that don't exist as nosave */
-- 
1.9.2
