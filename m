Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC4606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ofoUqRAz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsc4n8cz2yDD;
	Tue, 10 Nov 2026 10:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268612;
	cv=none; b=W28ihJDzmcDOTJXcsX4qYuqSpi/ddbQQMFapzbvmBJBDTostHDqAo0wNsWAh6qW8hXmhDn02LBcq7BxKcT1gfLb2/X/TAXASmF1Y12sGI+p4dMZmhuRISSwMLL5kLb690IRuKBDWuuvHlgVWLUHgQ2E01x3xGtg33y4CQYBLBgTJ2dXzqzM1G5Qq3gkg0OHr8I9A6AdRjlGksmDzy5vHufr4f/CeWdeK9hewZZdACk90NPu69wEurBFNqmynKu6r0aExXQsOHt+4J6pahPhr/ChmUyRj/N6AWbLCUuWjSGI/fMBHzaIAdR//L4lSCoyRm2J1wOKj0jn2hNcQ6kSY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268612; c=relaxed/relaxed;
	bh=Mh1GnRum088h7Gw+VQbztySL0NYHAdti6moRWs1X/IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjG01y1mwKmqyVLPZqZ2tDw331nZxuFCEMtjod/bvXcxwL9cxWiwBb+IOQbfbXnm8So80FQsmn+5hAVVGqUyBr4jytXilxtPJZutHcvjefjdkDc4NsxG95ZatfW5lakyFKoBHee5r2M6tjIuAMnrMDC6IN9597liGoTiBbJeo8lKzbYuVxj+oDVHe+7HYkidabNjay0wm8cNBgoJFuuGfOizopVD/MKfBcsSXaaGWxhuxCie3Lpv6nFGw01fghdt3BqNIsurdI1urqSjGGXzydaDdueJm1bZIX71RoycUaGDh+fyRjxmM365YUGySWE5bnUm40cPDGnR04SYSgETCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ofoUqRAz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ofoUqRAz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsb4jlpz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:51 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEDN6441956;
	Mon, 9 Nov 2026 23:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mh1GnRum088h7Gw+V
	QbztySL0NYHAdti6moRWs1X/IA=; b=ofoUqRAzkTtI97Tzhza/WcAuKmFx5lglN
	rxkeDZ5peWnaUyDKugrc1/Q0iYSWuQ/mCfThw2Mrc4rK8xuocvzfuR9GCkSXfncj
	7gCZC3F/j7AarQIzB2x/cPbuqtctozdHptuMaKMlX7ojaxGBgvIGwXem6utzvxv1
	MZP/IMpylQCY/oLnFIu+2tTN8Q7fFbwkuTylnWoyjo8dUjSjr0HoSdWJRS7rJXJz
	mjSnJbEW9WgerSDofnsNQXr57NJjEIaQYxOwufc54FDh8Y3mNKB0M/vqx1IRUwV/
	VDlqJQItTMwdeQqD8ayj7VLFzEoLiJ8b6QzZ7EzCco0VnL+1D1gYw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkjjt6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJsJt812420;
	Mon, 9 Nov 2026 23:56:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y42d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NubRc7602894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969A058059;
	Mon,  9 Nov 2026 23:56:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616C95805B;
	Mon,  9 Nov 2026 23:56:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:34 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 06/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Mon,  9 Nov 2026 15:55:47 -0800
Message-Id: <20261109235556.60604-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af25db8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1VeGBYNIxK-ThwsNLV0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX98PpcCVXBFDY
 jAP55iAaSlWfgk0YncqYxKk1Zko6BUgIK2d+ZVnWEymI/agPV7IryPQDyC8ww580iPRyHAhEmuM
 WF+bPts8WGdvW9dFGpuAVaGDXHj4v/PI+ljHaqTGhecRHFEyHF51BB00hpdjattkMeQOIWgbU3R
 tdlunfnudzCNS3f89W+wQpHrXrNxSum9Ju7uIXlPyRLnmfS5OXIMwoWj2ohZMoHK5+dTtbjq6/a
 dRwFXeJ6fcmxP0LSvWV8eqocd5fru7S5ZucK4IRhCX+d7PujmTvUOLomTS5bDc5h4/DPEMNY6jd
 6EoRlm+fjaQg8gKK+FiJJISF7iabA09krpN6Nqg6C7GzQIUyXjq308Si3TK4bpeoZ63L7UglOcg
 IV3iCEJi3fmG6e705+y0d8N9ZJZRCLvbBDbL8nBH2CXaJk4MzU3hYA9XKWVLV+GkO8etO0Ddj77
 b9QbEWa+2N9cvLghTiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX0TeZFvwZKeQm
 KRZum3SWjrSR9eV0yAXwBGisV9aK2HbMuw56EuzTTBabNhtRV+5lKlajhaGXi3HG2IsKwUgzVjO
 y5fKCPm0fqllAlmYt+5Vu8MFMSXpVdQ=
