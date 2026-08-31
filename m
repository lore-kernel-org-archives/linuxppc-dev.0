Return-Path: <linuxppc-dev+bounces-26307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F345DC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:08:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXSS5TlBz2yrW;
	Tue, 01 Sep 2026 01:08:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188920;
	cv=none; b=nKgS6JTiWcnHOTzeroCOVevU2oc8MxwMTkXqcuhQgLuwn6e4iq8x2aoA2XQbJ3iOz2IA0sCkZXL/X9sCa9/igaW4WXDZWd7Tj10eNnwxh4ZXLJgilPHB/8XyQaI5IvOcLQeMISNkKD1l8P99ksMd8cN3UKpk3XDFpdO96yCMOTtYinJ7fp7XjI9bY1KY3caVuJUSEAftC9XZzbVOyht28yGATZHVbwxsU+qeUDwwzWUVFE7A1fVP2t+MWzxZss+AlBuCkoV9odvz+CdxeFDHhoTfzOhG+7ROAE7zVMlKBOSzKvO/ec4RZtewKTOSkReLGt1sqYjmJMaMMVM2LTAVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188920; c=relaxed/relaxed;
	bh=2fDSjA/gIhwpfWSPmHpII6Q7mwpRalk0mwyj7+xT69c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/Kg7N5yaho0V5fCHbnqjU7PaGVAK2DoNI4nxdlJG02sMkC2aU8QbdwrdFbN5gTNWI+BsNqnOkof3vNMNUwMjg/zm5o+3plWYRPlBRmm5sFRFWxZmIG4WT1FPsGNAYHG9NRe3I+myDeTrPF+JkDmhqWvlIS4ytm8qo4JCJucw/kJ+kjMAYE6MR49tWLHISOjFEnuQSRUi5Sc4CFWXCM/U6GKZwkhclhayBCjpwZi7JWLDV9eITNQEVdVLfCnofbnbVaoD8K5Ix2vpsTAc1DWNbvbNfKIClWKTlvz5kz/hdEc/MAHjkuCyO4ddW+FFOPQHeoa41qtpB76pROrJodI2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NK87gW16; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NK87gW16;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXSR4JHDz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:39 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9V6652837;
	Mon, 31 Aug 2026 15:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2fDSjA/gIhwpfWSPm
	HpII6Q7mwpRalk0mwyj7+xT69c=; b=NK87gW16gZaOrlE5+u7lZ+cXOebZ881Xq
	I9l+Eeme+MUGd5z67A4JTk6tmdN+mhBDxxOVWUe9o4znPdgNh5bDEBSDqmGowbRb
	5BXUBm3VX3U0vJUw8U+7Dp72ZHa6cC1dHt89pzpidnP/yy/wyTLmKizlsfeXR1S4
	qLhQdHWP+2pG/SxXgNkWf1xmvwDJ1cyqRMOxNYdMeUz1whFIzFG1ydD3fTZC7F3y
	jFwjumV/SG+FZEVYJyX+p9mMX9ef64dbGsf/dF5908Mkjoo2xzFjDad8nB+x6nk1
	rQjOUJKYWXdza4jUfToDGHuQCF4GLxN2HEPIBpaJkBbBBR2GxfnDg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r236k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuPlU017180;
	Mon, 31 Aug 2026 15:08:30 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexxb9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8OB021365370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA55D5805E;
	Mon, 31 Aug 2026 15:08:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3113F58051;
	Mon, 31 Aug 2026 15:08:21 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:20 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 06/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Mon, 31 Aug 2026 08:07:17 -0700
Message-Id: <e07afab0a0129a7b01d24113d9d74bc10c7dc7de.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9598ef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DxozG-j1JV6YLmLuyJYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX0JJ8kIXIQRmR
 awZA9LRRy3QPQope4AjwNtkpH7waOJ4JTu8xt6PzhVVa6wJUPtiThMIcpX1YhVDunzdwyQn1R9V
 lU0X/ggxjfro+Kv9i28feBNJYESooNoQL5G2MpluRshmopHTRozsvS7J+5tc6/BuBFyzxiP1/LP
 8wzp4s/R+l2lvMXcSlMt2xnAO3Ia58Iy61Y7wuu5jTvLaA2w0TQnQRtEM5R/pFmIvtevm3wFO8O
 lvjkVRN6FoF1YuPg+nv2aRowXktOD85ukHhZXxvmd4pQuIE9VdsdHfSprFVBBzueUIk61RNyrIA
 6V89oUEUJTHRHxLunpjiLh4Ifhg3CiW3yIhnidFd5D/fIEQes1VgogHHnLFAOAf997bKoxA3z8R
 yFFqIBNZsrQjCvnK/3KeDRIeS55hHphV1lKTQmMhn5vQSvTejFGmtdfLRmsjOk16IVdblyT0dii
 q7f8UejjkLJNGf26Olg==
X-Proofpoint-GUID: nWwSl3wo2L-XyGBwvI4e9LumfWJWKzjE
X-Proofpoint-ORIG-GUID: ugfl_jtFWdSMbhDLYbOcHk91oFif-rKz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX5PDY5ayZClTM
 gj7VqS/QUOttFH108l4koMtBfGVvsJh66LITUfFMCE8bFpxl1nr0Ob1eFDTxyG2HIbxbOyctgfV
 TYwpsPbvnt/gugj0tZmSBJF+Fo6T82s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

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

