Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW7xc6hf5zDqw9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 15:25:24 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/pci: Fix SRIOV not building without EEH enabled
Date: Fri, 17 Jun 2016 15:25:17 +1000
Message-Id: <20160617052517.25322-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Book3E CPUs (and possibly other configs), it is possible to have SRIOV
(CONFIG_PCI_IOV) set without CONFIG_EEH.  The SRIOV code does not check
for this, and if EEH is disabled, pci_dn.c fails to build.

Fix this by gating the EEH-specific code in the SRIOV implementation
behind CONFIG_EEH.

Fixes: 39218cd0 ("powerpc/eeh: EEH device for VF")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org> # 4.1+
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/pci_dn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index ecdccce..afeda26 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -181,7 +181,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent, *pdn;
+#ifdef CONFIG_EEH
 	struct eeh_dev *edev;
+#endif /* CONFIG_EEH */
 	int i;
 
 	/* Only support IOV for now */
@@ -208,11 +210,13 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 			return NULL;
 		}
 
+#ifdef CONFIG_EEH
 		/* Create the EEH device for the VF */
 		eeh_dev_init(pdn, pci_bus_to_host(pdev->bus));
 		edev = pdn_to_eeh_dev(pdn);
 		BUG_ON(!edev);
 		edev->physfn = pdev;
+#endif /* CONFIG_EEH */
 	}
 #endif /* CONFIG_PCI_IOV */
 
@@ -266,12 +270,14 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
 				continue;
 
+#ifdef CONFIG_EEH
 			/* Release EEH device for the VF */
 			edev = pdn_to_eeh_dev(pdn);
 			if (edev) {
 				pdn->edev = NULL;
 				kfree(edev);
 			}
+#endif /* CONFIG_EEH */
 
 			if (!list_empty(&pdn->list))
 				list_del(&pdn->list);
-- 
2.8.3
