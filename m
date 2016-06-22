Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZK97204fzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 19:31:22 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: multipart/mixed;
 boundary=Apple-Mail-53ECE33A-5185-49B7-9A31-8C03B062F16A
Mime-Version: 1.0 (1.0)
Subject: Kernel 4.7 doesn't boot with the commit "powerpc-4.7-1" on the Nemo
 board
Message-Id: <424B7274-25FF-4744-8025-7E43B7AF5C3E@xenosoft.de>
Date: Wed, 22 Jun 2016 10:19:02 +0100
To: linuxppc-dev@lists.ozlabs.org, rtd@a-eon.com, rtd2@xtra.co.nz,
 Darren Stevens <darren@stevens-zone.net>, pjwall@mac.com, pjwall@me.com,
 adrian@humboldt.co.uk, contact@a-eon.com, matthew@a-eon.biz, runaway@candw.ms,
 intermediadc@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-53ECE33A-5185-49B7-9A31-8C03B062F16A
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi All,

We have a patch where is the problematic code.

One question. Which file is responsible for starting the kernel in this patc=
h? Maybe more than one file. We know that the kernel doesn't start. It must b=
e a source code for the early startup.

I was able to compile the RC4 without the three PowerPC commits and it boots=
 and works.

Please find attached our patch. Please note: We are working for the Linux su=
pport for the Nemo board. We are not developers. We are trying to solve issu=
es with the kernel. We didn't create the Nemo patch. We modified it a little=
 bit.

Thanks,

Christian

> Hello Christian
>=20
>> @Darren: Have you already found the problematic code? I think the PowerPC=

>> developers can't help us.
>=20
> Funny you should ask... I've just been giving a new patch a quick test -
> succesfully.
>=20
> I did a manual revert on commit: d6a9996e84ac4beb7713e9485f4563e100a9b03e
> against 4.7-rc3 (patch attached)
>=20
> I'm still very much at a loss as to why this patch breaks booting on our
> system, but it definately does.
>=20
> I will try removing parts of it to see which bit causes the problem.
>=20
> Regards
> Darren
>=20
> P.S. The patch is pulled from my Git tree and hasn't been directly tested.=


--Apple-Mail-53ECE33A-5185-49B7-9A31-8C03B062F16A
Content-Type: text/plain;
	name=nemo_4.7.0rc3.patch;
	x-apple-part-url=FEAD3549-ACAA-44B7-89B0-49876C8E9EBE
Content-Disposition: attachment;
	filename=nemo_4.7.0rc3.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/includ=
e/asm/book3s/64/hash.h
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
=20
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
=20
 /*
  * Region IDs
@@ -64,7 +64,7 @@
 #define REGION_MASK		(0xfUL << REGION_SHIFT)
 #define REGION_ID(ea)		(((unsigned long)(ea)) >> REGION_SHIFT)
=20
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
=20
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/inc=
lude/asm/book3s/64/pgtable.h
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
=20
 #include <asm/book3s/64/hash.h>
@@ -242,6 +230,7 @@ extern unsigned long ioremap_bot;
 #endif
=20
 #include <asm/barrier.h>
+
 /*
  * The second half of the kernel virtual space is used for IO mappings,
  * it's itself carved into the PIO region (ISA and PHB IO space) and
@@ -260,6 +249,8 @@ extern unsigned long ioremap_bot;
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
=20
+#define vmmemap			((struct page *)VMEMMAP_BASE)
+
 /* Advertise special mapping type for AGP */
 #define HAVE_PAGE_AGP
=20
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/inclu=
de/asm/book3s/64/radix.h
index 937d4e2..a8b24d6 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -31,74 +31,6 @@
 			      RADIX_PUD_INDEX_SIZE + RADIX_PGD_INDEX_SIZE +=
 PAGE_SHIFT)
 #define RADIX_PGTABLE_RANGE (ASM_CONST(1) << RADIX_PGTABLE_EADDR_SIZE)
=20
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
- * +------------------------------+  Kernel IO map end (0xc010000000000000)=

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
- * +------------------------------+  Kernel virt start (0xc008000000000000)=

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
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2d14774..0889f26 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -72,6 +72,13 @@ _GLOBAL(__start)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
 	FIXUP_ENDIAN
+/* Hack for PWRficient platforms: Due to CFE(?) bug, the 64-bit
+ * word at 0x8 needs to be set to 0. Patch it up here once we're
+ * done executing it (we can be lazy and avoid invalidating
+ * icache)
+ */
+li     r0,0
+std    0,8(0)
 	b	__start_initialization_multiplatform
 END_FTR_SECTION(0, 1)
