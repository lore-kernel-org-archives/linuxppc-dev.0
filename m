Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3BDC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:56:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DADE2084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DADE2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yz0s5W6mzDqSZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 18:56:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yyyv4bmqzDqQj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 18:54:31 +1100 (AEDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [10.3.19.214])
 by Forcepoint Email with ESMTP id 452B2EFFEAC11A69913E;
 Wed,  3 Apr 2019 15:54:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 15:54:16 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <tlfalcon@linux.ibm.com>, <jallen@linux.ibm.com>
Subject: [PATCH -next] ibmvnic: remove set but not used variable 'netdev'
Date: Wed, 3 Apr 2019 15:54:09 +0800
Message-ID: <20190403075409.29384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
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
Cc: netdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/ibm/ibmvnic.c: In function '__ibmvnic_reset':
drivers/net/ethernet/ibm/ibmvnic.c:1971:21: warning: variable 'netdev' set but not used [-Wunused-but-set-variable]

It's never used since introduction in
commit ed651a10875f ("ibmvnic: Updated reset handling")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 25b8e04..20c4e08 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1968,13 +1968,11 @@ static void __ibmvnic_reset(struct work_struct *work)
 {
 	struct ibmvnic_rwi *rwi;
 	struct ibmvnic_adapter *adapter;
-	struct net_device *netdev;
 	bool we_lock_rtnl = false;
 	u32 reset_state;
 	int rc = 0;
 
 	adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
-	netdev = adapter->netdev;
 
 	/* netif_set_real_num_xx_queues needs to take rtnl lock here
 	 * unless wait_for_reset is set, in which case the rtnl lock
-- 
2.7.0


