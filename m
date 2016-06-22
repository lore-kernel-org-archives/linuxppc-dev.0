Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZYyb5KcgzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 05:08:07 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <michaele@au1.ibm.com>, Julian Margetson
 <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 luigi burdo <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
 <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
 <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
 <87r3c71zs9.fsf@skywalker.in.ibm.com>
 <d3753fa2-d88b-2e31-7d0d-d8952c29a12b@xenosoft.de>
 <bab57839-0160-ae01-3cfb-6950067652c0@xenosoft.de>
 <1465470910.31662.10.camel@ellerman.id.au>
 <40816527-1be8-329c-2be0-86c39062c2e9@xenosoft.de>
 <25BBCC66-53B2-4009-B2BA-CD1070EA71E9@xenosoft.de>
 <1465805967.3022.14.camel@kernel.crashing.org> <575EF6BE.6020208@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <576AE1D7.7090301@xenosoft.de>
Date: Wed, 22 Jun 2016 21:07:03 +0200
MIME-Version: 1.0
In-Reply-To: <575EF6BE.6020208@xenosoft.de>
Content-Type: multipart/mixed; boundary="------------000807080801060705050502"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000807080801060705050502
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi All,

Please find attached Darren's patch. With this patch, the Nemo board
boots. That means, the problematic source code is somewhere in this patch.
Which file in this patch is responsible for starting the kernel?

Thanks,

Christian

On 13 June 2016 at 8:09 PM, Christian Zigotzky wrote:
> Hi Ben,
>
> I could send you a patch but it doesn't work with the three PowerPC
> commits. I think we have to fix the boot issue at first. After that we
> can integrate the first patch for the Nemo board.
>
> Cheers,
>
> Christian
>
> On 13 June 2016 at 10:19 AM, Benjamin Herrenschmidt wrote:
>> The right way to not have this problem anymore is to cleanup and
>> submit your patches upstream so they don't break all the time :-)
>>
>> Cheers,
>> Ben.
>>
>>


--------------000807080801060705050502
Content-Type: text/x-patch;
 name="nemo_4.7.0rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nemo_4.7.0rc3.patch"

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f61cad3..cd3e915 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -45,17 +45,17 @@
 /*
  * Define the address range of the kernel non-linear virtual area
  */
-#define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
-#define H_KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
+#define KERN_VIRT_START ASM_CONST(0xD000000000000000)
+#define KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
 
 /*
  * The vmalloc space starts at the beginning of that region, and
  * occupies half of it on hash CPUs and a quarter of it on Book3E
  * (we keep a quarter for the virtual memmap)
  */
-#define H_VMALLOC_START	H_KERN_VIRT_START
-#define H_VMALLOC_SIZE	(H_KERN_VIRT_SIZE >> 1)
-#define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
+#define VMALLOC_START	KERN_VIRT_START
+#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
 
 /*
  * Region IDs
@@ -64,7 +64,7 @@
 #define REGION_MASK		(0xfUL << REGION_SHIFT)
 #define REGION_ID(ea)		(((unsigned long)(ea)) >> REGION_SHIFT)
 
-#define VMALLOC_REGION_ID	(REGION_ID(H_VMALLOC_START))
+#define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
 #define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
 #define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
 #define USER_REGION_ID		(0UL)
@@ -73,7 +73,7 @@
  * Defines the address of the vmemap area, in its own region on
  * hash table CPUs.
  */
-#define H_VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
+#define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 88a5eca..bdfea62 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -218,18 +218,6 @@ extern unsigned long __pte_frag_size_shift;
 #define PUD_MASKED_BITS		0xc0000000000000ffUL
 /* Bits to mask out from a PGD to get to the PUD page */
 #define PGD_MASKED_BITS		0xc0000000000000ffUL
-
-extern unsigned long __vmalloc_start;
-extern unsigned long __vmalloc_end;
-#define VMALLOC_START	__vmalloc_start
-#define VMALLOC_END	__vmalloc_end
-
-extern unsigned long __kernel_virt_start;
-extern unsigned long __kernel_virt_size;
-#define KERN_VIRT_START __kernel_virt_start
-#define KERN_VIRT_SIZE  __kernel_virt_size
-extern struct page *vmemmap;
-extern unsigned long ioremap_bot;
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
@@ -242,6 +230,7 @@ extern unsigned long ioremap_bot;
 #endif
 
 #include <asm/barrier.h>
+
 /*
  * The second half of the kernel virtual space is used for IO mappings,
  * it's itself carved into the PIO region (ISA and PHB IO space) and
@@ -260,6 +249,8 @@ extern unsigned long ioremap_bot;
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
 
+#define vmmemap			((struct page *)VMEMMAP_BASE)
+
 /* Advertise special mapping type for AGP */
 #define HAVE_PAGE_AGP
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 937d4e2..a8b24d6 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -31,74 +31,6 @@
 			      RADIX_PUD_INDEX_SIZE + RADIX_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define RADIX_PGTABLE_RANGE (ASM_CONST(1) << RADIX_PGTABLE_EADDR_SIZE)
 
