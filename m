Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D1BA1A0D00
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 10:31:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Sun, 8 Nov 2015 05:01:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 181E0125805B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 05:01:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA7NVj9166256896
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Nov 2015 05:01:45 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA7NVi0d031954
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Nov 2015 05:01:45 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V13 5/9] powerpc/powernv: EEH device for VF
Date: Sun,  8 Nov 2015 07:30:31 +0800
Message-Id: <1446939035-2617-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  1 +
 arch/powerpc/kernel/pci_dn.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index c5eb86f..6c383ad 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -140,6 +140,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct pci_dev *physfn;		/* Associated PF PORT		*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b3b4df9..5091b05 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -178,7 +178,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pci_dn *parent, *pdn;
+	struct eeh_dev *edev;
 	int i;
 
 	/* Only support IOV for now */
@@ -204,6 +206,10 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 				 __func__, i);
 			return NULL;
 		}
+		eeh_dev_init(pdn, hose);
+		edev = pdn_to_eeh_dev(pdn);
+		BUG_ON(!edev);
+		edev->physfn = pdev;
 	}
 #endif /* CONFIG_PCI_IOV */
 
@@ -252,10 +258,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
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
2.5.0
