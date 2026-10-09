Return-Path: <linuxppc-dev+bounces-29155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F197CA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1b933wWFz3bh4;
	Sat, 10 Oct 2026 05:33:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791570823;
	cv=none; b=PA0iAHYo1A2x+iu3m72eDeXE5qaEp0MMOgIAxE331IRnOgNQO52mD4yo0BbQqPW2sBFG2R0h6DkDRsHDCcsNXvHA8pKYX/qblA7KBqQVddQffVEd5iM2oMzUf/ZewgrzyEwvyzrViVYF0L/kI2+qYIr4sfTY5DMJWBRJ/euivgRhd7CIshqskCQqqobLw99dI0CKv1Y7BeA8xzT+zjDxT1NSq/CcQ3NmWnFGp4QYUQi8/DRiVpbj54EonBqqToKMyUGm0nqHZlP9EOsj5tbk3z7NxeZzn8r0wyCyxjeSswcHxn/QG2UdmS95i20lNKNfCkoyrk8UbIbArJQjRYF6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791570823; c=relaxed/relaxed;
	bh=9//5D7uOJZSl6PoSvV8TWjsvZMBLJz4hhhBDYZJdSS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3MrxmLiy1SdZUn8ln3VOpRNU+l7OK3kWDt8zj3rmaHydFtLDqnmJ4A3vrxlTHibvaMoDQ6+u8HNIPPbIjFBXgTpoCoQasxQWImLBXFvb2R0C0nvYPRXGNa1nAhDj0fNoGNsmpGxrrAWr0Xjt9RQYIuqW+V+fBdvuvAL4ctC8q4dJrK+0spzFYJBmbvNPMtdsYTmFgCD1ji6pa8jzlXXlgwXSno5IVgL0TfepPuoLs/Sk0dQbV43VnymZ1WeSJvfnHlRC0F46gzwRYiCJVC7YqB+pZ4N4BWsHzIDTX5sVZC3e3T+5ihDqxJL07KtdaTMRL+S5L09uPD6OgyOMyl6TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qPFTnCJc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qPFTnCJc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1b922mF2z3c0n
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:33:42 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Ha6Ie592907;
	Fri, 9 Oct 2026 18:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9//5D7uOJZSl6PoSv
	V8TWjsvZMBLJz4hhhBDYZJdSS0=; b=qPFTnCJcJ2PL8SiSBohQGky8iQTaIbk0E
	PuM9wDdo7TJzjv3WIz5GfxyTmV+0v8c4rzGDDCzMxWFxUFT/naTtAI/nEW1qfMrF
	bVk/56hX3KtV1M35pVRfCatPGlnP0rH2VcRsknHJ/P9TXT/quSUvVtmtzUV/rvrO
	/+lcUfGcpprUNEySk2j9bMZatnaOL7rW5GHEIz3h9lIUmMSXq/MMQ3O2UG2Y7iHv
	kiqyGm9qEzpyUPWWZH68Bd5Xp118UttPiXDRwJ+Ib8NOsSb6O8nr2lB0JB2L0f/p
	ovxgUk/NN2tWSiVG+X5cjI54QL24nckQdXIQGXPZB5iDADe2Xchvg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg933-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8PBU4125998;
	Fri, 9 Oct 2026 18:33:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u46g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXNeu39191116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47AC75805A;
	Fri,  9 Oct 2026 18:33:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFCB158051;
	Fri,  9 Oct 2026 18:33:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:20 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        jeff@garzik.org