=20
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-comm=
on.c
index 0f7a60f..fade90f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -723,6 +723,19 @@ void pci_process_bridge_OF_ranges(struct pci_controller=
 *hose,
 				isa_io_base =3D
 					(unsigned long)hose->io_base_virt;
 #endif /* CONFIG_PPC32 */
+
+
+#ifdef CONFIG_PPC_PASEMI_SB600
+                       /* Workaround for lack of device tree. New for kerne=
l 3.17: range.cpu_addr instead of cpu_addr and range.size instead of size Ch=
. Zigotzky */
+                       if (primary) {
+                               __ioremap_at(range.cpu_addr, (void *)ISA_IO_=
BASE,
+                               range.size,pgprot_val(pgprot_noncached(__pgp=
rot(0))));
+                       hose->io_base_virt =3D (void *)_IO_BASE;
+		       /* _IO_BASE needs unsigned long long for the kernel 3=
.17 Ch. Zigotzky */
+                       printk("Initialised io_base_virt 0x%lx _IO_BASE 0x%l=
lx\n", (unsigned long)hose->io_base_virt, (unsigned long long)_IO_BASE);
+                    }
+#endif
+
 			/* pci_io_size and io_base_phys always represent IO=

 			 * space starting at 0 so we factor in pci_addr
 			 */
@@ -1182,6 +1195,7 @@ static void pcibios_allocate_bus_resources(struct pci_=
bus *bus)
 				&ioport_resource : &iomem_resource;
 		else {
 			pr =3D pci_find_parent_resource(bus->self, res);
+#ifndef CONFIG_PPC_PASEMI_SB600
 			if (pr =3D=3D res) {
 				/* this happens when the generic PCI
 				 * code (wrongly) decides that this
@@ -1189,6 +1203,7 @@ static void pcibios_allocate_bus_resources(struct pci_=
bus *bus)
 				 */
 				continue;
 			}
+#endif
 		}
=20
 		pr_debug("PCI: %s (bus %d) bridge rsrc %d: %pR, parent %p (=
%s)\n",
@@ -1607,8 +1622,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	pr_debug("PCI: Scanning PHB %s\n", of_node_full_name(node));
=20
 	/* Get some IO space for the new PHB */
+#ifndef CONFIG_PPC_PASEMI_SB600
 	pcibios_setup_phb_io_space(hose);
-
+#endif
 	/* Wire up PHB bus resources */
 	pcibios_setup_phb_resources(hose, &resources);
=20
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3759df5..41503d7 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -38,7 +38,7 @@
  * ISA drivers use hard coded offsets.  If no ISA bus exists nothing
  * is mapped on the first 64K of IO space
  */
-unsigned long pci_io_base;
+unsigned long pci_io_base =3D ISA_IO_BASE;
 EXPORT_SYMBOL(pci_io_base);
=20
 static int __init pcibios_init(void)
@@ -47,7 +47,6 @@ static int __init pcibios_init(void)
=20
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
=20
-	pci_io_base =3D ISA_IO_BASE;
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-=
common.c
index 8ca79b7..21edc85 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -76,7 +76,15 @@ EXPORT_SYMBOL(ppc_md);
 struct machdep_calls *machine_id;
 EXPORT_SYMBOL(machine_id);
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+/* FIXME!!
+ * Current PASemi code does not correctly update the value of boot_cpuid
+ * As a temporary fix we use the default 0, which is known to work
+ */
+int boot_cpuid =3D 0;
+#else
 int boot_cpuid =3D -1;
+#endif
 EXPORT_SYMBOL_GPL(boot_cpuid);
=20
 unsigned long klimit =3D (unsigned long) _end;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64=
.c
index b2740c6..bfbb3c8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -910,14 +910,6 @@ void __init hash__early_init_mmu(void)
 	__pmd_val_bits =3D 0;
 	__pud_val_bits =3D 0;
 	__pgd_val_bits =3D 0;
-
-	__kernel_virt_start =3D H_KERN_VIRT_START;
-	__kernel_virt_size =3D H_KERN_VIRT_SIZE;
-	__vmalloc_start =3D H_VMALLOC_START;
-	__vmalloc_end =3D H_VMALLOC_END;
-	vmemmap =3D (struct page *)H_VMEMMAP_BASE;
-	ioremap_bot =3D IOREMAP_BASE;
-
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix=
.c
index c939e6e..9c5de01f 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -325,12 +325,6 @@ void __init radix__early_init_mmu(void)
 	__pud_val_bits =3D RADIX_PUD_VAL_BITS;
 	__pgd_val_bits =3D RADIX_PGD_VAL_BITS;
=20
-	__kernel_virt_start =3D RADIX_KERN_VIRT_START;
-	__kernel_virt_size =3D RADIX_KERN_VIRT_SIZE;
-	__vmalloc_start =3D RADIX_VMALLOC_START;
-	__vmalloc_end =3D RADIX_VMALLOC_END;
-	vmemmap =3D (struct page *)RADIX_VMEMMAP_BASE;
-	ioremap_bot =3D IOREMAP_BASE;
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
 unsigned long ioremap_bot =3D IOREMAP_BASE;
-#endif
=20
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
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/=
pasemi/Kconfig
index 00d4b28..54b6126 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -14,6 +14,13 @@ config PPC_PASEMI
 menu "PA Semi PWRficient options"
 	depends on PPC_PASEMI
=20
+config PPC_PASEMI_SB600
+       bool "Nemo SB600 South Bridge Support"
+       depends on PPC_PASEMI
+       select PPC_I8259
+       help
+       Workarounds for the SB600 South Bridge.
+
 config PPC_PASEMI_IOMMU
 	bool "PA Semi IOMMU support"
 	depends on PPC_PASEMI
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/=
pasemi/iommu.c
index c929644..03930d7 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -1,3 +1,9 @@
+/* This is a modified copy of
+* usr/src/linux-2.6.39.4/arch/powerpc/platforms/pasemi/iommu.c
+* The mod is on line 150
+* By Len Karpowicz <twotat2z@embarqmail.com
+*/
+
 /*
  * Copyright (C) 2005-2008, PA Semi, Inc
  *
@@ -147,8 +153,11 @@ static void iommu_table_iobmap_setup(void)
 	iommu_table_iobmap.it_page_shift =3D IOBMAP_PAGE_SHIFT;
=20
 	/* it_size is in number of entries */
-	iommu_table_iobmap.it_size =3D
-		0x80000000 >> iommu_table_iobmap.it_page_shift;
+
+/* Note: changed 0x80000000 to 0x7FFFFFFF for SBLive! SB0220 */
+/* out of range problem on A-EON AmigaOne X1000 */
+       iommu_table_iobmap.it_size =3D 0x7FFFFFFF >> IOBMAP_PAGE_SHIFT;
+
=20
 	/* Initialize the common IOMMU code */
 	iommu_table_iobmap.it_base =3D (unsigned long)iob_l2_base;
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pa=
semi/pci.c
index f3a68a0..b98417e 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -108,6 +108,69 @@ static int workaround_5945(struct pci_bus *bus, unsigne=
d int devfn,
 	return 1;
 }
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+static int sb600_bus =3D 5;
+static void __iomem *iob_mapbase =3D NULL;
+
+static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
+                             int offset, int len, u32 *val);
+
+static void sb600_set_flag(int bus)
+{
+    struct resource res;
+    struct device_node *dn;
+       struct pci_bus *busp;
+       u32 val;
+       int err;
+
+       if (sb600_bus =3D=3D -1)
+       {
+               busp =3D pci_find_bus(0, 0);
+               pa_pxp_read_config(busp, PCI_DEVFN(17,0), PCI_SECONDARY_BUS,=
 1, &val);
+
+               sb600_bus =3D val;
+
+               printk(KERN_CRIT "NEMO SB600 on bus %d.\n",sb600_bus);
+       }
+
+       if (iob_mapbase =3D=3D NULL)
+       {
+        dn =3D of_find_compatible_node(NULL, "io-bridge", "pasemi,1682m-iob=
");
+        if (!dn)
+        {
+               printk(KERN_CRIT "NEMO SB600 missing iob node\n");
+                       return;
+               }
+
+               err =3D of_address_to_resource(dn, 0, &res);
+        of_node_put(dn);
+
+               if (err)
+               {
+               printk(KERN_CRIT "NEMO SB600 missing resource\n");
+                       return;
+               }
+
+               printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
+
+               iob_mapbase =3D ioremap(res.start + 0x100, 0x94);
+       }
+
+       if (iob_mapbase !=3D NULL)
+       {
+               if (bus =3D=3D sb600_bus)
+               {
+                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) |=
 0x800);
+               }
+               else
+               {
+                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) &=
 ~0x800);
+               }
+       }
+}
+#endif
+
+
 static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int offset, int len, u32 *val)
 {
@@ -126,6 +189,10 @@ static int pa_pxp_read_config(struct pci_bus *bus, unsi=
gned int devfn,
=20
 	addr =3D pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+       sb600_set_flag(bus->number);
+#endif
+
 	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/=
pasemi/setup.c
index d71b2c7..7640710 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -34,6 +34,7 @@
 #include <asm/prom.h>
 #include <asm/iommu.h>
 #include <asm/machdep.h>
+#include <asm/i8259.h>
 #include <asm/mpic.h>
 #include <asm/smp.h>
 #include <asm/time.h>
@@ -72,6 +73,17 @@ static void pas_restart(char *cmd)
 		out_le32(reset_reg, 0x6000000);
 }
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+void pas_shutdown(void)
+{
+       /* (added by DStevens 19/06/13)
+          Set the PLD bit that makes the SB600 think the power button is be=
ing pressed */
+       void __iomem *pld_map =3D ioremap(0xf5000000,4096);
+       while (1)
+               out_8(pld_map+7,0x01);
+}
+#endif
+
 #ifdef CONFIG_SMP
 static arch_spinlock_t timebase_lock;
 static unsigned long timebase;
@@ -183,6 +195,56 @@ static int __init pas_setup_mce_regs(void)
 }
 machine_device_initcall(pasemi, pas_setup_mce_regs);
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+static unsigned sb600_irq_to_vector(int irq)
+{
+       switch(irq) {
+       case 3: return 216;
+       case 4: return 217;
+       case 5: return 218;
+       case 6: return 219;
+       case 7: return 220;
+       case 8: return 222;
+       case 9: return 212;
+       case 10: return 213;
+       case 11: return 214;
+       case 12: return 215;
+       case 14: return 221;
+       default: return 0;
+       }
+}
+
+static void sb600_8259_cascade(struct irq_desc *desc)
+{
+	   struct irq_chip *chip =3D irq_desc_get_chip(desc);      =20
+	   unsigned int cascade_irq =3D i8259_irq();
+       unsigned vector =3D sb600_irq_to_vector(cascade_irq);
+       if (vector > 0)
+               generic_handle_irq(vector);
+       outb(0x20, 0xA0);       /* Non-specific EOI */
+       outb(0x20, 0x20);       /* Non-specific EOI to cascade */
+       chip->irq_eoi(&desc->irq_data);	=09
+}
+extern void i8259_unmask_irq(struct irq_data *d);
+
+__init void sb600_8259_init(void)
+{
+       int gpio_virq;
+
+       // Connect legacy i8259 controller in SB600
+       printk("Init i8259\n");
+       i8259_init(NULL, 0);
+
+       gpio_virq =3D irq_create_mapping(NULL, 3);
+       irq_set_irq_type(gpio_virq, IRQ_TYPE_LEVEL_HIGH);
+       irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
+       mpic_unmask_irq(irq_get_irq_data(gpio_virq));
+
+       // Initial mapping for RTC
+       irq_create_mapping(NULL, 222);
+}
+#endif
+
 static __init void pas_init_IRQ(void)
 {
 	struct device_node *np;
@@ -246,6 +308,12 @@ static __init void pas_init_IRQ(void)
=20
 	of_node_put(mpic_node);
 	of_node_put(root);
+
+
+#ifdef CONFIG_PPC_PASEMI_SB600
+       sb600_8259_init();
+#endif
+
 }
