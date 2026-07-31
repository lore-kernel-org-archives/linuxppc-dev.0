Return-Path: <linuxppc-dev+bounces-25159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E45C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:49:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6r63t6rz304N;
	Fri, 31 Jul 2026 10:48:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458902;
	cv=none; b=R2+PVfUJ8QS0hvjPZ9vf6VVbUmupswkOUa5AG50MOtJfcWevgFVYYPTL50yVPDh3/1UOsJ7wkCsgehjpKeAdUV6dRpYEdIoriV17ntp3bTn6gnmQ85ow6mbJqGRzk86qZomM0se6pOG+T5TRFE4EodFuQDOuvGRejC3o2c5Ngt1BlVI0Ndu+eIDSTDhV+N/5EFV+reyoYtOaK46Hedo0JoTtphWeWpxAENES3o9h2FBRLPNfps+UfkMKmKQZuqHamaLXlUK86ID+vm5j7YA8bVxmT+EoxPJ6ChBzYuzoW/RsYFaVt0PauI8ysihv4Xkwz3bDmUnes8El68tKESbUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458902; c=relaxed/relaxed;
	bh=jo/Rj6KLGUzeCF3zXYpG//pA5yECGfN6geY+88oxkxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0bfLiFMQttdB5T6LNzZrQEefIebz1xZtHyDhol1zki+8NV1j7wbQ9SAQ5CjlXHLl1ieDt1CYo/b3Ut3U55eLNcXbuZCbCrPRccq4t4YqNYU/HZUoJkIOhhODNyg3OQgSkz0FHfAO8tDSQUgqwnqMA1wMDf6wd06XVdLeMpXY3U4L7pBcpewya8AVzqnsme6yWr0gl/4Hl2Omt4IGvL7gu6rWA4YVbP2W32/+Y0+l1jUS1lrxhSCnMwNvWMenyR1Il4odh+vD6Em62SnVTDYfGSVBPVicYBYImNLMUaNFvdpPZngF0HD/B8tnVnseWonKonHVo/jgCk5OKjldW2Ssw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fF9Lpd86; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fF9Lpd86;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6r51h76z2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNIVaV2520456;
	Fri, 31 Jul 2026 00:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jo/Rj6KLGUzeCF3zX
	YpG//pA5yECGfN6geY+88oxkxI=; b=fF9Lpd86NhxMjqhXNrm+MnaZf/XaPNjQL
	tA/ENwHbBn2+sAdntSWxsfOajNM4NM7Z7ya/PdIhSwdY2N2Idh1gLUpDCDDD0iCo
	q2QH/KveyRnNyjOo6NE8xh2F9YJmySUktvib96UUKo18uaDcggNLXi1/jOYFjWqC
	Uheicw5/M9ooeBqUlEyVmyKzixJj5Y0MfBNZF9pN1HUd9eDDJY7TOuDOcFsJyFDt
	wi/1nHtGl3/54+G/v+8X7GEQYL+Q/RWY+pZw2rgcwyNmNzExdRjowosvyz/rjX5D
	tX28EiVWQoJ7prJAcgyJ2r3q+dPWE8HjCYGXRtIgMV16bbN4TgUjw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycthjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fLNH015691;
	Fri, 31 Jul 2026 00:48:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ydkb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0m9ug31458010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:48:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DCF758057;
	Fri, 31 Jul 2026 00:48:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E89458059;
	Fri, 31 Jul 2026 00:48:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:48:08 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 14/14] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Thu, 30 Jul 2026 17:47:17 -0700
Message-Id: <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Wv14OYUQL9a9pMASkhfUK_WrsShfDIgB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfXyfgB/pvFoxjI
 nQJdH99pYGflPgpXxHJ80LcVySg4TnAAypCx7Dhq+LTgZRpLG8o2EBvNeUIrPDSUVK0UHpFc/S0
 slX2An3AdjA45a0RwXmpFaUDgr4S6IAGKds8hGz1WZV449lWU+F6VqWP+w5kV7pEHmfe3+RfSn7
 QUS6+j01laFIwmlXOnujfIj9GcRYqho0VuIedOPg26Tj0XT75jw/sOIg5TkzlcJxGZdo0xG8MjA
 biBzksk9alFvprYUlebBG9EjKHRHBzoXIQMClyvXeV2CSnI/LRmnr9/H7s1OgtRs8hAfOb42qmG
 rEyuRoYoozQkei+5YuKfw1Dh4popLiK4fijViXy5AwiZOGSbNsKAYZ9M7pZnG49x4JDB4Zt6Pgg
 6GPzQaILRVNe4ooDYE/0D65mnuGFmV543qjJlZFWYISGtmTk5Jv/Gk15++t5NJi6fq4b9+H1QVH
 PllBOhtbTH8uUCEx1LQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX2cta+8QYzW6Z
 ZXBMQcgMmuOHrsFhOLQkizSXKlZkYDZgtIleXacI/jIigRgt3cGckK3Re79lU7IqD/PTDibx/bD
 GWl8P1mbRhHzOi7/9Zqvfds0twhLDMc=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bf0cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MdHJFOP_7j5GoaUJ3yAA:9
X-Proofpoint-GUID: vqM8yT3ZXQ47znPx5XNmzBe0YVDEGMmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

After aggressive ethtool -L cycling, PHYP can leave a VALID RX descriptor
with a correlator that no longer matches the per-queue buffer pools. Poll
treated this as fatal: ibmveth_rxq_get_buffer() WARNed and returned NULL
without advancing the ring, then restart_poll retried the same slot
forever.

