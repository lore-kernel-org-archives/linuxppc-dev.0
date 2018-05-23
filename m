Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhQB531yzF145
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:49:38 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIi50f001319
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:35 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j5bf0pscf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:35 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 23 May 2018 12:49:35 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net-next 8/8] ibmvnic: Introduce hard reset recovery
Date: Wed, 23 May 2018 13:38:02 -0500
In-Reply-To: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1527100682-23099-9-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a recovery hard reset to handle reset failure as a result of
change of device context following a transport event, such as a
backing device failover or partition migration. These operations reset
the device context to its initial state. If this occurs during a reset,
any initialization commands are likely to fail with an invalid state
error as backing device firmware requests reinitialization.

When this happens, make one more attempt by performing a hard reset,
which frees any resources currently allocated and performs device
initialization. If a transport event occurs during a device reset, a
flag is set which will trigger a new hard reset following the
completionof the current reset event.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 101 +++++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/ibm/ibmvnic.h |   1 +
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index ee51deb..09f8e6b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1878,6 +1878,85 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 	return 0;
 }
 
+static int do_hard_reset(struct ibmvnic_adapter *adapter,
+			 struct ibmvnic_rwi *rwi, u32 reset_state)
+{
+	struct net_device *netdev = adapter->netdev;
+	int rc;
+
+	netdev_dbg(adapter->netdev, "Hard resetting driver (%d)\n",
+		   rwi->reset_reason);
+
+	netif_carrier_off(netdev);
+	adapter->reset_reason = rwi->reset_reason;
+
+	ibmvnic_cleanup(netdev);
+	release_resources(adapter);
+	release_sub_crqs(adapter, 0);
+	release_crq_queue(adapter);
+
+	/* remove the closed state so when we call open it appears
+	 * we are coming from the probed state.
+	 */
+	adapter->state = VNIC_PROBED;
+
+	rc = init_crq_queue(adapter);
+	if (rc) {
+		netdev_err(adapter->netdev,
+			   "Couldn't initialize crq. rc=%d\n", rc);
+		return rc;
+	}
+
+	rc = ibmvnic_init(adapter);
+	if (rc)
+		return rc;
+
+	/* If the adapter was in PROBE state prior to the reset,
+	 * exit here.
+	 */
+	if (reset_state == VNIC_PROBED)
+		return 0;
+
+	rc = ibmvnic_login(netdev);
+	if (rc) {
+		adapter->state = VNIC_PROBED;
+		return 0;
+	}
+	/* netif_set_real_num_xx_queues needs to take rtnl lock here
+	 * unless wait_for_reset is set, in which case the rtnl lock
+	 * has already been taken before initializing the reset
+	 */
+	if (!adapter->wait_for_reset) {
+		rtnl_lock();
+		rc = init_resources(adapter);
+		rtnl_unlock();
+	} else {
+		rc = init_resources(adapter);
+	}
+	if (rc)
+		return rc;
+
+	ibmvnic_disable_irqs(adapter);
+	adapter->state = VNIC_CLOSED;
+
+	if (reset_state == VNIC_CLOSED)
+		return 0;
+
+	rc = __ibmvnic_open(netdev);
+	if (rc) {
+		if (list_empty(&adapter->rwi_list))
+			adapter->state = VNIC_CLOSED;
+		else
+			adapter->state = reset_state;
+
+		return 0;
+	}
+
+	netif_carrier_on(netdev);
+
+	return 0;
+}
+
 static struct ibmvnic_rwi *get_next_rwi(struct ibmvnic_adapter *adapter)
 {
 	struct ibmvnic_rwi *rwi;
@@ -1923,9 +2002,15 @@ static void __ibmvnic_reset(struct work_struct *work)
 
 	rwi = get_next_rwi(adapter);
 	while (rwi) {
-		rc = do_reset(adapter, rwi, reset_state);
+		if (adapter->force_reset_recovery) {
+			adapter->force_reset_recovery = false;
+			rc = do_hard_reset(adapter, rwi, reset_state);
+		} else {
+			rc = do_reset(adapter, rwi, reset_state);
+		}
 		kfree(rwi);
-		if (rc && rc != IBMVNIC_INIT_FAILED)
+		if (rc && rc != IBMVNIC_INIT_FAILED &&
+		    !adapter->force_reset_recovery)
 			break;
 
 		rwi = get_next_rwi(adapter);
@@ -1951,9 +2036,9 @@ static void __ibmvnic_reset(struct work_struct *work)
 static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 			 enum ibmvnic_reset_reason reason)
 {
+	struct list_head *entry, *tmp_entry;
 	struct ibmvnic_rwi *rwi, *tmp;
 	struct net_device *netdev = adapter->netdev;
-	struct list_head *entry;
 	int ret;
 
 	if (adapter->state == VNIC_REMOVING ||
@@ -1989,7 +2074,13 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 		ret = ENOMEM;
 		goto err;
 	}
-
+	/* if we just received a transport event,
+	 * flush reset queue and process this reset
+	 */
+	if (adapter->force_reset_recovery && !list_empty(&adapter->rwi_list)) {
+		list_for_each_safe(entry, tmp_entry, &adapter->rwi_list)
+			list_del(entry);
+	}
 	rwi->reset_reason = reason;
 	list_add_tail(&rwi->list, &adapter->rwi_list);
 	mutex_unlock(&adapter->rwi_lock);
@@ -4271,6 +4362,8 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 	case IBMVNIC_CRQ_XPORT_EVENT:
 		netif_carrier_off(netdev);
 		adapter->crq.active = false;
+		if (adapter->resetting)
+			adapter->force_reset_recovery = true;
 		if (gen_crq->cmd == IBMVNIC_PARTITION_MIGRATED) {
 			dev_info(dev, "Migrated, re-enabling adapter\n");
 			ibmvnic_reset(adapter, VNIC_RESET_MOBILITY);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index edfc312..f9fb780 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1109,6 +1109,7 @@ struct ibmvnic_adapter {
 
 	bool mac_change_pending;
 	bool failover_pending;
+	bool force_reset_recovery;
 
 	struct ibmvnic_tunables desired;
 	struct ibmvnic_tunables fallback;
-- 
2.7.5
