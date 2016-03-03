Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27B6A1A0BA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:41 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:54:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CC6272CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:36 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NsSnR1507768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:36 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23Ns46J026013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:04 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v15 05/12] powerpc/eeh: EEH device for VF
Date: Fri,  4 Mar 2016 10:53:07 +1100
Message-Id: <1457049194-9281-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

VFs and their corresponding pdn are created and released dynamically
when their PF's SRIOV capability is enabled and disabled. This creates
and releases EEH devices for VFs when creating and releasing their pdn
instances, which means EEH devices and pdn instances have same life
cycle. Also, VF's EEH device is identified by (struct eeh_dev::physfn).

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  1 +
 arch/powerpc/kernel/pci_dn.c   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 867c39b..574ed49a 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -141,6 +141,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct pci_dev *physfn;		/* Associated SRIOV PF		*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b3b4df9..e23bdf7 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -179,6 +179,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent, *pdn;
+	struct eeh_dev *edev;
 	int i;
 
 	/* Only support IOV for now */
@@ -204,6 +205,12 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 				 __func__, i);
 			return NULL;
 		}
+
+		/* Create the EEH device for the VF */
+		eeh_dev_init(pdn, pci_bus_to_host(pdev->bus));
+		edev = pdn_to_eeh_dev(pdn);
+		BUG_ON(!edev);
+		edev->physfn = pdev;
 	}
 #endif /* CONFIG_PCI_IOV */
 
@@ -215,6 +222,7 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent;
 	struct pci_dn *pdn, *tmp;
+	struct eeh_dev *edev;
 	int i;
 
 	/*
@@ -256,6 +264,13 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
 				continue;
 
+			/* Release EEH device for the VF */
+			edev = pdn_to_eeh_dev(pdn);
+			if (edev) {
+				pdn->edev = NULL;
+				kfree(edev);
+			}
+
 			if (!list_empty(&pdn->list))
 				list_del(&pdn->list);
 
-- 
2.1.0
