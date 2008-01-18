Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail77-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A56BEDDF69
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:18 +1100 (EST)
Message-ID: <47910CFB.3060505@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:59 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 15/16] PS3: Revove use lpar address workaround
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the PS3 workaround needed to support sparsemem SPU mappings.
The SPU mappings no longer use sparsemem, so this workaround is no
longer needed.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/Kconfig |   11 -----------
 arch/powerpc/platforms/ps3/mm.c    |   16 ++++------------
 include/asm-powerpc/sparsemem.h    |    5 -----
 3 files changed, 4 insertions(+), 28 deletions(-)

--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -61,17 +61,6 @@ config PS3_DYNAMIC_DMA
 	  This support is mainly for Linux kernel development.  If unsure,
 	  say N.
 
-config PS3_USE_LPAR_ADDR
-	depends on PPC_PS3 && EXPERIMENTAL
-	bool "PS3 use lpar address space"
-	default y
-	help
-	  This option is solely for experimentation by experts.  Disables
-	  translation of lpar addresses.  SPE support currently won't work
-	  without this set to y.
-
-	  If you have any doubt, choose the default y.
-
 config PS3_VUART
 	depends on PPC_PS3
 	tristate
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -36,11 +36,6 @@
 #endif
 
 enum {
-#if defined(CONFIG_PS3_USE_LPAR_ADDR)
-	USE_LPAR_ADDR = 1,
-#else
-	USE_LPAR_ADDR = 0,
-#endif
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	USE_DYNAMIC_DMA = 1,
 #else
@@ -137,11 +132,8 @@ static struct map map;
 unsigned long ps3_mm_phys_to_lpar(unsigned long phys_addr)
 {
 	BUG_ON(is_kernel_addr(phys_addr));
-	if (USE_LPAR_ADDR)
-		return phys_addr;
-	else
-		return (phys_addr < map.rm.size || phys_addr >= map.total)
-			? phys_addr : phys_addr + map.r1.offset;
+	return (phys_addr < map.rm.size || phys_addr >= map.total)
+		? phys_addr : phys_addr + map.r1.offset;
 }
 
 EXPORT_SYMBOL(ps3_mm_phys_to_lpar);
@@ -309,7 +301,7 @@ static int __init ps3_mm_add_memory(void
 
 	BUG_ON(!mem_init_done);
 
-	start_addr = USE_LPAR_ADDR ? map.r1.base : map.rm.size;
+	start_addr = map.rm.size;
 	start_pfn = start_addr >> PAGE_SHIFT;
 	nr_pages = (map.r1.size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
@@ -1007,7 +999,7 @@ static int dma_sb_region_create_linear(s
 
 	if (r->offset + r->len > map.rm.size) {
 		/* Map (part of) 2nd RAM chunk */
-		virt_addr = USE_LPAR_ADDR ? map.r1.base : map.rm.size;
+		virt_addr = map.rm.size;
 		len = r->len;
 		if (r->offset >= map.rm.size)
 			virt_addr += r->offset - map.rm.size;
--- a/include/asm-powerpc/sparsemem.h
+++ b/include/asm-powerpc/sparsemem.h
@@ -10,13 +10,8 @@
  */
 #define SECTION_SIZE_BITS       24
 
-#if defined(CONFIG_PS3_USE_LPAR_ADDR)
-#define MAX_PHYSADDR_BITS       47
-#define MAX_PHYSMEM_BITS        47
-#else
 #define MAX_PHYSADDR_BITS       44
 #define MAX_PHYSMEM_BITS        44
-#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void create_section_mapping(unsigned long start, unsigned long end);

-- 