=20
 static void __init pas_progress(char *s, unsigned short hex)
@@ -403,12 +471,39 @@ static const struct of_device_id pasemi_bus_ids[] =3D {=

 	{},
 };
=20
-static int __init pasemi_publish_devices(void)
-{
-	pasemi_pcmcia_init();
+#ifdef CONFIG_PPC_PASEMI_SB600
+
+/*
+ This should come from OF tree. See sysdev/rtc_cmos_setup for details. Need=
 to get i8259 supported correctly first, so that
+ as the standard support hard-codes IRQ 8.
+ */
+
+
+static struct resource rtc_resource[] =3D {{
+       .name =3D "rtc",
+       .start =3D 0x70,
+       .end =3D 0x71,
+       .flags =3D IORESOURCE_IO,
+}, {
+       .name =3D "rtc",
+       .start =3D 222,
+       .end =3D 222,
+       .flags =3D IORESOURCE_IRQ,
+}};
=20
-	/* Publish OF platform devices for SDC and other non-PCI devices */=

-	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
+#endif
+
+
+ static int __init pasemi_publish_devices(void)
+ {
+        pasemi_pcmcia_init();
+
+        /* Publish OF platform devices for SDC and other non-PCI devices */=

+        of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
+
+#ifdef CONFIG_PPC_PASEMI_SB600
+       platform_device_register_simple("rtc_cmos", -1, rtc_resource, 2);
+#endif
=20
 	return 0;
 }
@@ -430,9 +525,13 @@ static int __init pas_probe(void)
=20
 	alloc_iobmap_l2();
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+       pm_power_off              =3D pas_shutdown;         // Varisys provi=
ded a way to turn us off
+#endif
 	return 1;
 }
