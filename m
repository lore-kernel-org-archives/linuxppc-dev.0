Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B057AC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 01:00:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34F92063F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 01:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34F92063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dFWt4mZLzDqND
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 12:00:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dFRF2XtDzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:56:41 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 395D5AE80048;
 Sun, 13 Jan 2019 19:56:08 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 2/2] powerpc/powernv/npu: Move platform shared code to
 sysdev
Date: Mon, 14 Jan 2019 11:56:01 +1100
Message-Id: <20190114005601.1220-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114005601.1220-1-aik@ozlabs.ru>
References: <20190114005601.1220-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Initially NPU support was introduced for the powernv platform only,
and later it was extended to pseries so we ended up in a situation when
pseries code calls into arch/powerpc/platforms/powernv which is ugly.

This moves parts of npu-dma.c required for both powernv and pseries
platforms to sysdev.

This is mostly cut-n-paste; the only change is:
the pnv_npu2_init_context() helper takes a callback pointer which
returns void but the empty stub for it defines the callback as it
returns a pointer so this fixes it.

From now on it is possible to build without POWERNV platform enabled and
still have NPU2 support on pseries; currently this fails as:

arch/powerpc/platforms/pseries/pci.o: In function `pSeries_final_fixup':
/home/aik/p/kernel/arch/powerpc/platforms/pseries/pci.c:267: undefined reference to `pnv_npu2_init'
/home/aik/p/kernel/Makefile==1027== recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/sysdev/Makefile             |   1 +
 arch/powerpc/include/asm/npu.h           |  88 +++
 arch/powerpc/include/asm/pci.h           |   8 +-
 arch/powerpc/include/asm/powernv.h       |  24 -
 arch/powerpc/platforms/powernv/npu-dma.c | 662 ----------------------
 arch/powerpc/sysdev/npu.c                | 677 +++++++++++++++++++++++
 arch/powerpc/sysdev/Kconfig              |   3 +
 7 files changed, 770 insertions(+), 693 deletions(-)
 create mode 100644 arch/powerpc/include/asm/npu.h
 create mode 100644 arch/powerpc/sysdev/npu.c

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index aaf2328..e8895e3 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_PPC_XICS)		+= xics/
 obj-$(CONFIG_PPC_XIVE)		+= xive/
 
 obj-$(CONFIG_GE_FPGA)		+= ge/
+obj-$(CONFIG_PPC_NPU)		+= npu.o
diff --git a/arch/powerpc/include/asm/npu.h b/arch/powerpc/include/asm/npu.h
new file mode 100644
index 0000000..c957472
--- /dev/null
+++ b/arch/powerpc/include/asm/npu.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_NPU_H
+#define _ASM_NPU_H
+
+#if defined(CONFIG_PPC_RADIX_MMU) && \
+	(defined(CONFIG_PPC_POWERNV) || defined(CONFIG_PPC_PSERIES))
+#define NPU2_WRITE 1
+extern struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
+			unsigned long flags,
+			void (*cb)(struct npu_context *, void *),
+			void *priv);
+extern void pnv_npu2_destroy_context(struct npu_context *context,
+				struct pci_dev *gpdev);
+extern int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
+				unsigned long *flags, unsigned long *status,
+				int count);
+extern int pnv_npu2_init(struct pci_controller *hose);
+extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
+extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
+
+#else
+static inline struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
+			unsigned long flags,
+			void (*cb)(struct npu_context *, void *),
+			void *priv)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void pnv_npu2_destroy_context(struct npu_context *context,
+					struct pci_dev *gpdev)
+{
+}
+
+static inline int pnv_npu2_handle_fault(struct npu_context *context,
+					uintptr_t *ea, unsigned long *flags,
+					unsigned long *status, int count)
+{
+	return -ENODEV;
+}
+
+static inline int pnv_npu2_init(struct pci_controller *hose)
+{
+	return 0;
+}
+
+static inline struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev)
+{
+	return NULL;
+}
+
+static inline struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev,
+		int index)
+{
+	return NULL;
+}
+
+#endif
+
+#if defined(CONFIG_PPC_POWERNV)
+extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
+		unsigned long msr);
+extern int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev);
+#else
+static inline int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev,
+		unsigned int lparid, unsigned long msr)
+{
+	return -ENODEV;
+}
+
+static inline int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev)
+{
+	return -ENODEV;
+}
+
+
+#endif
+
+#endif /* _ASM_NPU_H */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 0c72f18..70a6216 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/npu.h>
 
 /* Return values for pci_controller_ops.probe_mode function */
 #define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
@@ -127,11 +128,4 @@ extern void pcibios_scan_phb(struct pci_controller *hose);
 
 #endif	/* __KERNEL__ */
 
-extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
-extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
-extern int pnv_npu2_init(struct pci_controller *hose);
-extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
-		unsigned long msr);
-extern int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev);
-
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/include/asm/powernv.h b/arch/powerpc/include/asm/powernv.h
index 362ea12..fd7522c 100644
--- a/arch/powerpc/include/asm/powernv.h
+++ b/arch/powerpc/include/asm/powernv.h
@@ -11,34 +11,10 @@
 #define _ASM_POWERNV_H
 
 #ifdef CONFIG_PPC_POWERNV
-#define NPU2_WRITE 1
 extern void powernv_set_nmmu_ptcr(unsigned long ptcr);
-extern struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
-			unsigned long flags,
-			void (*cb)(struct npu_context *, void *),
-			void *priv);
-extern void pnv_npu2_destroy_context(struct npu_context *context,
-				struct pci_dev *gpdev);
-extern int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
-				unsigned long *flags, unsigned long *status,
-				int count);
-
 void pnv_tm_init(void);
 #else
 static inline void powernv_set_nmmu_ptcr(unsigned long ptcr) { }
