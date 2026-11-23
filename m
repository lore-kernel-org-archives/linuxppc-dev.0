Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E21606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PEFQviJP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXypL15Yjz3blC;
	Mon, 23 Nov 2026 18:52:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420346;
	cv=none; b=RpoZGLcmzHqP1ovLsZAb6rKQBRN+0zrjZLLCD4Y/kgxoA8baxSt4A4QU8MNiWgus0R5UsJfGWLdizxhdlKopUcT6CH/Dfnsh/LrLkxay9zbngHORgDlNQCcvR/DUd6CcnIQuTErTVofqfhbCFdtVU9IVAlE4YokQQy0YW8SK6jUi7ydVFHw375j6LqHJydj/j64LT/6VSO05nU5oXbx05D5s3nP0TI0LhroR5qhfIYRJyfzxD3KZHDXz3JFcf80I5U8QzVLQunQjhFvgR5THRaxVXJwlXlolReM0GNTwbDRxrNDPruliF0N/ZGFW7zl+oAka9B2gAlTPiVVmbDXePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420346; c=relaxed/relaxed;
	bh=KnOIJk/RMmeleRCY2NRMFLsmyVcUumuOpJWizkz6jyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ni7D7QRutcgr6YLMMgVF+M4u7/anf+Hc6qVDKEmnPwLKzmxlW+UfpwYTPhWrJn63a2SN6d65ybP/Hbe3ykRPa+ZfvaEGXhhNzDN3JbLWnzXjtENHbTDElakcDs2oa8TQMR7QHtJflh3fu7vgDF51oZcQTm/40JGnCBDKABi4WFArkFbXvqw64jFGOWHM0DS7Tqmxeuy4I/PeDs/KOeKXQUFp0fWaZwb/3D+wBoT1VXOsdeDWo99uQod/NOVDdxMSAW8WFY6G1vTcy6OaP+DGv1x6HbV8Qm6SrzjVS34OcpWWJsv3Y0f+IUTBrA2LpTeOZhpQU5HI36rqKYuLH1fnEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PEFQviJP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PEFQviJP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXypK1pRzz3bkG
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:52:25 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN556Ix2623213;
	Mon, 23 Nov 2026 07:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KnOIJk/RMmeleRCY2
	NRMFLsmyVcUumuOpJWizkz6jyw=; b=PEFQviJP6q7q4/7R6YJrA9oMzGAtOHEIJ
	f1dUGHAwKBzWWvveLHRy1rgl+r9E/PHmUzdLJUx1yHMjvCZHrV15v4etdKVvNBX+
	pSn2zhpbaCuHUGu28PA5m6L1MiGEqwl7iIEi9eYNpVdKfjfTUoz1kIyj/qokFmde
	yu7OEHUXjfJe90O7t68B64+rZMm61d+zqowBOFdKykO6eHO7TfYtQb6WmeC3BRVA
	zBoaX9ZeLe/GOsanAeaQR05Ea3OYX3c4CfZLGObbOgD9ylz+Y5Q4jJkjkuu/jDCE
	4+NDvbS89WEg5uWhVenZPIYQbiMzgklnqp24WbfADgYu7vflrSikQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fka3p0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:52:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54Efa1346409;
	Mon, 23 Nov 2026 07:52:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqe15m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:52:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7q1nD29622806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:52:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD9B35803F;
	Mon, 23 Nov 2026 07:52:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6268B58056;
	Mon, 23 Nov 2026 07:51:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:59 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 6/8] ibmveth: Add RX queue register helpers for MQ
