Return-Path: <dtcarroll@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C280B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 03:11:24 +1000 (EST)
Received: by pzk26 with SMTP id 26so406214pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 10:11:22 -0700 (PDT)
From: Dave Carroll <dtcarroll@gmail.com>
To: Milton Miller <miltonm@bga.com>
Subject: [PATCH v8] powerpc: Force page alignment for initrd reserved memory
Date: Thu, 26 May 2011 10:53:36 -0600
Message-Id: <1306428816-21789-1-git-send-email-dcarroll@astekcorp.com>
In-Reply-To: <initrd-align-v7-reply@mdm.bga.com>
References: <initrd-align-v7-reply@mdm.bga.com>
Cc: Dave Carroll <dcarroll@astekcorp.com>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Carroll <dcarroll@astekcorp.com>

When using 64K pages with a separate cpio rootfs, U-Boot will align
the rootfs on a 4K page boundary. When the memory is reserved, and
subsequent early memblock_alloc is called, it will allocate memory
between the 64K page alignment and reserved memory. When the reserved
memory is subsequently freed, it is done so by pages, causing the
early memblock_alloc requests to be re-used, which in my case, caused
the device-tree to be clobbered.

This patch forces the reserved memory for initrd to be kernel page
aligned, and will move the device tree if it overlaps with the range
extension of initrd. This patch will also consolidate the identical
function free_initrd_mem() from mm/init_32.c, init_64.c to mm/mem.c,
and adds the same range extension when freeing initrd. free_initrd_mem()
is also moved to the __init section.

Many thanks to Milton Miller for his input on this patch.

Signed-off-by: Dave Carroll <dcarroll@astekcorp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c |   23 ++++++++++++++++++++---
 arch/powerpc/mm/init_32.c  |   15 ---------------
 arch/powerpc/mm/init_64.c  |   14 --------------
 arch/powerpc/mm/mem.c      |   19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 48aeb55..fba012a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -82,11 +82,25 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
+/*
+ * overlaps_initrd - check for overlap with page aligned extension of
+ * initrd.
+ */
+static inline int overlaps_initrd(unsigned long start, unsigned long size)
+{
+	if (!initrd_start)
+		return 0;
+
+	return	(start + size) > _ALIGN_DOWN(initrd_start, PAGE_SIZE) &&
+			start <= _ALIGN_UP(initrd_end, PAGE_SIZE);
+}
+
 /**
  * move_device_tree - move tree to an unused area, if needed.
  *
  * The device tree may be allocated beyond our memory limit, or inside the
- * crash kernel region for kdump. If so, move it out of the way.
+ * crash kernel region for kdump, or within the page aligned range of initrd.
+ * If so, move it out of the way.
  */
 static void __init move_device_tree(void)
 {
@@ -99,7 +113,8 @@ static void __init move_device_tree(void)
 	size = be32_to_cpu(initial_boot_params->totalsize);
 
 	if ((memory_limit && (start + size) > PHYSICAL_START + memory_limit) ||
-			overlaps_crashkernel(start, size)) {
+			overlaps_crashkernel(start, size) ||
+			overlaps_initrd(start, size)) {
 		p = __va(memblock_alloc(size, PAGE_SIZE));
 		memcpy(p, initial_boot_params, size);
 		initial_boot_params = (struct boot_param_header *)p;
@@ -555,7 +570,9 @@ static void __init early_reserve_mem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* then reserve the initrd, if any */
 	if (initrd_start && (initrd_end > initrd_start))
-		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
+		memblock_reserve(_ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
+			_ALIGN_UP(initrd_end, PAGE_SIZE) -
+			_ALIGN_DOWN(initrd_start, PAGE_SIZE));
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index d65b591..5de0f25 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -223,21 +223,6 @@ void free_initmem(void)
 #undef FREESEC
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
-	for (; start < end; start += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(start));
-		init_page_count(virt_to_page(start));
-		free_page(start);
-		totalram_pages++;
-	}
-}
-#endif
-
-
 #ifdef CONFIG_8xx /* No 8xx specific .c file to put that in ... */
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 6374b21..f6dbb4c 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -99,20 +99,6 @@ void free_initmem(void)
 		((unsigned long)__init_end - (unsigned long)__init_begin) >> 10);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
-	for (; start < end; start += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(start));
-		init_page_count(virt_to_page(start));
-		free_page(start);
-		totalram_pages++;
-	}
-}
-#endif
-
 static void pgd_ctor(void *addr)
 {
 	memset(addr, 0, PGD_TABLE_SIZE);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 57e545b..29d4dde 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -382,6 +382,25 @@ void __init mem_init(void)
 	mem_init_done = 1;
 }
 
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init free_initrd_mem(unsigned long start, unsigned long end)
+{
+	if (start >= end)
+		return;
+
+	start = _ALIGN_DOWN(start, PAGE_SIZE);
+	end = _ALIGN_UP(end, PAGE_SIZE);
+	pr_info("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+
+	for (; start < end; start += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(start));
+		init_page_count(virt_to_page(start));
+		free_page(start);
+		totalram_pages++;
+	}
+}
+#endif
+
 /*
  * This is called when a page has been modified by the kernel.
  * It just marks the page as not i-cache clean.  We do the i-cache
-- 
1.7.4
