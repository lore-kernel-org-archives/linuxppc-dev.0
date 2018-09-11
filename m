Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428k0N5WYbzF390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:56:36 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id F3D76411D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 11:56:30 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0w4RR1YIcPgi for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 11 Sep 2018 14:56:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 7F3B94190D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 14:56:28 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v3 6/6] powerpc/pci: Reduce code duplication in
 pci_add_device_node_info
Date: Tue, 11 Sep 2018 14:56:20 +0300
Message-ID: <20180911115620.10507-7-s.miroshnichenko@yadro.com>
In-Reply-To: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
References: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is possible now to allocate and fill a new pdn with add_one_dev_pci_data

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c | 38 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 863d00561c50..9bd780895926 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -151,15 +151,10 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 {
 	struct pci_dn *pdn;
 
-	/* Except PHB, we always have the parent */
-	if (!parent)
-		return NULL;
-
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (!pdn)
 		return NULL;
 
-	pdn->phb = parent->phb;
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
@@ -169,7 +164,10 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->pe_number = IODA_INVALID_PE;
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
-	list_add_tail(&pdn->list, &parent->child_list);
+	if (parent) {
+		pdn->phb = parent->phb;
+		list_add_tail(&pdn->list, &parent->child_list);
+	}
 
 	return pdn;
 }
@@ -338,25 +336,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 	const __be32 *regs;
 	struct device_node *parent;
 	struct pci_dn *pdn;
+	int busno = 0, devfn = 0;
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;
 #endif
 
-	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
-	if (pdn == NULL)
-		return NULL;
-	dn->data = pdn;
-	pdn->phb = hose;
-	pdn->pe_number = IODA_INVALID_PE;
 	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
 		u32 addr = of_read_number(regs, 1);
 
 		/* First register entry is addr (00BBSS00)  */
-		pdn->busno = (addr >> 16) & 0xff;
-		pdn->devfn = (addr >> 8) & 0xff;
+		busno = (addr >> 16) & 0xff;
+		devfn = (addr >> 8) & 0xff;
 	}
 
+	parent = of_get_parent(dn);
+	pdn = add_one_dev_pci_data(parent ? PCI_DN(parent) : NULL,
+				   0, busno, devfn);
+	if (!pdn)
+		return NULL;
+
+	dn->data = pdn;
+	pdn->phb = hose;
+
 	/* vendor/device IDs and class code */
 	regs = of_get_property(dn, "vendor-id", NULL);
 	pdn->vendor_id = regs ? of_read_number(regs, 1) : 0;
@@ -377,14 +379,6 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 	}
 #endif
 
-	/* Attach to parent node */
-	INIT_LIST_HEAD(&pdn->child_list);
-	INIT_LIST_HEAD(&pdn->list);
-	parent = of_get_parent(dn);
-	pdn->parent = parent ? PCI_DN(parent) : NULL;
-	if (pdn->parent)
-		list_add_tail(&pdn->list, &pdn->parent->child_list);
-
 	return pdn;
 }
 EXPORT_SYMBOL_GPL(pci_add_device_node_info);
-- 
2.17.1
