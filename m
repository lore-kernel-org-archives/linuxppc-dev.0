Return-Path: <linuxppc-dev+bounces-23656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDBEC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:37:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF3w5C0Xz3brP;
	Tue, 07 Jul 2026 05:37:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366620;
	cv=none; b=WgPSgh/MxWvifGYfEF5sAh/y5mt6LfFiTzR0iWTMv6zIMJgfpvjix30gajB6MzhdatojoOkhxh7vVumUeLi9KamuJ++vlVoKLUr9svyNsw5F7ZD1d0Sk7k30AOB4nggNe6bLj65ew1rABS+II08HVme1EVDrb5kxCSTgLrHRt8YrevWpuZfPDBxteHiW/SMuiur1aeaGHoIHWp5uw+kT5XvoCxSaVXNtxbY3d7M2w8TEzCp6nSUPeSiM7AVKZ915T4Zl7FB/EC/9dZgvTlL6BJyoq0VgRorsS82mMogSR2RaNJu4RVHisoe4Ndn6Ot9CYjCRAA2lwWnoo2r4g2dpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366620; c=relaxed/relaxed;
	bh=fjV0oi/8FV+ECvz5oOfDiNcHJDkxxhtdN/xF0rwRzw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdgiRuSi0/ufq98yJwvOiVaj6wSpYE/m0+kL8YQmqOaoRHlhytCUNyfwMTYxL1SoUl2Cu3g5fVMx6jLJAR9ZxbTxIXBzHDM8bQJmCZoEDiacvkl1PSh7FrGCJCJh9qWdUeHTkvOFF3ag7tjk6L5grc1fAVZdaBr5y5hNVDbPEiIayw0ijuBdGZNl59LV7+BxPAC67B3HCnc7cRRxmy8saCOR0wLFq+u7LzmXMuMIEC6nHz8fQglhN9sbvcwNbiej261HpC84DTB/+xS+BPvUD0rOWffjsl7JJh1nGxCDWk2RbN/+flOhfIWgoR73YlC7U7gJ8vN6c55QovweNyqSPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xlks/rQZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xlks/rQZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF3v3YKBz3br5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:36:59 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIYGY4050180;
	Mon, 6 Jul 2026 19:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fjV0oi
	/8FV+ECvz5oOfDiNcHJDkxxhtdN/xF0rwRzw0=; b=Xlks/rQZcnqUsOhZgy2kR+
	XjSRx8O60i16KyAPQu25p8SoaJWV+ZKIuqYIUQABc82OY1n1TYLJSpKhynf9Gskg
	+ROKxH4P3dDqH/mgtjEgEHyDmmCcWwrQUDtQyX10jK8+Ioz92e4E2E3PJis9K/4B
	EACW91jlrfDukSmt62vT093DOE4jwvzwK9qKBZVpgUBIeJlXri/qi0ycUIzrCZQd
	YuWxNoV5t83eaMLq0zTGVcWrTQE23Yzw61gFa2McsImPTnw5wBOwLVTn5hgTgRde
	oRZMOmKaLaYPTcPixWP6P+Y5Y70WuunM4OU+N4GvkPOzmdJ38wA4GkgOFzzcqScw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stskjyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZqM004294;
	Mon, 6 Jul 2026 19:36:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxr6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JalJH17629806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EDFB5805E;
	Mon,  6 Jul 2026 19:36:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30F9C58051;
	Mon,  6 Jul 2026 19:36:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:46 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 08/15] ibmveth: Refactor open/close into MQ-ready resource pipeline
Date: Mon,  6 Jul 2026 12:35:56 -0700
Message-Id: <20260706193603.8039-9-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: J5HDKZQWhQ9u7fDdt_ITAyjxgAIE0VWC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXz7IzVeCeRq3r
 ADMFJ68nInxaT2jz26GnOX64icVgGNTtIcE9FjXWKhBNufsLqa4LuyP30fYrEmQV8yIpl+ZN0Fl
 DOzZKdrvrbvkrx/Yc1xFJfuJQIXUpFw=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c03d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Dz3vdogtKBtOSoQPiIUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H1KAiuew1PUbUSSU8qhj:22