=20
+
 define_machine(pasemi) {
 	.name			=3D "PA Semi PWRficient",
 	.probe			=3D pas_probe,
@@ -445,4 +544,7 @@ define_machine(pasemi) {
 	.calibrate_decr		=3D generic_calibrate_decr,
 	.progress		=3D pas_progress,
 	.machine_check_exception =3D pas_machine_check_handler,
+#if 0 // def CONFIG_PPC_PASEMI_SB600
+       .pci_probe_mode =3D sb600_pci_probe_mode,
+#endif
 };
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index aa2c186..56f9ae5 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -103,11 +103,11 @@ static void i8259_set_irq_mask(int irq_nr)
 	outb(cached_21,0x21);
 }
=20
-static void i8259_mask_irq(struct irq_data *d)
+void i8259_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
=20
-	pr_debug("i8259_mask_irq(%d)\n", d->irq);
+	printk("i8259_mask_irq(%d)\n", d->irq);
=20
 	raw_spin_lock_irqsave(&i8259_lock, flags);
 	if (d->irq < 8)
@@ -118,11 +118,11 @@ static void i8259_mask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
=20
-static void i8259_unmask_irq(struct irq_data *d)
+void i8259_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
=20
-	pr_debug("i8259_unmask_irq(%d)\n", d->irq);
+	printk("i8259_unmask_irq(%d)\n", d->irq);
=20
 	raw_spin_lock_irqsave(&i8259_lock, flags);
 	if (d->irq < 8)
