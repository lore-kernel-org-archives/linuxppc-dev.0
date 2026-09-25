Return-Path: <linuxppc-dev+bounces-28215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA534C98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:39:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzyB0vwQz2yMm;
	Sat, 26 Sep 2026 04:39:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361570;
	cv=none; b=JYRgcO2ulumaHlN67vcJGymklutSHe7xYi6j8aJ/9zvTA9x5xqxZFH86o4L7I6pabKTazgER9NyxlE9m4rnkIyIbxYc5Aht8tSXjYmSlZ73O0aWQdvFcnmW/TDI6DHQcqV6YYN5o4gerBre8vgmoC3WvzxHAyWzjiKHm4yEW04b2TCdOmsZACFGfnmqanxg8o7AuqymgCgeW3kiZC04xCfXWb50Pn9FRc8Pbo4hXORZ9pFsHGpgWBIOTxdSNZoAuQdppis7b1F5fwlmy67fJ7NH+fMBOSzNAcvpRb3uEK156aRhtsBhnuXBsdCZlw5gyoKHVbm0mrw8K6Rdv3eynhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361570; c=relaxed/relaxed;
	bh=0Fko66Plq5Ewe0uLgy8PomaWm1vsQjXy+JmIz+EH3CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbA6zIas7kZvx561FT9j4Zm+Q5+PIz7F8OdWMJwXv6NZ6xHX3z1nLfm2iHEBN1/3hDcHH2B1kTIXA0pX8v6zy3Cu84hibdl0E6M8YPGL8CLIlkeIjvrhNkg6NbRssIp95EqwJHU/OsYY5Ygn+p97TIsahrgcZwPhXI5s680WVY6EWbnQ6EE5LIT4Sl21qV9FFD/zUhMTFePge1wEJKdFy3I2dSK7pa6HPIx5mYIZWPrlnPglHRYZ6n710gKimiWSY+SvCQOPQS8MeUYVJphrAINEwYk/JsyKMz2GMPo7pqo59vXXsoC7I/84Z9UO5f/NABdrrPgaLj45EOzSp/yhSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5IRKz4J; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5IRKz4J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzy903Y2z3bV6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:28 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG65Lk1372452;
	Fri, 25 Sep 2026 18:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Fko66Plq5Ewe0uLg
	y8PomaWm1vsQjXy+JmIz+EH3CY=; b=s5IRKz4JjWh7yh11FzEVAr47iixyYjN05
	QtB5oNTSgGkIBeOmwfnL7/4xnEbWDsOQ1R+BTC5vZbsMVy9ebIvxDWPcKKrVxIIc
	M212ABZnmgOwvb2sn6XVmSUN9gXrQHm339QOasDT16+6f2nnBlgyq4uwdjSREP2j
	VTEVh+ga3jV/KKY6h2Cwpt5UfRgXfGG9h0mLBUF2fkFSTNziMrX8h3tm35W6fqAM
	uOHnjteTlIjmUgNdaNPQXcfoMAfjfeS2GN25tGo+R7LVzatlWYakQ2n+g5t26i1g
	WejXLfTak1818Ua6MLUnC3eNmdSty2R+tMNZNYoUNoWErAd03eH+g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1yqm7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG38MF4186659;
	Fri, 25 Sep 2026 18:39:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe23k9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdCMC28377798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E1D58055;
	Fri, 25 Sep 2026 18:39:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C79E35804B;
	Fri, 25 Sep 2026 18:39:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:09 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 03/15] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Fri, 25 Sep 2026 11:38:38 -0700
Message-Id: <2320895ef517f70b063eca84766723ff20019748.1790319558.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZbzvFUpOShJAdxadYunmgUMqNI5Rr31s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX/PwuYarvhmdN
 odhfVwtZRXBqbtcEGK8/yJcUnh7L7gaSYGR5X2+EhwKfJ7R7qtIImG7fc8IXhfdbXFXIVV9yRbw
 JlcA7HbLgd3aGvNjB7aKt6BFYB/caaF1rQ8X/cdAQE1fNy84J7bgLy7H4OAcyWD4G18xWJsPJ/O
 bcTIj2xOJG7qm3eHui3EuZUaIGJ4kw3/yumRE5QgQJHt4OiyM6qUt9gb5uGaYI1qyEOO1RJKPEQ
 z5X0UskjSWvqwnZrIBYmHfaFYY8JHXI2zfAZo1Vu3AJn17S/m5c0FjCSDLd1E79IJ8X9McmTr7b
 qbdBZNdeRyCZqIVJMYiU6G5P9epROyFddD7FC3eCVs9GabfJ9331GS0f3EEyA8eRwQe18Zo5beb
 X6V3K7Ya89+vOrVGDZ8ASpjt72+YdoXj3cQ45+7Mf4cAs5/VCBEsqPgkdWkmL37lgIUJWBJ6fHE
 CA/YKchwLrEQPynFPHw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6bfd5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jXUIsfSPTXYLh4iwz40A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX/ho+iNHfVD3B
 WguKVKoZX5nMVnUii5RAoonVuF6mlzBW8RzcBRrATnDTmjWOauFIDJjPnhe07FAYQX6P8VsEuEA
 76/C4yAdJ9D8IjCA07QvaYQgBqOk/vA=
