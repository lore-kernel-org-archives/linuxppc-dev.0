Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C15CD1A0348
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 11:07:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] powerpc: Remove more traces of bootmem
Date: Thu, 20 Nov 2014 11:07:38 +1100
Message-Id: <1416442058-19544-1-git-send-email-mpe@ellerman.id.au>
Cc: David.Laight@ACULAB.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although we are now selecting NO_BOOTMEM, we still have some traces of
bootmem lying around. That is because even with NO_BOOTMEM there is
still a shim that converts bootmem calls into memblock calls, but
ultimately we want to remove all traces of bootmem.

Most of the patch is conversions from alloc_bootmem() to
memblock_virt_alloc(). In general a call such as:

  p = (struct foo *)alloc_bootmem(x);

Becomes:

  p = memblock_virt_alloc(x, 0);

We don't need the cast because memblock_virt_alloc() returns a void *.
The alignment value of zero tells memblock to use the default alignment,
which is SMP_CACHE_BYTES, the same value alloc_bootmem() uses.

We remove a number of NULL checks on the result of
memblock_virt_alloc(). That is because memblock_virt_alloc() will panic
if it can't allocate, in exactly the same way as alloc_bootmem(), so the
NULL checks are and always have been redundant.

The memory returned by memblock_virt_alloc() is already zeroed, so we
remove several memsets of the result of memblock_virt_alloc().

Finally we convert a few uses of __alloc_bootmem(x, y, MAX_DMA_ADDRESS)
to just plain memblock_virt_alloc(). We don't use memblock_alloc_base()
because MAX_DMA_ADDRESS is ~0ul on powerpc, so limiting the allocation
to that is pointless, 16XB ought to be enough for anyone.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci-common.c            |  1 -
 arch/powerpc/kernel/pci_32.c                |  4 +---
 arch/powerpc/kernel/setup_64.c              |  2 +-
 arch/powerpc/lib/alloc.c                    |  4 +---
 arch/powerpc/mm/hugetlbpage.c               |  2 +-
 arch/powerpc/mm/mmu_context_nohash.c        |  8 ++++----
 arch/powerpc/platforms/cell/celleb_pci.c    |  6 +++---
 arch/powerpc/platforms/powermac/nvram.c     |  6 +-----
 arch/powerpc/platforms/powernv/pci-ioda.c   | 12 +++---------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 16 ++++------------
 arch/powerpc/platforms/ps3/setup.c          |  7 +------
 arch/powerpc/sysdev/fsl_pci.c               |  1 -
 12 files changed, 20 insertions(+), 49 deletions(-)


v2: Use memblock_virt_alloc() instead of open-coding __va(memblock_alloc(..)).

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index bc2dab52a991..37d512d35943 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -20,7 +20,6 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/of_address.h>
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 432459c817fa..1f7930037cb7 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -199,9 +199,7 @@ pci_create_OF_bus_map(void)
 	struct property* of_prop;
 	struct device_node *dn;
 
-	of_prop = (struct property*) alloc_bootmem(sizeof(struct property) + 256);
-	if (!of_prop)
-		return;
+	of_prop = memblock_virt_alloc(sizeof(struct property) + 256, 0);
 	dn = of_find_node_by_path("/");
 	if (dn) {
 		memset(of_prop, -1, sizeof(struct property) + 256);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6e5310ddf8c7..49f553bbb360 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -660,7 +660,7 @@ static void __init emergency_stack_init(void)
 }
 
 /*
- * Called into from start_kernel this initializes bootmem, which is used
+ * Called into from start_kernel this initializes memblock, which is used
  * to manage page allocation until mem_init is called.
  */
 void __init setup_arch(char **cmdline_p)
diff --git a/arch/powerpc/lib/alloc.c b/arch/powerpc/lib/alloc.c
index da22c84a8fed..4a6c2cf890d9 100644
--- a/arch/powerpc/lib/alloc.c
+++ b/arch/powerpc/lib/alloc.c
@@ -13,9 +13,7 @@ void * __init_refok zalloc_maybe_bootmem(size_t size, gfp_t mask)
 	if (mem_init_done)
 		p = kzalloc(size, mask);
 	else {
-		p = alloc_bootmem(size);
-		if (p)
-			memset(p, 0, size);
+		p = memblock_virt_alloc(size, 0);
 	}
 	return p;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index af56de82375d..8c9b8115867c 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -315,7 +315,7 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 	 * If gpages can be in highmem we can't use the trick of storing the
 	 * data structure in the page; allocate space for this
 	 */
-	m = alloc_bootmem(sizeof(struct huge_bootmem_page));
+	m = memblock_virt_alloc(sizeof(struct huge_bootmem_page), 0);
 	m->phys = gpage_freearray[idx].gpage_list[--nr_gpages];
 #else
 	m = phys_to_virt(gpage_freearray[idx].gpage_list[--nr_gpages]);
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 928ebe79668b..9cba6cba2e50 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -421,12 +421,12 @@ void __init mmu_context_init(void)
 	/*
 	 * Allocate the maps used by context management
 	 */
-	context_map = alloc_bootmem(CTX_MAP_SIZE);
-	context_mm = alloc_bootmem(sizeof(void *) * (last_context + 1));
+	context_map = memblock_virt_alloc(CTX_MAP_SIZE, 0);
+	context_mm = memblock_virt_alloc(sizeof(void *) * (last_context + 1), 0);
 #ifndef CONFIG_SMP