Subject: [PATCH net-next v3 4/8] ibmveth: step past bad RX correlators instead of spinning or oopsing
Date: Fri,  9 Oct 2026 11:32:54 -0700
Message-Id: <20261009183258.18624-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXxUS7+bOrW9Il
 t0YBAbrT1fDPceTP6dZJfhyZ8GyqIjgXlyeMZHn81uuaiIvWbcshIym0SRkIPbOcMn+9Dz9qMiI
 fmsM+eUXpRue+WOs+YR7X1bLQtsSRGCjYyBAu8FBEU3eWBD/8u3wO6U1/BAk+I4v7aWbskE4ExI
 wbB55kgJ/vJ/PQ4iyO79asflzM1ucLmMmGyfAa6w50HzXWRXPuILUUCRG1qbFI91f3BT2b7EaF+
 /AuKxcz7sQxE29GhBXT403GOPjYig1TLAe9Tz9g7SeQ+Gswm/g4Sros66GejyNqKvLYTQfCcXn8
 LGNIQeCSInNdTVojAZ60P2hBi3cdg7Vr54rdj5345Otjh4eGB0x/YMBngz8HtwoMC8WoZDo6pXx
 rpdzOCwdFRm+lQeI2UyFxaPwX3PfJHtlOioKnFuMJjyu6SNJxqNldbYORFoLjmnQyYhd9NarHFE
 +xMxwOFzy0ysQxcrexg==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac93377 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=g0CC2Wx1xQ6HTDzo1HUA:9
X-Proofpoint-GUID: ev-BZ7TxjXEMyqAYi7yg9yaBaSARUDpB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX7FrupvRnT80k
 oXipk7d7uFYymDZj/4AmIbr7oLdBIjWUbfjLz6j/PyRRkatNWj05STMwuYUpr2UgxjloqM6XafP
 K5OZbIq8+xRlQLp0EV5fC/fkaamsIeg=
X-Proofpoint-ORIG-GUID: 78SaAMKnwkBMDrGMgYqX7LgG398XbVRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072

ibmveth_poll() mishandles a bad RX correlator from PHYP in two ways.

If harvest fails or ibmveth_rxq_get_buffer() returns NULL, poll
breaks out without advancing the ring and restarts on the same slot
forever. For an out-of-range correlator it also fires a WARN_ON() and
schedules a reset each pass, but the reset is queued on that CPU and
never runs, and the CPU stalls RCU, so RTNL holders hang too. This
dates from the first commit in Fixes:, which turned the BUG_ON()s
here into WARN_ON() plus a reset.

The range check also accepts a correlator naming an inactive buffer
pool (pools 2 and 3 by default), whose skbuff array is NULL, so the
lookup dereferences NULL in softirq. Pools became inactive with the
second commit in Fixes:.

Validate the correlator in one helper that also rejects a pool with
no skbuff array. On a bad slot, advance the ring, count the drop in
rx_dropped and still schedule the reset, which rebuilds the pools.
The slot has moved, so stay in the budget loop and count it in
frames_processed. Breaking out would complete NAPI, re-arm, and
napi_schedule() with budget left. Once napi_schedule() has queued
this NAPI and the budget is used up, return budget - 1.
busy_poll_stop() would queue it again if poll returned budget.

Drop a frame whose offset + length does not fit the pool buffer, or
that is shorter than an Ethernet header. Copybreak would read past
the RX buffer, skb_put() would BUG(), and the checksum helpers would
write past a short frame. Take the pool for that bound from the
correlator that was validated, read once, not from a second read of
the ring. The base driver never checked this, and it has not been
seen in the field, so it has no Fixes: tag of its own. The tags below
are for the correlator hang.

The correlator comes from PHYP, and with the ring advancing a burst
of bad slots would WARN once per slot (and panic with
panic_on_warn), so use a ratelimited netdev_err() instead. Also free
the rx_copybreak skb if harvest fails there.

Add a KUnit case for harvest advancing on errors and extend the
existing cases to an inactive pool; on the unfixed driver the first
fails and the others oops.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection and the KUnit cases above. Hitting either
bug needs PHYP to return a bad correlator, so neither was reproduced on
hardware. Tested with KUnit on qemu pseries (ppc64le), and on a POWER10
LPAR with a ping flood and MTU changes under traffic. No kernel
selftests cover ibmveth.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v3:
- after a bad slot, keep polling and count the slot against the NAPI
  budget instead of breaking out with budget left; once poll has
  rescheduled itself, return budget - 1 so busy_poll_stop() cannot
  queue the NAPI a second time (Sashiko review of v2)
