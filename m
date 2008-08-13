Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 9ECF6DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 13:04:02 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2672850rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 20:04:01 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH v2] powerpc: add ioremap_early() function for mapping IO
	regions before MMU_init()
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	jwboyer@linux.vnet.ibm.com, galak@kernel.crashing.org,
	miltonm@bga.com, paulus@samba.org, scottwood@freescale.com
Date: Tue, 12 Aug 2008 21:03:57 -0600
Message-ID: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

ioremap_early() is useful for things like mapping SoC internally memory mapped
register and early text because it allows mappings to devices to be setup
early in the boot process where they are needed, and the mappings persist
after the MMU is configured.

Without ioremap_early(), setting up the MMU would cause the early text
mappings to get lost and mostly likely result in a kernel panic on the next
attempt at output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

I've made changes based on the comments I've received.  I tried to share
code between __ioremap() and ioremap_early(), but when it came down to
writing the code, there was very little that was actually common.  Most
of it was around access to the ioremap_bot variable, but due to the
different alignments, the code ended up being different anyway.

I've not made any attempt to have this routine work after mem_init() time.
I don't think the use case justifies the extra code and I think I want to
enforce mapping with BATs (or other large region methods) to be performed
before smaller ioremaps() to maximize the performance gains.  If the BATs
are mapped first, then many smaller ioremaps() get to use them 'for free'.

Comments?
g.

 arch/powerpc/kernel/setup_32.c   |    4 +
 arch/powerpc/mm/init_32.c        |    7 --
 arch/powerpc/mm/mmu_decl.h       |    7 +-
 arch/powerpc/mm/pgtable_32.c     |   75 ++++++++++++++++++++
 arch/powerpc/mm/ppc_mmu_32.c     |  140 ++++++++++++++++++++++++++++++++------
 arch/powerpc/sysdev/cpm_common.c |    2 -
 include/asm-powerpc/io.h         |    8 ++
 7 files changed, 209 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 066e65c..822ae7e 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,6 +40,7 @@
 #include <asm/udbg.h>
 
 #include "setup.h"
+#include "mm/mmu_decl.h"
 
 #define DBG(fmt...)
 
@@ -113,6 +114,9 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  */
 notrace void __init machine_init(unsigned long dt_ptr, unsigned long phys)
 {
+	/* Get ready to allocate IO virtual address regions */
+	ioremap_init();
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 388ceda..a3d9b4e 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -169,13 +169,6 @@ void __init MMU_init(void)
 		ppc_md.progress("MMU:mapin", 0x301);
 	mapin_ram();
 
-#ifdef CONFIG_HIGHMEM
-	ioremap_base = PKMAP_BASE;
-#else
-	ioremap_base = 0xfe000000UL;	/* for now, could be 0xfffff000 */
-#endif /* CONFIG_HIGHMEM */
-	ioremap_bot = ioremap_base;
-
 	/* Map in I/O resources */
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:setio", 0x302);
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index fab3cfa..3c951d5 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -29,11 +29,14 @@ extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 #ifdef CONFIG_PPC32
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
-extern void setbat(int index, unsigned long virt, phys_addr_t phys,
-		   unsigned int size, int flags);
+extern int setbat(unsigned long virt, phys_addr_t phys, unsigned int size,
+		  int flags);
+extern int loadbat(unsigned long virt, phys_addr_t phys, unsigned int size,
+		   int flags);
 extern void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		      unsigned int size, int flags, unsigned int pid);
 extern void invalidate_tlbcam_entry(int index);
+extern void ioremap_init(void); /* called by machine_init() */
 
 extern int __map_without_bats;
 extern unsigned long ioremap_base;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2001abd..40820fa 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -55,8 +55,6 @@ extern void hash_page_sync(void);
 #ifdef HAVE_BATS
 extern phys_addr_t v_mapped_by_bats(unsigned long va);
 extern unsigned long p_mapped_by_bats(phys_addr_t pa);