-	stale_map[0] = alloc_bootmem(CTX_MAP_SIZE);
+	stale_map[0] = memblock_virt_alloc(CTX_MAP_SIZE, 0);
 #else
-	stale_map[boot_cpuid] = alloc_bootmem(CTX_MAP_SIZE);
+	stale_map[boot_cpuid] = memblock_virt_alloc(CTX_MAP_SIZE, 0);
 
 	register_cpu_notifier(&mmu_context_cpu_nb);
 #endif
diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 2b98a36ef8fb..3ce70ded2d6a 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -29,7 +29,7 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/pci_regs.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -401,11 +401,11 @@ error:
 	} else {
 		if (config && *config) {
 			size = 256;
-			free_bootmem(__pa(*config), size);
+			memblock_free(__pa(*config), size);
 		}
 		if (res && *res) {
 			size = sizeof(struct celleb_pci_resource);
-			free_bootmem(__pa(*res), size);
+			memblock_free(__pa(*res), size);
 		}
 	}
 
diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index 014d06e6d46b..60b03a1703d1 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -513,11 +513,7 @@ static int __init core99_nvram_setup(struct device_node *dp, unsigned long addr)
 		printk(KERN_ERR "nvram: no address\n");
 		return -EINVAL;
 	}
-	nvram_image = alloc_bootmem(NVRAM_SIZE);
-	if (nvram_image == NULL) {
-		printk(KERN_ERR "nvram: can't allocate ram image\n");
-		return -ENOMEM;
-	}
+	nvram_image = memblock_virt_alloc(NVRAM_SIZE, 0);
 	nvram_data = ioremap(addr, NVRAM_SIZE*2);
 	nvram_naddrs = 1; /* Make sure we get the correct case */
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d03503515692..cc861c14840d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1940,19 +1940,14 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb_id = be64_to_cpup(prop64);
 	pr_debug("  PHB-ID  : 0x%016llx\n", phb_id);
 
-	phb = alloc_bootmem(sizeof(struct pnv_phb));
-	if (!phb) {
-		pr_err("  Out of memory !\n");
-		return;
-	}
+	phb = memblock_virt_alloc(sizeof(struct pnv_phb), 0);
 
 	/* Allocate PCI controller */
-	memset(phb, 0, sizeof(struct pnv_phb));
 	phb->hose = hose = pcibios_alloc_controller(np);
 	if (!phb->hose) {
 		pr_err("  Can't allocate PCI controller for %s\n",
 		       np->full_name);
-		free_bootmem((unsigned long)phb, sizeof(struct pnv_phb));
+		memblock_free(__pa(phb), sizeof(struct pnv_phb));
 		return;
 	}
 
@@ -2019,8 +2014,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	}
 	pemap_off = size;
 	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
-	aux = alloc_bootmem(size);
-	memset(aux, 0, size);
+	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.m32_segmap = aux + m32map_off;
 	if (phb->type == PNV_PHB_IODA1)
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 3336fcbdd08a..6ef6d4d8e7e2 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -122,12 +122,9 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 		return;
 	}
 
-	phb = alloc_bootmem(sizeof(struct pnv_phb));
-	if (phb) {
-		memset(phb, 0, sizeof(struct pnv_phb));
-		phb->hose = pcibios_alloc_controller(np);
-	}
-	if (!phb || !phb->hose) {
+	phb = memblock_virt_alloc(sizeof(struct pnv_phb), 0);
+	phb->hose = pcibios_alloc_controller(np);
+	if (!phb->hose) {
 		pr_err("  Failed to allocate PCI controller\n");
 		return;
 	}
@@ -216,12 +213,7 @@ void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
 	 *
 	 * XXX TODO: Make it chip local if possible
 	 */
-	tce_mem = __alloc_bootmem(P5IOC2_TCE_MEMORY, P5IOC2_TCE_MEMORY,
-				  __pa(MAX_DMA_ADDRESS));
-	if (!tce_mem) {
-		pr_err(" Failed to allocate TCE Memory !\n");
-		return;
-	}
+	tce_mem = memblock_virt_alloc(P5IOC2_TCE_MEMORY, P5IOC2_TCE_MEMORY);
 	pr_debug(" TCE    : 0x%016lx..0x%016lx\n",
 		__pa(tce_mem), __pa(tce_mem) + P5IOC2_TCE_MEMORY - 1);
 	rc = opal_pci_set_hub_tce_memory(hub_id, __pa(tce_mem),
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 009a2004b876..799c8580ab09 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -125,12 +125,7 @@ static void __init prealloc(struct ps3_prealloc *p)
 	if (!p->size)
 		return;
 
-	p->address = __alloc_bootmem(p->size, p->align, __pa(MAX_DMA_ADDRESS));
-	if (!p->address) {
-		printk(KERN_ERR "%s: Cannot allocate %s\n", __func__,
-		       p->name);
-		return;
-	}
+	p->address = memblock_virt_alloc(p->size, p->align);
 
 	printk(KERN_INFO "%s: %lu bytes at %p\n", p->name, p->size,
 	       p->address);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index d8484d7cffaa..6455c1eada1a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
-- 
1.9.1
