Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05FBE1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:55:23 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 1/4] powerpc: Make a bunch of things static
Date: Wed, 20 Aug 2014 08:55:18 +1000
Message-Id: <1408488921-19187-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/hw_breakpoint.c       |  2 +-
 arch/powerpc/kernel/nvram_64.c            |  2 +-
 arch/powerpc/kernel/pci-common.c          |  2 +-
 arch/powerpc/kernel/pci_of_scan.c         |  2 +-
 arch/powerpc/kernel/prom.c                |  5 +++--
 arch/powerpc/kernel/ptrace.c              |  2 +-
 arch/powerpc/kernel/rtasd.c               |  2 +-
 arch/powerpc/kernel/time.c                |  4 ++--
 arch/powerpc/lib/feature-fixups.c         |  2 +-
 arch/powerpc/mm/hash_utils_64.c           |  2 +-
 arch/powerpc/mm/pgtable.c                 |  2 +-
 arch/powerpc/perf/core-book3s.c           | 18 +++++++++---------
 arch/powerpc/platforms/powernv/eeh-ioda.c |  4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c |  6 +++---
 arch/powerpc/platforms/powernv/setup.c    |  2 +-
 arch/powerpc/platforms/powernv/smp.c      |  2 +-
 arch/powerpc/platforms/pseries/dlpar.c    |  4 ++--
 arch/powerpc/platforms/pseries/nvram.c    | 12 +++++++-----
 arch/powerpc/platforms/pseries/ras.c      |  2 +-
 arch/powerpc/platforms/pseries/setup.c    |  2 +-
 arch/powerpc/sysdev/mpic.c                |  2 +-
 arch/powerpc/sysdev/msi_bitmap.c          |  6 +++---
 22 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 0bb5918..1f7d84e 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -293,7 +293,7 @@ out:
 /*
  * Handle single-step exceptions following a DABR hit.
  */
-int __kprobes single_step_dabr_instruction(struct die_args *args)
+static int __kprobes single_step_dabr_instruction(struct die_args *args)
 {
 	struct pt_regs *regs = args->regs;
 	struct perf_event *bp = NULL;
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 28b898e..34f7c9b 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -567,7 +567,7 @@ static int __init nvram_init(void)
   	return rc;
 }
 
