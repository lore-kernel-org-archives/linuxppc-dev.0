Return-Path: <glikely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87813B7028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 06:13:24 +1000 (EST)
Received: by pbcwy12 with SMTP id wy12so9803501pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 13:13:22 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] irqdomain/powerpc: Fix broken NR_IRQ references
Date: Mon, 16 Apr 2012 14:13:18 -0600
Message-Id: <1334607198-18694-2-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The switch from using irq_map to irq_alloc_desc*() for managing irq
number allocations introduced new bugs in some of the powerpc
interrupt code.  Several functions rely on the value of NR_IRQS to
determine the maximum irq number that could get allocated.  However,
with sparse_irq and using irq_alloc_desc*() the maximum possible irq
number is now specified with 'nr_irqs' which may be a number larger
than NR_IRQS.  This has caused breakage on powermac when
CONFIG_NR_IRQS is set to 32.

This patch removes most of the direct references to NR_IRQS in the
powerpc code and replaces them with either a nr_irqs reference or by
using the common for_each_irq_desc() macro.  The powerpc-specific
for_each_irq() macro is removed at the same time.

Also, the Cell axon_msi driver is refactored to remove the global
build assumption on the size of NR_IRQS and instead add a limit to the
maximum irq number when calling irq_domain_add_nomap().

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/irq.h               |    4 ----
 arch/powerpc/kernel/irq.c                    |    6 +-----
 arch/powerpc/kernel/machine_kexec.c          |    7 ++-----
 arch/powerpc/platforms/cell/axon_msi.c       |    7 ++-----
 arch/powerpc/platforms/cell/beat_interrupt.c |    2 +-
 arch/powerpc/platforms/powermac/pic.c        |    6 +++---
 arch/powerpc/sysdev/cpm2_pic.c               |    3 +--
 arch/powerpc/sysdev/xics/xics-common.c       |    7 +++----
 8 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index e648af9..0e40843 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -18,10 +18,6 @@
 #include <linux/atomic.h>
 
 
-/* Define a way to iterate across irqs. */
-#define for_each_irq(i) \
-	for ((i) = 0; (i) < NR_IRQS; ++(i))
-
 extern atomic_t ppc_n_lost_interrupts;
 
 /* This number is used when no interrupt has been assigned */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5ec1b23..43eb74f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -330,14 +330,10 @@ void migrate_irqs(void)
 
 	alloc_cpumask_var(&mask, GFP_KERNEL);
 
-	for_each_irq(irq) {
+	for_each_irq_desc(irq, desc) {
 		struct irq_data *data;
 		struct irq_chip *chip;
 
-		desc = irq_to_desc(irq);
-		if (!desc)
-			continue;
-
 		data = irq_desc_get_irq_data(desc);
 		if (irqd_is_per_cpu(data))
 			continue;
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index c957b12..5df7777 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -23,14 +23,11 @@
 
 void machine_kexec_mask_interrupts(void) {
 	unsigned int i;
+	struct irq_desc *desc;
 
-	for_each_irq(i) {
-		struct irq_desc *desc = irq_to_desc(i);
+	for_each_irq_desc(i, desc) {
 		struct irq_chip *chip;
 
-		if (!desc)
-			continue;
-
 		chip = irq_desc_get_chip(desc);
 		if (!chip)
 			continue;
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index d09f3e8..fc9df1a 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -114,7 +114,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
 
-		if (msi < NR_IRQS && irq_get_chip_data(msi) == msic) {
+		if (msi < nr_irqs && irq_get_chip_data(msi) == msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
 		} else {
@@ -276,9 +276,6 @@ static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (rc)
 		return rc;
 
-	/* We rely on being able to stash a virq in a u16 */
-	BUILD_BUG_ON(NR_IRQS > 65536);
-
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
 		if (virq == NO_IRQ) {
@@ -392,7 +389,7 @@ static int axon_msi_probe(struct platform_device *device)
 	}
 	memset(msic->fifo_virt, 0xff, MSIC_FIFO_SIZE_BYTES);
 
-	msic->irq_domain = irq_domain_add_nomap(dn, 0, &msic_host_ops, msic);
+	msic->irq_domain = irq_domain_add_nomap(dn, 65536, &msic_host_ops, msic);
 	if (!msic->irq_domain) {
 		printk(KERN_ERR "axon_msi: couldn't allocate irq_domain for %s\n",
 		       dn->full_name);
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index f9a48af..8c6dc42 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -248,6 +248,6 @@ void beatic_deinit_IRQ(void)
 {
 	int	i;
 
-	for (i = 1; i < NR_IRQS; i++)
+	for (i = 1; i < nr_irqs; i++)
 		beat_destruct_irq_plug(i);
 }
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 66ad93d..c4e6305 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -57,9 +57,9 @@ static int max_real_irqs;
 
 static DEFINE_RAW_SPINLOCK(pmac_pic_lock);
 
-#define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
-static unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
-static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+/* The max irq number this driver deals with is 128; see max_irqs */
+static DECLARE_BITMAP(ppc_lost_interrupts, 128);
+static DECLARE_BITMAP(ppc_cached_irq_mask, 128);
 static int pmac_irq_cascade = -1;
 static struct irq_domain *pmac_pic_host;
 
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index d3be961..10386b6 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -51,8 +51,7 @@
 static intctl_cpm2_t __iomem *cpm2_intctl;
 
 static struct irq_domain *cpm2_pic_host;
-#define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
-static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+static unsigned long ppc_cached_irq_mask[2]; /* 2 32-bit registers */
 
 static const u_char irq_to_siureg[] = {
 	1, 1, 1, 1, 1, 1, 1, 1,
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 1d7067d..9049d9f 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -188,6 +188,7 @@ void xics_migrate_irqs_away(void)
 {
 	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
 	unsigned int irq, virq;
+	struct irq_desc *desc;
 
 	/* If we used to be the default server, move to the new "boot_cpuid" */
 	if (hw_cpu == xics_default_server)
@@ -202,8 +203,7 @@ void xics_migrate_irqs_away(void)
 	/* Allow IPIs again... */
 	icp_ops->set_priority(DEFAULT_PRIORITY);
 
-	for_each_irq(virq) {
-		struct irq_desc *desc;
+	for_each_irq_desc(virq, desc) {
 		struct irq_chip *chip;
 		long server;
 		unsigned long flags;
@@ -212,9 +212,8 @@ void xics_migrate_irqs_away(void)
 		/* We can't set affinity on ISA interrupts */
 		if (virq < NUM_ISA_INTERRUPTS)
 			continue;
-		desc = irq_to_desc(virq);
 		/* We only need to migrate enabled IRQS */
-		if (!desc || !desc->action)
+		if (!desc->action)
 			continue;
 		if (desc->irq_data.domain != xics_host)
 			continue;
-- 
1.7.9.5
