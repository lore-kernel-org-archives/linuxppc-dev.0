Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jun 2009 17:50:15 +1000
Subject: [PATCH 5/5] powerpc: Shield code specific to 64-bit server processors
In-Reply-To: <1243929002.876045.46197476176.qpush@grosgo>
Message-Id: <20090602075032.8F4F8DDFC8@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a random collection of added ifdef's around portions of
code that only mak sense on server processors. Using either
CONFIG_PPC_STD_MMU_64 or CONFIG_PPC_BOOK3S as seems appropriate.

This is meant to make the future merging of Book3E 64-bit support
easier.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/lppaca.h        |    6 ++++++
 arch/powerpc/include/asm/mmu.h           |    4 ++--
 arch/powerpc/include/asm/pgtable-ppc64.h |    5 +++++
 arch/powerpc/kernel/irq.c                |    2 ++
 arch/powerpc/kernel/pci_64.c             |    5 +++++
 arch/powerpc/kernel/process.c            |    2 +-
 arch/powerpc/kernel/prom.c               |    2 +-
 arch/powerpc/kernel/setup_64.c           |    5 ++++-
 arch/powerpc/mm/Makefile                 |    7 ++++---
 arch/powerpc/mm/init_64.c                |    2 ++
 10 files changed, 32 insertions(+), 8 deletions(-)

--- linux-work.orig/arch/powerpc/mm/Makefile	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/mm/Makefile	2009-06-02 16:55:46.000000000 +1000
@@ -11,10 +11,11 @@ obj-y				:= fault.o mem.o pgtable.o gup.
 				   pgtable_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
-hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
-obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
+obj-$(CONFIG_PPC64)		+= mmap_64.o
+hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
+obj-$(CONFIG_PPC_STD_MMU_64)	+= hash_utils_64.o \
 				   slb_low.o slb.o stab.o \
-				   mmap_64.o $(hash-y)
+				   mmap_64.o $(hash64-y)
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
 				   tlb_hash$(CONFIG_WORD_SIZE).o \
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-06-02 16:55:46.000000000 +1000
@@ -31,9 +31,11 @@
 #error TASK_SIZE_USER64 exceeds pagetable range
 #endif
 
+#ifdef CONFIG_PPC_STD_MMU_64
 #if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
 #error TASK_SIZE_USER64 exceeds user VSID range
 #endif
+#endif
 
 /*
  * Define the address range of the vmalloc VM area.
@@ -199,8 +201,11 @@ static inline unsigned long pte_update(s
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (old & _PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
+#endif
+
 	return old;
 }
 
Index: linux-work/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu.h	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu.h	2009-06-02 16:55:46.000000000 +1000
@@ -74,10 +74,10 @@ extern void early_init_mmu_secondary(voi
 #endif /* !__ASSEMBLY__ */
 
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC_STD_MMU_64)
 /* 64-bit classic hash table MMU */
 #  include <asm/mmu-hash64.h>
