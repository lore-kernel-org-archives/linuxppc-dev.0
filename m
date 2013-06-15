Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 772BC2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:03:41 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 03:03:39 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B2A15C90026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:35 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93aa4321356
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:36 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93YDi009485
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:35 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 21/27] powerpc/eeh: Process interrupts caused by EEH
Date: Sat, 15 Jun 2013 17:03:12 +0800
Message-Id: <1371286998-2842-22-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, the EEH event is produced either by detect
on accessing config or I/O registers, or by interrupts dedicated
for EEH report. The patch adds support to process the interrupts
dedicated for EEH report.

Firstly, the kernel thread will be waken up to process incoming
interrupt. The PHBs will be scanned one by one to process all
existing EEH errors. Besides, There're mulple EEH errors that can
be reported from interrupts and we have differentiated actions
against them:

- If the IOC is dead, all PCI buses under all PHBs will be removed
  from the system.
- If the PHB is dead, all PCI buses under the PHB will be removed
  from the system.
- If the PHB is fenced, EEH event will be sent to EEH core and
  the fenced PHB is expected to be resetted completely.
- If specific PE has been put into frozen state, EEH event will
  be sent to EEH core so that the PE will be resetted.
- If the error is informational one, we just output the related
  registers for debugging purpose and no more action will be
  taken.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h           |    1 +
 arch/powerpc/kernel/eeh_driver.c         |   10 +
 arch/powerpc/platforms/powernv/Makefile  |    2 +-
 arch/powerpc/platforms/powernv/pci-err.c |  519 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h     |    1 +
 5 files changed, 532 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pci-err.c

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7ebf522..b52d8d7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -52,6 +52,7 @@ struct device_node;
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
+#define EEH_PE_PHB_DEAD		(1 << 2)	/* Dead PHB		*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0acc5a2..c7e13b0 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -439,6 +439,15 @@ void eeh_handle_event(struct eeh_pe *pe)
 	 */
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 
+	/*
+	 * On PowerNV platform, the PHB might have been dead. We need
+	 * remove all subordinate PCI buses under the dead PHB.
+	 */
+	if (eeh_probe_mode_dev() &&
+	    (pe->type & EEH_PE_PHB) &&
+	    (pe->state & EEH_PE_PHB_DEAD))
+		goto remove_bus;
+
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 3 seconds for certain systems.
 	 */
@@ -542,6 +551,7 @@ hard_fail:
 perm_error:
 	eeh_slot_error_detail(pe, EEH_LOG_PERM);
 
