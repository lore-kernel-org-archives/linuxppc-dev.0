Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id EEE0FB7BCF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 05:43:59 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 2/4] wii: use both mem1 and mem2 as ram
Date: Tue,  8 Dec 2009 19:43:51 +0100
Message-Id: <1260297833-17625-3-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/mm/init_32.c                |    4 ++
 arch/powerpc/mm/mmu_decl.h               |   10 ++++-
 arch/powerpc/mm/pgtable_32.c             |   32 +++++++++++++--
 arch/powerpc/mm/ppc_mmu_32.c             |    4 +-
 arch/powerpc/platforms/embedded6xx/wii.c |   63 ++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 9ddcfb4..703c7c2 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -131,9 +131,13 @@ void __init MMU_init(void)
 	MMU_setup();
 
 	if (lmb.memory.cnt > 1) {
+#ifndef CONFIG_WII
 		lmb.memory.cnt = 1;
 		lmb_analyze();
 		printk(KERN_WARNING "Only using first contiguous memory region");
+#else
+		wii_memory_fixups();
+#endif
 	}
 
 	total_lowmem = total_memory = lmb_end_of_DRAM() - memstart_addr;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index d2e5321..9aa39fe 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -136,6 +136,14 @@ extern phys_addr_t total_lowmem;
 extern phys_addr_t memstart_addr;
 extern phys_addr_t lowmem_end_addr;
 
+#ifdef CONFIG_WII
+extern unsigned long wii_hole_start;
+extern unsigned long wii_hole_size;
+
+extern unsigned long wii_mmu_mapin_mem2(unsigned long top);
+extern void wii_memory_fixups(void);
+#endif
+
 /* ...and now those things that may be slightly different between processor
  * architectures.  -- Dan
  */
@@ -155,5 +163,5 @@ extern void adjust_total_lowmem(void);
 #elif defined(CONFIG_PPC32)
 /* anything 32-bit except 4xx or 8xx */
 extern void MMU_init_hw(void);
-extern unsigned long mmu_mapin_ram(void);
+extern unsigned long mmu_mapin_ram(unsigned long top);
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index cb96cb2..b55bbe8 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -283,18 +283,18 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
 }
 
 /*
- * Map in a big chunk of physical memory starting at PAGE_OFFSET.
+ * Map in a chunk of physical memory starting at start.
  */
-void __init mapin_ram(void)
+void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 {
 	unsigned long v, s, f;
 	phys_addr_t p;
 	int ktext;
 
-	s = mmu_mapin_ram();
+	s = offset;
 	v = PAGE_OFFSET + s;
 	p = memstart_addr + s;
-	for (; s < total_lowmem; s += PAGE_SIZE) {
+	for (; s < top; s += PAGE_SIZE) {
 		ktext = ((char *) v >= _stext && (char *) v < etext);
 		f = ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL;
 		map_page(v, p, f);
@@ -307,6 +307,30 @@ void __init mapin_ram(void)
 	}
 }
 
+void __init mapin_ram(void)
+{
+	unsigned long s, top;
+
+#ifndef CONFIG_WII
+	top = total_lowmem;
+	s = mmu_mapin_ram(top);
+	__mapin_ram_chunk(s, top);
+#else
+	if (!wii_hole_size) {
+		s = mmu_mapin_ram(total_lowmem);
+		__mapin_ram_chunk(s, total_lowmem);
+	} else {
+		top = wii_hole_start;
+		s = mmu_mapin_ram(top);
+		__mapin_ram_chunk(s, top);
+
+		top = lmb_end_of_DRAM();
+		s = wii_mmu_mapin_mem2(top);
+		__mapin_ram_chunk(s, top);
+	}
+#endif
+}
+
 /* Scan the real Linux page tables and return a PTE pointer for
  * a virtual address in a context.
  * Returns true (1) if PTE was found, zero otherwise.  The pointer to
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 2d2a87e..f11c2cd 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -72,7 +72,7 @@ unsigned long p_mapped_by_bats(phys_addr_t pa)
 	return 0;
 }
 
-unsigned long __init mmu_mapin_ram(void)
+unsigned long __init mmu_mapin_ram(unsigned long top)
 {
 	unsigned long tot, bl, done;
 	unsigned long max_size = (256<<20);
@@ -86,7 +86,7 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
-	tot = total_lowmem;
+	tot = top;
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > tot)
 			break;
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 1bd41cc..5eaed86 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -20,6 +20,8 @@
 #include <linux/seq_file.h>
 #include <linux/kexec.h>
 #include <linux/of_platform.h>
+#include <linux/lmb.h>
+#include <mm/mmu_decl.h>
 
 #include <asm/io.h>
 #include <asm/machdep.h>
@@ -52,6 +54,67 @@
 static void __iomem *hw_ctrl;
 static void __iomem *hw_gpio;
 
+unsigned long wii_hole_start;
+unsigned long wii_hole_size;
+
+
+static int page_aligned(unsigned long x)
+{
+	return !(x & (PAGE_SIZE-1));
+}
+
+void __init wii_memory_fixups(void)
+{
+	struct lmb_property *p = lmb.memory.region;
+
+	/*
+	 * This is part of a workaround to allow the use of two
+	 * discontiguous RAM ranges on the Wii, even if this is
+	 * currently unsupported on 32-bit PowerPC Linux.
+	 *
+	 * We coealesce the two memory ranges of the Wii into a
+	 * single range, then create a reservation for the "hole"
+	 * between both ranges.
+	 */
+
+	BUG_ON(lmb.memory.cnt != 2);
+	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
+
+	p[0].size = _ALIGN_DOWN(p[0].size, PAGE_SIZE);
+	p[1].size = _ALIGN_DOWN(p[1].size, PAGE_SIZE);
+
+	wii_hole_start = p[0].base + p[0].size;
+	wii_hole_size = p[1].base - wii_hole_start;
+
+	pr_info("MEM1: <%08llx %08llx>\n", p[0].base, p[0].size);
+	pr_info("HOLE: <%08lx %08lx>\n", wii_hole_start, wii_hole_size);
+	pr_info("MEM2: <%08llx %08llx>\n", p[1].base, p[1].size);
+
+	p[0].size += wii_hole_size + p[1].size;
+
+	lmb.memory.cnt = 1;
+	lmb_analyze();
+
+	/* reserve the hole */
+	lmb_reserve(wii_hole_start, wii_hole_size);
+}
+
+unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
+{
+	unsigned long delta, size, bl;
+	unsigned long max_size = (256<<20);
+
+	/* MEM2 64MB@0x10000000 */
+	delta = wii_hole_start + wii_hole_size;
+	size = top - delta;
+	for (bl = 128<<10; bl < max_size; bl <<= 1) {
+		if (bl * 2 > size)
+			break;
+	}
+	setbat(4, PAGE_OFFSET+delta, delta, bl, PAGE_KERNEL_X);
+	return delta + bl;
+}
+
 static void wii_spin(void)
 {
 	local_irq_disable();
-- 
1.6.3.3
