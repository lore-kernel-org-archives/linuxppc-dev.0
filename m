Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F38AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:06:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995A12084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="FVeh9Mu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995A12084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449vSJ1MfVzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 03:06:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="FVeh9Mu/"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449vPy40PgzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 03:04:54 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D9A6141990;
 Fri,  1 Mar 2019 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1551456289; x=1553270690; bh=bzygkj8SVyB/xHOAI0BvG/o53chYzfycUdK
 p/qCFmHE=; b=FVeh9Mu/0q6UBggP8RT7Kqrt5BUmYh9jTJKj9CVhvK6tIpDuSX6
 w0+a6MgvOMFOLeRuhpiKK+d5qajOymt7npb0K2TZavBumBsnyVa6RNsLlCtSIJr/
 HmH8z13489zPbbKM1wljV5E+tRGP9yI+xeI9CZ1Fuv505ZrWh4j3Ze0E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Csz7YFOMeDeo; Fri,  1 Mar 2019 19:04:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6D2DD41995;
 Fri,  1 Mar 2019 19:04:48 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Mar
 2019 19:04:47 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 3/9] powerpc/pci: Create pci_dn on demand
Date: Fri, 1 Mar 2019 19:04:34 +0300
Message-ID: <20190301160440.26262-4-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, linux@yadro.com,
 Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If a struct pci_dn hasn't yet been created for the PCIe device (there was
no DT node for it), allocate this structure and fill with info read from
the device directly.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c | 79 ++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 341ed71250f1..67ccd7be8344 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -33,6 +33,8 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *parent);
+
 /*
  * The function is used to find the firmware data of one
  * specific PCI device, which is attached to the indicated
@@ -65,6 +67,9 @@ struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
 	dn = pci_bus_to_OF_node(pbus);
 	pdn = dn ? PCI_DN(dn) : NULL;
 
+	if (!pdn && pbus->self)
+		pdn = pbus->self->dev.archdata.pci_data;
+
 	return pdn;
 }
 
@@ -74,10 +79,13 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 	struct device_node *dn = NULL;
 	struct pci_dn *parent, *pdn;
 	struct pci_dev *pdev = NULL;
+	bool pdev_found = false;
 
 	/* Fast path: fetch from PCI device */
 	list_for_each_entry(pdev, &bus->devices, bus_list) {
 		if (pdev->devfn == devfn) {
+			pdev_found = true;
+
 			if (pdev->dev.archdata.pci_data)
 				return pdev->dev.archdata.pci_data;
 
@@ -86,6 +94,9 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 		}
 	}
 
+	if (!pdev_found)
+		pdev = NULL;
+
 	/* Fast path: fetch from device node */
 	pdn = dn ? PCI_DN(dn) : NULL;
 	if (pdn)
@@ -98,9 +109,12 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 
 	list_for_each_entry(pdn, &parent->child_list, list) {
 		if (pdn->busno == bus->number &&
-                    pdn->devfn == devfn)
-                        return pdn;
-        }
+		    pdn->devfn == devfn) {
+			if (pdev)
+				pdev->dev.archdata.pci_data = pdn;
+			return pdn;
+		}
+	}
 
 	return NULL;
 }
@@ -130,14 +144,15 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 
 	list_for_each_entry(pdn, &parent->child_list, list) {
 		if (pdn->busno == pdev->bus->number &&
-		    pdn->devfn == pdev->devfn)
+		    pdn->devfn == pdev->devfn) {
+			pdev->dev.archdata.pci_data = pdn;
 			return pdn;
+		}
 	}
 
-	return NULL;
+	return create_pdn(pdev, parent);
 }
 
-#ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 					   int vf_index,
 					   int busno, int devfn)
@@ -156,7 +171,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
+	#ifdef CONFIG_PCI_IOV
 	pdn->vf_index = vf_index;
+	#endif /* CONFIG_PCI_IOV */
 	pdn->pe_number = IODA_INVALID_PE;
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
@@ -164,7 +181,55 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 
 	return pdn;
 }
-#endif
+
+static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *parent)
+{
+	struct pci_dn *pdn = NULL;
+
+	if (!parent)
+		return NULL;
+
+	pdn = add_one_dev_pci_data(parent, 0, pdev->bus->busn_res.start, pdev->devfn);
+	dev_info(&pdev->dev, "Create a new pdn for devfn %2x\n", pdev->devfn / 8);
+
+	if (pdn) {
+		#ifdef CONFIG_EEH
+		struct eeh_dev *edev;
+		#endif /* CONFIG_EEH */
+		u32 class_code;
+		u16 device_id;
+		u16 vendor_id;
+
+		#ifdef CONFIG_EEH
+		edev = eeh_dev_init(pdn);
+		if (!edev) {
+			kfree(pdn);
+			dev_err(&pdev->dev, "%s: Failed to allocate edev\n", __func__);
+			return NULL;
+		}
+		#endif /* CONFIG_EEH */
+
+		pci_bus_read_config_word(pdev->bus, pdev->devfn,
+					 PCI_VENDOR_ID, &vendor_id);
+		pdn->vendor_id = vendor_id;
+
+		pci_bus_read_config_word(pdev->bus, pdev->devfn,
+					 PCI_DEVICE_ID, &device_id);
+		pdn->device_id = device_id;
+
+		pci_bus_read_config_dword(pdev->bus, pdev->devfn,
+					  PCI_CLASS_REVISION, &class_code);
+		class_code >>= 8;
+		pdn->class_code = class_code;
+
+		pdn->pci_ext_config_space = 0;
+		pdev->dev.archdata.pci_data = pdn;
+	} else {
+		dev_err(&pdev->dev, "%s: Failed to allocate pdn\n", __func__);
+	}
+
+	return pdn;
+}
 
 struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
-- 
2.20.1

