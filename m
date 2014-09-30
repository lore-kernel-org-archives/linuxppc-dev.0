Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE16C1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:40:11 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:40:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1297A2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:40:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2faL436307018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2daD2016069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/21] powerpc/eeh: Reenable PCI devices after reset
Date: Tue, 30 Sep 2014 12:38:53 +1000
Message-Id: <1412044750-24460-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI devices that have been passed through are enabled before
reset, we need restore to the enabled state after reset. Otherwise,
MMIO access might be issued to disabled devices after reset and
causes exceptional recursive EEH error.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 62 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 898c75f..db2841c 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1342,6 +1342,53 @@ int eeh_pe_get_state(struct eeh_pe *pe)
 }
 EXPORT_SYMBOL_GPL(eeh_pe_get_state);
 
+static int eeh_pe_reenable_devices(struct eeh_pe *pe)
+{
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+	int ret = 0;
+
+	/* Restore config space */
+	eeh_pe_restore_bars(pe);
+
+	/*
+	 * Reenable PCI devices as the devices passed
+	 * through are always enabled before the reset.
+	 */
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		ret = pci_reenable_device(pdev);
+		if (ret) {
+			pr_warn("%s: Failure %d reenabling %s\n",
+				__func__, ret, pci_name(pdev));
+			return ret;
+		}
+	}
+
+	/* The PE is still in frozen state */
+	ret = eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
+	if (ret) {
+		pr_warn("%s: Failure %d enabling MMIO for PHB#%x-PE#%x\n",
+			__func__, ret, pe->phb->global_number, pe->addr);
+		return ret;
+	}
+
+	ret = eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
+	if (ret) {
+		pr_warn("%s: Failure %d enabling DMA for PHB#%x-PE#%x\n",
+			__func__, ret, pe->phb->global_number, pe->addr);
+		return ret;
+	}
+
+	/* Clear software isolated state */
+	eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+
+	return ret;
+}
+
 /**
  * eeh_pe_reset - Issue PE reset according to specified type
  * @pe: EEH PE
@@ -1368,17 +1415,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 		if (ret)
 			break;
 
-		/*
-		 * The PE is still in frozen state and we need to clear
-		 * that. It's good to clear frozen state after deassert
-		 * to avoid messy IO access during reset, which might
-		 * cause recursive frozen PE.
-		 */
-		ret = eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
-		if (!ret)
-			ret = eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
-		if (!ret)
-			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+		ret = eeh_pe_reenable_devices(pe);
 		break;
 	case EEH_RESET_HOT:
 	case EEH_RESET_FUNDAMENTAL:
@@ -1417,9 +1454,6 @@ int eeh_pe_configure(struct eeh_pe *pe)
 	if (!pe)
 		return -ENODEV;
 
-	/* Restore config space for the affected devices */
-	eeh_pe_restore_bars(pe);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(eeh_pe_configure);
-- 
1.8.3.2