- drop a frame whose offset + length does not fit its pool buffer
  (Sashiko review of v2, pre-existing) or that is shorter than an
  Ethernet header
- read the correlator once and pass it to ibmveth_rxq_get_buffer(),
  so the buffer bound uses the validated pool

Changes in v2:
- count rx_dropped when recycling an invalid buffer fails

 drivers/net/ethernet/ibm/ibmveth.c | 245 ++++++++++++++++++++++++-----
 1 file changed, 205 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cee0e9783b2a..55c0b5d6e0a9 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -135,6 +135,13 @@ static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
 	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
 }
 
+static u64 ibmveth_rxq_correlator(struct ibmveth_adapter *adapter)
+{
+	unsigned int idx = adapter->rx_queue.index;
+
+	return READ_ONCE(adapter->rx_queue.queue_addr[idx].correlator);
+}
+
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
 {
 	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_CSUM_GOOD;
@@ -443,6 +450,37 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/* The correlator comes back from PHYP; a bad one schedules a reset. */
+static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
+					 u64 correlator)
+{
+	unsigned int index = correlator & 0xffffffffUL;
+	unsigned int pool = correlator >> 32;
+
+	/* An inactive pool keeps its size but has no skbuff array. */
+	if (pool < IBMVETH_NUM_BUFF_POOLS &&
+	    index < adapter->rx_buff_pool[pool].size &&
+	    adapter->rx_buff_pool[pool].skbuff)
+		return true;
+
+	if (net_ratelimit())
+		netdev_err(adapter->netdev,
+			   "invalid RX correlator %llx, resetting\n",
+			   correlator);
+	schedule_work(&adapter->work);
+	return false;
+}
+
+static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
+			       u64 correlator)
+{
+	if (net_ratelimit())
+		netdev_err(adapter->netdev,
+			   "no buffer for RX correlator %llx, resetting\n",
+			   correlator);
+	schedule_work(&adapter->work);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -451,7 +489,8 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
  *
  * Return:
  * * %0       - success
- * * %-EINVAL - correlator maps to pool or index out of range
+ * * %-EINVAL - correlator maps to pool or index out of range, or to an
+ *              inactive pool
  * * %-EFAULT - pool and index map to null skb
  */
 static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
@@ -462,15 +501,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	unsigned int free_index;
 	struct sk_buff *skb;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
 		return -EINVAL;
-	}
 
 	skb = adapter->rx_buff_pool[pool].skbuff[index];
-	if (WARN_ON(!skb)) {
-		schedule_work(&adapter->work);
+	if (!skb) {
+		ibmveth_rxq_no_skb(adapter, correlator);
 		return -EFAULT;
 	}
 
@@ -504,20 +540,29 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
-/* get the current buffer on the rx queue */
-static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
+/* get the buffer for @correlator, read once from the current rx queue entry */
+static struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
+					      u64 correlator)
 {
-	u64 correlator = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
+	struct sk_buff *skb;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
 		return NULL;
-	}
 
