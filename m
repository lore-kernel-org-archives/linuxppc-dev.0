Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 07/63] powerpc: Fix a number of sparse warnings
Date: Wed,  7 Aug 2013 02:01:24 +1000
Message-Id: <1375804940-22050-8-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Address some of the trivial sparse warnings in arch/powerpc.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/legacy_serial.c             | 2 +-
 arch/powerpc/kernel/pci-common.c                | 4 ++--
 arch/powerpc/kernel/pci_64.c                    | 2 +-
 arch/powerpc/kernel/setup_64.c                  | 4 ++--
 arch/powerpc/kernel/signal_64.c                 | 8 ++++----
 arch/powerpc/kernel/smp.c                       | 2 +-
 arch/powerpc/mm/hash_utils_64.c                 | 2 +-
 arch/powerpc/mm/subpage-prot.c                  | 4 ++--
 arch/powerpc/perf/core-book3s.c                 | 2 +-
 arch/powerpc/platforms/powernv/opal.c           | 2 +-
 arch/powerpc/platforms/pseries/lpar.c           | 2 +-
 arch/powerpc/platforms/pseries/pseries_energy.c | 4 ++--
 arch/powerpc/platforms/pseries/setup.c          | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 0733b05..af1c63f 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -99,7 +99,7 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 		legacy_serial_count = index + 1;
 
 	/* Check if there is a port who already claimed our slot */
