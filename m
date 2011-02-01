Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D85DB70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 05:49:17 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p11Ie3vL002820
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 13:40:03 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C00DD728065
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 13:49:13 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p11InDWV340520
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 13:49:13 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p11InB5q014252
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 16:49:13 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH V2 3/6] powerpc/47x: allow kernel to be loaded in higher
	physical memory
Date: Tue,  1 Feb 2011 12:48:43 -0600
Message-Id: <1296586126-32765-4-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig                          |    2 +-
 arch/powerpc/configs/44x/iss476-smp_defconfig |    6 ++--
 arch/powerpc/kernel/head_44x.S                |   42 ++++++++++++++++++++-----
 arch/powerpc/mm/44x_mmu.c                     |   13 ++++++--
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7d69e9b..fa41026 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -827,7 +827,7 @@ config LOWMEM_CAM_NUM
 
 config RELOCATABLE
 	bool "Build a relocatable kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
 	help
 	  This builds a kernel image that is capable of running at the
 	  location the kernel is loaded at (some alignment restrictions may
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index 92f863a..a6eb6ad 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -3,8 +3,8 @@ CONFIG_SMP=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
@@ -21,10 +21,11 @@ CONFIG_ISS4xx=y
 CONFIG_HZ_100=y
 CONFIG_MATH_EMULATION=y
 CONFIG_IRQ_ALL_CPUS=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="root=/dev/issblk0"
 # CONFIG_PCI is not set
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_RELOCATABLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -67,7 +68,6 @@ CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_INOTIFY=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index cbb3436..1da9b7e 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -93,6 +93,30 @@ _ENTRY(_start);
 
 	bl	early_init
 
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * r25 will contain RPN/ERPN for the start address of memory
+	 *
+	 * Add the difference between KERNELBASE and PAGE_OFFSET to the
+	 * start of physical memory to get kernstart_addr.
+	 */
+	lis	r3,kernstart_addr@ha
+	la	r3,kernstart_addr@l(r3)
+
+	lis	r4,KERNELBASE@h
+	ori	r4,r4,KERNELBASE@l
+	lis	r5,PAGE_OFFSET@h
+	ori	r5,r5,PAGE_OFFSET@l
+	subf	r4,r5,r4
+
+	rlwinm	r6,r25,0,28,31	/* ERPN */
+	rlwinm	r7,r25,0,0,3	/* RPN - assuming 256 MB page size */
+	add	r7,r7,r4
+
+	stw	r6,0(r3)
+	stw	r7,4(r3)
+#endif
+
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
@@ -1001,9 +1025,6 @@ clear_utlb_entry:
 	lis	r3,PAGE_OFFSET@h
 	ori	r3,r3,PAGE_OFFSET@l
 
-	/* Kernel is at the base of RAM */
-	li r4, 0			/* Load the kernel physical address */
-
 	/* Load the kernel PID = 0 */
 	li	r0,0
 	mtspr	SPRN_PID,r0
@@ -1013,9 +1034,8 @@ clear_utlb_entry:
 	clrrwi	r3,r3,12		/* Mask off the effective page number */
 	ori	r3,r3,PPC47x_TLB0_VALID | PPC47x_TLB0_256M
 
-	/* Word 1 */
-	clrrwi	r4,r4,12		/* Mask off the real page number */
-					/* ERPN is 0 for first 4GB page */
+	/* Word 1 - use r25.  RPN is the same as the original entry */
+
 	/* Word 2 */
 	li	r5,0
 	ori	r5,r5,PPC47x_TLB2_S_RWX
@@ -1026,7 +1046,7 @@ clear_utlb_entry:
 	/* We write to way 0 and bolted 0 */
 	lis	r0,0x8800
 	tlbwe	r3,r0,0
-	tlbwe	r4,r0,1
+	tlbwe	r25,r0,1
 	tlbwe	r5,r0,2
 
 /*
@@ -1124,7 +1144,13 @@ head_start_common:
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
-	addis	r22,r22,KERNELBASE@h
+	/*
+	 * If the kernel was loaded at a non-zero 256 MB page, we need to
+	 * mask off the most significant 4 bits to get the relative address
+	 * from the start of physical memory
+	 */
+	rlwinm	r22,r22,0,4,31
+	addis	r22,r22,PAGE_OFFSET@h
 	mtlr	r22
 	isync
 	blr
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 024acab..f60e006 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -186,10 +186,11 @@ void __init MMU_init_hw(void)
 unsigned long __init mmu_mapin_ram(unsigned long top)
 {
 	unsigned long addr;
+	unsigned long memstart = memstart_addr & ~(PPC_PIN_SIZE - 1);
 
 	/* Pin in enough TLBs to cover any lowmem not covered by the
 	 * initial 256M mapping established in head_44x.S */
-	for (addr = PPC_PIN_SIZE; addr < lowmem_end_addr;
+	for (addr = memstart + PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE) {
 		if (mmu_has_feature(MMU_FTR_TYPE_47x))
 			ppc47x_pin_tlb(addr + PAGE_OFFSET, addr);
@@ -218,19 +219,25 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
+	u64 size;
+
+#ifndef CONFIG_RELOCATABLE
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
 	 */
 	BUG_ON(first_memblock_base != 0);
+#endif
 
 	/* 44x has a 256M TLB entry pinned at boot */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, PPC_PIN_SIZE));
+	size = (min_t(u64, first_memblock_size, PPC_PIN_SIZE));
+	memblock_set_current_limit(first_memblock_base + size);
 }
 
 #ifdef CONFIG_SMP
 void __cpuinit mmu_init_secondary(int cpu)
 {
 	unsigned long addr;
+	unsigned long memstart = memstart_addr & ~(PPC_PIN_SIZE - 1);
 
 	/* Pin in enough TLBs to cover any lowmem not covered by the
 	 * initial 256M mapping established in head_44x.S
@@ -241,7 +248,7 @@ void __cpuinit mmu_init_secondary(int cpu)
 	 * stack. current (r2) isn't initialized, smp_processor_id()
 	 * will not work, current thread info isn't accessible, ...
 	 */
-	for (addr = PPC_PIN_SIZE; addr < lowmem_end_addr;
+	for (addr = memstart + PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE) {
 		if (mmu_has_feature(MMU_FTR_TYPE_47x))
 			ppc47x_pin_tlb(addr + PAGE_OFFSET, addr);
-- 
1.7.3.4
