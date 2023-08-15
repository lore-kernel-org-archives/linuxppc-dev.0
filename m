Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D75BC0015E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Aug 2023 23:19:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQS035ZQWz3bhp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Aug 2023 09:19:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=zhangjialin11@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1147 seconds by postgrey-1.37 at boromir; Tue, 15 Aug 2023 12:56:03 AEST
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPwrM4LQzz307d
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2023 12:55:59 +1000 (AEST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPwLh71fXzFqbB;
	Tue, 15 Aug 2023 10:33:48 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 10:36:44 +0800
From: Jialin Zhang <zhangjialin11@huawei.com>
To: <mahesh@linux.ibm.com>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/eeh: Use pci_dev_id() to simplify the code
Date: Tue, 15 Aug 2023 10:33:03 +0800
Message-ID: <20230815023303.3515503-1-zhangjialin11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500021.china.huawei.com (7.185.36.109)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 16 Aug 2023 09:19:04 +1000
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
Cc: liwei391@huawei.com, linuxppc-dev@lists.ozlabs.org, wangxiongfeng2@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a83cb679dd59..af3a5d37a149 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -855,8 +855,7 @@ static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
-	uint64_t id = PCI_SLOT_ID(phb->opal_id,
-				  (pdev->bus->number << 8) | pdev->devfn);
+	uint64_t id = PCI_SLOT_ID(phb->opal_id, pci_dev_id(pdev));
 	uint8_t scope;
 	int64_t rc;
 
-- 
2.25.1

