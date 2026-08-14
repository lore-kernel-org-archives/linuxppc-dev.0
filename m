Return-Path: <linuxppc-dev+bounces-25847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2AC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:38:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGj1jv2z30WY;
	Fri, 14 Aug 2026 17:38:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693101;
	cv=none; b=R5rPtCBeTZeLJcgq+NBqGCNiz9kWuc+DEaf9zviQyrmHq/VIQ4UHl+nSJ2naFilP+vexE2HqDDmQ+nFFpjtn/rgUs8y8FdtAsvsscOoDAA/JU+BDR8tB83U2dRI8mVpHwBldP8Qa+txQslWuEcI6LgWHVru+93kWk+ChSBOAAE4v4z7unztHRysM0l3aBZgsL799tvX+chuK2/cEXOydkBK2KrkvuVYVHviDCI63mP31PPZe06DfJDnqejV3cIfAlH4U5EPcH5l7hfKmzmeZsNTWjivuB1RSZ1UFLUM2ZfgEZfXemE5n62ilA/LLEap0gij04185TsFNd6r5ivwBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693101; c=relaxed/relaxed;
	bh=WJ1aG/coy/qYgY7KpbbN1eNuSvRdA1OI/m3oTqg/Wq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KRURWVXIAAapRASVB95j+46dY3FUsMS1zMtIR/WGX+8G0SiZsaytlxUt3XoFtvH9Gr1ROv7AgsXatksUPNK3W6BrWy/mu+o/6lEVhUkp6CGAruix9owjArG40LM1DDYF2z7X4jY1UTcbk3JZdyumzvuyJSmXfg+gLMfvbZzHamFIgVTzqRlJ21+fdXbdeCC1lWTL2cn3+OOW/hQbjx6Hy9KX8l2+Ty1ov9wmVAFGbjWtg2riQdeicJbmq3YfWtnqmTFqPANQd7s3BDtNgdOD37FmMoT2pO1y/Upefdy+RgFeeGLQ9KrZyXyYjH3JL31bTNX02KomkpA046kQ4itRsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fZu8IS5X; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fZu8IS5X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGg3g9Lz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:19 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Vfug154769;
	Fri, 14 Aug 2026 07:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WJ1aG/coy/qYgY7Kp
	bbN1eNuSvRdA1OI/m3oTqg/Wq4=; b=fZu8IS5XAUsXdTEq1a5uijXutfjl7png3
	Fasea0JMZKdXMpYgO1fatfPlEcC6jxSLdiPSceC4SOYcBoSOKB1jW/6zKfHmfVis
	c3TEELqB0VU5v8JJy+Dpy2qTsMrIzvvf7aPwbWWOrSXipxF5gyM45XExK7pDoElN
	UxiYuKdnJFjRI3pr5HAeaF9DV1PLV/DsOUJ0FBMXRXqCgWOmaDxCTt5QvF6Tu509
	5X0jTI6gJqQgWgECAvKxXWlTf4k2NxYytYvbGJLh5hIK1d8hNk0dtTM3NCb562vp
	5iEVQLmbpQCv/9A9haJ+1anqqNAz5dg14Ir7a4JkL53nv4Topm4+w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma3tt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QRZo013835;
	Fri, 14 Aug 2026 07:38:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv94wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7c4JH30736874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 027E658065;
	Fri, 14 Aug 2026 07:38:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D8258058;
	Fri, 14 Aug 2026 07:38:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:01 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 07/15] ibmveth: Add RX queue register helpers for MQ