-#elif defined(CONFIG_PPC_STD_MMU)
+#elif defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #  include <asm/mmu-hash32.h>
 #elif defined(CONFIG_40x)
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_64.c	2009-06-02 16:55:46.000000000 +1000
@@ -420,6 +420,9 @@ int pcibios_unmap_io_space(struct pci_bu
 	 * so flushing the hash table is the only sane way to make sure
 	 * that no hash entries are covering that removed bridge area
 	 * while still allowing other busses overlapping those pages
+	 *
+	 * Note: If we ever support P2P hotplug on Book3E, we'll have
+	 * to do an appropriate TLB flush here too
 	 */
 	if (bus->self) {
 		struct resource *res = bus->resource[0];
@@ -427,8 +430,10 @@ int pcibios_unmap_io_space(struct pci_bu
 		pr_debug("IO unmapping for PCI-PCI bridge %s\n",
 			 pci_name(bus->self));
 
+#ifdef CONFIG_PPC_STD_MMU_64
 		__flush_hash_table_range(&init_mm, res->start + _IO_BASE,
 					 res->end + _IO_BASE + 1);
+#endif
 		return 0;
 	}
 
Index: linux-work/arch/powerpc/include/asm/lppaca.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/lppaca.h	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/lppaca.h	2009-06-02 16:55:46.000000000 +1000
@@ -20,6 +20,11 @@
 #define _ASM_POWERPC_LPPACA_H
 #ifdef __KERNEL__
 
+/* These definitions relate to hypervisors that only exist when using
+ * a server type processor
+ */
+#ifdef CONFIG_PPC_BOOK3S
+
 //=============================================================================
 //
 //	This control block contains the data that is shared between the
@@ -158,5 +163,6 @@ struct slb_shadow {
 
 extern struct slb_shadow slb_shadow[];
 
+#endif /* CONFIG_PPC_BOOK3S */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_LPPACA_H */
Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2009-06-02 16:55:46.000000000 +1000
@@ -117,6 +117,7 @@ notrace void raw_local_irq_restore(unsig
 	if (!en)
 		return;
 
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
 		/*
 		 * Do we need to disable preemption here?  Not really: in the
@@ -134,6 +135,7 @@ notrace void raw_local_irq_restore(unsig
 		if (local_paca->lppaca_ptr->int_dword.any_int)
 			iseries_handle_interrupts();
 	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	/*
 	 * if (get_paca()->hard_enabled) return;
Index: linux-work/arch/powerpc/mm/init_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_64.c	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/mm/init_64.c	2009-06-02 16:55:46.000000000 +1000
@@ -66,6 +66,7 @@
 
 #include "mmu_decl.h"
 
+#ifdef CONFIG_PPC_STD_MMU_64
 #if PGTABLE_RANGE > USER_VSID_RANGE
 #warning Limited user VSID range means pagetable space is wasted
 #endif
@@ -73,6 +74,7 @@
 #if (TASK_SIZE_USER64 < PGTABLE_RANGE) && (TASK_SIZE_USER64 < USER_VSID_RANGE)
 #warning TASK_SIZE is smaller than it needs to be.
 #endif
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 phys_addr_t memstart_addr = ~0;
 phys_addr_t kernstart_addr;
Index: linux-work/arch/powerpc/kernel/process.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/process.c	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/kernel/process.c	2009-06-02 16:55:46.000000000 +1000
@@ -650,7 +650,7 @@ int copy_thread(unsigned long clone_flag
 	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
 				_ALIGN_UP(sizeof(struct thread_info), 16);
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (cpu_has_feature(CPU_FTR_SLB)) {
 		unsigned long sp_vsid;
 		unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-06-02 16:55:46.000000000 +1000
@@ -417,9 +417,11 @@ void __init setup_system(void)
 	if (ppc64_caches.iline_size != 0x80)
 		printk("ppc64_caches.icache_line_size = 0x%x\n",
 		       ppc64_caches.iline_size);
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address)
 		printk("htab_address                  = 0x%p\n", htab_address);
 	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
+#endif /* CONFIG_PPC_STD_MMU_64 */
 	if (PHYSICAL_START > 0)
 		printk("physical_start                = 0x%lx\n",
 		       PHYSICAL_START);
@@ -511,8 +513,9 @@ void __init setup_arch(char **cmdline_p)
 	irqstack_early_init();
 	emergency_stack_init();
 
+#ifdef CONFIG_PPC_STD_MMU_64
 	stabs_alloc();
-
+#endif
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	sparse_init();
Index: linux-work/arch/powerpc/kernel/prom.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom.c	2009-06-02 16:53:18.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom.c	2009-06-02 16:55:46.000000000 +1000
@@ -585,7 +585,7 @@ static void __init check_cpu_pa_features
 		      ibm_pa_features, ARRAY_SIZE(ibm_pa_features));
 }
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_STD_MMU_64
 static void __init check_cpu_slb_size(unsigned long node)
 {
 	u32 *slb_size_ptr;
