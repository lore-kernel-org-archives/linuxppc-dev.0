Return-Path: <linuxppc-dev+bounces-25845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8AFC5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:38:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGd6n9Kz3bmJ;
	Fri, 14 Aug 2026 17:38:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693097;
	cv=none; b=NjKJFDFRYy5TF9tYRcG+nVPOIOgWPEKR2lt5Tug+x/NrsYSYZdOcN9NTuF19IBp7JOykbjdFVv8Dwe8ZNKI9GvyulabBUXCnfkJxj3thpPTlY6lPtSPXPCyxbwbBRrxa61Uu37JM4mlKPbKYxWJ3Np4uiK4e584Pq0APLBnqcnNEhoifdfjw747fV2RCFgFLujPlYP3oH11oLylHRN6gF1/HhBcKy/XCntQbkQw2xQMk6EAD+FjEx1FMr9LOuDaDsEoAlDSg2zbBQYbx4aGVR916sYY8LEwsP4hFOzIufUXUo7CTgL+PE1W/oeRvR24IYw7YkxfOb45AEAIPgz1z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693097; c=relaxed/relaxed;
	bh=WSLnUrq9Z/INQMNmz6mfA4iZ8HX1HDJHx1YErQ+l3OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZK482WjAtFYwrLm7iATJYpo1Z75Iycroo2pjKfJ9laLz+fleUE8VmeAXlyH8CB11RtzLqDNjj/ncZmE3RBN9raTPqpS57e+LaJJy9qqOZtGX4w43yXoGcoKnWEUv3mrDxk9MC9f2UgI9rmihKUdOljzSS2niUV4KfsMWTojrvY3XdNNJcuVltq/00DlKrWLEqaa2lvouT6Mu8vH1msp9qNCBK+MvsYv3KIoCW7Q7pmMS02iGRdTm0UNybThSLUiQdGPnzZ9oEhlSYqiEoOVbMd5qKPXz0juycy3bJbCFlVXSmc7vL+978n1aeN5jehR3ichSGdH+ROGfS/7cGF00g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IshkLSXt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IshkLSXt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGc2DSvz30W1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VeZP182761;
	Fri, 14 Aug 2026 07:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WSLnUrq9Z/INQMNmz
	6mfA4iZ8HX1HDJHx1YErQ+l3OU=; b=IshkLSXt/T8EEiz5/E+nUM9lJwJP29MGK
	equ/3347VtXyFSvRMACHGfJ1/uN8d2L4iiCjocbmY7zaoL3iKRIZs+nSyhAwx9lw
	0UwsOlcSJTO2vnkuVbp6wCrwK5YhlH4QtX/NGM4i1Jojcc9AHfckB3nQoE/hESun
	GSN36OrnNolSpCal0z1g5fzhtOh0NJuRY/CKQowYCzc8qr+nbgOaiRwLd+Dckv5U
	vGGmwccLI9Qapnx/+jEKUrj+F8Wrtf9EnZOkG27pFMgCHMHZY0WC15IlmVky64Nb
	Rrck+boCFExQOa18hCexopa2d2VlHmD67Qu1wkW6K8LNfefbtINSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwjmff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QJVL002726;
	Fri, 14 Aug 2026 07:38:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqejjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7c0V111535034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C8F558061;
	Fri, 14 Aug 2026 07:38:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A0C58057;
	Fri, 14 Aug 2026 07:37:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:37:58 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 06/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Fri, 14 Aug 2026 00:36:33 -0700
Message-Id: <20260814073642.24630-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260814073642.24630-1-mmc@linux.ibm.com>
References: <20260814073642.24630-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ec5dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=QI5arGAyr2GC0cwn9DMA:9
X-Proofpoint-GUID: yeJNf9ptw999JZ7f9pd5DAaprhqTBSAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX9qNu5eaXcEiX
 j2CimKVE6IXWNDJ4Blza6zNwJ5NbqOwYSvWSmXhrzdNZBzuYkA/uYHVvz9g4o/2mLfIUdv2aEID
 Vm838O7FrPe5n5LivOQbL29ivBm8yOE2xMvKjZ698XtkVyA6Qdgj0ftxLJMFDMcYmH9U+1nrNtr
 Wt+99r14mPq8UY0xnOVDUFWp65JCWC9y41NzTfapLL0gSgNtFOt/m8HIQSGFonW4QI7wQOTj/il
 2cLEXt67ky4ldegQhuaxNhgVOTSEkugBQhYM+3doRRYlBjZ7WxKqmAZF03vYH1To1Lp1crakbRi
 VGn6IsY8R5lUp6Z4lHItXsiBh4j/2cdJP8UeN24fmyji+G8Un4g2h5UIKbVXPXWZG47JiBXGqLh
 MhVrkcncZ5Tgytfp9lbPboOYP5vRWSBudqPArm4zr/refw5rgneVDWJFh5POPEgp8nd9YUyzOUV
 vgYbjqaCG1Sjfe58aIw==
