Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BA606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sF9VisbV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsQ1VCgz30dn;
	Tue, 10 Nov 2026 10:56:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268602;
	cv=none; b=mcWYZXvh/I3Aq3uR0ICyEqbLO0tuP1GpQpBQ/GIRTkYHGtGJbiBX6ESrXhT1L34UKeWk6Km1AP+7n/wTmZDrH9aNyTPFxdiSd8lhih6Md66rr5ePItfcfvVHhcIo/CNZwUgiCq72m+bY6zntvfsbrMg5HwTRZyHWE7Ndm9FAGDDYlDOeaQpSRsTfoxl0xazWIHDZtRoTuDPYc6i0dbbcu1z9/WlAlYcbPO0Unqn+w+CYtJi20l+MxfgwHg+W+OpnGJ67siB3pqL4g88goYK4n20lni1k4hn9UphYxtK2buRnsYQDjv3cJo29JEPVlnB0WzEZRtaTpaR8sVFgNQ5iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268602; c=relaxed/relaxed;
	bh=PqARnUj+v7khZ5GnswXQMPoz8ASKvrM055bsOX6ueW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SM/1iWfKyUgqHoL2LxcpDMsMKlOW5GtP93fbUFAJ+kmu6pONQL/AYMvVCEXGwz6jv3h8Hfj9eAppM24ubSpJl3WyVqPNzG+hfpeloMheV3kGBWcWDrB2ZVaEXAcN6TD7hp1KGJ84lC0i+MNc5fD/02jG1b89YAAK6/wjUTXdYIyVXbEMw9BhfmtiYrx7DYY6qfr6wUKB1wGV7kvL6h+YL8pk+epwqCU0u8YGpnR+YtVYaFZx85PVY86f3OpfR8w41CmMa1bact97zE9O6XfJhWjeb4Sn/HpIztGsDrZ21HdmpsZRaWE+6kqlKblDxwuTlcOdpkAND29XzRIixWsqgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sF9VisbV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sF9VisbV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsP1WtBz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:40 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEGSl502492;
	Mon, 9 Nov 2026 23:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PqARnUj+v7khZ5Gns
	wXQMPoz8ASKvrM055bsOX6ueW8=; b=sF9VisbVLMyEig3F12fBDN9mMmqHcjWGO
	M/PTHL+rOvalr4d964xzHCRa3+m+8u7rFcTNxdupdxlneIiMmRk/qMj+2fVWktE1
	bfWiJ0XFcoczxHV62ak/E89ds/9c9w1q4/SBAnyTIp4bfCNi8AJUuPhA7DH5wWmL
	cMBlHM22YCG4ut7Lm54rQ29Sh5ez47g2l7Rl7ZBytwRifItvzvQT59JMVrTWiC2u
	9s4WGT31uP289hpcuwIMlyWrXjqEhWycAaEqnXXPxgoEY69W7pnrLEGPd8QYxONX
	01+7qpXLurQOPSxujKuk99fkYT9iMhb3u+a+JAJB6PHANPaerocMQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6ta0p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJxmw3831253;
	Mon, 9 Nov 2026 23:56:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg43w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NtdNq27263582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:55:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F6805805C;
	Mon,  9 Nov 2026 23:56:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AF9D58028;
	Mon,  9 Nov 2026 23:56:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:25 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Mon,  9 Nov 2026 15:55:45 -0800
Message-Id: <20261109235556.60604-5-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX6OsFg16t/T3e
 7Uh1At+sfYzrcO2uJmt6JnBrRX0qv3AEUb1rIPB8pNnoA0T8iCAae3CBpQu6rDtPw6AKA8pR1Ab
 Qj9WvYHe6Cx82bZQyBg3zYt8Kn7G/AA=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af25db0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=lp0D4TrqX67ggtpjc1wA:9
