Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99A60A2635
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D+Hc0kaT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsj4cmDz2yLY;
	Tue, 10 Nov 2026 10:56:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268617;
	cv=none; b=GRiCgtAld06gN0VX36m3CdM7CjcovZYxCYnkcLqTb5a9kM5LK7Bqe0/NAUH4oC5NGcu67t4NggSiCcXHrkcAx1ESsjiGIZE/wcxtcaTtE+1MAbNdiV884VD8zV7f9R5+eIn6I/Y+C0JaeBNh2IQ1cN6aIz98Srev6cFLiyypO6JquUmrU7gel2SK5T+mUY0Ja7oJHsGEjbQK1SqvHx1y06rGS2NBkYhNromnF2JdAjgwZh36RwTvYa150qmGT+oBhySIiWyJItTmqWURyEw3OYeAym8PnfC8DQ1Tlt6VsHFPAeEDNXf8mVRcUPidDjr0cnAdrOpHs4BYDUXzFnTGng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268617; c=relaxed/relaxed;
	bh=yAnN0V4ATJKY1SvJRnP+X7+DY39p/oBD2XcpsdVc+Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuHQ/6nvbInJJgeAU0sNL7wCSvQsg/NqMerEhpAnDJjkeFrPLEhNy1MmrFKl71sZj5egKOC29ZZDd03SdYyFTSQEdkcJwjndiZbh7WfDwSi8DqOBTrmBDD/ZdmtYdnmkz9YcRWKuuD0+TmrfLdxAsiZGF17OAHKtGPbTQ/K3qKA21ODdIg9RToKJSrW5rrgXYQWDLymDjiDCwovWlgjoxb5Vyc6ohW4HOk65tOLktU+uDsJ81yhCDCGs0Wrz1s99my8++pMGiZWUyIyTlmxhfiZ7EJeHOBaI41sbNDeGSjcVCo2OYWFulqqR3tEGyBCciGMW0ZeK5fJzGADjTqdPQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D+Hc0kaT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D+Hc0kaT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsh3SR1z2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:56 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEEb03484333;
	Mon, 9 Nov 2026 23:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yAnN0V4ATJKY1SvJR
	nP+X7+DY39p/oBD2XcpsdVc+Ss=; b=D+Hc0kaT7po/pqhLmBhaJBbv4ggx0ZiD9
	nCggEC4hVBWwum8BSRKHLeRUIczjYRFQmL2PB45zJfucjJHRKgCBX0h4ZS7DFWwU
	kRHQrzAdKdacHibPwqN0lww+oVM5LGIncuIgeNfMTv9gWVHDtSg/aQ5Xd4rucmbs
	uITq42r6XWsSSKvWGkmT7dQhlVphfUxBlB+7rt8ELyaw1gUtByy5D4U3JxTBY8qH
	AHLz4tkbLnOdte4M2foZan9z8xZYfEg4uaSYej8H72Cq0ArsZxqQe1ba+v9ujuPc
	y2MaXjrhWSRT2ff4Bc466szVEzLdeslnLJ8FznGBaPXZYsBb6h/GQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg217x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LK0A53831296;
	Mon, 9 Nov 2026 23:56:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg43wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NtqXm55771484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:55:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D55C35805D;
	Mon,  9 Nov 2026 23:56:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 995A65805B;
	Mon,  9 Nov 2026 23:56:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:38 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 07/15] ibmveth: Add RX queue register helpers for MQ
Date: Mon,  9 Nov 2026 15:55:48 -0800
Message-Id: <20261109235556.60604-8-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af25dbd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cbYZCOWhoq8dY3wGLmMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX7I7akXgxcOn/
 plfW4EVkUQa+rk3Duqu7HoeWFXRuoBQD0DJARhkbfDyoz20HIq4yJSqks3Q/EszXIIuX3v5dOgD
 CEwN+P/bP/QUvYyEyfwVyvNpyYMMGjNjJePLJ10hrY6zN65V0ZxvQJwjfonJ77yrQ8dNNgG0koS
 mSHpTtA8ItU8SuegJv8w8GC8Dr9zOXq+GlrS8+v4KbLtMKNUweDl8KvRfSYqxiDpsCxozSrLO/2
 6O9InOxtYBbrYUtlUtofMvSkwl3Fm5w8mvkZak0BYUQyt9/S3RjSAskTrjxsQrdL30w522giBSg
 tb/Q6PH162n8eTOSlEbyuxSiU1i/LMOLU95mNSzZkkJ5dqoahE+fWyOc20ECAAuexz+LdgW429J
 RWQ0dF6abPn3YBQzT4V6oafx2qM4oC+nEszPyN2c0yeHUYxdBhXY50A9lwbvdoQemVfJjivHod2
 gfkfcG3OEo+1NsZfEHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX8Pv468RWI/zU
 ebsLvGcTcrhJsYIJ/KdJ9wo1PleOH8mcpR2aQDveTxY6IFqkF+b/MhaAHq23RUsWJL4jz/w7Rz1
 pJQcthkaC4hn9YQEGxCgWzQ1eY11tso=
