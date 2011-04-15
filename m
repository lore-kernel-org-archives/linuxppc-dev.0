Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <02b9880aa9ef5d49b473c894bce886f2060f9f0b.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 14/15] powerpc: Add WSP platform
Date: Fri, 15 Apr 2011 18:32:06 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <david@gibson.dropbear.id.au>

Add a platform for the Wire Speed Processor, based on the PPC A2.

This includes code for the ICS & OPB interrupt controllers, as well
as a SCOM backend, and SCOM based cpu bringup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Jack Miller <jack@codezen.org>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/wsp.h        |   14 +
 arch/powerpc/kernel/exceptions-64e.S  |   23 +
 arch/powerpc/platforms/Kconfig        |    1 +
 arch/powerpc/platforms/Makefile       |    1 +
 arch/powerpc/platforms/wsp/Kconfig    |   28 ++
 arch/powerpc/platforms/wsp/Makefile   |    6 +
 arch/powerpc/platforms/wsp/ics.c      |  716 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/wsp/ics.h      |   20 +
 arch/powerpc/platforms/wsp/opb_pic.c  |  332 +++++++++++++++
 arch/powerpc/platforms/wsp/psr2.c     |   95 +++++
 arch/powerpc/platforms/wsp/scom_smp.c |  427 ++++++++++++++++++++
 arch/powerpc/platforms/wsp/scom_wsp.c |   77 ++++
 arch/powerpc/platforms/wsp/setup.c    |   36 ++
 arch/powerpc/platforms/wsp/smp.c      |   87 ++++
 arch/powerpc/platforms/wsp/wsp.h      |   17 +
 arch/powerpc/sysdev/xics/icp-native.c |    1 +
 16 files changed, 1881 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/wsp.h b/arch/powerpc/include/asm/wsp.h
new file mode 100644
index 0000000..c7dc830
--- /dev/null
+++ b/arch/powerpc/include/asm/wsp.h
@@ -0,0 +1,14 @@
+/*
+ *  Copyright 2011 Michael Ellerman, IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_POWERPC_WSP_H
+#define __ASM_POWERPC_WSP_H
+
+extern int wsp_get_chip_id(struct device_node *dn);
+
+#endif /* __ASM_POWERPC_WSP_H */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index ab5c4dd..8e5d2c1 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -864,6 +864,20 @@ have_hes:
 	 * that will have to be made dependent on whether we are running under
 	 * a hypervisor I suppose.
 	 */
+
+	/* BEWARE, MAGIC
+	 * This code is called as an ordinary function on the boot CPU. But to
+	 * avoid duplication, this code is also used in SCOM bringup of
+	 * secondary CPUs. We read the code between the initial_tlb_code_start
+	 * and initial_tlb_code_end labels one instruction at a time and RAM it
+	 * into the new core via SCOM. That doesn't process branches, so there
+	 * must be none between those two labels. It also means if this code
+	 * ever takes any parameters, the SCOM code must also be updated to
+	 * provide them.
+	 */
+	.globl a2_tlbinit_code_start
+a2_tlbinit_code_start:
+
 	ori	r11,r3,MAS0_WQ_ALLWAYS
 	oris	r11,r11,MAS0_ESEL(3)@h /* Use way 3: workaround A2 erratum 376 */
 	mtspr	SPRN_MAS0,r11
@@ -880,6 +894,9 @@ have_hes:
 	/* Write the TLB entry */
 	tlbwe
 
+	.globl a2_tlbinit_after_linear_map
+a2_tlbinit_after_linear_map:
+
 	/* Now we branch the new virtual address mapped by this entry */
 	LOAD_REG_IMMEDIATE(r3,1f)
 	mtctr	r3
@@ -931,10 +948,16 @@ have_hes:
 	cmpw	r3,r9
 	blt	2b
 
+	.globl  a2_tlbinit_after_iprot_flush
+a2_tlbinit_after_iprot_flush:
+
 	PPC_TLBILX(0,0,0)
 	sync
 	isync
 
+	.globl a2_tlbinit_code_end
+a2_tlbinit_code_end:
+
 	/* We translate LR and return */
 	mflr	r3
 	tovirt(r3,r3)
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 114d748..2359454 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -20,6 +20,7 @@ source "arch/powerpc/platforms/embedded6xx/Kconfig"
 source "arch/powerpc/platforms/44x/Kconfig"
 source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
+source "arch/powerpc/platforms/wsp/Kconfig"
 
 config KVM_GUEST
 	bool "KVM Guest support"
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index fdb9f0b..73e2116 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
 obj-$(CONFIG_AMIGAONE)		+= amigaone/
