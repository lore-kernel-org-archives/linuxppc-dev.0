Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyY66rNzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 58/70] powerpc/mm: vmalloc abstraction in preparation for
 radix
Date: Fri, 29 Apr 2016 23:26:21 +1000
Message-Id: <1461936393-10131-58-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

The vmalloc range differs between hash and radix config. Hence make
VMALLOC_START and related constants a variable which will be runtime
initialized depending on whether hash or radix mode is active.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 14 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 15 ++++--
 arch/powerpc/include/asm/book3s/64/radix.h   | 68 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_64.c                 |  3 +-
 arch/powerpc/mm/hash_utils_64.c              |  8 ++++
 arch/powerpc/mm/pgtable-radix.c              |  7 +++
 arch/powerpc/mm/pgtable_64.c                 | 13 +++++-
 arch/powerpc/mm/slb_low.S                    |  2 +-
 8 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index cd3e91583c81..f61cad3de4e6 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -45,17 +45,17 @@
 /*
  * Define the address range of the kernel non-linear virtual area
  */
-#define KERN_VIRT_START ASM_CONST(0xD000000000000000)
-#define KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
+#define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
+#define H_KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
 
 /*
  * The vmalloc space starts at the beginning of that region, and
  * occupies half of it on hash CPUs and a quarter of it on Book3E
  * (we keep a quarter for the virtual memmap)
  */
-#define VMALLOC_START	KERN_VIRT_START
-#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
+#define H_VMALLOC_START	H_KERN_VIRT_START
+#define H_VMALLOC_SIZE	(H_KERN_VIRT_SIZE >> 1)
+#define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
 
 /*
  * Region IDs
@@ -64,7 +64,7 @@
 #define REGION_MASK		(0xfUL << REGION_SHIFT)
 #define REGION_ID(ea)		(((unsigned long)(ea)) >> REGION_SHIFT)
 
-#define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
+#define VMALLOC_REGION_ID	(REGION_ID(H_VMALLOC_START))
 #define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
 #define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
 #define USER_REGION_ID		(0UL)
@@ -73,7 +73,7 @@
  * Defines the address of the vmemap area, in its own region on
  * hash table CPUs.
  */
-#define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
+#define H_VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 32a975694e53..f5628f96134b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -208,6 +208,18 @@ extern unsigned long __pgd_val_bits;
 #define PUD_MASKED_BITS		0xc0000000000000ffUL
 /* Bits to mask out from a PGD to get to the PUD page */
 #define PGD_MASKED_BITS		0xc0000000000000ffUL
+
+extern unsigned long __vmalloc_start;
+extern unsigned long __vmalloc_end;
+#define VMALLOC_START	__vmalloc_start
+#define VMALLOC_END	__vmalloc_end
+
+extern unsigned long __kernel_virt_start;
+extern unsigned long __kernel_virt_size;
+#define KERN_VIRT_START __kernel_virt_start
+#define KERN_VIRT_SIZE  __kernel_virt_size
+extern struct page *vmemmap;
+extern unsigned long ioremap_bot;
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
@@ -220,7 +232,6 @@ extern unsigned long __pgd_val_bits;
 #endif
 
 #include <asm/barrier.h>
-
 /*
  * The second half of the kernel virtual space is used for IO mappings,
  * it's itself carved into the PIO region (ISA and PHB IO space) and
@@ -239,8 +250,6 @@ extern unsigned long __pgd_val_bits;
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
 
-#define vmemmap			((struct page *)VMEMMAP_BASE)
-
 /* Advertise special mapping type for AGP */
 #define HAVE_PAGE_AGP
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 63eb629a8b64..f4709024b466 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -31,6 +31,74 @@
 			      RADIX_PUD_INDEX_SIZE + RADIX_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define RADIX_PGTABLE_RANGE (ASM_CONST(1) << RADIX_PGTABLE_EADDR_SIZE)
 