X-Proofpoint-GUID: UeCT0ZgCV4l-zD3y_SZkNH3Tx0TEFaBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX3u2YuTqqdWyx
 X1GmicFayz+05kvOq6R+d6XHMrDWq2NGw9iqxvr+5f/YMvMLSdKENQrSRZTDnyg9n1VQyXxu8MM
 qaMkWi6hkoKMKtc2MUdbcXY83YGU9FOW6hF0n0xjHv8WxHbbpcMyY53ZEQd0/myBmRiuLmHEIp0
 WAh3Z0fSWfHIIjhPbQyOPSUmaspqWvWbPuMDhgm1oM9/3gGGjudKzNLsaI2TYKzULWh0NyfnxEX
 OCbEK4SJQMX1WSX9dsLGAIJJy6y6zy3VdjTMIDTtHyuGZB39GwV3Fjue2gP0R/pDTYqDGe8UJA3
 5i2TxTNsuwZxCykkrqmETclhiuVOpybNqPSMdujTd1XZJO4h1WmxNzmcSSdZbi6XyCGsYQKeNF9
 GdcRojjLSKpKVCpDOSbS2l/x8PKWJi45snxoyOoCr1+yr74sASn5J4rT+byW2iCh86IKVUQGdIl
 uQ+pZs1/wnUqV9yZD7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060195

Patches 4-8 added alloc/free helpers for RX rings, buffer pools, IRQs,
TX LTBs, and PHYP registration, but open() and close() still duplicated
most of that logic inline. This patch wires the helpers in and makes
open/close the readable bring-up/teardown sequence MQ will extend.

ibmveth_open() runs:

  1. ibmveth_alloc_rx_qstats()
  2. ibmveth_alloc_filter_list()
  3. ibmveth_alloc_rx_queues()        - buffer lists + RX rings [0, N)
  4. ibmveth_alloc_buffer_pools()    - guest RX memory before PHYP
  5. ibmveth_register_rx_queues()    - PHYP registration (no IRQ enable)
  6. netif_set_real_num_rx_queues()
  7. ibmveth_setup_rx_interrupts()   - request_irq, PHYP enable on MQ
  8. initial replenish                 - queue 0 only today
  9. ibmveth_alloc_tx_resources()

Each step has a matching out_* label on failure so unwind walks back
through free_all_queues(), cleanup_rx_resources(), and the other helpers
instead of open() carrying its own DMA unmap/free_page/goto maze (~200
lines removed).

ibmveth_close() mirrors that in reverse: stop TX, disable hypervisor IRQs
per queue, free TX LTBs, tear down NAPI/IRQ handlers, drop buffer pools,
H_FREE_LOGICAL_LAN via ibmveth_free_all_queues(), then free
RX/filter/qstats memory.

request_irq() now passes &napi[i] as dev_id on every queue so the
interrupt and poll paths can derive the queue index from the napi pointer
(napi - adapter->napi).

Drop __maybe_unused from the helpers added in patches 4-8 — they are
called from open/close from this patch onward.

Runtime still single-queue until the MQ enable commit later in the series;
replenish still kicks off via ibmveth_interrupt() on queue 0 as before.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 351 +++++++++++------------------
 1 file changed, 137 insertions(+), 214 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 7fc11a4e1f61..fa2d4777ffc7 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -155,7 +155,7 @@ static unsigned int ibmveth_real_max_tx_queues(void)
  *
  * Return: 0 on success, negative error code on failure
  */
-static int __maybe_unused ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
+static int ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 	struct net_device *netdev = adapter->netdev;
@@ -187,7 +187,7 @@ static int __maybe_unused ibmveth_alloc_filter_list(struct ibmveth_adapter *adap
  * ibmveth_free_filter_list - Free filter list resources
  * @adapter: ibmveth adapter structure
  */
-static void __maybe_unused ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
+static void ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 
@@ -203,6 +203,33 @@ static void __maybe_unused ibmveth_free_filter_list(struct ibmveth_adapter *adap
 	}
 }
 
