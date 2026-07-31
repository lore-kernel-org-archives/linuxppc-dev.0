Return-Path: <linuxppc-dev+bounces-25151-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7139AC55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6qt2CFHz2ygL;
	Fri, 31 Jul 2026 10:48:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458890;
	cv=none; b=ExHraIL4SXJIt/iyryeZACxqYIKMIGK1BUKVbU0rl+zof2dFyOZu8mQY6CgblrJ4rn+7zcUoXX1hG578449AnUyjcUUcJ0im3lAhijY1v7CYLdd78XvYj7T5ZBuy3Jqt8vCo4vbUi9Ji2YkkjTLe29w20ScZtrmTDVVjBB+1yILG5HeiW7DwCEdew4HC8ABe61BQ70s1dA1J5lF1HpmLekPztV9rwgw6i+m88xMnc5cQGGVy7ewb1E5tBXLhWEErWF7kl08UV541iL2hbFqGqUJ1uca44loyS1GqrOSA0fpF8Bby0GDcAhGwVA4taAHxCr3cEumvV8GLgSet+WHXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458890; c=relaxed/relaxed;
	bh=Xmh2Akf2Kx6rIEkJpZPibYaonPdltsDwdIiWacWbvnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSXA2PZQA2Pd99GuuElIzJWBIl+2Fo8IfrrnX6iLY6M9shBH4O0CkHUKKHofonHS3dkX4tQ7yqvoQ3jzJf6xzyW8xSkP9hmWzHrz1zj3n5XvOvTtQnV42b+GerJSMkNp5fMWkC9E5HfaZgooHuB1FXhIV2MtO3nhRA8B+ikppwdkZ0jAiI/GXOnSC6UHNOkvJaC5xMB+7qK5iAvqcX7lqkbjMm1CAFMEOul3BhEQZnt4neC5bnyxUqEGIR8KlVGgjkZXIaQhI4TYYCiIKqqsjIHNXdGXPQkQuHCNiWI98gPMm6FowQaNkvIeyInMWsU61VdOWNk1V/QdkemDgMtM4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PRe0lYH6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PRe0lYH6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6qq4GCDz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:07 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNI9Au2519230;
	Fri, 31 Jul 2026 00:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xmh2Akf2Kx6rIEkJp
	ZPibYaonPdltsDwdIiWacWbvnE=; b=PRe0lYH6W+bFPy1ra7Nl92+3/44JcZQFv
	FVG4bxOwDQyrIXVK2vwNLmu2UiB5gAlXTuMLYaTHgBhDzhHHhFrUNTmfDWE7i0SV
	CwXvDfHBkLpgvsZJFU60fzGjSpGjL/h9nv1YAQEJKxgv0Rto2Nt5b/kxTJCULenL
	+XIfGIXii09P/ojdZaqOIX1SiVo9+bk0lKxPeye4we2U9pHtPGZr6wzwbnoqTdk2
	h9ULvSdoLxvCtSjohiGX1BC+8MNM4iZGv/tUzptxNqGZLbPvnFaIFz+PHYxx3oHh
	FKhbVdX03Syk14HDvWDbD+8BRJixe8/hUhBqUFbnyUwbqawijnErw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycthhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fcSE016841;
	Fri, 31 Jul 2026 00:47:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhns06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lsOx34341454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD61D58058;
	Fri, 31 Jul 2026 00:47:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C161658057;
	Fri, 31 Jul 2026 00:47:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:53 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 06/14] ibmveth: Refactor TX resource allocation in open/close paths
Date: Thu, 30 Jul 2026 17:47:09 -0700
Message-Id: <f6e2721c3c664f789a72594d64c7b586ef1ce108.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: tMtDFdFLoLaQtSQgamqp21Q0Jtjv8PVx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX22l9Ovzg2H/Q
 dZbNtmnvcwKgW62JK5y+Bvi866adi9WfggwVFFbQIOykj9zf6m0yhXrUo5URDAIZi/zgMQbedLF
 uVXK9CrGEU78+VSgklUuf2NVHYbRUT9wSs2JIAkETWcM4TSxJ/fQAVXLFI7ofgVOjRej3f9TF0Y
 BEMtzrc52jipygmdKuE30NSYNvHM9S0RVo9n3z2xQyZrCyf3TGcBbCCpc3oEeTMfSl41Jvnxp6Z
 hhy50RfOP+by3FeuLvQb0LKbhiQG/wL5bcOaoGT4M4x/FoVw1VffO/7UFLMYFtCUiXfTv69Pewc
 QK90el+Uw+rO4Mn1HBdgOszZz9I+5/s12xYz5keJiIQ8oTUBSj0RyjKypcxfGmeZSotM/suCZ5x
 A+p8MYFckd6MKnYlgLMvI0l52nWh1pqL9QPEW3ELGiGWrJVzCiGwDoUO3xBvEoC3kWjg7Xc/wpn
 7GnNIGrra2cPzTGs4PQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX1FH4bXWhGO65
 RVEPl5V/KKLpSMTDwpJClrqQ6qBAnGk4EVmDeNEQYn+vpF6wVpQIy9SsBo5WeFaglMRWZ9HydYj
 YommfRGXzyN3/MSs2uY4D5TQcYZ/g+A=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bf0be cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=TNYWkx2eXG3FstYr7TUA:9
X-Proofpoint-GUID: 6xLMqt9DtgHP_q_ODa6hzGn78xe3DAlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

