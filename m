Return-Path: <SRS0=hLaT=A7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C71C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2020 12:30:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A9020672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2020 12:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A9020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B9LfM4mk5zDqNn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2020 22:30:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=zhangchangzhong@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B9JxJ1NZ2zDqVv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2020 21:12:58 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4EC88F12689ECCFD9523;
 Mon, 20 Jul 2020 19:12:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 20 Jul 2020 19:12:40 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: <pantelis.antoniou@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>
Subject: [PATCH net-next] net: fs_enet: remove redundant null check
Date: Mon, 20 Jul 2020 19:12:33 +0800
Message-ID: <1595243553-12325-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 20 Jul 2020 22:27:13 +1000
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Because clk_prepare_enable and clk_disable_unprepare already
checked NULL clock parameter, so the additional checks are
unnecessary, just remove them.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index b0d4b198..bf846b4 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1043,8 +1043,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 out_free_dev:
 	free_netdev(ndev);
 out_put:
-	if (fpi->clk_per)
-		clk_disable_unprepare(fpi->clk_per);
+	clk_disable_unprepare(fpi->clk_per);
 out_deregister_fixed_link:
 	of_node_put(fpi->phy_node);
 	if (of_phy_is_fixed_link(ofdev->dev.of_node))
@@ -1065,8 +1064,7 @@ static int fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
 	of_node_put(fep->fpi->phy_node);
-	if (fep->fpi->clk_per)
-		clk_disable_unprepare(fep->fpi->clk_per);
+	clk_disable_unprepare(fep->fpi->clk_per);
 	if (of_phy_is_fixed_link(ofdev->dev.of_node))
 		of_phy_deregister_fixed_link(ofdev->dev.of_node);
 	free_netdev(ndev);
-- 
1.8.3.1

