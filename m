Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F93C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Apr 2022 22:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KnK3Q4x27z3bp5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Apr 2022 08:11:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=wupeng58@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KmyYV1D5pz2yMj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2022 18:17:31 +1000 (AEST)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmyXQ1C0szhYkS;
 Mon, 25 Apr 2022 16:16:38 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 16:16:48 +0800
From: Peng Wu <wupeng58@huawei.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <nick.child@ibm.com>
Subject: [PATCH -next] powerpc/iommu: Add missing of_node_put in
 iommu_init_early_dart
Date: Mon, 25 Apr 2022 08:12:45 +0000
Message-ID: <20220425081245.21705-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 26 Apr 2022 08:10:52 +1000
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
Cc: Peng Wu <wupeng58@huawei.com>, liwei391@huawei.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The device_node pointer is returned by of_find_compatible_node
with refcount incremented. We should use of_node_put() to avoid
the refcount leak.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 arch/powerpc/sysdev/dart_iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index be6b99b1b352..9a02aed886a0 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -404,9 +404,10 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	}
 
 	/* Initialize the DART HW */
-	if (dart_init(dn) != 0)
+	if (dart_init(dn) != 0) {
+		of_node_put(dn);
 		return;
-
+	}
 	/*
 	 * U4 supports a DART bypass, we use it for 64-bit capable devices to
 	 * improve performance.  However, that only works for devices connected
@@ -419,6 +420,7 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
+	of_node_put(dn);
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

