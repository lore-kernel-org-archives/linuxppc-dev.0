Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 01 May 2006 10:53:45 +1000
Subject: [RFC/PATCH 4/4] powerpc: Convert DBG to pr_debug for the rest of
	arch/powerpc
In-Reply-To: <1146444821.660434.518701003988.qpush@concordia>
Message-Id: <20060501005348.6985267B27@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert DBG to pr_debug for the rest of arch/powerpc.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/hash_native_64.c |   22 ++++++------------
 arch/powerpc/mm/init_64.c        |    8 ------
 arch/powerpc/mm/lmb.c            |   29 +++++++++---------------
 arch/powerpc/mm/slb.c            |   12 ++--------
 arch/powerpc/sysdev/dart_iommu.c |   10 ++++----
 arch/powerpc/sysdev/mpic.c       |   46 ++++++++++++++++++---------------------
 6 files changed, 50 insertions(+), 77 deletions(-)

Index: to-merge/arch/powerpc/mm/hash_native_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_native_64.c
+++ to-merge/arch/powerpc/mm/hash_native_64.c
@@ -10,7 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG_LOW
+#undef DEBUG	/* warning: leads to _lots_ of output */
 
 #include <linux/spinlock.h>
 #include <linux/bitops.h>
@@ -27,12 +27,6 @@
 #include <asm/cputable.h>
 #include <asm/udbg.h>
 
-#ifdef DEBUG_LOW
-#define DBG_LOW(fmt...) udbg_printf(fmt)
-#else
-#define DBG_LOW(fmt...)
-#endif
-
 #define HPTE_LOCK_BIT 3
 
 static DEFINE_SPINLOCK(native_tlbie_lock);
