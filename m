Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64E7D1A0B97
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 12:44:27 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39CF514009B
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 11:44:26 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F2B182CE804E
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:24 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H1iG7N52232216
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:24 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H1hpqH020744
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:43:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] powerpc/eeh: Replace device_node with pci_dn in eeh_ops
Date: Tue, 17 Mar 2015 12:37:23 +1100
Message-Id: <1426556244-30066-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are 3 EEH operations whose arguments contain device_node:
read_config(), write_config() and restore_config(). The patch
replaces device_node with pci_dn.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  6 +-
 arch/powerpc/kernel/eeh.c                    | 34 +++++++-----
 arch/powerpc/kernel/eeh_pe.c                 | 82 ++++++++++++++--------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 40 ++++++--------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 16 ++----
 5 files changed, 84 insertions(+), 94 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index eefff1f..2540ad8 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -216,10 +216,10 @@ struct eeh_ops {
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*err_inject)(struct eeh_pe *pe, int type, int func,
 			  unsigned long addr, unsigned long mask);
-	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
-	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
+	int (*read_config)(struct pci_dn *pdn, int where, int size, u32 *val);
+	int (*write_config)(struct pci_dn *pdn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
-	int (*restore_config)(struct device_node *dn);
+	int (*restore_config)(struct pci_dn *pdn);
 };
 
 extern int eeh_subsystem_flags;
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 1743b54..6f9ec77 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -164,30 +164,34 @@ __setup("eeh=", eeh_setup);
  */
 static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 {
-	struct device_node *dn = eeh_dev_to_of_node(edev);
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	u32 cfg;
 	int cap, i;
 	int n = 0, l = 0;
 	char buffer[128];
 
-	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
-	pr_warn("EEH: of node=%s\n", dn->full_name);
+	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x:%01x\n",
+		       edev->phb->global_number, pdn->busno,
+		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+	pr_warn("EEH: of node=%04x:%02x:%02x:%01x\n",
+		edev->phb->global_number, pdn->busno,
+		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
 
-	eeh_ops->read_config(dn, PCI_VENDOR_ID, 4, &cfg);
+	eeh_ops->read_config(pdn, PCI_VENDOR_ID, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
 	pr_warn("EEH: PCI device/vendor: %08x\n", cfg);
 
-	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cfg);
+	eeh_ops->read_config(pdn, PCI_COMMAND, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
 	pr_warn("EEH: PCI cmd/status register: %08x\n", cfg);
 
 	/* Gather bridge-specific registers */
 	if (edev->mode & EEH_DEV_BRIDGE) {
-		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
+		eeh_ops->read_config(pdn, PCI_SEC_STATUS, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
 		pr_warn("EEH: Bridge secondary status: %04x\n", cfg);
 
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &cfg);
+		eeh_ops->read_config(pdn, PCI_BRIDGE_CONTROL, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
 		pr_warn("EEH: Bridge control: %04x\n", cfg);
 	}
@@ -195,11 +199,11 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 	/* Dump out the PCI-X command and status regs */
 	cap = edev->pcix_cap;
 	if (cap) {
-		eeh_ops->read_config(dn, cap, 4, &cfg);
+		eeh_ops->read_config(pdn, cap, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
 		pr_warn("EEH: PCI-X cmd: %08x\n", cfg);
 
-		eeh_ops->read_config(dn, cap+4, 4, &cfg);
+		eeh_ops->read_config(pdn, cap+4, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
 		pr_warn("EEH: PCI-X status: %08x\n", cfg);
 	}
@@ -211,7 +215,7 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 		pr_warn("EEH: PCI-E capabilities and status follow:\n");
 
 		for (i=0; i<=8; i++) {
-			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
+			eeh_ops->read_config(pdn, cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 
 			if ((i % 4) == 0) {
@@ -238,7 +242,7 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 		pr_warn("EEH: PCI-E AER capability register set follows:\n");
 
 		for (i=0; i<=13; i++) {
-			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
+			eeh_ops->read_config(pdn, cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 
 			if ((i % 4) == 0) {
@@ -870,15 +874,15 @@ out:
  */
 void eeh_save_bars(struct eeh_dev *edev)
 {
+	struct pci_dn *pdn;
 	int i;
-	struct device_node *dn;
 
-	if (!edev)
+	pdn = eeh_dev_to_pdn(edev);
+	if (!pdn)
 		return;
-	dn = eeh_dev_to_of_node(edev);
 
 	for (i = 0; i < 16; i++)
-		eeh_ops->read_config(dn, i * 4, 4, &edev->config_space[i]);
+		eeh_ops->read_config(pdn, i * 4, 4, &edev->config_space[i]);
 
 	/*
 	 * For PCI bridges including root port, we need enable bus
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 1e4946c..209cd75 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -291,27 +291,25 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
  */
 static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 {
-	struct device_node *dn;
 	struct eeh_dev *parent;
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	/*
 	 * It might have the case for the indirect parent
 	 * EEH device already having associated PE, but
 	 * the direct parent EEH device doesn't have yet.
 	 */
-	dn = edev->dn->parent;
-	while (dn) {
+	pdn = pdn ? pdn->parent : NULL;
+	while (pdn) {
 		/* We're poking out of PCI territory */
-		if (!PCI_DN(dn)) return NULL;
-
-		parent = of_node_to_eeh_dev(dn);
-		/* We're poking out of PCI territory */
-		if (!parent) return NULL;
+		parent = pdn_to_eeh_dev(pdn);
+		if (!parent)
+			return NULL;
 
 		if (parent->pe)
 			return parent->pe;
 
-		dn = dn->parent;
+		pdn = pdn->parent;
 	}
 
 	return NULL;
@@ -653,9 +651,9 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
  * blocked on normal path during the stage. So we need utilize
  * eeh operations, which is always permitted.
  */
-static void eeh_bridge_check_link(struct eeh_dev *edev,
-				  struct device_node *dn)
+static void eeh_bridge_check_link(struct eeh_dev *edev)
 {
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	int cap;
 	uint32_t val;
 	int timeout = 0;
@@ -675,32 +673,32 @@ static void eeh_bridge_check_link(struct eeh_dev *edev,
 
 	/* Check slot status */
 	cap = edev->pcie_cap;
-	eeh_ops->read_config(dn, cap + PCI_EXP_SLTSTA, 2, &val);
+	eeh_ops->read_config(pdn, cap + PCI_EXP_SLTSTA, 2, &val);
 	if (!(val & PCI_EXP_SLTSTA_PDS)) {
 		pr_debug("  No card in the slot (0x%04x) !\n", val);
 		return;
 	}
 
 	/* Check power status if we have the capability */
-	eeh_ops->read_config(dn, cap + PCI_EXP_SLTCAP, 2, &val);
+	eeh_ops->read_config(pdn, cap + PCI_EXP_SLTCAP, 2, &val);
 	if (val & PCI_EXP_SLTCAP_PCP) {
-		eeh_ops->read_config(dn, cap + PCI_EXP_SLTCTL, 2, &val);
+		eeh_ops->read_config(pdn, cap + PCI_EXP_SLTCTL, 2, &val);
 		if (val & PCI_EXP_SLTCTL_PCC) {
 			pr_debug("  In power-off state, power it on ...\n");
 			val &= ~(PCI_EXP_SLTCTL_PCC | PCI_EXP_SLTCTL_PIC);
 			val |= (0x0100 & PCI_EXP_SLTCTL_PIC);
-			eeh_ops->write_config(dn, cap + PCI_EXP_SLTCTL, 2, val);
+			eeh_ops->write_config(pdn, cap + PCI_EXP_SLTCTL, 2, val);
 			msleep(2 * 1000);
 		}
 	}
 
 	/* Enable link */
-	eeh_ops->read_config(dn, cap + PCI_EXP_LNKCTL, 2, &val);
+	eeh_ops->read_config(pdn, cap + PCI_EXP_LNKCTL, 2, &val);
 	val &= ~PCI_EXP_LNKCTL_LD;
-	eeh_ops->write_config(dn, cap + PCI_EXP_LNKCTL, 2, val);
+	eeh_ops->write_config(pdn, cap + PCI_EXP_LNKCTL, 2, val);
 
 	/* Check link */
-	eeh_ops->read_config(dn, cap + PCI_EXP_LNKCAP, 4, &val);
+	eeh_ops->read_config(pdn, cap + PCI_EXP_LNKCAP, 4, &val);
 	if (!(val & PCI_EXP_LNKCAP_DLLLARC)) {
 		pr_debug("  No link reporting capability (0x%08x) \n", val);
 		msleep(1000);
@@ -713,7 +711,7 @@ static void eeh_bridge_check_link(struct eeh_dev *edev,
 		msleep(20);
 		timeout += 20;
 
-		eeh_ops->read_config(dn, cap + PCI_EXP_LNKSTA, 2, &val);
+		eeh_ops->read_config(pdn, cap + PCI_EXP_LNKSTA, 2, &val);
 		if (val & PCI_EXP_LNKSTA_DLLLA)
 			break;
 	}
@@ -728,9 +726,9 @@ static void eeh_bridge_check_link(struct eeh_dev *edev,
 #define BYTE_SWAP(OFF)	(8*((OFF)/4)+3-(OFF))
 #define SAVED_BYTE(OFF)	(((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
 
-static void eeh_restore_bridge_bars(struct eeh_dev *edev,
-				    struct device_node *dn)
+static void eeh_restore_bridge_bars(struct eeh_dev *edev)
 {
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	int i;
 
 	/*
@@ -738,49 +736,49 @@ static void eeh_restore_bridge_bars(struct eeh_dev *edev,
 	 * Bus numbers and windows: 0x18 - 0x30
 	 */
 	for (i = 4; i < 13; i++)
-		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
+		eeh_ops->write_config(pdn, i*4, 4, edev->config_space[i]);
 	/* Rom: 0x38 */
-	eeh_ops->write_config(dn, 14*4, 4, edev->config_space[14]);
+	eeh_ops->write_config(pdn, 14*4, 4, edev->config_space[14]);
 
 	/* Cache line & Latency timer: 0xC 0xD */
-	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
+	eeh_ops->write_config(pdn, PCI_CACHE_LINE_SIZE, 1,
                 SAVED_BYTE(PCI_CACHE_LINE_SIZE));
-        eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
+        eeh_ops->write_config(pdn, PCI_LATENCY_TIMER, 1,
                 SAVED_BYTE(PCI_LATENCY_TIMER));
 	/* Max latency, min grant, interrupt ping and line: 0x3C */
-	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
+	eeh_ops->write_config(pdn, 15*4, 4, edev->config_space[15]);
 
 	/* PCI Command: 0x4 */
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1]);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1]);
 
 	/* Check the PCIe link is ready */
-	eeh_bridge_check_link(edev, dn);
+	eeh_bridge_check_link(edev);
 }
 
-static void eeh_restore_device_bars(struct eeh_dev *edev,
-				    struct device_node *dn)
+static void eeh_restore_device_bars(struct eeh_dev *edev)
 {
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	int i;
 	u32 cmd;
 
 	for (i = 4; i < 10; i++)
-		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
+		eeh_ops->write_config(pdn, i*4, 4, edev->config_space[i]);
 	/* 12 == Expansion ROM Address */
-	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
+	eeh_ops->write_config(pdn, 12*4, 4, edev->config_space[12]);
 
-	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
+	eeh_ops->write_config(pdn, PCI_CACHE_LINE_SIZE, 1,
 		SAVED_BYTE(PCI_CACHE_LINE_SIZE));
-	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
+	eeh_ops->write_config(pdn, PCI_LATENCY_TIMER, 1,
 		SAVED_BYTE(PCI_LATENCY_TIMER));
 
 	/* max latency, min grant, interrupt pin and line */
-	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
+	eeh_ops->write_config(pdn, 15*4, 4, edev->config_space[15]);
 
 	/*
 	 * Restore PERR & SERR bits, some devices require it,
 	 * don't touch the other command bits
 	 */
-	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
+	eeh_ops->read_config(pdn, PCI_COMMAND, 4, &cmd);
 	if (edev->config_space[1] & PCI_COMMAND_PARITY)
 		cmd |= PCI_COMMAND_PARITY;
 	else
@@ -789,7 +787,7 @@ static void eeh_restore_device_bars(struct eeh_dev *edev,
 		cmd |= PCI_COMMAND_SERR;
 	else
 		cmd &= ~PCI_COMMAND_SERR;
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 4, cmd);
 }
 
 /**
@@ -804,16 +802,16 @@ static void eeh_restore_device_bars(struct eeh_dev *edev,
 static void *eeh_restore_one_device_bars(void *data, void *flag)
 {
 	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	/* Do special restore for bridges */
 	if (edev->mode & EEH_DEV_BRIDGE)
-		eeh_restore_bridge_bars(edev, dn);
+		eeh_restore_bridge_bars(edev);
 	else
-		eeh_restore_device_bars(edev, dn);
+		eeh_restore_device_bars(edev);
 
-	if (eeh_ops->restore_config)
-		eeh_ops->restore_config(dn);
+	if (eeh_ops->restore_config && pdn)
+		eeh_ops->restore_config(pdn);
 
 	return NULL;
 }
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index dcc524f..ce738ab 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -842,8 +842,8 @@ out:
 
 static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
-	struct device_node *dn = pci_device_to_OF_node(dev);
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	int aer = edev ? edev->aer_cap : 0;
 	u32 ctrl;
 
@@ -856,32 +856,32 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	case EEH_RESET_HOT:
 		/* Don't report linkDown event */
 		if (aer) {
-			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
+			eeh_ops->read_config(pdn, aer + PCI_ERR_UNCOR_MASK,
 					     4, &ctrl);
 			ctrl |= PCI_ERR_UNC_SURPDN;
-			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
+			eeh_ops->write_config(pdn, aer + PCI_ERR_UNCOR_MASK,
 					      4, ctrl);
 		}
 
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
+		eeh_ops->read_config(pdn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
-		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+		eeh_ops->write_config(pdn, PCI_BRIDGE_CONTROL, 2, ctrl);
 
 		msleep(EEH_PE_RST_HOLD_TIME);
 		break;
 	case EEH_RESET_DEACTIVATE:
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
+		eeh_ops->read_config(pdn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+		eeh_ops->write_config(pdn, PCI_BRIDGE_CONTROL, 2, ctrl);
 
 		msleep(EEH_PE_RST_SETTLE_TIME);
 
 		/* Continue reporting linkDown event */
 		if (aer) {
-			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
+			eeh_ops->read_config(pdn, aer + PCI_ERR_UNCOR_MASK,
 					     4, &ctrl);
 			ctrl &= ~PCI_ERR_UNC_SURPDN;
-			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
+			eeh_ops->write_config(pdn, aer + PCI_ERR_UNCOR_MASK,
 					      4, ctrl);
 		}
 
@@ -1099,9 +1099,9 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 	return 0;
 }
 
-static inline bool pnv_eeh_cfg_blocked(struct device_node *dn)
+static inline bool pnv_eeh_cfg_blocked(struct pci_dn *pdn)
 {
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
 	if (!edev || !edev->pe)
 		return false;
@@ -1112,15 +1112,13 @@ static inline bool pnv_eeh_cfg_blocked(struct device_node *dn)
 	return false;
 }
 
-static int pnv_eeh_read_config(struct device_node *dn,
+static int pnv_eeh_read_config(struct pci_dn *pdn,
 			       int where, int size, u32 *val)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
-
 	if (!pdn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (pnv_eeh_cfg_blocked(dn)) {
+	if (pnv_eeh_cfg_blocked(pdn)) {
 		*val = 0xFFFFFFFF;
 		return PCIBIOS_SET_FAILED;
 	}
@@ -1128,15 +1126,13 @@ static int pnv_eeh_read_config(struct device_node *dn,
 	return pnv_pci_cfg_read(pdn, where, size, val);
 }
 
-static int pnv_eeh_write_config(struct device_node *dn,
+static int pnv_eeh_write_config(struct pci_dn *pdn,
 				int where, int size, u32 val)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
-
 	if (!pdn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (pnv_eeh_cfg_blocked(dn))
+	if (pnv_eeh_cfg_blocked(pdn))
 		return PCIBIOS_SET_FAILED;
 
 	return pnv_pci_cfg_write(pdn, where, size, val);
@@ -1484,9 +1480,9 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	return ret;
 }
 
-static int pnv_eeh_restore_config(struct device_node *dn)
+static int pnv_eeh_restore_config(struct pci_dn *pdn)
 {
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	struct pnv_phb *phb;
 	s64 ret;
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a2946f7..2039397 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -651,37 +651,29 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 
 /**
  * pseries_eeh_read_config - Read PCI config space
- * @dn: device node
+ * @pdn: PCI device node
  * @where: PCI address
  * @size: size to read
  * @val: return value
  *
  * Read config space from the speicifed device
  */
-static int pseries_eeh_read_config(struct device_node *dn, int where, int size, u32 *val)
+static int pseries_eeh_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 {
-	struct pci_dn *pdn;
-
-	pdn = PCI_DN(dn);
-
 	return rtas_read_config(pdn, where, size, val);
 }
 
 /**
  * pseries_eeh_write_config - Write PCI config space
- * @dn: device node
+ * @pdn: PCI device node
  * @where: PCI address
  * @size: size to write
  * @val: value to be written
  *
  * Write config space to the specified device
  */
-static int pseries_eeh_write_config(struct device_node *dn, int where, int size, u32 val)
+static int pseries_eeh_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 {
-	struct pci_dn *pdn;
-
-	pdn = PCI_DN(dn);
-
 	return rtas_write_config(pdn, where, size, val);
 }
 
-- 
1.8.3.2
