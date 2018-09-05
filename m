Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4257FP4SPhzF38Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 01:40:22 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 84B1C418BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 15:40:19 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2yWEQD4N-Qb for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  5 Sep 2018 18:40:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 3D380418EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 18:40:18 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH 2/5] powerpc/pci: Create pci_dn on demand
Date: Wed, 5 Sep 2018 18:40:05 +0300
Message-ID: <20180905154008.11130-3-s.miroshnichenko@yadro.com>
In-Reply-To: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
References: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
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

The pci_dn structures can be created not only from DT, but also
directly from newly discovered PCIe devices, so allocate them
dynamically.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c | 69 +++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index ab147a1909c8..5ce752874827 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -33,6 +33,8 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+static struct pci_dn* create_pdn(struct pci_dev *pdev, struct pci_dn *parent);
+
 /*
  * The function is used to find the firmware data of one
  * specific PCI device, which is attached to the indicated
@@ -58,6 +60,10 @@ static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
 		pbus = pbus->parent;
 	}
 
+	if (!pbus->self && !pci_is_root_bus(pbus)) {
+		return NULL;
+	}
+
 	/*
 	 * Except virtual bus, all PCI buses should
 	 * have device nodes.
@@ -65,13 +71,16 @@ static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
 	dn = pci_bus_to_OF_node(pbus);
 	pdn = dn ? PCI_DN(dn) : NULL;
 
+	if (!pdn && pbus->self) {
+		pdn = pbus->self->dev.archdata.pci_data;
+	}
+
 	return pdn;
 }
 
 struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 				    int devfn)
 {
-	struct device_node *dn = NULL;
 	struct pci_dn *parent, *pdn;
 	struct pci_dev *pdev = NULL;
 
@@ -80,17 +89,10 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 		if (pdev->devfn == devfn) {
 			if (pdev->dev.archdata.pci_data)
 				return pdev->dev.archdata.pci_data;
-
-			dn = pci_device_to_OF_node(pdev);
 			break;
 		}
 	}
 
-	/* Fast path: fetch from device node */
-	pdn = dn ? PCI_DN(dn) : NULL;
-	if (pdn)
-		return pdn;
-
 	/* Slow path: fetch from firmware data hierarchy */
 	parent = pci_bus_to_pdn(bus);
 	if (!parent)
@@ -128,16 +130,9 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 	if (!parent)
 		return NULL;
 
-	list_for_each_entry(pdn, &parent->child_list, list) {
-		if (pdn->busno == pdev->bus->number &&
-		    pdn->devfn == pdev->devfn)
-			return pdn;
-	}
-
-	return NULL;
+	return create_pdn(pdev, parent);
 }
 
-#ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 					   int vf_index,
 					   int busno, int devfn)
@@ -164,7 +159,47 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 
 	return pdn;
 }
-#endif
+
+static struct pci_dn* create_pdn(struct pci_dev *pdev, struct pci_dn *parent)
+{
+	struct pci_dn *pdn = NULL;
+
+	pdn = add_one_dev_pci_data(parent, 0, pdev->bus->number, pdev->devfn);
+	dev_info(&pdev->dev, "Create a new pdn for devfn %2x\n", pdev->devfn / 8);
+
+	if (pdn)
+	{
+		u32 class_code;
+		u16 device_id;
+		u16 vendor_id;
+
+		struct eeh_dev *edev = eeh_dev_init(pdn);
+		if (!edev) {
+			kfree(pdn);
+			dev_err(&pdev->dev, "%s:%d: Failed to allocate edev\n", __func__, __LINE__);
+			return NULL;
+		}
+
+		pdn->busno = pdev->bus->busn_res.start;
+
+		pci_bus_read_config_word(pdev->bus, pdev->devfn, PCI_VENDOR_ID, &vendor_id);
+		pdn->vendor_id = vendor_id;
+
+		pci_bus_read_config_word(pdev->bus, pdev->devfn, PCI_DEVICE_ID, &device_id);
+		pdn->device_id = device_id;
+
+		pci_bus_read_config_dword(pdev->bus, pdev->devfn, PCI_CLASS_REVISION, &class_code);
+		class_code >>= 8;
+		pdn->class_code = class_code;
+
+		pdn->pci_ext_config_space = 0;
+		pdev->dev.archdata.pci_data = pdn;
+	} else {
+		dev_err(&pdev->dev, "%s:%d: Failed to allocate pdn\n", __func__, __LINE__);
+	}
+
+	return pdn;
+}
 
 struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
-- 
2.17.1