Date: Fri, 14 Aug 2026 00:36:34 -0700
Message-Id: <20260814073642.24630-8-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX3YEYjBimDU7A
 3w8byYMphrG/HkVIxELAyw8drDZ7nFIemVJGDZrf1/W9elDAHV1C87jdlJEI/7YbYnSYvIe1hR8
 mj2LlD7HwnD9vu5IWZvC22nO0QrVpTEzj7VXElBKeYGGH1+1ngc72QlngxtTNgVcEieGbWO0pUx
 16lOfiZxRRo+0eGcRYsfA70LO43d9tBrMwtFJAtw7DDo8UNvb+RBaml4KJOqqTmaCaiGSVV1bSK
 qXjVbN7IjevddgpTsL2k5++3LNjLYIPfbFnkC2UGBmwEI7VuIZU3UAhv54KicOt4cyizLyFT/io
 Pmp013e7y8ZzMZQhzRa4ENuvsWPj0ksCXitEiPS/RvrtCYG5aMeT5RjWKwTptq5mSxty+PWDATW
 wxmf332CRFjdkhOVEX9BbdCZSVmon/qSY3kKtY793SCvO4pR00SVjBVAJlJVimTUyiwbMZkR1ez
 5OqSMKaVK8phSuRZwXg==
X-Proofpoint-ORIG-GUID: J5qs89g9jKdLNYwa25dyv0InLq1EyAcv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXyJaBLEkkP0wx
 Jxw2WQBA7pejcYyYuXd4qZGtKZosHR11jI1UM3CB4Oht9w+cuyYFlPrbeaWmAGZfcxt8TE/cEP2
 XthbeCqJdhc+dCTtUhtHJtTZJQak1SY=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ec5e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LCABU1SJQDt5kw-hZ4sA:9
X-Proofpoint-GUID: ybRaQpsZUcCW5cB5aGbZUPji77xt5M7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

MQ RX changes queue lifecycle from one adapter-level register/free pair
to a mixed model:

  - queue 0: registered via h_register_logical_lan*()
  - queues 1..N: registered via H_REG_LOGICAL_LAN_QUEUE

This patch extracts the queue-0 control-plane helpers used by open/close
today and wires them in the same commit:

  ibmveth_register_rx_queues()
  ibmveth_free_all_queues()

H_FREE_LOGICAL_LAN tears down the primary LAN and any subordinate queues
registered under it (PAPR/PHYP full-teardown contract). Close and
open-fail use that one free_lan. Incremental scale-down uses per-queue
H_FREE_LOGICAL_LAN_QUEUE instead; that path arrives with resize.

Also update ibmveth_register_logical_lan() so that when multi_queue is
later enabled, queue 0 uses h_register_logical_lan_with_handle() and
stores queue_handle[0]. Runtime remains single-queue: multi_queue is
still false, so queue 0 keeps the legacy h_register_logical_lan() flow
and no subordinate queue is registered. Subordinate register helpers
arrive with MQ enablement; deregister arrives with resize at first use.

Introduce adapter->hcall_stats here for register/free path accounting
(first use).

Open/close unwind:
  - failures after successful LAN registration enter
    out_unregister_queues, then fall through to out_free_buffer_pools,
    so RX pools are not leaked;
  - free_all_queues() runs before free_buffer_pools() on open failure
    and close, so PHYP cannot retain a registered LAN while its
    DMA-backed RX pools are released.

Failures before registration go directly to out_free_buffer_pools.
RX interrupt masking before napi_disable is already handled by
cleanup_rx_interrupts() from the IRQ-helper patch.

As of this patch, open/close follow the MQ-ready pipeline below
(still single-queue). The MQ enablement patch changes open's kick
(replenish-all before setup_rx_interrupts, then restart_rx_queue per
queue for SQ and MQ) and should restate that open path there. Close
shape stays the same through enablement.

ibmveth_open() (this commit):

  1. ibmveth_alloc_filter_list()
  2. ibmveth_alloc_rx_queues()       - buffer lists + RX rings
  3. ibmveth_alloc_buffer_pools()   - guest RX memory before PHYP
  4. ibmveth_register_rx_queues()   - PHYP registration (no IRQ enable)
  5. netif_set_real_num_rx_queues()
  6. ibmveth_setup_rx_interrupts()  - request_irq + napi_enable
  7. initial kick                   - schedule_rx_queue(0)
  8. ibmveth_alloc_tx_resources()
  9. netif_tx_start_all_queues(); adapter->opened = true