X-Proofpoint-ORIG-GUID: Z9A8MEuZ3eAzdd4zOkR4WBJpg8uf--cY
X-Proofpoint-GUID: _dCV0cyHLxRJ8sbVisf-a7pNpLvL3Pl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As with the RX refactor, pull TX LTB alloc/free out of open/close
into helpers and wire them in this patch.

  ibmveth_alloc_tx_resources()
  ibmveth_free_tx_resources()

They wrap the existing per-queue allocate_tx_ltb() / free_tx_ltb()
primitives. alloc_tx_resources() allocates every TX queue and unwinds
partial failure itself; free_tx_resources() walks real_num_tx_queues.
The helpers remove dependence on shared open/close loop indices and
match the RX helper structure. TX was already multi-queue capable via
ethtool -L.

free_tx_ltb() already returns early on a NULL slot and clears
tx_ltb_ptr[] before unmapping. Clear tx_ltb_dma[] there too, and on
the allocate_tx_ltb() DMA-map failure path, so a freed slot carries no
stale DMA address.

Stop TX at the start of open() with netif_tx_disable() so TX cannot
run while TX LTBs are still being allocated. That covers first-open
generic XDP_TX, whose queues are not DRV_XOFF.
netif_tx_start_all_queues() stays after alloc_tx_resources(), under
netif_tx_lock_bh(): RX NAPI is already live there, and generic
XDP_TX and netpoll test DRV_XOFF under the queue's xmit lock before
they read the LTB, so the lock orders the LTB stores before any
sender that sees the queues started.
Move TX LTB allocation to the end of open(), after LAN registration,
RX pools, RX interrupt setup, and the initial replenish kick. A late
alloc_tx_resources() failure jumps to out_cleanup_rx_interrupts and
must not call free_tx_resources() again: alloc already freed any
partial TX LTBs. RX is live by then; cleanup_rx_interrupts() waits
for the poll tail before the RX ring and pools are freed, as it
does for close(). start_xmit() bails if
tx_ltb_ptr[] is gone, counting the drop in tx_dropped and falling
into the existing out: label like the function's other drop paths.
That guard catches a sender that picked its queue before an
ethtool -L shrink and arrives after the free; a sender already in
xmit during the free is not covered, as before this series. The
close path is quiesced by netif_tx_disable().

Every failure after LAN registration still issues
h_free_logical_lan() before the RX pools are freed. As in close(),
the unwind does not check its result, and the late TX failure now
reaches it with RX buffers already posted; a later patch makes the
multi-queue paths keep that memory mapped on a hard failure.

close() keeps netif_tx_disable() and frees the LTBs through
free_tx_resources() after h_free_logical_lan().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- netif_tx_disable() at the start of open(); the TX queues start under
  netif_tx_lock_bh(), since NAPI (and generic XDP_TX) is already live
- a late TX allocation failure unwinds through cleanup_rx_interrupts()
  (patch 5), which already waits for the poll
- start_xmit LTB guard comment is about a sender that picked its queue
  before a shrink
- commit message: the late TX failure unwind frees posted RX after an
  unchecked H_FREE, as close() does (MQ keeps it mapped from patch 10)

Dropped from this series (merged fixes own them):
- commit c807573ea58e: close() netif_tx_stop_all_queues() ->
  netif_tx_disable() (in base; this patch adds open()-start disable)
- commit 84bec0bf0352: free_tx_ltb() NULL check and NULL-first clear
  (in base; MQ refactor keeps the v6 behavior, not a duplicate fix hunk)
- commit 95811c873d1b: set_channels IFF_UP vs opened commit-message claim
  (base gates set_channels() on opened)

