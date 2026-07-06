Return-Path: <linuxppc-dev+bounces-23655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E80EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:37:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF3s420tz3c1L;
	Tue, 07 Jul 2026 05:36:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366617;
	cv=none; b=S6tDRHi9w11wW4AV19AQt3keLGJwZGmAFc79PeJjc2r4pPhUamaV1k6b5IChWXIDRKfQw5ejtfuPf72OKj6nGtXB289e78zDozLjI1R2VWcPlgPARYCzj9GBxY1dGMX3NOt0595jt+YpXnwSiNqWXvyOssKyyRWscgWiNxYmZQxT53hoI68CUvjt3YuBsrXF1U+o2ydwmJ4Qw6/qZjgryPhOse6qo6vJ9TEJVng+z/6RgIrB01WtJfm6UYhXMsOJcEudw3rEPaa/UapNKGWYIAyz3c7ViXMFKcmKQ9WnO90jSWpIiTYdzfS208XJAkuYdHS7BImyG6VaBwEzkvzzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366617; c=relaxed/relaxed;
	bh=zqw1xVi6f/t/VOkXx4/uYoNiNALbzmxBFB30V6L7EFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNId8kbBrck9ROe7ZBSkedGkWajj9lvV5E+dykCQO56PV2Tt6a0OyjETsCjxITRrVhs+KaMirOCVxaUy94xiDxD8N0shA9g0djmy4H57cKfbm/ZpgW4wOopUNsa5wneOU67FNE3XXpE/bsRNmMxdbrSJRv3qu+eaPcn5VaXC4bum0iqvQxA2LcYA/pcn1lG4j6a4AzPTMaGlpU6sdUyjO0D5teHYqX6jRRhzCHILbUI+9Pc2HYZRJViLeW7uadX14kO2M3IOHl7Wb8GSbglgsVquEWK2P/4Q2vrk1f12kHYWiTiRWoCQbCatLr1eCd6WwbxPtQ16AdEf60ligKq3EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZH1Ouk6E; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZH1Ouk6E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF3r1r7nz3br5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:36:56 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIsIR757035;
	Mon, 6 Jul 2026 19:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zqw1xV
	i6f/t/VOkXx4/uYoNiNALbzmxBFB30V6L7EFM=; b=ZH1Ouk6EImUxGmTkULK2oP
	dTEzaUo0wF34w8hmanaGHi0b9q8rpqv2HdpdqeOcGpqvvWf9Bn60WzlQ7f550sA+
	FsCxTk1CPmYQPepz+812dsHeOfbw3NQ519svDSBxk3xkzQOJEVS195KhslxxFqDv
	0Q+aPcVEkMbjQiaqTUt5uXVZBDzhNXinugC7tthBhcdwK846lahi0TJyQ/PQEUAD
	EJ2wp7Amy4c5BaP4CP15xUWRMioiaKdbzmJgzZOvVktdaomO8Ab0oaFIIZyvjtAt
	WCgWO+WoQRa7vuIURSRCh/Nxv04kEGn8P5llC4POAPvlYUROo14NQGxHhqs2HnJw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZQ0022405;
	Mon, 6 Jul 2026 19:36:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvy4a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JaiMF8389168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A2445805A;
	Mon,  6 Jul 2026 19:36:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2830B58051;
	Mon,  6 Jul 2026 19:36:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:43 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 07/15] ibmveth: Add RX queue register/deregister helpers for MQ
Date: Mon,  6 Jul 2026 12:35:55 -0700
Message-Id: <20260706193603.8039-8-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vJoZBXvL9LZIL3lWWPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VT_U8ovyjFOxQixdDbMGvcCJjj-QAlQv
X-Proofpoint-ORIG-GUID: DeWiXRvrj9vyfl9rFvrZw-76qciKLNxO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX13h4+E1IUHq2
 Moh3KsgbKL3Bkt2OhKvWkoEhtUGoc4e7l+caXvLs0tCuWBxeK1RTLiLGaQlU38yro3v26BN5fz5
 v19aUfcxZJJyoPM5u4pCxe03ijLLYIg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX6Hbh0xYoU6xv
 K63K5H0oaBMJ7SY65/Pr1FwAr+HM268OVS+/ADriop9bQYgvm7YsJm0WKM+BSVuXhRTsIwk/bmc
 Zz0BJQJ4Qh5BNI/n5jZe7afy6jf04+Nr4m0OOlyx97cKRGkoWlz0feZWDTowbwCAelJ8C99cT0w
 L//3fL91onOH8Avhx87vExh1M3LR9kOqA6zyCECLcueEk6w3s1ReIgtKQws6lVtb+HCtUW3Ke0n
 +iDkHO47RlApsaXMuX3CiS9N2aUSxWbhJywxVs9TBaeE5RY1UfUKZRJqa86qTCFoSmpmUcqDzp2
 AQ8nBcU8/11qpQHwDvgwfmHabjCHAYY++yOcf4blkJEV/Qsu9bJU+QKLUkEAnaN5jhHkAQQsyrm
 2nWTbO1uq/NZEO1usG9Jh33T/wbnKunJXplxTkaizpqdtvh/xB0lhBEsS2Xdi9VMQJk9z0SD1RA
 0NEyRrPtEbK0sU31duQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195

