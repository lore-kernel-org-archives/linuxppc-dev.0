Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1B191A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 09:27:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 30 Jul 2015 09:27:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 41B092BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 09:27:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6TNRjNM15204506
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 09:27:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6TNRKB3009547
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 09:27:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Disable automatically blocked PCI config
Date: Thu, 30 Jul 2015 09:26:51 +1000
Message-Id: <1438212411-11368-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pcibios_set_pcie_reset_state() could be called to complete
reset request when passing through PCI device, flag
EEH_PE_ISOLATED is set before saving the PCI config sapce.
On some Broadcom adapters, EEH_PE_CFG_BLOCKED is automatically
set when the flag EEH_PE_ISOLATED is marked. It caused bogus
data saved from the PCI config space, which will be restored
to the PCI adapter after the reset. Eventually, the hardware
can't work with corrupted data in PCI config space.

The patch fixes the issue with eeh_pe_state_mark_no_cfg(), which
doesn't set EEH_PE_CFG_BLOCKED when seeing EEH_PE_ISOLATED on the
PE, in order to avoid the bogus data saved and restored to the PCI
config space.

Reported-by: Rajanikanth H. Adaveeshaiah <rajanikanth.ha@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h |  1 +
 arch/powerpc/kernel/eeh.c          |  4 ++--
 arch/powerpc/kernel/eeh_pe.c       | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 4122a86..ca0c5bf 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -61,6 +61,7 @@ int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
 void eeh_pe_state_clear(struct eeh_pe *pe, int state);
+void eeh_pe_state_mark_with_cfg(struct eeh_pe *pe, int state);
 void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode);
 
 void eeh_sysfs_add_device(struct pci_dev *pdev);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index af9b597..8050f5e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -750,14 +750,14 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 		break;
 	case pcie_hot_reset:
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_mark_with_cfg(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_mark_with_cfg(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 35f0b62..8654cb1 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -657,6 +657,28 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
 }
 
+/**
+ * eeh_pe_state_mark_with_cfg - Mark PE state with unblocked config space
+ * @pe: PE
+ * @state: PE state to be set
+ *
+ * Set specified flag to PE and its child PEs. The PCI config space
+ * of some PEs is blocked automatically when EEH_PE_ISOLATED is set,
+ * which isn't needed in some situations. The function allows to set
+ * the specified flag to indicated PEs without blocking their PCI
+ * config space.
+ */
+void eeh_pe_state_mark_with_cfg(struct eeh_pe *pe, int state)
+{
+	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
+	if (!(state & EEH_PE_ISOLATED))
+		return;
+
+	/* Clear EEH_PE_CFG_BLOCKED, which might be set just now */
+	state = EEH_PE_CFG_BLOCKED;
+	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
+}
+
 /*
  * Some PCI bridges (e.g. PLX bridges) have primary/secondary
  * buses assigned explicitly by firmware, and we probably have
-- 
2.1.0