ibmveth_close() (this commit):

  0. if (!opened) return; opened = false
  1. netif_tx_disable()
  2. ibmveth_cleanup_rx_interrupts() - mask PHYP, napi_disable, free_irq
  3. synchronize_net()
  4. ibmveth_update_rx_no_buffer()   - last glimpse while LAN registered
  5. ibmveth_free_all_queues()       - H_FREE_LOGICAL_LAN (this patch)
  6. ibmveth_free_tx_resources()
  7. ibmveth_free_buffer_pools()
  8. ibmveth_cleanup_rx_resources()
  9. ibmveth_free_filter_list()

Per-queue NULL-safe update_rx_no_buffer() lands in the MQ enablement
patch. Idempotent close (opened / rx_irq_setup) is owned by the
IRQ-helper patch.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- Document H_FREE_LOGICAL_LAN full-teardown contract in kdoc/changelog:
  one free_lan drops primary + any subordinate queues
  (H_FREE_LOGICAL_LAN_QUEUE is for incremental scale-down only) - v4
  helper text did not spell the subordinate semantics
- Call out close() update_rx_no_buffer() before free_lan as intentional
  last-glimpse accounting while the LAN is still registered (order
  already in v4; v4 step list omitted it); NULL-safe per-queue form
  lands with MQ enablement
- opened / rx_irq_setup idempotent close is owned by the IRQ-helper
  patch (same failed-reopen / second napi_disable hang raised here)
- Poll re-arm during teardown not claimed here (same race as IRQ patch;
  lands with poll harden)

Changes in v4:
- Introduce register/free helpers in the same patch that wires their
  first open/close callers; keep subordinate-only helpers deferred
  until MQ enablement.
- Introduce adapter->hcall_stats here (first use); not in patch 2.
- Correct open/close unwind so free_all_queues() precedes
  free_buffer_pools().
- Drop the orphaned big-bang "open/close pipeline" patch from v3; that
  wiring is incremental across helper patches 3-7 instead.

 drivers/net/ethernet/ibm/ibmveth.c | 169 +++++++++++++++++++++--------
 drivers/net/ethernet/ibm/ibmveth.h |  14 +++
 2 files changed, 137 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b39e8c53cbfd..8519cad50322 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1260,9 +1260,14 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+					union ibmveth_buf_desc rxq_desc,
+					u64 mac_address)
 {
 	int rc, try_again = 1;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long buf_dma = adapter->buffer_list_dma[0];
+	unsigned long filter_dma = adapter->filter_list_dma;
+	unsigned long qh0;
 
 	/*
 	 * After a kexec the adapter will still be open, so our attempt to
@@ -1270,13 +1275,27 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 * try again, but only once.
 	 */
 retry:
-	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma[0], rxq_desc.desc,
-				    adapter->filter_list_dma, mac_address);
+	/* In multi-queue mode, obtain a queue handle for queue 0 so all RX
+	 * queues can use the same per-queue buffer hypercalls.
+	 */
+	if (adapter->multi_queue) {
+		rc = h_register_logical_lan_with_handle(ua, buf_dma,
+							rxq_desc.desc,
+							filter_dma,
+							mac_address,
+							&qh0);
+		if (rc == H_SUCCESS)
+			adapter->queue_handle[0] = qh0;
+	} else {
+		rc = h_register_logical_lan(ua, buf_dma, rxq_desc.desc,
+					    filter_dma, mac_address);
+	}
+	adapter->hcall_stats.reg_lan++;
 
 	if (rc != H_SUCCESS && try_again) {
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
+			adapter->hcall_stats.free_lan++;
 		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
 
 		try_again = 0;
@@ -1286,14 +1305,93 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+/**
+ * ibmveth_free_all_queues - Free all RX queues at once
+ * @adapter: ibmveth adapter structure
+ *
+ * Issues one H_FREE_LOGICAL_LAN for full adapter teardown. Per PAPR/PHYP,
+ * that drops the primary LAN and any subordinate queues registered under
+ * it. Incremental scale-down uses H_FREE_LOGICAL_LAN_QUEUE per queue
+ * instead; do not use this helper for partial live-set shrink.
+ *
+ * Used during interface close and registration error cleanup.
+ *
+ * Clears queue handles only; queue_irq[] is released by
+ * ibmveth_cleanup_rx_interrupts().
+ */
+static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+{
+	unsigned long lpar_rc;
+	int i;
+
+	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
+
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+		adapter->hcall_stats.free_lan++;
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		adapter->queue_handle[i] = 0;
+}
+
+/**
+ * ibmveth_register_rx_queues - Register RX queues with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @mac_address: MAC address for device registration
+ *
+ * Registers queue 0 via ibmveth_register_logical_lan(). Subordinate queue
+ * registration is added when multi-queue RX is enabled.
+ *
+ * Return: 0 on success, -ENONET if queue 0 registration fails
+ */
+static int
+ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	unsigned long lpar_rc;
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
+	netdev_dbg(netdev,
+		   "registered 1 RX queue with hypervisor (single-queue mode)\n");
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
@@ -1309,37 +1407,23 @@ static int ibmveth_open(struct net_device *netdev)
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
+	if (rc)
 		goto out_free_queue_mem;
-	}
 