-void setbat(int index, unsigned long virt, phys_addr_t phys,
-	    unsigned int size, int flags);
 
 #else /* !HAVE_BATS */
 #define v_mapped_by_bats(x)	(0UL)
@@ -142,6 +140,21 @@ void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	__free_page(ptepage);
 }
 
+/**
+ * ioremap_init - setup ioremap address range
+ */
+void __init ioremap_init(void)
+{
+	if (ioremap_base)
+		return;
+#ifdef CONFIG_HIGHMEM
+	ioremap_base = PKMAP_BASE;
+#else
+	ioremap_base = 0xfe000000UL;	/* for now, could be 0xfffff000 */
+#endif
+	ioremap_bot = ioremap_base;
+}
+
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
@@ -265,6 +278,64 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+/**
+ * ioremap_early - Allow large persistant IO regions to be mapped early.
+ * @addr: physical address of region
+ * @size: size of region
+ *
+ * This routine uses setbat() to set up IO ranges before the MMU is
+ * fully configured.
+ *
+ * This routine can be called really early, before MMU_init() is called.  It
+ * is useful for setting up early debug output consoles and frequently
+ * accessed IO regions, like the internally memory mapped registers (IMMR)
+ * in an SoC.  Ranges mapped with this function persist even after MMU_init()
+ * is called and the MMU is turned on 'for real.'
+ *
+ * The region mapped is large (minimum size of 128k) and virtual mapping must
+ * be aligned against this boundary.  Therefore, to avoid fragmentation all
+ * calls to ioremap_early() are best made before any calls to ioremap
+ * for smaller regions.
+ */
+void __iomem * __init
+ioremap_early(phys_addr_t addr, unsigned long size)
+{
+	unsigned long v, p;
+	int i;
+
+	/* Be loud and annoying if someone calls this too late.
+	 * No need to crash the kernel though */
+	WARN_ON(mem_init_done);
+	if (mem_init_done)
+		return NULL;
+
+	/* Make sure request is sane */
+	if (size == 0)
+		return NULL;
+
+	/* If the region is already block mapped, then there is nothing
+	 * to do; just return the mapped address */
+	v = p_mapped_by_bats(addr);
+	if (v)
+		return (void __iomem *)v;
+
+	/* Adjust size to reflect aligned region */
+	p = _ALIGN_DOWN(addr, 128 << 10); /* BATs align on 128k boundaries */
+	size = ALIGN(addr - p + size, 128 << 10);
+
+	/* Allocate the aligned virtual base address.  ALIGN_DOWN is used
+	 * to ensure no overlaps occur with normal 4k ioremaps. */
+	v = ioremap_bot = _ALIGN_DOWN(ioremap_bot, 128 << 10) - size;
+
+	/* Set up a BAT for this IO region */
+	i = loadbat(v, p, size, _PAGE_IO);
+	if (i < 0)
+		return NULL;
+
+	return (void __iomem *) (v + (addr - p));
+}
+
+
 int map_page(unsigned long va, phys_addr_t pa, int flags)
 {
 	pmd_t *pd;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..676b2a0 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -72,41 +72,44 @@ unsigned long p_mapped_by_bats(phys_addr_t pa)
 	return 0;
 }
 
