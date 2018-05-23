Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhQ31HQNzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:49:30 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIhp0r082605
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:28 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j5afyt37c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:28 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 23 May 2018 12:49:27 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/8] ibmvnic: Introduce active CRQ state
Date: Wed, 23 May 2018 13:37:56 -0500
In-Reply-To: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1527100682-23099-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce an "active" state for a IBM vNIC Command-Response Queue. A CRQ
is considered active once it has initialized or linked with its partner by
sending an initialization request and getting a successful response back
from the management partition.  Until this has happened, do not allow CRQ
commands to be sent other than the initialization request.

This change will avoid a protocol error in case of a device transport
event occurring during a initialization. When the driver receives a
transport event notification indicating that the backing hardware
has changed and needs reinitialization, any further commands other
than the initialization handshake with the VIOS management partition
will result in an invalid state error. Instead of sending a command
that will be returned with an error, print a warning and return an
error that will be handled by the caller.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 10 ++++++++++
 drivers/net/ethernet/ibm/ibmvnic.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index eabc1e4..e6a081c 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3147,6 +3147,12 @@ static int ibmvnic_send_crq(struct ibmvnic_adapter *adapter,
 		   (unsigned long int)cpu_to_be64(u64_crq[0]),
 		   (unsigned long int)cpu_to_be64(u64_crq[1]));
 
+	if (!adapter->crq.active &&
+	    crq->generic.first != IBMVNIC_CRQ_INIT_CMD) {
+		dev_warn(dev, "Invalid request detected while CRQ is inactive, possible device state change during reset\n");
+		return -EINVAL;
+	}
+
 	/* Make sure the hypervisor sees the complete request */
 	mb();
 
@@ -4225,6 +4231,7 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 			break;
 		case IBMVNIC_CRQ_INIT_COMPLETE:
 			dev_info(dev, "Partner initialization complete\n");
+			adapter->crq.active = true;
 			send_version_xchg(adapter);
 			break;
 		default:
@@ -4233,6 +4240,7 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 		return;
 	case IBMVNIC_CRQ_XPORT_EVENT:
 		netif_carrier_off(netdev);
+		adapter->crq.active = false;
 		if (gen_crq->cmd == IBMVNIC_PARTITION_MIGRATED) {
 			dev_info(dev, "Migrated, re-enabling adapter\n");
 			ibmvnic_reset(adapter, VNIC_RESET_MOBILITY);
@@ -4420,6 +4428,7 @@ static int ibmvnic_reset_crq(struct ibmvnic_adapter *adapter)
 	/* Clean out the queue */
 	memset(crq->msgs, 0, PAGE_SIZE);
 	crq->cur = 0;
+	crq->active = false;
 
 	/* And re-open it again */
 	rc = plpar_hcall_norets(H_REG_CRQ, vdev->unit_address,
@@ -4454,6 +4463,7 @@ static void release_crq_queue(struct ibmvnic_adapter *adapter)
 			 DMA_BIDIRECTIONAL);
 	free_page((unsigned long)crq->msgs);
 	crq->msgs = NULL;
+	crq->active = false;
 }
 
 static int init_crq_queue(struct ibmvnic_adapter *adapter)
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 22391e8..edfc312 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -865,6 +865,7 @@ struct ibmvnic_crq_queue {
 	int size, cur;
 	dma_addr_t msg_token;
 	spinlock_t lock;
+	bool active;
 };
 
 union sub_crq {
-- 
2.7.5