+/*
+ * We support 52 bit address space, Use top bit for kernel
+ * virtual mapping. Also make sure kernel fit in the top
+ * quadrant.
+ *
+ *           +------------------+
+ *           +------------------+  Kernel virtual map (0xc008000000000000)
+ *           |                  |
+ *           |                  |
+ *           |                  |
+ * 0b11......+------------------+  Kernel linear map (0xc....)
+ *           |                  |
+ *           |     2 quadrant   |
+ *           |                  |
+ * 0b10......+------------------+
+ *           |                  |
+ *           |    1 quadrant    |
+ *           |                  |
+ * 0b01......+------------------+
+ *           |                  |
+ *           |    0 quadrant    |
+ *           |                  |
+ * 0b00......+------------------+
+ *
+ *
+ * 3rd quadrant expanded:
+ * +------------------------------+
+ * |                              |
+ * |                              |
+ * |                              |
+ * +------------------------------+  Kernel IO map end (0xc010000000000000)
+ * |                              |
+ * |                              |
+ * |      1/2 of virtual map      |
+ * |                              |
+ * |                              |
+ * +------------------------------+  Kernel IO map start
+ * |                              |
+ * |      1/4 of virtual map      |
+ * |                              |
+ * +------------------------------+  Kernel vmemap start
+ * |                              |
+ * |     1/4 of virtual map       |
+ * |                              |
+ * +------------------------------+  Kernel virt start (0xc008000000000000)
+ * |                              |
+ * |                              |
+ * |                              |
+ * +------------------------------+  Kernel linear (0xc.....)
+ */
+
+#define RADIX_KERN_VIRT_START ASM_CONST(0xc008000000000000)
+#define RADIX_KERN_VIRT_SIZE  ASM_CONST(0x0008000000000000)
+
+/*
+ * The vmalloc space starts at the beginning of that region, and
+ * occupies a quarter of it on radix config.
+ * (we keep a quarter for the virtual memmap)
+ */
+#define RADIX_VMALLOC_START	RADIX_KERN_VIRT_START
+#define RADIX_VMALLOC_SIZE	(RADIX_KERN_VIRT_SIZE >> 2)
+#define RADIX_VMALLOC_END	(RADIX_VMALLOC_START + RADIX_VMALLOC_SIZE)
+/*
+ * Defines the address of the vmemap area, in its own region on
+ * hash table CPUs.
+ */
+#define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
+
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
 #define RADIX_PMD_TABLE_SIZE	(sizeof(pmd_t) << RADIX_PMD_INDEX_SIZE)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 41503d7d53a1..3759df52bd67 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -38,7 +38,7 @@
  * ISA drivers use hard coded offsets.  If no ISA bus exists nothing
  * is mapped on the first 64K of IO space
  */
-unsigned long pci_io_base = ISA_IO_BASE;
+unsigned long pci_io_base;
 EXPORT_SYMBOL(pci_io_base);
 
 static int __init pcibios_init(void)
@@ -47,6 +47,7 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	pci_io_base = ISA_IO_BASE;
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 64165a730160..68aee435ea97 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -889,6 +889,14 @@ void __init hash__early_init_mmu(void)
 	__pmd_val_bits = 0;
 	__pud_val_bits = 0;
 	__pgd_val_bits = 0;
+
+	__kernel_virt_start = H_KERN_VIRT_START;
+	__kernel_virt_size = H_KERN_VIRT_SIZE;
+	__vmalloc_start = H_VMALLOC_START;
+	__vmalloc_end = H_VMALLOC_END;
+	vmemmap = (struct page *)H_VMEMMAP_BASE;
+	ioremap_bot = IOREMAP_BASE;
+
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6182b6c3c9c3..13afacdfa96e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -328,6 +328,13 @@ void __init radix__early_init_mmu(void)
 	__pud_val_bits = RADIX_PUD_VAL_BITS;
 	__pgd_val_bits = RADIX_PGD_VAL_BITS;
 
+	__kernel_virt_start = RADIX_KERN_VIRT_START;
+	__kernel_virt_size = RADIX_KERN_VIRT_SIZE;
+	__vmalloc_start = RADIX_VMALLOC_START;
+	__vmalloc_end = RADIX_VMALLOC_END;
+	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
+	ioremap_bot = IOREMAP_BASE;
+
 	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		radix_init_partition_table();
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index b8c75e65157c..e2463c03902b 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -97,9 +97,18 @@ unsigned long __pud_val_bits;
 EXPORT_SYMBOL(__pud_val_bits);
 unsigned long __pgd_val_bits;
 EXPORT_SYMBOL(__pgd_val_bits);
-
+unsigned long __kernel_virt_start;
+EXPORT_SYMBOL(__kernel_virt_start);
+unsigned long __kernel_virt_size;
+EXPORT_SYMBOL(__kernel_virt_size);
+unsigned long __vmalloc_start;
+EXPORT_SYMBOL(__vmalloc_start);
+unsigned long __vmalloc_end;
+EXPORT_SYMBOL(__vmalloc_end);
+struct page *vmemmap;
+EXPORT_SYMBOL(vmemmap);
 #endif
-unsigned long ioremap_bot = IOREMAP_BASE;
+unsigned long ioremap_bot;
 
 /**
  * __ioremap_at - Low level function to establish the page tables
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 15b8f712b50b..dfdb90cb4403 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -91,7 +91,7 @@ slb_miss_kernel_load_vmemmap:
 	 * can be demoted from 64K -> 4K dynamically on some machines
 	 */
 	clrldi	r11,r10,48
-	cmpldi	r11,(VMALLOC_SIZE >> 28) - 1
+	cmpldi	r11,(H_VMALLOC_SIZE >> 28) - 1
 	bgt	5f
 	lhz	r11,PACAVMALLOCSLLP(r13)
 	b	6f
-- 
2.5.0