X-Proofpoint-ORIG-GUID: 1bs7wa3kJ-36b0bdcrS4TG2FEhntSs0y
X-Proofpoint-GUID: M3N89RNW12UzS3UZ5HtEoBPMGB-vGE6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXz7GYprEmX//4
 KfOYTrJFHgRs2TH5rEGHPDtHEsjmfPVmdutQpMg+cCCaRI/RAktNdZZbF4ZLeZ2qHCRae+j2Eni
 SNifSGtA8JD201rPx25Pr2OWDNavfHkJdidFuw5bh8gnf2ro0xSHaWJGl3jlazuKdaAMAVIus3E
 hkTh+WuUuXGGFZ021xCAOAlDlRXm7kwZv5uA64qJWP2hvKmpqJ9xnvq3XiO7YqOO9lHkloVbOYa
 bQ1fB1W3uGZAiJ9NNK9BFavwiyLZlU0UtzzDp9UFiit3BH5GmDYoeT2R39jgpzqE4w+W4bZpudf
 mAsz4Lhl1zJAl2U2FNOqw5QNeONtm6kJsT+IcrhPb3tyhStwWuywmwyfqi9IQFkrTdPIhgQ1qOd
 Fl+FnNJtAKKq5s80scvqVYwIETToDGlo6rYlRhUvSckHZabhY/b+DMvgi2/ZGPIZQkVVRa0PBI5
 D6rTSy1GzQBoYt+Y3nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Legacy ibmveth uses five adapter-level RX buffer pools (512 B through
64 KiB). pool_active[] enables the standard-MTU pools by default;
larger pools activate when MTU requires them. With single-queue RX
that set is shared on one completion path.

MQ requires the same pool model per queue: buffers post with
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against a queue handle and completions
return on that queue. Sharing pools across queues would mix ownership
and break queue-local replenish/drain/teardown.

Refactor around queue-local pools:

  rx_buff_pool[queue][pool]
  ibmveth_alloc_queue_buffer_pools()
  ibmveth_free_queue_buffer_pools()
  ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools()

Queue 0 remains the template for pool geometry and activation policy
(size, buff_size, threshold, index, active). Queues 1..N copy that
metadata from queue 0, then allocate backing arrays/skbs per queue.
The existing poolN/ sysfs knobs stay adapter-wide on queue 0: writing
a pool size multiplies real memory by num_rx_queues (still 1 here).
Per-queue runtime state is exposed later via debugfs, not separate
per-queue pool sysfs nodes.

Wire the helpers into open()/close() in the same patch. Runtime
remains single-queue (num_rx_queues is still 1).

A pool allocation failure still unwinds through out_free_buffer_pools,
so the logical LAN registered just before is freed with
h_free_logical_lan() as on the other post-register failures.

Error handling is queue-safe: allocation failure unwinds only what
that queue allocated (then prior queues in the caller).
alloc_buffer_pool() already undoes its own partials, so this open-fail
slot is empty. Free paths release by real allocations
(free_map/dma_addr/skbuff) rather than pool->active, so a pool is
freed whether or not its active flag still matches its memory.

close() also reorders pool teardown ahead of cleanup_rx_resources()
and filter-list free. napi_disable() and free_irq() have already run,
so NAPI no longer references the pool buffers or RX completion queue,
and PHYP does not once h_free_logical_lan() has succeeded. A failed
free is logged and the memory is still released, as close() did
before this patch; the order of the frees does not change that.

Keep the legacy 64 KiB pool enabled by default at standard MTU (same
as single-queue policy).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- a pool allocation failure in open() unwinds through
  h_free_logical_lan(), as the merged open-fail fix does

Dropped from this series (merged fixes own them):
- commit 84bec0bf0352: commit-message shared-TX-index unwind paragraph
  (base owns the unwind)

Changes in v7:
- no P04 code change
- commit message: request_irq() failure also reached
  out_free_tx_ltb with i spent
- noted: err_cleanup comment reworded in P03
- noted: no Fixes: peel of the shared-i TX LTB leak (named
  in the v6 body after v5); standalone [PATCH net] after
  this series
- noted: no pool-before-register reorder here; P06 issues h_free
  on the pool-fail path, P07 allocates pools before register

Changes in v6:
- retarget the free-by-presence comment to the later resize paths;
  alloc_buffer_pool() already undoes its own partials, so this
  open-fail slot is empty
- use %u for the two num_rx_queues dbg prints
- noted: pool-fail after register without h_free_logical_lan predates
  this patch; the inline pool loop reached the same labels. P06
  issues h_free before the pool DMA; P07 moves pools ahead of
  register_rx_queues

Changes in v5:
- vs mailed v4: keep pool_active[] = {1,1,0,0,1} (v4 set the 64 KiB
  pool inactive). No code delta vs prior patches here; SQ large-receive /
  CMO stay at the historical baseline. change_mtu does not re-enable
  pool4 at MTU 1500; MQ memory pressure belongs at scale-up, not SQ
  default
- Unwind / free pools by real allocations (free_map/dma_addr/skbuff),
  not only pool->active, so open-fail cannot leak partially allocated
  pools (v4 fail path freed by active and skipped the failing pool)
- Clarify kdoc: free paths use allocation presence (not "all active");
  queue 1..N metadata copy from queue 0 (v4 said "queues 1-15" while
  MAX is still 1 here)