+remove_bus:
 	/* Notify all devices that they're about to go down. */
 	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
 
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 7fe5951..912fa7c 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -3,4 +3,4 @@ obj-y			+= opal-rtc.o opal-nvram.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
-obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_EEH)	+= pci-err.o eeh-ioda.o eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/pci-err.c b/arch/powerpc/platforms/powernv/pci-err.c
new file mode 100644
index 0000000..e54135b
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/pci-err.c
@@ -0,0 +1,519 @@
+/*
+ * The file instends to handle those interrupts dedicated for error
+ * detection from IOC chips. Currently, we only support P7IOC and
+ * need support more IOC chips in the future. The interrupts have
+ * been exported to hypervisor through "opal-interrupts" of "ibm,opal"
+ * OF node. When one of them comes in, the hypervisor simply turns
+ * to the firmware and expects the appropriate events returned. In
+ * turn, we will format one message and queue that in order to process
+ * it at later point.
+ *
+ * On the other hand, we need maintain information about the states
+ * of IO HUBs and their associated PHBs. The information would be
+ * shared by hypervisor and guests in future. While hypervisor or guests
+ * accessing IO HUBs, PHBs and PEs, the state should be checked and
+ * return approriate results. That would benefit EEH RTAS emulation in
+ * hypervisor as well.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2013.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/semaphore.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/kthread.h>
+#include <linux/msi.h>
+
+#include <asm/firmware.h>
+#include <asm/sections.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/msi_bitmap.h>
+#include <asm/ppc-pci.h>
+#include <asm/opal.h>
+#include <asm/iommu.h>
+#include <asm/tce.h>
+#include <asm/eeh_event.h>
+#include <asm/eeh.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+/* Debugging option */
+#ifdef PCI_ERR_DEBUG_ON
+#define PCI_ERR_DBG(args...)	pr_info(args)
+#else
+#define PCI_ERR_DBG(args...)
+#endif
+
+static struct task_struct *pci_err_thread;
+static struct semaphore pci_err_int_sem;
+static char *pci_err_diag;
+
+static int pci_err_dead_phb(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct eeh_pe *phb_pe;
+	unsigned long flags;
+
+	if (phb->removed)
+		return 0;
+
+	/* Find the PHB PE */
+	phb_pe = eeh_phb_pe_get(hose);
+	if (!phb_pe) {
+		pr_debug("%s Can't find PE for PHB#%d\n",
+			 __func__, hose->global_number);
+		return -EEXIST;
+	}
+	PCI_ERR_DBG("PCI_ERR: PHB#%d PE found\n",
+		hose->global_number);
+
+	/*
+	 * Mark the PHB has been dead and the EEH core
+	 * should remove all subordinate PCI buses.
+	 */
+	eeh_serialize_lock(&flags);
+	phb->removed = 1;
+	if (phb_pe->state & EEH_PE_PHB_DEAD) {
+		eeh_serialize_unlock(flags);
+		return 0;
+	}
+
+	PCI_ERR_DBG("PCI_ERR: Mark PHB#%x dead and send event "
+		    "to EEH core\n", hose->global_number);
+	eeh_pe_state_mark(phb_pe, EEH_PE_PHB_DEAD);
+	eeh_serialize_unlock(flags);
+	eeh_send_failure_event(phb_pe);
+
+	return 0;
+}
+
+static int pci_err_dead_ioc(void)
+{
+	struct pci_controller *hose, *tmp;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
+		pci_err_dead_phb(hose);
+
+	return 0;
+}
+
+/*
+ * When we get global interrupts (e.g. P7IOC RGC), PCI error happens
+ * in critical component of the IOC or PHB. For the formal case, the
+ * firmware just returns OPAL_PCI_ERR_CLASS_HUB and we needn't proceed.
+ * For the late case, we probably need reset one particular PHB. For
+ * that, we're doing is to send EEH event to the toppset PE of that
+ * problematic PHB so that the PHB can be reset by the EEH core.
+ */
+static int pci_err_check_phb(struct pci_controller *hose)
+{
+	struct eeh_pe *phb_pe;
+	unsigned long flags;
+
+	/* Find the PHB PE */
+	phb_pe = eeh_phb_pe_get(hose);
+	if (!phb_pe) {
+		pr_debug("%s Can't find PE for PHB#%d\n",
+			__func__, hose->global_number);
+		return -EEXIST;
+	}
+	PCI_ERR_DBG("PCI_ERR: PHB#%d PE found\n",
+		hose->global_number);
+
+	/* Send event if possible */
+	eeh_serialize_lock(&flags);
+	if (phb_pe->state & EEH_PE_ISOLATED) {
+		eeh_serialize_unlock(flags);
+		return 0;
+	}
+
+	PCI_ERR_DBG("PCI_ERR: Fence PHB#%x and send event "
+		    "to EEH core\n", hose->global_number);
+	eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
+	eeh_serialize_unlock(flags);
+
+	WARN(1, "EEH: PHB failure detected\n");
+	eeh_send_failure_event(phb_pe);
+
+	return 0;
+}
+
+/*
+ * When we get interrupts from PHB, there are probablly some PEs that
+ * have been put into frozen state. What we need do is sent one message
+ * to the EEH device, no matter which one it is, so that the EEH core
+ * can check it out and do PE reset accordingly.
+ */
+static int pci_err_check_pe(struct pci_controller *hose, u16 pe_no)
+{
+	struct eeh_pe *phb_pe, *pe;
+	struct eeh_dev dev, *edev;
+
+	/* Find the PHB PE */
+	phb_pe = eeh_phb_pe_get(hose);
+	if (!phb_pe) {
+		pr_warning("%s Can't find PE for PHB#%d\n",
+			__func__, hose->global_number);
+		return -EEXIST;
+	}
+	PCI_ERR_DBG("PCI_ERR: PHB#%d PE found\n",
+		hose->global_number);
+
+	/*
+	 * If the PHB has been put into fenced state, we
+	 * needn't send the duplicate event because the
+	 * whole PHB is going to take reset.
+	 */
+	if (phb_pe->state & EEH_PE_ISOLATED)
+		return 0;
+
+	/* Find the PE according to PE# */
+	memset(&dev, 0, sizeof(struct eeh_dev));
+	dev.phb = hose;
+	dev.pe_config_addr = pe_no;
+	pe = eeh_pe_get(&dev);
+	if (!pe) {
+		pr_debug("%s: Can't find PE for PHB#%x - PE#%x\n",
+			__func__, hose->global_number, pe_no);
+		return -EEXIST;
+	}
+	PCI_ERR_DBG("PCI_ERR: PE (%x) found for PHB#%x - PE#%x\n",
+		pe->addr, hose->global_number, pe_no);
+
+	/*
+	 * It doesn't matter which EEH device to get
+	 * the message. Just pick up the one on the
+	 * toppest position.
+	 */
+	edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
+	if (!edev) {
+		pr_err("%s: No EEH devices hooked on PHB#%x - PE#%x\n",
+			__func__, hose->global_number, pe_no);
+		return -EEXIST;
+	}
+	PCI_ERR_DBG("PCI_ERR: First EEH device found on PHB#%x - PE#%x\n",
+		hose->global_number, pe_no);
+
+	eeh_dev_check_failure(edev);
+
+	return 0;
+}
+
+static void pci_err_hub_diag_common(struct OpalIoP7IOCErrorData *data)
+{
+	/* GEM */
+	pr_info("  GEM XFIR:        %016llx\n", data->gemXfir);
+	pr_info("  GEM RFIR:        %016llx\n", data->gemRfir);
+	pr_info("  GEM RIRQFIR:     %016llx\n", data->gemRirqfir);
+	pr_info("  GEM Mask:        %016llx\n", data->gemMask);
+	pr_info("  GEM RWOF:        %016llx\n", data->gemRwof);
+
+	/* LEM */
+	pr_info("  LEM FIR:         %016llx\n", data->lemFir);
+	pr_info("  LEM Error Mask:  %016llx\n", data->lemErrMask);
+	pr_info("  LEM Action 0:    %016llx\n", data->lemAction0);
+	pr_info("  LEM Action 1:    %016llx\n", data->lemAction1);
+	pr_info("  LEM WOF:         %016llx\n", data->lemWof);
+}
+
+static void pci_err_hub_diag_data(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct OpalIoP7IOCErrorData *data;
+	long ret;
+
+	data = (struct OpalIoP7IOCErrorData *)pci_err_diag;
+	ret = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
+	if (ret != OPAL_SUCCESS) {
+		pr_warning("%s: Failed to get HUB#%llx diag-data, ret=%ld\n",
+			__func__, phb->hub_id, ret);
+		return;
+	}
+
+	/* Check the error type */
+	if (data->type <= OPAL_P7IOC_DIAG_TYPE_NONE ||
+	    data->type >= OPAL_P7IOC_DIAG_TYPE_LAST) {
+		pr_warning("%s: Invalid type of HUB#%llx diag-data (%d)\n",
+			__func__, phb->hub_id, data->type);
+		return;
+	}
+
+	switch (data->type) {
+	case OPAL_P7IOC_DIAG_TYPE_RGC:
+		pr_info("P7IOC diag-data for RGC\n\n");
+		pci_err_hub_diag_common(data);
+		pr_info("  RGC Status:      %016llx\n", data->rgc.rgcStatus);
+		pr_info("  RGC LDCP:        %016llx\n", data->rgc.rgcLdcp);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_BI:
+		pr_info("P7IOC diag-data for BI %s\n\n",
+			data->bi.biDownbound ? "Downbound" : "Upbound");
+		pci_err_hub_diag_common(data);
+		pr_info("  BI LDCP 0:       %016llx\n", data->bi.biLdcp0);
+		pr_info("  BI LDCP 1:       %016llx\n", data->bi.biLdcp1);
+		pr_info("  BI LDCP 2:       %016llx\n", data->bi.biLdcp2);
+		pr_info("  BI Fence Status: %016llx\n", data->bi.biFenceStatus);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_CI:
+		pr_info("P7IOC diag-data for CI Port %d\\nn",
+			data->ci.ciPort);
+		pci_err_hub_diag_common(data);
+		pr_info("  CI Port Status:  %016llx\n", data->ci.ciPortStatus);
+		pr_info("  CI Port LDCP:    %016llx\n", data->ci.ciPortLdcp);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_MISC:
+		pr_info("P7IOC diag-data for MISC\n\n");
+		pci_err_hub_diag_common(data);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_I2C:
+		pr_info("P7IOC diag-data for I2C\n\n");
+		pci_err_hub_diag_common(data);
+		break;
+	}
+}
+
+static void pci_err_phb_p7ioc_diag(struct pci_controller *hose,
+				   struct OpalIoPhbErrorCommon *common)
+{
+	struct OpalIoP7IOCPhbErrorData *data;
+	int i;
+
+	data = (struct OpalIoP7IOCPhbErrorData *)common;
+
+	pr_info("P7IOC PHB#%x Diag-data (Version: %d)\n\n",
+		hose->global_number, common->version);
+
+	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
+
+	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
+	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
+	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
+
+	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
+	pr_info("  slotStatus:           %08x\n", data->slotStatus);
+	pr_info("  linkStatus:           %08x\n", data->linkStatus);
+	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
+	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
+
+	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
+	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
+	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
+	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
+	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
+	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
+	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
+	pr_info("  sourceId:             %08x\n", data->sourceId);
+
+	pr_info("  errorClass:           %016llx\n", data->errorClass);
+	pr_info("  correlator:           %016llx\n", data->correlator);
+	pr_info("  p7iocPlssr:           %016llx\n", data->p7iocPlssr);
+	pr_info("  p7iocCsr:             %016llx\n", data->p7iocCsr);
+	pr_info("  lemFir:               %016llx\n", data->lemFir);
+	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
+	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
+	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
+	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
+	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
+	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
+	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
+	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
+	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
+	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
+	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
+	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
+	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
+	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
+	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
+	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
+	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
+	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
+
+	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
+		if ((data->pestA[i] >> 63) == 0 &&
+		    (data->pestB[i] >> 63) == 0)
+			continue;
+
+		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
+		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
+	}
+}
+
+static void pci_err_phb_diag_data(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct OpalIoPhbErrorCommon *common;
+	long ret;
+
+	common = (struct OpalIoPhbErrorCommon *)pci_err_diag;
+	ret = opal_pci_get_phb_diag_data2(phb->opal_id, common, PAGE_SIZE);
+	if (ret != OPAL_SUCCESS) {
+		pr_warning("%s: Failed to get diag-data for PHB#%x, ret=%ld\n",
+			   __func__, hose->global_number, ret);
+		return;
+	}
+
+	switch (common->ioType) {
+	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
+		pci_err_phb_p7ioc_diag(hose, common);
+		break;
+	default:
+		pr_warning("%s: Unrecognized I/O chip %d\n",
+			   __func__, common->ioType);
+	}
+}
+
+/*
+ * Process PCI errors from IOC, PHB, or PE. Here's the list
+ * of expected error types and their severities, as well as
+ * the corresponding action.
+ *
+ * Type                        Severity                Action
+ * OPAL_EEH_ERROR_IOC  OPAL_EEH_SEV_IOC_DEAD   panic
+ * OPAL_EEH_ERROR_IOC  OPAL_EEH_SEV_INF        diag_data
+ * OPAL_EEH_ERROR_PHB  OPAL_EEH_SEV_PHB_DEAD   panic
+ * OPAL_EEH_ERROR_PHB  OPAL_EEH_SEV_PHB_FENCED eeh
+ * OPAL_EEH_ERROR_PHB  OPAL_EEH_SEV_INF        diag_data
+ * OPAL_EEH_ERROR_PE   OPAL_EEH_SEV_PE_ER      eeh
+ */
+static void pci_err_process(struct pci_controller *hose,
+			u16 err_type, u16 severity, u16 pe_no)
+{
+	struct pnv_phb *phb = hose->private_data;
+
+	PCI_ERR_DBG("PCI_ERR: Process error (%d, %d, %d) on PHB#%x\n",
+		err_type, severity, pe_no, hose->global_number);
+
+	switch (err_type) {
+	case OPAL_EEH_IOC_ERROR:
+		if (severity == OPAL_EEH_SEV_IOC_DEAD) {
+			WARN(1, "EEH: dead IOC detected\n");
+			pci_err_dead_ioc();
+		} else if (severity == OPAL_EEH_SEV_INF)
+			pci_err_hub_diag_data(hose);
+
+		break;
+	case OPAL_EEH_PHB_ERROR:
+		if (severity == OPAL_EEH_SEV_PHB_DEAD) {
+			if (!phb->removed)
+				WARN(1, "EEH: dead PHB#%x detected\n",
+				     hose->global_number);
+			pci_err_dead_phb(hose);
+		} else if (severity == OPAL_EEH_SEV_PHB_FENCED)
+			pci_err_check_phb(hose);
+		else if (severity == OPAL_EEH_SEV_INF)
+			pci_err_phb_diag_data(hose);
+
+		break;
+	case OPAL_EEH_PE_ERROR:
+		pci_err_check_pe(hose, pe_no);
+		break;
+	}
+}
+
+static int pci_err_handler(void *dummy)
+{
+	struct pnv_phb *phb;
+	struct pci_controller *hose, *tmp;
+	u64 frozen_pe_no;
+	u16 err_type, severity;
+	long ret;
+
+	while (!kthread_should_stop()) {
+		down(&pci_err_int_sem);
+		PCI_ERR_DBG("PCI_ERR: Get PCI error semaphore\n");
+
+		list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+			/*
+			 * If the subordinate PCI buses of the PHB has been
+			 * removed, we needn't take care of it any more.
+			 */
+			phb = hose->private_data;
+			if (phb->removed)
+				continue;
+
+			ret = opal_pci_next_error(phb->opal_id,
+					&frozen_pe_no, &err_type, &severity);
+
+			/* If OPAL API returns error, we needn't proceed */
+			if (ret != OPAL_SUCCESS) {
+				PCI_ERR_DBG("PCI_ERR: Invalid return value on "
+					    "PHB#%x (0x%lx) from opal_pci_next_error",
+					    hose->global_number, ret);
+				continue;
+			}
+
+			/* If the PHB doesn't have error, stop processing */
+			if (err_type == OPAL_EEH_NO_ERROR ||
+			    severity == OPAL_EEH_SEV_NO_ERROR) {
+				PCI_ERR_DBG("PCI_ERR: No error found on PHB#%x\n",
+					hose->global_number);
+				continue;
+			}
+
+			/*
+			 * Processing the error. We're expecting the error with
+			 * highest priority reported upon multiple errors on the
+			 * specific PHB.
+			 */
+			pci_err_process(hose, err_type, severity, frozen_pe_no);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * pci_err_init - Initialize PCI error handling component
+ *
+ * It should be done before OPAL interrupts got registered because
+ * that depends on this.
+ */
+static int __init pci_err_init(void)
+{
+	int ret = 0;
+
+	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
+		pr_err("%s: FW_FEATURE_OPALv3 required!\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	pci_err_diag = (char *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
+	if (!pci_err_diag) {
+		pr_err("%s: Failed to alloc memory for diag data\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	/* Initialize semaphore */
+	sema_init(&pci_err_int_sem, 0);
+
+	/* Start kthread */
+	pci_err_thread = kthread_run(pci_err_handler, NULL, "PCI_ERR");
+	if (IS_ERR(pci_err_thread)) {
+		ret = PTR_ERR(pci_err_thread);
+		free_page((unsigned long)pci_err_diag);
+		pr_err("%s: Failed to start kthread, ret=%d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+arch_initcall(pci_err_init);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 6f69b87..08d53b0 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -92,6 +92,7 @@ struct pnv_phb {
 #ifdef CONFIG_EEH
 	struct pnv_eeh_ops	*eeh_ops;
 	int			eeh_enabled;
+	int			removed;
 #endif
 
 #ifdef CONFIG_PCI_MSI
-- 
1.7.5.4
