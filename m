Return-Path: <SRS0=1oEm=ZC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76823C43331
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Nov 2019 02:44:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29F321655
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Nov 2019 02:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwJgwA/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29F321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 479dcd4KzNzF1Rd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Nov 2019 13:44:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="lwJgwA/9"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 479dXv53xPzF3wq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Nov 2019 13:40:47 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4297221848;
 Sun, 10 Nov 2019 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573353645;
 bh=ffidVs99+EyIN0h+Yg+AdhgsEgNhtwcYak5FUzTui/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lwJgwA/9yF7UOXVi+AjFvRQ8jnfqAPkduSwf/yCJnczWNp4B4Q9NpPOTIFeNqvng0
 nYtpAc6HWSsPEZJOZJQUrYsvWGunH8djWx8JpOPS2eU2FAtMItgP5jLJmCTli7bskn
 sKwo06cwi3Th82/fikGcf1cN8EHtvHGQQN3wfANs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 025/191] net: ibm: fix return type of
 ndo_start_xmit function
Date: Sat,  9 Nov 2019 21:37:27 -0500
Message-Id: <20191110024013.29782-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, YueHaibing <yuehaibing@huawei.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 94b2bb28dbb43fcb943d5275ab19fd5a4972bedb ]

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
 drivers/net/ethernet/ibm/emac/core.c      | 7 ++++---
 drivers/net/ethernet/ibm/ibmvnic.c        | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 506f78322d741..e8ee69d4e4d34 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -2027,7 +2027,7 @@ static void ehea_xmit3(struct sk_buff *skb, struct net_device *dev,
 	dev_consume_skb_any(skb);
 }
 
-static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ehea_port *port = netdev_priv(dev);
 	struct ehea_swqe *swqe;
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 129f4e9f38dac..a96f501813ff7 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1409,7 +1409,7 @@ static inline u16 emac_tx_csum(struct emac_instance *dev,
 	return 0;
 }
 
-static inline int emac_xmit_finish(struct emac_instance *dev, int len)
+static inline netdev_tx_t emac_xmit_finish(struct emac_instance *dev, int len)
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	struct net_device *ndev = dev->ndev;
@@ -1436,7 +1436,7 @@ static inline int emac_xmit_finish(struct emac_instance *dev, int len)
 }
 
 /* Tx lock BH */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
 	unsigned int len = skb->len;
@@ -1494,7 +1494,8 @@ static inline int emac_xmit_split(struct emac_instance *dev, int slot,
 }
 
 /* Tx lock BH disabled (SG version for TAH equipped EMACs) */
-static int emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
 	int nr_frags = skb_shinfo(skb)->nr_frags;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8fa14736449bc..8a1916443235a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1420,7 +1420,7 @@ static int ibmvnic_xmit_workarounds(struct sk_buff *skb,
 	return 0;
 }
 
-static int ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 	int queue_num = skb_get_queue_mapping(skb);
@@ -1444,7 +1444,7 @@ static int ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u64 *handle_array;
 	int index = 0;
 	u8 proto = 0;
-	int ret = 0;
+	netdev_tx_t ret = NETDEV_TX_OK;
 
 	if (adapter->resetting) {
 		if (!netif_subqueue_stopped(netdev, skb))
-- 
2.20.1