-	if (legacy_serial_infos[index].np != 0) {
+	if (legacy_serial_infos[index].np != NULL) {
 		/* if we still have some room, move it, else override */
 		if (legacy_serial_count < MAX_LEGACY_SERIAL_PORTS) {
 			printk(KERN_DEBUG "Moved legacy port %d -> %d\n",
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7d22a67..22fe401 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -306,7 +306,7 @@ static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
 	unsigned long io_offset = 0;
 	int i, res_bit;
 
-	if (hose == 0)
+	if (hose == NULL)
 		return NULL;		/* should never happen */
 
 	/* If memory, add on the PCI bridge address offset */
@@ -1578,7 +1578,7 @@ fake_pci_bus(struct pci_controller *hose, int busnr)
 {
 	static struct pci_bus bus;
 
-	if (hose == 0) {
+	if (hose == NULL) {
 		printk(KERN_ERR "Can't find hose for PCI bus %d!\n", busnr);
 	}
 	bus.number = busnr;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 2e86296..cdf5aa1 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -109,7 +109,7 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 	hose = pci_bus_to_host(bus);
 
 	/* Check if we have IOs allocated */
-	if (hose->io_base_alloc == 0)
+	if (hose->io_base_alloc == NULL)
 		return 0;
 
 	pr_debug("IO unmapping for PHB %s\n", hose->dn->full_name);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 389fb807..b3b5fd3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -322,7 +322,7 @@ static void __init initialize_cache_info(void)
 							 NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
-			if (sizep == 0 || lsizep == 0)
+			if (sizep == NULL || lsizep == NULL)
 				DBG("Argh, can't find dcache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
@@ -344,7 +344,7 @@ static void __init initialize_cache_info(void)
 							 NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
-			if (sizep == 0 || lsizep == 0)
+			if (sizep == NULL || lsizep == NULL)
 				DBG("Argh, can't find icache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 887e99d..cbd2692 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -346,13 +346,13 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
-	if (v_regs != 0 && (msr & MSR_VEC) != 0)
+	if (v_regs != NULL && (msr & MSR_VEC) != 0)
 		err |= __copy_from_user(current->thread.vr, v_regs,
 					33 * sizeof(vector128));
 	else if (current->thread.used_vr)
 		memset(current->thread.vr, 0, 33 * sizeof(vector128));
 	/* Always get VRSAVE back */
-	if (v_regs != 0)
+	if (v_regs != NULL)
 		err |= __get_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
 	else
 		current->thread.vrsave = 0;
@@ -463,7 +463,7 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 				    tm_v_regs, 34 * sizeof(vector128)))
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
-	if (v_regs != 0 && tm_v_regs != 0 && (msr & MSR_VEC) != 0) {
+	if (v_regs != NULL && tm_v_regs != NULL && (msr & MSR_VEC) != 0) {
 		err |= __copy_from_user(current->thread.vr, v_regs,
 					33 * sizeof(vector128));
 		err |= __copy_from_user(current->thread.transact_vr, tm_v_regs,
@@ -474,7 +474,7 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		memset(current->thread.transact_vr, 0, 33 * sizeof(vector128));
 	}
 	/* Always get VRSAVE back */
-	if (v_regs != 0 && tm_v_regs != 0) {
+	if (v_regs != NULL && tm_v_regs != NULL) {
 		err |= __get_user(current->thread.vrsave,
 				  (u32 __user *)&v_regs[33]);
 		err |= __get_user(current->thread.transact_vrsave,
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 38b0ba6..98822400 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -172,7 +172,7 @@ int smp_request_message_ipi(int virq, int msg)
 #endif
 	err = request_irq(virq, smp_ipi_action[msg],
 			  IRQF_PERCPU | IRQF_NO_THREAD | IRQF_NO_SUSPEND,
-			  smp_ipi_name[msg], 0);
+			  smp_ipi_name[msg], NULL);
 	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
 		virq, smp_ipi_name[msg], err);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 6ecc38b..bde8b55 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -907,7 +907,7 @@ static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 
 	if (ea >= spt->maxaddr)
 		return 0;
-	if (ea < 0x100000000) {
+	if (ea < 0x100000000UL) {
 		/* addresses below 4GB use spt->low_prot */
 		sbpm = spt->low_prot;
 	} else {
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index aa74acb..a770df2d 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -105,7 +105,7 @@ static void subpage_prot_clear(unsigned long addr, unsigned long len)
 		limit = spt->maxaddr;
 	for (; addr < limit; addr = next) {
 		next = pmd_addr_end(addr, limit);
-		if (addr < 0x100000000) {
+		if (addr < 0x100000000UL) {
 			spm = spt->low_prot;
 		} else {
 			spm = spt->protptrs[addr >> SBP_L3_SHIFT];
@@ -219,7 +219,7 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 	for (limit = addr + len; addr < limit; addr = next) {
 		next = pmd_addr_end(addr, limit);
 		err = -ENOMEM;
-		if (addr < 0x100000000) {
+		if (addr < 0x100000000UL) {
 			spm = spt->low_prot;
 		} else {
 			spm = spt->protptrs[addr >> SBP_L3_SHIFT];
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index eeae308..29b89e8 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -24,7 +24,7 @@
 #define BHRB_MAX_ENTRIES	32
 #define BHRB_TARGET		0x0000000000000002
 #define BHRB_PREDICTION		0x0000000000000001
-#define BHRB_EA			0xFFFFFFFFFFFFFFFC
+#define BHRB_EA			0xFFFFFFFFFFFFFFFCUL
 
 struct cpu_hw_events {
 	int n_events;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 106301f..7c25346 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -422,7 +422,7 @@ void opal_shutdown(void)
 
 	for (i = 0; i < opal_irq_count; i++) {
 		if (opal_irqs[i])
-			free_irq(opal_irqs[i], 0);
+			free_irq(opal_irqs[i], NULL);
 		opal_irqs[i] = 0;
 	}
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8bad880..60b6f4e 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -724,7 +724,7 @@ int h_get_mpp(struct hvcall_mpp_data *mpp_data)
 
 	mpp_data->mem_weight = (retbuf[3] >> 7 * 8) & 0xff;
 	mpp_data->unallocated_mem_weight = (retbuf[3] >> 6 * 8) & 0xff;
-	mpp_data->unallocated_entitlement = retbuf[3] & 0xffffffffffff;
+	mpp_data->unallocated_entitlement = retbuf[3] & 0xffffffffffffUL;
 
 	mpp_data->pool_size = retbuf[4];
 	mpp_data->loan_request = retbuf[5];
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index a91e6da..9276779 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -108,8 +108,8 @@ err:
  * energy consumption.
  */
 
-#define FLAGS_MODE1	0x004E200000080E01
-#define FLAGS_MODE2	0x004E200000080401
+#define FLAGS_MODE1	0x004E200000080E01UL
+#define FLAGS_MODE2	0x004E200000080401UL
 #define FLAGS_ACTIVATE  0x100
 
 static ssize_t get_best_energy_list(char *page, int activate)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c11c823..b19cd83 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -183,7 +183,7 @@ static void __init pseries_mpic_init_IRQ(void)
 	np = of_find_node_by_path("/");
 	naddr = of_n_addr_cells(np);
 	opprop = of_get_property(np, "platform-open-pic", &opplen);
-	if (opprop != 0) {
+	if (opprop != NULL) {
 		openpic_addr = of_read_number(opprop, naddr);
 		printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 	}
-- 
1.8.1.2
