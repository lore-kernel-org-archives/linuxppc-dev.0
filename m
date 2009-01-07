Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F2B09DE69C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:26:07 +1100 (EST)
Date: Wed, 7 Jan 2009 11:26:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: change u64/s64 to a long long integer type
Message-Id: <20090107112603.287393e6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ingo Molnar <mingo@elte.hu>

Convert arch/powerpc/ over to long long based u64:

 -#ifdef __powerpc64__
 -# include <asm-generic/int-l64.h>
 -#else
 -# include <asm-generic/int-ll64.h>
 -#endif
 +#include <asm-generic/int-ll64.h>

This will avoid reoccuring spurious warnings in core kernel code that
comes when people test on their own hardware. (i.e. x86 in ~98% of the
cases) This is what x86 uses and it generally helps keep 64-bit code
32-bit clean too.

[Adjusted to not impact user mode (from paulus) - sfr]
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/rtas.h               |    2 +-
 arch/powerpc/include/asm/types.h              |    7 ++++-
 arch/powerpc/kernel/dma-iommu.c               |    4 +-
 arch/powerpc/kernel/iommu.c                   |   12 ++++----
 arch/powerpc/kernel/lparcfg.c                 |   10 +++---
 arch/powerpc/kernel/setup_64.c                |    6 ++--
 arch/powerpc/mm/stab.c                        |    4 +-
 arch/powerpc/oprofile/op_model_pa6t.c         |    6 ++--
 arch/powerpc/platforms/cell/beat_interrupt.c  |    2 +-
 arch/powerpc/platforms/cell/celleb_scc_epci.c |    4 +-
 arch/powerpc/platforms/cell/iommu.c           |    4 +-
 arch/powerpc/platforms/cell/ras.c             |    8 +++---
 arch/powerpc/platforms/cell/spu_base.c        |    4 +-
 arch/powerpc/platforms/cell/spu_callbacks.c   |    2 +-
 arch/powerpc/platforms/iseries/iommu.c        |    4 +-
 arch/powerpc/platforms/pseries/iommu.c        |   35 ++++++++++++-------------
 arch/powerpc/sysdev/mpic.c                    |    2 +-
 drivers/net/pasemi_mac.c                      |    6 ++--
 drivers/pcmcia/electra_cf.c                   |    2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c              |   12 ++++----
 20 files changed, 70 insertions(+), 66 deletions(-)

This patch depends on the preceding type fixup patches (or some errors,
not just warnings, will result).

This patch fixes most of the new warnings, but there are a few more
following patches to clean up the ppc64_defconfig build.

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index e0175be..0aa0315 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -18,7 +18,7 @@
  */
 
 #define RTAS_UNKNOWN_SERVICE (-1)
-#define RTAS_INSTANTIATE_MAX (1UL<<30) /* Don't instantiate rtas at/above this value */
+#define RTAS_INSTANTIATE_MAX (1ULL<<30) /* Don't instantiate rtas at/above this value */
 
 /* Buffer size for ppc_rtas system call. */
 #define RTAS_RMOBUF_MAX (64 * 1024)
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index c004c13..7ce27a5 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -1,7 +1,12 @@
 #ifndef _ASM_POWERPC_TYPES_H
 #define _ASM_POWERPC_TYPES_H
 
-#ifdef __powerpc64__
+/*
+ * This is here because we used to use l64 for 64bit powerpc
+ * and we don't want to impact user mode with our change to ll64
+ * in the kernel.
+ */
+#if defined(__powerpc64__) && !defined(__KERNEL__)
 # include <asm-generic/int-l64.h>
 #else
 # include <asm-generic/int-ll64.h>
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 14183af..2983ada 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -79,10 +79,10 @@ static int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		       "Warning: IOMMU offset too big for device mask\n");
 		if (tbl)
 			printk(KERN_INFO
-			       "mask: 0x%08lx, table offset: 0x%08lx\n",
+			       "mask: 0x%08llx, table offset: 0x%08lx\n",
 				mask, tbl->it_offset);
 		else