-/*
- * We support 52 bit address space, Use top bit for kernel
- * virtual mapping. Also make sure kernel fit in the top
- * quadrant.
- *
- *           +------------------+
- *           +------------------+  Kernel virtual map (0xc008000000000000)
- *           |                  |
- *           |                  |
- *           |                  |
- * 0b11......+------------------+  Kernel linear map (0xc....)
- *           |                  |
- *           |     2 quadrant   |
- *           |                  |
- * 0b10......+------------------+
- *           |                  |
- *           |    1 quadrant    |
- *           |                  |
- * 0b01......+------------------+
- *           |                  |
- *           |    0 quadrant    |
- *           |                  |
- * 0b00......+------------------+
- *
- *
- * 3rd quadrant expanded:
- * +------------------------------+
- * |                              |
- * |                              |
- * |                              |
- * +------------------------------+  Kernel IO map end (0xc010000000000000)
- * |                              |
- * |                              |
- * |      1/2 of virtual map      |
- * |                              |
- * |                              |
- * +------------------------------+  Kernel IO map start
- * |                              |
- * |      1/4 of virtual map      |
- * |                              |
- * +------------------------------+  Kernel vmemap start
- * |                              |
- * |     1/4 of virtual map       |
- * |                              |
- * +------------------------------+  Kernel virt start (0xc008000000000000)
- * |                              |
- * |                              |
- * |                              |
- * +------------------------------+  Kernel linear (0xc.....)
- */
-
-#define RADIX_KERN_VIRT_START ASM_CONST(0xc008000000000000)
-#define RADIX_KERN_VIRT_SIZE  ASM_CONST(0x0008000000000000)
-
-/*
- * The vmalloc space starts at the beginning of that region, and
- * occupies a quarter of it on radix config.
- * (we keep a quarter for the virtual memmap)
- */
-#define RADIX_VMALLOC_START	RADIX_KERN_VIRT_START
-#define RADIX_VMALLOC_SIZE	(RADIX_KERN_VIRT_SIZE >> 2)
-#define RADIX_VMALLOC_END	(RADIX_VMALLOC_START + RADIX_VMALLOC_SIZE)
-/*
- * Defines the address of the vmemap area, in its own region on
- * hash table CPUs.
- */
-#define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
-
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
 #define RADIX_PMD_TABLE_SIZE	(sizeof(pmd_t) << RADIX_PMD_INDEX_SIZE)
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3759df5..41503d7 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -38,7 +38,7 @@
  * ISA drivers use hard coded offsets.  If no ISA bus exists nothing
  * is mapped on the first 64K of IO space
  */
-unsigned long pci_io_base;
+unsigned long pci_io_base = ISA_IO_BASE;
 EXPORT_SYMBOL(pci_io_base);
 
 static int __init pcibios_init(void)
@@ -47,7 +47,6 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
-	pci_io_base = ISA_IO_BASE;
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b2740c6..bfbb3c8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -910,14 +910,6 @@ void __init hash__early_init_mmu(void)
 	__pmd_val_bits = 0;
 	__pud_val_bits = 0;
 	__pgd_val_bits = 0;
-
-	__kernel_virt_start = H_KERN_VIRT_START;
-	__kernel_virt_size = H_KERN_VIRT_SIZE;
-	__vmalloc_start = H_VMALLOC_START;
-	__vmalloc_end = H_VMALLOC_END;
-	vmemmap = (struct page *)H_VMEMMAP_BASE;
-	ioremap_bot = IOREMAP_BASE;
-
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c939e6e..9c5de01f 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -325,12 +325,6 @@ void __init radix__early_init_mmu(void)
 	__pud_val_bits = RADIX_PUD_VAL_BITS;
 	__pgd_val_bits = RADIX_PGD_VAL_BITS;
 
-	__kernel_virt_start = RADIX_KERN_VIRT_START;
-	__kernel_virt_size = RADIX_KERN_VIRT_SIZE;
-	__vmalloc_start = RADIX_VMALLOC_START;
-	__vmalloc_end = RADIX_VMALLOC_END;
-	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
-	ioremap_bot = IOREMAP_BASE;
 	/*
 	 * For now radix also use the same frag size
 	 */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e009e06..1408776 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -94,24 +94,12 @@ unsigned long __pud_val_bits;
 EXPORT_SYMBOL(__pud_val_bits);
 unsigned long __pgd_val_bits;
 EXPORT_SYMBOL(__pgd_val_bits);
-unsigned long __kernel_virt_start;
-EXPORT_SYMBOL(__kernel_virt_start);
-unsigned long __kernel_virt_size;
-EXPORT_SYMBOL(__kernel_virt_size);
-unsigned long __vmalloc_start;
-EXPORT_SYMBOL(__vmalloc_start);
-unsigned long __vmalloc_end;
-EXPORT_SYMBOL(__vmalloc_end);
-struct page *vmemmap;
-EXPORT_SYMBOL(vmemmap);
 unsigned long __pte_frag_nr;
 EXPORT_SYMBOL(__pte_frag_nr);
 unsigned long __pte_frag_size_shift;
 EXPORT_SYMBOL(__pte_frag_size_shift);
-unsigned long ioremap_bot;
-#else /* !CONFIG_PPC_BOOK3S_64 */
+#endif /* !CONFIG_PPC_BOOK3S_64 */
 unsigned long ioremap_bot = IOREMAP_BASE;
-#endif
 
 /**
  * __ioremap_at - Low level function to establish the page tables
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index dfdb90c..15b8f71 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -91,7 +91,7 @@ slb_miss_kernel_load_vmemmap:
 	 * can be demoted from 64K -> 4K dynamically on some machines
 	 */
 	clrldi	r11,r10,48
-	cmpldi	r11,(H_VMALLOC_SIZE >> 28) - 1
+	cmpldi	r11,(VMALLOC_SIZE >> 28) - 1
 	bgt	5f
 	lhz	r11,PACAVMALLOCSLLP(r13)
 	b	6f
--------------000807080801060705050502--
