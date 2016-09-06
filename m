Return-Path: <dja@axtens.net>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSwHH6PshzDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 15:33:15 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gi6so619509pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 22:33:15 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 2/5] powerpc/sparse: Make a bunch of things static
Date: Tue,  6 Sep 2016 15:32:40 +1000
Message-Id: <1473139963-7496-2-git-send-email-dja@axtens.net>
In-Reply-To: <1473139963-7496-1-git-send-email-dja@axtens.net>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Squash a bunch of sparse warnings by making things static.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v2: remove the symbol that I dropped in the previous patch.

This is an omnibus patch - I wrote a Python script to figure out if
sparse warnings could be automatically fixed. These are the fixes
that didn't cause issues.

I have compile tested against arch/powerpc/configs/*defconfig
I haven't recursed into subdirectories or boot tested.

The patch is based on linux-next.
---
 arch/powerpc/kernel/module.c                 | 2 +-
 arch/powerpc/kernel/nvram_64.c               | 2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c          | 4 ++--
 arch/powerpc/oprofile/cell/spu_profiler.c    | 2 +-
 arch/powerpc/oprofile/cell/spu_task_sync.c   | 4 ++--
 arch/powerpc/perf/core-book3s.c              | 2 +-
 arch/powerpc/perf/hv-gpci.c                  | 2 +-
 arch/powerpc/perf/power7-pmu.c               | 2 +-
 arch/powerpc/perf/power8-pmu.c               | 2 +-
 arch/powerpc/perf/power9-pmu.c               | 2 +-
 arch/powerpc/platforms/cell/cbe_regs.c       | 2 +-
 arch/powerpc/platforms/cell/iommu.c          | 2 +-
 arch/powerpc/platforms/cell/ras.c            | 2 +-
 arch/powerpc/platforms/maple/setup.c         | 4 ++--
 arch/powerpc/platforms/pasemi/gpio_mdio.c    | 4 ++--
 arch/powerpc/platforms/pasemi/iommu.c        | 2 +-
 arch/powerpc/platforms/pasemi/setup.c        | 4 ++--
 arch/powerpc/platforms/powermac/pfunc_core.c | 2 +-
 arch/powerpc/platforms/powermac/smp.c        | 2 +-
 arch/powerpc/platforms/powernv/npu-dma.c     | 2 +-
 arch/powerpc/platforms/pseries/dlpar.c       | 4 ++--
 arch/powerpc/platforms/pseries/scanlog.c     | 2 +-
 arch/powerpc/sysdev/mmio_nvram.c             | 2 +-
 23 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index d1f1b35bf0c7..30b89d5cbb03 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -27,7 +27,7 @@
 #include <linux/sort.h>
 #include <asm/setup.h>
 
-LIST_HEAD(module_bug_list);
+static LIST_HEAD(module_bug_list);
 
 static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 				    const Elf_Shdr *sechdrs,
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 64174bf95611..46c3c76f171b 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -851,7 +851,7 @@ static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
-const struct file_operations nvram_fops = {
+static const struct file_operations nvram_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= dev_nvram_llseek,
 	.read		= dev_nvram_read,
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 05f09ae82587..95abca69b168 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -255,7 +255,7 @@ static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 	kvmppc_set_msr(vcpu, msr);
 }
 
-long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
+static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret)
 {
@@ -1608,7 +1608,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
+static ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
 			   size_t len, loff_t *ppos)
 {
 	return -EACCES;
diff --git a/arch/powerpc/oprofile/cell/spu_profiler.c b/arch/powerpc/oprofile/cell/spu_profiler.c
index b129d007e7fe..b19265de9178 100644
--- a/arch/powerpc/oprofile/cell/spu_profiler.c
+++ b/arch/powerpc/oprofile/cell/spu_profiler.c
@@ -43,7 +43,7 @@ static unsigned int profiling_interval;
 #define SPU_PC_MASK	     0xFFFF
 
 DEFINE_SPINLOCK(oprof_spu_smpl_arry_lck);
-unsigned long oprof_spu_smpl_arry_lck_flags;
+static unsigned long oprof_spu_smpl_arry_lck_flags;
 
 void set_spu_profiling_frequency(unsigned int freq_khz, unsigned int cycles_reset)
 {
diff --git a/arch/powerpc/oprofile/cell/spu_task_sync.c b/arch/powerpc/oprofile/cell/spu_task_sync.c
index ef2142ff7dbd..83d2b4ef7f0d 100644
--- a/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ b/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -36,7 +36,7 @@
 static DEFINE_SPINLOCK(buffer_lock);
 static DEFINE_SPINLOCK(cache_lock);
 static int num_spu_nodes;
-int spu_prof_num_nodes;
+static int spu_prof_num_nodes;
 
 struct spu_buffer spu_buff[MAX_NUMNODES * SPUS_PER_NODE];
 struct delayed_work spu_work;
@@ -88,7 +88,7 @@ static void spu_buff_add(unsigned long int value, int spu)
 /* This function copies the per SPU buffers to the
  * OProfile kernel buffer.
  */