+/**
+ * mmu_mapin_ram - Map as much of RAM as possible into kernel space using BATs
+ */
 unsigned long __init mmu_mapin_ram(void)
 {
 #ifdef CONFIG_POWER4
 	return 0;
 #else
 	unsigned long tot, bl, done;
-	unsigned long max_size = (256<<20);
+	int rc;
 
 	if (__map_without_bats) {
 		printk(KERN_DEBUG "RAM mapped without BATs\n");
 		return 0;
 	}
 
-	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
-
-	/* Make sure we don't map a block larger than the
-	   smallest alignment of the physical address. */
+	/* Set up BATs to cover RAM. */
 	tot = total_lowmem;
-	for (bl = 128<<10; bl < max_size; bl <<= 1) {
-		if (bl * 2 > tot)
+	done = 0;
+	while (done < tot) {
+		/* determine the smallest block size need to map the region.
+		 * Don't use a BAT mapping if the remaining region is less
+		 * that 128k */
+		if (tot - done <= 128<<10)
 			break;
-	}
-
-	setbat(2, KERNELBASE, 0, bl, _PAGE_RAM);
-	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
-	if ((done < tot) && !bat_addrs[3].limit) {
-		/* use BAT3 to cover a bit more */
-		tot -= done;
-		for (bl = 128<<10; bl < max_size; bl <<= 1)
-			if (bl * 2 > tot)
+		for (bl = 128<<10; bl < (256<<20); bl <<= 1)
+			if ((bl * 2) > (tot - done))
 				break;
-		setbat(3, KERNELBASE+done, done, bl, _PAGE_RAM);
-		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
+
+		/* Allocate the BAT and recalculate amount of RAM mapped */
+		rc = setbat(KERNELBASE+done, done, bl, _PAGE_RAM);
+		if (rc < 0)
+			break;
+		done = (unsigned long)bat_addrs[rc].limit - KERNELBASE + 1;
 	}
 
+	if (done == 0)
+		printk(KERN_CRIT "Weird; No BATs available for RAM.\n");
 	return done;
 #endif
 }
@@ -116,12 +119,29 @@ unsigned long __init mmu_mapin_ram(void)
  * The parameters are not checked; in particular size must be a power
  * of 2 between 128k and 256M.
  */
-void __init setbat(int index, unsigned long virt, phys_addr_t phys,
-		   unsigned int size, int flags)
+int __init setbat(unsigned long virt, phys_addr_t phys,
+		  unsigned int size, int flags)
 {
 	unsigned int bl;
-	int wimgxpp;
-	struct ppc_bat *bat = BATS[index];
+	int wimgxpp, index, nr_bats;
+	struct ppc_bat *bat;
+
+	/* Find a free BAT
+	 *
+	 * Special case; Keep the first entry in reserve for mapping RAM.
+	 * Otherwise the too many other users can prevent RAM from getting
+	 * mapped at all with a BAT.
+	 */
+	index = (flags == _PAGE_RAM) ? 0 : 1;
+	nr_bats = cpu_has_feature(CPU_FTR_HAS_HIGH_BATS) ? 8 : 4;
+	for (; index < nr_bats; index++) {
+		if ((BATS[index][0].batu == 0) && (BATS[index][1].batu == 0))
+			break;
+	}
+	if (index == nr_bats)
+		return -1;
+
+	bat = BATS[index];
 
 	if (((flags & _PAGE_NO_CACHE) == 0) &&
 	    cpu_has_feature(CPU_FTR_NEED_COHERENT))
@@ -162,8 +182,84 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 	bat_addrs[index].start = virt;
 	bat_addrs[index].limit = virt + ((bl + 1) << 17) - 1;
 	bat_addrs[index].phys = phys;
+	return index;
 }
 
+/**
+ * loadbat - Set up and configure one of the I/D BAT register pairs.
+ * @virt - virtual address, 128k aligned
+ * @phys - physical address, 128k aligned
+ * @size - size of mapping
+ * @flags - region attribute flags
+ *
+ * Uses setbat() to allocate a BAT pair and immediately writes the
+ * configuration into the BAT registers (instead of waiting for load_up_mmu)
+ */
+int __init loadbat(unsigned long virt, phys_addr_t phys,
+		   unsigned int size, int flags)
+{
+	struct ppc_bat *bat;
+	int i;
+
+	i = setbat(virt, phys, size, flags);
+	if (i < 0)
+		return i;
+	bat = BATS[i];
+
+	/* BATs must be set with a switch statement because there is no way
+	 * to paramaterize mtspr/mfspr instructions.
+	 *
+	 * Note: BAT0 is not handled here because early boot code depends
+	 * on BAT0 for mapping first 16M of RAM.  setbat() keeps BAT0 in
+	 * reserve for mapping main memory anyway, so this is okay.
+	 */
+	switch (i) {
+	case 1:
+		mtspr(SPRN_IBAT1U, bat[0].batu);
+		mtspr(SPRN_IBAT1L, bat[0].batl);
+		mtspr(SPRN_DBAT1U, bat[1].batu);
+		mtspr(SPRN_DBAT1L, bat[1].batl);
+		break;
+	case 2:
+		mtspr(SPRN_IBAT2U, bat[0].batu);
+		mtspr(SPRN_IBAT2L, bat[0].batl);
+		mtspr(SPRN_DBAT2U, bat[1].batu);
+		mtspr(SPRN_DBAT2L, bat[1].batl);
+		break;
+	case 3:
+		mtspr(SPRN_IBAT3U, bat[0].batu);
+		mtspr(SPRN_IBAT3L, bat[0].batl);
+		mtspr(SPRN_DBAT3U, bat[1].batu);
+		mtspr(SPRN_DBAT3L, bat[1].batl);
+		break;
+	case 4:
+		mtspr(SPRN_IBAT4U, bat[0].batu);
+		mtspr(SPRN_IBAT4L, bat[0].batl);
+		mtspr(SPRN_DBAT4U, bat[1].batu);
+		mtspr(SPRN_DBAT4L, bat[1].batl);
+		break;
+	case 5:
+		mtspr(SPRN_IBAT5U, bat[0].batu);
+		mtspr(SPRN_IBAT5L, bat[0].batl);
+		mtspr(SPRN_DBAT5U, bat[1].batu);
+		mtspr(SPRN_DBAT5L, bat[1].batl);
+		break;
+	case 6:
+		mtspr(SPRN_IBAT6U, bat[0].batu);
+		mtspr(SPRN_IBAT6L, bat[0].batl);
+		mtspr(SPRN_DBAT6U, bat[1].batu);
+		mtspr(SPRN_DBAT6L, bat[1].batl);
+		break;
+	case 7:
+		mtspr(SPRN_IBAT7U, bat[0].batu);
+		mtspr(SPRN_IBAT7L, bat[0].batl);
+		mtspr(SPRN_DBAT7U, bat[1].batu);
+		mtspr(SPRN_DBAT7L, bat[1].batl);
+		break;
+	}
+
+	return i;
+}
 /*
  * Preload a translation in the hash table
  */
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 53da8a0..b3b4f8c 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -56,7 +56,7 @@ void __init udbg_init_cpm(void)
 {
 	if (cpm_udbg_txdesc) {
 #ifdef CONFIG_CPM2
-		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
+		setbat(0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
 #endif
 		udbg_putc = udbg_putc_cpm;
 	}
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 77c7fa0..e343f76 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -624,6 +624,12 @@ static inline void iosync(void)
  *
  * * iounmap undoes such a mapping and can be hooked
  *
+ * * ioremap_early is for setting up mapping regions during early boot.  Useful
+ *   for console devices or mapping an entire region of SoC internal registers.
+ *   ioremap_early becomes usable at machine_init() time.  Care must be taken
+ *   when using this routine because it can consume limited resources like BAT
+ *   registers.
+ *
  * * __ioremap_at (and the pending __iounmap_at) are low level functions to
  *   create hand-made mappings for use only by the PCI code and cannot
  *   currently be hooked. Must be page aligned.
@@ -644,6 +650,8 @@ extern void __iomem *ioremap_flags(phys_addr_t address, unsigned long size,
 
 extern void iounmap(volatile void __iomem *addr);
 
+extern void __iomem *ioremap_early(phys_addr_t addr, unsigned long size);
+
 extern void __iomem *__ioremap(phys_addr_t, unsigned long size,
 			       unsigned long flags);
 extern void __iounmap(volatile void __iomem *addr);
