Return-Path: <jiang.liu@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id CE9271A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 19:42:17 +1000 (AEST)
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Vrabel <david.vrabel@citrix.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Christoph Lameter <cl@linux.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Jiang Liu <jiang.liu@linux.intel.com>,
 Rusty Russell <rusty@rustcorp.com.au>, Jonas Gorski <jogo@openwrt.org>,
 Aleksey Makarov <aleksey.makarov@auriga.com>,
 David Daney <david.daney@cavium.com>, Anton Blanchard <anton@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>,
 bob picco <bpicco@meloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 Kevin Cernekee <cernekee@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [Patch v2 08/14] genirq: Introduce helper function
 irq_data_get_affinity_mask()
Date: Wed, 20 May 2015 17:40:39 +0800
Message-Id: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Cc: linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 linux-ia64@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-acpi@vger.kernel.org, linux-metag@vger.kernel.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Russell King <rmk+kernel@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce helper function irq_data_get_affinity_mask() and
irq_get_affinity_mask() to hide implementation details,
so we could move field 'affinity' from struct irq_data into
struct irq_common_data later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/alpha/kernel/irq.c                   |    2 +-
 arch/arm/kernel/irq.c                     |    4 ++--
 arch/arm64/kernel/irq.c                   |    4 ++--
 arch/blackfin/mach-common/ints-priority.c |    3 ++-
 arch/ia64/kernel/iosapic.c                |    2 +-
 arch/ia64/kernel/irq.c                    |    6 +++---
 arch/ia64/kernel/msi_ia64.c               |    4 ++--
 arch/ia64/sn/kernel/msi_sn.c              |    2 +-
 arch/metag/kernel/irq.c                   |   10 ++++++----
 arch/mips/bcm63xx/irq.c                   |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c      |   14 ++++++++------
 arch/mips/pmcs-msp71xx/msp_irq_cic.c      |    3 ++-
 arch/mn10300/kernel/cevt-mn10300.c        |    2 +-
 arch/mn10300/kernel/irq.c                 |   13 +++++++------
 arch/parisc/kernel/irq.c                  |   12 ++++++------
 arch/powerpc/kernel/irq.c                 |    2 +-
 arch/powerpc/sysdev/xics/ics-opal.c       |    2 +-
 arch/powerpc/sysdev/xics/ics-rtas.c       |    2 +-
 arch/sh/kernel/irq.c                      |    7 ++++---
 arch/sparc/kernel/irq_64.c                |   12 +++++++-----
 arch/sparc/kernel/leon_kernel.c           |    6 +++---
 arch/x86/kernel/apic/io_apic.c            |    2 +-
 arch/x86/kernel/apic/vector.c             |    5 ++---
 arch/x86/kernel/irq.c                     |    5 +++--
 arch/xtensa/kernel/irq.c                  |   10 ++++++----
 drivers/irqchip/irq-mips-gic.c            |    2 +-
 drivers/parisc/iosapic.c                  |    2 +-
 drivers/sh/intc/chip.c                    |    6 +++---
 drivers/xen/events/events_base.c          |    4 ++--
 include/linux/irq.h                       |   12 ++++++++++++
 30 files changed, 93 insertions(+), 69 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index 7b2be251c30f..bd8e47699cad 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -60,7 +60,7 @@ int irq_select_affinity(unsigned int irq)
 		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
 	last_cpu = cpu;
 
-	cpumask_copy(data->affinity, cpumask_of(cpu));
+	cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
 	chip->irq_set_affinity(data, cpumask_of(cpu), false);
 	return 0;
 }
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 350f188c92d2..baf8edebe26f 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -140,7 +140,7 @@ int __init arch_probe_nr_irqs(void)
 static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = d->affinity;
+	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
 	struct irq_chip *c;
 	bool ret = false;
 
@@ -160,7 +160,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
 	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
