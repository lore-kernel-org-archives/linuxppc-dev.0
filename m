Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66EC61A0CCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:54:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:54:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C2366357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:54:32 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JAsOAF15139008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:54:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JAs07E000905
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:54:00 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V7 05/10] powerpc/powernv: EEH device for VF
Date: Tue, 19 May 2015 18:50:07 +0800
Message-Id: <1432032612-21701-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFs and their corresponding pci_dn instances are created and released
dynamically as their PF's SRIOV capability is enabled and disabled.
The patch creates and releases EEH devices for VFs when creating and
releasing their pci_dn instances, which means EEH devices and pci_dn
instances have same life cycle. Also, VF's EEH device is identified
by (struct eeh_dev::physfn).

[gwshan: changelog and removed CONFIG_PCI_IOV]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    1 +
 arch/powerpc/kernel/pci_dn.c   |   12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a52db28..1b3614d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -138,6 +138,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct pci_dev *physfn;		/* Associated PF PORT		*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index f771130..f0ddde7 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pci_dn *parent, *pdn;
+	struct eeh_dev *edev;
 	int i;
 
 	/* Only support IOV for now */
@@ -206,6 +208,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 				 __func__, i);
 			return NULL;
 		}
+		eeh_dev_init(pdn, hose);
+		edev = pdn_to_eeh_dev(pdn);
+		edev->physfn = pdev;
 	}
 #endif /* CONFIG_PCI_IOV */
 
@@ -254,10 +259,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
 		list_for_each_entry_safe(pdn, tmp,
 			&parent->child_list, list) {
+			struct eeh_dev *edev;
 			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
 				continue;
 
+			edev = pdn_to_eeh_dev(pdn);
+			if (edev) {
+				pdn->edev = NULL;
+				kfree(edev);
+			}
+
 			if (!list_empty(&pdn->list))
 				list_del(&pdn->list);
 
-- 
1.7.9.5