-static inline struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
-			unsigned long flags,
-			struct npu_context *(*cb)(struct npu_context *, void *),
-			void *priv) { return ERR_PTR(-ENODEV); }
-static inline void pnv_npu2_destroy_context(struct npu_context *context,
-					struct pci_dev *gpdev) { }
-
-static inline int pnv_npu2_handle_fault(struct npu_context *context,
-					uintptr_t *ea, unsigned long *flags,
-					unsigned long *status, int count) {
-	return -ENODEV;
-}
-
 static inline void pnv_tm_init(void) { }
 #endif
 
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index c7cd259..c1c1438 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -11,80 +11,14 @@
 
 #include <linux/mmu_notifier.h>
 #include <linux/mmu_context.h>
-#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/memblock.h>
-#include <linux/sizes.h>
 
-#include <asm/debugfs.h>
 #include <asm/powernv.h>
 #include <asm/opal.h>
 
 #include "pci.h"
 
-/*
- * spinlock to protect initialisation of an npu_context for a particular
- * mm_struct.
- */
-static DEFINE_SPINLOCK(npu_context_lock);
-
-static struct pci_dev *get_pci_dev(struct device_node *dn)
-{
-	struct pci_dn *pdn = PCI_DN(dn);
-
-	return pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
-					   pdn->busno, pdn->devfn);
-}
-
-/* Given a NPU device get the associated PCI device. */
-struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev)
-{
-	struct device_node *dn;
-	struct pci_dev *gpdev;
-
-	if (WARN_ON(!npdev))
-		return NULL;
-
-	if (WARN_ON(!npdev->dev.of_node))
-		return NULL;
-
-	/* Get assoicated PCI device */
-	dn = of_parse_phandle(npdev->dev.of_node, "ibm,gpu", 0);
-	if (!dn)
-		return NULL;
-
-	gpdev = get_pci_dev(dn);
-	of_node_put(dn);
-
-	return gpdev;
-}
-EXPORT_SYMBOL(pnv_pci_get_gpu_dev);
-
-/* Given the real PCI device get a linked NPU device. */
-struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
-{
-	struct device_node *dn;
-	struct pci_dev *npdev;
-
-	if (WARN_ON(!gpdev))
-		return NULL;
-
-	/* Not all PCI devices have device-tree nodes */
-	if (!gpdev->dev.of_node)
-		return NULL;
-
-	/* Get assoicated PCI device */
-	dn = of_parse_phandle(gpdev->dev.of_node, "ibm,npu", index);
-	if (!dn)
-		return NULL;
-
-	npdev = get_pci_dev(dn);
-	of_node_put(dn);
-
-	return npdev;
-}
-EXPORT_SYMBOL(pnv_pci_get_npu_dev);
-
 /*
  * Returns the PE assoicated with the PCI device of the given
  * NPU. Returns the linked pci device if pci_dev != NULL.
@@ -340,13 +274,7 @@ static struct iommu_table_group_ops pnv_pci_npu_ops = {
 	.take_ownership = pnv_npu_take_ownership,
 	.release_ownership = pnv_npu_release_ownership,
 };
-#endif /* !CONFIG_IOMMU_API */
 
-/*
- * NPU2 ATS
- */
-/* Maximum possible number of ATSD MMIO registers per NPU */
-#define NV_NMMU_ATSD_REGS 8
 #define NV_NPU_MAX_PE_NUM	16
 
 /*
@@ -359,20 +287,6 @@ struct npu_comp {
 	struct pnv_ioda_pe *pe[NV_NPU_MAX_PE_NUM];
 };
 
-/* An NPU descriptor, valid for POWER9 only */
-struct npu {
-	int index;
-	__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
-	unsigned int mmio_atsd_count;
-
-	/* Bitmask for MMIO register usage */
-	unsigned long mmio_atsd_usage;
-
-	/* Do we need to explicitly flush the nest mmu? */
-	bool nmmu_flush;
-};
-
-#ifdef CONFIG_IOMMU_API
 static long pnv_npu_peers_create_table_userspace(
 		struct iommu_table_group *table_group,
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
@@ -631,582 +545,6 @@ struct iommu_table_group *pnv_npu_compound_attach(struct pnv_ioda_pe *pe)
 }
 #endif /* CONFIG_IOMMU_API */
 