+		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
 
 	return ret;
 }
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 240b75c0e94f..463fa2e7e34c 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -61,7 +61,7 @@ void __init init_IRQ(void)
 static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = d->affinity;
+	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
 	struct irq_chip *c;
 	bool ret = false;
 
@@ -81,7 +81,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
 	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
+		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
 
 	return ret;
 }
diff --git a/arch/blackfin/mach-common/ints-priority.c b/arch/blackfin/mach-common/ints-priority.c
index 7236bdfc71e6..332a434b4669 100644
--- a/arch/blackfin/mach-common/ints-priority.c
+++ b/arch/blackfin/mach-common/ints-priority.c
@@ -194,7 +194,8 @@ void bfin_internal_unmask_irq(unsigned int irq)
 #ifdef CONFIG_SMP
 static void bfin_internal_unmask_irq_chip(struct irq_data *d)
 {
-	bfin_internal_unmask_irq_affinity(d->irq, d->affinity);
+	bfin_internal_unmask_irq_affinity(d->irq,
+					  irq_data_get_affinity_mask(d));
 }
 
 static int bfin_internal_set_affinity(struct irq_data *d,
diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index bc9501e36e77..4d2698d43c39 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -838,7 +838,7 @@ iosapic_unregister_intr (unsigned int gsi)
 	if (iosapic_intr_info[irq].count == 0) {
 #ifdef CONFIG_SMP
 		/* Clear affinity */
-		cpumask_setall(irq_get_irq_data(irq)->affinity);
+		cpumask_setall(irq_get_affinity_mask(irq));
 #endif
 		/* Clear the interrupt information */
 		iosapic_intr_info[irq].dest = 0;
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index 812a1e6b3179..de4fc00dea98 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -67,7 +67,7 @@ static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
 void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
 {
 	if (irq < NR_IRQS) {
-		cpumask_copy(irq_get_irq_data(irq)->affinity,
+		cpumask_copy(irq_get_affinity_mask(irq),
 			     cpumask_of(cpu_logical_id(hwid)));
 		irq_redir[irq] = (char) (redir & 0xff);
 	}
@@ -119,8 +119,8 @@ static void migrate_irqs(void)
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (cpumask_any_and(data->affinity, cpu_online_mask)
-		    >= nr_cpu_ids) {
+		if (cpumask_any_and(irq_data_get_affinity_mask(data),
+				    cpu_online_mask) >= nr_cpu_ids) {
 			/*
 			 * Save it for phase 2 processing
 			 */
diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index d70bf15c690a..6c50d332b7d7 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -36,7 +36,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
 	msg.data = data;
 
 	pci_write_msi_msg(irq, &msg);
-	cpumask_copy(idata->affinity, cpumask_of(cpu));
+	cpumask_copy(irq_data_get_affinity_mask(idata), cpumask_of(cpu));
 
 	return 0;
 }
@@ -148,7 +148,7 @@ static int dmar_msi_set_affinity(struct irq_data *data,
 	msg.address_lo |= MSI_ADDR_DEST_ID_CPU(cpu_physical_id(cpu));
 
 	dmar_msi_write(irq, &msg);
-	cpumask_copy(data->affinity, mask);
+	cpumask_copy(irq_data_get_affinity_mask(data), mask);
 
 	return 0;
 }
diff --git a/arch/ia64/sn/kernel/msi_sn.c b/arch/ia64/sn/kernel/msi_sn.c
index a0eb27b66d13..42b5a13af142 100644
--- a/arch/ia64/sn/kernel/msi_sn.c
+++ b/arch/ia64/sn/kernel/msi_sn.c
@@ -206,7 +206,7 @@ static int sn_set_msi_irq_affinity(struct irq_data *data,
 	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
 
 	pci_write_msi_msg(irq, &msg);
-	cpumask_copy(data->affinity, cpu_mask);
+	cpumask_copy(irq_data_get_affinity_mask(data), cpu_mask);
 
 	return 0;
 }
diff --git a/arch/metag/kernel/irq.c b/arch/metag/kernel/irq.c
index 4f8f1f87ef11..a336094a7a6c 100644
--- a/arch/metag/kernel/irq.c
+++ b/arch/metag/kernel/irq.c
@@ -270,23 +270,25 @@ void migrate_irqs(void)
 
 	for_each_active_irq(i) {
 		struct irq_data *data = irq_get_irq_data(i);
+		struct cpumask *mask;
 		unsigned int newcpu;
 
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		mask = irq_data_get_affinity_mask(data);
+		if (!cpumask_test_cpu(cpu, mask))
 			continue;
 
-		newcpu = cpumask_any_and(data->affinity, cpu_online_mask);
+		newcpu = cpumask_any_and(mask, cpu_online_mask);
 
 		if (newcpu >= nr_cpu_ids) {
 			pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 					    i, cpu);
 
-			cpumask_setall(data->affinity);
+			cpumask_setall(mask);
 		}
-		irq_set_affinity(i, data->affinity);
+		irq_set_affinity(i, mask);
 	}
 }
 #endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index e3e808a6c542..02983b90826d 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -60,7 +60,7 @@ static inline int enable_irq_for_cpu(int cpu, struct irq_data *d,
 	if (m)
 		enable &= cpumask_test_cpu(cpu, m);
 	else if (irqd_affinity_was_set(d))
-		enable &= cpumask_test_cpu(cpu, d->affinity);
+		enable &= cpumask_test_cpu(cpu, irq_data_get_affinity_mask(d));
 #endif
 	return enable;
 }
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 10f762557b92..0643ae614284 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -225,13 +225,14 @@ static int next_cpu_for_irq(struct irq_data *data)
 
 #ifdef CONFIG_SMP
 	int cpu;
-	int weight = cpumask_weight(data->affinity);
+	struct cpumask *mask = irq_data_get_affinity_mask(data);
+	int weight = cpumask_weight(mask);
 	struct octeon_ciu_chip_data *cd = irq_data_get_irq_chip_data(data);
 
 	if (weight > 1) {
 		cpu = cd->current_cpu;
 		for (;;) {
-			cpu = cpumask_next(cpu, data->affinity);
+			cpu = cpumask_next(cpu, mask);
 			if (cpu >= nr_cpu_ids) {
 				cpu = -1;
 				continue;
@@ -240,7 +241,7 @@ static int next_cpu_for_irq(struct irq_data *data)
 			}
 		}
 	} else if (weight == 1) {
-		cpu = cpumask_first(data->affinity);
+		cpu = cpumask_first(mask);
 	} else {
 		cpu = smp_processor_id();
 	}
@@ -710,16 +711,17 @@ static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
 {
 	int cpu = smp_processor_id();
 	cpumask_t new_affinity;
+	struct cpumask *mask = irq_data_get_affinity_mask(data);
 
-	if (!cpumask_test_cpu(cpu, data->affinity))
+	if (!cpumask_test_cpu(cpu, mask))
 		return;
 
-	if (cpumask_weight(data->affinity) > 1) {
+	if (cpumask_weight(mask) > 1) {
 		/*
 		 * It has multi CPU affinity, just remove this CPU
 		 * from the affinity set.
 		 */
-		cpumask_copy(&new_affinity, data->affinity);
+		cpumask_copy(&new_affinity, mask);
 		cpumask_clear_cpu(cpu, &new_affinity);
 	} else {
 		/* Otherwise, put it on lowest numbered online CPU. */
diff --git a/arch/mips/pmcs-msp71xx/msp_irq_cic.c b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
index 1207ec4dfb77..8b9cf6463040 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq_cic.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
@@ -88,7 +88,8 @@ static void unmask_cic_irq(struct irq_data *d)
 	* Make sure we have IRQ affinity.  It may have changed while
 	* we were processing the IRQ.
 	*/
-	if (!cpumask_test_cpu(smp_processor_id(), d->affinity))
+	if (!cpumask_test_cpu(smp_processor_id(),
+			      irq_data_get_affinity_mask(d)))
 		return;
 #endif
 
diff --git a/arch/mn10300/kernel/cevt-mn10300.c b/arch/mn10300/kernel/cevt-mn10300.c
index 60f64ca1752a..326677d4a3b2 100644
--- a/arch/mn10300/kernel/cevt-mn10300.c
+++ b/arch/mn10300/kernel/cevt-mn10300.c
@@ -123,7 +123,7 @@ int __init init_clockevents(void)
 	{
 		struct irq_data *data;
 		data = irq_get_irq_data(cd->irq);
-		cpumask_copy(data->affinity, cpumask_of(cpu));
+		cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
 		iact->flags |= IRQF_NOBALANCING;
 	}
 #endif
diff --git a/arch/mn10300/kernel/irq.c b/arch/mn10300/kernel/irq.c
index 480de70f4059..c716437baa2c 100644
--- a/arch/mn10300/kernel/irq.c
+++ b/arch/mn10300/kernel/irq.c
@@ -87,7 +87,8 @@ static void mn10300_cpupic_mask_ack(struct irq_data *d)
 		tmp2 = GxICR(irq);
 
 		irq_affinity_online[irq] =
-			cpumask_any_and(d->affinity, cpu_online_mask);
+			cpumask_any_and(irq_data_get_affinity_mask(d),
+					cpu_online_mask);
 		CROSS_GxICR(irq, irq_affinity_online[irq]) =
 			(tmp & (GxICR_LEVEL | GxICR_ENABLE)) | GxICR_DETECT;
 		tmp = CROSS_GxICR(irq, irq_affinity_online[irq]);
@@ -124,7 +125,7 @@ static void mn10300_cpupic_unmask_clear(struct irq_data *d)
 	} else {
 		tmp = GxICR(irq);
 
-		irq_affinity_online[irq] = cpumask_any_and(d->affinity,
+		irq_affinity_online[irq] = cpumask_any_and(irq_data_get_affinity_mask(d),
 							   cpu_online_mask);
 		CROSS_GxICR(irq, irq_affinity_online[irq]) = (tmp & GxICR_LEVEL) | GxICR_ENABLE | GxICR_DETECT;
 		tmp = CROSS_GxICR(irq, irq_affinity_online[irq]);
@@ -316,15 +317,16 @@ void migrate_irqs(void)
 	self = smp_processor_id();
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		struct irq_data *data = irq_get_irq_data(irq);
+		struct cpumask *mask = irq_data_get_affinity_mask(data);
 
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (cpumask_test_cpu(self, data->affinity) &&
+		if (cpumask_test_cpu(self, mask) &&
 		    !cpumask_intersects(&irq_affinity[irq], cpu_online_mask)) {
 			int cpu_id;
 			cpu_id = cpumask_first(cpu_online_mask);
-			cpumask_set_cpu(cpu_id, data->affinity);
+			cpumask_set_cpu(cpu_id, mask);
 		}
 		/* We need to operate irq_affinity_online atomically. */
 		arch_local_cli_save(flags);
@@ -335,8 +337,7 @@ void migrate_irqs(void)
 			GxICR(irq) = x & GxICR_LEVEL;
 			tmp = GxICR(irq);
 
-			new = cpumask_any_and(data->affinity,
-					      cpu_online_mask);
+			new = cpumask_any_and(mask, cpu_online_mask);
 			irq_affinity_online[irq] = new;
 
 			CROSS_GxICR(irq, new) =
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index f3191db6e2e9..413ec3c3f9cc 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -131,7 +131,7 @@ static int cpu_set_affinity_irq(struct irq_data *d, const struct cpumask *dest,
 	if (cpu_dest < 0)
 		return -1;
 
-	cpumask_copy(d->affinity, dest);
+	cpumask_copy(irq_data_get_affinity_mask(d), dest);
 
 	return 0;
 }
@@ -339,7 +339,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
 {
 #ifdef CONFIG_SMP
 	struct irq_data *d = irq_get_irq_data(irq);
-	cpumask_copy(d->affinity, cpumask_of(cpu));
+	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
 #endif
 
 	return per_cpu(cpu_data, cpu).txn_addr;
@@ -508,7 +508,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 	unsigned long eirr_val;
 	int irq, cpu = smp_processor_id();
 #ifdef CONFIG_SMP
-	struct irq_desc *desc;
+	struct irq_data *irq_data;
 	cpumask_t dest;
 #endif
 
@@ -522,9 +522,9 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 	irq = eirr_to_irq(eirr_val);
 
 #ifdef CONFIG_SMP
-	desc = irq_to_desc(irq);
-	cpumask_copy(&dest, desc->irq_data.affinity);
-	if (irqd_is_per_cpu(&desc->irq_data) &&
+	irq_data = irq_get_irq_data(irq);
+	cpumask_copy(&dest, irq_data_get_affinity_mask(irq_data));
+	if (irqd_is_per_cpu(irq_data) &&
 	    !cpumask_test_cpu(smp_processor_id(), &dest)) {
 		int cpu = cpumask_first(&dest);
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 45096033d37b..290559df1e8b 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -441,7 +441,7 @@ void migrate_irqs(void)
 
 		chip = irq_data_get_irq_chip(data);
 
-		cpumask_and(mask, data->affinity, map);
+		cpumask_and(mask, irq_data_get_affinity_mask(data), map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
 			pr_warn("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 68c7e5cc98e0..3996393c254d 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -54,7 +54,7 @@ static void ics_opal_unmask_irq(struct irq_data *d)
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 	server = ics_opal_mangle_server(server);
 
 	rc = opal_set_xive(hw_irq, server, DEFAULT_PRIORITY);
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index 0af97deb83f3..e2665a9dfc0f 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -47,7 +47,7 @@ static void ics_rtas_unmask_irq(struct irq_data *d)
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hw_irq, server,
 				DEFAULT_PRIORITY);
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 8dc677cc136b..6c0378c0b8b5 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -228,15 +228,16 @@ void migrate_irqs(void)
 		struct irq_data *data = irq_get_irq_data(irq);
 
 		if (irq_data_get_node(data) == cpu) {
-			unsigned int newcpu = cpumask_any_and(data->affinity,
+			struct cpumask *mask = irq_data_get_affinity_mask(data);
+			unsigned int newcpu = cpumask_any_and(mask,
 							      cpu_online_mask);
 			if (newcpu >= nr_cpu_ids) {
 				pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 						    irq, cpu);
 
-				cpumask_setall(data->affinity);
+				cpumask_setall(mask);
 			}
-			irq_set_affinity(irq, data->affinity);
+			irq_set_affinity(irq, mask);
 		}
 	}
 }
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 5130f6e3e68e..e22416ce56ea 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -377,7 +377,8 @@ static void sun4u_irq_enable(struct irq_data *data)
 		unsigned long cpuid, imap, val;
 		unsigned int tid;
 
-		cpuid = irq_choose_cpu(data->irq, data->affinity);
+		cpuid = irq_choose_cpu(data->irq,
+				       irq_data_get_affinity_mask(data));
 		imap = handler_data->imap;
 
 		tid = sun4u_compute_tid(imap, cpuid);
@@ -449,7 +450,8 @@ static void sun4u_irq_eoi(struct irq_data *data)
 
 static void sun4v_irq_enable(struct irq_data *data)
 {
-	unsigned long cpuid = irq_choose_cpu(data->irq, data->affinity);
+	unsigned long cpuid = irq_choose_cpu(data->irq,
+					     irq_data_get_affinity_mask(data));
 	unsigned int ino = irq_data_to_sysino(data);
 	int err;
 
@@ -511,7 +513,7 @@ static void sun4v_virq_enable(struct irq_data *data)
 	unsigned long cpuid;
 	int err;
 
-	cpuid = irq_choose_cpu(data->irq, data->affinity);
+	cpuid = irq_choose_cpu(data->irq, irq_data_get_affinity_mask(data));
 
 	err = sun4v_vintr_set_target(dev_handle, dev_ino, cpuid);
 	if (err != HV_EOK)
@@ -884,8 +886,8 @@ void fixup_irqs(void)
 		if (desc->action && !irqd_is_per_cpu(data)) {
 			if (data->chip->irq_set_affinity)
 				data->chip->irq_set_affinity(data,
-							     data->affinity,
-							     false);
+					irq_data_get_affinity_mask(data),
+					false);
 		}
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 9bbb8f2bbfcc..0299f052a2ef 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -126,7 +126,7 @@ static int leon_set_affinity(struct irq_data *data, const struct cpumask *dest,
 	int oldcpu, newcpu;
 
 	mask = (unsigned long)data->chip_data;
-	oldcpu = irq_choose_cpu(data->affinity);
+	oldcpu = irq_choose_cpu(irq_data_get_affinity_mask(data));
 	newcpu = irq_choose_cpu(dest);
 
 	if (oldcpu == newcpu)
@@ -149,7 +149,7 @@ static void leon_unmask_irq(struct irq_data *data)
 	int cpu;
 
 	mask = (unsigned long)data->chip_data;
-	cpu = irq_choose_cpu(data->affinity);
+	cpu = irq_choose_cpu(irq_data_get_affinity_mask(data));
 	spin_lock_irqsave(&leon_irq_lock, flags);
 	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
 	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask | mask));
@@ -162,7 +162,7 @@ static void leon_mask_irq(struct irq_data *data)
 	int cpu;
 
 	mask = (unsigned long)data->chip_data;
-	cpu = irq_choose_cpu(data->affinity);
+	cpu = irq_choose_cpu(irq_data_get_affinity_mask(data));
 	spin_lock_irqsave(&leon_irq_lock, flags);
 	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
 	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask & ~mask));
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 845dc0df2002..09921de4210f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2541,7 +2541,7 @@ void __init setup_ioapic_dest(void)
 		 * Honour affinities which have been set in early boot
 		 */
 		if (!irqd_can_balance(idata) || irqd_affinity_was_set(idata))
-			mask = idata->affinity;
+			mask = irq_data_get_affinity_mask(idata);
 		else
 			mask = apic->target_cpus();
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9b62f690b0ff..dfa3a5f5b3d3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -494,9 +494,8 @@ static int apic_set_affinity(struct irq_data *irq_data,
 
 	err = assign_irq_vector(irq, data, dest);
 	if (err) {
-		struct irq_data *top = irq_get_irq_data(irq);
-
-		if (assign_irq_vector(irq, data, top->affinity))
+		if (assign_irq_vector(irq, data,
+				      irq_data_get_affinity_mask(irq_data)))
 			pr_err("Failed to recover vector for irq %d\n", irq);
 		return err;
 	}
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index be3894512820..e0bca24b300b 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -304,7 +304,8 @@ int check_irq_vectors_for_cpu_disable(void)
 				continue;
 
 			data = irq_desc_get_irq_data(desc);
-			cpumask_copy(&affinity_new, data->affinity);
+			cpumask_copy(&affinity_new,
+				     irq_data_get_affinity_mask(data));
 			cpumask_clear_cpu(this_cpu, &affinity_new);
 
 			/* Do not count inactive or per-cpu irqs. */
@@ -382,7 +383,7 @@ void fixup_irqs(void)
 		raw_spin_lock(&desc->lock);
 
 		data = irq_desc_get_irq_data(desc);
-		affinity = data->affinity;
+		affinity = irq_data_get_affinity_mask(data);
 		if (!irq_has_action(irq) || irqd_is_per_cpu(data) ||
 		    cpumask_subset(affinity, cpu_online_mask)) {
 			raw_spin_unlock(&desc->lock);
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 3eee94f621eb..d7b5a4c8ae5d 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -166,23 +166,25 @@ void migrate_irqs(void)
 
 	for_each_active_irq(i) {
 		struct irq_data *data = irq_get_irq_data(i);
+		struct cpumask *mask;
 		unsigned int newcpu;
 
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		mask = irq_data_get_affinity_mask(data);
+		if (!cpumask_test_cpu(cpu, mask))
 			continue;
 
-		newcpu = cpumask_any_and(data->affinity, cpu_online_mask);
+		newcpu = cpumask_any_and(mask, cpu_online_mask);
 
 		if (newcpu >= nr_cpu_ids) {
 			pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 					    i, cpu);
 
-			cpumask_setall(data->affinity);
+			cpumask_setall(mask);
 		}
-		irq_set_affinity(i, data->affinity);
+		irq_set_affinity(i, mask);
 	}
 }
 #endif /* CONFIG_HOTPLUG_CPU */
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 57f09cb54464..09257c301bd2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -403,7 +403,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		clear_bit(irq, pcpu_masks[i].pcpu_mask);
 	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
 
-	cpumask_copy(d->affinity, cpumask);
+	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK_NOCOPY;
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 9ee04b4b68bf..144c77dfe4b1 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -691,7 +691,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
 	if (dest_cpu < 0)
 		return -1;
 
-	cpumask_copy(d->affinity, cpumask_of(dest_cpu));
+	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
 	vi->txn_addr = txn_affinity_addr(d->irq, dest_cpu);
 
 	spin_lock_irqsave(&iosapic_lock, flags);
diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
index 46427b48e2f1..358df7510186 100644
--- a/drivers/sh/intc/chip.c
+++ b/drivers/sh/intc/chip.c
@@ -22,7 +22,7 @@ void _intc_enable(struct irq_data *data, unsigned long handle)
 
 	for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_E(handle)); cpu++) {
 #ifdef CONFIG_SMP
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		if (!cpumask_test_cpu(cpu, irq_data_get_affinity_mask(data)))
 			continue;
 #endif
 		addr = INTC_REG(d, _INTC_ADDR_E(handle), cpu);
@@ -50,7 +50,7 @@ static void intc_disable(struct irq_data *data)
 
 	for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_D(handle)); cpu++) {
 #ifdef CONFIG_SMP
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		if (!cpumask_test_cpu(cpu, irq_data_get_affinity_mask(data)))
 			continue;
 #endif
 		addr = INTC_REG(d, _INTC_ADDR_D(handle), cpu);
@@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
 	if (!cpumask_intersects(cpumask, cpu_online_mask))
 		return -1;
 
-	cpumask_copy(data->affinity, cpumask);
+	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
 
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 2b8553bd8715..d00e0be8e9ea 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -336,7 +336,7 @@ static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
 
 	BUG_ON(irq == -1);
 #ifdef CONFIG_SMP
-	cpumask_copy(irq_get_irq_data(irq)->affinity, cpumask_of(cpu));
+	cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
 #endif
 	xen_evtchn_port_bind_to_cpu(info, cpu);
 
@@ -373,7 +373,7 @@ static void xen_irq_init(unsigned irq)
 	struct irq_info *info;
 #ifdef CONFIG_SMP
 	/* By default all event channels notify CPU#0. */
-	cpumask_copy(irq_get_irq_data(irq)->affinity, cpumask_of(0));
+	cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(0));
 #endif
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 43581e166298..2eb82257aaee 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -650,6 +650,18 @@ static inline int irq_data_get_node(struct irq_data *d)
 	return irq_common_data_get_node(d->common);
 }
 
+static inline struct cpumask *irq_get_affinity_mask(int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	return d ? d->affinity : NULL;
+}
+
+static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
+{
+	return d->affinity;
+}
+
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-- 
1.7.10.4
