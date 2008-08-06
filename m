Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id B2668DDEF1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:02:38 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5593181wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 23:02:38 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting up
	BAT translated IO regions.
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
	galak@kernel.crashing.org, jwboyer@linux.vnet.ibm.com
Date: Wed, 06 Aug 2008 00:02:34 -0600
Message-ID: <20080806060223.30717.35175.stgit@trillian.secretlab.ca>
In-Reply-To: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

ioremap_bat() is useful for things like mapping SoC internally memory mapped
register and early text because it allows mappings to devices to be setup
early in the boot process where they are needed, and the mappings persist
after the MMU is configured.

Without ioremap_bat(), setting up the MMU would cause the early text
mappings to get lost and mostly likely result in a kernel panic on the next
attempt at output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/kernel/setup_32.c   |    9 ++
 arch/powerpc/mm/init_32.c        |    7 --
 arch/powerpc/mm/mmu_decl.h       |    4 +
 arch/powerpc/mm/pgtable_32.c     |    2 -
 arch/powerpc/mm/ppc_mmu_32.c     |  148 ++++++++++++++++++++++++++++++++------
 arch/powerpc/sysdev/cpm_common.c |    2 -
 include/asm-powerpc/pgalloc-32.h |    2 +
 7 files changed, 140 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 066e65c..7b25b57 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -113,6 +113,15 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  */
 notrace void __init machine_init(unsigned long dt_ptr, unsigned long phys)
 {
+	/* Do the bare minimum to start allocting from the IO region so
+	 * that ioremap_bat() works */
+#ifdef CONFIG_HIGHMEM
+	ioremap_base = PKMAP_BASE;
+#else
+	ioremap_base = 0xfe000000UL;	/* for now, could be 0xfffff000 */
+#endif /* CONFIG_HIGHMEM */
+	ioremap_bot = ioremap_base;
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
index fab3cfa..5027736 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -29,8 +29,8 @@ extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 #ifdef CONFIG_PPC32
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
-extern void setbat(int index, unsigned long virt, phys_addr_t phys,
-		   unsigned int size, int flags);
+extern int setbat(unsigned long virt, phys_addr_t phys,
+		  unsigned int size, int flags);
 extern void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		      unsigned int size, int flags, unsigned int pid);
 extern void invalidate_tlbcam_entry(int index);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2001abd..e96f745 100644
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
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..62c4603 100644
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
@@ -162,6 +182,90 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 	bat_addrs[index].start = virt;
 	bat_addrs[index].limit = virt + ((bl + 1) << 17) - 1;
 	bat_addrs[index].phys = phys;
+	return index;
+}
+
+/**
+ * ioremap_bat - Allow IO regions to be mapped using BAT registers
+ * @addr: physical address of region
+ * @size: size of region
+ *
+ * This routine uses setbat() to set up IO ranges before the MMU is
+ * fully configured.  Regions allocated with this function will
+ * automatically be converted into page table entries once the MMU is able
+ * to accept them.
+ *
+ * This routine can be called really early, before MMU_init() is called.  It
+ * is useful for setting up early debug output consoles and frequently
+ * accessed IO regions, like the internally memory mapped registers (IMMR)
+ * in an SoC.
+ *
+ * Just like in setbat, size must be a power of 2 between 128k and 256M.
+ * It is also assumed that callers are somewhat sane and will not be trying
+ * to call this multiple times on the same region.
+ */
+void __iomem * __init
+ioremap_bat(phys_addr_t addr, unsigned long size)
+{
+	struct ppc_bat *bat;
+	unsigned long v;
+	int i;
+
+	/* BAT mappings must be 128k aligned */
+	if (addr != _ALIGN_DOWN(addr, 128 << 10))
+		return NULL;
+
+	/* Carve out a chunk of the ioremap virtual address region
+	 * Also must be 128k aligned */
+	v = ioremap_bot = _ALIGN_DOWN(ioremap_bot - size, 128 << 10);
+
+	/* Allocate a BAT for this IO region */
+	i = setbat(v, addr, size, _PAGE_IO);
+	if (i < 0)
+		return NULL;
+	bat = BATS[i];
+
+	/*
+	 * IO BAT setting can be loaded immediately.
+	 * This only sets the DBATs.  IBATs are irrelevant for IO ranges
+	 *
+	 * Note: Don't disturb BAT 0; it is dedicated for mapping RAM,
+	 * especially in early boot.  Kernel will break if it gets changed
+	 * here.  (actually, setbat should never return index 0 for IO BAT
+	 * mappings).
+	 */
+	switch(i) {
+	case 1:
+		mtspr(SPRN_DBAT1U, bat[1].batu);
+		mtspr(SPRN_DBAT1L, bat[1].batl);
+		break;
+	case 2:
+		mtspr(SPRN_DBAT2U, bat[1].batu);
+		mtspr(SPRN_DBAT2L, bat[1].batl);
+		break;
+	case 3:
+		mtspr(SPRN_DBAT3U, bat[1].batu);
+		mtspr(SPRN_DBAT3L, bat[1].batl);
+		break;
+	case 4:
+		mtspr(SPRN_DBAT4U, bat[1].batu);
+		mtspr(SPRN_DBAT4L, bat[1].batl);
+		break;
+	case 5:
+		mtspr(SPRN_DBAT5U, bat[1].batu);
+		mtspr(SPRN_DBAT5L, bat[1].batl);
+		break;
+	case 6:
+		mtspr(SPRN_DBAT6U, bat[1].batu);
+		mtspr(SPRN_DBAT6L, bat[1].batl);
+		break;
+	case 7:
+		mtspr(SPRN_DBAT7U, bat[1].batu);
+		mtspr(SPRN_DBAT7L, bat[1].batl);
+		break;
+	}
+
+	return (void __iomem *)v;
 }
 
 /*
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
diff --git a/include/asm-powerpc/pgalloc-32.h b/include/asm-powerpc/pgalloc-32.h
index 58c0714..ea8b23d 100644
--- a/include/asm-powerpc/pgalloc-32.h
+++ b/include/asm-powerpc/pgalloc-32.h
@@ -40,4 +40,6 @@ extern void pte_free(struct mm_struct *mm, pgtable_t pte);
 
 #define check_pgt_cache()	do { } while (0)
 
+extern void __iomem *ioremap_bat(phys_addr_t addr, unsigned long size);
+
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
