Return-Path: <linuxppc-dev+bounces-23329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0CAC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:26:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF2x5vzKz2yS4;
	Thu, 02 Jul 2026 08:25:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944745;
	cv=none; b=n/6coWtCxczJfA+xHhFfHmEfTi/y7BQ2rJpJrl9sfNi3ybhOqQgcCCb7o8dxgCwnhThcV94ZTJ3BGV/I+0p/duRVIkN9y4RDJ6mCKhLPwA92TOWlrxbRi4cH+4kNKgffqw8zEGctPBl5DpvClOV5pI28vP4VO7mcfcvWYM66GgbUqKvUqteCiLxEU8XVfCnJ/6yJCaUoZEeoywdg+4YTEn4nJKoL9uv8JIgkxW+RVg9Uzbt44pY3llHy2TZcD2L0D98I9nkzs/Tc7iN92bz8A1xRJw81RSlhHO6aehg/tjsDcPAKCqZNXqg2k0kuwrzaYIN102+A3N0QGcUsCctAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944745; c=relaxed/relaxed;
	bh=fjV0oi/8FV+ECvz5oOfDiNcHJDkxxhtdN/xF0rwRzw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN9XNZVDPFcirpfvO2sg6LCz7S5oTGRCtk3vI7S2jgTLy3qJrg/usuL1+37ahVBxjBqtZLf8ELXy6FnFRXFP3H3HNJ3cUiyxcGd9CB156yehd84wruIawZmYoLeGlYSai9gHuMGeIoFHQQTdmQd60gdaOvn3WIJSBg0UAN6H4cQg1DPeM61JwO0VZJ/GBGSbLWAyoe1w2h7yM4uVhDYxXDN190P1zUTFSLj/9HdFaLo+AnA6Bt6bYQd7VdDa5jQPpe88OP8vHdZomBI5xSW/1HWu9L3hVfTGrnusgAWLmo6RRc+EkfNW4dpWHfCjU34xMLFCE8P1NWhbO4RudLWNog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qqFu0gq2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qqFu0gq2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF2w500Bz2yrt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:44 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmbYg2226449;
	Wed, 1 Jul 2026 22:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fjV0oi
	/8FV+ECvz5oOfDiNcHJDkxxhtdN/xF0rwRzw0=; b=qqFu0gq2NU/nIb+pSMwkrD
	Pmfgm6gjkDCcIqj0doRCE9ZOjRQm52ChhCJrvlsLk2yxSD7DmNxgi06B2iEgX9Aq
	7sz0fNOt45occiCW3etla6G4E33E4CMUOMcJ7NqHRj6ONNKVAErhWIWh02gPns1J
	EH/lWzUtS8wFlxs3PWnNcQH0g6kn1Vz/Y3mxefbx4BUnJhOeEewny/4i1t/d+cul
	OxYKPPPIYF6IHpOaVPfQ97i3PB/CkDaqGzRjyfqqdUfk8RNvf7EAr8BJzyKFR2iq
	teOlsSX9FdcErGTkpbbgxx3alwCPHw/DbOBPtQNVSMUKPijJzAMEmW5NW7qQUxBA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg6x3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJbpM028852;
	Wed, 1 Jul 2026 22:25:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9fjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPWXA15073890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D37058055;
	Wed,  1 Jul 2026 22:25:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E5B5804B;
	Wed,  1 Jul 2026 22:25:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:30 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 06/15] ibmveth: Refactor open/close into MQ-ready resource pipeline
Date: Wed,  1 Jul 2026 15:23:18 -0700
Message-Id: <20260701222327.61325-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4593de cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Dz3vdogtKBtOSoQPiIUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H1KAiuew1PUbUSSU8qhj:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfXz9hZJjTcYuS9
 nPjXJTQagRjR8t1DACN0FDWUZuSqz6bYMFAlze+VNOZZ/X2TJ5Pg+ThFq8Fhs2Vo5aPHTOnHYdr
 ce61BTr+0L+HPSrh9GHV2Clb3eyQrsQ=
X-Proofpoint-GUID: ctuBt3xg4EV6hBSpNBEL5bRxzAp2NeTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX6wAY5X4/r55Q
 8fj3mfbk3uCTFSW8WXbs7/d6Ws6/tuhhuEcU6bjU1Ik5SPe6KcOdwVYNRI6LHL5tFfbtwercXb1
 SesnQN3Pyj+rfm8f7Hlgn7suSfohXBRfK827sm21Qtc9hP+WgWi+Ldy+LOkpbq5OmkzDHRp4vP2
 DHWDRsk+2OLY0e4jqa/TAjiSUhH05MRhMLt0r+M8Lq0qkukUam4aC2SRiVnRK/3isrvVFNUg2vi
 2IhJSSLWQyi4/bOdWp+WCHEf9+O2FCH/VoysVbrRU2vlHHhkMgOHLT3aTaAmVykBaHKh7w2kNob
 UKA9v0WZ53/dJSJkaRy81oR/oMJE2wP5ntSZ98/xw0l8o0lUvMzu7tn9nQl63U+lHDEDumVMQiA
 WQWN5AYqmP6HruNnbLFsg+B6rjD4DFC6/pVph81om+zBnA/g9fPX+IiCN6Nh+GW10JlntrUdUri
 KeZfU9t3lQRtBqQFmgA==
X-Proofpoint-ORIG-GUID: JfoQ_qcm5bheRlUfTttD9jkzNVvuX_uN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

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


