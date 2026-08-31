Return-Path: <linuxppc-dev+bounces-26308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6991EC624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:09:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXSZ6Ztkz2yFK;
	Tue, 01 Sep 2026 01:08:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188926;
	cv=none; b=FIk+mpC85ovPWyD9rQW8uQEvDwFn7F67VxHijO1XyafGqv+dq1Jxp6ciezEHrhFNom5lbi25iPTeaENIcWiEvy5AxFkkyDFaf9XUBYV7eA2V9oQX+bojrwF8L1azKSnWxRSrn3y/DYCrO/Zwo7ARMnE3f+wSSDBxpZp4BbIEFKRRzO52YUjssm5luNEgM6jyOqPrVKKLaYHH8gfgeYZEHPEmdDTXhNw7FW8t4Whdn8Hn6JIgBEHFXuB3qksJIL4myW+fq11uyXx8KukWihzNmqmJd2iFnoP5tlHJLyzl/QBZL9vW385rGFChzdW5U56gHZz9bYXSBRT2voMzVx8ylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188926; c=relaxed/relaxed;
	bh=uqOm4tOKPbmm/mcSekaGkc7Pu4WJGbBsMyikMhEw9wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFoXqn/RqvoJOEjUi+gblMubyw9pXu5+82pGIl/465Jj27OzEfJ0sFmSf2I91JFNlFYC2un4974c9d/VJJGeORAB0HfFzMHPAddXVTG0JU6ohVc+YtOiSloXNr3CCR++aUFoMjp0q1sjsGLVhZAyAS53rSXY4mo+OwKIfIEPGoQWwGVS3Q0RM/mbEZwq1sr+8/f2HOVfX5G2BET2+68hU+nfG5VnkjfTf+mv3HrNucPAGobv2Xnqe3tfLHG7xsZNHZo6GdEZZtkyhJ5+B0dMQp8/5KLlKRWy6BKhXZafxznEPadJCfodrQVwK3GmW+nsMWNM5EGIQlBee1grWF7g9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rGVqgrr8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rGVqgrr8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXSY6x2yz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:45 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZFwS2415072;
	Mon, 31 Aug 2026 15:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uqOm4tOKPbmm/mcSe
	kaGkc7Pu4WJGbBsMyikMhEw9wM=; b=rGVqgrr8ZmO/RFiglc4Gq1+iiF4R8CgJd
	tzfKwHKVoTIec7EnwntEgPRr/LuexXUyEYlUWvB/4I+Wqj7cYIwTdPHfcBfj8LKs
	TrAVdZqI3XwYS1bZgLkvkkoKMX0waiXM8UowXcphyL0iOolisXhLumpiHsFKfVnv
	tT75Jk9A6q6YzTNf2TwgIPKguolGO12da0OItpMjMHM4mEwH8DDLogc+p4F5oCNi
	7EtEcG/lkhQyKACZW1JT4SLCCzxeldFKvriJJBR0JH0MwiJDAGeRJ096SW1cAhDL
	804pBRauqjkJ7WzmPLgUpfK7Pj0uVt+98dutvC6IHzt1bd2kRC/WA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj8xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuW2s005753;
	Mon, 31 Aug 2026 15:08:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6g3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8UE626608344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEE1D5805A;
	Mon, 31 Aug 2026 15:08:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDF258051;
	Mon, 31 Aug 2026 15:08:26 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:25 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 07/15] ibmveth: Add RX queue register helpers for MQ
Date: Mon, 31 Aug 2026 08:07:18 -0700
Message-Id: <7684dce6d5255707047bac2ad1ede2e638a99f69.1788102125.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: bGBqVSqImYemRSWYYowK5CoQiSNrUQMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX/zF4cLlclfk4
 6u9Ebh6cETL/AjMAha0I5IxDG484QVyf7pJcdFDQeRfuMj4fjc2A0yZyi6MU5S3Fh9rsChzHMk3
 vyZz4JEGhZY7gMTSDT687HQzy6uYbwTS1GkWCXjN1Ebf79dlKUpkmBKLFpcF4a9NKMSdsIv8sN/
 SfnwG+9Kk0/4VKS61qdAO/yHR6K2ZGBmBuUEpxpecvUbO1Gj1DZYj2Rsk6vkYKg4IFlPs5+Uz6b
 GleZ4YT/Oz4rQYaY1x3K04IfIkKqHJarPGwpusM6uQwd2O/33dgmigQqA6SMOFt3v5GhXE62Iek
 wpLlsYXVeSA6EG/VPRWT+ej+skVX6BsQB38crMv7hPWFWDAD5Sy7YC9M6wg3whXFpnWwq9gYs/+
 wcVPZWCtUAb8819VH4LKrOd3rNbOpcnimo6Ebj6fvzMDy0ij/R/L5IBUKW3qHYZB3i88S8jXHpn
 Z+9BsZgiZKZ9kAoPa2A==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9598f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=qhGsbuW5snZ5JCOQXLEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXyY8HyqhWXlOs
 G025AX2CYNAWgE1BCdirhSzyqdauQzD/dXKNYhnFrWRB2ZH5mwf8PLzsx5vhY3HBIApOFlP6heK
 9wn9DSmBqEdKPtuBFMCSa4aluHccxEE=
X-Proofpoint-ORIG-GUID: 2ek-muUrTHCs-5iVjkO8pTOiXIslfTQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

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

open() allocates buffer pools before PHYP registration so a pool-fail
path never has a live LAN. Post-register errors still unwind through
ibmveth_free_all_queues().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

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

 drivers/net/ethernet/ibm/ibmveth.c | 174 +++++++++++++++++++++--------
 1 file changed, 128 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 7a420e1a41d5..465330464f91 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1289,9 +1289,14 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
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
@@ -1299,14 +1304,29 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
+	netdev_dbg(adapter->netdev, "h_register_logical_lan%s rc=%d\n",
+		   adapter->multi_queue ? "_with_handle" : "", rc);
 
 	if (rc != H_SUCCESS && try_again) {
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
 		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
+		netdev_dbg(adapter->netdev, "h_free_logical_lan rc=%d\n", rc);
 
 		try_again = 0;
 		goto retry;
@@ -1315,14 +1335,97 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
+ * Retries only H_BUSY and H_IS_LONG_BUSY. On other failures, logs and
+ * returns; callers cannot observe hypercall status. queue_handle[] is
+ * cleared regardless. Callers still run RX pool and DMA teardown
+ * afterward (same as pre-helper close()).
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
@@ -1338,37 +1441,23 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -1386,10 +1475,12 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -1402,7 +1493,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	long lpar_rc;
 
 	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
 	 * leave IFF_UP set after a failed reopen.
@@ -1424,15 +1514,7 @@ static int ibmveth_close(struct net_device *netdev)
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
-- 
2.50.1 (Apple Git-155)


