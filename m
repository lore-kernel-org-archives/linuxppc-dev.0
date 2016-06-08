Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPpBS3BLCzDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 22:48:00 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
CC: Michael Ellerman <mpe@ellerman.id.au>,
 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 R.T.Dickinson <rtd@a-eon.com>, R.T.Dickinson <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 Matthew Leaman <matthew@a-eon.biz>, luigi burdo <intermediadc@hotmail.com>
Date: Wed, 08 Jun 2016 12:33:20 +0100 (BST)
Message-ID: <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
In-Reply-To: <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
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
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c7b88401f2d2ffb.de"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c7b88401f2d2ffb.de
Content-Type: text/plain

Hello Christian

On 07/06/2016, Christian Zigotzky wrote:
> "range.size, pgprot_val(pgprot_noncached(__pgprot(0))));" isn't the 
> problem. :-) It works.
>
> 764041e0f43cc7846f6d8eb246d65b53cc06c764 is the first bad commit
> commit 764041e0f43cc7846f6d8eb246d65b53cc06c764
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Fri Apr 29 23:26:09 2016 +1000
>
>      powerpc/mm/radix: Add checks in slice code to catch radix usage
>
>      Radix doesn't need slice support. Catch incorrect usage of slice
>      code when radix is enabled.
>
>      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>

That's not where I ended up with my bisect, this commit is about 10 before the
one I found to be bad, which is:

commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Fri Apr 29 23:26:21 2016 +1000

    powerpc/mm: vmalloc abstraction in preparation for radix
    
    The vmalloc range differs between hash and radix config. Hence make
    VMALLOC_START and related constants a variable which will be runtime
    initialized depending on whether hash or radix mode is active.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    [mpe: Fix missing init of ioremap_bot in pgtable_64.c for ppc64e]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Not sure how we are getting different results though. I have attached my
bisect log and the suspect commit, whcih is quite large. I'm not sure which
part of it is at fault. I have some jobs to do now, but hope to get tesing
this later today.

Regards
Darren

----=_BOUNDARY.6c7b88401f2d2ffb.de
Content-Type: text/plain;
	name="git.bisectlog.txt"
Content-Disposition: attachment;
	filename="git.bisectlog.txt";
	size=2744

git bisect start
# bad: [ed2608faa0f701b1dbc65277a9e5c7ff7118bfd4] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect bad ed2608faa0f701b1dbc65277a9e5c7ff7118bfd4
# good: [8ffb4103f5e28d7e7890ed4774d8e009f253f56e] IB/qib: Use cache inhibitted and guarded mapping on powerpc
git bisect good 8ffb4103f5e28d7e7890ed4774d8e009f253f56e
# good: [801faf0db8947e01877920e848a4d338dd7a99e7] mm/slab: lockless decision to grow cache
git bisect good 801faf0db8947e01877920e848a4d338dd7a99e7
# bad: [2f37dd131c5d3a2eac21cd5baf80658b1b02a8ac] Merge tag 'staging-4.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 2f37dd131c5d3a2eac21cd5baf80658b1b02a8ac
# bad: [be1332c0994fbf016fa4ef0f0c4acda566fe6cb3] Merge tag 'gfs2-4.7.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect bad be1332c0994fbf016fa4ef0f0c4acda566fe6cb3
# good: [f4c80d5a16eb4b08a0d9ade154af1ebdc63f5752] Merge tag 'sound-4.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good f4c80d5a16eb4b08a0d9ade154af1ebdc63f5752
# good: [a1c28b75a95808161cacbb3531c418abe248994e] Merge branch 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
git bisect good a1c28b75a95808161cacbb3531c418abe248994e
# bad: [6eb59af580dcffc6f6982ac8ef6d27a1a5f26b27] Merge tag 'mfd-for-linus-4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect bad 6eb59af580dcffc6f6982ac8ef6d27a1a5f26b27
# bad: [4fad494321351f0ac412945c6a464109ad96734a] powerpc/powernv: Simplify pnv_eeh_reset()
git bisect bad 4fad494321351f0ac412945c6a464109ad96734a
# bad: [43a5c684270ee9b5b13c91ec048831dd5b7e0cdc] powerpc/mm/radix: Make sure swapper pgdir is properly aligned
git bisect bad 43a5c684270ee9b5b13c91ec048831dd5b7e0cdc
# good: [a9252aaefe7e72133e7a37e0eff4e950a4f33af1] powerpc/mm: Move hugetlb and THP related pmd accessors to pgtable.h
git bisect good a9252aaefe7e72133e7a37e0eff4e950a4f33af1
# good: [177ba7c647f37bc3f31667192059ee794347d79d] powerpc/mm/radix: Limit paca allocation in radix
git bisect good 177ba7c647f37bc3f31667192059ee794347d79d
# good: [934828edfadc43be07e53429ce501741bedf4a5e] powerpc/mm: Make 4K and 64K use pte_t for pgtable_t
git bisect good 934828edfadc43be07e53429ce501741bedf4a5e
# bad: [a3dece6d69b0ad21b64104dff508c67a1a1f14dd] powerpc/radix: Update MMU cache
git bisect bad a3dece6d69b0ad21b64104dff508c67a1a1f14dd
# good: [4dfb88ca9b66690d21030ccacc1cca73db90655e] powerpc/mm: Update pte filter for radix
git bisect good 4dfb88ca9b66690d21030ccacc1cca73db90655e
# bad: [d6a9996e84ac4beb7713e9485f4563e100a9b03e] powerpc/mm: vmalloc abstraction in preparation for radix
git bisect bad d6a9996e84ac4beb7713e9485f4563e100a9b03e

----=_BOUNDARY.6c7b88401f2d2ffb.de
Content-Type: text/plain;
	name="HEAD.txt"
Content-Disposition: attachment;
	filename="HEAD.txt";
	size=10182

commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Fri Apr 29 23:26:21 2016 +1000

    powerpc/mm: vmalloc abstraction in preparation for radix
    
    The vmalloc range differs between hash and radix config. Hence make
    VMALLOC_START and related constants a variable which will be runtime
    initialized depending on whether hash or radix mode is active.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    [mpe: Fix missing init of ioremap_bot in pgtable_64.c for ppc64e]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index cd3e915..f61cad3 100644
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
index 32a9756..f5628f9 100644
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
index 63eb629..f470902 100644
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
index 41503d7..3759df5 100644
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
index 64165a7..68aee43 100644
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
index 6182b6c..13afacd 100644
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
index b8c75e6..216e2bd 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -97,9 +97,20 @@ unsigned long __pud_val_bits;
 EXPORT_SYMBOL(__pud_val_bits);
 unsigned long __pgd_val_bits;
 EXPORT_SYMBOL(__pgd_val_bits);
-
-#endif
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
+unsigned long ioremap_bot;
+#else /* !CONFIG_PPC_BOOK3S_64 */
 unsigned long ioremap_bot = IOREMAP_BASE;
+#endif
 
 /**
  * __ioremap_at - Low level function to establish the page tables
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 15b8f71..dfdb90c 100644
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

----=_BOUNDARY.6c7b88401f2d2ffb.de--
