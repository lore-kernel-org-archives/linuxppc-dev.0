Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C10331A1BF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BB02D2CE805F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:35 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764DRKc62390448
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764D2id002046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 28/42] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
Date: Thu,  6 Aug 2015 14:11:33 +1000
Message-Id: <1438834307-26960-29-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some subordinate PCI devices of one particular PCI bus might ask
for fundamental reset because the default (hot) reset isn't enough
for those PCI devices to be up successfully after reset.

This iterates all PCI devices behind the specified PCI bus and issues
fundamental reset if any one PCI device is asking for that. Otherwise,
hot reset is still issued.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 19cb947..4ae48ff 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1057,8 +1057,31 @@ static int pnv_eeh_vf_pe_reset(struct eeh_pe *pe, int option)
 	return 0;
 }
 
+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
+{
+	int *freset = data;
+
+	/*
+	 * Stop the iteration immediately if there is any
+	 * one PCI device requesting fundamental reset
+	 */
+	*freset |= pdev->needs_freset;
+	return *freset;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
+	int option = EEH_RESET_HOT;
+
+	if (dev->subordinate) {
+		int freset = 0;
+
+		pci_walk_bus(dev->subordinate,
+			     pnv_pci_dev_reset_type,
+			     &freset);
+		option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
+	}
+
 	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
-- 
2.1.0