@@ -132,7 +126,7 @@ long native_hpte_insert(unsigned long hp
 	int i;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
-		DBG_LOW("    insert(group=%lx, va=%016lx, pa=%016lx,"
+		pr_debug("    insert(group=%lx, va=%016lx, pa=%016lx,"
 			" rflags=%lx, vflags=%lx, psize=%d)\n",
 			hpte_group, va, pa, rflags, vflags, psize);
 	}
@@ -156,7 +150,7 @@ long native_hpte_insert(unsigned long hp
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
-		DBG_LOW(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
+		pr_debug(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
 			i, hpte_v, hpte_r);
 	}
 
@@ -181,7 +175,7 @@ static long native_hpte_remove(unsigned 
 	int slot_offset;
 	unsigned long hpte_v;
 
-	DBG_LOW("    remove(group=%lx)\n", hpte_group);
+	pr_debug("    remove(group=%lx)\n", hpte_group);
 
 	/* pick a random entry to start at */
 	slot_offset = mftb() & 0x7;
@@ -222,7 +216,7 @@ static long native_hpte_updatepp(unsigne
 
 	want_v = hpte_encode_v(va, psize);
 
-	DBG_LOW("    update(va=%016lx, avpnv=%016lx, hash=%016lx, newpp=%x)",
+	pr_debug("    update(va=%016lx, avpnv=%016lx, hash=%016lx, newpp=%x)",
 		va, want_v & HPTE_V_AVPN, slot, newpp);
 
 	native_lock_hpte(hptep);
@@ -231,11 +225,11 @@ static long native_hpte_updatepp(unsigne
 
 	/* Even if we miss, we need to invalidate the TLB */
 	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID)) {
-		DBG_LOW(" -> miss\n");
+		pr_debug(" -> miss\n");
 		native_unlock_hpte(hptep);
 		ret = -1;
 	} else {
-		DBG_LOW(" -> hit\n");
+		pr_debug(" -> hit\n");
 		/* Update the HPTE */
 		hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
 			(newpp & (HPTE_R_PP | HPTE_R_N));
@@ -321,7 +315,7 @@ static void native_hpte_invalidate(unsig
 
 	local_irq_save(flags);
 
-	DBG_LOW("    invalidate(va=%016lx, hash: %x)\n", va, slot);
+	pr_debug("    invalidate(va=%016lx, hash: %x)\n", va, slot);
 
 	want_v = hpte_encode_v(va, psize);
 	native_lock_hpte(hptep);
Index: to-merge/arch/powerpc/mm/init_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/init_64.c
+++ to-merge/arch/powerpc/mm/init_64.c
@@ -67,12 +67,6 @@
 
 #include "mmu_decl.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #if PGTABLE_RANGE > USER_VSID_RANGE
 #warning Limited user VSID range means pagetable space is wasted
 #endif
@@ -172,7 +166,7 @@ void pgtable_cache_init(void)
 		int size = pgtable_cache_size[i];
 		const char *name = pgtable_cache_name[i];
 
-		DBG("Allocating page table cache %s (#%d) "
+		pr_debug("Allocating page table cache %s (#%d) "
 		    "for size: %08x...\n", name, i, size);
 		pgtable_cache[i] = kmem_cache_create(name,
 						     size, size,
Index: to-merge/arch/powerpc/mm/lmb.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/lmb.c
+++ to-merge/arch/powerpc/mm/lmb.c
@@ -10,6 +10,8 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -22,15 +24,6 @@
 #include "mmu_decl.h"		/* for __max_low_memory */
 #endif
 
-#undef DEBUG
-
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #define LMB_ALLOC_ANYWHERE	0
 
 struct lmb lmb;
@@ -40,22 +33,22 @@ void lmb_dump_all(void)
 #ifdef DEBUG
 	unsigned long i;
 
-	DBG("lmb_dump_all:\n");
-	DBG("    memory.cnt		  = 0x%lx\n", lmb.memory.cnt);
-	DBG("    memory.size		  = 0x%lx\n", lmb.memory.size);
+	pr_debug("lmb_dump_all:\n");
+	pr_debug("    memory.cnt		  = 0x%lx\n", lmb.memory.cnt);
+	pr_debug("    memory.size		  = 0x%lx\n", lmb.memory.size);
 	for (i=0; i < lmb.memory.cnt ;i++) {
-		DBG("    memory.region[0x%x].base       = 0x%lx\n",
+		pr_debug("    memory.region[0x%x].base       = 0x%lx\n",
 			    i, lmb.memory.region[i].base);
-		DBG("		      .size     = 0x%lx\n",
+		pr_debug("		      .size     = 0x%lx\n",
 			    lmb.memory.region[i].size);
 	}
 
-	DBG("\n    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);
-	DBG("    reserved.size	  = 0x%lx\n", lmb.reserved.size);
+	pr_debug("\n    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);
+	pr_debug("    reserved.size	  = 0x%lx\n", lmb.reserved.size);
 	for (i=0; i < lmb.reserved.cnt ;i++) {
-		DBG("    reserved.region[0x%x].base       = 0x%lx\n",
+		pr_debug("    reserved.region[0x%x].base       = 0x%lx\n",
 			    i, lmb.reserved.region[i].base);
-		DBG("		      .size     = 0x%lx\n",
+		pr_debug("		      .size     = 0x%lx\n",
 			    lmb.reserved.region[i].size);
 	}
 #endif /* DEBUG */
Index: to-merge/arch/powerpc/mm/slb.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/slb.c
+++ to-merge/arch/powerpc/mm/slb.c
@@ -24,12 +24,6 @@
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 extern void slb_allocate_realmode(unsigned long ea);
 extern void slb_allocate_user(unsigned long ea);
 
@@ -191,12 +185,12 @@ void slb_initialize(void)
 		patch_slb_encoding(slb_miss_user_load_normal,
 				   SLB_VSID_USER | virtual_llp);
 
-		DBG("SLB: linear  LLP = %04x\n", linear_llp);
-		DBG("SLB: virtual LLP = %04x\n", virtual_llp);
+		pr_debug("SLB: linear  LLP = %04x\n", linear_llp);
+		pr_debug("SLB: virtual LLP = %04x\n", virtual_llp);
 #ifdef CONFIG_HUGETLB_PAGE
 		patch_slb_encoding(slb_miss_user_load_huge,
 				   SLB_VSID_USER | huge_llp);
-		DBG("SLB: huge    LLP = %04x\n", huge_llp);
+		pr_debug("SLB: huge    LLP = %04x\n", huge_llp);
 #endif
 	}
 
Index: to-merge/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- to-merge.orig/arch/powerpc/sysdev/dart_iommu.c
+++ to-merge/arch/powerpc/sysdev/dart_iommu.c
@@ -27,6 +27,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -70,15 +72,13 @@ static int iommu_table_dart_inited;
 static int dart_dirty;
 static int dart_is_u4;
 
-#define DBG(...)
-
 static inline void dart_tlb_invalidate_all(void)
 {
 	unsigned long l = 0;
 	unsigned int reg, inv_bit;
 	unsigned long limit;
 
-	DBG("dart: flush\n");
+	pr_debug("dart: flush\n");
 
 	/* To invalidate the DART, set the DARTCNTL_FLUSHTLB bit in the
 	 * control register and wait for it to clear.
@@ -125,7 +125,7 @@ static void dart_build(struct iommu_tabl
 	unsigned int *dp;
 	unsigned int rpn;
 
-	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
+	pr_debug("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
 
 	index <<= DART_PAGE_FACTOR;
 	npages <<= DART_PAGE_FACTOR;
@@ -156,7 +156,7 @@ static void dart_free(struct iommu_table
 	 * bad DMAs, but then no 32-bit architecture ever does either.
 	 */
 
-	DBG("dart: free at: %lx, %lx\n", index, npages);
+	pr_debug("dart: free at: %lx, %lx\n", index, npages);
 
 	index <<= DART_PAGE_FACTOR;
 	npages <<= DART_PAGE_FACTOR;
Index: to-merge/arch/powerpc/sysdev/mpic.c
===================================================================
--- to-merge.orig/arch/powerpc/sysdev/mpic.c
+++ to-merge/arch/powerpc/sysdev/mpic.c
@@ -37,12 +37,6 @@
 #include <asm/mpic.h>
 #include <asm/smp.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static struct mpic *mpics;
 static struct mpic *mpic_primary;
 static DEFINE_SPINLOCK(mpic_lock);
@@ -205,7 +199,7 @@ static void mpic_startup_ht_interrupt(st
 	if (fixup->base == NULL)
 		return;
 
-	DBG("startup_ht_interrupt(%u, %u) index: %d\n",
+	pr_debug("startup_ht_interrupt(%u, %u) index: %d\n",
 	    source, irqflags, fixup->index);
 	spin_lock_irqsave(&mpic->fixup_lock, flags);
 	/* Enable and configure */
@@ -228,7 +222,7 @@ static void mpic_shutdown_ht_interrupt(s
 	if (fixup->base == NULL)
 		return;
 
-	DBG("shutdown_ht_interrupt(%u, %u)\n", source, irqflags);
+	pr_debug("shutdown_ht_interrupt(%u, %u)\n", source, irqflags);
 
 	/* Disable */
 	spin_lock_irqsave(&mpic->fixup_lock, flags);
@@ -271,7 +265,8 @@ static void __init mpic_scan_ht_pic(stru
 		writeb(0x10 + 2 * i, base + 2);
 		tmp = readl(base + 4);
 		irq = (tmp >> 16) & 0xff;
-		DBG("HT PIC index 0x%x, irq 0x%x, tmp: %08x\n", i, irq, tmp);
+		pr_debug("HT PIC index 0x%x, irq 0x%x, tmp: %08x\n",
+				i, irq, tmp);
 		/* mask it , will be unmasked later */
 		tmp |= 0x1;
 		writel(tmp, base + 4);
@@ -318,7 +313,7 @@ static void __init mpic_scan_ht_pics(str
 		u32 l = readl(devbase + PCI_VENDOR_ID);
 		u16 s;
 
-		DBG("devfn %x, l: %x\n", devfn, l);
+		pr_debug("devfn %x, l: %x\n", devfn, l);
 
 		/* If no device, skip */
 		if (l == 0xffffffff || l == 0x00000000 ||
@@ -417,7 +412,8 @@ static void mpic_enable_irq(unsigned int
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = irq - mpic->irq_offset;
 
-	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
+	pr_debug("%p: %s: enable_irq: %d (src %d)\n",
+			mpic, mpic->name, irq, src);
 
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
 		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
@@ -464,7 +460,7 @@ static void mpic_disable_irq(unsigned in
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = irq - mpic->irq_offset;
 
-	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
+	pr_debug("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
 		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
@@ -498,7 +494,7 @@ static void mpic_end_irq(unsigned int ir
 	struct mpic *mpic = mpic_from_irq(irq);
 
 #ifdef DEBUG_IRQ
-	DBG("%s: end_irq: %d\n", mpic->name, irq);
+	pr_debug("%s: end_irq: %d\n", mpic->name, irq);
 #endif
 	/* We always EOI on end_irq() even for edge interrupts since that
 	 * should only lower the priority, the MPIC should have properly
@@ -524,7 +520,7 @@ static void mpic_enable_ipi(unsigned int
 	struct mpic *mpic = mpic_from_ipi(irq);
 	unsigned int src = irq - mpic->ipi_offset;
 
-	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
+	pr_debug("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
 	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
 }
 
@@ -762,7 +758,7 @@ void __init mpic_init(struct mpic *mpic)
 
 #ifdef CONFIG_MPIC_BROKEN_U3
 	/* Do the HT PIC fixups on U3 broken mpic */
-	DBG("MPIC flags: %x\n", mpic->flags);
+	pr_debug("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
 		mpic_scan_ht_pics(mpic);
 #endif /* CONFIG_MPIC_BROKEN_U3 */
@@ -802,8 +798,8 @@ void __init mpic_init(struct mpic *mpic)
 #endif
 		}
 
-		DBG("setup source %d, vecpri: %08x, level: %d\n", i, vecpri,
-		    (level != 0));
+		pr_debug("setup source %d, vecpri: %08x, level: %d\n",
+				i, vecpri, (level != 0));
 
 		/* init hw */
 		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
@@ -879,7 +875,8 @@ void mpic_setup_this_cpu(void)
 
 	BUG_ON(mpic == NULL);
 
-	DBG("%s: setup_this_cpu(%d)\n", mpic->name, hard_smp_processor_id());
+	pr_debug("%s: setup_this_cpu(%d)\n",
+			mpic->name, hard_smp_processor_id());
 
 	spin_lock_irqsave(&mpic_lock, flags);
 
@@ -930,7 +927,8 @@ void mpic_teardown_this_cpu(int secondar
 
 	BUG_ON(mpic == NULL);
 
-	DBG("%s: teardown_this_cpu(%d)\n", mpic->name, hard_smp_processor_id());
+	pr_debug("%s: teardown_this_cpu(%d)\n",
+			mpic->name, hard_smp_processor_id());
 	spin_lock_irqsave(&mpic_lock, flags);
 
 	/* let the mpic know we don't want intrs.  */
@@ -952,7 +950,7 @@ void mpic_send_ipi(unsigned int ipi_no, 
 	BUG_ON(mpic == NULL);
 
 #ifdef DEBUG_IPI
-	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
+	pr_debug("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
 
 	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
@@ -965,11 +963,11 @@ int mpic_get_one_irq(struct mpic *mpic, 
 
 	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
 #ifdef DEBUG_LOW
-	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
+	pr_debug("%s: get_one_irq(): %d\n", mpic->name, irq);
 #endif
 	if (mpic->cascade && irq == mpic->cascade_vec) {
 #ifdef DEBUG_LOW
-		DBG("%s: cascading ...\n", mpic->name);
+		pr_debug("%s: cascading ...\n", mpic->name);
 #endif
 		irq = mpic->cascade(regs, mpic->cascade_data);
 		mpic_eoi(mpic);
@@ -979,12 +977,12 @@ int mpic_get_one_irq(struct mpic *mpic, 
 		return -1;
 	if (irq < MPIC_VEC_IPI_0) {
 #ifdef DEBUG_IRQ
-		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);
+		pr_debug("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);
 #endif
 		return irq + mpic->irq_offset;
 	}
 #ifdef DEBUG_IPI
-       	DBG("%s: ipi %d !\n", mpic->name, irq - MPIC_VEC_IPI_0);
+	pr_debug("%s: ipi %d !\n", mpic->name, irq - MPIC_VEC_IPI_0);
 #endif
 	return irq - MPIC_VEC_IPI_0 + mpic->ipi_offset;
 }
