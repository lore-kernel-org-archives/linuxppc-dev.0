Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B6EC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8276820989
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJb4sGOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8276820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4356S01DDVzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 17:04:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iJb4sGOD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="iJb4sGOD"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4356LJ389GzDr4D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 16:59:52 +1100 (AEDT)
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BF3E21104;
 Thu, 29 Nov 2018 05:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543471190;
 bh=/KySSdHTSOnyrrEm2qnhYq7IdrcvuV0UJNKEcYwKick=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iJb4sGODF+yKyPQVB+J5jVNw1SLt5hRK7OD9mZc7MqtFVN/CZhRZKmP3cesfR4wq6
 IKDzZOm8apKmb/sXTRbUjwWJ86CW+6QOtUpk8TN3BajE9KiAczujZ9GBmMnb7ROvrN
 es9PRymXuCZZI9ZmJgnarJStdkvGLmubBViUFDUM=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 49/68] net/ibmnvic: Fix deadlock problem in reset
Date: Thu, 29 Nov 2018 00:55:40 -0500
Message-Id: <20181129055559.159228-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
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
Cc: Juliet Kim <julietk@linux.vnet.ibm.com>, Sasha Levin <sashal@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Juliet Kim <julietk@linux.vnet.ibm.com>

[ Upstream commit a5681e20b541a507c7d4fd48ae4a4040d32ee1ef ]

This patch changes to use rtnl_lock only during a reset to avoid
deadlock that could occur when a thread operating close is holding
rtnl_lock and waiting for reset_lock acquired by another thread,
which is waiting for rtnl_lock in order to set the number of tx/rx
queues during a reset.

Also, we now setting the number of tx/rx queues during a soft reset
for failover or LPM events.

Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 59 +++++++++++-------------------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 +-
 2 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7661064c815b..a646de07cbdc 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1103,20 +1103,15 @@ static int ibmvnic_open(struct net_device *netdev)
 		return 0;
 	}
 
-	mutex_lock(&adapter->reset_lock);
-
 	if (adapter->state != VNIC_CLOSED) {
 		rc = ibmvnic_login(netdev);
-		if (rc) {
-			mutex_unlock(&adapter->reset_lock);
+		if (rc)
 			return rc;
-		}
 
 		rc = init_resources(adapter);
 		if (rc) {
 			netdev_err(netdev, "failed to initialize resources\n");
 			release_resources(adapter);
-			mutex_unlock(&adapter->reset_lock);
 			return rc;
 		}
 	}
@@ -1124,8 +1119,6 @@ static int ibmvnic_open(struct net_device *netdev)
 	rc = __ibmvnic_open(netdev);
 	netif_carrier_on(netdev);
 
-	mutex_unlock(&adapter->reset_lock);
-
 	return rc;
 }
 
@@ -1269,10 +1262,8 @@ static int ibmvnic_close(struct net_device *netdev)
 		return 0;
 	}
 
-	mutex_lock(&adapter->reset_lock);
 	rc = __ibmvnic_close(netdev);
 	ibmvnic_cleanup(netdev);
-	mutex_unlock(&adapter->reset_lock);
 
 	return rc;
 }
@@ -1820,20 +1811,15 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 				return rc;
 		} else if (adapter->req_rx_queues != old_num_rx_queues ||
 			   adapter->req_tx_queues != old_num_tx_queues) {
-			adapter->map_id = 1;
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
-			rc = init_rx_pools(netdev);
-			if (rc)
-				return rc;
-			rc = init_tx_pools(netdev);
-			if (rc)
-				return rc;
-
 			release_napi(adapter);
-			rc = init_napi(adapter);
+			release_vpd_data(adapter);
+
+			rc = init_resources(adapter);
 			if (rc)
 				return rc;
+
 		} else {
 			rc = reset_tx_pools(adapter);
 			if (rc)
@@ -1917,17 +1903,8 @@ static int do_hard_reset(struct ibmvnic_adapter *adapter,
 		adapter->state = VNIC_PROBED;
 		return 0;
 	}
-	/* netif_set_real_num_xx_queues needs to take rtnl lock here
-	 * unless wait_for_reset is set, in which case the rtnl lock
-	 * has already been taken before initializing the reset
-	 */
-	if (!adapter->wait_for_reset) {
-		rtnl_lock();
-		rc = init_resources(adapter);
-		rtnl_unlock();
-	} else {
-		rc = init_resources(adapter);
-	}
+
+	rc = init_resources(adapter);
 	if (rc)
 		return rc;
 
@@ -1986,13 +1963,21 @@ static void __ibmvnic_reset(struct work_struct *work)
 	struct ibmvnic_rwi *rwi;
 	struct ibmvnic_adapter *adapter;
 	struct net_device *netdev;
+	bool we_lock_rtnl = false;
 	u32 reset_state;
 	int rc = 0;
 
 	adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
 	netdev = adapter->netdev;
 
-	mutex_lock(&adapter->reset_lock);
+	/* netif_set_real_num_xx_queues needs to take rtnl lock here
+	 * unless wait_for_reset is set, in which case the rtnl lock
+	 * has already been taken before initializing the reset
+	 */
+	if (!adapter->wait_for_reset) {
+		rtnl_lock();
+		we_lock_rtnl = true;
+	}
 	reset_state = adapter->state;
 
 	rwi = get_next_rwi(adapter);
@@ -2020,12 +2005,11 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (rc) {
 		netdev_dbg(adapter->netdev, "Reset failed\n");
 		free_all_rwi(adapter);
-		mutex_unlock(&adapter->reset_lock);
-		return;
 	}
 
 	adapter->resetting = false;
-	mutex_unlock(&adapter->reset_lock);
+	if (we_lock_rtnl)
+		rtnl_unlock();
 }
 
 static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
@@ -4709,7 +4693,6 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
-	mutex_init(&adapter->reset_lock);
 	mutex_init(&adapter->rwi_lock);
 	adapter->resetting = false;
 
@@ -4781,8 +4764,8 @@ static int ibmvnic_remove(struct vio_dev *dev)
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 
 	adapter->state = VNIC_REMOVING;
-	unregister_netdev(netdev);
-	mutex_lock(&adapter->reset_lock);
+	rtnl_lock();
+	unregister_netdevice(netdev);
 
 	release_resources(adapter);
 	release_sub_crqs(adapter, 1);
@@ -4793,7 +4776,7 @@ static int ibmvnic_remove(struct vio_dev *dev)
 
 	adapter->state = VNIC_REMOVED;
 
-	mutex_unlock(&adapter->reset_lock);
+	rtnl_unlock();
 	device_remove_file(&dev->dev, &dev_attr_failover);
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index f06eec145ca6..735f481b1870 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1068,7 +1068,7 @@ struct ibmvnic_adapter {
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
 	enum ibmvnic_reset_reason reset_reason;
-	struct mutex reset_lock, rwi_lock;
+	struct mutex rwi_lock;
 	struct list_head rwi_list;
 	struct work_struct ibmvnic_reset;
 	bool resetting;
-- 
2.17.1