MQ RX replaces a single adapter-level register/free pair with a mixed
PHYP model: queue 0 via h_register_logical_lan*(), subordinates via
H_REG_LOGICAL_LAN_QUEUE. Subordinate registration returns queue handles
and hardware IRQ numbers that must be mapped to Linux virqs and unwound
on failure.

Add queue lifecycle helpers to isolate that control plane:

  ibmveth_register_logical_lan_queue()
  ibmveth_register_single_rx_queue()
  ibmveth_deregister_single_rx_queue()
  ibmveth_register_rx_queues()
  ibmveth_free_all_queues()
  ibmveth_dispose_subordinate_irq_mappings()

These helpers are called only when multi_queue is enabled (patch 11).
Until then open/close still use the legacy register and buffer hcall
path; legacy firmware is unchanged.

When multi_queue is enabled, queue 0 uses
h_register_logical_lan_with_handle() so all queues share the per-queue
buffer hcall path. register_rx_queues() registers with PHYP only;
interrupt delivery is enabled later from ibmveth_setup_rx_interrupts()
after request_irq(). Partial registration failure disposes subordinate virq
mappings before ibmveth_free_all_queues() clears handles;
free_all_queues() clears queue handles only — IRQ mappings are released
by dispose_subordinate_irq_mappings() or cleanup_rx_interrupts().
This commit also centralizes hcall accounting on the register/free paths.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 337 ++++++++++++++++++++++++++++-
 1 file changed, 332 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 63b0184c622a..7fc11a4e1f61 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -21,6 +21,8 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/ethtool.h>
@@ -399,6 +401,28 @@ ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
 	return ibmveth_toggle_irq(adapter, queue_index, true);
 }
 
+/**
+ * ibmveth_dispose_subordinate_irq_mappings - Drop virq mappings for queues 1..N
+ * @adapter: ibmveth adapter structure
+ *
+ * Subordinate queues get mappings from irq_create_mapping() during PHYP
+ * registration.  Queue 0 uses netdev->irq from device tree and is left alone.
+ * Call after free_irq() when handlers were installed, or alone when open
+ * fails during register_rx_queues() before request_irq().
+ */
+static void
+ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i]) {
+			irq_dispose_mapping(adapter->queue_irq[i]);
+			adapter->queue_irq[i] = 0;
+		}
+	}
+}
+
 /**
  * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
  * @adapter: ibmveth adapter structure
@@ -1082,8 +1106,8 @@ ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-				   union ibmveth_buf_desc rxq_desc,
-				   u64 mac_address)
+					union ibmveth_buf_desc rxq_desc,
+					u64 mac_address)
 {
 	int rc, try_again = 1;
 
@@ -1093,13 +1117,29 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 * try again, but only once.
 	 */
 retry:
-	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma[0], rxq_desc.desc,
-				    adapter->filter_list_dma, mac_address);
+	/* In multi-queue mode, obtain a queue handle for queue 0 so all RX
+	 * queues can use the same per-queue buffer hypercalls.
+	 */
+	if (adapter->multi_queue) {
+		rc = h_register_logical_lan_with_handle(adapter->vdev->unit_address,
+							adapter->buffer_list_dma[0],
+							rxq_desc.desc,
+							adapter->filter_list_dma,
+							mac_address,
+							&adapter->queue_handle[0]);
+	} else {
+		rc = h_register_logical_lan(adapter->vdev->unit_address,
+					    adapter->buffer_list_dma[0],
+					    rxq_desc.desc,
+					    adapter->filter_list_dma,
+					    mac_address);
+	}
+	adapter->hcall_stats.reg_lan++;
 
 	if (rc != H_SUCCESS && try_again) {
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
+			adapter->hcall_stats.free_lan++;
 		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
 
 		try_again = 0;
@@ -1136,6 +1176,293 @@ static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapte
 	adapter->rx_qstats = NULL;
 }
 