-			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
+			printk(KERN_INFO "mask: 0x%08llx, table unavailable\n",
 				mask);
 		return 0;
 	} else
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 1bfa706..fd51578 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -239,12 +239,12 @@ static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 		if (printk_ratelimit()) {
 			printk(KERN_INFO "iommu_free: invalid entry\n");
 			printk(KERN_INFO "\tentry     = 0x%lx\n", entry); 
-			printk(KERN_INFO "\tdma_addr  = 0x%lx\n", (u64)dma_addr);
-			printk(KERN_INFO "\tTable     = 0x%lx\n", (u64)tbl);
-			printk(KERN_INFO "\tbus#      = 0x%lx\n", (u64)tbl->it_busno);
-			printk(KERN_INFO "\tsize      = 0x%lx\n", (u64)tbl->it_size);
-			printk(KERN_INFO "\tstartOff  = 0x%lx\n", (u64)tbl->it_offset);
-			printk(KERN_INFO "\tindex     = 0x%lx\n", (u64)tbl->it_index);
+			printk(KERN_INFO "\tdma_addr  = 0x%llx\n", (u64)dma_addr);
+			printk(KERN_INFO "\tTable     = 0x%llx\n", (u64)tbl);
+			printk(KERN_INFO "\tbus#      = 0x%llx\n", (u64)tbl->it_busno);
+			printk(KERN_INFO "\tsize      = 0x%llx\n", (u64)tbl->it_size);
+			printk(KERN_INFO "\tstartOff  = 0x%llx\n", (u64)tbl->it_offset);
+			printk(KERN_INFO "\tindex     = 0x%llx\n", (u64)tbl->it_index);
 			WARN_ON(1);
 		}
 		return;
diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index d051e8c..182e0f6 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -240,7 +240,7 @@ static void parse_ppp_data(struct seq_file *m)
 	if (rc)
 		return;
 
-	seq_printf(m, "partition_entitled_capacity=%ld\n",
+	seq_printf(m, "partition_entitled_capacity=%lld\n",
 	           ppp_data.entitlement);
 	seq_printf(m, "group=%d\n", ppp_data.group_num);
 	seq_printf(m, "system_active_processors=%d\n",
@@ -265,7 +265,7 @@ static void parse_ppp_data(struct seq_file *m)
 		   ppp_data.unallocated_weight);
 	seq_printf(m, "capacity_weight=%d\n", ppp_data.weight);
 	seq_printf(m, "capped=%d\n", ppp_data.capped);
-	seq_printf(m, "unallocated_capacity=%ld\n",
+	seq_printf(m, "unallocated_capacity=%lld\n",
 		   ppp_data.unallocated_entitlement);
 }
 
@@ -509,10 +509,10 @@ static ssize_t update_ppp(u64 *entitlement, u8 *weight)
 	} else
 		return -EINVAL;
 
-	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
+	pr_debug("%s: current_entitled = %llu, current_weight = %u\n",
 		 __func__, ppp_data.entitlement, ppp_data.weight);
 
-	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
+	pr_debug("%s: new_entitled = %llu, new_weight = %u\n",
 		 __func__, new_entitled, new_weight);
 
 	retval = plpar_hcall_norets(H_SET_PPP, new_entitled, new_weight);
@@ -558,7 +558,7 @@ static ssize_t update_mpp(u64 *entitlement, u8 *weight)
 	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
 	         __func__, mpp_data.entitled_mem, mpp_data.mem_weight);
 
-	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
+	pr_debug("%s: new_entitled = %llu, new_weight = %u\n",
 		 __func__, new_entitled, new_weight);
 
 	rc = plpar_hcall_norets(H_SET_MPP, new_entitled, new_weight);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d8bd216..2d34196 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -434,8 +434,8 @@ void __init setup_system(void)
 	printk("Starting Linux PPC64 %s\n", init_utsname()->version);
 
 	printk("-----------------------------------------------------\n");
