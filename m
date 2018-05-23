Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhQ75WRpzF1Cq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:49:35 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIhmd3091549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:33 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j5cxt2gkc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:33 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 23 May 2018 12:49:32 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net-next 6/8] ibmvnic: Create separate initialization routine
 for resets
Date: Wed, 23 May 2018 13:38:00 -0500
In-Reply-To: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1527100682-23099-7-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of having one initialization routine for all cases, create
a separate, simpler function for standard initialization, such as during
device probe. Use the original initialization function to handle
device reset scenarios. The goal of this patch is to avoid having
a single, cluttered init function to handle all possible
scenarios.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index b1bbd5b..f26e1f8 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -116,6 +116,7 @@ static void send_cap_queries(struct ibmvnic_adapter *adapter);
 static int init_sub_crqs(struct ibmvnic_adapter *);
 static int init_sub_crq_irqs(struct ibmvnic_adapter *adapter);
 static int ibmvnic_init(struct ibmvnic_adapter *);
+static int ibmvnic_reset_init(struct ibmvnic_adapter *);
 static void release_crq_queue(struct ibmvnic_adapter *);
 static int __ibmvnic_set_mac(struct net_device *netdev, struct sockaddr *p);
 static int init_crq_queue(struct ibmvnic_adapter *adapter);
@@ -1807,7 +1808,7 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			return rc;
 		}
 
-		rc = ibmvnic_init(adapter);
+		rc = ibmvnic_reset_init(adapter);
 		if (rc)
 			return IBMVNIC_INIT_FAILED;
 
@@ -4571,7 +4572,7 @@ static int init_crq_queue(struct ibmvnic_adapter *adapter)
 	return retrc;
 }
 
-static int ibmvnic_init(struct ibmvnic_adapter *adapter)
+static int ibmvnic_reset_init(struct ibmvnic_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 	unsigned long timeout = msecs_to_jiffies(30000);
@@ -4630,6 +4631,49 @@ static int ibmvnic_init(struct ibmvnic_adapter *adapter)
 	return rc;
 }
 
+static int ibmvnic_init(struct ibmvnic_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	unsigned long timeout = msecs_to_jiffies(30000);
+	int rc;
+
+	adapter->from_passive_init = false;
+
+	init_completion(&adapter->init_done);
+	adapter->init_done_rc = 0;
+	ibmvnic_send_crq_init(adapter);
+	if (!wait_for_completion_timeout(&adapter->init_done, timeout)) {
+		dev_err(dev, "Initialization sequence timed out\n");
+		return -1;
+	}
+
+	if (adapter->init_done_rc) {
+		release_crq_queue(adapter);
+		return adapter->init_done_rc;
+	}
+
+	if (adapter->from_passive_init) {
+		adapter->state = VNIC_OPEN;
+		adapter->from_passive_init = false;
+		return -1;
+	}
+
+	rc = init_sub_crqs(adapter);
+	if (rc) {
+		dev_err(dev, "Initialization of sub crqs failed\n");
+		release_crq_queue(adapter);
+		return rc;
+	}
+
+	rc = init_sub_crq_irqs(adapter);
+	if (rc) {
+		dev_err(dev, "Failed to initialize sub crq irqs\n");
+		release_crq_queue(adapter);
+	}
+
+	return rc;
+}
+
 static struct device_attribute dev_attr_failover;
 
 static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
-- 
2.7.5
