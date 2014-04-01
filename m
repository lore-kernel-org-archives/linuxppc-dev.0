Return-Path: <Emilian.Medve@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 091971400A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 18:53:32 +1100 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc: Enable NO_BOOTMEM
Date: Tue, 1 Apr 2014 02:21:31 -0500
Message-ID: <1396336891-13480-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1396336891-13480-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1396336891-13480-1-git-send-email-Emilian.Medve@Freescale.com>
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

Currently bootmem is just a wrapper around memblock. This gets rid of
the wrapper code just as other ARHC(es) did: x86, arm, etc.

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/Kconfig  | 3 +++
 arch/powerpc/mm/mem.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 957d3e5..2a2d4b3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -471,6 +471,9 @@ config SYS_SUPPORTS_HUGETLBFS
 
 source "mm/Kconfig"
 
+config NO_BOOTMEM
+	def_bool y
+
 config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
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
1.9.1
