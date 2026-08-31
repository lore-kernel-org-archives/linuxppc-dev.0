Return-Path: <linuxppc-dev+bounces-26304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E86FC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:08:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXSC0GCWz2yrH;
	Tue, 01 Sep 2026 01:08:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188907;
	cv=none; b=G2IlbCAT/ZTUAaNHyGAnZkSudk0BkLi/cNsOiJWPdq/koqnZ9KFd+omrHaOl1nPRwGXicfEs1krohbdLJ+wuiBXUy8l5FwX9uBm7BEFhKNUyDmAHjsWezuQrs2S1PHRI0uJ2yVfsQ/t0oDP9wYE0CfDoEmxgkAZPSr3V4JpkIRO3F0M5yKyfo+O3ABU+JLI4cUby/uPMsoDUKcBJ0p7GYrdsxgbUqDYPxLeOsdrQz7vLZ7jPAVoMrmAuOXsGmdfE5dhqxOwzgn0mLCRYL+q7B7Wyg+lcZ/Xsue24jBb8C03dTHTz616JwMdwfPMcsBMZyrzIuUkh53JIGlqyMe1umg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188907; c=relaxed/relaxed;
	bh=dab5cAChUzCYUQ9iWV3i1TZjjb6sgbKPrbqXx/YHCB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDsxxqhfN83ZZEuDP9sJV8UsMzBUPjuCtDRowH+UJYLsb5VU0wt+V+D3Ac1muiNb7WchRU/9/j7EMlQCXt8RiaqrMtZHioBbyLf+whRqaoYozYlvldW45kLmJ+h+CGORv5OJ2qwJb3nouLw7Y4Z89dkuBVELP7q4I5J2igtJDA+RVx/Rl0hN3QGl5bhybYx9RMCqAzhvUG0UNa+0z+WCjYadd/n50B4QfomkEKlfiFs15vNCfRH70MXtRDW7RV4jQFbt1WHfKeTN4AS2yB+vUuozhhnesBlnT5blBLZ4W3+EExteGVbsUwJBP8E0BRue9hfJkSglmgA5lFs/SR45Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KoQNOxrh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KoQNOxrh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXS93gGnz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:25 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZVtn2583578;
	Mon, 31 Aug 2026 15:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dab5cAChUzCYUQ9iW
	V3i1TZjjb6sgbKPrbqXx/YHCB4=; b=KoQNOxrh5DbpQzBHzbDs31LmTL8eGaN57
	QZSeNBfrNsttVx4rX4yWdJKV+FuLxViI9B/Tq83ePPIwNdXXrCjY3Fq5DNHW5kzH
	bvQC5HbXOogYo8lvbakjN1v7ANmfZ/e0zVZGz4SddzqAvTTbeEHEIzjOHC5YGDrE
	5ZljEViypmZNQu4amkF/PiRntYlLxvpiT2fblKeJk07fFVEitIA01fgAkbMHrv9s
	J+SfHqkUgkAvkMX9XIGPCH1k2vkFZZd0j8HM2yR0cWWwJh1RbuEKSMR1mPFjKjBW
	ofuxSc0PeZV51pkGPD51fmOWlARiSKavI7cm9YPSlgKMucGRZJdLA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1x2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuJio003212;
	Mon, 31 Aug 2026 15:08:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6qrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF89wS31392490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF0A58051;
	Mon, 31 Aug 2026 15:08:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6469F5805F;
	Mon, 31 Aug 2026 15:08:05 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:05 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 03/15] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Mon, 31 Aug 2026 08:07:14 -0700
Message-Id: <35d4e6e84a68bb44d6f0968926b77e555abd126e.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9598de cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=an1raLIMKTMwdd-vNtwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX+wyyVZvROde0
 T+qcEKyP6+2rDgRqWudVE/pI75arzmLfoS6ui8GpU3/nBB5ZUsPgkOScuaJWqnJd80MpUQ8Q/QU
 LUeOvIxfcbf0Mvbbg8HJkyZvp/EBb5Y=
X-Proofpoint-ORIG-GUID: 9nEvZB949MVRHfbmY7DU_2lAx39T8nSK
X-Proofpoint-GUID: LxYPTLbu3rSin_x2lGgvDcywSJItV9zX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX7YTprt/deLbz
 lmUCAIHCirs5VZc0o1/unwHrq4kEoJtpZagIYzNIq7VOr268/xKnAVTJdMbF87h+Cr/LitizU+T
 zldJS1ngE9HLHKZJYvW1OqEGTBCOTIA6FF203cHGf9I1tZvJ3Vo7VpTuiNKNibZX4cvXtybwxpG
 CiF40mvywMl9csAxX9bwnUi6U6se+mKPNzTWXqq4sdRA0pnhu6Rp/qq+ClaGKHS+jfC+hFT+2oS
 7f5G93UTqxSwd3q0USG2t27Vh3oQDa14lNkj60FIGzDMGgSBgjLcK2mbWN69Qt3nA2pL0SN3Mid
 Ghd63RqH1sXGIawD0i3Zr+YVIc32OqrWhaXjwEWpvelOu/EJAoy4u+o3eSU/ZkDugwNt2azzrUa
 DR6KhBs03RcYISKrX46MA2qeXS9Gg/PKTcoayOfGSHGBFTnso1MfLB2wd1y8fchSki54xVfhWX7
 vtfOC2yt5xZSu6yAhhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

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

The pointer and DMA-handle guards also close a baseline double
free_page() and stale dma_unmap after a failed reopen followed by
ndo_stop: a filter-list map error zeros filter_list_dma so a later
free path cannot unmap DMA_MAPPING_ERROR, and unmap is gated on the
CPU page because SPAPR can return DMA address 0. Cleanup NULLs each
slot as it frees.

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

 drivers/net/ethernet/ibm/ibmveth.c | 277 +++++++++++++++++++++--------
 1 file changed, 199 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 7cb828b476c1..d2dad9e6068e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -151,6 +151,193 @@ static unsigned int ibmveth_real_max_tx_queues(void)
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
+	 * Every failure path above releases what it had already allocated
+	 * for queue i, so each index here is either fully constructed or
+	 * fully empty. Do not unmap buffer_list_dma[] without the matching
+	 * buffer_list_addr[] check: the two are only ever set together.
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
@@ -626,74 +813,34 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -708,7 +855,7 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_unmap_filter_list;
+		goto out_free_tx_ltb;
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
@@ -735,8 +882,6 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_buffer_pools;
 	}
 
-	rc = -ENOMEM;
-
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_interrupt(netdev->irq, netdev);
 
@@ -752,26 +897,12 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -780,7 +911,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	struct device *dev = &adapter->vdev->dev;
 	long lpar_rc;
 	int i;
 
@@ -805,17 +935,8 @@ static int ibmveth_close(struct net_device *netdev)
 
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