+obj-$(CONFIG_PPC_WSP)		+= wsp/
diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
new file mode 100644
index 0000000..c3c48eb
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -0,0 +1,28 @@
+config PPC_WSP
+	bool
+	default n
+
+menu "WSP platform selection"
+	depends on PPC_BOOK3E_64
+
+config PPC_PSR2
+	bool "PSR-2 platform"
+	select PPC_A2
+	select GENERIC_TBSYNC
+	select PPC_SCOM
+	select EPAPR_BOOT
+	select PPC_WSP
+	select PPC_XICS
+	select PPC_ICP_NATIVE
+	default y
+
+endmenu
+
+config PPC_A2_DD2
+	bool "Support for DD2 based A2/WSP systems"
+	depends on PPC_A2
+
+config WORKAROUND_ERRATUM_463
+	depends on PPC_A2_DD2
+	bool "Workaround erratum 463"
+	default y
diff --git a/arch/powerpc/platforms/wsp/Makefile b/arch/powerpc/platforms/wsp/Makefile
new file mode 100644
index 0000000..095be73
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/Makefile
@@ -0,0 +1,6 @@
+ccflags-y			+= -mno-minimal-toc
+
+obj-y				+= setup.o ics.o
+obj-$(CONFIG_PPC_PSR2)		+= psr2.o opb_pic.o
+obj-$(CONFIG_PPC_WSP)		+= scom_wsp.o
+obj-$(CONFIG_SMP)		+= smp.o scom_smp.o
diff --git a/arch/powerpc/platforms/wsp/ics.c b/arch/powerpc/platforms/wsp/ics.c
new file mode 100644
index 0000000..9d40798
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/ics.c
@@ -0,0 +1,716 @@
+/*
+ * Copyright 2008-2011 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/xics.h>
+
+#include "wsp.h"
+#include "ics.h"
+
+
+/* WSP ICS */
+
+struct wsp_ics {
+	struct ics ics;
+	struct device_node *dn;
+	void __iomem *regs;
+	spinlock_t lock;
+	unsigned long *bitmap;
+	u32 chip_id;
+	u32 lsi_base;
+	u32 lsi_count;
+	u64 hwirq_start;
+	u64 count;
+#ifdef CONFIG_SMP
+	int *hwirq_cpu_map;
+#endif
+};
+
+#define to_wsp_ics(ics)	container_of(ics, struct wsp_ics, ics)
+
+#define INT_SRC_LAYER_BUID_REG(base)	((base) + 0x00)
+#define IODA_TBL_ADDR_REG(base)		((base) + 0x18)
+#define IODA_TBL_DATA_REG(base)		((base) + 0x20)
+#define XIVE_UPDATE_REG(base)		((base) + 0x28)
+#define ICS_INT_CAPS_REG(base)		((base) + 0x30)
+
+#define TBL_AUTO_INCREMENT	((1UL << 63) | (1UL << 15))
+#define TBL_SELECT_XIST		(1UL << 48)
+#define TBL_SELECT_XIVT		(1UL << 49)
+
+#define IODA_IRQ(irq)		((irq) & (0x7FFULL))	/* HRM 5.1.3.4 */
+
+#define XIST_REQUIRED		0x8
+#define XIST_REJECTED		0x4
+#define XIST_PRESENTED		0x2
+#define XIST_PENDING		0x1
+
+#define XIVE_SERVER_SHIFT	42
+#define XIVE_SERVER_MASK	0xFFFFULL
+#define XIVE_PRIORITY_MASK	0xFFULL
+#define XIVE_PRIORITY_SHIFT	32
+#define XIVE_WRITE_ENABLE	(1ULL << 63)
+
+/*
+ * The docs refer to a 6 bit field called ChipID, which consists of a
+ * 3 bit NodeID and a 3 bit ChipID. On WSP the ChipID is always zero
+ * so we ignore it, and every where we use "chip id" in this code we
+ * mean the NodeID.
+ */
+#define WSP_ICS_CHIP_SHIFT		17
+
+
+static struct wsp_ics *ics_list;
+static int num_ics;
+
+/* ICS Source controller accessors */
+
+static u64 wsp_ics_get_xive(struct wsp_ics *ics, unsigned int irq)
+{
+	unsigned long flags;
+	u64 xive;
+
+	spin_lock_irqsave(&ics->lock, flags);
+	out_be64(IODA_TBL_ADDR_REG(ics->regs), TBL_SELECT_XIVT | IODA_IRQ(irq));
+	xive = in_be64(IODA_TBL_DATA_REG(ics->regs));
+	spin_unlock_irqrestore(&ics->lock, flags);
+
+	return xive;
+}
+
+static void wsp_ics_set_xive(struct wsp_ics *ics, unsigned int irq, u64 xive)
+{
+	xive &= ~XIVE_ADDR_MASK;
+	xive |= (irq & XIVE_ADDR_MASK);
+	xive |= XIVE_WRITE_ENABLE;
+
+	out_be64(XIVE_UPDATE_REG(ics->regs), xive);
+}
+
+static u64 xive_set_server(u64 xive, unsigned int server)
+{
+	u64 mask = ~(XIVE_SERVER_MASK << XIVE_SERVER_SHIFT);
+
+	xive &= mask;
+	xive |= (server & XIVE_SERVER_MASK) << XIVE_SERVER_SHIFT;
+
+	return xive;
+}
+
+static u64 xive_set_priority(u64 xive, unsigned int priority)
+{
+	u64 mask = ~(XIVE_PRIORITY_MASK << XIVE_PRIORITY_SHIFT);
+
+	xive &= mask;
+	xive |= (priority & XIVE_PRIORITY_MASK) << XIVE_PRIORITY_SHIFT;
+
+	return xive;
+}
+
+
+#ifdef CONFIG_SMP
+/* Find logical CPUs within mask on a given chip and store result in ret */
+void cpus_on_chip(int chip_id, cpumask_t *mask, cpumask_t *ret)
+{
+	int cpu, chip;
+	struct device_node *cpu_dn, *dn;
+	const u32 *prop;
+
+	cpumask_clear(ret);
+	for_each_cpu(cpu, mask) {
+		cpu_dn = of_get_cpu_node(cpu, NULL);
+		if (!cpu_dn)
+			continue;
+
+		prop = of_get_property(cpu_dn, "at-node", NULL);
+		if (!prop) {
+			of_node_put(cpu_dn);
+			continue;
+		}
+
+		dn = of_find_node_by_phandle(*prop);
+		of_node_put(cpu_dn);
+
+		chip = wsp_get_chip_id(dn);
+		if (chip == chip_id)
+			cpumask_set_cpu(cpu, ret);
+
+		of_node_put(dn);
+	}
+}
+
+/* Store a suitable CPU to handle a hwirq in the ics->hwirq_cpu_map cache */
+static int cache_hwirq_map(struct wsp_ics *ics, unsigned int hwirq,
+			   const cpumask_t *affinity)
+{
+	cpumask_var_t avail, newmask;
+	int ret = -ENOMEM, cpu, cpu_rover = 0, target;
+	int index = hwirq - ics->hwirq_start;
+	unsigned int nodeid;
+
+	BUG_ON(index < 0 || index >= ics->count);
+
+	if (!ics->hwirq_cpu_map)
+		return -ENOMEM;
+
+	if (!distribute_irqs) {
+		ics->hwirq_cpu_map[hwirq - ics->hwirq_start] = xics_default_server;
+		return 0;
+	}
+
+	/* Allocate needed CPU masks */
+	if (!alloc_cpumask_var(&avail, GFP_KERNEL))
+		goto ret;
+	if (!alloc_cpumask_var(&newmask, GFP_KERNEL))
+		goto freeavail;
+
+	/* Find PBus attached to the source of this IRQ */
+	nodeid = (hwirq >> WSP_ICS_CHIP_SHIFT) & 0x3; /* 12:14 */
+
+	/* Find CPUs that could handle this IRQ */
+	if (affinity)
+		cpumask_and(avail, cpu_online_mask, affinity);
+	else
+		cpumask_copy(avail, cpu_online_mask);
+
+	/* Narrow selection down to logical CPUs on the same chip */
+	cpus_on_chip(nodeid, avail, newmask);
+
+	/* Ensure we haven't narrowed it down to 0 */
+	if (unlikely(cpumask_empty(newmask))) {
+		if (unlikely(cpumask_empty(avail))) {
+			ret = -1;
+			goto out;
+		}
+		cpumask_copy(newmask, avail);
+	}
+
+	/* Choose a CPU out of those we narrowed it down to in round robin */
+	target = hwirq % cpumask_weight(newmask);
+	for_each_cpu(cpu, newmask) {
+		if (cpu_rover++ >= target) {
+			ics->hwirq_cpu_map[index] = get_hard_smp_processor_id(cpu);
+			ret = 0;
+			goto out;
+		}
+	}
+
+	/* Shouldn't happen */
+	WARN_ON(1);
+
+out:
+	free_cpumask_var(newmask);
+freeavail:
+	free_cpumask_var(avail);
+ret:
+	if (ret < 0) {
+		ics->hwirq_cpu_map[index] = cpumask_first(cpu_online_mask);
+		pr_warning("Error, falling hwirq 0x%x routing back to CPU %i\n",
+			   hwirq, ics->hwirq_cpu_map[index]);
+	}
+	return ret;
+}
+
+static void alloc_irq_map(struct wsp_ics *ics)
+{
+	int i;
+
+	ics->hwirq_cpu_map = kmalloc(sizeof(int) * ics->count, GFP_KERNEL);
+	if (!ics->hwirq_cpu_map) {
+		pr_warning("Allocate hwirq_cpu_map failed, "
+			   "IRQ balancing disabled\n");
+		return;
+	}
+
+	for (i=0; i < ics->count; i++)
+		ics->hwirq_cpu_map[i] = xics_default_server;
+}
+
+static int get_irq_server(struct wsp_ics *ics, unsigned int hwirq)
+{
+	int index = hwirq - ics->hwirq_start;
+
+	BUG_ON(index < 0 || index >= ics->count);
+
+	if (!ics->hwirq_cpu_map)
+		return xics_default_server;
+
+	return ics->hwirq_cpu_map[index];
+}
+#else /* !CONFIG_SMP */
+static int cache_hwirq_map(struct wsp_ics *ics, unsigned int hwirq,
+			   const cpumask_t *affinity)
+{
+	return 0;
+}
+
+static int get_irq_server(struct wsp_ics *ics, unsigned int hwirq)
+{
+	return xics_default_server;
+}
+
+static void alloc_irq_map(struct wsp_ics *ics) { }
+#endif
+
+static void wsp_chip_unmask_irq(struct irq_data *d)
+{
+	struct wsp_ics *ics;
+	unsigned int irq;
+	int server;
+	u64 xive;
+
+	irq = (unsigned int)irq_map[d->irq].hwirq;
+	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		return;
+
+	ics = d->chip_data;
+	if (WARN_ON(!ics))
+		return;
+
+	server = get_irq_server(ics, irq);
+
+	xive = wsp_ics_get_xive(ics, irq);
+	xive = xive_set_server(xive, server);
+	xive = xive_set_priority(xive, DEFAULT_PRIORITY);
+	wsp_ics_set_xive(ics, irq, xive);
+}
+
+static unsigned int wsp_chip_startup(struct irq_data *d)
+{
+	/* unmask it */
+	wsp_chip_unmask_irq(d);
+	return 0;
+}
+
+static void wsp_mask_real_irq(unsigned int irq, struct wsp_ics *ics)
+{
+	u64 xive;
+
+	if (irq == XICS_IPI)
+		return;
+
+	if (WARN_ON(!ics))
+		return;
+	xive = wsp_ics_get_xive(ics, irq);
+	xive = xive_set_server(xive, xics_default_server);
+	xive = xive_set_priority(xive, LOWEST_PRIORITY);
+	wsp_ics_set_xive(ics, irq, xive);
+}
+
+static void wsp_chip_mask_irq(struct irq_data *d)
+{
+	struct wsp_ics *ics = d->chip_data;
+	unsigned int irq;
+
+	irq = (unsigned int)irq_map[d->irq].hwirq;
+	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		return;
+
+	wsp_mask_real_irq(irq, ics);
+}
+
+static int wsp_chip_set_affinity(struct irq_data *d,
+				 const struct cpumask *cpumask, bool force)
+{
+	struct wsp_ics *ics;
+	unsigned int irq;
+	int ret;
+	u64 xive;
+
+	irq = (unsigned int)irq_map[d->irq].hwirq;
+	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		return -1;
+
+	ics = d->chip_data;
+	if (WARN_ON(!ics))
+		return -1;
+	xive = wsp_ics_get_xive(ics, irq);
+
+	/*
+	 * For the moment only implement delivery to all cpus or one cpu.
+	 * Get current irq_server for the given irq
+	 */
+	ret = cache_hwirq_map(ics, d->irq, cpumask);
+	if (ret == -1) {
+		char cpulist[128];
+		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
+		pr_warning("%s: No online cpus in the mask %s for irq %d\n",
+			   __func__, cpulist, d->irq);
+		return -1;
+	} else if (ret == -ENOMEM) {
+		pr_warning("%s: Out of memory\n", __func__);
+		return -1;
+	}
+
+	xive = xive_set_server(xive, get_irq_server(ics, irq));
+	wsp_ics_set_xive(ics, irq, xive);
+
+	return 0;
+}
+
+static struct irq_chip wsp_irq_chip = {
+	.name = "WSP ICS",
+	.irq_startup		= wsp_chip_startup,
+	.irq_mask		= wsp_chip_mask_irq,
+	.irq_unmask		= wsp_chip_unmask_irq,
+	.irq_set_affinity	= wsp_chip_set_affinity
+};
+
+static int wsp_ics_host_match(struct ics *ics, struct device_node *dn)
+{
+	/* All ICSs in the system implement a global irq number space,
+	 * so match against them all. */
+	return of_device_is_compatible(dn, "ibm,ppc-xics");
+}
+
+static int wsp_ics_match_hwirq(struct wsp_ics *wsp_ics, unsigned int hwirq)
+{
+	if (hwirq >= wsp_ics->hwirq_start &&
+	    hwirq <  wsp_ics->hwirq_start + wsp_ics->count)
+		return 1;
+
+	return 0;
+}
+
+static int wsp_ics_map(struct ics *ics, unsigned int virq)
+{
+	struct wsp_ics *wsp_ics = to_wsp_ics(ics);
+	unsigned long flags;
+	unsigned int hw_irq;
+
+	hw_irq = (unsigned int)irq_map[virq].hwirq;
+	if (!wsp_ics_match_hwirq(wsp_ics, hw_irq))
+		return -ENOENT;
+
+	irq_set_chip_and_handler(virq, &wsp_irq_chip, handle_fasteoi_irq);
+
+	irq_set_chip_data(virq, wsp_ics);
+
+	spin_lock_irqsave(&wsp_ics->lock, flags);
+	bitmap_allocate_region(wsp_ics->bitmap, hw_irq - wsp_ics->hwirq_start, 0);
+	spin_unlock_irqrestore(&wsp_ics->lock, flags);
+
+	return 0;
+}
+
+static void wsp_ics_mask_unknown(struct ics *ics, unsigned long hw_irq)
+{
+	struct wsp_ics *wsp_ics = to_wsp_ics(ics);
+
+	if (!wsp_ics_match_hwirq(wsp_ics, hw_irq))
+		return;
+
+	pr_err("%s: IRQ %lu (real) is invalid, disabling it.\n", __func__, hw_irq);
+	wsp_mask_real_irq(hw_irq, wsp_ics);
+}
+
+static long wsp_ics_get_server(struct ics *ics, unsigned long hw_irq)
+{
+	struct wsp_ics *wsp_ics = to_wsp_ics(ics);
+
+	if (!wsp_ics_match_hwirq(wsp_ics, hw_irq))
+		return -ENOENT;
+
+	return get_irq_server(wsp_ics, hw_irq);
+}
+
+/* HW Number allocation API */
+
+static struct wsp_ics *wsp_ics_find_dn_ics(struct device_node *dn)
+{
+	struct device_node *iparent;
+	int i;
+
+	iparent = of_irq_find_parent(dn);
+	if (!iparent) {
+		pr_err("wsp_ics: Failed to find interrupt parent!\n");
+		return NULL;
+	}
+
+	for(i = 0; i < num_ics; i++) {
+		if(ics_list[i].dn == iparent)
+			break;
+	}
+
+	if (i >= num_ics) {
+		pr_err("wsp_ics: Unable to find parent bitmap!\n");
+		return NULL;
+	}
+
+	return &ics_list[i];
+}
+
+int wsp_ics_alloc_irq(struct device_node *dn, int num)
+{
+	struct wsp_ics *ics;
+	int order, offset;
+
+	ics = wsp_ics_find_dn_ics(dn);
+	if (!ics)
+		return -ENODEV;
+
+	/* Fast, but overly strict if num isn't a power of two */
+	order = get_count_order(num);
+
+	spin_lock_irq(&ics->lock);
+	offset = bitmap_find_free_region(ics->bitmap, ics->count, order);
+	spin_unlock_irq(&ics->lock);
+
+	if (offset < 0)
+		return offset;
+
+	return offset + ics->hwirq_start;
+}
+
+void wsp_ics_free_irq(struct device_node *dn, unsigned int irq)
+{
+	struct wsp_ics *ics;
+
+	ics = wsp_ics_find_dn_ics(dn);
+	if (WARN_ON(!ics))
+		return;
+
+	spin_lock_irq(&ics->lock);
+	bitmap_release_region(ics->bitmap, irq, 0);
+	spin_unlock_irq(&ics->lock);
+}
+
+/* Initialisation */
+
+static int __init wsp_ics_bitmap_setup(struct wsp_ics *ics,
+				      struct device_node *dn)
+{
+	int len, i, j, size;
+	u32 start, count;
+	const u32 *p;
+
+	size = BITS_TO_LONGS(ics->count) * sizeof(long);
+	ics->bitmap = kzalloc(size, GFP_KERNEL);
+	if (!ics->bitmap) {
+		pr_err("wsp_ics: ENOMEM allocating IRQ bitmap!\n");
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&ics->lock);
+
+	p = of_get_property(dn, "available-ranges", &len);
+	if (!p || !len) {
+		/* FIXME this should be a WARN() once mambo is updated */
+		pr_err("wsp_ics: No available-ranges defined for %s\n",
+			dn->full_name);
+		return 0;
+	}
+
+	if (len % (2 * sizeof(u32)) != 0) {
+		/* FIXME this should be a WARN() once mambo is updated */
+		pr_err("wsp_ics: Invalid available-ranges for %s\n",
+			dn->full_name);
+		return 0;
+	}
+
+	bitmap_fill(ics->bitmap, ics->count);
+
+	for (i = 0; i < len / sizeof(u32); i += 2) {
+		start = of_read_number(p + i, 1);
+		count = of_read_number(p + i + 1, 1);
+
+		pr_devel("%s: start: %d count: %d\n", __func__, start, count);
+
+		if ((start + count) > (ics->hwirq_start + ics->count) ||
+		     start < ics->hwirq_start) {
+			pr_err("wsp_ics: Invalid range! -> %d to %d\n",
+					start, start + count);
+			break;
+		}
+
+		for (j = 0; j < count; j++)
+			bitmap_release_region(ics->bitmap,
+				(start + j) - ics->hwirq_start, 0);
+	}
+
+	/* Ensure LSIs are not available for allocation */
+	bitmap_allocate_region(ics->bitmap, ics->lsi_base,
+			       get_count_order(ics->lsi_count));
+
+	return 0;
+}
+
+static int __init wsp_ics_setup(struct wsp_ics *ics, struct device_node *dn)
+{
+	u32 lsi_buid, msi_buid, msi_base, msi_count;
+	void __iomem *regs;
+	const u32 *p;
+	int rc, len, i;
+	u64 caps, buid;
+
+	p = of_get_property(dn, "interrupt-ranges", &len);
+	if (!p || len < (2 * sizeof(u32))) {
+		pr_err("wsp_ics: No/bad interrupt-ranges found on %s\n",
+			dn->full_name);
+		return -ENOENT;
+	}
+
+	if (len > (2 * sizeof(u32))) {
+		pr_err("wsp_ics: Multiple ics ranges not supported.\n");
+		return -EINVAL;
+	}
+
+	regs = of_iomap(dn, 0);
+	if (!regs) {
+		pr_err("wsp_ics: of_iomap(%s) failed\n", dn->full_name);
+		return -ENXIO;
+	}
+
+	ics->hwirq_start = of_read_number(p, 1);
+	ics->count = of_read_number(p + 1, 1);
+	ics->regs = regs;
+
+	ics->chip_id = wsp_get_chip_id(dn);
+	if (WARN_ON(ics->chip_id < 0))
+		ics->chip_id = 0;
+
+	/* Get some informations about the critter */
+	caps = in_be64(ICS_INT_CAPS_REG(ics->regs));
+	buid = in_be64(INT_SRC_LAYER_BUID_REG(ics->regs));
+	ics->lsi_count = caps >> 56;
+	msi_count = (caps >> 44) & 0x7ff;
+
+	/* Note: LSI BUID is 9 bits, but really only 3 are BUID and the
+	 * rest is mixed in the interrupt number. We store the whole
+	 * thing though
+	 */
+	lsi_buid = (buid >> 48) & 0x1ff;
+	ics->lsi_base = (ics->chip_id << WSP_ICS_CHIP_SHIFT) | lsi_buid << 5;
+	msi_buid = (buid >> 37) & 0x7;
+	msi_base = (ics->chip_id << WSP_ICS_CHIP_SHIFT) | msi_buid << 11;
+
+	pr_info("wsp_ics: Found %s\n", dn->full_name);
+	pr_info("wsp_ics:    irq range : 0x%06llx..0x%06llx\n",
+		ics->hwirq_start, ics->hwirq_start + ics->count - 1);
+	pr_info("wsp_ics:    %4d LSIs : 0x%06x..0x%06x\n",
+		ics->lsi_count, ics->lsi_base,
+		ics->lsi_base + ics->lsi_count - 1);
+	pr_info("wsp_ics:    %4d MSIs : 0x%06x..0x%06x\n",
+		msi_count, msi_base,
+		msi_base + msi_count - 1);
+
+	/* Let's check the HW config is sane */
+	if (ics->lsi_base < ics->hwirq_start ||
+	    (ics->lsi_base + ics->lsi_count) > (ics->hwirq_start + ics->count))
+		pr_warning("wsp_ics: WARNING ! LSIs out of interrupt-ranges !\n");
+	if (msi_base < ics->hwirq_start ||
+	    (msi_base + msi_count) > (ics->hwirq_start + ics->count))
+		pr_warning("wsp_ics: WARNING ! MSIs out of interrupt-ranges !\n");
+
+	/* We don't check for overlap between LSI and MSI, which will happen
+	 * if we use the same BUID, I'm not sure yet how legit that is.
+	 */
+
+	rc = wsp_ics_bitmap_setup(ics, dn);
+	if (rc) {
+		iounmap(regs);
+		return rc;
+	}
+
+	ics->dn = of_node_get(dn);
+	alloc_irq_map(ics);
+
+	for(i = 0; i < ics->count; i++)
+		wsp_mask_real_irq(ics->hwirq_start + i, ics);
+
+	ics->ics.map = wsp_ics_map;
+	ics->ics.mask_unknown = wsp_ics_mask_unknown;
+	ics->ics.get_server = wsp_ics_get_server;
+	ics->ics.host_match = wsp_ics_host_match;
+
+	xics_register_ics(&ics->ics);
+
+	return 0;
+}
+
+static void __init wsp_ics_set_default_server(void)
+{
+	struct device_node *np;
+	u32 hwid;
+
+	/* Find the server number for the boot cpu. */
+	np = of_get_cpu_node(boot_cpuid, NULL);
+	BUG_ON(!np);
+
+	hwid = get_hard_smp_processor_id(boot_cpuid);
+
+	pr_info("wsp_ics: default server is %#x, CPU %s\n", hwid, np->full_name);
+	xics_default_server = hwid;
+
+	of_node_put(np);
+}
+
+static int __init wsp_ics_init(void)
+{
+	struct device_node *dn;
+	struct wsp_ics *ics;
+	int rc, found;
+
+	wsp_ics_set_default_server();
+
+	found = 0;
+	for_each_compatible_node(dn, NULL, "ibm,ppc-xics")
+		found++;
+
+	if (found == 0) {
+		pr_err("wsp_ics: No ICS's found!\n");
+		return -ENODEV;
+	}
+
+	ics_list = kmalloc(sizeof(*ics) * found, GFP_KERNEL);
+	if (!ics_list) {
+		pr_err("wsp_ics: No memory for structs.\n");
+		return -ENOMEM;
+	}
+
+	num_ics = 0;
+	ics = ics_list;
+	for_each_compatible_node(dn, NULL, "ibm,wsp-xics") {
+		rc = wsp_ics_setup(ics, dn);
+		if (rc == 0) {
+			ics++;
+			num_ics++;
+		}
+	}
+
+	if (found != num_ics) {
+		pr_err("wsp_ics: Failed setting up %d ICS's\n",
+			found - num_ics);
+		return -1;
+	}
+
+	return 0;
+}
+
+void __init wsp_init_irq(void)
+{
+	wsp_ics_init();
+	xics_init();
+
+	/* We need to patch our irq chip's EOI to point to the right ICP */
+	wsp_irq_chip.irq_eoi = icp_ops->eoi;
+}
diff --git a/arch/powerpc/platforms/wsp/ics.h b/arch/powerpc/platforms/wsp/ics.h
new file mode 100644
index 0000000..e34d531
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/ics.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright 2009 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __ICS_H
+#define __ICS_H
+
+#define XIVE_ADDR_MASK		0x7FFULL
+
+extern void wsp_init_irq(void);
+
+extern int wsp_ics_alloc_irq(struct device_node *dn, int num);
+extern void wsp_ics_free_irq(struct device_node *dn, unsigned int irq);
+
+#endif /* __ICS_H */
diff --git a/arch/powerpc/platforms/wsp/opb_pic.c b/arch/powerpc/platforms/wsp/opb_pic.c
new file mode 100644
index 0000000..4ed9a7a
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/opb_pic.c
@@ -0,0 +1,332 @@
+/*
+ * IBM Onboard Peripheral Bus Interrupt Controller
+ *
+ * Copyright 2010 Jack Miller, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+
+#include <asm/reg_a2.h>
+#include <asm/irq.h>
+
+#define OPB_NR_IRQS 32
+
+#define OPB_MLSASIER	0x04    /* MLS Accumulated Status IER */
+#define OPB_MLSIR	0x50	/* MLS Interrupt Register */
+#define OPB_MLSIER	0x54	/* MLS Interrupt Enable Register */
+#define OPB_MLSIPR	0x58	/* MLS Interrupt Polarity Register */
+#define OPB_MLSIIR	0x5c	/* MLS Interrupt Inputs Register */
+
+static int opb_index = 0;
+
+struct opb_pic {
+	struct irq_host *host;
+	void *regs;
+	int index;
+	spinlock_t lock;
+};
+
+static u32 opb_in(struct opb_pic *opb, int offset)
+{
+	return in_be32(opb->regs + offset);
+}
+
+static void opb_out(struct opb_pic *opb, int offset, u32 val)
+{
+	out_be32(opb->regs + offset, val);
+}
+
+static void opb_unmask_irq(struct irq_data *d)
+{
+	struct opb_pic *opb;
+	unsigned long flags;
+	u32 ier, bitset;
+
+	opb = d->chip_data;
+	bitset = (1 << (31 - irq_map[d->irq].hwirq));
+
+	spin_lock_irqsave(&opb->lock, flags);
+
+	ier = opb_in(opb, OPB_MLSIER);
+	opb_out(opb, OPB_MLSIER, ier | bitset);
+	ier = opb_in(opb, OPB_MLSIER);
+
+	spin_unlock_irqrestore(&opb->lock, flags);
+}
+
+static void opb_mask_irq(struct irq_data *d)
+{
+	struct opb_pic *opb;
+	unsigned long flags;
+	u32 ier, mask;
+
+	opb = d->chip_data;
+	mask = ~(1 << (31 - irq_map[d->irq].hwirq));
+
+	spin_lock_irqsave(&opb->lock, flags);
+
+	ier = opb_in(opb, OPB_MLSIER);
+	opb_out(opb, OPB_MLSIER, ier & mask);
+	ier = opb_in(opb, OPB_MLSIER); // Flush posted writes
+
+	spin_unlock_irqrestore(&opb->lock, flags);
+}
+
+static void opb_ack_irq(struct irq_data *d)
+{
+	struct opb_pic *opb;
+	unsigned long flags;
+	u32 bitset;
+
+	opb = d->chip_data;
+	bitset = (1 << (31 - irq_map[d->irq].hwirq));
+
+	spin_lock_irqsave(&opb->lock, flags);
+
+	opb_out(opb, OPB_MLSIR, bitset);
+	opb_in(opb, OPB_MLSIR); // Flush posted writes
+
+	spin_unlock_irqrestore(&opb->lock, flags);
+}
+
+static void opb_mask_ack_irq(struct irq_data *d)
+{
+	struct opb_pic *opb;
+	unsigned long flags;
+	u32 bitset;
+	u32 ier, ir;
+
+	opb = d->chip_data;
+	bitset = (1 << (31 - irq_map[d->irq].hwirq));
+
+	spin_lock_irqsave(&opb->lock, flags);
+
+	ier = opb_in(opb, OPB_MLSIER);
+	opb_out(opb, OPB_MLSIER, ier & ~bitset);
+	ier = opb_in(opb, OPB_MLSIER); // Flush posted writes
+
+	opb_out(opb, OPB_MLSIR, bitset);
+	ir = opb_in(opb, OPB_MLSIR); // Flush posted writes
+
+	spin_unlock_irqrestore(&opb->lock, flags);
+}
+
+static int opb_set_irq_type(struct irq_data *d, unsigned int flow)
+{
+	struct opb_pic *opb;
+	unsigned long flags;
+	int invert, ipr, mask, bit;
+
+	opb = d->chip_data;
+
+	/* The only information we're interested in in the type is whether it's
+	 * a high or low trigger. For high triggered interrupts, the polarity
+	 * set for it in the MLS Interrupt Polarity Register is 0, for low
+	 * interrupts it's 1 so that the proper input in the MLS Interrupt Input
+	 * Register is interrupted as asserting the interrupt. */
+
+	switch (flow) {
+		case IRQ_TYPE_NONE:
+			opb_mask_irq(d);
+			return 0;
+
+		case IRQ_TYPE_LEVEL_HIGH:
+			invert = 0;
+			break;
+
+		case IRQ_TYPE_LEVEL_LOW:
+			invert = 1;
+			break;
+
+		default:
+			return -EINVAL;
+	}
+
+	bit = (1 << (31 - irq_map[d->irq].hwirq));
+	mask = ~bit;
+
+	spin_lock_irqsave(&opb->lock, flags);
+
+	ipr = opb_in(opb, OPB_MLSIPR);
+	ipr = (ipr & mask) | (invert ? bit : 0);
+	opb_out(opb, OPB_MLSIPR, ipr);
+	ipr = opb_in(opb, OPB_MLSIPR);  // Flush posted writes
+
+	spin_unlock_irqrestore(&opb->lock, flags);
+
+	/* Record the type in the interrupt descriptor */
+	irqd_set_trigger_type(d, flow);
+
+	return 0;
+}
+
+static struct irq_chip opb_irq_chip = {
+	.name		= "OPB",
+	.irq_mask	= opb_mask_irq,
+	.irq_unmask	= opb_unmask_irq,
+	.irq_mask_ack	= opb_mask_ack_irq,
+	.irq_ack	= opb_ack_irq,
+	.irq_set_type	= opb_set_irq_type
+};
+
+static int opb_host_map(struct irq_host *host, unsigned int virq,
+		irq_hw_number_t hwirq)
+{
+	struct opb_pic *opb;
+
+	opb = host->host_data;
+
+	/* Most of the important stuff is handled by the generic host code, like
+	 * the lookup, so just attach some info to the virtual irq */
+
+	irq_set_chip_data(virq, opb);
+	irq_set_chip_and_handler(virq, &opb_irq_chip, handle_level_irq);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int opb_host_xlate(struct irq_host *host, struct device_node *dn,
+		const u32 *intspec, unsigned int intsize,
+		irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	/* Interrupt size must == 2 */
+	BUG_ON(intsize != 2);
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1];
+	return 0;
+}
+
+static struct irq_host_ops opb_host_ops = {
+	.map = opb_host_map,
+	.xlate = opb_host_xlate,
+};
+
+irqreturn_t opb_irq_handler(int irq, void *private)
+{
+	struct opb_pic *opb;
+	u32 ir, src, subvirq;
+
+	opb = (struct opb_pic *) private;
+
+	/* Read the OPB MLS Interrupt Register for
+	 * asserted interrupts */
+	ir = opb_in(opb, OPB_MLSIR);
+	if (!ir)
+		return IRQ_NONE;
+
+	do {
+		/* Get 1 - 32 source, *NOT* bit */
+		src = 32 - ffs(ir);
+
+		/* Translate from the OPB's conception of interrupt number to
+		 * Linux's virtual IRQ */
+
+		subvirq = irq_linear_revmap(opb->host, src);
+
+		generic_handle_irq(subvirq);
+	} while ((ir = opb_in(opb, OPB_MLSIR)));
+
+	return IRQ_HANDLED;
+}
+
+struct opb_pic *opb_pic_init_one(struct device_node *dn)
+{
+	struct opb_pic *opb;
+	struct resource res;
+
+	if (of_address_to_resource(dn, 0, &res)) {
+		printk(KERN_ERR "opb: Couldn't translate resource\n");
+		return  NULL;
+	}
+
+	opb = kzalloc(sizeof(struct opb_pic), GFP_KERNEL);
+	if (!opb) {
+		printk(KERN_ERR "opb: Failed to allocate opb struct!\n");
+		return NULL;
+	}
+
+	/* Get access to the OPB MMIO registers */
+	opb->regs = ioremap(res.start + 0x10000, 0x1000);
+	if (!opb->regs) {
+		printk(KERN_ERR "opb: Failed to allocate register space!\n");
+		goto free_opb;
+	}
+
+	/* Allocate an irq host so that Linux knows that despite only
+	 * having one interrupt to issue, we're the controller for multiple
+	 * hardware IRQs, so later we can lookup their virtual IRQs. */
+
+	opb->host = irq_alloc_host(dn, IRQ_HOST_MAP_LINEAR,
+			OPB_NR_IRQS, &opb_host_ops, -1);
+
+	if (!opb->host) {
+		printk(KERN_ERR "opb: Failed to allocate IRQ host!\n");
+		goto free_regs;
+	}
+
+	opb->index = opb_index++;
+	spin_lock_init(&opb->lock);
+	opb->host->host_data = opb;
+
+	/* Disable all interrupts by default */
+	opb_out(opb, OPB_MLSASIER, 0);
+	opb_out(opb, OPB_MLSIER, 0);
+
+	/* ACK any interrupts left by FW */
+	opb_out(opb, OPB_MLSIR, 0xFFFFFFFF);
+
+	return opb;
+
+free_regs:
+	iounmap(opb->regs);
+free_opb:
+	kfree(opb);
+	return NULL;
+}
+
+void __init opb_pic_init(void)
+{
+	struct device_node *dn;
+	struct opb_pic *opb;
+	int virq;
+	int rc;
+
+	/* Call init_one for each OPB device */
+	for_each_compatible_node(dn, NULL, "ibm,opb") {
+
+		/* Fill in an OPB struct */
+		opb = opb_pic_init_one(dn);
+		if (!opb) {
+			printk(KERN_WARNING "opb: Failed to init node, skipped!\n");
+			continue;
+		}
+
+		/* Map / get opb's hardware virtual irq */
+		virq = irq_of_parse_and_map(dn, 0);
+		if (virq <= 0) {
+			printk("opb: irq_op_parse_and_map failed!\n");
+			continue;
+		}
+
+		/* Attach opb interrupt handler to new virtual IRQ */
+		rc = request_irq(virq, opb_irq_handler, 0, "OPB LS Cascade", opb);
+		if (rc) {
+			printk("opb: request_irq failed: %d\n", rc);
+			continue;
+		}
+
+		printk("OPB%d init with %d IRQs at %p\n", opb->index,
+				OPB_NR_IRQS, opb->regs);
+	}
+}
diff --git a/arch/powerpc/platforms/wsp/psr2.c b/arch/powerpc/platforms/wsp/psr2.c
new file mode 100644
index 0000000..40f2891
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/psr2.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright 2008-2011, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+
+#include <asm/machdep.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+
+#include "ics.h"
+#include "wsp.h"
+
+
+static void psr2_spin(void)
+{
+	hard_irq_disable();
+	for (;;) ;
+}
+
+static void psr2_restart(char *cmd)
+{
+	psr2_spin();
+}
+
+static int psr2_probe_devices(void)
+{
+	struct device_node *np;
+
+	/* Our RTC is a ds1500. It seems to be programatically compatible
+	 * with the ds1511 for which we have a driver so let's use that
+	 */
+	np = of_find_compatible_node(NULL, NULL, "dallas,ds1500");
+	if (np != NULL) {
+		struct resource res;
+		if (of_address_to_resource(np, 0, &res) == 0)
+			platform_device_register_simple("ds1511", 0, &res, 1);
+	}
+	return 0;
+}
+machine_arch_initcall(psr2_md, psr2_probe_devices);
+
+static void __init psr2_setup_arch(void)
+{
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	scom_init_wsp();
+
+	/* Setup SMP callback */
+#ifdef CONFIG_SMP
+	a2_setup_smp();
+#endif
+}
+
+static int __init psr2_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,psr2"))
+		return 0;
+
+	return 1;
+}
+
+static void __init psr2_init_irq(void)
+{
+	wsp_init_irq();
+	opb_pic_init();
+}
+
+define_machine(psr2_md) {
+	.name			= "PSR2 A2",
+	.probe			= psr2_probe,
+	.setup_arch		= psr2_setup_arch,
+	.restart		= psr2_restart,
+	.power_off		= psr2_spin,
+	.halt			= psr2_spin,
+	.calibrate_decr		= generic_calibrate_decr,
+	.init_IRQ		= psr2_init_irq,
+	.progress		= udbg_progress,
+	.power_save		= book3e_idle,
+};
diff --git a/arch/powerpc/platforms/wsp/scom_smp.c b/arch/powerpc/platforms/wsp/scom_smp.c
new file mode 100644
index 0000000..141e780
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/scom_smp.c
@@ -0,0 +1,427 @@
+/*
+ * SCOM support for A2 platforms
+ *
+ * Copyright 2007-2011 Benjamin Herrenschmidt, David Gibson,
+ *		       Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/cputhreads.h>
+#include <asm/reg_a2.h>
+#include <asm/scom.h>
+#include <asm/udbg.h>
+
+#include "wsp.h"
+
+#define SCOM_RAMC		0x2a		/* Ram Command */
+#define SCOM_RAMC_TGT1_EXT	0x80000000
+#define SCOM_RAMC_SRC1_EXT	0x40000000
+#define SCOM_RAMC_SRC2_EXT	0x20000000
+#define SCOM_RAMC_SRC3_EXT	0x10000000
+#define SCOM_RAMC_ENABLE	0x00080000
+#define SCOM_RAMC_THREADSEL	0x00060000
+#define SCOM_RAMC_EXECUTE	0x00010000
+#define SCOM_RAMC_MSR_OVERRIDE	0x00008000
+#define SCOM_RAMC_MSR_PR	0x00004000
+#define SCOM_RAMC_MSR_GS	0x00002000
+#define SCOM_RAMC_FORCE		0x00001000
+#define SCOM_RAMC_FLUSH		0x00000800
+#define SCOM_RAMC_INTERRUPT	0x00000004
+#define SCOM_RAMC_ERROR		0x00000002
+#define SCOM_RAMC_DONE		0x00000001
+#define SCOM_RAMI		0x29		/* Ram Instruction */
+#define SCOM_RAMIC		0x28		/* Ram Instruction and Command */
+#define SCOM_RAMIC_INSN		0xffffffff00000000
+#define SCOM_RAMD		0x2d		/* Ram Data */
+#define SCOM_RAMDH		0x2e		/* Ram Data High */
+#define SCOM_RAMDL		0x2f		/* Ram Data Low */
+#define SCOM_PCCR0		0x33		/* PC Configuration Register 0 */
+#define SCOM_PCCR0_ENABLE_DEBUG	0x80000000
+#define SCOM_PCCR0_ENABLE_RAM	0x40000000
+#define SCOM_THRCTL		0x30		/* Thread Control and Status */
+#define SCOM_THRCTL_T0_STOP	0x80000000
+#define SCOM_THRCTL_T1_STOP	0x40000000
+#define SCOM_THRCTL_T2_STOP	0x20000000
+#define SCOM_THRCTL_T3_STOP	0x10000000
+#define SCOM_THRCTL_T0_STEP	0x08000000
+#define SCOM_THRCTL_T1_STEP	0x04000000
+#define SCOM_THRCTL_T2_STEP	0x02000000
+#define SCOM_THRCTL_T3_STEP	0x01000000
+#define SCOM_THRCTL_T0_RUN	0x00800000
+#define SCOM_THRCTL_T1_RUN	0x00400000
+#define SCOM_THRCTL_T2_RUN	0x00200000
+#define SCOM_THRCTL_T3_RUN	0x00100000
+#define SCOM_THRCTL_T0_PM	0x00080000
+#define SCOM_THRCTL_T1_PM	0x00040000
+#define SCOM_THRCTL_T2_PM	0x00020000
+#define SCOM_THRCTL_T3_PM	0x00010000
+#define SCOM_THRCTL_T0_UDE	0x00008000
+#define SCOM_THRCTL_T1_UDE	0x00004000
+#define SCOM_THRCTL_T2_UDE	0x00002000
+#define SCOM_THRCTL_T3_UDE	0x00001000
+#define SCOM_THRCTL_ASYNC_DIS	0x00000800
+#define SCOM_THRCTL_TB_DIS	0x00000400
+#define SCOM_THRCTL_DEC_DIS	0x00000200
+#define SCOM_THRCTL_AND		0x31		/* Thread Control and Status */
+#define SCOM_THRCTL_OR		0x32		/* Thread Control and Status */
+
+
+static DEFINE_PER_CPU(scom_map_t, scom_ptrs);
+
+static scom_map_t get_scom(int cpu, struct device_node *np, int *first_thread)
+{
+	scom_map_t scom = per_cpu(scom_ptrs, cpu);
+	int tcpu;
+
+	if (scom_map_ok(scom)) {
+		*first_thread = 0;
+		return scom;
+	}
+
+	*first_thread = 1;
+
+	scom = scom_map_device(np, 0);
+
+	for (tcpu = cpu_first_thread_sibling(cpu);
+	     tcpu <= cpu_last_thread_sibling(cpu); tcpu++)
+		per_cpu(scom_ptrs, tcpu) = scom;
+
+	/* Hack: for the boot core, this will actually get called on
+	 * the second thread up, not the first so our test above will
+	 * set first_thread incorrectly. */
+	if (cpu_first_thread_sibling(cpu) == 0)
+		*first_thread = 0;
+
+	return scom;
+}
+
+static int a2_scom_ram(scom_map_t scom, int thread, u32 insn, int extmask)
+{
+	u64 cmd, mask, val;
+	int n = 0;
+
+	cmd = ((u64)insn << 32) | (((u64)extmask & 0xf) << 28)
+		| ((u64)thread << 17) | SCOM_RAMC_ENABLE | SCOM_RAMC_EXECUTE;
+	mask = SCOM_RAMC_DONE | SCOM_RAMC_INTERRUPT | SCOM_RAMC_ERROR;
+
+	scom_write(scom, SCOM_RAMIC, cmd);
+
+	while (!((val = scom_read(scom, SCOM_RAMC)) & mask)) {
+		pr_devel("Waiting on RAMC = 0x%llx\n", val);
+		if (++n == 3) {
+			pr_err("RAMC timeout on instruction 0x%08x, thread %d\n",
+			       insn, thread);
+			return -1;
+		}
+	}
+
+	if (val & SCOM_RAMC_INTERRUPT) {
+		pr_err("RAMC interrupt on instruction 0x%08x, thread %d\n",
+		       insn, thread);
+		return -SCOM_RAMC_INTERRUPT;
+	}
+
+	if (val & SCOM_RAMC_ERROR) {
+		pr_err("RAMC error on instruction 0x%08x, thread %d\n",
+		       insn, thread);
+		return -SCOM_RAMC_ERROR;
+	}
+
+	return 0;
+}
+
+static int a2_scom_getgpr(scom_map_t scom, int thread, int gpr, int alt,
+			  u64 *out_gpr)
+{
+	int rc;
+
+	/* or rN, rN, rN */
+	u32 insn = 0x7c000378 | (gpr << 21) | (gpr << 16) | (gpr << 11);
+	rc = a2_scom_ram(scom, thread, insn, alt ? 0xf : 0x0);
+	if (rc)
+		return rc;
+
+	*out_gpr = scom_read(scom, SCOM_RAMD);
+
+	return 0;
+}
+
+static int a2_scom_getspr(scom_map_t scom, int thread, int spr, u64 *out_spr)
+{
+	int rc, sprhi, sprlo;
+	u32 insn;
+
+	sprhi = spr >> 5;
+	sprlo = spr & 0x1f;
+	insn = 0x7c2002a6 | (sprlo << 16) | (sprhi << 11); /* mfspr r1,spr */
+
+	if (spr == 0x0ff0)
+		insn = 0x7c2000a6; /* mfmsr r1 */
+
+	rc = a2_scom_ram(scom, thread, insn, 0xf);
+	if (rc)
+		return rc;
+	return a2_scom_getgpr(scom, thread, 1, 1, out_spr);
+}
+
+static int a2_scom_setgpr(scom_map_t scom, int thread, int gpr,
+			  int alt, u64 val)
+{
+	u32 lis = 0x3c000000 | (gpr << 21);
+	u32 li = 0x38000000 | (gpr << 21);
+	u32 oris = 0x64000000 | (gpr << 21) | (gpr << 16);
+	u32 ori = 0x60000000 | (gpr << 21) | (gpr << 16);
+	u32 rldicr32 = 0x780007c6 | (gpr << 21) | (gpr << 16);
+	u32 highest = val >> 48;
+	u32 higher = (val >> 32) & 0xffff;
+	u32 high = (val >> 16) & 0xffff;
+	u32 low = val & 0xffff;
+	int lext = alt ? 0x8 : 0x0;
+	int oext = alt ? 0xf : 0x0;
+	int rc = 0;
+
+	if (highest)
+		rc |= a2_scom_ram(scom, thread, lis | highest, lext);
+
+	if (higher) {
+		if (highest)
+			rc |= a2_scom_ram(scom, thread, oris | higher, oext);
+		else
+			rc |= a2_scom_ram(scom, thread, li | higher, lext);
+	}
+
+	if (highest || higher)
+		rc |= a2_scom_ram(scom, thread, rldicr32, oext);
+
+	if (high) {
+		if (highest || higher)
+			rc |= a2_scom_ram(scom, thread, oris | high, oext);
+		else
+			rc |= a2_scom_ram(scom, thread, lis | high, lext);
+	}
+
+	if (highest || higher || high)
+		rc |= a2_scom_ram(scom, thread, ori | low, oext);
+	else
+		rc |= a2_scom_ram(scom, thread, li | low, lext);
+
+	return rc;
+}
+
+static int a2_scom_setspr(scom_map_t scom, int thread, int spr, u64 val)
+{
+	int sprhi = spr >> 5;
+	int sprlo = spr & 0x1f;
+	/* mtspr spr, r1 */
+	u32 insn = 0x7c2003a6 | (sprlo << 16) | (sprhi << 11);
+
+	if (spr == 0x0ff0)
+		insn = 0x7c200124; /* mtmsr r1 */
+
+	if (a2_scom_setgpr(scom, thread, 1, 1, val))
+		return -1;
+
+	return a2_scom_ram(scom, thread, insn, 0xf);
+}
+
+static int a2_scom_initial_tlb(scom_map_t scom, int thread)
+{
+	extern u32 a2_tlbinit_code_start[], a2_tlbinit_code_end[];
+	extern u32 a2_tlbinit_after_iprot_flush[];
+	extern u32 a2_tlbinit_after_linear_map[];
+	u32 assoc, entries, i;
+	u64 epn, tlbcfg;
+	u32 *p;
+	int rc;
+
+	/* Invalidate all entries (including iprot) */
+
+	rc = a2_scom_getspr(scom, thread, SPRN_TLB0CFG, &tlbcfg);
+	if (rc)
+		goto scom_fail;
+	entries = tlbcfg & TLBnCFG_N_ENTRY;
+	assoc = (tlbcfg & TLBnCFG_ASSOC) >> 24;
+	epn = 0;
+
+	/* Set MMUCR2 to enable 4K, 64K, 1M, 16M and 1G pages */
+	a2_scom_setspr(scom, thread, SPRN_MMUCR2, 0x000a7531);
+	/* Set MMUCR3 to write all thids bit to the TLB */
+	a2_scom_setspr(scom, thread, SPRN_MMUCR3, 0x0000000f);
+
+	/* Set MAS1 for 1G page size, and MAS2 to our initial EPN */
+	a2_scom_setspr(scom, thread, SPRN_MAS1, MAS1_TSIZE(BOOK3E_PAGESZ_1GB));
+	a2_scom_setspr(scom, thread, SPRN_MAS2, epn);
+	for (i = 0; i < entries; i++) {
+
+		a2_scom_setspr(scom, thread, SPRN_MAS0, MAS0_ESEL(i % assoc));
+
+		/* tlbwe */
+		rc = a2_scom_ram(scom, thread, 0x7c0007a4, 0);
+		if (rc)
+			goto scom_fail;
+
+		/* Next entry is new address? */
+		if((i + 1) % assoc == 0) {
+			epn += (1 << 30);
+			a2_scom_setspr(scom, thread, SPRN_MAS2, epn);
+		}
+	}
+
+	/* Setup args for linear mapping */
+	rc = a2_scom_setgpr(scom, thread, 3, 0, MAS0_TLBSEL(0));
+	if (rc)
+		goto scom_fail;
+
+	/* Linear mapping */
+	for (p = a2_tlbinit_code_start; p < a2_tlbinit_after_linear_map; p++) {
+		rc = a2_scom_ram(scom, thread, *p, 0);
+		if (rc)
+			goto scom_fail;
+	}
+
+	/*
+	 * For the boot thread, between the linear mapping and the debug
+	 * mappings there is a loop to flush iprot mappings. Ramming doesn't do
+	 * branches, but the secondary threads don't need to be nearly as smart
+	 * (i.e. we don't need to worry about invalidating the mapping we're
+	 * standing on).
+	 */
+
+	/* Debug mappings. Expects r11 = MAS0 from linear map (set above) */
+	for (p = a2_tlbinit_after_iprot_flush; p < a2_tlbinit_code_end; p++) {
+		rc = a2_scom_ram(scom, thread, *p, 0);
+		if (rc)
+			goto scom_fail;
+	}
+
+scom_fail:
+	if (rc)
+		pr_err("Setting up initial TLB failed, err %d\n", rc);
+
+	if (rc == -SCOM_RAMC_INTERRUPT) {
+		/* Interrupt, dump some status */
+		int rc[10];
+		u64 iar, srr0, srr1, esr, mas0, mas1, mas2, mas7_3, mas8, ccr2;
+		rc[0] = a2_scom_getspr(scom, thread, SPRN_IAR, &iar);
+		rc[1] = a2_scom_getspr(scom, thread, SPRN_SRR0, &srr0);
+		rc[2] = a2_scom_getspr(scom, thread, SPRN_SRR1, &srr1);
+		rc[3] = a2_scom_getspr(scom, thread, SPRN_ESR, &esr);
+		rc[4] = a2_scom_getspr(scom, thread, SPRN_MAS0, &mas0);
+		rc[5] = a2_scom_getspr(scom, thread, SPRN_MAS1, &mas1);
+		rc[6] = a2_scom_getspr(scom, thread, SPRN_MAS2, &mas2);
+		rc[7] = a2_scom_getspr(scom, thread, SPRN_MAS7_MAS3, &mas7_3);
+		rc[8] = a2_scom_getspr(scom, thread, SPRN_MAS8, &mas8);
+		rc[9] = a2_scom_getspr(scom, thread, SPRN_A2_CCR2, &ccr2);
+		pr_err(" -> retreived IAR =0x%llx (err %d)\n", iar, rc[0]);
+		pr_err("    retreived SRR0=0x%llx (err %d)\n", srr0, rc[1]);
+		pr_err("    retreived SRR1=0x%llx (err %d)\n", srr1, rc[2]);
+		pr_err("    retreived ESR =0x%llx (err %d)\n", esr, rc[3]);
+		pr_err("    retreived MAS0=0x%llx (err %d)\n", mas0, rc[4]);
+		pr_err("    retreived MAS1=0x%llx (err %d)\n", mas1, rc[5]);
+		pr_err("    retreived MAS2=0x%llx (err %d)\n", mas2, rc[6]);
+		pr_err("    retreived MS73=0x%llx (err %d)\n", mas7_3, rc[7]);
+		pr_err("    retreived MAS8=0x%llx (err %d)\n", mas8, rc[8]);
+		pr_err("    retreived CCR2=0x%llx (err %d)\n", ccr2, rc[9]);
+	}
+
+	return rc;
+}
+
+int __devinit a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
+				  struct device_node *np)
+{
+	u64 init_iar, init_msr, init_ccr2;
+	unsigned long start_here;
+	int rc, core_setup;
+	scom_map_t scom;
+	u64 pccr0;
+
+	scom = get_scom(lcpu, np, &core_setup);
+	if (!scom) {
+		printk(KERN_ERR "Couldn't map SCOM for CPU%d\n", lcpu);
+		return -1;
+	}
+
+	pr_devel("Bringing up CPU%d using SCOM...\n", lcpu);
+
+	pccr0 = scom_read(scom, SCOM_PCCR0);
+	scom_write(scom, SCOM_PCCR0, pccr0 | SCOM_PCCR0_ENABLE_DEBUG |
+				     SCOM_PCCR0_ENABLE_RAM);
+
+	/* Stop the thead with THRCTL. If we are setting up the TLB we stop all
+	 * threads. We also disable asynchronous interrupts while RAMing.
+	 */
+	if (core_setup)
+		scom_write(scom, SCOM_THRCTL_OR,
+			      SCOM_THRCTL_T0_STOP |
+			      SCOM_THRCTL_T1_STOP |
+			      SCOM_THRCTL_T2_STOP |
+			      SCOM_THRCTL_T3_STOP |
+			      SCOM_THRCTL_ASYNC_DIS);
+	else
+		scom_write(scom, SCOM_THRCTL_OR, SCOM_THRCTL_T0_STOP >> thr_idx);
+
+	/* Flush its pipeline just in case */
+	scom_write(scom, SCOM_RAMC, ((u64)thr_idx << 17) |
+		      SCOM_RAMC_FLUSH | SCOM_RAMC_ENABLE);
+
+	a2_scom_getspr(scom, thr_idx, SPRN_IAR, &init_iar);
+	a2_scom_getspr(scom, thr_idx, 0x0ff0, &init_msr);
+	a2_scom_getspr(scom, thr_idx, SPRN_A2_CCR2, &init_ccr2);
+
+	/* Set MSR to MSR_CM (0x0ff0 is magic value for MSR_CM) */
+	rc = a2_scom_setspr(scom, thr_idx, 0x0ff0, MSR_CM);
+	if (rc) {
+		pr_err("Failed to set MSR ! err %d\n", rc);
+		return rc;
+	}
+
+	/* RAM in an sync/isync for the sake of it */
+	a2_scom_ram(scom, thr_idx, 0x7c0004ac, 0);
+	a2_scom_ram(scom, thr_idx, 0x4c00012c, 0);
+
+	if (core_setup) {
+		pr_devel("CPU%d is first thread in core, initializing TLB...\n",
+			 lcpu);
+		rc = a2_scom_initial_tlb(scom, thr_idx);
+		if (rc)
+			goto fail;
+	}
+
+	start_here = *(unsigned long *)(core_setup ? generic_secondary_smp_init
+					: generic_secondary_thread_init);
+	pr_devel("CPU%d entry point at 0x%lx...\n", lcpu, start_here);
+
+	rc |= a2_scom_setspr(scom, thr_idx, SPRN_IAR, start_here);
+	rc |= a2_scom_setgpr(scom, thr_idx, 3, 0,
+			     get_hard_smp_processor_id(lcpu));
+	/*
+	 * Tell book3e_secondary_core_init not to set up the TLB, we've
+	 * already done that.
+	 */
+	rc |= a2_scom_setgpr(scom, thr_idx, 4, 0, 1);
+
+	rc |= a2_scom_setspr(scom, thr_idx, SPRN_TENS, 0x1 << thr_idx);
+
+	scom_write(scom, SCOM_RAMC, 0);
+	scom_write(scom, SCOM_THRCTL_AND, ~(SCOM_THRCTL_T0_STOP >> thr_idx));
+	scom_write(scom, SCOM_PCCR0, pccr0);
+fail:
+	pr_devel("  SCOM initialization %s\n", rc ? "failed" : "succeeded");
+	if (rc) {
+		pr_err("Old IAR=0x%08llx MSR=0x%08llx CCR2=0x%08llx\n",
+		       init_iar, init_msr, init_ccr2);
+	}
+
+	return rc;
+}
diff --git a/arch/powerpc/platforms/wsp/scom_wsp.c b/arch/powerpc/platforms/wsp/scom_wsp.c
new file mode 100644
index 0000000..4052e22
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/scom_wsp.c
@@ -0,0 +1,77 @@
+/*
+ *  SCOM backend for WSP
+ *
+ *  Copyright 2010 Benjamin Herrenschmidt, IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/cputhreads.h>
+#include <asm/reg_a2.h>
+#include <asm/scom.h>
+#include <asm/udbg.h>
+
+#include "wsp.h"
+
+
+static scom_map_t wsp_scom_map(struct device_node *dev, u64 reg, u64 count)
+{
+	struct resource r;
+	u64 xscom_addr;
+
+	if (!of_get_property(dev, "scom-controller", NULL)) {
+		pr_err("%s: device %s is not a SCOM controller\n",
+			__func__, dev->full_name);
+		return SCOM_MAP_INVALID;
+	}
+
+	if (of_address_to_resource(dev, 0, &r)) {
+		pr_debug("Failed to find SCOM controller address\n");
+		return 0;
+	}
+
+	/* Transform the SCOM address into an XSCOM offset */
+	xscom_addr = ((reg & 0x7f000000) >> 1) | ((reg & 0xfffff) << 3);
+
+	return (scom_map_t)ioremap(r.start + xscom_addr, count << 3);
+}
+
+static void wsp_scom_unmap(scom_map_t map)
+{
+	iounmap((void *)map);
+}
+
+static u64 wsp_scom_read(scom_map_t map, u32 reg)
+{
+	u64 __iomem *addr = (u64 __iomem *)map;
+
+	return in_be64(addr + reg);
+}
+
+static void wsp_scom_write(scom_map_t map, u32 reg, u64 value)
+{
+	u64 __iomem *addr = (u64 __iomem *)map;
+
+	return out_be64(addr + reg, value);
+}
+
+static const struct scom_controller wsp_scom_controller = {
+	.map	= wsp_scom_map,
+	.unmap	= wsp_scom_unmap,
+	.read	= wsp_scom_read,
+	.write	= wsp_scom_write
+};
+
+void scom_init_wsp(void)
+{
+	scom_init(&wsp_scom_controller);
+}
diff --git a/arch/powerpc/platforms/wsp/setup.c b/arch/powerpc/platforms/wsp/setup.c
new file mode 100644
index 0000000..11ac2f0
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/setup.c
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2010 Michael Ellerman, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+#include "wsp.h"
+
+/*
+ * Find chip-id by walking up device tree looking for ibm,wsp-chip-id property.
+ * Won't work for nodes that are not a descendant of a wsp node.
+ */
+int wsp_get_chip_id(struct device_node *dn)
+{
+	const u32 *p;
+	int rc;
+
+	/* Start looking at the specified node, not its parent */
+	dn = of_node_get(dn);
+	while (dn && !(p = of_get_property(dn, "ibm,wsp-chip-id", NULL)))
+		dn = of_get_next_parent(dn);
+
+	if (!dn)
+		return -1;
+
+	rc = *p;
+	of_node_put(dn);
+
+	return rc;
+}
diff --git a/arch/powerpc/platforms/wsp/smp.c b/arch/powerpc/platforms/wsp/smp.c
new file mode 100644
index 0000000..c7b8db9
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/smp.c
@@ -0,0 +1,87 @@
+/*
+ *  SMP Support for A2 platforms
+ *
+ *  Copyright 2007 Benjamin Herrenschmidt, IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+
+#include <asm/dbell.h>
+#include <asm/machdep.h>
+#include <asm/xics.h>
+
+#include "ics.h"
+#include "wsp.h"
+
+static void __devinit smp_a2_setup_cpu(int cpu)
+{
+	doorbell_setup_this_cpu();
+
+	if (cpu != boot_cpuid)
+		xics_setup_cpu();
+}
+
+int __devinit smp_a2_kick_cpu(int nr)
+{
+	const char *enable_method;
+	struct device_node *np;
+	int thr_idx;
+
+	if (nr < 0 || nr >= NR_CPUS)
+		return -ENOENT;
+
+	np = of_get_cpu_node(nr, &thr_idx);
+	if (!np)
+		return -ENODEV;
+
+	enable_method = of_get_property(np, "enable-method", NULL);
+	pr_devel("CPU%d has enable-method: \"%s\"\n", nr, enable_method);
+
+	if (!enable_method) {
+                printk(KERN_ERR "CPU%d has no enable-method\n", nr);
+		return -ENOENT;
+	} else if (strcmp(enable_method, "ibm,a2-scom") == 0) {
+		if (a2_scom_startup_cpu(nr, thr_idx, np))
+			return -1;
+	} else {
+		printk(KERN_ERR "CPU%d: Don't understand enable-method \"%s\"\n",
+                       nr, enable_method);
+		return -EINVAL;
+	}
+
+	/*
+	 * The processor is currently spinning, waiting for the
+	 * cpu_start field to become non-zero After we set cpu_start,
+	 * the processor will continue on to secondary_start
+	 */
+	paca[nr].cpu_start = 1;
+
+	return 0;
+}
+
+static int __init smp_a2_probe(void)
+{
+	return cpus_weight(cpu_possible_map);
+}
+
+static struct smp_ops_t a2_smp_ops = {
+	.message_pass	= doorbell_message_pass,
+	.probe		= smp_a2_probe,
+	.kick_cpu	= smp_a2_kick_cpu,
+	.setup_cpu	= smp_a2_setup_cpu,
+};
+
+void __init a2_setup_smp(void)
+{
+	smp_ops = &a2_smp_ops;
+}
diff --git a/arch/powerpc/platforms/wsp/wsp.h b/arch/powerpc/platforms/wsp/wsp.h
new file mode 100644
index 0000000..7c3e087
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/wsp.h
@@ -0,0 +1,17 @@
+#ifndef __WSP_H
+#define __WSP_H
+
+#include <asm/wsp.h>
+
+extern void wsp_setup_pci(void);
+extern void scom_init_wsp(void);
+
+extern void a2_setup_smp(void);
+extern int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
+			       struct device_node *np);
+int smp_a2_cpu_bootable(unsigned int nr);
+int __devinit smp_a2_kick_cpu(int nr);
+
+void opb_pic_init(void);
+
+#endif /*  __WSP_H */
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index be5e3d7..efc79e1 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -7,6 +7,7 @@
  *  2 of the License, or (at your option) any later version.
  *
  */
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
-- 
1.7.1