X-Proofpoint-GUID: abdpkid2WulWxwMgU-4CsBI-PRm2wZ3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

ibmveth_open() allocates the filter list and every RX queue inline.
That is already a long sequence and would get uglier once we loop over
num_rx_queues, especially on error unwind.

Pull the RX bits into helpers and wire them into open()/close() in the
same patch:

  ibmveth_alloc_filter_list() / ibmveth_free_filter_list()
    - shared multicast filter list (one per adapter, not per queue)

  ibmveth_alloc_rx_queues() / ibmveth_cleanup_rx_resources()
    - per-queue buffer lists and RX rings, looping [0, num_rx_queues)

alloc_rx_queues() rolls back on failure so open() does not need nested
goto chains for every queue index. open-failure and close release the
same resources through the same helpers.

Cleanup NULLs each slot as it frees. A filter-list map error zeros
filter_list_dma so a later free path cannot unmap DMA_MAPPING_ERROR,
and unmap is gated on the CPU page because SPAPR can return DMA
address 0.

Runtime behavior stays single-queue (num_rx_queues is still 1). Buffer
pools, IRQ, TX LTB, and PHYP registration remain inline for later
helper patches.

Also set rc = -ENOMEM before the TX LTB allocation loop so a failed
ibmveth_allocate_tx_ltb() still returns a useful errno after the RX
allocation blocks move into helpers.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v7:
- NULL-check buffer_list_addr[0] in update_rx_no_buffer()
- reword err_cleanup comment for the mixed map-failure state
- drop the failed-reopen then ndo_stop double-free claim from the body
- noted: no Fixes: peel of the DMA-handle checks; [PATCH net 0/2]
  <cover.1790357373.git.mmc@linux.ibm.com>
- noted: TX LTB stale handle predates this; P06 (pointer check, zero dma)
- noted: shared-i TX LTB leak predates this; P06 (own counter, TX
  after pools)
- noted: pool-fail without h_free predates this; P06 adds it, P07
  allocates pools first
- noted: napi imbalance on failed reopen predates this; P05
- noted: replenish_lock stays in P08; poll_controller !opened
  stays in P15; leftover netpoll/irqsave after this series

Changes in v6:
- on RX-queue dma_alloc or map failure, free the buffer-list page
  before cleanup so the addr-based unmap does not dma_unmap an
  address that was never mapped
- unmap RX filter/buffer lists by CPU pointer, not dma_addr==0
- use %u for the two num_rx_queues dbg prints
- noted: NULL buffer_list_addr[0] window: close() in P05, netpoll
  through replenish_task() until the per-queue guard in P10
- noted: shared-i TX LTB leak on pool-fail predates this; P04/P06
- noted: pool-fail after register without h_free predates this; P06/P07

Changes in v5:
- On filter_list DMA map failure: free_page and zero filter_list_dma so
  a later free path cannot dma_unmap the DMA_MAPPING_ERROR sentinel
  (match buffer_list_dma convention). Closes reopen->ifdown WARN path
  after set_csum/set_tso/change_mtu/pool_store close+open while running
  - v4 left the sentinel
- Call out rc = -ENOMEM before the TX LTB loop after RX helper extract
  (already in v4; still required so allocate_tx_ltb failure returns a
  useful errno)

Changes in v4:
- Introduce RX/filter allocation helpers in the same patch that wires
  their first open/close callers; v3 left unused statics ahead of the
  old open/close pipeline patch.
- Preserve correct -ENOMEM return on TX LTB allocation failure after
  the RX helper extract.
- Drop reliance on v3's separate "open/close pipeline" patch for this
  wiring.

 drivers/net/ethernet/ibm/ibmveth.c | 284 +++++++++++++++++++++--------
 1 file changed, 205 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 7cb828b476c1..01efd318baab 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -151,6 +151,194 @@ static unsigned int ibmveth_real_max_tx_queues(void)
 	return min(n_cpu, IBMVETH_MAX_QUEUES);
 }
 
