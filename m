Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE15606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VxJlhoRc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsM2gb3z2xwP;
	Tue, 10 Nov 2026 10:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268599;
	cv=none; b=C1daADxbVT6u3nFNRu3EF3BYVmHpi4az8KgipxSVKtF448GRDPNmOrpQGzNf/xdAmcdUhesnDihlENXs37DU8Y7zW8Rqhsj51Qh2ZETqy9Hjs+otoZrsAQv12PzuDggRj9ID/sojrY0vpJeXZ0ULKsgEBpskjKh55BC27tuvWfWBQOkmzkSoXBc2Vno5xq7TSQnb9f/VAs7kD+IPx38bzcM2/sc2bEB9Gv+kRN46T4kiQ3HIKsRjadBVMSzzYSywGF9+F2EdS4w542jq6eaXtNhtXsnumzX2gk2oIJ+iBZL6ohnAnyq2UsKROMK+d/URpfWtH5DsB/40VBBJMLbOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268599; c=relaxed/relaxed;
	bh=ZBnkXV+dPpjdUMp/o+M1dPqMREgzuEl5F0whH915fUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bA6F8ogFbjhYuz7Dv51YfVNgGjxhQqE6WcI+iXvkrf8UN/ywMcz2iCz728YEH8cElAlcrezJFTBD29FRv5C6QOYFnudfa9dvprLKPajZP4RpY2cqKRKEaheTtHq/XeeLk469UHMp2Lzer3PN2cdLeeakerN5v+TmjB/bNbaiGSLXQLGqK5j0nsyCzRZC90ODXwPROU426ibXQc7HMdikifJhaxOOCQIu8NOmQREItmn1svRFJiOIrLOnL+IQI+97/hPo6r6q182PylcQypH9PB2FmfClTqIAxFLDULmQ5cmji01eHYR29QuTbezvDcQKpUCViX1zqczuoExUbC1D3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VxJlhoRc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VxJlhoRc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsL1h3nz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:38 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEFZg512535;
	Mon, 9 Nov 2026 23:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZBnkXV+dPpjdUMp/o
	+M1dPqMREgzuEl5F0whH915fUY=; b=VxJlhoRc5/lNJlFMuif3jbkyd2ot9rtaj
	EyR2JfkWPZ/vWY2+tA0wXWu8bG6fkBqC701LQ9bRfhI/bX+biTMlKXYbtXXflrLG
	U9X4rXUBKnPECOepJ4vPPbJZyDldpcMlPWSRcC4R0Lu1t571EoVlLhoAWbKId0bE
	XnDvdhq1MmAXwgDWZhcpXhAXvMFxSGT9R+v9LDDqSgS6jF9dybBI1U0nsupubgRI
	o2Uw2IWajBqLn7m6tF6t4cTAOqFg36iT1LYKOsOqD1r/Jwa8mav+qqzzrIACgNxz
	s2lUvephvrqPd2Wah7xLfcmxvN+S5qx8czCA3Jvlo7NQobjH1YSXQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumusrsk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJwYq3831246;
	Mon, 9 Nov 2026 23:56:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg43w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NuN7r26345990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6375458067;
	Mon,  9 Nov 2026 23:56:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 282A058028;
	Mon,  9 Nov 2026 23:56:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:19 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 03/15] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Mon,  9 Nov 2026 15:55:44 -0800
Message-Id: <20261109235556.60604-4-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX/rzWpkXd1BEB
 mE/tUGAO4FTHuTsxF/7Eg5Pm5t4SS9k4PepM9Oj6ampOBX22m9n0eHp3Dq4y3ZXk/7dPh2M+Jyf
 hHoZu+ASCLmoG27QMYaNtyp49BioIvg=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af25daa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jVyGSsqy6OvhAJL82RIA:9