-void __exit nvram_cleanup(void)
+static void __exit nvram_cleanup(void)
 {
         misc_deregister( &nvram_dev );
 }
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b2814e2..bd84771 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1140,7 +1140,7 @@ static int reparent_resources(struct resource *parent,
  *	    as well.
  */
 
-void pcibios_allocate_bus_resources(struct pci_bus *bus)
+static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 {
 	struct pci_bus *b;
 	int i;
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 44562aa..e6245e9 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -38,7 +38,7 @@ static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
  * @addr0: value of 1st cell of a device tree PCI address.
  * @bridge: Set this flag if the address is from a bridge 'ranges' property
  */
-unsigned int pci_parse_of_flags(u32 addr0, int bridge)
+static unsigned int pci_parse_of_flags(u32 addr0, int bridge)
 {
 	unsigned int flags = 0;
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1a3b105..6d8c4cb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -386,8 +386,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-int __init early_init_dt_scan_chosen_ppc(unsigned long node, const char *uname,
-					 int depth, void *data)
+static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
+						const char *uname,
+						int depth, void *data)
 {
 	const unsigned long *lprop; /* All these set by kernel, so no need to convert endian */
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2e3d2bf..cdb404e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -932,7 +932,7 @@ void ptrace_triggered(struct perf_event *bp,
 }
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
-int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
+static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index e736387..5a2c049 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -286,7 +286,7 @@ static void prrn_work_fn(struct work_struct *work)
 
 static DECLARE_WORK(prrn_work, prrn_work_fn);
 
-void prrn_schedule_update(u32 scope)
+static void prrn_schedule_update(u32 scope)
 {
 	flush_work(&prrn_work);
 	prrn_update_scope = scope;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 368ab37..f6b3430 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -479,7 +479,7 @@ void arch_irq_work_raise(void)
 
 #endif /* CONFIG_IRQ_WORK */
 
-void __timer_interrupt(void)
+static void __timer_interrupt(void)
 {
 	struct pt_regs *regs = get_irq_regs();
 	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
@@ -643,7 +643,7 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
 	return found;
 }
 
-void start_cpu_decrementer(void)
+static void start_cpu_decrementer(void)
 {
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	/* Clear any pending timer interrupts */
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 7a8a748..7ce3870 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -164,7 +164,7 @@ static long calc_offset(struct fixup_entry *entry, unsigned int *p)
 	return (unsigned long)p - (unsigned long)entry;
 }
 
-void test_basic_patching(void)
+static void test_basic_patching(void)
 {
 	extern unsigned int ftr_fixup_test1;
 	extern unsigned int end_ftr_fixup_test1;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index daee7f4..18df45f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -867,7 +867,7 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 }
 
 #ifdef CONFIG_PPC_MM_SLICES
-unsigned int get_paca_psize(unsigned long addr)
+static unsigned int get_paca_psize(unsigned long addr)
 {
 	u64 lpsizes;
 	unsigned char *hpsizes;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index c695943..c90e602 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -48,7 +48,7 @@ static inline int pte_looks_normal(pte_t pte)
 	    (_PAGE_PRESENT | _PAGE_USER);
 }
 
-struct page * maybe_pte_to_page(pte_t pte)
+static struct page *maybe_pte_to_page(pte_t pte)
 {
 	unsigned long pfn = pte_pfn(pte);
 	struct page *page;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b7cd00b..a6995d4 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -59,9 +59,9 @@ struct cpu_hw_events {
 	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
 };
 
-DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
-struct power_pmu *ppmu;
+static struct power_pmu *ppmu;
 
 /*
  * Normally, to ignore kernel events we set the FCS (freeze counters
@@ -124,7 +124,7 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-void power_pmu_flush_branch_stack(void) {}
+static void power_pmu_flush_branch_stack(void) {}
 static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -375,7 +375,7 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-void power_pmu_flush_branch_stack(void)
+static void power_pmu_flush_branch_stack(void)
 {
 	if (ppmu->bhrb_nr)
 		power_pmu_bhrb_reset();
@@ -408,7 +408,7 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 }
 
 /* Processing BHRB entries */
-void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
+static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 {
 	u64 val;
 	u64 addr;
@@ -1573,7 +1573,7 @@ static void power_pmu_stop(struct perf_event *event, int ef_flags)
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
  */
-void power_pmu_start_txn(struct pmu *pmu)
+static void power_pmu_start_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
 
@@ -1587,7 +1587,7 @@ void power_pmu_start_txn(struct pmu *pmu)
  * Clear the flag and pmu::enable() will perform the
  * schedulability test.
  */
-void power_pmu_cancel_txn(struct pmu *pmu)
+static void power_pmu_cancel_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
 
@@ -1600,7 +1600,7 @@ void power_pmu_cancel_txn(struct pmu *pmu)
  * Perform the group schedulability test as a whole
  * Return 0 if success
  */
-int power_pmu_commit_txn(struct pmu *pmu)
+static int power_pmu_commit_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw;
 	long i, n;
@@ -1888,7 +1888,7 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
-struct pmu power_pmu = {
+static struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
 	.event_init	= power_pmu_event_init,
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index c945bed..df5c2cc 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -628,8 +628,8 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
  * Retrieve error log, which contains log from device driver
  * and firmware.
  */
-int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
-		     char *drv_log, unsigned long len)
+static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
+			    char *drv_log, unsigned long len)
 {
 	pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index df241b1..4441bfa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -385,7 +385,7 @@ static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
 	}
 }
 
-int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
+static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
 {
 	struct pnv_ioda_pe *pe, *slave;
 	s64 rc;
@@ -1631,8 +1631,8 @@ static void pnv_pci_ioda_shutdown(struct pnv_phb *phb)
 		       OPAL_ASSERT_RESET);
 }
 
-void __init pnv_pci_init_ioda_phb(struct device_node *np,
-				  u64 hub_id, int ioda_type)
+static void __init pnv_pci_init_ioda_phb(struct device_node *np,
+					 u64 hub_id, int ioda_type)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 5a0e2dc..bb1fc9b 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -307,7 +307,7 @@ static int __init pnv_probe(void)
  * Returns the cpu frequency for 'cpu' in Hz. This is used by
  * /proc/cpuinfo
  */
-unsigned long pnv_get_proc_freq(unsigned int cpu)
+static unsigned long pnv_get_proc_freq(unsigned int cpu)
 {
 	unsigned long ret_freq;
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 5fcfcf4..b73adc5 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -54,7 +54,7 @@ static void pnv_smp_setup_cpu(int cpu)
 #endif
 }
 
-int pnv_smp_kick_cpu(int nr)
+static int pnv_smp_kick_cpu(int nr)
 {
 	unsigned int pcpu = get_hard_smp_processor_id(nr);
 	unsigned long start_here =
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a2450b8..d37ba4f 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -312,7 +312,7 @@ int dlpar_detach_node(struct device_node *dn)
 #define ISOLATE			0
 #define UNISOLATE		1
 
-int dlpar_acquire_drc(u32 drc_index)
+static int dlpar_acquire_drc(u32 drc_index)
 {
 	int dr_status, rc;
 
@@ -334,7 +334,7 @@ int dlpar_acquire_drc(u32 drc_index)
 	return 0;
 }
 
-int dlpar_release_drc(u32 drc_index)
+static int dlpar_release_drc(u32 drc_index)
 {
 	int dr_status, rc;
 
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 0cc240b..11a3b61 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -276,8 +276,10 @@ static ssize_t pSeries_nvram_get_size(void)
  * sequence #: The unique sequence # for each event. (until it wraps)
  * error log: The error log from event_scan
  */
-int nvram_write_os_partition(struct nvram_os_partition *part, char * buff,
-		int length, unsigned int err_type, unsigned int error_log_cnt)
+static int nvram_write_os_partition(struct nvram_os_partition *part,
+				    char *buff, int length,
+				    unsigned int err_type,
+				    unsigned int error_log_cnt)
 {
 	int rc;
 	loff_t tmp_index;
@@ -330,9 +332,9 @@ int nvram_write_error_log(char * buff, int length,
  *
  * Reads nvram partition for at most 'length'
  */
-int nvram_read_partition(struct nvram_os_partition *part, char *buff,
-			int length, unsigned int *err_type,
-			unsigned int *error_log_cnt)
+static int nvram_read_partition(struct nvram_os_partition *part, char *buff,
+				int length, unsigned int *err_type,
+				unsigned int *error_log_cnt)
 {
 	int rc;
 	loff_t tmp_index;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index dff05b9..5a4d0fc 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -126,7 +126,7 @@ struct epow_errorlog {
 #define EPOW_MAIN_ENCLOSURE		5
 #define EPOW_POWER_OFF			7
 
-void rtas_parse_epow_errlog(struct rtas_error_log *log)
+static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 {
 	struct pseries_errorlog *pseries_log;
 	struct epow_errorlog *epow_log;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index cfe8a63..bbe0e91 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -562,7 +562,7 @@ void pSeries_coalesce_init(void)
  * fw_cmo_feature_init - FW_FEATURE_CMO is not stored in ibm,hypertas-functions,
  * handle that here. (Stolen from parse_system_parameter_string)
  */
-void pSeries_cmo_feature_init(void)
+static void pSeries_cmo_feature_init(void)
 {
 	char *ptr, *key, *value, *end;
 	int call_status;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index be33c97..89cec0e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -960,7 +960,7 @@ void mpic_set_vector(unsigned int virq, unsigned int vector)
 	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
 }
 
-void mpic_set_destination(unsigned int virq, unsigned int cpuid)
+static void mpic_set_destination(unsigned int virq, unsigned int cpuid)
 {
 	struct mpic *mpic = mpic_from_irq(virq);
 	unsigned int src = virq_to_hw(virq);
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 2ff6302..a7c7a9f 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -143,7 +143,7 @@ void msi_bitmap_free(struct msi_bitmap *bmp)
 #define check(x)	\
 	if (!(x)) printk("msi_bitmap: test failed at line %d\n", __LINE__);
 
-void __init test_basics(void)
+static void __init test_basics(void)
 {
 	struct msi_bitmap bmp;
 	int i, size = 512;
@@ -188,7 +188,7 @@ void __init test_basics(void)
 	kfree(bmp.bitmap);
 }
 
-void __init test_of_node(void)
+static void __init test_of_node(void)
 {
 	u32 prop_data[] = { 10, 10, 25, 3, 40, 1, 100, 100, 200, 20 };
 	const char *expected_str = "0-9,20-24,28-39,41-99,220-255";
@@ -236,7 +236,7 @@ void __init test_of_node(void)
 	kfree(bmp.bitmap);
 }
 
-int __init msi_bitmap_selftest(void)
+static int __init msi_bitmap_selftest(void)
 {
 	printk(KERN_DEBUG "Running MSI bitmap self-tests ...\n");
 
-- 
1.9.1
