Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FAC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:19:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4BF2083D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="TmqCY0gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4BF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449vlF1zj4zDqVT
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 03:19:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="TmqCY0gB"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449vQ41WwlzDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 03:05:00 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 65DF241997;
 Fri,  1 Mar 2019 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1551456296; x=1553270697; bh=DfGEAmyajGfwct6Ljt3BNOWQ+nERJQivRa8
 EZK3s7r8=; b=TmqCY0gBSxKN36SXNjpAyj3qlexyVmpfd9gW5B7zQPtcCIhSMp/
 FrqtkiHEAcqp3IO2cO53xdqZPiHsxewIHIoucRJf74VtGxCj3HDCLnyNdJD2wmFA
 q2cOipdUZjN6e04z4hbna9XpGTFV9lkGRV48xCfdCvQQq390HMRc1zl4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tlC7SFLL89L4; Fri,  1 Mar 2019 19:04:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id DF682419CA;
 Fri,  1 Mar 2019 19:04:48 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Mar
 2019 19:04:48 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 6/9] powerpc/pci/IOV: Add support for runtime enabling
 the VFs
Date: Fri, 1 Mar 2019 19:04:37 +0300
Message-ID: <20190301160440.26262-7-s.miroshnichenko@yadro.com>
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

When called within pcibios_sriov_enable(), the pci_sriov_get_totalvfs(pdev)
returns zero, because the device is yet preparing to enable the VFs.

With this patch it becomes possible to enable VFs via sysfs "sriov_numvfs"
on PowerNV.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |  2 +-
 arch/powerpc/kernel/pci_dn.c              | 27 ++++++++++++++---------
 arch/powerpc/platforms/powernv/pci-ioda.c |  2 +-
 arch/powerpc/platforms/pseries/pci.c      |  2 +-
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index aee4fcc24990..8a30c48caa3e 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -225,7 +225,7 @@ struct pci_dn {
 extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 					   int devfn);
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
-extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
+extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev, int num_vfs);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
 extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 					       struct device_node *dn);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index ed1aab424e91..1b1a6198eb28 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -229,18 +229,19 @@ static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *parent)
 	return pdn;
 }
 
-struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
+struct pci_dn *add_dev_pci_data(struct pci_dev *pdev, int num_vfs)
 {
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent, *pdn;
 	int i;
 
+	pdn = pci_get_pdn(pdev);
+
 	/* Only support IOV for now */
 	if (!pdev->is_physfn)
-		return pci_get_pdn(pdev);
+		return pdn;
 
 	/* Check if VFs have been populated */
-	pdn = pci_get_pdn(pdev);
 	if (!pdn || (pdn->flags & PCI_DN_FLAG_IOV_VF))
 		return NULL;
 
@@ -249,28 +250,34 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 	if (!parent)
 		return NULL;
 
-	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
+	for (i = 0; i < num_vfs; i++) {
 		struct eeh_dev *edev __maybe_unused;
+		struct pci_dn *vpdn;
 
-		pdn = add_one_dev_pci_data(parent, i,
-					   pci_iov_virtfn_bus(pdev, i),
-					   pci_iov_virtfn_devfn(pdev, i));
-		if (!pdn) {
+		vpdn = add_one_dev_pci_data(parent, i,
+					    pci_iov_virtfn_bus(pdev, i),
+					    pci_iov_virtfn_devfn(pdev, i));
+		if (!vpdn) {
 			dev_warn(&pdev->dev, "%s: Cannot create firmware data for VF#%d\n",
 				 __func__, i);
 			return NULL;
 		}
 
+		vpdn->vendor_id = pdn->vendor_id;
+		vpdn->device_id = pdn->device_id;
+		vpdn->class_code = pdn->class_code;
+		vpdn->pci_ext_config_space = 0;
+
 #ifdef CONFIG_EEH
 		/* Create the EEH device for the VF */
-		edev = eeh_dev_init(pdn);
+		edev = eeh_dev_init(vpdn);
 		BUG_ON(!edev);
 		edev->physfn = pdev;
 #endif /* CONFIG_EEH */
 	}
 #endif /* CONFIG_PCI_IOV */
 
-	return pci_get_pdn(pdev);
+	return pdn;
 }
 
 void remove_dev_pci_data(struct pci_dev *pdev)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0631e8196dad..371e60c824d7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1728,7 +1728,7 @@ int pnv_pcibios_sriov_disable(struct pci_dev *pdev)
 int pnv_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	/* Allocate PCI data */
-	add_dev_pci_data(pdev);
+	add_dev_pci_data(pdev, num_vfs);
 
 	return pnv_pci_sriov_enable(pdev, num_vfs);
 }
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 37a77e57893e..054e8bf5d5d3 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -205,7 +205,7 @@ int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 int pseries_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	/* Allocate PCI data */
-	add_dev_pci_data(pdev);
+	add_dev_pci_data(pdev, num_vfs);
 	return pseries_pci_sriov_enable(pdev, num_vfs);
 }
 
-- 
2.20.1