@@ -231,6 +231,8 @@ void i8259_init(struct device_node *node, unsigned long i=
ntack_addr)
 	/* initialize the controller */
 	raw_spin_lock_irqsave(&i8259_lock, flags);
=20
+	printk("About to write to i8259\n");
+
 	/* Mask all first */
 	outb(0xff, 0xA1);
 	outb(0xff, 0x21);
@@ -261,8 +263,12 @@ void i8259_init(struct device_node *node, unsigned long=
 intack_addr)
 	outb(cached_A1, 0xA1);
 	outb(cached_21, 0x21);
=20
+	printk("Done write to i8259\n");
+
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
=20
+#ifndef CONFIG_PPC_PASEMI_SB600
+
 	/* create a legacy host */
 	i8259_host =3D irq_domain_add_legacy_isa(node, &i8259_host_ops, NUL=
L);
 	if (i8259_host =3D=3D NULL) {
@@ -270,6 +276,8 @@ void i8259_init(struct device_node *node, unsigned long i=
ntack_addr)
 		return;
 	}
=20
+#endif
+
 	/* reserve our resources */
 	/* XXX should we continue doing that ? it seems to cause problems
 	 * with further requesting of PCI IO resources for that range...
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7de45b2..866926f 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -661,6 +661,56 @@ static inline void mpic_eoi(struct mpic *mpic)
  * Linux descriptor level callbacks
  */
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+
+static int sb600_vector_to_irq(unsigned vector)
+{
+       switch(vector) {
+       case 212: return 9;
+       case 213: return 10;
+       case 214: return 11;
+       case 215: return 12;
+       case 216: return 3;
+       case 217: return 4;
+       case 218: return 5;
+       case 219: return 6;
+       case 220: return 7;
+       case 221: return 14;
+       case 222: return 8;
+       default: return -1;
+       }
+}
+
+extern void i8259_mask_irq(struct irq_data *d);
+extern void i8259_unmask_irq(struct irq_data *d);
+
+int sb600_unmask_irq(unsigned irq)
+{
+       int vector =3D sb600_vector_to_irq(irq);
+       if (vector >=3D 0) {
+               i8259_unmask_irq(irq_get_irq_data(vector));
+               return 1;
+       } else
+               return 0;
+}
+
+int sb600_mask_irq(unsigned irq)
+{
+       int vector =3D sb600_vector_to_irq(irq);
+       if (vector >=3D 0) {
+               i8259_mask_irq(irq_get_irq_data(vector));
+               return 1;
+       } else
+               return 0;
+}
+
+int sb600_end_irq(unsigned irq)
+{
+       int vector =3D sb600_vector_to_irq(irq);
+       return (vector >=3D 0);
+}
+
+#endif
=20
 void mpic_unmask_irq(struct irq_data *d)
 {
@@ -668,7 +718,12 @@ void mpic_unmask_irq(struct irq_data *d)
 	struct mpic *mpic =3D mpic_from_irq_data(d);
 	unsigned int src =3D irqd_to_hwirq(d);
=20
-	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, d->irq, s=
rc);
+#ifdef CONFIG_PPC_PASEMI_SB600
+       if (sb600_unmask_irq(src))
+               return;
+#endif
+
+       DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src)=
;
=20
 	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
@@ -689,7 +744,12 @@ void mpic_mask_irq(struct irq_data *d)
 	struct mpic *mpic =3D mpic_from_irq_data(d);
 	unsigned int src =3D irqd_to_hwirq(d);
=20
-	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, d->irq, src);
+#ifdef CONFIG_PPC_PASEMI_SB600
+       if (sb600_mask_irq(src))
+               return;
+#endif
+
+       DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
=20
 	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) |