X-Proofpoint-GUID: -AJ42nujpsKE5ZJzxTjZPDdYuuqIMMzh
X-Proofpoint-ORIG-GUID: HAHCREpMB1r--0Om6mydgdkQw_mvN-17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MQ RX changes the RX queue lifecycle from one adapter-level
register/free pair into a mixed model: queue 0 is registered through
h_register_logical_lan*(), queues 1..N through
H_REG_LOGICAL_LAN_QUEUE. The queue-0 control plane that open() and
close() use today has to come out into helpers first, so the
subordinate paths have somewhere to attach when MQ RX is enabled.

Extract logical LAN registration and queue teardown into dedicated
helpers:

  ibmveth_register_logical_lan()
  ibmveth_register_rx_queues()
  ibmveth_free_all_queues()

Runtime stays single-queue here. adapter->multi_queue is still false
until MQ RX is enabled, so queue 0 keeps the legacy
h_register_logical_lan() flow, the with_handle arm is not yet
reachable, and no subordinate queue is registered.

ibmveth_register_logical_lan() registers queue 0 with PHYP. When
multi-queue mode is active it uses h_register_logical_lan_with_handle()
and stores the handle only on H_SUCCESS, so a failed attempt leaves no
stale handle behind.
ibmveth_register_rx_queues() is the open()-side entry point: it builds
queue 0's buffer descriptor, records queue 0's virq in queue_irq[0],
masks that IRQ before registration, and calls
ibmveth_register_logical_lan(). It registers queue 0 only.
ibmveth_free_all_queues() issues one H_FREE_LOGICAL_LAN and clears all
queue handles. One hypercall is enough because H_FREE_LOGICAL_LAN is a
full teardown: per PAPR/PHYP it drops the primary LAN and any
subordinate queues registered under it. Close and the open-fail unwind
both rely on that. Incremental scale-down cannot, and issues
H_FREE_LOGICAL_LAN_QUEUE per queue instead; that path arrives with
resize.

Handle 0 is a live PHYP cookie. queue_registered[] is the slot-is-live
flag; do not treat a zero handle as unregistered. Single-queue
registration returns no handle and leaves queue_registered[0] clear.

open() now allocates buffer pools before PHYP registration
(net-next registered first), so a pool-fail
path never has a LAN this kernel registered. A LAN left registered
across a kexec is a different matter: the pool failure used to come
after registration and free it, so issue one H_FREE_LOGICAL_LAN on
that path, ignoring its result (H_PARAMETER when nothing is
registered). Post-register errors still unwind through
ibmveth_free_all_queues().

open() also calls netif_set_real_num_rx_queues() with num_rx_queues
after registration (one queue until multi-queue is enabled); a failure
there unwinds the same way.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- queue_registered[] marks a live slot; handle 0 can be a valid cookie
- a buffer pool allocation failure in open() still calls
  H_FREE_LOGICAL_LAN once, for a LAN a kexec'd kernel left registered
- ibmveth_register_logical_lan() returns long, the hypercall status
  type

Changes in v7:
- no P07 code change
- commit message: name netif_set_real_num_rx_queues()
  in open()

Changes in v6:
- drop the eight hypercall counters, struct ibmveth_hcall_stats, and
  the adapter field. Only reg_lan and free_lan had writers here;
  none of the eight had a reader. The ethtool -S keys v5 added in
  patch 11 are gone with them. This patch no longer touches ibmveth.h
- trace LAN registration and the free retry with netdev_dbg() (open/
  close/resize, not per packet). Teardown already uses netdev_err()
- document free_all_queues() log-and-continue in its kdoc, including
  that queue_handle[] is cleared whatever the hypercall returned
