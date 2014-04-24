Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC3DD140155
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D82EB3578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dXkP24772772
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:33 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80QZ1023339
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 07/25] powerpc/powernv: Use EEH PCI config accessors
Date: Thu, 24 Apr 2014 18:00:13 +1000
Message-Id: <1398326431-24305-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For EEH PowerNV backends, they need use their own PCI config
accesors as the normal one could be blocked during PE reset.
The patch also removes necessary parameter "hose" for the
function ioda_eeh_bridge_reset().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 9ff7b2d..ed6c686 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -478,26 +478,27 @@ out:
 	return 0;
 }
 
-static int ioda_eeh_bridge_reset(struct pci_controller *hose,
-		struct pci_dev *dev, int option)
+static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
+
 {
-	u16 ctrl;
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	u32 ctrl;
 
-	pr_debug("%s: Reset device %04x:%02x:%02x.%01x with option %d\n",
-		 __func__, hose->global_number, dev->bus->number,
-		 PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn), option);
+	pr_debug("%s: Reset PCI bus %04x:%02x with option %d\n",
+		 __func__, pci_domain_nr(dev->bus),
+		 dev->bus->number, option);
 
 	switch (option) {
 	case EEH_RESET_FUNDAMENTAL:
 	case EEH_RESET_HOT:
-		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
-		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
 		break;
 	case EEH_RESET_DEACTIVATE:
-		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
 		break;
 	}
 
@@ -552,7 +553,7 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		if (pci_is_root_bus(bus))
 			ret = ioda_eeh_root_reset(hose, option);
 		else
-			ret = ioda_eeh_bridge_reset(hose, bus->self, option);
+			ret = ioda_eeh_bridge_reset(bus->self, option);
 	}
 
 	return ret;
-- 
1.8.3.2
