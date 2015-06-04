Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A85EF1A0D0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 09F96357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hoUj61276264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hPCe006504
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 29/42] powerpc/powernv: Issue fundamental reset in
 pnv_pci_reset_secondary_bus()
Date: Thu,  4 Jun 2015 16:41:58 +1000
Message-Id: <1433400131-18429-30-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There might have PCI devices, under the specified PCI bus, asking
for fundamental reset. The patch iterates all PCI devices under
the specified PCI bus and issue fundamental reset to the PCI bus
if any PCI device is asking for that. Otherwise, hot reset is
issued to the PCI bus.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 10/21]
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 18167c5..4eb53ed 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1055,9 +1055,32 @@ static int pnv_eeh_vf_pe_reset(struct eeh_pe *pe, int option)
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
-	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
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
+	pnv_eeh_bridge_reset(dev, option);
 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
 
-- 
2.1.0