@@ -709,6 +769,14 @@ void mpic_end_irq(struct irq_data *d)
 {
 	struct mpic *mpic =3D mpic_from_irq_data(d);
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+       unsigned int src =3D irqd_to_hwirq(d);
+
+       if (src >=3D 212 && src <=3D 222)
+               return;
+#endif
+
+
 #ifdef DEBUG_IRQ
 	DBG("%s: end_irq: %d\n", mpic->name, d->irq);
 #endif
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 051b615..95fa3d1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2429,9 +2429,9 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 	if ((pdev->class >> 8) =3D=3D PCI_CLASS_STORAGE_IDE) {
 		u8 tmp8, mask;
=20
-		/* TODO: What if one channel is in native mode ... */
+		/* Don't look at dummy ports in the mask */=09
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask =3D (1 << 2) | (1 << 0);
+		mask =3D (! ata_port_is_dummy(host->ports[1]) << 2) | (! at=
a_port_is_dummy(host->ports[0]) << 0);=09
 		if ((tmp8 & mask) !=3D mask)
 			legacy_mode =3D 1;
 	}
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 970f776..4680325 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,6 +278,11 @@ static int atiixp_init_one(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] =3D { &info, &info };
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+       // Second port not wired on SB600, and config bit cannot be set by B=
IOS
+       ppi[1] =3D &ata_dummy_port_info;
+#endif
+
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
 				      ATA_HOST_PARALLEL_SCAN);
 }
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c=

index b6b7af8..8bb54f4 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -41,14 +41,36 @@ static int pata_of_platform_probe(struct platform_device=
 *ofdev)
 		return -EINVAL;
 	}
=20
-	ret =3D of_address_to_resource(dn, 1, &ctl_res);
-	if (ret) {
-		dev_err(&ofdev->dev, "can't get CTL address from "
-			"device tree\n");
-		return -EINVAL;
+	if (of_device_is_compatible(dn, "electra-ide")) {
+		/* Altstatus is really at offset 0x3f6 from the primary win=
dow
+		 * on electra-ide. Adjust ctl_res and io_res accordingly.
+		 */
+		ctl_res =3D io_res;
+		ctl_res.start =3D ctl_res.start+0x3f6;
+		io_res.end =3D ctl_res.start-1;
+
+#ifdef CONFIG_PPC_PASEMI_SB600
+       } else if (of_device_is_compatible(dn, "electra-cf")) {
+               /* Task regs are at 0x800, with alt status @ 0x80e in the pr=
imary window
+                * on electra-cf. Adjust ctl_res and io_res accordingly.
+                */
+               ctl_res =3D io_res;
+               io_res.start +=3D 0x800;
+               ctl_res.start =3D ctl_res.start + 0x80e;
+               io_res.end =3D ctl_res.start-1;
+#endif
+	} else {
+		ret =3D of_address_to_resource(dn, 1, &ctl_res);
+		if (ret) {
+			dev_err(&ofdev->dev, "can't get CTL address from "
+				"device tree\n");
+			return -EINVAL;
+		}
 	}
=20
 	irq_res =3D platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
+	if (irq_res)
+		irq_res->flags =3D 0;
=20
 	prop =3D of_get_property(dn, "reg-shift", NULL);
 	if (prop)
@@ -65,6 +87,11 @@ static int pata_of_platform_probe(struct platform_device *=
ofdev)
 		dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\=
n");
 	}
=20
+#ifdef CONFIG_PPC_PASEMI_SB600
+       irq_res =3D 0;                    // force irq off (doesn't seem to w=
ork)
+#endif
+
+
 	pio_mask =3D 1 << pio_mode;
 	pio_mask |=3D (1 << pio_mode) - 1;
=20
@@ -74,7 +101,11 @@ static int pata_of_platform_probe(struct platform_device=
 *ofdev)
