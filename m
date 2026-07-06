Return-Path: <linuxppc-dev+bounces-23663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BFDC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:38:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF4H4dN1z3bs0;
	Tue, 07 Jul 2026 05:37:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366639;
	cv=none; b=aithZPC9vD8ZlkvW4EBiD5tvoh3QPneOeWiYGSkivk94Jixl8gz+cqP3gBBWBzOWUU5Rdc52SFTulTorvqdKSeV2FY77BtHt3TEeOuqonVGJFAJd5vMC+S4D0lsk9mI4L4stOFHXgw90ghPGxLHTtGPYhXhNedek2fa5+41XlfLfJ0Oxrui9gr4Oq1pfdF1wWsUzlLCoEuAN//VSSQzxTPEX7E1UM3/H/k+6mA3mJR6VzPQ8rfkhL3OQ4kpnmEteJOCTDXb2pxnfhl9f5xazMaxuzLd4bItu7g1gObdGzD8kF0k5tEeEFkg+gJ3pv9RTCqC20Zqr4qaGWSwKeqtWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366639; c=relaxed/relaxed;
	bh=SedQovSKo0iXXIEGL3BVsBeZfUvpUMRZBWUxAwaWICs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1iH96lIK0YoWW4xA/ZcJ8UDYXB+92rL8sy8LlyRG479ulg+mjti1qk6MkddtcWE3K9VkizKsJWfc7VzXkF1DErk+wmilFNhyR/BT6GYC23W5AG0Tl6anclLOOVHGCG3K1YQDX3RoNl887poq/R4mU2gO0RKtoolovOXdVYH2Iea6vJ7hoPTxVZ2NyM+dK5wzeKriziLtHV9fZKTnyoqUNKQDJMZvaB2qOGjwrou6F/WzxU947nrvl+1fi1iR8s3gNXMk/v7U2HECXJYol8rCCA9wOS1+/mQWFFbeodCaCmaxLi0Hb5lVVupmG8tb+4Fb/EKM+klqVzOLUf112z5LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q7mt0RyC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q7mt0RyC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF4G65S7z3brc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:37:18 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FImaN756594;
	Mon, 6 Jul 2026 19:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SedQovSKo0iXXIEGL
	3BVsBeZfUvpUMRZBWUxAwaWICs=; b=Q7mt0RyCRxGUOXQDcSeu7gu5BdWmnXp8p
	znB1QyezuXM0ML0yQNbg6vSXU+w7aR+QHv9mYNQp6ZeQWVYo1d+aZ/yhnPe5zooT
	yZ9j6B9729z90bagEZ891bfEYTh0pg37uvcmHt2h5apn6GeaVPo6Tt2YhPitQJou
	6gQaPsb2lp0tjB0SfRBRSaTUgoDU/TfgU28zru80B5HGIeE4leCXMWoxrzzpFsWS
	GFA3jFn1VHgB4cHHlGvLgB3V17jvYgu0fW7YBWV0IAwZE3Mra35jyQ+kfPkodkKF
	7uBM/lFhIR0TAnKvPi1CVUPCr8npgPmuNdoGD0RFh+CMemqz1+DIw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZ1j022409;
	Mon, 6 Jul 2026 19:37:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvy4cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jb6jt33554900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:37:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A788E5805A;
	Mon,  6 Jul 2026 19:37:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7473058051;
	Mon,  6 Jul 2026 19:37:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:37:05 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 15/15] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Mon,  6 Jul 2026 12:36:03 -0700
Message-Id: <20260706193603.8039-16-mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03e5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=H2PsU0_gVjd1cLIlZ3YA:9
X-Proofpoint-GUID: pVluUtutbhXUwmnsEBFF9t0Jju90rufz
X-Proofpoint-ORIG-GUID: dc0hHG4mDYCju6j0AtPGL5vZEv_dP1wr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX9THXSo46uER0
 wZWjxuQXwL590qZmx0qbQpz/3tx6gyhiSo/BE///kXDJumKOOcDb9quPF89ebtrKFGz7iyBzE6k
 j1pKd9LGvQwGEN6k03EyoI0zAopuhOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX8+c8rf1QuEsz
 gvNSBEkFbgY5ObYGVo43ZW895xoxLKecqB4clEnf4ZBg0l+crWWpQ12xKeEa0GCOFUxzaFi3AEQ
 bEtguWItaO8FbZEU/OJaKJdiMvIsyAJgeGC9Ce7O8MOjLGbNtQlBdplmER1g7AW7+0eSxWz3tDi
 rIZ8Drgv3AoBwjMPgVhqIipx1nmAZvJaqKR1x8E1mZ3KAZ9wGdxsZB7GazdimXV+FcmPLDhi3/j
 OHIEX98mnpHpeiEIZ9aemCoUpfAqVWYYXbO6fwvWC2b6L5cv7z0wCe8YZpiC23CY39kKlAx7tOd
 1ui/66YxFayVr5/2pCU0QkZ+GmSzkH7uPNMDZ3hNoyN0owrZnbs0+e5obQ9bekRXThULakfxVQI
 dijDiC3Age307MT0CYzYnHAU7X0jAeThB6vd4yguYISVTDQKQmYKlWHRTKjkYhwpZ2b+Gh50TLI
 r0XA6hpbez17nhv0geA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195

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
ibmveth_cleanup_rx_interrupts() can finish. Do not restart_poll in that
window. Close keeps hypervisor IRQ disable before napi_disable (via
cleanup_rx_interrupts()).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 77 ++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 50a332ab83fd..eb84b4e5f69f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -158,6 +158,24 @@ static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter,
 	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
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
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
 					int queue_index)
 {
@@ -1284,17 +1302,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
@@ -1335,11 +1348,8 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
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
@@ -1365,14 +1375,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
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
 
@@ -2931,11 +2942,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
@@ -2959,8 +2978,23 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -3034,8 +3068,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 	ibmveth_replenish_task(adapter, queue_index);
 
-	if (frames_processed == budget)
+	if (frames_processed == budget) {
+		if (!netif_running(netdev) || napi_disable_pending(napi))
+			napi_complete_done(napi, frames_processed);
 		goto out;
+	}
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
@@ -3053,6 +3090,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    netif_running(netdev) &&
+	    !napi_disable_pending(napi) &&
 	    napi_schedule(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
 		WARN_ON(lpar_rc != H_SUCCESS);
-- 
2.39.3 (Apple Git-146)