-	rc = ibmveth_alloc_buffer_pools(adapter);
+	rc = ibmveth_register_rx_queues(adapter, mac_address);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_free_buffer_pools;
+
+	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
+	if (rc) {
+		netdev_err(netdev, "failed to set number of rx queues\n");
+		goto out_unregister_queues;
+	}
 
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_free_all_queues; /* setup already disposed IRQs */
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
@@ -1357,10 +1441,12 @@ static int ibmveth_open(struct net_device *netdev)
 
 out_cleanup_rx_interrupts:
 	ibmveth_cleanup_rx_interrupts(adapter);
-out_unregister_lan:
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+	goto out_free_all_queues; /* cleanup already disposed IRQs */
+out_unregister_queues:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+out_free_all_queues:
+	ibmveth_free_all_queues(adapter);
+out_free_buffer_pools:
 	ibmveth_free_buffer_pools(adapter);
 out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
@@ -1373,7 +1459,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	long lpar_rc;
 
 	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
 	 * leave IFF_UP set after a failed reopen.
@@ -1395,15 +1480,7 @@ static int ibmveth_close(struct net_device *netdev)
 	synchronize_net();
 
 	ibmveth_update_rx_no_buffer(adapter);
-	/* Full LAN teardown (subordinates arrive with register helpers). */
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-	if (lpar_rc != H_SUCCESS) {
-		netdev_err(adapter->netdev,
-			   "h_free_logical_lan failed with %lx, continuing\n",
-			   lpar_rc);
-	}
+	ibmveth_free_all_queues(adapter);
 	/* Free TX LTBs after quiesce and after H_FREE_LOGICAL_LAN so xmit
 	 * cannot touch unmapped bounce buffers while the LAN is live.
 	 */
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index bf5dd5703773..fae3473cc498 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -268,6 +268,17 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
+struct ibmveth_hcall_stats {
+	u64 reg_lan_queue;	/* H_REG_LOGICAL_LAN_QUEUE */
+	u64 reg_lan;		/* H_REGISTER_LOGICAL_LAN */
+	u64 add_bufs_queue;	/* H_ADD_LOGICAL_LAN_BUFFERS_QUEUE */
+	u64 add_bufs;		/* H_ADD_LOGICAL_LAN_BUFFERS */
+	u64 add_buf;		/* H_ADD_LOGICAL_LAN_BUFFER */
+	u64 free_lan_queue;	/* H_FREE_LOGICAL_LAN_QUEUE */
+	u64 free_lan;		/* H_FREE_LOGICAL_LAN */
+	u64 send_lan;		/* H_SEND_LOGICAL_LAN */
+};
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -335,6 +346,9 @@ struct ibmveth_adapter {
 	u64 tx_send_failed;
 	u64 tx_large_packets;
 	u64 rx_large_packets;
+
+	/* Hypercall statistics */
+	struct ibmveth_hcall_stats hcall_stats;
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)


