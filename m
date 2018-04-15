Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PSyh51bpzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 09:53:48 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3FNnKDH018887
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 19:53:45 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hcdfjcxsx-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 19:53:45 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Sun, 15 Apr 2018 17:53:44 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, jallen@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, benh@kernel.crashing.org,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH] ibmvnic: Clear pending interrupt after device reset
Date: Sun, 15 Apr 2018 18:53:36 -0500
Message-Id: <1523836416-16531-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to a firmware bug, the hypervisor can send an interrupt to a
transmit or receive queue just prior to a partition migration, not
allowing the device enough time to handle it and send an EOI. When
the partition migrates, the interrupt is lost but an "EOI-pending"
flag for the interrupt line is still set in firmware. No further
interrupts will be sent until that flag is cleared, effectively
freezing that queue. To workaround this, the driver will disable the
hardware interrupt and send an H_EOI signal prior to re-enabling it.
This will flush the pending EOI and allow the driver to continue
operation.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index f84a920..ef7995fc 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1034,16 +1034,14 @@ static int __ibmvnic_open(struct net_device *netdev)
 		netdev_dbg(netdev, "Enabling rx_scrq[%d] irq\n", i);
 		if (prev_state == VNIC_CLOSED)
 			enable_irq(adapter->rx_scrq[i]->irq);
-		else
-			enable_scrq_irq(adapter, adapter->rx_scrq[i]);
+		enable_scrq_irq(adapter, adapter->rx_scrq[i]);
 	}
 
 	for (i = 0; i < adapter->req_tx_queues; i++) {
 		netdev_dbg(netdev, "Enabling tx_scrq[%d] irq\n", i);
 		if (prev_state == VNIC_CLOSED)
 			enable_irq(adapter->tx_scrq[i]->irq);
-		else
-			enable_scrq_irq(adapter, adapter->tx_scrq[i]);
+		enable_scrq_irq(adapter, adapter->tx_scrq[i]);
 	}
 
 	rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_UP);
@@ -1184,6 +1182,7 @@ static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter)
 			if (adapter->tx_scrq[i]->irq) {
 				netdev_dbg(netdev,
 					   "Disabling tx_scrq[%d] irq\n", i);
+				disable_scrq_irq(adapter, adapter->tx_scrq[i]);
 				disable_irq(adapter->tx_scrq[i]->irq);
 			}
 	}
@@ -1193,6 +1192,7 @@ static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter)
 			if (adapter->rx_scrq[i]->irq) {
 				netdev_dbg(netdev,
 					   "Disabling rx_scrq[%d] irq\n", i);
+				disable_scrq_irq(adapter, adapter->rx_scrq[i]);
 				disable_irq(adapter->rx_scrq[i]->irq);
 			}
 		}
@@ -2601,12 +2601,19 @@ static int enable_scrq_irq(struct ibmvnic_adapter *adapter,
 {
 	struct device *dev = &adapter->vdev->dev;
 	unsigned long rc;
+	u64 val;
 
 	if (scrq->hw_irq > 0x100000000ULL) {
 		dev_err(dev, "bad hw_irq = %lx\n", scrq->hw_irq);
 		return 1;
 	}
 
+	val = (0xff000000) | scrq->hw_irq;
+	rc = plpar_hcall_norets(H_EOI, val);
+	if (rc)
+		dev_err(dev, "H_EOI FAILED irq 0x%llx. rc=%ld\n",
+			val, rc);
+
 	rc = plpar_hcall_norets(H_VIOCTL, adapter->vdev->unit_address,
 				H_ENABLE_VIO_INTERRUPT, scrq->hw_irq, 0, 0);
 	if (rc)
-- 
1.8.3.1