-	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
-	printk("physicalMemorySize            = 0x%lx\n", lmb_phys_mem_size());
+	printk("ppc64_pft_size                = 0x%llx\n", ppc64_pft_size);
+	printk("physicalMemorySize            = 0x%llx\n", lmb_phys_mem_size());
 	if (ppc64_caches.dline_size != 0x80)
 		printk("ppc64_caches.dcache_line_size = 0x%x\n",
 		       ppc64_caches.dline_size);
@@ -493,7 +493,7 @@ static void __init emergency_stack_init(void)
 	 * bringup, we need to get at them in real mode. This means they
 	 * must also be within the RMO region.
 	 */
-	limit = min(0x10000000UL, lmb.rmo_size);
+	limit = min(0x10000000ULL, lmb.rmo_size);
 
 	for_each_possible_cpu(i) {
 		unsigned long sp;
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 60e6032..98cd1dc 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -251,8 +251,8 @@ void __init stabs_alloc(void)
 
 		paca[cpu].stab_addr = newstab;
 		paca[cpu].stab_real = virt_to_abs(newstab);
-		printk(KERN_INFO "Segment table for CPU %d at 0x%lx "
-		       "virtual, 0x%lx absolute\n",
+		printk(KERN_INFO "Segment table for CPU %d at 0x%llx "
+		       "virtual, 0x%llx absolute\n",
 		       cpu, paca[cpu].stab_addr, paca[cpu].stab_real);
 	}
 }
diff --git a/arch/powerpc/oprofile/op_model_pa6t.c b/arch/powerpc/oprofile/op_model_pa6t.c
index c40de46..42f778d 100644
--- a/arch/powerpc/oprofile/op_model_pa6t.c
+++ b/arch/powerpc/oprofile/op_model_pa6t.c
@@ -132,7 +132,7 @@ static int pa6t_reg_setup(struct op_counter_config *ctr,
 	for (pmc = 0; pmc < cur_cpu_spec->num_pmcs; pmc++) {
 		/* counters are 40 bit. Move to cputable at some point? */
 		reset_value[pmc] = (0x1UL << 39) - ctr[pmc].count;
-		pr_debug("reset_value for pmc%u inited to 0x%lx\n",
+		pr_debug("reset_value for pmc%u inited to 0x%llx\n",
 				 pmc, reset_value[pmc]);
 	}
 
@@ -177,7 +177,7 @@ static int pa6t_start(struct op_counter_config *ctr)
 
 	oprofile_running = 1;
 
-	pr_debug("start on cpu %d, mmcr0 %lx\n", smp_processor_id(), mmcr0);
+	pr_debug("start on cpu %d, mmcr0 %llx\n", smp_processor_id(), mmcr0);
 
 	return 0;
 }
@@ -193,7 +193,7 @@ static void pa6t_stop(void)
 
 	oprofile_running = 0;
 
-	pr_debug("stop on cpu %d, mmcr0 %lx\n", smp_processor_id(), mmcr0);
+	pr_debug("stop on cpu %d, mmcr0 %llx\n", smp_processor_id(), mmcr0);
 }
 
 /* handle the perfmon overflow vector */
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index 192a935..7225484 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -99,7 +99,7 @@ static void beatic_end_irq(unsigned int irq_plug)
 	err = beat_downcount_of_interrupt(irq_plug);
 	if (err != 0) {
 		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
-			panic("Failed to downcount IRQ! Error = %16lx", err);
+			panic("Failed to downcount IRQ! Error = %16llx", err);
 
 		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
 	}