- Document poolN sysfs size multiplies by num_rx_queues (queue 0 is the
  shared template; no per-queue pool sysfs in this series)
- Call out close() pool-free before cleanup_rx_resources, after LAN/
  NAPI/IRQ teardown (order already in v4; spell it for later drain)

Changes in v4:
- Introduce the pool helpers in the same patch that wires their first
  open/close callers, instead of leaving unused statics.
- Copy pool->index when cloning queue-0 geometry to later queues
  (needed for correlators; also required by incremental resize).

 drivers/net/ethernet/ibm/ibmveth.c | 159 +++++++++++++++++++++++++----
 1 file changed, 139 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 68791402cd53..31fad7713dc7 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -678,6 +678,140 @@ static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
 	schedule_work(&adapter->work);
 }
 
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees buffer pools that still hold allocations for the specified
+ * queue (by free_map / dma_addr / skbuff presence), regardless of the
+ * active flag.
+ */
+static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue][i];
+
+		/* Free by allocation presence, not by the active flag,
+		 * so a pool's memory is released whatever active says.
+		 */
+		if (pool->free_map || pool->dma_addr || pool->skbuff)
+			ibmveth_free_buffer_pool(adapter, pool);
+	}
+}
+
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates backing storage for each active pool on @queue.
+ * Inactive pools (!active) are skipped. Pool metadata must be
+ * initialized before calling this function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *bpool =
+			&adapter->rx_buff_pool[queue][i];
+
+		if (!bpool->active)
+			continue;
+
+		if (ibmveth_alloc_buffer_pool(bpool)) {
+			netdev_err(netdev,
+				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
+				   queue, i,
+				   bpool->buff_size,
+				   bpool->size);
+			bpool->active = 0;
+			/* Undo the pools this queue already allocated; the
+			 * failed one freed its own partial allocation.
+			 */
+			ibmveth_free_queue_buffer_pools(adapter, queue);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_alloc_buffer_pools - Allocate buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Initializes pool metadata for queues 1-N from queue 0 settings,
+ * then allocates buffer pools for all queues using the helper function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, q, rc;
+
+	/* Initialize pool metadata for queues 1..N from queue 0 settings */
+	for (q = 1; q < adapter->num_rx_queues; q++) {
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *src =
+				&adapter->rx_buff_pool[0][i];
+			struct ibmveth_buff_pool *dst =
+				&adapter->rx_buff_pool[q][i];
+
+			dst->size = src->size;
+			dst->index = src->index;
+			dst->buff_size = src->buff_size;
+			dst->threshold = src->threshold;
+			dst->active = src->active;
+		}
+	}
+
+	/* Allocate actual buffers for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
+		if (rc) {
+			/* Free pools for all previous queues */
+			while (--q >= 0)
+				ibmveth_free_queue_buffer_pools(adapter, q);
+			return rc;
+		}
+	}
+
+	netdev_dbg(netdev, "allocated buffer pools for %u queue(s)\n",
+		   adapter->num_rx_queues);
+	return 0;
+}
+
+/**
+ * ibmveth_free_buffer_pools - Free buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees buffer pools for all queues using the helper function.
+ */
+static void
+ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	int q;
+
+	/* Free buffer pools for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++)
+		ibmveth_free_queue_buffer_pools(adapter, q);
+
+	netdev_dbg(adapter->netdev, "freed buffer pools for %u queue(s)\n",
+		   adapter->num_rx_queues);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -907,16 +1041,9 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_tx_ltb;
 	}
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		if (!adapter->rx_buff_pool[0][i].active)
-			continue;
-		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
-			netdev_err(netdev, "unable to alloc pool\n");
-			adapter->rx_buff_pool[0][i].active = 0;
-			rc = -ENOMEM;
-			goto out_free_buffer_pools;
-		}
-	}
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc)
+		goto out_free_buffer_pools;
 
 	/* NAPI can run as soon as it is enabled, from netpoll during the
 	 * direct close()/open() pairs or from a direct ibmveth_interrupt()
@@ -950,11 +1077,7 @@ static int ibmveth_open(struct net_device *netdev)
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-	while (--i >= 0) {
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-	}
+	ibmveth_free_buffer_pools(adapter);
 out_free_tx_ltb:
 	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
 		ibmveth_free_tx_ltb(adapter, i);
@@ -1005,14 +1128,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
+	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-
 	for (i = 0; i < netdev->real_num_tx_queues; i++)
 		ibmveth_free_tx_ltb(adapter, i);
 
-- 
2.50.1 (Apple Git-155)