X-Proofpoint-ORIG-GUID: E0DwGCK6FA-0ebbRN9bTma7bfYnAkQFG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX1Vs+KilHGC31
 o0eJHdMNl44e8x0AYmkL3mIl0UXImvIIwj11KFlmPmxcudlmnZsJLABa1iX+wuKRgOnwd/2pz/O
 VxpQ0CrkhGHIAPt9+vz9U7VGbIZ1740=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Same story as the RX refactor: pull TX LTB alloc/free out of open/close
into helpers and wire them in this patch.

  ibmveth_alloc_tx_resources()
  ibmveth_free_tx_resources()

They wrap the existing per-queue allocate_tx_ltb() / free_tx_ltb()
primitives. alloc_tx_resources() allocates every TX queue and unwinds
partial failure itself; free_tx_resources() walks real_num_tx_queues.
The helpers remove dependence on shared open/close loop indices and
match the RX helper structure. TX was already multi-queue capable via
ethtool -L.

Also tighten TX LTB lifetime: free_tx_ltb() keys off tx_ltb_ptr[]
presence (not a dma==0 sentinel) and clears tx_ltb_dma[] after unmap;
allocate_tx_ltb() clears tx_ltb_dma[] after DMA-map failure.

Move TX LTB allocation to the end of open(), after LAN registration,
RX pools, RX interrupt setup, and the initial replenish kick. A late
alloc_tx_resources() failure jumps to out_cleanup_rx_interrupts and
must not call free_tx_resources() again: alloc already freed any
partial TX LTBs. start_xmit() bails if tx_ltb_ptr[] is gone so RX can
be live while TX LTB alloc still runs (and so close/failed-reopen with
IFF_UP set cannot UAF).

After LAN registration, open-fail teardown frees the logical LAN before
tearing down RX pool DMA (intentional safer order than leaving the LAN
registered while unmapping RX memory).

close() quiesces TX with netif_tx_disable() (stop_all_queues does not
wait for in-flight ndo_start_xmit), then frees LTBs after
h_free_logical_lan() via free_tx_resources() - required because direct
close() callers bypass synchronize_net().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- Quiesce TX with netif_tx_disable before free (stop_all_queues does not
  wait for in-flight xmit); free LTBs after h_free_logical_lan - direct
  close() callers bypass synchronize_net()
- Guard start_xmit if tx_ltb_ptr gone so open can leave RX live while TX
  LTB alloc still runs (also covers close/failed-reopen with IFF_UP set)
- Drop fake mid-open TX-leak / Fixes: motivation; reword as helper
  extraction matching RX (shared loop-index independence)
- Free TX LTB by pointer presence (drop dma==0 sentinel; dma_mapping_error
  already cleared the slot on map failure)
- Document intentional open-fail LAN-first unwind (free_lan before RX
  pool/DMA teardown) rather than leaving it silent in a TX-only refactor
- Drop drive-by blank-line cosmetics (header / start_xmit)

Changes in v4:
- Introduce the TX resource helpers in the same patch that wires their
  first open/close callers.
- Do not free TX LTBs again after a failed alloc_tx_resources();
  harden free_tx_ltb() against unset slots.
- Move TX allocation after RX IRQ setup / replenish kick so open()
  failure unwind no longer depends on a shared loop index (also fixes
  a mid-open TX LTB leak).

 drivers/net/ethernet/ibm/ibmveth.c | 98 +++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 99eeb6ef51bf..b39e8c53cbfd 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1183,8 +1183,12 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
+	if (!adapter->tx_ltb_ptr[idx])
+		return;
+
 	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
 			 adapter->tx_ltb_size, DMA_TO_DEVICE);
+	adapter->tx_ltb_dma[idx] = 0;
 	kfree(adapter->tx_ltb_ptr[idx]);
 	adapter->tx_ltb_ptr[idx] = NULL;
 }
@@ -1207,12 +1211,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
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
@@ -1263,12 +1309,6 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1290,24 +1330,24 @@ static int ibmveth_open(struct net_device *netdev)
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
 
 	adapter->opened = true;
@@ -1315,11 +1355,14 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -1331,7 +1374,6 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
 	 * leave IFF_UP set after a failed reopen.
@@ -1343,7 +1385,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	netif_tx_stop_all_queues(netdev);
+	/* Disable and wait for in-flight ndo_start_xmit (stop_all_queues
+	 * alone does not). Direct close() callers bypass synchronize_net().
+	 */
+	netif_tx_disable(netdev);
 
 	ibmveth_cleanup_rx_interrupts(adapter);
 	/* Wait for softirq/poll that already passed shutdown checks. */
@@ -1359,13 +1404,14 @@ static int ibmveth_close(struct net_device *netdev)
 			   "h_free_logical_lan failed with %lx, continuing\n",
 			   lpar_rc);
 	}
+	/* Free TX LTBs after quiesce and after H_FREE_LOGICAL_LAN so xmit
+	 * cannot touch unmapped bounce buffers while the LAN is live.
+	 */
+	ibmveth_free_tx_resources(adapter);
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
-		ibmveth_free_tx_ltb(adapter, i);
-
 	netdev_dbg(netdev, "close complete\n");
 
 	return 0;
@@ -1789,6 +1835,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
+	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
+	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
 	if (ibmveth_is_packet_unsupported(skb, netdev))
 		goto out;
 	/* veth can't checksum offload UDP */
-- 
2.50.1 (Apple Git-155)