+/**
+ * ibmveth_alloc_filter_list - Allocate and map filter list
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+
+	adapter->filter_list_addr = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->filter_list_addr) {
+		netdev_err(netdev, "unable to allocate filter pages\n");
+		return -ENOMEM;
+	}
+
+	adapter->filter_list_dma = dma_map_single(dev,
+						  adapter->filter_list_addr,
+						  4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
+		netdev_err(netdev, "unable to map filter list pages\n");
+		free_page((unsigned long)adapter->filter_list_addr);
+		adapter->filter_list_addr = NULL;
+		/* Do not leave DMA_MAPPING_ERROR for free_filter_list(). */
+		adapter->filter_list_dma = 0;
+		return -ENOMEM;
+	}
+
+	netdev_dbg(netdev, "filter list @ 0x%p (DMA: 0x%llx)\n",
+		   adapter->filter_list_addr,
+		   (unsigned long long)adapter->filter_list_dma);
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_filter_list - Free filter list resources
+ * @adapter: ibmveth adapter structure
+ */
+static void
+ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	/* Unmap by CPU pointer: SPAPR can return DMA address 0. */
+	if (adapter->filter_list_addr) {
+		dma_unmap_single(dev, adapter->filter_list_dma, 4096,
+				 DMA_BIDIRECTIONAL);
+		adapter->filter_list_dma = 0;
+		free_page((unsigned long)adapter->filter_list_addr);
+		adapter->filter_list_addr = NULL;
+	}
+}
+
+/**
+ * ibmveth_alloc_rx_queues - Allocate per-queue RX resources
+ * @adapter: ibmveth adapter structure
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		adapter->buffer_list_addr[i] =
+			(void *)get_zeroed_page(GFP_KERNEL);
+		if (!adapter->buffer_list_addr[i]) {
+			netdev_err(netdev,
+				   "unable to allocate buffer list for queue %d\n",
+				   i);
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].queue_len =
+			sizeof(struct ibmveth_rx_q_entry) * rxq_entries;
+		adapter->rx_queue[i].queue_addr =
+			dma_alloc_coherent(dev, adapter->rx_queue[i].queue_len,
+					   &adapter->rx_queue[i].queue_dma,
+					   GFP_KERNEL);
+		if (!adapter->rx_queue[i].queue_addr) {
+			netdev_err(netdev,
+				   "unable to allocate RX queue for queue %d\n",
+				   i);
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+			goto err_cleanup;
+		}
+
+		adapter->buffer_list_dma[i] =
+			dma_map_single(dev, adapter->buffer_list_addr[i],
+				       4096, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
+			netdev_err(netdev,
+				   "unable to map buffer list for queue %d\n",
+				   i);
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+			adapter->buffer_list_dma[i] = 0;
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].index = 0;
+		adapter->rx_queue[i].num_slots = rxq_entries;
+		adapter->rx_queue[i].toggle = 1;
+
+		netdev_dbg(netdev, "queue %d: buffer_list @ 0x%p (DMA: 0x%llx), rx_queue @ 0x%p (DMA: 0x%llx), %llu entries\n",
+			   i, adapter->buffer_list_addr[i],
+			   (unsigned long long)adapter->buffer_list_dma[i],
+			   adapter->rx_queue[i].queue_addr,
+			   (unsigned long long)adapter->rx_queue[i].queue_dma,
+			   (unsigned long long)rxq_entries);
+	}
+
+	netdev_dbg(netdev, "allocated %u RX queue(s) with %d entries each\n",
+		   adapter->num_rx_queues, rxq_entries);
+
+	return 0;
+
+err_cleanup:
+	/*
+	 * Free each leftover resource by pointer presence. A
+	 * dma_mapping_error on queue i has already dropped
+	 * buffer_list_addr[i] but can leave rx_queue[i].queue_addr
+	 * live, so this index may be mixed. Do not collapse the
+	 * buffer_list and queue_addr checks.
+	 */
+	for (; i >= 0; i--) {
+		if (adapter->buffer_list_addr[i]) {
+			dma_unmap_single(dev, adapter->buffer_list_dma[i],
+					 4096, DMA_BIDIRECTIONAL);
+			adapter->buffer_list_dma[i] = 0;
+		}
+		if (adapter->rx_queue[i].queue_addr) {
+			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
+					  adapter->rx_queue[i].queue_addr,
+					  adapter->rx_queue[i].queue_dma);
+			adapter->rx_queue[i].queue_addr = NULL;
+		}
+		if (adapter->buffer_list_addr[i]) {
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+		}
+	}
+
+	return -ENOMEM;
+}
+
+/**
+ * ibmveth_cleanup_rx_resources - Free all RX queue resources
+ * @adapter: ibmveth adapter structure
+ */
+static void
+ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	int i;
+
+	netdev_dbg(adapter->netdev, "cleaning up %u RX queue(s)\n",
+		   adapter->num_rx_queues);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->buffer_list_addr[i]) {
+			dma_unmap_single(dev, adapter->buffer_list_dma[i],
+					 4096, DMA_BIDIRECTIONAL);
+			adapter->buffer_list_dma[i] = 0;
+		}
+
+		if (adapter->rx_queue[i].queue_addr) {
+			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
+					  adapter->rx_queue[i].queue_addr,
+					  adapter->rx_queue[i].queue_dma);
+			adapter->rx_queue[i].queue_addr = NULL;
+		}
+
+		if (adapter->buffer_list_addr[i]) {
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+		}
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -390,8 +578,12 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
+	__be64 *p;
 