- noted: queue 0 handle is stored only on H_SUCCESS
- noted: body drops the out_unregister_queues walk and the
  unconditional PHYP-vs-pools guarantee

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

 drivers/net/ethernet/ibm/ibmveth.c | 201 ++++++++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |   4 +
 2 files changed, 159 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cab895cc970c..e2aa10865567 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1335,10 +1335,31 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 		ibmveth_free_tx_ltb(adapter, i);
 }
 
-static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+static void ibmveth_set_rx_queue_handle(struct ibmveth_adapter *adapter,
+					int queue_index, u64 handle)
 {
-	int rc, try_again = 1;
+	/* PHYP handle; 0 can be valid. queue_registered[] is the sentinel. */
+	adapter->queue_handle[queue_index] = handle;
+	adapter->queue_registered[queue_index] = true;
+}
+
+static void ibmveth_clear_rx_queue_handle(struct ibmveth_adapter *adapter,
+					  int queue_index)
+{
+	adapter->queue_registered[queue_index] = false;
+	adapter->queue_handle[queue_index] = 0;
+}
+
+static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
+					 union ibmveth_buf_desc rxq_desc,
+					 u64 mac_address)
+{
+	long rc;
+	int try_again = 1;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long buf_dma = adapter->buffer_list_dma[0];
+	unsigned long filter_dma = adapter->filter_list_dma;
+	unsigned long qh0;
 
 	/*
 	 * After a kexec the adapter will still be open, so our attempt to
@@ -1346,14 +1367,29 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
+			ibmveth_set_rx_queue_handle(adapter, 0, qh0);
+	} else {
+		rc = h_register_logical_lan(ua, buf_dma, rxq_desc.desc,
+					    filter_dma, mac_address);
+	}
+	netdev_dbg(adapter->netdev, "h_register_logical_lan%s rc=%ld\n",
+		   adapter->multi_queue ? "_with_handle" : "", rc);
 
 	if (rc != H_SUCCESS && try_again) {
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
 		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
+		netdev_dbg(adapter->netdev, "h_free_logical_lan rc=%ld\n", rc);
 
 		try_again = 0;
 		goto retry;
@@ -1362,14 +1398,97 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
+ * Used by close() and the post-register open() unwind.
+ *
+ * Retries only H_BUSY and H_IS_LONG_BUSY. On other failures, logs and
+ * returns; callers cannot observe hypercall status. Registered slots
+ * are cleared regardless. Callers still run RX pool and DMA teardown
+ * afterward (same as pre-helper close()).
+ *
+ * Clears registered flags and cookies of queues [0, num_rx_queues);
+ * queue_irq[] is released by ibmveth_cleanup_rx_interrupts().
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
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		ibmveth_clear_rx_queue_handle(adapter, i);
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
@@ -1390,33 +1509,30 @@ static int ibmveth_open(struct net_device *netdev)
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
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc) {
+		unsigned long ua = adapter->vdev->unit_address;
+		unsigned long lpar_rc;
 
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
+		/* A kexec can leave the LAN registered by the old kernel
+		 * (see ibmveth_register_logical_lan()); do not leave its
+		 * buffers live in PHYP. H_PARAMETER if none is registered.
+		 */
+		do {
+			lpar_rc = h_free_logical_lan(ua);
+		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 		goto out_free_queue_mem;
 	}
 
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
 
 	/* Enables NAPI, so everything ibmveth_poll() touches must exist:
 	 * netpoll during the direct close()/open() pairs, or a direct
@@ -1424,7 +1540,7 @@ static int ibmveth_open(struct net_device *netdev)
 	 */
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_free_all_queues; /* setup already disposed IRQs */
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
@@ -1448,10 +1564,12 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -1464,7 +1582,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	long lpar_rc;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1480,15 +1597,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_cleanup_rx_interrupts(adapter);
 
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
 	ibmveth_update_rx_no_buffer(adapter);
 	/* netif_tx_disable() above keeps xmit off the TX LTBs. */
 	ibmveth_free_tx_resources(adapter);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 50be6c95457e..1433f62aaaca 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -321,7 +321,11 @@ struct ibmveth_adapter {
 	struct ibmveth_buff_pool
 		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
 	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
+	/* Opaque PHYP cookie; 0 can be live. queue_registered[] is slot-live,
+	 * tracked only for multi_queue: SQ registration sets no handle.
+	 */
 	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
+	bool queue_registered[IBMVETH_MAX_RX_QUEUES];
 	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
 	int multi_queue;
 	unsigned int num_rx_queues;
-- 
2.50.1 (Apple Git-155)