Date: Sun, 22 Nov 2026 23:51:34 -0800
Message-Id: <20261123075136.3278-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261123075136.3278-1-mmc@linux.ibm.com>
References: <20261123075136.3278-1-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfXxdQ+OhL8l+uR
 AJSAWlFJNPRzSgYfsSE9lByELqHIbSGIztQi2C0J2N/qmB2PS5umaQi0Xwms3qmFN9do+zf/Vh1
 rqTCf6rCIq4oWin5jWXXXOt4t6N1bi0JeuOO/8NXxPGnQXC42J+pHY5eBQC7V5aChjtQYV6Z16B
 Qgwu3n8dXXbQAVdIhM7rtsXO+kj8q2YIcbcUrSNdXH6f6wj6tydclth2DJ14SDlEvWn09cNyV4t
 /msfu5suF93Ow3n7i97hT2qwMFxrl3LXqAZwiL9HZn4sWnflLTGVUxRYgem5VKrlykF6sDIoDt+
 nliKn07znbsjdvbLvxn23IwKbBm5lcU/bm5MoOOJX85OnSs02KHp4uu+tXVAagMvCb96KhJMASc
 N/MtuM7334zPERMuSFe464/soxfJPB/8ur9GZ3lqJ0+4qZgdF4qOGg5qOii6XeThy7Xwll9s1UH
 Ccu9BQM9SxqnkGSXOvw==
X-Proofpoint-ORIG-GUID: uqRMsqYDIxZMARQ2_HZ-N79T49f-8InQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX9X3WsxyPx06H
 kYy5ZF+FR8WUXfEWWliKRvYHKcdwWdVdLN8Vn49l8/LM4XpTr+6ai9nH7GvDsokkR1LIGPaM+ki
 nOVJ6Hr8oAtrHCCYUfBQ8id22pyMux4=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b03f0a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RRdia9iRzB-DQCvl0TEA:9
X-Proofpoint-GUID: jiLScXFH3xeGS5VOB22t4ZWoviXDARDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move logical LAN registration and teardown out of open() and close()
into ibmveth_register_rx_queues() and ibmveth_free_all_queues(). The
three H_FREE_LOGICAL_LAN busy loops (kexec retry in register, pool
fail before register, close) share ibmveth_free_logical_lan().

open() now allocates the buffer pools before registering, so a pool
failure never has a LAN this kernel registered. A pool failure still
issues one H_FREE_LOGICAL_LAN, as before, so a kexec leftover is not
left registered.

A failed H_FREE_LOGICAL_LAN is now logged as "h_free_logical_lan
failed: %ld", in decimal like the other hcall errors, instead of
close()'s "failed with %lx, continuing". The open() error path logs it
too. ibmveth_register_logical_lan() returns the hcall status as a long.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- drop the duplicate IRQ-disable debug log (Sashiko)

 drivers/net/ethernet/ibm/ibmveth.c | 149 +++++++++++++++++++----------
 1 file changed, 100 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 06741a6756b8..0bda9b145b1e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1094,10 +1094,34 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 		ibmveth_free_tx_ltb(adapter, i);
 }
 