+	if (!adapter->buffer_list_addr[0])
+		return;
+
+	p = adapter->buffer_list_addr[0] + 4096 - 8;
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
 
@@ -626,74 +818,34 @@ static int ibmveth_open(struct net_device *netdev)
 	int rc;
 	union ibmveth_buf_desc rxq_desc;
 	int i;
-	struct device *dev;
 
 	netdev_dbg(netdev, "open starting\n");
 
 	napi_enable(&adapter->napi[0]);
 
-	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
-	rc = -ENOMEM;
-	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!adapter->buffer_list_addr[0]) {
-		netdev_err(netdev, "unable to allocate list pages\n");
+	rc = ibmveth_alloc_filter_list(adapter);
+	if (rc)
 		goto out;
-	}
 
-	adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
-	if (!adapter->filter_list_addr) {
-		netdev_err(netdev, "unable to allocate filter pages\n");
-		goto out_free_buffer_list;
-	}
-
-	dev = &adapter->vdev->dev;
-
-	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
-						rxq_entries;
-	adapter->rx_queue[0].queue_addr =
-		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
-				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
-	if (!adapter->rx_queue[0].queue_addr)
+	rc = ibmveth_alloc_rx_queues(adapter, rxq_entries);
+	if (rc)
 		goto out_free_filter_list;
 
-	adapter->buffer_list_dma[0] =
-		dma_map_single(dev, adapter->buffer_list_addr[0],
-			       4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
-		netdev_err(netdev, "unable to map buffer list pages\n");
-		goto out_free_queue_mem;
-	}
-
-	adapter->filter_list_dma = dma_map_single(dev,
-			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
-		netdev_err(netdev, "unable to map filter list pages\n");
-		goto out_unmap_buffer_list;
-	}
-
+	rc = -ENOMEM;
 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		if (ibmveth_allocate_tx_ltb(adapter, i))
 			goto out_free_tx_ltb;
 	}
 
-	adapter->rx_queue[0].index = 0;
-	adapter->rx_queue[0].num_slots = rxq_entries;
-	adapter->rx_queue[0].toggle = 1;
-
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	netdev_dbg(netdev, "buffer list @ 0x%p\n",
-		   adapter->buffer_list_addr[0]);
-	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
-	netdev_dbg(netdev, "receive q   @ 0x%p\n",
-		   adapter->rx_queue[0].queue_addr);
-
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
@@ -708,7 +860,7 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_unmap_filter_list;
+		goto out_free_tx_ltb;
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
@@ -735,8 +887,6 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_buffer_pools;
 	}
 
-	rc = -ENOMEM;
-
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_interrupt(netdev->irq, netdev);
 
@@ -752,26 +902,12 @@ static int ibmveth_open(struct net_device *netdev)
 			ibmveth_free_buffer_pool(adapter,
 						 &adapter->rx_buff_pool[0][i]);
 	}
-out_unmap_filter_list:
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-
 out_free_tx_ltb:
-	while (--i >= 0) {
+	while (--i >= 0)
 		ibmveth_free_tx_ltb(adapter, i);
-	}
-
-out_unmap_buffer_list:
-	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
-			 DMA_BIDIRECTIONAL);
-out_free_queue_mem:
-	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
-			  adapter->rx_queue[0].queue_addr,
-			  adapter->rx_queue[0].queue_dma);
+	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
-	free_page((unsigned long)adapter->filter_list_addr);
-out_free_buffer_list:
-	free_page((unsigned long)adapter->buffer_list_addr[0]);
+	ibmveth_free_filter_list(adapter);
 out:
 	napi_disable(&adapter->napi[0]);
 	return rc;
@@ -780,7 +916,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	struct device *dev = &adapter->vdev->dev;
 	long lpar_rc;
 	int i;
 
@@ -805,17 +940,8 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
-	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
-			 DMA_BIDIRECTIONAL);
-	free_page((unsigned long)adapter->buffer_list_addr[0]);
-
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-	free_page((unsigned long)adapter->filter_list_addr);
-
-	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
-			  adapter->rx_queue[0].queue_addr,
-			  adapter->rx_queue[0].queue_dma);
+	ibmveth_cleanup_rx_resources(adapter);
+	ibmveth_free_filter_list(adapter);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		if (adapter->rx_buff_pool[0][i].active)
-- 
2.50.1 (Apple Git-155)