+/**
+ * ibmveth_alloc_rx_qstats - Allocate per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->rx_qstats = kcalloc(IBMVETH_MAX_RX_QUEUES,
+				     sizeof(struct ibmveth_rx_queue_stats),
+				     GFP_KERNEL);
+	if (!adapter->rx_qstats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_rx_qstats - Free per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ */
+static void ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	kfree(adapter->rx_qstats);
+	adapter->rx_qstats = NULL;
+}
+
 /**
  * ibmveth_alloc_rx_queues - Allocate per-queue RX resources
  * @adapter: ibmveth adapter structure
@@ -210,7 +237,7 @@ static void __maybe_unused ibmveth_free_filter_list(struct ibmveth_adapter *adap
  *
  * Return: 0 on success, negative error code on failure
  */
-static int __maybe_unused
+static int
 ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
 {
 	struct device *dev = &adapter->vdev->dev;
@@ -288,7 +315,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
  * ibmveth_cleanup_rx_resources - Free all RX queue resources
  * @adapter: ibmveth adapter structure
  */
-static void __maybe_unused ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
+static void ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
 	int i;
@@ -424,21 +451,22 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
 }
 
 /**
- * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
+ * ibmveth_setup_rx_interrupts - Register IRQ handlers and enable NAPI
  * @adapter: ibmveth adapter structure
  *
  * Registers interrupt handlers for all RX queues and enables NAPI polling.
- * On error, cleans up any successfully registered IRQs before returning.
+ * For multi-queue mode, enables hypervisor interrupt delivery only after
+ * every queue has a Linux handler installed.
  *
  * Return: 0 on success, negative error code on failure
  */
-static int __maybe_unused
+static int
 ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int i, rc;
+	int i, rc, num = adapter->num_rx_queues;
 
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < num; i++) {
 		if (!adapter->queue_irq[i]) {
 			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
 			rc = -EINVAL;
@@ -455,14 +483,34 @@ ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 		}
 	}
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < num; i++)
 		napi_enable(&adapter->napi[i]);
 
+	if (adapter->multi_queue && num > 1) {
+		for (i = 0; i < num; i++) {
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d, rc=%d\n",
+					   i, rc);
+				while (--i >= 0)
+					ibmveth_disable_irq(adapter, i);
+				rc = -EIO;
+				goto err_disable_napi;
+			}
+		}
+	}
+
 	return 0;
 
+err_disable_napi:
+	for (i = 0; i < num; i++)
+		napi_disable(&adapter->napi[i]);
+	i = num;
 err_free_irqs:
 	while (--i >= 0)
 		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
 	return rc;
 }
 
@@ -485,15 +533,7 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
 	}
 
-	/* Dispose IRQ mappings for subordinate queues (1-15).
-	 * Queue 0 uses netdev->irq from device tree, not irq_create_mapping().
-	 */
-	for (i = 1; i < adapter->num_rx_queues; i++) {
-		if (adapter->queue_irq[i]) {
-			irq_dispose_mapping(adapter->queue_irq[i]);
-			adapter->queue_irq[i] = 0;
-		}
-	}
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
 
 	/* Clear queue 0 IRQ number */
 	adapter->queue_irq[0] = 0;
@@ -869,7 +909,7 @@ static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
  *
  * Return: 0 on success, negative error code on failure
  */