Same story as the RX refactor: pull TX LTB alloc/free out of open/close
into helpers and wire them in this patch.

  ibmveth_alloc_tx_resources()
  ibmveth_free_tx_resources()

They wrap the existing per-queue allocate_tx_ltb() / free_tx_ltb()
primitives. alloc_tx_resources() allocates every TX queue and unwinds
partial failure itself; free_tx_resources() walks real_num_tx_queues.
TX was already multi-queue capable via ethtool -L, so there is no MQ
RX behaviour change here.

Also tighten TX LTB lifetime: free_tx_ltb() is safe on an unallocated
slot and clears tx_ltb_dma[] after unmap; allocate_tx_ltb() clears
tx_ltb_dma[] after DMA-map failure.

Move TX LTB allocation to the end of open(), after LAN registration,
RX pools, RX interrupt setup, and the initial replenish kick. A late
alloc_tx_resources() failure jumps to out_cleanup_rx_interrupts and
must not call free_tx_resources() again: alloc already freed any
partial TX LTBs. That also retires a mid-open TX leak where the old
index-based while (--i) free could skip successfully allocated LTBs.

close() uses free_tx_resources() and cleanup_rx_interrupts().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Introduce the TX resource helpers in the same patch that wires their
  first open/close callers.
- Do not free TX LTBs again after a failed alloc_tx_resources();
  harden free_tx_ltb() against unset slots.
- Move TX allocation after RX IRQ setup / replenish kick so open()
  failure unwind no longer depends on a shared loop index (also fixes
  a mid-open TX LTB leak).

 drivers/net/ethernet/ibm/ibmveth.c | 90 ++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 664169c4d27a..131c1a61d9e7 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1077,8 +1077,14 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
-	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
-			 adapter->tx_ltb_size, DMA_TO_DEVICE);
+	if (!adapter->tx_ltb_ptr[idx])
+		return;
+
+	if (adapter->tx_ltb_dma[idx]) {
+		dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
+				 adapter->tx_ltb_size, DMA_TO_DEVICE);
+		adapter->tx_ltb_dma[idx] = 0;
+	}
 	kfree(adapter->tx_ltb_ptr[idx]);
 	adapter->tx_ltb_ptr[idx] = NULL;
 }
@@ -1101,12 +1107,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 			   "unable to DMA map tx long term buffer\n");
 		kfree(adapter->tx_ltb_ptr[idx]);
 		adapter->tx_ltb_ptr[idx] = NULL;
+		adapter->tx_ltb_dma[idx] = 0;
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
+/**
+ * ibmveth_alloc_tx_resources - Allocate TX resources for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Allocates TX Long Term Buffers (LTBs) for all TX queues.
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++) {
+		if (ibmveth_allocate_tx_ltb(adapter, i))
+			goto err_free_ltbs;
+	}
+
+	return 0;
+
+err_free_ltbs:
+	while (--i >= 0)
+		ibmveth_free_tx_ltb(adapter, i);
+	return -ENOMEM;
+}
+
+/**
+ * ibmveth_free_tx_resources - Free TX resources for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees TX Long Term Buffers (LTBs) for all TX queues.
+ */
+static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++)
+		ibmveth_free_tx_ltb(adapter, i);
+}
+
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
         union ibmveth_buf_desc rxq_desc, u64 mac_address)
 {
@@ -1157,12 +1205,6 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_filter_list;
 
-	rc = -ENOMEM;
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		if (ibmveth_allocate_tx_ltb(adapter, i))
-			goto out_free_tx_ltb;
-	}
-
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
@@ -1184,35 +1226,38 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_free_tx_ltb;
+		goto out_free_queue_mem;
 	}
 
 	rc = ibmveth_alloc_buffer_pools(adapter);
 	if (rc)
-		goto out_free_tx_ltb;
+		goto out_unregister_lan;
 
 	rc = ibmveth_setup_rx_interrupts(adapter);
-	if (rc) {
-		do {
-			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-		goto out_free_buffer_pools;
-	}
+	if (rc)
+		goto out_unregister_lan;
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
 
+	rc = ibmveth_alloc_tx_resources(adapter);
+	if (rc)
+		goto out_cleanup_rx_interrupts;
+
 	netif_tx_start_all_queues(netdev);
 
 	netdev_dbg(netdev, "open complete\n");
 
 	return 0;
 
-out_free_buffer_pools:
+out_cleanup_rx_interrupts:
+	ibmveth_cleanup_rx_interrupts(adapter);
+out_unregister_lan:
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	ibmveth_free_buffer_pools(adapter);
-out_free_tx_ltb:
-	while (--i >= 0)
-		ibmveth_free_tx_ltb(adapter, i);
+out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
 	ibmveth_free_filter_list(adapter);
@@ -1224,13 +1269,13 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	netdev_dbg(netdev, "close starting\n");
 
 	netif_tx_stop_all_queues(netdev);
 
 	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
+	ibmveth_free_tx_resources(adapter);
 	ibmveth_cleanup_rx_interrupts(adapter);
 
 	do {
@@ -1248,9 +1293,6 @@ static int ibmveth_close(struct net_device *netdev)
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
-		ibmveth_free_tx_ltb(adapter, i);
-
 	netdev_dbg(netdev, "close complete\n");
 
 	return 0;
-- 
2.50.1 (Apple Git-155)


