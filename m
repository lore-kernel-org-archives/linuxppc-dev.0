Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C5AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 22:01:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9852086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 22:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9852086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zN8V00pGzF3Wc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 09:01:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=julietk@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zN6B75pRzF3St
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 08:59:30 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJLwvQK062316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 16:59:28 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nv4e0jjr6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 16:59:28 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <julietk@linux.vnet.ibm.com>;
 Mon, 19 Nov 2018 21:59:26 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Nov 2018 21:59:24 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAJLxNFN1704380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Nov 2018 21:59:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 017B32805E;
 Mon, 19 Nov 2018 21:59:23 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77F7228058;
 Mon, 19 Nov 2018 21:59:22 +0000 (GMT)
Received: from ltcalpine2-lp22.aus.stglabs.ibm.com (unknown [9.40.195.231])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 19 Nov 2018 21:59:22 +0000 (GMT)
Subject: [PATCH net] net/ibmnvic: Fix deadlock problem in reset
From: Juliet Kim <julietk@linux.vnet.ibm.com>
To: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 19 Nov 2018 15:59:22 -0600
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111921-0068-0000-0000-00000362D5A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010083; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01119880; UDB=6.00581062; IPR=6.00900002; 
 MB=3.00024237; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-19 21:59:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111921-0069-0000-0000-0000467A7CBB
Message-Id: <20181119215727.22197.97260.stgit@ltcalpine2-lp22.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-19_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190194
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
Cc: julietk@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch changes to use rtnl_lock only during a reset to avoid
deadlock that could occur when a thread operating close is holding
rtnl_lock and waiting for reset_lock acquired by another thread,
which is waiting for rtnl_lock in order to set the number of tx/rx
queues during a reset.

Also, we now setting the number of tx/rx queues during a soft reset
for failover or LPM events.

Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   59 +++++++++++++-----------------------
 drivers/net/ethernet/ibm/ibmvnic.h |    2 +
 2 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7893bef..4a5de59 100644
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
@@ -4768,7 +4752,6 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
-	mutex_init(&adapter->reset_lock);
 	mutex_init(&adapter->rwi_lock);
 	adapter->resetting = false;
 
@@ -4840,8 +4823,8 @@ static int ibmvnic_remove(struct vio_dev *dev)
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 
 	adapter->state = VNIC_REMOVING;
-	unregister_netdev(netdev);
-	mutex_lock(&adapter->reset_lock);
+	rtnl_lock();
+	unregister_netdevice(netdev);
 
 	release_resources(adapter);
 	release_sub_crqs(adapter, 1);
@@ -4852,7 +4835,7 @@ static int ibmvnic_remove(struct vio_dev *dev)
 
 	adapter->state = VNIC_REMOVED;
 
-	mutex_unlock(&adapter->reset_lock);
+	rtnl_unlock();
 	device_remove_file(&dev->dev, &dev_attr_failover);
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 18103b8..99c4f8d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1075,7 +1075,7 @@ struct ibmvnic_adapter {
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
 	enum ibmvnic_reset_reason reset_reason;
-	struct mutex reset_lock, rwi_lock;
+	struct mutex rwi_lock;
 	struct list_head rwi_list;
 	struct work_struct ibmvnic_reset;
 	bool resetting;