X-Proofpoint-GUID: fVr05oOkO1LkASgeI-XYs36zrVAYfupW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX6jVdHWwxF5UZ
 8qDPZeGd6L7Uk8Jn5czQIPYnm3tjjhZAH0gXyCIhvJZLIA9DPFhVq4wBCAXMKJXXCdoaAxbPsZa
 5etKa1XTR4tXhAzZVK3OqI6cWX8RLZtYM5gtOLnk0Lig0PqPK617A6LAmigEXWL5grkNIFEUqeQ
 6QRETojo/tvM9wiY9PZMkoG5unlkUMXeV6sveKSWusIgJkfPdDBaTgJq1vkl6QvVNSS3PLUQQSG
 Vgy4+Os3hJtsuWiTV+EqMu1R5A8UN9xBA0rgs2kVmKtW8UnLOBgzzio1j4E5SN5vJsQBZvj9A/n
 uFBAjhHRcIYrvOJ2CQ7XhEYElkBqRtFx3ahMJtNxnvoFzUfBro8NT+qJC81xBh3kRZbE1Mmn43l
 ZykliScoqrqEhxInP3yq8lpTDDPmaG1fJw4p8RBssGs6E+2cfj8qZ9Zf9lkK+W5Z2YEiabfJ+Hy
 tk9z9dZzFCH1e7boPqQ==
X-Proofpoint-ORIG-GUID: wuGm679LNaHgLVBVlPnJXMjMkuXYmJ1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Cleanup NULLs each slot as it frees. A filter-list map error clears
both filter_list_addr and filter_list_dma, so no stale handle stays
in the adapter; unmap is gated on the CPU page because SPAPR can
return DMA address 0. ibmveth_update_rx_no_buffer() returns when
the buffer list is not allocated yet.

Runtime behavior stays single-queue (num_rx_queues is still 1). Buffer
pools, IRQ, TX LTB, and PHYP registration remain inline for later
helper patches.

Also set rc = -ENOMEM before the TX LTB allocation loop so a failed
ibmveth_allocate_tx_ltb() still returns a useful errno after the RX
allocation blocks move into helpers, and drop the dead rc = -ENOMEM
after request_irq().

open() now allocates the filter list first and initialises the RX
ring before the TX LTB loop. The list-page error names the queue, a
failed RX ring allocation gets its own error, and the per-buffer
netdev_dbg() lines are replaced by per-helper ones.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- rebased onto net-next, which carries the open-fail pair and the nine
  merged fixes; the TX unwind keeps net-next's real_num_tx_queues loop
- commit message lists the open() order and log string changes, and
  the dead rc after request_irq() this patch drops

This patch adds the filter-list DMA sentinel (filter_list_dma = 0
on map error) and the update_rx_no_buffer() NULL guard on
buffer_list_addr[0]; those are not in the merged fixes.

Changes in v7:
- NULL-check buffer_list_addr[0] in update_rx_no_buffer()
- reword err_cleanup comment for the mixed map-failure state
- drop the failed-reopen then ndo_stop double-free claim from the body
- noted: no Fixes: peel of the DMA-handle checks; standalone after
  this series
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
 1 file changed, 206 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ecfa7f737dbb..68791402cd53 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -159,6 +159,194 @@ static unsigned int ibmveth_real_max_tx_queues(void)
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
+		/* Do not leave DMA_MAPPING_ERROR in the adapter. */
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
@@ -398,8 +586,12 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
+	__be64 *p;
+
+	if (!adapter->buffer_list_addr[0])
+		return;
 
+	p = adapter->buffer_list_addr[0] + 4096 - 8;
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
 
@@ -672,72 +864,32 @@ static int ibmveth_open(struct net_device *netdev)
 	int rc;
 	union ibmveth_buf_desc rxq_desc;
 	int i;
-	struct device *dev;
 
 	netdev_dbg(netdev, "open starting\n");
 
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
-			goto out_unmap_filter_list;
+			goto out_free_tx_ltb;
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
@@ -752,7 +904,7 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_unmap_filter_list;
+		goto out_free_tx_ltb;
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
@@ -784,8 +936,6 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_buffer_pools;
 	}
 
-	rc = -ENOMEM;
-
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_interrupt(netdev->irq, netdev);
 
@@ -805,24 +955,12 @@ static int ibmveth_open(struct net_device *netdev)
 			ibmveth_free_buffer_pool(adapter,
 						 &adapter->rx_buff_pool[0][i]);
 	}
-out_unmap_filter_list:
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-
+out_free_tx_ltb:
 	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
 		ibmveth_free_tx_ltb(adapter, i);
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
 	return rc;
 }
@@ -830,7 +968,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	struct device *dev = &adapter->vdev->dev;
 	long lpar_rc;
 	int i;
 
@@ -868,17 +1005,8 @@ static int ibmveth_close(struct net_device *netdev)
 
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