-static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+/**
+ * ibmveth_free_logical_lan - Busy-retry H_FREE_LOGICAL_LAN
+ * @adapter: ibmveth adapter structure
+ *
+ * Retries while PHYP returns H_BUSY or a long-busy code.
+ *
+ * Return: the last hypervisor return code
+ */
+static long ibmveth_free_logical_lan(struct ibmveth_adapter *adapter)
 {
-	int rc, try_again = 1;
+	long rc;
+
+	do {
+		rc = h_free_logical_lan(adapter->vdev->unit_address);
+	} while (H_IS_LONG_BUSY(rc) || rc == H_BUSY);
+
+	return rc;
+}
+
+static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
+					 union ibmveth_buf_desc rxq_desc,
+					 u64 mac_address)
+{
+	long rc;
+	int try_again = 1;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long buf_dma = adapter->buffer_list_dma[0];
+	unsigned long filter_dma = adapter->filter_list_dma;
 
 	/*
 	 * After a kexec the adapter will still be open, so our attempt to
@@ -1105,14 +1129,11 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 * try again, but only once.
 	 */
 retry:
-	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma[0], rxq_desc.desc,
-				    adapter->filter_list_dma, mac_address);
+	rc = h_register_logical_lan(ua, buf_dma, rxq_desc.desc, filter_dma,
+				    mac_address);
 
 	if (rc != H_SUCCESS && try_again) {
-		do {
-			rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
+		rc = ibmveth_free_logical_lan(adapter);
 
 		try_again = 0;
 		goto retry;
@@ -1121,14 +1142,67 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+/**
+ * ibmveth_free_all_queues - Free all RX queues at once
+ * @adapter: ibmveth adapter structure
+ *
+ * Issues one H_FREE_LOGICAL_LAN. A failure is logged; the caller still
+ * frees the RX memory, as close() always has.
+ */
+static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+{
+	long lpar_rc;
+
+	lpar_rc = ibmveth_free_logical_lan(adapter);
+	if (lpar_rc != H_SUCCESS)
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+}
+
+/**
+ * ibmveth_register_rx_queues - Register RX queues with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @mac_address: MAC address for device registration
+ *
+ * Registers queue 0 with H_REGISTER_LOGICAL_LAN.
+ *
+ * Return: 0 on success, -ENONET if queue 0 registration fails
+ */
+static int
+ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	long lpar_rc;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
+	adapter->queue_irq[0] = netdev->irq;
+
+	ibmveth_disable_irq(adapter, 0);
+
+	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev,
+			   "h_register_logical_lan failed: %ld\n", lpar_rc);
+		netdev_err(netdev,
+			   "buffer TCE:0x%llx filter TCE:0x%llx rxq desc:0x%llx MAC:0x%llx\n",
+			   adapter->buffer_list_dma[0],
+			   adapter->filter_list_dma,
+			   rxq_desc.desc, mac_address);
+		return -ENONET;
+	}
+
+	return 0;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	u64 mac_address;
+	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
 	int rxq_entries = 1;
-	unsigned long lpar_rc;
 	int rc;
-	union ibmveth_buf_desc rxq_desc;
 	int i;
 
 	netdev_dbg(netdev, "open starting\n");
@@ -1152,31 +1226,17 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_queue_mem;
 
-	mac_address = ether_addr_to_u64(netdev->dev_addr);
-
-	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
-					adapter->rx_queue[0].queue_len;
-	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
-
-	adapter->queue_irq[0] = netdev->irq;
-	ibmveth_disable_irq(adapter, 0);
-
-	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
-
-	if (lpar_rc != H_SUCCESS) {
-		netdev_err(netdev, "h_register_logical_lan failed with %ld\n",
-			   lpar_rc);
-		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
-			   "desc:0x%llx MAC:0x%llx\n",
-				     adapter->buffer_list_dma[0],
-				     adapter->filter_list_dma,
-				     rxq_desc.desc,
-				     mac_address);
-		rc = -ENONET;
-		goto out_free_tx_ltb;
-	}
-
 	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc) {
+		/* A kexec can leave the LAN registered by the old kernel
+		 * (see ibmveth_register_logical_lan()); do not leave its
+		 * buffers live in PHYP.
+		 */
+		ibmveth_free_logical_lan(adapter);
+		goto out_free_tx_ltb;
+	}
+
+	rc = ibmveth_register_rx_queues(adapter, mac_address);
 	if (rc)
 		goto out_free_buffer_pools;
 
@@ -1186,7 +1246,7 @@ static int ibmveth_open(struct net_device *netdev)
 	 */
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_free_buffer_pools;
+		goto out_free_all_queues;
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
@@ -1203,10 +1263,9 @@ static int ibmveth_open(struct net_device *netdev)
 
 	return 0;
 
+out_free_all_queues:
+	ibmveth_free_all_queues(adapter);
 out_free_buffer_pools:
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	ibmveth_free_buffer_pools(adapter);
 out_free_tx_ltb:
 	ibmveth_free_tx_resources(adapter);
@@ -1221,7 +1280,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	long lpar_rc;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1237,14 +1295,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_cleanup_rx_interrupts(adapter);
 
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-	if (lpar_rc != H_SUCCESS) {
-		netdev_err(adapter->netdev,
-			   "h_free_logical_lan failed with %lx, continuing\n",
-			   lpar_rc);
-	}
+	ibmveth_free_all_queues(adapter);
 	ibmveth_update_rx_no_buffer(adapter);
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
-- 
2.50.1 (Apple Git-155)


