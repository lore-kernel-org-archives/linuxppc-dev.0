Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACE606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PCP4CIb5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJhB0MjJz2xjQ;
	Thu, 19 Nov 2026 11:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046874;
	cv=none; b=GogKJ+Q3BFiMO2IVTmubH6SkKGGyW26cHdHg0VJi58NrqnCfYLDgRJ4sdhNPlTz933Sht51D+qJywZRwnVAY6v7sCxSZBMagiUp+bchnrMCwJ91Sb0r+BoVa7rEtTiKPBBUD3VWGRdNEV7vi+gfbngxjz/cRmCh5TvJlzyCaePnlQYdF7GKTRJIPHhqLTHoI2eXMDFbuxDlrR2PW8u6uZUnQqopXdcLIhsiEfdlai+hdD8Qu2+K0llLIK0WqM3gIQyWlTb++JEN7oA7YlHbHkADQQLUcyzyYUZ52SmB6Sh+JtTNi7EaGexl9CGoEa6wKS7LULH+26JquB8oiJvpC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046874; c=relaxed/relaxed;
	bh=WPrAkWK1BfpDdIc33SPNm7qdbWQuYdhOJGfPwyabjGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rz6sHSkUTjyC4ugdYBpWn8xEC9wo8t0iDKq7CbfiVGgxLI+ydQUvZaVSUMblQDNS/qf3V1cK8yxRsRbRxC53VCWyIKAmDt9GWezzSmRkyKg1g/pD9tuDxbW+pmILSBbQukwmqnTMxxAD1bhkrW8VvIM4ntebSbGuWMj4MrM9HtTh0An78HLmE8mUBEU6iiIjuaqVPPSRI5SlDktiCCaRPlZv5o7uh7It2In2yPk9Mg8ZbVAWZcKRb0nrJKpmZ8kJm6l9ARmx3LIDHWXim7pSMqAhkLcgNSywzwQJSaM3+pWXqpMRfhuG2Y1wk1E6Eem9shR2f0SRfifLJ5janIi+Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PCP4CIb5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PCP4CIb5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJh917tTz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:52 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQcGr2240616;
	Thu, 19 Nov 2026 00:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WPrAkWK1BfpDdIc33
	SPNm7qdbWQuYdhOJGfPwyabjGM=; b=PCP4CIb5e9a3xtVesvW3ReQEmtpe/0DWi
	1+VUWaTmAW61b1VWVVOXZ894KlnqM5V4rsG+t0MJpF1tY0wQp2ilJ8vBM7XlmXQY
	kSVdYE7ivy/czhEAfBBCPFY6Hf50R8lxyJE/+byYVa3UZsNmBZBwpdwbRH0VFLod
	ty/udSsgBVBLunPx3hMN0LOmeZqmXBThkw6CoQn5XRadh4L28BnZ43N7sFsm92WB
	E0iQCu+kRWd65GOfmUPX3r7CwM0iHbvBYHn8xxylknV/cr9AmQ2mVuTH0ZP/8WAN
	dlaGBVRVTNPsIN+kJp8Frjm+fJTje//V/JEaX1hw6q1pSAYdx2izA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vn5pd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILbNMW3716181;
	Thu, 19 Nov 2026 00:07:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3hrd59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ06mTT34537766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:06:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53BBF5805A;
	Thu, 19 Nov 2026 00:07:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB7E458051;
	Thu, 19 Nov 2026 00:07:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:36 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 6/8] ibmveth: Add RX queue register helpers for MQ
Date: Wed, 18 Nov 2026 16:07:09 -0800
Message-Id: <20261119000711.18093-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: NCckyfdmxUN110_Ck0UxLzMU_mZ7UP8T
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afe3dce cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=YgAxCJhiS3bUF3PW2GoA:9
X-Proofpoint-ORIG-GUID: Ndmubhzd79sirAmokr6GABDkBiXn0BuT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX14zWJldYCldb
 41UYWl5oDBxIcos5n1/nLgyZGoRT6985bBDaoLTnl5uaUAjPQrD043RmMBg3HtPE8MEG3b2SVSl
 aIREv+6NVbU3YHLNPHdkTkO/j50jdT2ZFvR/9Jwc/XgEoYSYM4kRNJ8QYMoAOSTx/PyJRZYO4Pc
 L91rZEXkHvghUKLFdeK5Y52KRXOnEJCOtVO3uDasUHB5x68m8nrVv75QNQrwUbS5dQryuNlSBW0
 P1og/0+lhJEQNEMXXRCDLFjY+NHyk6gOz4iOeqgw8FTKeiLu+9NwpWTInVH+ewWfyENbxlkIDAO
 DmY8kebNgtaXKAzmwGuLSU3842wT6eADvhpjmjYbo/+tO0EXYpywE5CatfZpWhQTjzDUuBOe8rL
 ci4qvscQh8Wo1Q08ZxaWhkSK4z5QiFJQwfEFY5Ou/qCQZ+39YWp4xJlXlpDJW1kJ2mhh9ADqKVV
 RAdA43pUyw4is3qjz9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX2j4wt3nDtpN/
 hjIHwFXz7PHdX6LEEUrJkEizViExWNPHZMLvetNwBXtDLKjLuueODYD9arqA6tP9bhsS9NqewXJ
 wQEhYGsXNVGflxXd3NpnCz+a/YyC8Pg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180088
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

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 154 ++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 8f32f75f2d7f..ab8c5f6a265b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1088,10 +1088,34 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
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
@@ -1099,14 +1123,11 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
@@ -1115,14 +1136,72 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
+	int rc;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
+	adapter->queue_irq[0] = netdev->irq;
+
+	rc = ibmveth_disable_irq(adapter, 0);
+	if (rc)
+		netdev_dbg(netdev,
+			   "Failed to disable IRQ for queue 0 before registration, rc=%d\n",
+			   rc);
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
@@ -1143,33 +1222,19 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_filter_list;
 
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
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc) {
+		/* A kexec can leave the LAN registered by the old kernel
+		 * (see ibmveth_register_logical_lan()); do not leave its
+		 * buffers live in PHYP.
+		 */
+		ibmveth_free_logical_lan(adapter);
 		goto out_free_queue_mem;
 	}
 
-	rc = ibmveth_alloc_buffer_pools(adapter);
+	rc = ibmveth_register_rx_queues(adapter, mac_address);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_free_buffer_pools;
 
 	/* Enables NAPI, so everything ibmveth_poll() touches must exist:
 	 * netpoll during the direct close()/open() pairs, or a direct
@@ -1177,7 +1242,7 @@ static int ibmveth_open(struct net_device *netdev)
 	 */
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_free_all_queues;
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
@@ -1200,10 +1265,9 @@ static int ibmveth_open(struct net_device *netdev)
 
 out_cleanup_rx_interrupts:
 	ibmveth_cleanup_rx_interrupts(adapter);
-out_unregister_lan:
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+out_free_all_queues:
+	ibmveth_free_all_queues(adapter);
+out_free_buffer_pools:
 	ibmveth_free_buffer_pools(adapter);
 out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
@@ -1216,7 +1280,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	long lpar_rc;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1232,14 +1295,7 @@ static int ibmveth_close(struct net_device *netdev)
 
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
 	/* netif_tx_disable() above keeps xmit off the TX LTBs. */
 	ibmveth_free_tx_resources(adapter);
-- 
2.50.1 (Apple Git-155)