=20
 static struct of_device_id pata_of_platform_match[] =3D {
 	{ .compatible =3D "ata-generic", },
-	{ },
+	{ .compatible =3D "electra-ide", },
+#ifdef CONFIG_PPC_PASEMI_SB600
+       { .compatible =3D "electra-cf",},
+#endif
+	{},
 };
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
=20
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/rad=
eon_pm.c
index 38226d9..db634d5 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -226,7 +226,10 @@ static void radeon_set_power_state(struct radeon_device=
 *rdev)
 		/* set memory clock */
 		if (rdev->asic->pm.set_memory_clock && (mclk !=3D rdev->pm.=
current_mclk)) {
 			radeon_pm_debug_check_in_vbl(rdev, false);
+               /* D.Stevens 2012 for the A-EON AmigaOne X1000: Setting memo=
ry clock only works on CAICOS and 6570, don't set for anything else (We igno=
re 6570 here */
+               if (rdev->family =3D=3D CHIP_CAICOS) {
 			radeon_set_memory_clock(rdev, mclk);
+               }
 			radeon_pm_debug_check_in_vbl(rdev, true);
 			rdev->pm.current_mclk =3D mclk;
 			DRM_DEBUG_DRIVER("Setting: m: %d\n", mclk);
@@ -1223,7 +1226,7 @@ static void radeon_pm_resume_old(struct radeon_device *=
rdev)
 						SET_VOLTAGE_TYPE_ASIC_VDDCI=
);
 		if (rdev->pm.default_sclk)
 			radeon_set_engine_clock(rdev, rdev->pm.default_sclk=
);
-		if (rdev->pm.default_mclk)
+		if (rdev->pm.default_mclk && (rdev->family =3D=3D CHIP_CAIC=
OS))     /* Fix for PPC systems HD6000 >6570 by A-EON Core Linux Support Tea=
m */=09
 			radeon_set_memory_clock(rdev, rdev->pm.default_mclk=
);
 	}
 	/* asic init will reset the default power state */
@@ -1274,7 +1277,7 @@ dpm_resume_fail:
 						SET_VOLTAGE_TYPE_ASIC_VDDCI=
);
 		if (rdev->pm.default_sclk)
 			radeon_set_engine_clock(rdev, rdev->pm.default_sclk=
);
-		if (rdev->pm.default_mclk)
+		if (rdev->pm.default_mclk && (rdev->family =3D=3D CHIP_CAIC=
OS))     /* Fix for PPC & > HD6570 by A-EON Linux Core Support Team */=09
 			radeon_set_memory_clock(rdev, rdev->pm.default_mclk=
);
 	}
 }
@@ -1321,7 +1324,7 @@ static int radeon_pm_init_old(struct radeon_device *rd=
ev)
 							SET_VOLTAGE_TYPE_AS=
IC_VDDCI);
 			if (rdev->pm.default_sclk)
 				radeon_set_engine_clock(rdev, rdev->pm.defa=
ult_sclk);
-			if (rdev->pm.default_mclk)
+			if (rdev->pm.default_mclk && (rdev->family =3D=3D C=
HIP_CAICOS))     // D.Stevens 2013: fix for >HD6570 on PPC=09
 				radeon_set_memory_clock(rdev, rdev->pm.defa=
ult_mclk);
 		}
 	}