-	return adapter->rx_buff_pool[pool].skbuff[index];
+	skb = adapter->rx_buff_pool[pool].skbuff[index];
+	if (!skb)
+		ibmveth_rxq_no_skb(adapter, correlator);
+	return skb;
+}
+
+static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
+{
+	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
+		adapter->rx_queue.index = 0;
+		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
+	}
 }
 
 /**
@@ -528,6 +573,9 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
  *
  * Context: called from ibmveth_poll
  *
+ * The ring advances even on error, so poll does not return to a bad
+ * slot before the scheduled reset can run.
+ *
  * Return:
  * * %0    - success
  * * other - non-zero return from ibmveth_remove_buffer_from_pool
@@ -540,15 +588,9 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
-	if (unlikely(rc))
-		return rc;
+	ibmveth_rxq_advance(adapter);
 
-	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
-		adapter->rx_queue.index = 0;
-		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
-	}
-
-	return 0;
+	return rc;
 }
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
@@ -1469,7 +1511,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
 	unsigned long lpar_rc;
+	int rescheduled = 0;
 	u16 mss = 0;
+	int rc;
 
 restart_poll:
 	while (frames_processed < budget) {
@@ -1481,19 +1525,46 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
-				break;
+			rc = ibmveth_rxq_harvest_buffer(adapter, true);
+			if (unlikely(rc)) {
+				netdev->stats.rx_dropped++;
+				frames_processed++;
+				continue;
+			}
 		} else {
 			struct sk_buff *skb, *new_skb;
 			int length = ibmveth_rxq_frame_length(adapter);
 			int offset = ibmveth_rxq_frame_offset(adapter);
 			int csum_good = ibmveth_rxq_csum_good(adapter);
 			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
+			u64 correlator = ibmveth_rxq_correlator(adapter);
+			unsigned int pool, room, off, len;
 			__sum16 iph_check = 0;
 
-			skb = ibmveth_rxq_get_buffer(adapter);
-			if (unlikely(!skb))
-				break;
+			skb = ibmveth_rxq_get_buffer(adapter, correlator);
+			if (unlikely(!skb)) {
+				ibmveth_rxq_advance(adapter);
+				netdev->stats.rx_dropped++;
+				frames_processed++;
+				continue;
+			}
+
+			pool = correlator >> 32;
+			room = min_t(unsigned int, skb_tailroom(skb),
+				     adapter->rx_buff_pool[pool].buff_size);
+			off = offset;
+			len = length;
+			if (unlikely(len < ETH_HLEN || off >= room ||
+				     len > room - off)) {
+				if (net_ratelimit())
+					netdev_err(netdev,
+						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
+						   off, len, room);
+				ibmveth_rxq_harvest_buffer(adapter, true);
+				netdev->stats.rx_dropped++;
+				frames_processed++;
+				continue;
+			}
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -1517,12 +1588,21 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
 						length + offset);
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
-					break;
+				rc = ibmveth_rxq_harvest_buffer(adapter, true);
+				if (unlikely(rc)) {
+					dev_kfree_skb_any(new_skb);
+					netdev->stats.rx_dropped++;
+					frames_processed++;
+					continue;
+				}
 				skb = new_skb;
 			} else {
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
-					break;
+				rc = ibmveth_rxq_harvest_buffer(adapter, false);
+				if (unlikely(rc)) {
+					netdev->stats.rx_dropped++;
+					frames_processed++;
+					continue;
+				}
 				skb_reserve(skb, offset);
 			}
 
@@ -1581,10 +1661,16 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 				       VIO_IRQ_DISABLE);
+		rescheduled = 1;
 		goto restart_poll;
 	}
 
 out:
+	/* napi_schedule() already queued us. Returning budget would
+	 * make busy_poll_stop() queue the napi a second time.
+	 */
+	if (rescheduled && budget && frames_processed >= budget)
+		return budget - 1;
 	return frames_processed;
 }
 
@@ -2206,8 +2292,7 @@ static void ibmveth_reset_kunit(struct work_struct *w)
  * @test: pointer to kunit structure
  *
  * Tests the error returns from ibmveth_remove_buffer_from_pool.
- * ibmveth_remove_buffer_from_pool also calls WARN_ON, so dmesg should be
- * checked to see that these warnings happened.
+ * Each error also logs a ratelimited netdev_err.
  *
  * Return: void
  */
@@ -2216,6 +2301,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	struct ibmveth_adapter *adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
 	struct ibmveth_buff_pool *pool;
 	u64 correlator;
+	int ret;
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
 