-void sync_spu_buff(void)
+static void sync_spu_buff(void)
 {
 	int spu;
 	unsigned long flags;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4ed377f0f7b2..72c27b8d2cf3 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2158,7 +2158,7 @@ static void perf_event_interrupt(struct pt_regs *regs)
 		irq_exit();
 }
 
-int power_pmu_prepare_cpu(unsigned int cpu)
+static int power_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
 
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 7aa37236bb70..43fabb3cae0f 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -131,7 +131,7 @@ static const struct attribute_group *attr_groups[] = {
 #define HGPCI_MAX_DATA_BYTES \
 	(HGPCI_REQ_BUFFER_SIZE - sizeof(struct hv_get_perf_counter_info_params))
 
-DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
+static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
 
 struct hv_gpci_request_buffer {
 	struct hv_get_perf_counter_info_params params;
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index a383c23a9070..7963658dbc22 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -416,7 +416,7 @@ static struct attribute *power7_pmu_format_attr[] = {
 	NULL,
 };
 
-struct attribute_group power7_pmu_format_group = {
+static struct attribute_group power7_pmu_format_group = {
 	.name = "format",
 	.attrs = power7_pmu_format_attr,
 };
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 5fde2b192fec..ab830d106ec5 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -204,7 +204,7 @@ static struct attribute *power8_pmu_format_attr[] = {
 	NULL,
 };
 
-struct attribute_group power8_pmu_format_group = {
+static struct attribute_group power8_pmu_format_group = {
 	.name = "format",
 	.attrs = power8_pmu_format_attr,
 };
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 788346303852..8e9a81967ff8 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -119,7 +119,7 @@ static struct attribute *power9_pmu_format_attr[] = {
 	NULL,
 };
 
-struct attribute_group power9_pmu_format_group = {
+static struct attribute_group power9_pmu_format_group = {
 	.name = "format",
 	.attrs = power9_pmu_format_attr,
 };
diff --git a/arch/powerpc/platforms/cell/cbe_regs.c b/arch/powerpc/platforms/cell/cbe_regs.c
index 1428d583c238..b926438d73af 100644
--- a/arch/powerpc/platforms/cell/cbe_regs.c
+++ b/arch/powerpc/platforms/cell/cbe_regs.c
@@ -189,7 +189,7 @@ static struct device_node *cbe_get_be_node(int cpu_id)
 	return NULL;
 }
 
-void __init cbe_fill_regs_map(struct cbe_regs_map *map)
+static void __init cbe_fill_regs_map(struct cbe_regs_map *map)
 {
 	if(map->be_node) {
 		struct device_node *be, *np;
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index f7d1a4953ea0..640772af9bcb 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -651,7 +651,7 @@ static int dma_fixed_dma_supported(struct device *dev, u64 mask)
 
 static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask);
 
-struct dma_map_ops dma_iommu_fixed_ops = {
+static struct dma_map_ops dma_iommu_fixed_ops = {
 	.alloc          = dma_fixed_alloc_coherent,
 	.free           = dma_fixed_free_coherent,
 	.map_sg         = dma_fixed_map_sg,
diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 2d4f60c0119a..460ab392f0e7 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -298,7 +298,7 @@ int cbe_sysreset_hack(void)
 }
 #endif /* CONFIG_PPC_IBM_CELL_RESETBUTTON */
 
-int __init cbe_ptcal_init(void)
+static int __init cbe_ptcal_init(void)
 {
 	int ret;
 	ptcal_start_tok = rtas_token("ibm,cbe-start-ptcal");
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 3c30c7a4534d..b7f937563827 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -156,7 +156,7 @@ static void __noreturn maple_halt(void)
 }
 
 #ifdef CONFIG_SMP
-struct smp_ops_t maple_smp_ops = {
+static struct smp_ops_t maple_smp_ops = {
 	.probe		= smp_mpic_probe,
 	.message_pass	= smp_mpic_message_pass,
 	.kick_cpu	= smp_generic_kick_cpu,
@@ -176,7 +176,7 @@ static void __init maple_use_rtas_reboot_and_halt_if_present(void)
 	}
 }
 
-void __init maple_setup_arch(void)
+static void __init maple_setup_arch(void)
 {
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index ddf635000c6b..c23e60959aa8 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -306,7 +306,7 @@ static struct platform_driver gpio_mdio_driver =
 	},
 };
 
-int gpio_mdio_init(void)
+static int gpio_mdio_init(void)
 {
 	struct device_node *np;
 
@@ -326,7 +326,7 @@ int gpio_mdio_init(void)
 }
 module_init(gpio_mdio_init);
 
-void gpio_mdio_exit(void)
+static void gpio_mdio_exit(void)
 {
 	platform_driver_unregister(&gpio_mdio_driver);
 	if (gpio_regs)
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index c61667e8bb06..e74adc4e7fd8 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -199,7 +199,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	set_iommu_table_base(&dev->dev, &iommu_table_iobmap);
 }
 
-int __init iob_init(struct device_node *dn)
+static int __init iob_init(struct device_node *dn)
 {
 	unsigned long tmp;
 	u32 regword;
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index e86c1bd08f1f..1d0c3a621a38 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -105,7 +105,7 @@ static void pas_take_timebase(void)
 	arch_spin_unlock(&timebase_lock);
 }
 
-struct smp_ops_t pas_smp_ops = {
+static struct smp_ops_t pas_smp_ops = {
 	.probe		= smp_mpic_probe,
 	.message_pass	= smp_mpic_message_pass,
 	.kick_cpu	= smp_generic_kick_cpu,
@@ -115,7 +115,7 @@ struct smp_ops_t pas_smp_ops = {
 };
 #endif /* CONFIG_SMP */
 
-void __init pas_setup_arch(void)
+static void __init pas_setup_arch(void)
 {
 #ifdef CONFIG_SMP
 	/* Setup SMP callback */
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 43075081721f..695e8c4d4224 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -804,7 +804,7 @@ void pmf_unregister_driver(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(pmf_unregister_driver);
 
-struct pmf_function *__pmf_find_function(struct device_node *target,
+static struct pmf_function *__pmf_find_function(struct device_node *target,
 					 const char *name, u32 flags)
 {
 	struct device_node *actor = of_node_get(target);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 834868b9fdc9..5a8564c2092a 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -979,7 +979,7 @@ static void pmac_cpu_die(void)
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /* Core99 Macs (dual G4s and G5s) */
-struct smp_ops_t core99_smp_ops = {
+static struct smp_ops_t core99_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 00e1a0195c78..aec85e778028 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -115,7 +115,7 @@ static u64 dma_npu_get_required_mask(struct device *dev)
 	return 0;
 }
 
-struct dma_map_ops dma_npu_ops = {
+static struct dma_map_ops dma_npu_ops = {
 	.map_page		= dma_npu_map_page,
 	.map_sg			= dma_npu_map_sg,
 	.alloc			= dma_npu_alloc,
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 4748124faa10..2511ccf186af 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -27,7 +27,7 @@
 #include <asm/uaccess.h>
 #include <asm/rtas.h>
 
-struct workqueue_struct *pseries_hp_wq;
+static struct workqueue_struct *pseries_hp_wq;
 
 struct pseries_hp_work {
 	struct work_struct work;
@@ -377,7 +377,7 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	return rc;
 }
 
-void pseries_hp_work_fn(struct work_struct *work)
+static void pseries_hp_work_fn(struct work_struct *work)
 {
 	struct pseries_hp_work *hp_work =
 			container_of(work, struct pseries_hp_work, work);
diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
index b502ab61aafa..7d28cabf1206 100644
--- a/arch/powerpc/platforms/pseries/scanlog.c
+++ b/arch/powerpc/platforms/pseries/scanlog.c
@@ -156,7 +156,7 @@ static int scanlog_release(struct inode * inode, struct file * file)
 	return 0;
 }
 
-const struct file_operations scanlog_fops = {
+static const struct file_operations scanlog_fops = {
 	.owner		= THIS_MODULE,
 	.read		= scanlog_read,
 	.write		= scanlog_write,
diff --git a/arch/powerpc/sysdev/mmio_nvram.c b/arch/powerpc/sysdev/mmio_nvram.c
index 69f5814ae6d4..c31f634f1973 100644
--- a/arch/powerpc/sysdev/mmio_nvram.c
+++ b/arch/powerpc/sysdev/mmio_nvram.c
@@ -89,7 +89,7 @@ static ssize_t mmio_nvram_write(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
-void mmio_nvram_write_val(int addr, unsigned char val)
+static void mmio_nvram_write_val(int addr, unsigned char val)
 {
 	unsigned long flags;
 
-- 
2.7.4