+/**
+ * ibmveth_register_logical_lan_queue - Register subordinate queue with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @rxq_desc: Receive queue descriptor
+ * @queue_index: RX queue index (1..N for subordinate queues)
+ *
+ * Registers a subordinate receive queue using H_REG_LOGICAL_LAN_QUEUE.
+ * On success, stores the queue handle and virtual IRQ in the adapter.
+ * Retries once if registration fails (handles kexec case).  If IRQ mapping
+ * fails after a successful hypervisor registration, the queue is freed
+ * before returning.
+ *
+ * Return: H_SUCCESS on success, negative errno on IRQ mapping failure,
+ *         hypervisor error code otherwise
+ */
+static int
+ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
+				   union ibmveth_buf_desc rxq_desc,
+				   int queue_index)
+{
+	unsigned long handle, hwirq;
+	unsigned int virq;
+	long lpar_rc;
+	int try_again = 1;
+
+retry:
+	netdev_dbg(adapter->netdev,
+		   "Attempting to register queue %d: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   (unsigned long long)adapter->buffer_list_dma[queue_index],
+		   (unsigned long long)rxq_desc.desc);
+
+	lpar_rc = h_reg_logical_lan_queue(adapter->vdev->unit_address,
+					  adapter->buffer_list_dma[queue_index],
+					  rxq_desc.desc, &handle, &hwirq);
+	adapter->hcall_stats.reg_lan_queue++;
+
+	if (lpar_rc == H_SUCCESS) {
+		virq = irq_create_mapping(NULL, hwirq);
+		if (!virq) {
+			unsigned long free_rc;
+
+			netdev_err(adapter->netdev,
+				   "Failed to map IRQ for queue %d (hwirq=%lu)\n",
+				   queue_index, hwirq);
+			do {
+				free_rc = h_free_logical_lan_queue(adapter->vdev->unit_address,
+								   handle);
+			} while (H_IS_LONG_BUSY(free_rc) || (free_rc == H_BUSY));
+			adapter->hcall_stats.free_lan_queue++;
+			if (free_rc != H_SUCCESS)
+				netdev_err(adapter->netdev,
+					   "h_free_logical_lan_queue failed for queue %d after IRQ map failure: rc=0x%lx\n",
+					   queue_index, free_rc);
+			return -EINVAL;
+		}
+
+		adapter->queue_handle[queue_index] = handle;
+		adapter->queue_irq[queue_index] = virq;
+
+		netdev_dbg(adapter->netdev,
+			   "queue %d registered: handle=0x%llx irq=%u\n",
+			   queue_index, adapter->queue_handle[queue_index],
+			   adapter->queue_irq[queue_index]);
+		return H_SUCCESS;
+	}
+
+	if (lpar_rc == H_FUNCTION) {
+		if (adapter->multi_queue) {
+			netdev_info(adapter->netdev,
+				    "Multi queue mode not supported by firmware, falling back to single queue\n");
+			adapter->multi_queue = 0;
+		} else {
+			netdev_err(adapter->netdev,
+				   "Unexpected H_FUNCTION for queue %d registration (MQ mode already disabled)\n",
+				   queue_index);
+		}
+		return lpar_rc;
+	}
+
+	if (try_again) {
+		try_again = 0;
+		goto retry;
+	}
+
+	netdev_err(adapter->netdev,
+		   "h_reg_logical_lan_queue failed with %ld after retry\n",
+		   lpar_rc);
+	netdev_err(adapter->netdev,
+		   "queue %d params: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   (unsigned long long)adapter->buffer_list_dma[queue_index],
+		   (unsigned long long)rxq_desc.desc);
+
+	return lpar_rc;
+}
+
+/**
+ * ibmveth_register_single_rx_queue - Register one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to register (1..N)
+ * @mac_address: MAC address (unused; reserved for API symmetry)
+ *
+ * Builds the queue descriptor and registers with the hypervisor via
+ * ibmveth_register_logical_lan_queue().
+ *
+ * Return: 0 on success, -EINVAL if @queue_idx is invalid, -EIO on failure
+ */
+static int
+ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
+				 int queue_idx, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	long lpar_rc;
+
+	(void)mac_address;
+
+	if (WARN_ON(queue_idx < 1 || queue_idx >= IBMVETH_MAX_RX_QUEUES))
+		return -EINVAL;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[queue_idx].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[queue_idx].queue_dma;
+
+	lpar_rc = ibmveth_register_logical_lan_queue(adapter, rxq_desc,
+						     queue_idx);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev, "Failed to register queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+		return -EIO;
+	}
+
+	netdev_dbg(netdev, "Registered queue %d with handle 0x%llx\n",
+		   queue_idx, adapter->queue_handle[queue_idx]);
+
+	return 0;
+}
+
+/**
+ * ibmveth_deregister_single_rx_queue - Deregister one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to deregister (1..N)
+ *
+ * Deregisters a single queue via H_FREE_LOGICAL_LAN_QUEUE and disposes
+ * the IRQ mapping for subordinate queues. Queue 0 is freed only through
+ * ibmveth_free_all_queues() (H_FREE_LOGICAL_LAN).
+ */
+static void __maybe_unused
+ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
+				   int queue_idx)
+{
+	unsigned long lpar_rc;
+
+	if (!adapter->queue_handle[queue_idx])
+		return;
+
+	do {
+		lpar_rc = h_free_logical_lan_queue(adapter->vdev->unit_address,
+						   adapter->queue_handle[queue_idx]);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	adapter->hcall_stats.free_lan_queue++;
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+	}
+
+	adapter->queue_handle[queue_idx] = 0;
+
+	if (queue_idx > 0 && adapter->queue_irq[queue_idx]) {
+		irq_dispose_mapping(adapter->queue_irq[queue_idx]);
+		adapter->queue_irq[queue_idx] = 0;
+	}
+
+	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
+}
+
+/**
+ * ibmveth_free_all_queues - Free all RX queues at once
+ * @adapter: ibmveth adapter structure
+ *
+ * Uses H_FREE_LOGICAL_LAN to free all queues in one hypercall.
+ * Used during interface close and registration error cleanup.
+ *
+ * Clears queue handles only; queue_irq[] is released by
+ * ibmveth_cleanup_rx_interrupts() on close, or by
+ * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
+ */
+static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+{
+	unsigned long lpar_rc;
+	int i;
+
+	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
+
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+		adapter->hcall_stats.free_lan++;
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		adapter->queue_handle[i] = 0;
+}
+
+/**
+ * ibmveth_register_rx_queues - Register RX queues with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @mac_address: MAC address for device registration
+ *
+ * Registers queue 0 via ibmveth_register_logical_lan(), then subordinate
+ * queues 1..N when multi-queue mode is enabled.
+ *
+ * Return: 0 on success, -ENONET if queue 0 registration fails, -EIO on
+ *         subordinate queue registration failure
+ */
+static int
+ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	unsigned long lpar_rc;
+	int i, rc;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
+	adapter->queue_irq[0] = netdev->irq;
+
+	rc = ibmveth_disable_irq(adapter, 0);
+	if (rc != H_SUCCESS)
+		netdev_dbg(netdev,
+			   "Failed to disable IRQ for queue 0 before registration, rc=%d\n",
+			   rc);
+
+	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev, "h_register_logical_lan failed: %ld\n", lpar_rc);
+		netdev_err(netdev,
+			   "buffer TCE:0x%llx filter TCE:0x%llx rxq desc:0x%llx MAC:0x%llx\n",
+			   adapter->buffer_list_dma[0],
+			   adapter->filter_list_dma,
+			   rxq_desc.desc, mac_address);
+		return -ENONET;
+	}
+
+	if (adapter->num_rx_queues == 1 || !adapter->multi_queue) {
+		netdev_dbg(netdev,
+			   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+		return 0;
+	}
+
+	netdev_dbg(netdev, "Registering %d subordinate queues (1-%d)\n",
+		   adapter->num_rx_queues - 1, adapter->num_rx_queues - 1);
+
+	for (i = 1; i < adapter->num_rx_queues; i++) {
+		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
+		if (rc) {
+			if (!adapter->queue_handle[i] || !adapter->queue_irq[i]) {
+				netdev_err(netdev,
+					   "Invalid hypervisor return for queue %d: handle=0x%llx irq=%u\n",
+					   i, adapter->queue_handle[i],
+					   adapter->queue_irq[i]);
+			}
+			goto err_unregister;
+		}
+	}
+
+	netdev_dbg(netdev,
+		   "registered %d RX queues with hypervisor (multi-queue mode)\n",
+		   adapter->num_rx_queues);
+
+	return 0;
+
+err_unregister:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+	ibmveth_free_all_queues(adapter);
+	return rc;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-- 
2.39.3 (Apple Git-146)