Also tighten TX LTB lifetime: free_tx_ltb() returns early if
tx_ltb_ptr[] is already NULL, then clears both tx_ltb_ptr[] and
tx_ltb_dma[] before unmapping and freeing, so start_xmit() cannot pick
up a slot that is mid-teardown. allocate_tx_ltb() clears tx_ltb_dma[]
on the DMA-map failure path.

Move TX LTB allocation to the end of open(), after LAN registration,
RX pools, RX interrupt setup, and the initial replenish kick. A late
alloc_tx_resources() failure jumps to out_cleanup_rx_interrupts and
must not call free_tx_resources() again: alloc already freed any
partial TX LTBs. start_xmit() bails if tx_ltb_ptr[] is gone, counting
the drop in tx_dropped and falling into the existing out: label like
the function's other drop paths, so RX can be live while TX LTB alloc
still runs and close/failed-reopen cannot race a live mapping. The
close path is quiesced by netif_tx_disable(); NULL-first in
free_tx_ltb() only closes the check-then-use window, it is not itself
a UAF barrier. set_channels() IFF_UP vs opened is later (P14/P15).

After LAN registration, open-fail teardown issues h_free_logical_lan()
before RX pool DMA teardown on the pool-fail path that previously never
issued that hcall (missing deregistration, not a preference reorder).

close() quiesces TX with netif_tx_disable() (stop_all_queues does not
wait for in-flight ndo_start_xmit), then frees LTBs after
h_free_logical_lan() via free_tx_resources() - required because direct
close() callers bypass synchronize_net().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v6:
- NULL tx_ltb_ptr[idx] and zero tx_ltb_dma[idx] before unmap/free, so a
  racing start_xmit() fails the pointer check. Close-path safety is
  still netif_tx_disable()
- the NULL-LTB start_xmit drop increments tx_dropped and falls into
  the existing out: label
- comment on allocate_tx_ltb(): caller must leave tx_ltb_ptr[idx] NULL
- kdoc alloc/free_tx_resources says real_num_tx_queues
- noted: ethtool -L TX shrink still stop-then-free; cover leftovers

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

 drivers/net/ethernet/ibm/ibmveth.c | 115 ++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 335712faaa42..7a420e1a41d5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1201,12 +1201,27 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
-	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
-			 adapter->tx_ltb_size, DMA_TO_DEVICE);
-	kfree(adapter->tx_ltb_ptr[idx]);
+	void *ltb = adapter->tx_ltb_ptr[idx];
+	dma_addr_t dma = adapter->tx_ltb_dma[idx];
+
+	if (!ltb)
+		return;
+
+	/*
+	 * Clear the slot before releasing it. start_xmit() tests
+	 * tx_ltb_ptr[idx] to decide whether the LTB is usable.
+	 */
 	adapter->tx_ltb_ptr[idx] = NULL;
+	adapter->tx_ltb_dma[idx] = 0;
+
+	dma_unmap_single(&adapter->vdev->dev, dma, adapter->tx_ltb_size,
+			 DMA_TO_DEVICE);
+	kfree(ltb);
 }
 
+/* Caller must ensure tx_ltb_ptr[idx] is NULL. open() runs on
+ * probe-zeroed slots; set_channels() skips populated indices.
+ */
 static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
 	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,
@@ -1225,12 +1240,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 			   "unable to DMA map tx long term buffer\n");
 		kfree(adapter->tx_ltb_ptr[idx]);
 		adapter->tx_ltb_ptr[idx] = NULL;
+		adapter->tx_ltb_dma[idx] = 0;
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
+/**
+ * ibmveth_alloc_tx_resources - Allocate TX LTBs for real_num_tx_queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Allocates TX Long Term Buffers (LTBs) for real_num_tx_queues.
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
+ * ibmveth_free_tx_resources - Free TX LTBs for real_num_tx_queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees TX Long Term Buffers (LTBs) for real_num_tx_queues.
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
@@ -1281,12 +1338,6 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1308,24 +1359,24 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1333,11 +1384,14 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -1349,7 +1403,6 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
 	 * leave IFF_UP set after a failed reopen.
@@ -1361,7 +1414,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	netif_tx_stop_all_queues(netdev);
+	/* Disable and wait for in-flight ndo_start_xmit (stop_all_queues
+	 * alone does not). Direct close() callers bypass synchronize_net().
+	 */
+	netif_tx_disable(netdev);
 
 	ibmveth_cleanup_rx_interrupts(adapter);
 	/* Wait for softirq/poll that already passed shutdown checks. */
@@ -1377,13 +1433,14 @@ static int ibmveth_close(struct net_device *netdev)
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
@@ -1807,6 +1864,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
+	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
+	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
+		netdev->stats.tx_dropped++;
+		goto out;
+	}
+
 	if (ibmveth_is_packet_unsupported(skb, netdev))
 		goto out;
 	/* veth can't checksum offload UDP */
-- 
2.50.1 (Apple Git-155)