@@ -1412,7 +1415,7 @@ dpm_failed:
 						SET_VOLTAGE_TYPE_ASIC_VDDCI=
);
 		if (rdev->pm.default_sclk)
 			radeon_set_engine_clock(rdev, rdev->pm.default_sclk=
);
-		if (rdev->pm.default_mclk)
+		if (rdev->pm.default_mclk && (rdev->family =3D=3D CHIP_CAIC=
OS))  // D.Stevens 2013: Fix for >HD6570 on ppc=09
 			radeon_set_memory_clock(rdev, rdev->pm.default_mclk=
);
 	}
 	DRM_ERROR("radeon: dpm initialization failed\n");
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..1282410 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -432,7 +432,16 @@ struct resource *pci_find_parent_resource(const struct p=
ci_dev *dev,
 	pci_bus_for_each_resource(bus, r, i) {
 		if (!r)
 			continue;
+#ifdef CONFIG_PPC_PASEMI_SB600
+	/* The new code here checks for resources that are not allocated, a=
nd no longer
+	 * returns these, however the SB600 code uses this feature to alloc=
ate IO ranges
+	 * in the ISA map, and this breaks booting on the AmigaOneX1000.
+	 * Temporary fix to get the kernel working, remove the resource all=
ocated check.
+	 */
+		if (resource_contains(r, res)) {
+#else
 		if (res->start && resource_contains(r, res)) {
+#endif
=20
 			/*
 			 * If the window is prefetchable but the BAR is
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e3ef72..f2706e5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -368,7 +368,11 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		limit |=3D ((unsigned long) io_limit_hi << 16);
 	}
=20
-	if (base <=3D limit) {
+       if (base <=3D limit
+       #ifdef CONFIG_PPC_PASEMI_SB600
+               || child->busn_res.start =3D=3D 5
+       #endif
+              ) {
 		res->flags =3D (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORE=
SOURCE_IO;
 		region.start =3D base;
 		region.end =3D limit + io_granularity - 1;
@@ -1836,6 +1840,8 @@ static int only_one_child(struct pci_bus *bus)
=20
 	if (!parent || !pci_is_pcie(parent))
 		return 0;
+	#ifndef CONFIG_PPC_PASEMI_SB600
+	// SB600 has non-zero devices on non-root bus.
 	if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
 		return 1;
=20
@@ -1848,6 +1854,7 @@ static int only_one_child(struct pci_bus *bus)
 	if (parent->has_secondary_link &&
 	    !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
 		return 1;
+	#endif
 	return 0;
 }
=20
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fbe9c72..6d16905 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -242,6 +242,13 @@ static int cmos_read_alarm(struct device *dev, struct r=
tc_wkalrm *t)
 	}
=20
 	rtc_control =3D CMOS_READ(RTC_CONTROL);
+
+#ifdef CONFIG_PPC_PASEMI_SB600
+       // Nemo BIOS does not init RTC
+       rtc_control =3D rtc_control | RTC_24H;
+       CMOS_WRITE(rtc_control, RTC_CONTROL);
+#endif
+
 	spin_unlock_irq(&rtc_lock);
=20
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c=

index 37b70f8..51947a6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -166,6 +166,7 @@ enum {
 	STAC_D965_VERBS,
 	STAC_DELL_3ST,
 	STAC_DELL_BIOS,
+	STAC_NEMO_DEFAULT,
 	STAC_DELL_BIOS_AMIC,
 	STAC_DELL_BIOS_SPDIF,
 	STAC_927X_DELL_DMIC,
@@ -1360,6 +1361,23 @@ static const struct hda_pintbl oqo9200_pin_configs[] =3D=
 {
 	{}
 };
=20
+static const struct hda_pintbl nemo_pin_configs[] =3D {
+   { 0x0a, 0x02214020 },
+   { 0x0b, 0x02A19080 },
+   { 0x0c, 0x0181304E },
+   { 0x0d, 0x01014010 },
+   { 0x0e, 0x01A19040 },
+   { 0x0f, 0x01011012 },
+   { 0x10, 0x01016011 },
+   { 0x11, 0x01012014 },
+   { 0x12, 0x103301F0 },
+   { 0x13, 0x00000000 },
+   { 0x14, 0x00000000 },
+   { 0x21, 0x01442170 },
+   { 0x22, 0x00000000 },
+   { 0x23, 0x00000000 },
+   {}
+};
=20
 static void stac9200_fixup_panasonic(struct hda_codec *codec,
 				     const struct hda_fixup *fix, int actio=
n)
@@ -3883,6 +3901,10 @@ static const struct hda_fixup stac927x_fixups[] =3D {=

 		.type =3D HDA_FIXUP_PINS,
 		.v.pins =3D d965_5st_no_fp_pin_configs,
 	},
+	[STAC_NEMO_DEFAULT] =3D {
+       		.type =3D HDA_FIXUP_PINS,
+		.v.pins =3D nemo_pin_configs,
+	},
 	[STAC_DELL_3ST] =3D {
 		.type =3D HDA_FIXUP_PINS,
 		.v.pins =3D dell_3st_pin_configs,
@@ -3939,6 +3961,7 @@ static const struct hda_model_fixup stac927x_models[] =3D=
 {
 	{ .id =3D STAC_D965_5ST_NO_FP, .name =3D "5stack-no-fp" },
 	{ .id =3D STAC_DELL_3ST, .name =3D "dell-3stack" },
 	{ .id =3D STAC_DELL_BIOS, .name =3D "dell-bios" },
+	{ .id =3D STAC_NEMO_DEFAULT, .name =3D "nemo-default" },=09
 	{ .id =3D STAC_DELL_BIOS_AMIC, .name =3D "dell-bios-amic" },
 	{ .id =3D STAC_927X_VOLKNOB, .name =3D "volknob" },
 	{}
@@ -3977,6 +4000,8 @@ static const struct snd_pci_quirk stac927x_fixup_tbl[]=
 =3D {
 			   "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_INTEL, 0xff00, 0x2500,
 			   "Intel D965", STAC_D965_5ST),
+	/* Nemo */
+	SND_PCI_QUIRK(0x1888, 0x1000, "AmigaOne X1000", STAC_NEMO_DEFAULT),=

 	/* volume-knob fixes */
 	SND_PCI_QUIRK_VENDOR(0x10cf, "FSC", STAC_927X_VOLKNOB),
 	{} /* terminator */
@@ -5036,6 +5061,7 @@ static const struct hda_device_id snd_hda_id_sigmatel[=
] =3D {
 	HDA_CODEC_ENTRY(0x83847683, "STAC9221D A2", patch_stac922x),
 	HDA_CODEC_ENTRY(0x83847618, "STAC9227", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847619, "STAC9227", patch_stac927x),
+	HDA_CODEC_ENTRY(0x83847638, "STAC92HD700", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847616, "STAC9228", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847617, "STAC9228", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847614, "STAC9229", patch_stac927x),

--Apple-Mail-53ECE33A-5185-49B7-9A31-8C03B062F16A--