@@ -2239,6 +2325,13 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
+	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
+	correlator = ((u64)2 << 32) | 0;
+	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, false);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, true);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
 	correlator = (u64)0 | 0;
 	pool->skbuff[0] = NULL;
 	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
@@ -2251,9 +2344,8 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
  * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
  * @test: pointer to kunit structure
  *
- * Tests ibmveth_rxq_get_buffer. ibmveth_rxq_get_buffer also calls WARN_ON for
- * the NULL returns, so dmesg should be checked to see that these warnings
- * happened.
+ * Tests ibmveth_rxq_get_buffer. Each NULL return also logs a ratelimited
+ * netdev_err.
  *
  * Return: void
  */
@@ -2284,15 +2376,87 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
+	u64 cor;
+
 	adapter->rx_queue.queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	cor = ibmveth_rxq_correlator(adapter);
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    ibmveth_rxq_get_buffer(adapter, cor));
 
 	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | adapter->rx_buff_pool[0].size;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	cor = ibmveth_rxq_correlator(adapter);
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    ibmveth_rxq_get_buffer(adapter, cor));
+
+	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
+	adapter->rx_queue.queue_addr[0].correlator = (u64)2 << 32 | 0;
+	cor = ibmveth_rxq_correlator(adapter);
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    ibmveth_rxq_get_buffer(adapter, cor));
 
 	pool->skbuff[0] = skb;
 	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
+	cor = ibmveth_rxq_correlator(adapter);
+	KUNIT_EXPECT_PTR_EQ(test, skb,
+			    ibmveth_rxq_get_buffer(adapter, cor));
+
+	flush_work(&adapter->work);
+}
+
+/**
+ * ibmveth_rxq_harvest_buffer_test - unit test for ibmveth_rxq_harvest_buffer
+ * @test: pointer to kunit structure
+ *
+ * A bad correlator must still advance the RX ring, wrapping and flipping
+ * the toggle at the end. This covers the harvest path; the advance after
+ * ibmveth_rxq_get_buffer() fails in ibmveth_poll() is not tested here.
+ *
+ * Return: void
+ */
+static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
+{
+	struct ibmveth_adapter *adapter;
+	struct ibmveth_buff_pool *pool;
+	int ret;
+
+	adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
+
+	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
+
+	adapter->rx_queue.num_slots = 2;
+	adapter->rx_queue.index = 0;
+	adapter->rx_queue.toggle = 1;
+	adapter->rx_queue.queue_addr =
+		kunit_kcalloc(test, 2, sizeof(struct ibmveth_rx_q_entry),
+			      GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue.queue_addr);
+
+	/* Set sane values for buffer pools */
+	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+					 pool_count[i], pool_size[i],
+					 pool_active[i]);
+
+	pool = &adapter->rx_buff_pool[0];
+	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *),
+				     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+
+	/* Slot 0: pool out of range. Slot 1: valid, but no skb. */
+	adapter->rx_queue.queue_addr[0].correlator =
+		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
+	adapter->rx_queue.queue_addr[1].correlator = (u64)0 << 32 | 0;
+
+	ret = ibmveth_rxq_harvest_buffer(adapter, true);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue.index);
+	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue.toggle);
+
+	ret = ibmveth_rxq_harvest_buffer(adapter, true);
+	KUNIT_EXPECT_EQ(test, -EFAULT, ret);
+	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue.index);
+	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue.toggle);
 
 	flush_work(&adapter->work);
 }
@@ -2300,6 +2464,7 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 static struct kunit_case ibmveth_test_cases[] = {
 	KUNIT_CASE(ibmveth_remove_buffer_from_pool_test),
 	KUNIT_CASE(ibmveth_rxq_get_buffer_test),
+	KUNIT_CASE(ibmveth_rxq_harvest_buffer_test),
 	{}
 };
 
-- 
2.50.1 (Apple Git-155)


