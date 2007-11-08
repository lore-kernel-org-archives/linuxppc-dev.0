Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] Use SLB size from the device tree
Date: Fri, 09 Nov 2007 10:40:18 +1100
Message-ID: <510.1194565218@neuling.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we hardwire the number of SLBs but the PAPR says we export an
ibm,slb-size property to specify the number of SLB entries.  This patch
uses this property instead of assuming 64 always.  If no property is
found, we assume 64 entries as before.

This soft patches the SLB handler, so it won't change performance at
all.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Paulus: for your 2.6.25 tree.
Olof: this touches the pasemi code, but I've not tested with one.  
Will: this will interact with your SLB xmon patch, but is easy to
      resolve.

 arch/powerpc/kernel/prom.c            |   11 +++++++++++
 arch/powerpc/mm/hash_utils_64.c       |    1 +
 arch/powerpc/mm/slb.c                 |    3 +++
 arch/powerpc/mm/slb_low.S             |    5 +++--
 arch/powerpc/platforms/pasemi/setup.c |    3 ++-
 arch/powerpc/xmon/xmon.c              |    2 +-
 include/asm-powerpc/mmu-hash64.h      |    1 +
 include/asm-powerpc/reg.h             |    6 ------
 8 files changed, 22 insertions(+), 10 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
@@ -583,6 +583,16 @@ static void __init check_cpu_pa_features
 		      ibm_pa_features, ARRAY_SIZE(ibm_pa_features));
 }
 
+static void __init check_cpu_slb_size(unsigned long node)
+{
+	u32 *slb_size_ptr;
+
+	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
+	if (slb_size_ptr != NULL) {
+		mmu_slb_size = *slb_size_ptr;
+	}
+}
+
 static struct feature_property {
 	const char *name;
 	u32 min_value;
@@ -701,6 +711,7 @@ static int __init early_init_dt_scan_cpu
 
 	check_cpu_feature_properties(node);
 	check_cpu_pa_features(node);
+	check_cpu_slb_size(node);
 
 #ifdef CONFIG_PPC_PSERIES
 	if (nthreads > 1)
Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_utils_64.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
@@ -95,6 +95,7 @@ int mmu_vmalloc_psize = MMU_PAGE_4K;
 int mmu_io_psize = MMU_PAGE_4K;
 int mmu_kernel_ssize = MMU_SEGSIZE_256M;
 int mmu_highuser_ssize = MMU_SEGSIZE_256M;
+u16 mmu_slb_size = 64;
 #ifdef CONFIG_HUGETLB_PAGE
 int mmu_huge_psize = MMU_PAGE_16M;
 unsigned int HPAGE_SHIFT;
Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -255,6 +255,7 @@ void slb_initialize(void)
 	static int slb_encoding_inited;
 	extern unsigned int *slb_miss_kernel_load_linear;
 	extern unsigned int *slb_miss_kernel_load_io;
+	extern unsigned int *slb_compare_rr_to_size;
 
 	/* Prepare our SLB miss handler based on our page size */
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
@@ -268,6 +269,8 @@ void slb_initialize(void)
 				   SLB_VSID_KERNEL | linear_llp);
 		patch_slb_encoding(slb_miss_kernel_load_io,
 				   SLB_VSID_KERNEL | io_llp);
+		patch_slb_encoding(slb_compare_rr_to_size,
+				   mmu_slb_size);
 
 		DBG("SLB: linear  LLP = %04x\n", linear_llp);
 		DBG("SLB: io      LLP = %04x\n", io_llp);
Index: linux-2.6-ozlabs/arch/powerpc/mm/slb_low.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb_low.S
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb_low.S
@@ -227,8 +227,9 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISER
 
 7:	ld	r10,PACASTABRR(r13)
 	addi	r10,r10,1
-	/* use a cpu feature mask if we ever change our slb size */
-	cmpldi	r10,SLB_NUM_ENTRIES
+	/* This gets soft patched on boot. */
+_GLOBAL(slb_compare_rr_to_size)
+	cmpldi	r10,0
 
 	blt+	4f
 	li	r10,SLB_NUM_BOLTED
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pasemi/setup.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pasemi/setup.c
@@ -36,6 +36,7 @@
 #include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/of_platform.h>
+#include <asm/mmu.h>
 
 #include <pcmcia/ss.h>
 #include <pcmcia/cistpl.h>
@@ -295,7 +296,7 @@ static int pas_machine_check_handler(str
 		int i;
 
 		printk(KERN_ERR "slb contents:\n");
-		for (i = 0; i < SLB_NUM_ENTRIES; i++) {
+		for (i = 0; i < mmu_slb_size; i++) {
 			asm volatile("slbmfee  %0,%1" : "=r" (e) : "r" (i));
 			asm volatile("slbmfev  %0,%1" : "=r" (v) : "r" (i));
 			printk(KERN_ERR "%02d %016lx %016lx\n", i, e, v);
Index: linux-2.6-ozlabs/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6-ozlabs/arch/powerpc/xmon/xmon.c
@@ -2531,7 +2531,7 @@ static void dump_slb(void)
 
 	printf("SLB contents of cpu %x\n", smp_processor_id());
 
-	for (i = 0; i < SLB_NUM_ENTRIES; i++) {
+	for (i = 0; i < mmu_slb_size; i++) {
 		asm volatile("slbmfee  %0,%1" : "=r" (tmp) : "r" (i));
 		printf("%02d %016lx ", i, tmp);
 
Index: linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/mmu-hash64.h
+++ linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
@@ -180,6 +180,7 @@ extern int mmu_vmalloc_psize;
 extern int mmu_io_psize;
 extern int mmu_kernel_ssize;
 extern int mmu_highuser_ssize;
+extern u16 mmu_slb_size;
 
 /*
  * If the processor supports 64k normal pages but not 64k cache
Index: linux-2.6-ozlabs/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/reg.h
+++ linux-2.6-ozlabs/include/asm-powerpc/reg.h
@@ -695,12 +695,6 @@
 #define PV_BE		0x0070
 #define PV_PA6T		0x0090
 
-/*
- * Number of entries in the SLB. If this ever changes we should handle
- * it with a use a cpu feature fixup.
- */
-#define SLB_NUM_ENTRIES 64
-
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
 #define mfmsr()		({unsigned long rval; \