-static int __maybe_unused ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+static int ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	int i, q, rc;
@@ -910,7 +950,7 @@ static int __maybe_unused ibmveth_alloc_buffer_pools(struct ibmveth_adapter *ada
  *
  * Frees buffer pools for all queues using the helper function.
  */
-static void __maybe_unused ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
+static void ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 {
 	int q;
 
@@ -1070,7 +1110,7 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
  *
  * Return: 0 on success, -ENOMEM on failure
  */
-static int __maybe_unused
+static int
 ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1095,7 +1135,7 @@ ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
  *
  * Frees TX Long Term Buffers (LTBs) for all TX queues.
  */
-static void __maybe_unused
+static void
 ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1149,33 +1189,6 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
-/**
- * ibmveth_alloc_rx_qstats - Allocate per-queue RX statistics
- * @adapter: ibmveth adapter structure
- *
- * Return: 0 on success, -ENOMEM on failure
- */
-static int __maybe_unused ibmveth_alloc_rx_qstats(struct ibmveth_adapter *adapter)
-{
-	adapter->rx_qstats = kcalloc(IBMVETH_MAX_RX_QUEUES,
-				     sizeof(struct ibmveth_rx_queue_stats),
-				     GFP_KERNEL);
-	if (!adapter->rx_qstats)
-		return -ENOMEM;
-
-	return 0;
-}
-
-/**
- * ibmveth_free_rx_qstats - Free per-queue RX statistics
- * @adapter: ibmveth adapter structure
- */
-static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
-{
-	kfree(adapter->rx_qstats);
-	adapter->rx_qstats = NULL;
-}
-
 /**
  * ibmveth_register_logical_lan_queue - Register subordinate queue with hypervisor
  * @adapter: ibmveth adapter structure
@@ -1466,208 +1479,108 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
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
-	struct device *dev;
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi[0]);
-
-	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
-	rc = -ENOMEM;
-	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!adapter->buffer_list_addr[0]) {
-		netdev_err(netdev, "unable to allocate list pages\n");
+	rc = ibmveth_alloc_rx_qstats(adapter);
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
+	rc = ibmveth_alloc_filter_list(adapter);
+	if (rc)
+		goto out_free_rx_qstats;
 
-	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
-						rxq_entries;
-	adapter->rx_queue[0].queue_addr =
-		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
-				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
-	if (!adapter->rx_queue[0].queue_addr)
+	rc = ibmveth_alloc_rx_queues(adapter, rxq_entries);
+	if (rc)
 		goto out_free_filter_list;
 
-	adapter->buffer_list_dma[0] = dma_map_single(dev,
-						     adapter->buffer_list_addr[0],
-						     4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
-		netdev_err(netdev, "unable to map buffer list pages\n");
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc)
 		goto out_free_queue_mem;
-	}
 
-	adapter->filter_list_dma = dma_map_single(dev,
-			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
-		netdev_err(netdev, "unable to map filter list pages\n");
-		goto out_unmap_buffer_list;
-	}
+	rc = ibmveth_register_rx_queues(adapter, mac_address);
+	if (rc)
+		goto out_free_buffer_pools;
 
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		if (ibmveth_allocate_tx_ltb(adapter, i))
-			goto out_free_tx_ltb;
+	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
+	if (rc) {
+		netdev_err(netdev, "failed to set number of rx queues\n");
+		goto out_unregister_queues;
 	}
 
-	adapter->rx_queue[0].index = 0;
-	adapter->rx_queue[0].num_slots = rxq_entries;
-	adapter->rx_queue[0].toggle = 1;
-
-	mac_address = ether_addr_to_u64(netdev->dev_addr);
-
-	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
-					adapter->rx_queue[0].queue_len;
-	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
-
-	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr[0]);
-	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
-	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue[0].queue_addr);
-
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
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
-		goto out_unmap_filter_list;
-	}
+	rc = ibmveth_setup_rx_interrupts(adapter);
+	if (rc)
+		goto out_unregister_queues;
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		if (!adapter->rx_buff_pool[0][i].active)
-			continue;
-		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
-			netdev_err(netdev, "unable to alloc pool\n");
-			adapter->rx_buff_pool[0][i].active = 0;
-			rc = -ENOMEM;
-			goto out_free_buffer_pools;
+	if (adapter->num_rx_queues > 1) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
+			ibmveth_replenish_task(adapter, i);
 		}
+	} else {
+		netdev_dbg(netdev, "initial replenish cycle\n");
+		ibmveth_interrupt(adapter->queue_irq[0], &adapter->napi[0]);
 	}
 
-	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
-	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
-			 netdev);
-	if (rc != 0) {
-		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
-			   netdev->irq, rc);
-		do {
-			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
-		goto out_free_buffer_pools;
-	}
-
-	rc = -ENOMEM;
-
-	netdev_dbg(netdev, "initial replenish cycle\n");
-	ibmveth_interrupt(netdev->irq, netdev);
+	rc = ibmveth_alloc_tx_resources(adapter);
+	if (rc)
+		goto out_cleanup_rx_interrupts;
 
 	netif_tx_start_all_queues(netdev);
 
 	netdev_dbg(netdev, "open complete\n");
-
 	return 0;
 
+out_cleanup_rx_interrupts:
+	ibmveth_cleanup_rx_interrupts(adapter);
+out_free_tx_resources:
+	ibmveth_free_tx_resources(adapter);
 out_free_buffer_pools:
-	while (--i >= 0) {
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-	}
-out_unmap_filter_list:
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-
-out_free_tx_ltb:
-	while (--i >= 0) {
-		ibmveth_free_tx_ltb(adapter, i);
-	}
-
-out_unmap_buffer_list:
-	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
-			 DMA_BIDIRECTIONAL);
+	ibmveth_free_buffer_pools(adapter);
+out_unregister_queues:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+	ibmveth_free_all_queues(adapter);
 out_free_queue_mem:
-	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
-			  adapter->rx_queue[0].queue_addr,
-			  adapter->rx_queue[0].queue_dma);
+	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
-	free_page((unsigned long)adapter->filter_list_addr);
-out_free_buffer_list:
-	free_page((unsigned long)adapter->buffer_list_addr[0]);
+	ibmveth_free_filter_list(adapter);
+out_free_rx_qstats:
+	ibmveth_free_rx_qstats(adapter);
 out:
-	napi_disable(&adapter->napi[0]);
 	return rc;
 }
 
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	struct device *dev = &adapter->vdev->dev;
-	long lpar_rc;
 	int i;
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi[0]);
-
 	netif_tx_stop_all_queues(netdev);
 
-	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
-
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
-	if (lpar_rc != H_SUCCESS) {
-		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
-			   "continuing with close\n", lpar_rc);
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->queue_irq[i]) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
 	}
 
-	free_irq(netdev->irq, netdev);
-
+	ibmveth_free_tx_resources(adapter);
+	ibmveth_cleanup_rx_interrupts(adapter);
 	ibmveth_update_rx_no_buffer(adapter);
-
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
-
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
-		ibmveth_free_tx_ltb(adapter, i);
+	ibmveth_free_all_queues(adapter);
+	ibmveth_free_buffer_pools(adapter);
+	ibmveth_cleanup_rx_resources(adapter);
+	ibmveth_free_filter_list(adapter);
+	ibmveth_free_rx_qstats(adapter);
 
 	netdev_dbg(netdev, "close complete\n");
 
@@ -2423,15 +2336,21 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 {
-	struct net_device *netdev = dev_instance;
+	struct napi_struct *napi = dev_instance;
+	struct net_device *netdev = napi->dev;
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned long lpar_rc;
+	int qindex;
 
-	if (napi_schedule_prep(&adapter->napi[0])) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
+	qindex = napi - adapter->napi;
+
+	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+		return IRQ_NONE;
+
+	if (napi_schedule_prep(napi)) {
+		lpar_rc = ibmveth_disable_irq(adapter, qindex);
 		WARN_ON(lpar_rc != H_SUCCESS);
-		__napi_schedule(&adapter->napi[0]);
+		__napi_schedule(napi);
 	}
 	return IRQ_HANDLED;
 }
@@ -2537,8 +2456,10 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void ibmveth_poll_controller(struct net_device *dev)
 {
-	ibmveth_replenish_task(netdev_priv(dev));
-	ibmveth_interrupt(dev->irq, dev);
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
+	ibmveth_replenish_task(adapter);
+	ibmveth_interrupt(dev->irq, &adapter->napi[0]);
 }
 #endif
 
@@ -2951,7 +2872,7 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	rtnl_unlock();
 
 	/* kick the interrupt handler to allocate/deallocate pools */
-	ibmveth_interrupt(netdev->irq, netdev);
+	ibmveth_interrupt(netdev->irq, &adapter->napi[0]);
 	return count;
 
 unlock_err:
@@ -2991,7 +2912,9 @@ static struct kobj_type ktype_veth_pool = {
 static int ibmveth_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
-	ibmveth_interrupt(netdev->irq, netdev);
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
+	ibmveth_interrupt(netdev->irq, &adapter->napi[0]);
 	return 0;
 }
 
-- 
2.39.3 (Apple Git-146)