Changes in v7:
- late alloc_tx_resources() failure: synchronize_net()
  after cleanup_rx_interrupts(), as close() does, before
  the RX ring and pools are freed
- noted: no Fixes: peel of the pool-fail h_free; stay
  at 15; one standalone [PATCH net] after this series
  (Fixes: d43732ce021f)

Changes in v6:
- free_tx_ltb(): clear tx_ltb_ptr[idx] then tx_ltb_dma[idx] before
  unmap (NULL-first narrows the race; close still uses netif_tx_disable())
- start_xmit(): tx_dropped++ and goto out: when the LTB is missing
- allocate_tx_ltb(): comment that caller must leave tx_ltb_ptr[idx] NULL
- alloc/free_tx_resources kdoc uses real_num_tx_queues
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

 drivers/net/ethernet/ibm/ibmveth.c | 111 +++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 62e6c9a9f5e9..cab895cc970c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1248,17 +1248,27 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
-	void *ptr = adapter->tx_ltb_ptr[idx];
+	void *ltb = adapter->tx_ltb_ptr[idx];
+	dma_addr_t dma = adapter->tx_ltb_dma[idx];
 
-	if (!ptr)
+	if (!ltb)
 		return;
 
+	/*
+	 * Clear the slot before releasing it. start_xmit() tests
+	 * tx_ltb_ptr[idx] to decide whether the LTB is usable.
+	 */
 	adapter->tx_ltb_ptr[idx] = NULL;
-	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
-			 adapter->tx_ltb_size, DMA_TO_DEVICE);
-	kfree(ptr);
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
@@ -1277,12 +1287,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
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
@@ -1322,6 +1374,11 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
+	/* Stop TX before RX is live. First-open queues are not DRV_XOFF,
+	 * so generic XDP_TX can run during TX LTB alloc.
+	 */
+	netif_tx_disable(netdev);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
@@ -1333,12 +1390,6 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1360,12 +1411,12 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_free_tx_ltb;
+		goto out_free_queue_mem;
 	}
 
 	rc = ibmveth_alloc_buffer_pools(adapter);
 	if (rc)
-		goto out_free_buffer_pools;
+		goto out_unregister_lan;
 
 	/* Enables NAPI, so everything ibmveth_poll() touches must exist:
 	 * netpoll during the direct close()/open() pairs, or a direct
@@ -1373,26 +1424,36 @@ static int ibmveth_open(struct net_device *netdev)
 	 */
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_free_buffer_pools;
+		goto out_unregister_lan;
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
 
+	rc = ibmveth_alloc_tx_resources(adapter);
+	if (rc)
+		goto out_cleanup_rx_interrupts;
+
+	/* NAPI is live, so generic XDP_TX can transmit as soon as it sees
+	 * the queues started. Senders test DRV_XOFF under the xmit lock;
+	 * starting the queues under it orders the LTB stores before them.
+	 */
+	netif_tx_lock_bh(netdev);
 	netif_tx_start_all_queues(netdev);
+	netif_tx_unlock_bh(netdev);
 
 	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");
 
 	return 0;
 
-out_free_buffer_pools:
+out_cleanup_rx_interrupts:
+	ibmveth_cleanup_rx_interrupts(adapter);
+out_unregister_lan:
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	ibmveth_free_buffer_pools(adapter);
-out_free_tx_ltb:
-	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
-		ibmveth_free_tx_ltb(adapter, i);
+out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
 	ibmveth_free_filter_list(adapter);
@@ -1404,7 +1465,6 @@ static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	long lpar_rc;
-	int i;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1430,13 +1490,12 @@ static int ibmveth_close(struct net_device *netdev)
 			   lpar_rc);
 	}
 	ibmveth_update_rx_no_buffer(adapter);
+	/* netif_tx_disable() above keeps xmit off the TX LTBs. */
+	ibmveth_free_tx_resources(adapter);
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
-		ibmveth_free_tx_ltb(adapter, i);
-
 	netdev_dbg(netdev, "close complete\n");
 
 	return 0;
@@ -1864,6 +1923,14 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
+	/* TX LTBs are freed on shrink; a sender that picked its queue
+	 * before the shrink can get here after the free.
+	 */
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


