Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 5 Jul 2011 14:38:03 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/44x: don't use tlbivax on AMP systems
Message-ID: <20110705043803.GG13483@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110705043657.GF13483@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Since other OS's may be running on the other cores don't use tlbivax

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/mmu.h |    7 ++++++-
 arch/powerpc/kernel/setup_32.c |    2 ++
 arch/powerpc/mm/tlb_hash32.c   |    4 ++++
 arch/powerpc/mm/tlb_nohash.c   |   19 +++++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 4138b21..bb5591f 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -120,9 +120,14 @@ static inline int mmu_has_feature(unsigned long feature)
 	return (cur_cpu_spec->mmu_features & feature);
 }
 
+static inline void mmu_clear_feature(unsigned long feature)
+{
+	cur_cpu_spec->mmu_features &= ~feature;
+}
+
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
-/* MMU initialization (64-bit only fo now) */
+/* MMU initialization */
 extern void early_init_mmu(void);
 extern void early_init_mmu_secondary(void);
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 620d792..6bae164 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -127,6 +127,8 @@ notrace void __init machine_init(unsigned long dt_ptr)
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
+	early_init_mmu();
+
 	probe_machine();
 
 	setup_kdump_trampoline();
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index 27b863c..9a445f6 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -177,3 +177,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	flush_range(vma->vm_mm, start, end);
 }
 EXPORT_SYMBOL(flush_tlb_range);
+
+void __init early_init_mmu(void)
+{
+}
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 0bdad3a..04990b9 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -35,6 +35,7 @@
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -266,6 +267,17 @@ EXPORT_SYMBOL(flush_tlb_page);
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_PPC_47x
+void __init early_init_mmu_47x(void)
+{
+#ifdef CONFIG_SMP
+	unsigned long root = of_get_flat_dt_root();
+	if (of_get_flat_dt_prop(root, "cooperative-partition", NULL))
+		mmu_clear_feature(MMU_FTR_USE_TLBIVAX_BCAST);
+#endif /* CONFIG_SMP */
+}
+#endif /* CONFIG_PPC_47x */
+
 /*
  * Flush kernel TLB entries in the given range
  */
@@ -584,4 +596,11 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
 }
+#else /* ! CONFIG_PPC64 */
+void __init early_init_mmu(void)
+{
+#ifdef CONFIG_PPC_47x
+	early_init_mmu_47x();
+#endif
+}
 #endif /* CONFIG_PPC64 */
-- 
1.7.4.4
