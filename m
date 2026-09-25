Return-Path: <linuxppc-dev+bounces-28218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC5C98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:40:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzyN1c28z3048;
	Sat, 26 Sep 2026 04:39:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361580;
	cv=none; b=W3km344gfxH+6A+dm5kLQxFybmRkrv+YerJSUILqLs3ws8OPwXwUzDwp8zn4G10pc8Grh6Lt6xPKkrNNnDy86KvMBD3oZuZ9SVm0Q219q/L3fR25sWt1+SStnKPPr5T1EE2V7pfkMrPNAtWioWlBWYFtVQ6Q8Z/fBo3ivS33s/Z51q/WoX7v2RYjV0iHkY6eM5fcl1yYIQs7J3uT3WL1iz3UBHU7RrNTk5/xRsutDW6xuCE/DP8bwoWwyQeHpsorhtp8IuJGTN9borXzaHUoQ7hhgOvp0SdLeP5ecab5gIa/jGrhbdRCl0GR5D/46eAmnI25HZuDvVMb5YMWZLw18A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361580; c=relaxed/relaxed;
	bh=jMUMqmoWyhNk8K+iaGZIgJryhJwyB0qSgB3J8h6z6vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OafYiD7miXgQDlLlKq/JkzRwA7U8e2H/d3vrVshbh8sINc1vK3nmZQK0P0qTapQWedjPdltW3IDUfybeYwvGRlyQwoW8y/oPa7tJpc4Dm4DI+7lSu0jofaXEUthZVEa9s/Ziz4ereCmURtEnekOtmkQZ9iHacXC9VNcMkMoVWY5CQCeP6nubkSkCN9X+iKI1H15xGaUFN/tM4lmF6vTQXKTCiAnfiZ3cWs5IUX8u8IjokCKpLNJKrBsH37Yk4wfItIr5aWOSlsp7w+aeY4G+dH2eWSHQ3ZcKFnfrYA8eXWiqD/iJJS/dmdbdL6HZp7e5O0iLcofPu4fIWzUSIKtDXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JaVXE3kw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JaVXE3kw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyM1xvbz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:39 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5jO3343540;
	Fri, 25 Sep 2026 18:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jMUMqmoWyhNk8K+ia
	GZIgJryhJwyB0qSgB3J8h6z6vQ=; b=JaVXE3kw0qMpGSb36WntP4UI0XvWO9hKN
	Eh7wTWrwCyT74m3jzxmXzJ4ttmUQsJ5Yj7LLdyFv5eoZvufBIiHV8syBWJvK/VJo
	1HSE2gdq+o3unvxx3CXRdGuAY2Rqxi2rWrACcNI3iMTa8EUcZrwRDwzHVfsRr7el
	e5i0M7ciPaXnmTXr2Nt4oWCjZjDGaEfuHpTlPDLpLJqiuIecdkLSorvvPfJn4M9j
	/hHX+MmPbE7xwwT1dfWPlYc2hLBGtky2KcY/Dxo1/Jkk4a1rBIb3DkLw5oX4a/70
	jz4k53nJ+tnJgbxi1ui9jPWfLI4s9qkbRmlWOhoqQ8QDZ+QKtLJFw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqyjca-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG39i04186670;
	Fri, 25 Sep 2026 18:39:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe23kag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdOup38011248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF7C558059;
	Fri, 25 Sep 2026 18:39:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B0605804B;
	Fri, 25 Sep 2026 18:39:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:21 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 06/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Fri, 25 Sep 2026 11:38:41 -0700
Message-Id: <02196cd1ee13b66859544b7ab5fd0bd4d5d61fb9.1790319558.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790319558.git.mmc@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6bfe0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DxozG-j1JV6YLmLuyJYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXwiCj3CKsHgIM
 O4ZjEPA5Ux1VG0odxs/bKq7ToKqzSxCC4svxoJb2qes9EN81N722pEOnpGZ2GRXU219uLCcqj+n
 TizUumKuBiCsCYIvS8Ei34ASL2HsmMBVZcBAeTk7rzju6owiLgmcL4vBpwoe5pchK2KDHJc6q4w
 p3mtqhX9OqcgDGCVlp5FVTBrtzDia8lj7sQzyxqilu9pKQYk77KqbEXRqo55vlXBLwN0mA9JiqW
 ouom0YWCrBbxgHP03CuwwQxNnHUj08qA59pbI92K2Eo+xgY2W+puepO79KiK/dfNaTKeteSdCe8
 MUK4ZWUJemg1foL/b5cEfH9nHWhhAdfHorTBQBZ3AqIHEom3bOvq4nDFDamqAGM4BqhD3nYrwFn
 afoNhgTuud4n2F98NX16Of5rRcSvSPaRxzCPmIM33OSkZ0xi0apfv7c2/xlTGxNCUxEm0K26/Zp
 TmQEAala5ZdvgrCZQ5A==
X-Proofpoint-ORIG-GUID: pxY31GH88pZt8Gbol10W9p_QS5QP7pVp
X-Proofpoint-GUID: 3Oe2VQMn4rj-12DYOrzP2c2-DuBQqL0u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXxSGXxI1cHV8R
 +1E9wyD1WFgd5KtIgA4l4HqnMdvR0HroiylJTgS5PI/lf6Vl7847meC0bAgO7rZjBS9tA7J+6WB
 RJmwUI1zeBySua9tvJptWg/fuv9XkU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

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
partial TX LTBs. RX is live by then, so that label also calls
synchronize_net() after cleanup_rx_interrupts(), as close() does,
before the RX ring and pools are freed. start_xmit() bails if
tx_ltb_ptr[] is gone, counting
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

Changes in v7:
- late alloc_tx_resources() failure: synchronize_net()
  after cleanup_rx_interrupts(), as close() does, before
  the RX ring and pools are freed
- noted: no Fixes: peel of the pool-fail h_free; stay
  at 15; [PATCH net 1/2]
  <cover.1790357373.git.mmc@linux.ibm.com>
  (Fixes: d43732ce021f)

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

 drivers/net/ethernet/ibm/ibmveth.c | 117 ++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a22a17e05ae1..011082db1e08 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1206,12 +1206,27 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
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
@@ -1230,12 +1245,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
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
@@ -1286,12 +1343,6 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1313,24 +1364,24 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1338,11 +1389,16 @@ static int ibmveth_open(struct net_device *netdev)
 
 	return 0;
 
-out_free_buffer_pools:
+out_cleanup_rx_interrupts:
+	ibmveth_cleanup_rx_interrupts(adapter);
+	/* As in close(): a poll past napi_complete_done() may still run. */
+	synchronize_net();
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
@@ -1354,7 +1410,6 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
 	 * leave IFF_UP set after a failed reopen.
@@ -1366,7 +1421,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	netif_tx_stop_all_queues(netdev);
+	/* Disable and wait for in-flight ndo_start_xmit (stop_all_queues
+	 * alone does not). Direct close() callers bypass synchronize_net().
+	 */
+	netif_tx_disable(netdev);
 
 	ibmveth_cleanup_rx_interrupts(adapter);
 	/* Wait for softirq/poll that already passed shutdown checks. */
@@ -1382,13 +1440,14 @@ static int ibmveth_close(struct net_device *netdev)
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
@@ -1812,6 +1871,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
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