-/* Maximum number of nvlinks per npu */
-#define NV_MAX_LINKS 6
-
-/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
-static int max_npu2_index;
-
-struct npu_context {
-	struct mm_struct *mm;
-	struct pci_dev *npdev[NV_MAX_NPUS][NV_MAX_LINKS];
-	struct mmu_notifier mn;
-	struct kref kref;
-	bool nmmu_flush;
-
-	/* Callback to stop translation requests on a given GPU */
-	void (*release_cb)(struct npu_context *context, void *priv);
-
-	/*
-	 * Private pointer passed to the above callback for usage by
-	 * device drivers.
-	 */
-	void *priv;
-};
-
-struct mmio_atsd_reg {
-	struct npu *npu;
-	int reg;
-};
-
-/*
- * Find a free MMIO ATSD register and mark it in use. Return -ENOSPC
- * if none are available.
- */
-static int get_mmio_atsd_reg(struct npu *npu)
-{
-	int i;
-
-	for (i = 0; i < npu->mmio_atsd_count; i++) {
-		if (!test_bit(i, &npu->mmio_atsd_usage))
-			if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
-				return i;
-	}
-
-	return -ENOSPC;
-}
-
-static void put_mmio_atsd_reg(struct npu *npu, int reg)
-{
-	clear_bit_unlock(reg, &npu->mmio_atsd_usage);
-}
-
-/* MMIO ATSD register offsets */
-#define XTS_ATSD_LAUNCH 0
-#define XTS_ATSD_AVA    1
-#define XTS_ATSD_STAT   2
-
-static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize)
-{
-	unsigned long launch = 0;
-
-	if (psize == MMU_PAGE_COUNT) {
-		/* IS set to invalidate entire matching PID */
-		launch |= PPC_BIT(12);
-	} else {
-		/* AP set to invalidate region of psize */
-		launch |= (u64)mmu_get_ap(psize) << PPC_BITLSHIFT(17);
-	}
-
-	/* PRS set to process-scoped */
-	launch |= PPC_BIT(13);
-
-	/* PID */
-	launch |= pid << PPC_BITLSHIFT(38);
-
-	/* Leave "No flush" (bit 39) 0 so every ATSD performs a flush */
-
-	return launch;
-}
-
-static void mmio_atsd_regs_write(struct mmio_atsd_reg
-			mmio_atsd_reg[NV_MAX_NPUS], unsigned long offset,
-			unsigned long val)
-{
-	struct npu *npu;
-	int i, reg;
-
-	for (i = 0; i <= max_npu2_index; i++) {
-		reg = mmio_atsd_reg[i].reg;
-		if (reg < 0)
-			continue;
-
-		npu = mmio_atsd_reg[i].npu;
-		__raw_writeq_be(val, npu->mmio_atsd_regs[reg] + offset);
-	}
-}
-
-static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
-				unsigned long pid)
-{
-	unsigned long launch = get_atsd_launch_val(pid, MMU_PAGE_COUNT);
-
-	/* Invalidating the entire process doesn't use a va */
-	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
-}
-
-static void mmio_invalidate_range(struct mmio_atsd_reg
-			mmio_atsd_reg[NV_MAX_NPUS], unsigned long pid,
-			unsigned long start, unsigned long psize)
-{
-	unsigned long launch = get_atsd_launch_val(pid, psize);
-
-	/* Write all VAs first */
-	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_AVA, start);
-
-	/* Issue one barrier for all address writes */
-	eieio();
-
-	/* Launch */
-	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
-}
-
-#define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
-
-static void mmio_invalidate_wait(
-	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
-{
-	struct npu *npu;
-	int i, reg;
-
-	/* Wait for all invalidations to complete */
-	for (i = 0; i <= max_npu2_index; i++) {
-		if (mmio_atsd_reg[i].reg < 0)
-			continue;
-
-		/* Wait for completion */
-		npu = mmio_atsd_reg[i].npu;
-		reg = mmio_atsd_reg[i].reg;
-		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
-			cpu_relax();
-	}
-}
-
-/*
- * Acquires all the address translation shootdown (ATSD) registers required to
- * launch an ATSD on all links this npu_context is active on.
- */
-static void acquire_atsd_reg(struct npu_context *npu_context,
-			struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
-{
-	int i, j;
-	struct npu *npu;
-	struct pci_dev *npdev;
-
-	for (i = 0; i <= max_npu2_index; i++) {
-		mmio_atsd_reg[i].reg = -1;
-		for (j = 0; j < NV_MAX_LINKS; j++) {
-			/*
-			 * There are no ordering requirements with respect to
-			 * the setup of struct npu_context, but to ensure
-			 * consistent behaviour we need to ensure npdev[][] is
-			 * only read once.
-			 */
-			npdev = READ_ONCE(npu_context->npdev[i][j]);
-			if (!npdev)
-				continue;
-
-			npu = pci_bus_to_host(npdev->bus)->npu;
-			if (!npu)
-				continue;
-
-			mmio_atsd_reg[i].npu = npu;
-			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
-			while (mmio_atsd_reg[i].reg < 0) {
-				mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
-				cpu_relax();
-			}
-			break;
-		}
-	}
-}
-
-/*
- * Release previously acquired ATSD registers. To avoid deadlocks the registers
- * must be released in the same order they were acquired above in
- * acquire_atsd_reg.
- */
-static void release_atsd_reg(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
-{
-	int i;
-
-	for (i = 0; i <= max_npu2_index; i++) {
-		/*
-		 * We can't rely on npu_context->npdev[][] being the same here
-		 * as when acquire_atsd_reg() was called, hence we use the
-		 * values stored in mmio_atsd_reg during the acquire phase
-		 * rather than re-reading npdev[][].
-		 */
-		if (mmio_atsd_reg[i].reg < 0)
-			continue;
-
-		put_mmio_atsd_reg(mmio_atsd_reg[i].npu, mmio_atsd_reg[i].reg);
-	}
-}
-
-/*
- * Invalidate a virtual address range
- */
-static void mmio_invalidate(struct npu_context *npu_context,
-			unsigned long start, unsigned long size)
-{
-	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
-	unsigned long pid = npu_context->mm->context.id;
-	unsigned long atsd_start = 0;
-	unsigned long end = start + size - 1;
-	int atsd_psize = MMU_PAGE_COUNT;
-
-	/*
-	 * Convert the input range into one of the supported sizes. If the range
-	 * doesn't fit, use the next larger supported size. Invalidation latency
-	 * is high, so over-invalidation is preferred to issuing multiple
-	 * invalidates.
-	 *
-	 * A 4K page size isn't supported by NPU/GPU ATS, so that case is
-	 * ignored.
-	 */
-	if (size == SZ_64K) {
-		atsd_start = start;
-		atsd_psize = MMU_PAGE_64K;
-	} else if (ALIGN_DOWN(start, SZ_2M) == ALIGN_DOWN(end, SZ_2M)) {
-		atsd_start = ALIGN_DOWN(start, SZ_2M);
-		atsd_psize = MMU_PAGE_2M;
-	} else if (ALIGN_DOWN(start, SZ_1G) == ALIGN_DOWN(end, SZ_1G)) {
-		atsd_start = ALIGN_DOWN(start, SZ_1G);
-		atsd_psize = MMU_PAGE_1G;
-	}
-
-	if (npu_context->nmmu_flush)
-		/*
-		 * Unfortunately the nest mmu does not support flushing specific
-		 * addresses so we have to flush the whole mm once before
-		 * shooting down the GPU translation.
-		 */
-		flush_all_mm(npu_context->mm);
-
-	/*
-	 * Loop over all the NPUs this process is active on and launch
-	 * an invalidate.
-	 */
-	acquire_atsd_reg(npu_context, mmio_atsd_reg);
-
-	if (atsd_psize == MMU_PAGE_COUNT)
-		mmio_invalidate_pid(mmio_atsd_reg, pid);
-	else
-		mmio_invalidate_range(mmio_atsd_reg, pid, atsd_start,
-					atsd_psize);
-
-	mmio_invalidate_wait(mmio_atsd_reg);
-
-	/*
-	 * The GPU requires two flush ATSDs to ensure all entries have been
-	 * flushed. We use PID 0 as it will never be used for a process on the
-	 * GPU.
-	 */
-	mmio_invalidate_pid(mmio_atsd_reg, 0);
-	mmio_invalidate_wait(mmio_atsd_reg);
-	mmio_invalidate_pid(mmio_atsd_reg, 0);
-	mmio_invalidate_wait(mmio_atsd_reg);
-
-	release_atsd_reg(mmio_atsd_reg);
-}
-
-static void pnv_npu2_mn_release(struct mmu_notifier *mn,
-				struct mm_struct *mm)
-{
-	struct npu_context *npu_context = mn_to_npu_context(mn);
-
-	/* Call into device driver to stop requests to the NMMU */
-	if (npu_context->release_cb)
-		npu_context->release_cb(npu_context, npu_context->priv);
-
-	/*
-	 * There should be no more translation requests for this PID, but we
-	 * need to ensure any entries for it are removed from the TLB.
-	 */
-	mmio_invalidate(npu_context, 0, ~0UL);
-}
-
-static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
-				struct mm_struct *mm,
-				unsigned long address,
-				pte_t pte)
-{
-	struct npu_context *npu_context = mn_to_npu_context(mn);
-	mmio_invalidate(npu_context, address, PAGE_SIZE);
-}
-
-static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
-					struct mm_struct *mm,
-					unsigned long start, unsigned long end)
-{
-	struct npu_context *npu_context = mn_to_npu_context(mn);
-	mmio_invalidate(npu_context, start, end - start);
-}
-
-static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
-	.release = pnv_npu2_mn_release,
-	.change_pte = pnv_npu2_mn_change_pte,
-	.invalidate_range = pnv_npu2_mn_invalidate_range,
-};
-
-/*
- * Call into OPAL to setup the nmmu context for the current task in
- * the NPU. This must be called to setup the context tables before the
- * GPU issues ATRs. pdev should be a pointed to PCIe GPU device.
- *
- * A release callback should be registered to allow a device driver to
- * be notified that it should not launch any new translation requests
- * as the final TLB invalidate is about to occur.
- *
- * Returns an error if there no contexts are currently available or a
- * npu_context which should be passed to pnv_npu2_handle_fault().
- *
- * mmap_sem must be held in write mode and must not be called from interrupt
- * context.
- */
-struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
-			unsigned long flags,
-			void (*cb)(struct npu_context *, void *),
-			void *priv)
-{
-	int rc;
-	u32 nvlink_index;
-	struct device_node *nvlink_dn;
-	struct mm_struct *mm = current->mm;
-	struct npu *npu;
-	struct npu_context *npu_context;
-	struct pci_controller *hose;
-
-	/*
-	 * At present we don't support GPUs connected to multiple NPUs and I'm
-	 * not sure the hardware does either.
-	 */
-	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
-
-	if (!npdev)
-		/* No nvlink associated with this GPU device */
-		return ERR_PTR(-ENODEV);
-
-	/* We only support DR/PR/HV in pnv_npu2_map_lpar_dev() */
-	if (flags & ~(MSR_DR | MSR_PR | MSR_HV))
-		return ERR_PTR(-EINVAL);
-
-	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
-	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
-							&nvlink_index)))
-		return ERR_PTR(-ENODEV);
-
-	if (!mm || mm->context.id == 0) {
-		/*
-		 * Kernel thread contexts are not supported and context id 0 is
-		 * reserved on the GPU.
-		 */
-		return ERR_PTR(-EINVAL);
-	}
-
-	hose = pci_bus_to_host(npdev->bus);
-	npu = hose->npu;
-	if (!npu)
-		return ERR_PTR(-ENODEV);
-
-	/*
-	 * We store the npu pci device so we can more easily get at the
-	 * associated npus.
-	 */
-	spin_lock(&npu_context_lock);
-	npu_context = mm->context.npu_context;
-	if (npu_context) {
-		if (npu_context->release_cb != cb ||
-			npu_context->priv != priv) {
-			spin_unlock(&npu_context_lock);
-			return ERR_PTR(-EINVAL);
-		}
-
-		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
-	}
-	spin_unlock(&npu_context_lock);
-
-	if (!npu_context) {
-		/*
-		 * We can set up these fields without holding the
-		 * npu_context_lock as the npu_context hasn't been returned to
-		 * the caller meaning it can't be destroyed. Parallel allocation
-		 * is protected against by mmap_sem.
-		 */
-		rc = -ENOMEM;
-		npu_context = kzalloc(sizeof(struct npu_context), GFP_KERNEL);
-		if (npu_context) {
-			kref_init(&npu_context->kref);
-			npu_context->mm = mm;
-			npu_context->mn.ops = &nv_nmmu_notifier_ops;
-			rc = __mmu_notifier_register(&npu_context->mn, mm);
-		}
-
-		if (rc) {
-			kfree(npu_context);
-			return ERR_PTR(rc);
-		}
-
-		mm->context.npu_context = npu_context;
-	}
-
-	npu_context->release_cb = cb;
-	npu_context->priv = priv;
-
-	/*
-	 * npdev is a pci_dev pointer setup by the PCI code. We assign it to
-	 * npdev[][] to indicate to the mmu notifiers that an invalidation
-	 * should also be sent over this nvlink. The notifiers don't use any
-	 * other fields in npu_context, so we just need to ensure that when they
-	 * deference npu_context->npdev[][] it is either a valid pointer or
-	 * NULL.
-	 */
-	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
-
-	if (!npu->nmmu_flush) {
-		/*
-		 * If we're not explicitly flushing ourselves we need to mark
-		 * the thread for global flushes
-		 */
-		npu_context->nmmu_flush = false;
-		mm_context_add_copro(mm);
-	} else
-		npu_context->nmmu_flush = true;
-
-	return npu_context;
-}
-EXPORT_SYMBOL(pnv_npu2_init_context);
-
-static void pnv_npu2_release_context(struct kref *kref)
-{
-	struct npu_context *npu_context =
-		container_of(kref, struct npu_context, kref);
-
-	if (!npu_context->nmmu_flush)
-		mm_context_remove_copro(npu_context->mm);
-
-	npu_context->mm->context.npu_context = NULL;
-}
-
-/*
- * Destroy a context on the given GPU. May free the npu_context if it is no
- * longer active on any GPUs. Must not be called from interrupt context.
- */
-void pnv_npu2_destroy_context(struct npu_context *npu_context,
-			struct pci_dev *gpdev)
-{
-	int removed;
-	struct npu *npu;
-	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
-	struct device_node *nvlink_dn;
-	u32 nvlink_index;
-	struct pci_controller *hose;
-
-	if (WARN_ON(!npdev))
-		return;
-
-	hose = pci_bus_to_host(npdev->bus);
-	npu = hose->npu;
-	if (!npu)
-		return;
-	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
-	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
-							&nvlink_index)))
-		return;
-	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
-	spin_lock(&npu_context_lock);
-	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
-	spin_unlock(&npu_context_lock);
-
-	/*
-	 * We need to do this outside of pnv_npu2_release_context so that it is
-	 * outside the spinlock as mmu_notifier_destroy uses SRCU.
-	 */
-	if (removed) {
-		mmu_notifier_unregister(&npu_context->mn,
-					npu_context->mm);
-
-		kfree(npu_context);
-	}
-
-}
-EXPORT_SYMBOL(pnv_npu2_destroy_context);
-
-/*
- * Assumes mmap_sem is held for the contexts associated mm.
- */
-int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
-			unsigned long *flags, unsigned long *status, int count)
-{
-	u64 rc = 0, result = 0;
-	int i, is_write;
-	struct page *page[1];
-	const char __user *u;
-	char c;
-
-	/* mmap_sem should be held so the struct_mm must be present */
-	struct mm_struct *mm = context->mm;
-
-	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
-
-	for (i = 0; i < count; i++) {
-		is_write = flags[i] & NPU2_WRITE;
-		rc = get_user_pages_remote(NULL, mm, ea[i], 1,
-					is_write ? FOLL_WRITE : 0,
-					page, NULL, NULL);
-
-		if (rc != 1) {
-			status[i] = rc;
-			result = -EFAULT;
-			continue;
-		}
-
-		/* Make sure partition scoped tree gets a pte */
-		u = page_address(page[0]);
-		if (__get_user(c, u))
-			result = -EFAULT;
-
-		status[i] = 0;
-		put_page(page[0]);
-	}
-
-	return result;
-}
-EXPORT_SYMBOL(pnv_npu2_handle_fault);
-
-int pnv_npu2_init(struct pci_controller *hose)
-{
-	unsigned int i;
-	u64 mmio_atsd;
-	static int npu_index;
-	struct npu *npu;
-	int ret;
-
-	npu = kzalloc(sizeof(*npu), GFP_KERNEL);
-	if (!npu)
-		return -ENOMEM;
-
-	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
-
-	for (i = 0; i < ARRAY_SIZE(npu->mmio_atsd_regs) &&
-			!of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
-				i, &mmio_atsd); i++)
-		npu->mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
-
-	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
-	npu->mmio_atsd_count = i;
-	npu->mmio_atsd_usage = 0;
-	npu_index++;
-	if (WARN_ON(npu_index >= NV_MAX_NPUS)) {
-		ret = -ENOSPC;
-		goto fail_exit;
-	}
-	max_npu2_index = npu_index;
-	npu->index = npu_index;
-	hose->npu = npu;
-
-	return 0;
-
-fail_exit:
-	for (i = 0; i < npu->mmio_atsd_count; ++i)
-		iounmap(npu->mmio_atsd_regs[i]);
-
-	kfree(npu);
-
-	return ret;
-}
-
 int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
 		unsigned long msr)
 {
diff --git a/arch/powerpc/sysdev/npu.c b/arch/powerpc/sysdev/npu.c
new file mode 100644
index 0000000..72755b2
--- /dev/null
+++ b/arch/powerpc/sysdev/npu.c
@@ -0,0 +1,677 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This file implements the context manipulation for NVLink devices.
+ *
+ * Copyright IBM Corporation 2019.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * Copied from original arch/powerpc/platforms/powernv/npu-dma.c:
+ * Copyright Alistair Popple, IBM Corporation 2015.
+ */
+
+#include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
+#include <linux/pci.h>
+
+/*
+ * NPU2 ATS
+ */
+/* Maximum possible number of ATSD MMIO registers per NPU */
+#define NV_NMMU_ATSD_REGS 8
+
+/* An NPU descriptor, valid for POWER9 only */
+struct npu {
+	int index;
+	__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
+	unsigned int mmio_atsd_count;
+
+	/* Bitmask for MMIO register usage */
+	unsigned long mmio_atsd_usage;
+
+	/* Do we need to explicitly flush the nest mmu? */
+	bool nmmu_flush;
+};
+
+/*
+ * spinlock to protect initialisation of an npu_context for a particular
+ * mm_struct.
+ */
+static DEFINE_SPINLOCK(npu_context_lock);
+
+static struct pci_dev *get_pci_dev(struct device_node *dn)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
+					   pdn->busno, pdn->devfn);
+}
+
+/* Given a NPU device get the associated PCI device. */
+struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev)
+{
+	struct device_node *dn;
+	struct pci_dev *gpdev;
+
+	if (WARN_ON(!npdev))
+		return NULL;
+
+	if (WARN_ON(!npdev->dev.of_node))
+		return NULL;
+
+	/* Get assoicated PCI device */
+	dn = of_parse_phandle(npdev->dev.of_node, "ibm,gpu", 0);
+	if (!dn)
+		return NULL;
+
+	gpdev = get_pci_dev(dn);
+	of_node_put(dn);
+
+	return gpdev;
+}
+EXPORT_SYMBOL(pnv_pci_get_gpu_dev);
+
+/* Given the real PCI device get a linked NPU device. */
+struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
+{
+	struct device_node *dn;
+	struct pci_dev *npdev;
+
+	if (WARN_ON(!gpdev))
+		return NULL;
+
+	/* Not all PCI devices have device-tree nodes */
+	if (!gpdev->dev.of_node)
+		return NULL;
+
+	/* Get assoicated PCI device */
+	dn = of_parse_phandle(gpdev->dev.of_node, "ibm,npu", index);
+	if (!dn)
+		return NULL;
+
+	npdev = get_pci_dev(dn);
+	of_node_put(dn);
+
+	return npdev;
+}
+EXPORT_SYMBOL(pnv_pci_get_npu_dev);
+
+/* Maximum number of nvlinks per npu */
+#define NV_MAX_LINKS 6
+
+/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
+static int max_npu2_index;
+
+struct npu_context {
+	struct mm_struct *mm;
+	struct pci_dev *npdev[NV_MAX_NPUS][NV_MAX_LINKS];
+	struct mmu_notifier mn;
+	struct kref kref;
+	bool nmmu_flush;
+
+	/* Callback to stop translation requests on a given GPU */
+	void (*release_cb)(struct npu_context *context, void *priv);
+
+	/*
+	 * Private pointer passed to the above callback for usage by
+	 * device drivers.
+	 */
+	void *priv;
+};
+
+struct mmio_atsd_reg {
+	struct npu *npu;
+	int reg;
+};
+
+/*
+ * Find a free MMIO ATSD register and mark it in use. Return -ENOSPC
+ * if none are available.
+ */
+static int get_mmio_atsd_reg(struct npu *npu)
+{
+	int i;
+
+	for (i = 0; i < npu->mmio_atsd_count; i++) {
+		if (!test_bit(i, &npu->mmio_atsd_usage))
+			if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
+				return i;
+	}
+
+	return -ENOSPC;
+}
+
+static void put_mmio_atsd_reg(struct npu *npu, int reg)
+{
+	clear_bit_unlock(reg, &npu->mmio_atsd_usage);
+}
+
+/* MMIO ATSD register offsets */
+#define XTS_ATSD_LAUNCH 0
+#define XTS_ATSD_AVA    1
+#define XTS_ATSD_STAT   2
+
+static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize)
+{
+	unsigned long launch = 0;
+
+	if (psize == MMU_PAGE_COUNT) {
+		/* IS set to invalidate entire matching PID */
+		launch |= PPC_BIT(12);
+	} else {
+		/* AP set to invalidate region of psize */
+		launch |= (u64)mmu_get_ap(psize) << PPC_BITLSHIFT(17);
+	}
+
+	/* PRS set to process-scoped */
+	launch |= PPC_BIT(13);
+
+	/* PID */
+	launch |= pid << PPC_BITLSHIFT(38);
+
+	/* Leave "No flush" (bit 39) 0 so every ATSD performs a flush */
+
+	return launch;
+}
+
+static void mmio_atsd_regs_write(struct mmio_atsd_reg
+			mmio_atsd_reg[NV_MAX_NPUS], unsigned long offset,
+			unsigned long val)
+{
+	struct npu *npu;
+	int i, reg;
+
+	for (i = 0; i <= max_npu2_index; i++) {
+		reg = mmio_atsd_reg[i].reg;
+		if (reg < 0)
+			continue;
+
+		npu = mmio_atsd_reg[i].npu;
+		__raw_writeq_be(val, npu->mmio_atsd_regs[reg] + offset);
+	}
+}
+
+static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
+				unsigned long pid)
+{
+	unsigned long launch = get_atsd_launch_val(pid, MMU_PAGE_COUNT);
+
+	/* Invalidating the entire process doesn't use a va */
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
+}
+
+static void mmio_invalidate_range(struct mmio_atsd_reg
+			mmio_atsd_reg[NV_MAX_NPUS], unsigned long pid,
+			unsigned long start, unsigned long psize)
+{
+	unsigned long launch = get_atsd_launch_val(pid, psize);
+
+	/* Write all VAs first */
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_AVA, start);
+
+	/* Issue one barrier for all address writes */
+	eieio();
+
+	/* Launch */
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
+}
+
+#define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
+
+static void mmio_invalidate_wait(
+	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
+{
+	struct npu *npu;
+	int i, reg;
+
+	/* Wait for all invalidations to complete */
+	for (i = 0; i <= max_npu2_index; i++) {
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
+
+		/* Wait for completion */
+		npu = mmio_atsd_reg[i].npu;
+		reg = mmio_atsd_reg[i].reg;
+		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
+			cpu_relax();
+	}
+}
+
+/*
+ * Acquires all the address translation shootdown (ATSD) registers required to
+ * launch an ATSD on all links this npu_context is active on.
+ */
+static void acquire_atsd_reg(struct npu_context *npu_context,
+			struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
+{
+	int i, j;
+	struct npu *npu;
+	struct pci_dev *npdev;
+
+	for (i = 0; i <= max_npu2_index; i++) {
+		mmio_atsd_reg[i].reg = -1;
+		for (j = 0; j < NV_MAX_LINKS; j++) {
+			/*
+			 * There are no ordering requirements with respect to
+			 * the setup of struct npu_context, but to ensure
+			 * consistent behaviour we need to ensure npdev[][] is
+			 * only read once.
+			 */
+			npdev = READ_ONCE(npu_context->npdev[i][j]);
+			if (!npdev)
+				continue;
+
+			npu = pci_bus_to_host(npdev->bus)->npu;
+			if (!npu)
+				continue;
+
+			mmio_atsd_reg[i].npu = npu;
+			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
+			while (mmio_atsd_reg[i].reg < 0) {
+				mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
+				cpu_relax();
+			}
+			break;
+		}
+	}
+}
+
+/*
+ * Release previously acquired ATSD registers. To avoid deadlocks the registers
+ * must be released in the same order they were acquired above in
+ * acquire_atsd_reg.
+ */
+static void release_atsd_reg(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
+{
+	int i;
+
+	for (i = 0; i <= max_npu2_index; i++) {
+		/*
+		 * We can't rely on npu_context->npdev[][] being the same here
+		 * as when acquire_atsd_reg() was called, hence we use the
+		 * values stored in mmio_atsd_reg during the acquire phase
+		 * rather than re-reading npdev[][].
+		 */
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
+
+		put_mmio_atsd_reg(mmio_atsd_reg[i].npu, mmio_atsd_reg[i].reg);
+	}
+}
+
+/*
+ * Invalidate a virtual address range
+ */
+static void mmio_invalidate(struct npu_context *npu_context,
+			unsigned long start, unsigned long size)
+{
+	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
+	unsigned long pid = npu_context->mm->context.id;
+	unsigned long atsd_start = 0;
+	unsigned long end = start + size - 1;
+	int atsd_psize = MMU_PAGE_COUNT;
+
+	/*
+	 * Convert the input range into one of the supported sizes. If the range
+	 * doesn't fit, use the next larger supported size. Invalidation latency
+	 * is high, so over-invalidation is preferred to issuing multiple
+	 * invalidates.
+	 *
+	 * A 4K page size isn't supported by NPU/GPU ATS, so that case is
+	 * ignored.
+	 */
+	if (size == SZ_64K) {
+		atsd_start = start;
+		atsd_psize = MMU_PAGE_64K;
+	} else if (ALIGN_DOWN(start, SZ_2M) == ALIGN_DOWN(end, SZ_2M)) {
+		atsd_start = ALIGN_DOWN(start, SZ_2M);
+		atsd_psize = MMU_PAGE_2M;
+	} else if (ALIGN_DOWN(start, SZ_1G) == ALIGN_DOWN(end, SZ_1G)) {
+		atsd_start = ALIGN_DOWN(start, SZ_1G);
+		atsd_psize = MMU_PAGE_1G;
+	}
+
+	if (npu_context->nmmu_flush)
+		/*
+		 * Unfortunately the nest mmu does not support flushing specific
+		 * addresses so we have to flush the whole mm once before
+		 * shooting down the GPU translation.
+		 */
+		flush_all_mm(npu_context->mm);
+
+	/*
+	 * Loop over all the NPUs this process is active on and launch
+	 * an invalidate.
+	 */
+	acquire_atsd_reg(npu_context, mmio_atsd_reg);
+
+	if (atsd_psize == MMU_PAGE_COUNT)
+		mmio_invalidate_pid(mmio_atsd_reg, pid);
+	else
+		mmio_invalidate_range(mmio_atsd_reg, pid, atsd_start,
+					atsd_psize);
+
+	mmio_invalidate_wait(mmio_atsd_reg);
+
+	/*
+	 * The GPU requires two flush ATSDs to ensure all entries have been
+	 * flushed. We use PID 0 as it will never be used for a process on the
+	 * GPU.
+	 */
+	mmio_invalidate_pid(mmio_atsd_reg, 0);
+	mmio_invalidate_wait(mmio_atsd_reg);
+	mmio_invalidate_pid(mmio_atsd_reg, 0);
+	mmio_invalidate_wait(mmio_atsd_reg);
+
+	release_atsd_reg(mmio_atsd_reg);
+}
+
+static void pnv_npu2_mn_release(struct mmu_notifier *mn,
+				struct mm_struct *mm)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+
+	/* Call into device driver to stop requests to the NMMU */
+	if (npu_context->release_cb)
+		npu_context->release_cb(npu_context, npu_context->priv);
+
+	/*
+	 * There should be no more translation requests for this PID, but we
+	 * need to ensure any entries for it are removed from the TLB.
+	 */
+	mmio_invalidate(npu_context, 0, ~0UL);
+}
+
+static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
+				struct mm_struct *mm,
+				unsigned long address,
+				pte_t pte)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+
+	mmio_invalidate(npu_context, address, PAGE_SIZE);
+}
+
+static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
+					struct mm_struct *mm,
+					unsigned long start, unsigned long end)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+
+	mmio_invalidate(npu_context, start, end - start);
+}
+
+static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
+	.release = pnv_npu2_mn_release,
+	.change_pte = pnv_npu2_mn_change_pte,
+	.invalidate_range = pnv_npu2_mn_invalidate_range,
+};
+
+/*
+ * Call into OPAL to setup the nmmu context for the current task in
+ * the NPU. This must be called to setup the context tables before the
+ * GPU issues ATRs. pdev should be a pointed to PCIe GPU device.
+ *
+ * A release callback should be registered to allow a device driver to
+ * be notified that it should not launch any new translation requests
+ * as the final TLB invalidate is about to occur.
+ *
+ * Returns an error if there no contexts are currently available or a
+ * npu_context which should be passed to pnv_npu2_handle_fault().
+ *
+ * mmap_sem must be held in write mode and must not be called from interrupt
+ * context.
+ */
+struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
+			unsigned long flags,
+			void (*cb)(struct npu_context *, void *),
+			void *priv)
+{
+	int rc;
+	u32 nvlink_index;
+	struct device_node *nvlink_dn;
+	struct mm_struct *mm = current->mm;
+	struct npu *npu;
+	struct npu_context *npu_context;
+	struct pci_controller *hose;
+
+	/*
+	 * At present we don't support GPUs connected to multiple NPUs and I'm
+	 * not sure the hardware does either.
+	 */
+	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
+
+	if (!npdev)
+		/* No nvlink associated with this GPU device */
+		return ERR_PTR(-ENODEV);
+
+	/* We only support DR/PR/HV in pnv_npu2_map_lpar_dev() */
+	if (flags & ~(MSR_DR | MSR_PR | MSR_HV))
+		return ERR_PTR(-EINVAL);
+
+	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
+	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
+							&nvlink_index)))
+		return ERR_PTR(-ENODEV);
+
+	if (!mm || mm->context.id == 0) {
+		/*
+		 * Kernel thread contexts are not supported and context id 0 is
+		 * reserved on the GPU.
+		 */
+		return ERR_PTR(-EINVAL);
+	}
+
+	hose = pci_bus_to_host(npdev->bus);
+	npu = hose->npu;
+	if (!npu)
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * We store the npu pci device so we can more easily get at the
+	 * associated npus.
+	 */
+	spin_lock(&npu_context_lock);
+	npu_context = mm->context.npu_context;
+	if (npu_context) {
+		if (npu_context->release_cb != cb ||
+			npu_context->priv != priv) {
+			spin_unlock(&npu_context_lock);
+			return ERR_PTR(-EINVAL);
+		}
+
+		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
+	}
+	spin_unlock(&npu_context_lock);
+
+	if (!npu_context) {
+		/*
+		 * We can set up these fields without holding the
+		 * npu_context_lock as the npu_context hasn't been returned to
+		 * the caller meaning it can't be destroyed. Parallel allocation
+		 * is protected against by mmap_sem.
+		 */
+		rc = -ENOMEM;
+		npu_context = kzalloc(sizeof(struct npu_context), GFP_KERNEL);
+		if (npu_context) {
+			kref_init(&npu_context->kref);
+			npu_context->mm = mm;
+			npu_context->mn.ops = &nv_nmmu_notifier_ops;
+			rc = __mmu_notifier_register(&npu_context->mn, mm);
+		}
+
+		if (rc) {
+			kfree(npu_context);
+			return ERR_PTR(rc);
+		}
+
+		mm->context.npu_context = npu_context;
+	}
+
+	npu_context->release_cb = cb;
+	npu_context->priv = priv;
+
+	/*
+	 * npdev is a pci_dev pointer setup by the PCI code. We assign it to
+	 * npdev[][] to indicate to the mmu notifiers that an invalidation
+	 * should also be sent over this nvlink. The notifiers don't use any
+	 * other fields in npu_context, so we just need to ensure that when they
+	 * deference npu_context->npdev[][] it is either a valid pointer or
+	 * NULL.
+	 */
+	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
+
+	if (!npu->nmmu_flush) {
+		/*
+		 * If we're not explicitly flushing ourselves we need to mark
+		 * the thread for global flushes
+		 */
+		npu_context->nmmu_flush = false;
+		mm_context_add_copro(mm);
+	} else
+		npu_context->nmmu_flush = true;
+
+	return npu_context;
+}
+EXPORT_SYMBOL(pnv_npu2_init_context);
+
+static void pnv_npu2_release_context(struct kref *kref)
+{
+	struct npu_context *npu_context =
+		container_of(kref, struct npu_context, kref);
+
+	if (!npu_context->nmmu_flush)
+		mm_context_remove_copro(npu_context->mm);
+
+	npu_context->mm->context.npu_context = NULL;
+}
+
+/*
+ * Destroy a context on the given GPU. May free the npu_context if it is no
+ * longer active on any GPUs. Must not be called from interrupt context.
+ */
+void pnv_npu2_destroy_context(struct npu_context *npu_context,
+			struct pci_dev *gpdev)
+{
+	int removed;
+	struct npu *npu;
+	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
+	struct device_node *nvlink_dn;
+	u32 nvlink_index;
+	struct pci_controller *hose;
+
+	if (WARN_ON(!npdev))
+		return;
+
+	hose = pci_bus_to_host(npdev->bus);
+	npu = hose->npu;
+	if (!npu)
+		return;
+	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
+	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
+							&nvlink_index)))
+		return;
+	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
+	spin_lock(&npu_context_lock);
+	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
+	spin_unlock(&npu_context_lock);
+
+	/*
+	 * We need to do this outside of pnv_npu2_release_context so that it is
+	 * outside the spinlock as mmu_notifier_destroy uses SRCU.
+	 */
+	if (removed) {
+		mmu_notifier_unregister(&npu_context->mn,
+					npu_context->mm);
+
+		kfree(npu_context);
+	}
+
+}
+EXPORT_SYMBOL(pnv_npu2_destroy_context);
+
+/*
+ * Assumes mmap_sem is held for the contexts associated mm.
+ */
+int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
+			unsigned long *flags, unsigned long *status, int count)
+{
+	u64 rc = 0, result = 0;
+	int i, is_write;
+	struct page *page[1];
+	const char __user *u;
+	char c;
+
+	/* mmap_sem should be held so the struct_mm must be present */
+	struct mm_struct *mm = context->mm;
+
+	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
+
+	for (i = 0; i < count; i++) {
+		is_write = flags[i] & NPU2_WRITE;
+		rc = get_user_pages_remote(NULL, mm, ea[i], 1,
+					is_write ? FOLL_WRITE : 0,
+					page, NULL, NULL);
+
+		if (rc != 1) {
+			status[i] = rc;
+			result = -EFAULT;
+			continue;
+		}
+
+		/* Make sure partition scoped tree gets a pte */
+		u = page_address(page[0]);
+		if (__get_user(c, u))
+			result = -EFAULT;
+
+		status[i] = 0;
+		put_page(page[0]);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(pnv_npu2_handle_fault);
+
+int pnv_npu2_init(struct pci_controller *hose)
+{
+	unsigned int i;
+	u64 mmio_atsd;
+	static int npu_index;
+	struct npu *npu;
+	int ret;
+
+	npu = kzalloc(sizeof(*npu), GFP_KERNEL);
+	if (!npu)
+		return -ENOMEM;
+
+	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
+
+	for (i = 0; i < ARRAY_SIZE(npu->mmio_atsd_regs) &&
+			!of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
+				i, &mmio_atsd); i++)
+		npu->mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
+
+	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
+	npu->mmio_atsd_count = i;
+	npu->mmio_atsd_usage = 0;
+	npu_index++;
+	if (WARN_ON(npu_index >= NV_MAX_NPUS)) {
+		ret = -ENOSPC;
+		goto fail_exit;
+	}
+	max_npu2_index = npu_index;
+	npu->index = npu_index;
+	hose->npu = npu;
+
+	return 0;
+
+fail_exit:
+	for (i = 0; i < npu->mmio_atsd_count; ++i)
+		iounmap(npu->mmio_atsd_regs[i]);
+
+	kfree(npu);
+
+	return ret;
+}
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index e0dbec7..e25e1bb 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -42,3 +42,6 @@ config FSL_CORENET_RCPM
 	bool
 	help
 	  This option enables support for RCPM (Run Control/Power Management).
+
+config PPC_NPU
+	def_bool y if (PPC_POWERNV || PPC_PSERIES) && PPC_RADIX_MMU
-- 
2.17.1