Advance past bad correlators instead of spinning: validate correlators
without WARN_ON, skip invalid slots in poll (count as invalid_buffers),
and advance the RX ring when remove_buffer_from_pool cannot map the
correlator. Rate-limit the bad correlator message.

Complete NAPI when the interface is down or napi_disable is pending so
close/quiesce can finish. Do not restart_poll in that window. Close
keeps hypervisor IRQ disable before napi_disable (via
cleanup_rx_interrupts() / related cleanup helpers).

Also validate descriptor length against skb tailroom before skb_put(),
and after napi_complete_done() on the budget-exhausted shutdown path
return a value less than budget so NAPI does not immediately reschedule.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Skip invalid correlators in poll instead of spinning (no WARN_ON;
  rate-limited message; advance ring when harvest cannot map).
- Validate descriptor length against skb tailroom before skb_put().
- After napi_complete_done() on the budget-exhausted shutdown path,
  return a value less than budget so NAPI does not immediately
  reschedule.
- Align KUnit comments with correlator validation (no WARN_ON).

 drivers/net/ethernet/ibm/ibmveth.c | 109 ++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index c99d8e8be7b3..09e06d86701a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1376,6 +1376,24 @@ ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
 	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
 }
 
+static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
+					 int queue_index, u64 correlator)
+{
+	unsigned int pool = correlator >> 32;
+	unsigned int index = correlator & 0xffffffffUL;
+
+	return pool < IBMVETH_NUM_BUFF_POOLS &&
+	       index < adapter->rx_buff_pool[queue_index][pool].size;
+}
+
+static void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
+{
+	if (++rxq->index == rxq->num_slots) {
+		rxq->index = 0;
+		rxq->toggle = !rxq->toggle;
+	}
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -1397,17 +1415,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	unsigned int free_index;
 	struct sk_buff *skb;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return -EINVAL;
-	}
 
 	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
-	if (WARN_ON(!skb)) {
-		schedule_work(&adapter->work);
+	if (!skb)
 		return -EFAULT;
-	}
 
 	/* if we are going to reuse the buffer then keep the pointers around
 	 * but mark index as available. replenish will see the skb pointer and
@@ -1452,11 +1465,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
-	}
 
 	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
@@ -1483,14 +1493,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 	cor = rxq->queue_addr[rxq->index].correlator;
 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
+		if (rc == -EINVAL || rc == -EFAULT)
+			goto advance;
 		return rc;
-
-	if (++rxq->index == rxq->num_slots) {
-		rxq->index = 0;
-		rxq->toggle = !rxq->toggle;
 	}
 
+advance:
+	ibmveth_rxq_advance(rxq);
+
 	return 0;
 }
 
@@ -3092,11 +3103,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
 		return 0;
 
+	if (!netif_running(netdev) || napi_disable_pending(napi)) {
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	if (adapter->rx_qstats)
 		adapter->rx_qstats[queue_index].polls++;
 
 restart_poll:
 	while (frames_processed < budget) {
+		if (!netif_running(netdev) || napi_disable_pending(napi))
+			break;
+
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
@@ -3126,8 +3145,45 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			__sum16 iph_check = 0;
 
 			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
-			if (unlikely(!skb))
-				break;
+			if (unlikely(!skb)) {
+				if (net_ratelimit())
+					netdev_err(netdev,
+						   "bad correlator on queue %d, skipping slot\n",
+						   queue_index);
+				if (adapter->rx_qstats)
+					adapter->rx_qstats[queue_index]
+						.invalid_buffers++;
+				else
+					adapter->rx_invalid_buffer++;
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								true);
+				if (unlikely(rc))
+					break;
+				continue;
+			}
+
+			if (unlikely((unsigned int)offset +
+				     (unsigned int)length >
+				     skb_tailroom(skb))) {
+				if (net_ratelimit())
+					netdev_err(netdev,
+						   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
+						   offset, length,
+						   skb_tailroom(skb),
+						   queue_index);
+				if (adapter->rx_qstats)
+					adapter->rx_qstats[queue_index]
+						.invalid_buffers++;
+				else
+					adapter->rx_invalid_buffer++;
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								true);
+				if (unlikely(rc))
+					break;
+				continue;
+			}
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -3206,8 +3262,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 	ibmveth_replenish_task(adapter, queue_index);
 
-	if (frames_processed == budget)
+	if (frames_processed == budget) {
+		if (!netif_running(netdev) || napi_disable_pending(napi)) {
+			napi_complete_done(napi, frames_processed);
+			/* After complete_done, must not return full budget. */
+			return frames_processed ? frames_processed - 1 : 0;
+		}
 		goto out;
+	}
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
@@ -3225,6 +3287,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    netif_running(netdev) &&
+	    !napi_disable_pending(napi) &&
 	    napi_schedule(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
 		WARN_ON(lpar_rc != H_SUCCESS);
@@ -4014,8 +4078,7 @@ static void ibmveth_reset_kunit(struct work_struct *w)
  * @test: pointer to kunit structure
  *
  * Tests the error returns from ibmveth_remove_buffer_from_pool.
- * ibmveth_remove_buffer_from_pool also calls WARN_ON, so dmesg should be
- * checked to see that these warnings happened.
+ * Bad correlators return -EINVAL/-EFAULT (no WARN_ON).
  *
  * Return: void
  */
@@ -4071,9 +4134,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
  * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
  * @test: pointer to kunit structure
  *
- * Tests ibmveth_rxq_get_buffer. ibmveth_rxq_get_buffer also calls WARN_ON for
- * the NULL returns, so dmesg should be checked to see that these warnings
- * happened.
+ * Tests ibmveth_rxq_get_buffer invalid correlator returns NULL without WARN.
  *
  * Return: void
  */
-- 
2.50.1 (Apple Git-155)