diff --git a/arch/powerpc/platforms/cell/celleb_scc_epci.c b/arch/powerpc/platforms/cell/celleb_scc_epci.c
index 08c285b..48ec88a 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_epci.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_epci.c
@@ -405,7 +405,7 @@ static int __init celleb_setup_epci(struct device_node *node,
 	hose->cfg_addr = ioremap(r.start, (r.end - r.start + 1));
 	if (!hose->cfg_addr)
 		goto error;
-	pr_debug("EPCI: cfg_addr map 0x%016lx->0x%016lx + 0x%016lx\n",
+	pr_debug("EPCI: cfg_addr map 0x%016llx->0x%016lx + 0x%016llx\n",
 		 r.start, (unsigned long)hose->cfg_addr, (r.end - r.start + 1));
 
 	if (of_address_to_resource(node, 2, &r))
@@ -413,7 +413,7 @@ static int __init celleb_setup_epci(struct device_node *node,
 	hose->cfg_data = ioremap(r.start, (r.end - r.start + 1));
 	if (!hose->cfg_data)
 		goto error;
-	pr_debug("EPCI: cfg_data map 0x%016lx->0x%016lx + 0x%016lx\n",
+	pr_debug("EPCI: cfg_data map 0x%016llx->0x%016lx + 0x%016llx\n",
 		 r.start, (unsigned long)hose->cfg_data, (r.end - r.start + 1));
 
 	hose->ops = &celleb_epci_ops;
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 88d94b5..ee5033e 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -855,7 +855,7 @@ static int __init cell_iommu_init_disabled(void)
 	 */
 	if (np && size < lmb_end_of_DRAM()) {
 		printk(KERN_WARNING "iommu: force-enabled, dma window"
-		       " (%ldMB) smaller than total memory (%ldMB)\n",
+		       " (%ldMB) smaller than total memory (%lldMB)\n",
 		       size >> 20, lmb_end_of_DRAM() >> 20);
 		return -ENODEV;
 	}
@@ -985,7 +985,7 @@ static void cell_dma_dev_setup_fixed(struct device *dev)
 	addr = cell_iommu_get_fixed_address(dev) + dma_iommu_fixed_base;
 	archdata->dma_data = (void *)addr;
 
-	dev_dbg(dev, "iommu: fixed addr = %lx\n", addr);
+	dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 }
 
 static void insert_16M_pte(unsigned long addr, unsigned long *ptab,
diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 7b4cefa..5f961c4 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -38,16 +38,16 @@ static void dump_fir(int cpu)
 	/* Todo: do some nicer parsing of bits and based on them go down
 	 * to other sub-units FIRs and not only IIC
 	 */
-	printk(KERN_ERR "Global Checkstop FIR    : 0x%016lx\n",
+	printk(KERN_ERR "Global Checkstop FIR    : 0x%016llx\n",
 	       in_be64(&pregs->checkstop_fir));
-	printk(KERN_ERR "Global Recoverable FIR  : 0x%016lx\n",
+	printk(KERN_ERR "Global Recoverable FIR  : 0x%016llx\n",
 	       in_be64(&pregs->checkstop_fir));
-	printk(KERN_ERR "Global MachineCheck FIR : 0x%016lx\n",
+	printk(KERN_ERR "Global MachineCheck FIR : 0x%016llx\n",
 	       in_be64(&pregs->spec_att_mchk_fir));
 
 	if (iregs == NULL)
 		return;
-	printk(KERN_ERR "IOC FIR                 : 0x%016lx\n",
+	printk(KERN_ERR "IOC FIR                 : 0x%016llx\n",
 	       in_be64(&iregs->ioc_fir));
 
 }
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index a5bdb89..e487ad6 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -151,7 +151,7 @@ static inline void spu_load_slb(struct spu *spu, int slbe, struct spu_slb *slb)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 
-	pr_debug("%s: adding SLB[%d] 0x%016lx 0x%016lx\n",
+	pr_debug("%s: adding SLB[%d] 0x%016llx 0x%016llx\n",
 			__func__, slbe, slb->vsid, slb->esid);
 
 	out_be64(&priv2->slb_index_W, slbe);
@@ -221,7 +221,7 @@ static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 {
 	int ret;
 
-	pr_debug("%s, %lx, %lx\n", __func__, dsisr, ea);
+	pr_debug("%s, %llx, %lx\n", __func__, dsisr, ea);
 
 	/*
 	 * Handle kernel space hash faults immediately. User hash
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 19f6bfd..fec1495 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -54,7 +54,7 @@ long spu_sys_callback(struct spu_syscall_block *s)
 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
 
 	if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {
-		pr_debug("%s: invalid syscall #%ld", __func__, s->nr_ret);
+		pr_debug("%s: invalid syscall #%lld", __func__, s->nr_ret);
 		return -ENOSYS;
 	}
 
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index bbe828f..6ed75bf 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -66,7 +66,7 @@ static int tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
 
 		rc = HvCallXm_setTce((u64)tbl->it_index, (u64)index, tce);
 		if (rc)
-			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n",
+			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%llx\n",
 					rc);
 		index++;
 		uaddr += TCE_PAGE_SIZE;
@@ -81,7 +81,7 @@ static void tce_free_iSeries(struct iommu_table *tbl, long index, long npages)
 	while (npages--) {
 		rc = HvCallXm_setTce((u64)tbl->it_index, (u64)index, 0);
 		if (rc)
-			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n",
+			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%llx\n",
 					rc);
 		index++;
 	}
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index c90817a..3ee01b4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -127,10 +127,10 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		}
 
 		if (rc && printk_ratelimit()) {
-			printk("tce_build_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
-			printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
-			printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
-			printk("\ttce val = 0x%lx\n", tce );
+			printk("tce_build_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
+			printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
+			printk("\ttcenum  = 0x%llx\n", (u64)tcenum);
+			printk("\ttce val = 0x%llx\n", tce );
 			show_stack(current, (unsigned long *)__get_SP());
 		}
 
@@ -210,10 +210,10 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	}
 
 	if (rc && printk_ratelimit()) {
-		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
-		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
-		printk("\tnpages  = 0x%lx\n", (u64)npages);
-		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
+		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
+		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
+		printk("\tnpages  = 0x%llx\n", (u64)npages);
+		printk("\ttce[0] val = 0x%llx\n", tcep[0]);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
 	return ret;
@@ -227,9 +227,9 @@ static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages
 		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, 0);
 
 		if (rc && printk_ratelimit()) {
-			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
-			printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
-			printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
+			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
+			printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
+			printk("\ttcenum  = 0x%llx\n", (u64)tcenum);
 			show_stack(current, (unsigned long *)__get_SP());
 		}
 
@@ -246,9 +246,9 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
 
 	if (rc && printk_ratelimit()) {
 		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
-		printk("\trc      = %ld\n", rc);
-		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
-		printk("\tnpages  = 0x%lx\n", (u64)npages);
+		printk("\trc      = %lld\n", rc);
+		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
+		printk("\tnpages  = 0x%llx\n", (u64)npages);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
 }
@@ -261,10 +261,9 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
 	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
 
 	if (rc && printk_ratelimit()) {
-		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%ld\n",
-			rc);
-		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
-		printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
+		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
+		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
+		printk("\ttcenum  = 0x%llx\n", (u64)tcenum);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index c82babb..d83597a 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -435,7 +435,7 @@ static void __init mpic_scan_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
 		addr = addr | ((u64)readl(base + HT_MSI_ADDR_HI) << 32);
 	}
 
-	printk(KERN_DEBUG "mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%lx\n",
+	printk(KERN_DEBUG "mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%llx\n",
 		PCI_SLOT(devfn), PCI_FUNC(devfn),
 		flags & HT_MSI_FLAGS_ENABLE ? "enabled" : "disabled", addr);
 
diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index 5b7a574..d0349e7 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -712,7 +712,7 @@ static inline void pasemi_mac_rx_error(const struct pasemi_mac *mac,
 	rcmdsta = read_dma_reg(PAS_DMA_RXINT_RCMDSTA(mac->dma_if));
 	ccmdsta = read_dma_reg(PAS_DMA_RXCHAN_CCMDSTA(chan->chno));
 
-	printk(KERN_ERR "pasemi_mac: rx error. macrx %016lx, rx status %lx\n",
+	printk(KERN_ERR "pasemi_mac: rx error. macrx %016llx, rx status %llx\n",
 		macrx, *chan->status);
 
 	printk(KERN_ERR "pasemi_mac: rcmdsta %08x ccmdsta %08x\n",
@@ -730,8 +730,8 @@ static inline void pasemi_mac_tx_error(const struct pasemi_mac *mac,
 
 	cmdsta = read_dma_reg(PAS_DMA_TXCHAN_TCMDSTA(chan->chno));
 
-	printk(KERN_ERR "pasemi_mac: tx error. mactx 0x%016lx, "\
-		"tx status 0x%016lx\n", mactx, *chan->status);
+	printk(KERN_ERR "pasemi_mac: tx error. mactx 0x%016llx, "\
+		"tx status 0x%016llx\n", mactx, *chan->status);
 
 	printk(KERN_ERR "pasemi_mac: tcmdsta 0x%08x\n", cmdsta);
 }
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index a34284b..d187ba4 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -297,7 +297,7 @@ static int __devinit electra_cf_probe(struct of_device *ofdev,
 		goto fail3;
 	}
 
-	dev_info(device, "at mem 0x%lx io 0x%lx irq %d\n",
+	dev_info(device, "at mem 0x%lx io 0x%llx irq %d\n",
 		 cf->mem_phys, io.start, cf->irq);
 
 	cf->active = 1;
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 868d35e..3098c98 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1060,7 +1060,7 @@ static int ibmvscsi_eh_abort_handler(struct scsi_cmnd *cmd)
 	}
 
 	sdev_printk(KERN_INFO, cmd->device,
-                    "aborting command. lun 0x%lx, tag 0x%lx\n",
+                    "aborting command. lun 0x%llx, tag 0x%llx\n",
 		    (((u64) lun) << 48), (u64) found_evt);
 
 	wait_for_completion(&evt->comp);
@@ -1081,7 +1081,7 @@ static int ibmvscsi_eh_abort_handler(struct scsi_cmnd *cmd)
 	if (rsp_rc) {
 		if (printk_ratelimit())
 			sdev_printk(KERN_WARNING, cmd->device,
-				    "abort code %d for task tag 0x%lx\n",
+				    "abort code %d for task tag 0x%llx\n",
 				    rsp_rc, tsk_mgmt->task_tag);
 		return FAILED;
 	}
@@ -1101,12 +1101,12 @@ static int ibmvscsi_eh_abort_handler(struct scsi_cmnd *cmd)
 
 	if (found_evt == NULL) {
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
-		sdev_printk(KERN_INFO, cmd->device, "aborted task tag 0x%lx completed\n",
+		sdev_printk(KERN_INFO, cmd->device, "aborted task tag 0x%llx completed\n",
 			    tsk_mgmt->task_tag);
 		return SUCCESS;
 	}
 
-	sdev_printk(KERN_INFO, cmd->device, "successfully aborted task tag 0x%lx\n",
+	sdev_printk(KERN_INFO, cmd->device, "successfully aborted task tag 0x%llx\n",
 		    tsk_mgmt->task_tag);
 
 	cmd->result = (DID_ABORT << 16);
@@ -1181,7 +1181,7 @@ static int ibmvscsi_eh_device_reset_handler(struct scsi_cmnd *cmd)
 		return FAILED;
 	}
 
-	sdev_printk(KERN_INFO, cmd->device, "resetting device. lun 0x%lx\n",
+	sdev_printk(KERN_INFO, cmd->device, "resetting device. lun 0x%llx\n",
 		    (((u64) lun) << 48));
 
 	wait_for_completion(&evt->comp);
@@ -1202,7 +1202,7 @@ static int ibmvscsi_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	if (rsp_rc) {
 		if (printk_ratelimit())
 			sdev_printk(KERN_WARNING, cmd->device,
-				    "reset code %d for task tag 0x%lx\n",
+				    "reset code %d for task tag 0x%llx\n",
 				    rsp_rc, tsk_mgmt->task_tag);
 		return FAILED;
 	}
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
