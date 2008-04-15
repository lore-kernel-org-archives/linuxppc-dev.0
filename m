Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69B9ADE2A1
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 05:56:24 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 03/13] [POWERPC] Remove and replace uses of PPC_MEMSTART with
	memstart_addr
Date: Tue, 15 Apr 2008 14:52:21 -0500
Message-Id: <1208289151-2925-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1208289151-2925-3-git-send-email-galak@kernel.crashing.org>
References: <1208289151-2925-1-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-2-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-3-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A number of users of PPC_MEMSTART (40x, ppc_mmu_32) can just always use
0 as we don't support booting these kernels at non-zero physical addresses
since their exception vectors must be at 0 (or 0xfffx_xxxx).

For the sub-arches that support relocatable interrupt vectors (book-e) its
reasonable to have memory start at a non-zero physical address.  For those
cases use the variable memstart_addr instead of the #define PPC_MEMSTART
since the only uses of PPC_MEMSTART are for initialization and in the
future we can set memstart_addr at runtime to have a relocatable kernel.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/40x_mmu.c       |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c |   11 +++++------
 arch/powerpc/mm/init_32.c       |    7 +++----
 arch/powerpc/mm/mmu_decl.h      |    1 +
 arch/powerpc/mm/pgtable_32.c    |    5 +++--
 arch/powerpc/mm/ppc_mmu_32.c    |   11 ++---------
 include/asm-powerpc/page_32.h   |    2 --
 7 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index 3899ea9..cecbbc7 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -97,7 +97,7 @@ unsigned long __init mmu_mapin_ram(void)
 	phys_addr_t p;
 
 	v = KERNELBASE;
-	p = PPC_MEMSTART;
+	p = 0;
 	s = total_lowmem;
 
 	if (__map_without_ltlbs)
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index c93a966..3dd0c81 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -53,13 +53,12 @@
 #include <asm/machdep.h>
 #include <asm/setup.h>
 
+#include "mmu_decl.h"
+
 extern void loadcam_entry(unsigned int index);
 unsigned int tlbcam_index;
 unsigned int num_tlbcam_entries;
 static unsigned long __cam0, __cam1, __cam2;
-extern unsigned long total_lowmem;
-extern unsigned long __max_low_memory;
-extern unsigned long __initial_memory_limit;
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
 #define NUM_TLBCAMS	(16)
@@ -165,15 +164,15 @@ void invalidate_tlbcam_entry(int index)
 void __init cam_mapin_ram(unsigned long cam0, unsigned long cam1,
 		unsigned long cam2)
 {
-	settlbcam(0, PAGE_OFFSET, PPC_MEMSTART, cam0, _PAGE_KERNEL, 0);
+	settlbcam(0, PAGE_OFFSET, memstart_addr, cam0, _PAGE_KERNEL, 0);
 	tlbcam_index++;
 	if (cam1) {
 		tlbcam_index++;
-		settlbcam(1, PAGE_OFFSET+cam0, PPC_MEMSTART+cam0, cam1, _PAGE_KERNEL, 0);
+		settlbcam(1, PAGE_OFFSET+cam0, memstart_addr+cam0, cam1, _PAGE_KERNEL, 0);
 	}
 	if (cam2) {
 		tlbcam_index++;
-		settlbcam(2, PAGE_OFFSET+cam0+cam1, PPC_MEMSTART+cam0+cam1, cam2, _PAGE_KERNEL, 0);
+		settlbcam(2, PAGE_OFFSET+cam0+cam1, memstart_addr+cam0+cam1, cam2, _PAGE_KERNEL, 0);
 	}
 }
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 0c66a9f..1d7e5b8 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -59,8 +59,8 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long total_memory;
 unsigned long total_lowmem;
 
-unsigned long ppc_memstart;
-unsigned long ppc_memoffset = PAGE_OFFSET;
+phys_addr_t memstart_addr;
+phys_addr_t lowmem_end_addr;
 
 int boot_mapsize;
 #ifdef CONFIG_PPC_PMAC
@@ -145,8 +145,7 @@ void __init MMU_init(void)
 		printk(KERN_WARNING "Only using first contiguous memory region");
 	}
 
-	total_memory = lmb_end_of_DRAM();
-	total_lowmem = total_memory;
+	total_lowmem = total_memory = lmb_end_of_DRAM() - memstart_addr;
 
 #ifdef CONFIG_FSL_BOOKE
 	/* Freescale Book-E parts expect lowmem to be mapped by fixed TLB
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index ebfd13d..5bc11f5 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -51,6 +51,7 @@ extern unsigned long __max_low_memory;
 extern unsigned long __initial_memory_limit;
 extern unsigned long total_memory;
 extern unsigned long total_lowmem;
+extern phys_addr_t memstart_addr;
 
 /* ...and now those things that may be slightly different between processor
  * architectures.  -- Dan
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index ac3390f..64c44bc 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -281,12 +281,13 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
  */
 void __init mapin_ram(void)
 {
-	unsigned long v, p, s, f;
+	unsigned long v, s, f;
+	phys_addr_t p;
 	int ktext;
 
 	s = mmu_mapin_ram();
 	v = KERNELBASE + s;
-	p = PPC_MEMSTART + s;
+	p = memstart_addr + s;
 	for (; s < total_lowmem; s += PAGE_SIZE) {
 		ktext = ((char *) v >= _stext && (char *) v < etext);
 		f = ktext ?_PAGE_RAM_TEXT : _PAGE_RAM;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 72de3c7..65f915c 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -82,7 +82,6 @@ unsigned long __init mmu_mapin_ram(void)
 #else
 	unsigned long tot, bl, done;
 	unsigned long max_size = (256<<20);
-	unsigned long align;
 
 	if (__map_without_bats) {
 		printk(KERN_DEBUG "RAM mapped without BATs\n");
@@ -93,19 +92,13 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
-	/* alignment of PPC_MEMSTART */
-	align = ~(PPC_MEMSTART-1) & PPC_MEMSTART;
-	/* set BAT block size to MIN(max_size, align) */
-	if (align && align < max_size)
-		max_size = align;
-
 	tot = total_lowmem;
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > tot)
 			break;
 	}
 
-	setbat(2, KERNELBASE, PPC_MEMSTART, bl, _PAGE_RAM);
+	setbat(2, KERNELBASE, 0, bl, _PAGE_RAM);
 	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
 	if ((done < tot) && !bat_addrs[3].limit) {
 		/* use BAT3 to cover a bit more */
@@ -113,7 +106,7 @@ unsigned long __init mmu_mapin_ram(void)
 		for (bl = 128<<10; bl < max_size; bl <<= 1)
 			if (bl * 2 > tot)
 				break;
-		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
+		setbat(3, KERNELBASE+done, done, bl, _PAGE_RAM);
 		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
 	}
 
diff --git a/include/asm-powerpc/page_32.h b/include/asm-powerpc/page_32.h
index 65ea19e..51f8134 100644
--- a/include/asm-powerpc/page_32.h
+++ b/include/asm-powerpc/page_32.h
@@ -3,8 +3,6 @@
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_DEFAULT_FLAGS32
 
-#define PPC_MEMSTART	0
-
 #ifdef CONFIG_NOT_COHERENT_CACHE
 #define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
 #endif
-- 
1.5.4.1
