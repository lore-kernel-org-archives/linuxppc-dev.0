Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBjd0s7rzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:08:21 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBjc2Tgbz9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:08:20 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 40/41] powerpc/pci: Fix build of Book3E/64 without EEH
Date: Tue,  5 Jul 2016 15:07:53 +1000
Message-Id: <1467695274-14667-40-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
References: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_dn.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index ecdccce..4fc6ede 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -31,6 +31,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
+#include <asm/eeh.h>
 
 /*
  * The function is used to find the firmware data of one
@@ -181,7 +182,6 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent, *pdn;
-	struct eeh_dev *edev;
 	int i;
 
 	/* Only support IOV for now */
@@ -199,6 +199,8 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 		return NULL;
 
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
+		struct eeh_dev *edev __maybe_unused;
+
 		pdn = add_one_dev_pci_data(parent, NULL, i,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
@@ -209,10 +211,12 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 		}
 
 		/* Create the EEH device for the VF */
+#ifdef CONFIG_EEH
 		eeh_dev_init(pdn, pci_bus_to_host(pdev->bus));
 		edev = pdn_to_eeh_dev(pdn);
 		BUG_ON(!edev);
 		edev->physfn = pdev;
+#endif /* CONFIG_EEH */
 	}
 #endif /* CONFIG_PCI_IOV */
 
@@ -224,7 +228,6 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent;
 	struct pci_dn *pdn, *tmp;
-	struct eeh_dev *edev;
 	int i;
 
 	/*
@@ -260,18 +263,22 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 	 * a batch mode.
 	 */
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
+		struct eeh_dev *edev __maybe_unused;
+
 		list_for_each_entry_safe(pdn, tmp,
 			&parent->child_list, list) {
 			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
 				continue;
 
+#ifdef CONFIG_EEH
 			/* Release EEH device for the VF */
 			edev = pdn_to_eeh_dev(pdn);
 			if (edev) {
 				pdn->edev = NULL;
 				kfree(edev);
 			}
+#endif
 
 			if (!list_empty(&pdn->list))
 				list_del(&pdn->list);
-- 
2.7.4
