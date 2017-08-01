Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMCHC3RBPzDrMP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 20:29:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org,
	aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH 1/3] powerpc/mm/book3s64: Make KERN_IO_START a variable
Date: Tue,  1 Aug 2017 20:29:22 +1000
Message-Id: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently KERN_IO_START is defined as:

 #define KERN_IO_START  (KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))

Although it looks like a constant, both the components are actually
variables, to allow us to have a different value between Radix and
Hash with a single kernel.

However that still requires both Radix and Hash to place the kernel IO
region at the same location relative to the start and end of the
kernel virtual region (namely 1/2 way through it), and we'd like to
change that.

So split KERN_IO_START out into its own variable, and initialise it
for Radix and Hash. In the medium term we should be able to
reconsolidate this, by doing a more involved rearrangement of the
location of the regions.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 2 ++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
 arch/powerpc/include/asm/book3s/64/radix.h   | 2 ++
 arch/powerpc/mm/hash_utils_64.c              | 1 +
 arch/powerpc/mm/pgtable-radix.c              | 1 +
 arch/powerpc/mm/pgtable_64.c                 | 2 ++
 6 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 36fc7bfe9e11..d613653ed5b9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -51,6 +51,8 @@
 #define H_VMALLOC_SIZE	(H_KERN_VIRT_SIZE >> 1)
 #define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
 
+#define H_KERN_IO_START	H_VMALLOC_END
+
 /*
  * Region IDs
  */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d1da415e283c..18a8580d3ddc 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -272,8 +272,10 @@ extern unsigned long __vmalloc_end;
 
 extern unsigned long __kernel_virt_start;
 extern unsigned long __kernel_virt_size;
+extern unsigned long __kernel_io_start;
 #define KERN_VIRT_START __kernel_virt_start
 #define KERN_VIRT_SIZE  __kernel_virt_size
+#define KERN_IO_START  __kernel_io_start
 extern struct page *vmemmap;
 extern unsigned long ioremap_bot;
 extern unsigned long pci_io_base;
@@ -298,7 +300,6 @@ extern unsigned long pci_io_base;
  *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
  * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
  */
-#define KERN_IO_START	(KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
 #define FULL_IO_SIZE	0x80000000ul
 #define  ISA_IO_BASE	(KERN_IO_START)
 #define  ISA_IO_END	(KERN_IO_START + 0x10000ul)
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 544440b5aff3..1e5ba94e62ef 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -110,6 +110,8 @@
  */
 #define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
 
+#define RADIX_KERN_IO_START	(RADIX_KERN_VIRT_START + (RADIX_KERN_VIRT_SIZE >> 1))
+
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
 #define RADIX_PMD_TABLE_SIZE	(sizeof(pmd_t) << RADIX_PMD_INDEX_SIZE)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7419fc1854ad..a93137c358ea 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1019,6 +1019,7 @@ void __init hash__early_init_mmu(void)
 	__kernel_virt_size = H_KERN_VIRT_SIZE;
 	__vmalloc_start = H_VMALLOC_START;
 	__vmalloc_end = H_VMALLOC_END;
+	__kernel_io_start = H_KERN_IO_START;
 	vmemmap = (struct page *)H_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 5cc50d47ce3f..d37e68495acc 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -494,6 +494,7 @@ void __init radix__early_init_mmu(void)
 	__kernel_virt_size = RADIX_KERN_VIRT_SIZE;
 	__vmalloc_start = RADIX_VMALLOC_START;
 	__vmalloc_end = RADIX_VMALLOC_END;
+	__kernel_io_start = RADIX_KERN_IO_START;
 	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0736e94c7615..ac0717a90ca6 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -104,6 +104,8 @@ unsigned long __vmalloc_start;
 EXPORT_SYMBOL(__vmalloc_start);
 unsigned long __vmalloc_end;
 EXPORT_SYMBOL(__vmalloc_end);
+unsigned long __kernel_io_start;
+EXPORT_SYMBOL(__kernel_io_start);
 struct page *vmemmap;
 EXPORT_SYMBOL(vmemmap);
 unsigned long __pte_frag_nr;
-- 
2.7.4
