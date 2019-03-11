Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC9CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 11:58:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE91206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 11:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="qpS1FwY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE91206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HxSh469XzDqDf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 22:58:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="qpS1FwY0"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HxLR48nXzDq8F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 22:52:47 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 2CB764193A;
 Mon, 11 Mar 2019 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552305163; x=1554119564; bh=1IMRsgwCAXCOMAa1/eZp+CJZbXa/pYIE6jw
 jpgjSH2Y=; b=qpS1FwY0Qqrk1IwNn90iR9Y2+WfznLVQSpl/SI6mG3PF+h6nGIq
 89khg7wTCr1TF7pLl4Yq4EbzuFlmzoyXfs6zCF3nNMamDbSVqRkaY2i/CiQ+4JvG
 8rYi6tWI1oi0c4hegA63zqOUJ6+SXasQZe5wwrhcKVC7JsDPfuP6IZbM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWS5X-y5FObW; Mon, 11 Mar 2019 14:52:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A2B6541980;
 Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 14:52:40 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 3/8] powerpc/pci: Create pci_dn on demand
Date: Mon, 11 Mar 2019 14:52:28 +0300
Message-ID: <20190311115233.6514-4-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
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
 arch/powerpc/kernel/pci_dn.c | 88 ++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 341ed71250f1..b594b055b2cf 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -33,6 +33,9 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+static struct pci_dn *pci_create_pdn_from_dev(struct pci_dev *pdev,
+					      struct pci_dn *parent);
+
 /*
  * The function is used to find the firmware data of one
  * specific PCI device, which is attached to the indicated
@@ -65,6 +68,9 @@ struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
 	dn = pci_bus_to_OF_node(pbus);
 	pdn = dn ? PCI_DN(dn) : NULL;
 
+	if (!pdn && pbus->self)
+		pdn = pbus->self->dev.archdata.pci_data;
+
 	return pdn;
 }
 
@@ -74,10 +80,13 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
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
 
@@ -86,6 +95,9 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 		}
 	}
 
+	if (!pdev_found)
+		pdev = NULL;
+
 	/* Fast path: fetch from device node */
 	pdn = dn ? PCI_DN(dn) : NULL;
 	if (pdn)
@@ -98,9 +110,12 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 
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
@@ -130,17 +145,17 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 
 	list_for_each_entry(pdn, &parent->child_list, list) {
 		if (pdn->busno == pdev->bus->number &&
-		    pdn->devfn == pdev->devfn)
+		    pdn->devfn == pdev->devfn) {
+			pdev->dev.archdata.pci_data = pdn;
 			return pdn;
+		}
 	}
 
-	return NULL;
+	return pci_create_pdn_from_dev(pdev, parent);
 }
 
-#ifdef CONFIG_PCI_IOV
-static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
-					   int vf_index,
-					   int busno, int devfn)
+static struct pci_dn *pci_alloc_pdn(struct pci_dn *parent,
+				    int busno, int devfn)
 {
 	struct pci_dn *pdn;
 
@@ -156,7 +171,6 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
-	pdn->vf_index = vf_index;
 	pdn->pe_number = IODA_INVALID_PE;
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
@@ -164,7 +178,51 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 
 	return pdn;
 }
-#endif
+
+static struct pci_dn *pci_create_pdn_from_dev(struct pci_dev *pdev,
+					      struct pci_dn *parent)
+{
+	struct pci_dn *pdn = NULL;
+	u32 class_code;
+	u16 device_id;
+	u16 vendor_id;
+
+	if (!parent)
+		return NULL;
+
+	pdn = pci_alloc_pdn(parent, pdev->bus->busn_res.start, pdev->devfn);
+	pci_info(pdev, "Create a new pdn for devfn %2x\n", pdev->devfn / 8);
+
+	if (!pdn) {
+		pci_err(pdev, "%s: Failed to allocate pdn\n", __func__);
+		return NULL;
+	}
+
+	#ifdef CONFIG_EEH
+	if (!eeh_dev_init(pdn)) {
+		kfree(pdn);
+		pci_err(pdev, "%s: Failed to allocate edev\n", __func__);
+		return NULL;
+	}
+	#endif /* CONFIG_EEH */
+
+	pci_bus_read_config_word(pdev->bus, pdev->devfn,
+				 PCI_VENDOR_ID, &vendor_id);
+	pdn->vendor_id = vendor_id;
+
+	pci_bus_read_config_word(pdev->bus, pdev->devfn,
+				 PCI_DEVICE_ID, &device_id);
+	pdn->device_id = device_id;
+
+	pci_bus_read_config_dword(pdev->bus, pdev->devfn,
+				  PCI_CLASS_REVISION, &class_code);
+	class_code >>= 8;
+	pdn->class_code = class_code;
+
+	pdev->dev.archdata.pci_data = pdn;
+
+	return pdn;
+}
 
 struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
@@ -189,15 +247,17 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
 		struct eeh_dev *edev __maybe_unused;
 
-		pdn = add_one_dev_pci_data(parent, i,
-					   pci_iov_virtfn_bus(pdev, i),
-					   pci_iov_virtfn_devfn(pdev, i));
+		pdn = pci_alloc_pdn(parent,
+				    pci_iov_virtfn_bus(pdev, i),
+				    pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
 			dev_warn(&pdev->dev, "%s: Cannot create firmware data for VF#%d\n",
 				 __func__, i);
 			return NULL;
 		}
 
+		pdn->vf_index = i;
+
 #ifdef CONFIG_EEH
 		/* Create the EEH device for the VF */
 		edev = eeh_dev_init(pdn);
-- 
2.20.1

