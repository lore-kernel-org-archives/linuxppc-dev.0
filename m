Return-Path: <linuxppc-dev+bounces-25849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574E0C5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGq2wznz3bwL;
	Fri, 14 Aug 2026 17:38:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693107;
	cv=none; b=Fi+pkHW9eYtni9LAdIdbYv/AjBq+wfyGX1FEzP2X+lmz5WmF06SEM7Mjd+jC4gKmb0z3LMRfDM/TxukQHJSPYt33u3A2E0mwwzXztQ9z2x9JGLTVEHPk/ajVHK1SU/R6tycGRk3tz/HV5TB/bjSbG9x3FY0zq6BolTd2YqC2Z80ZUhiWNXIWYieNTeZ3fNAsImDQ0aiDvGDqXxU7TKbRWAftFvL4MNhnZc5WAR+yP99f3WfbWFnjZ0xoQYoFfwedtEDbOL7raz+43+EhdtZa8dK+2uST8RKKZE8kjRC/9hdZh8xYv514B+er+HHlPUP6R0tddtSfT+GvtlFOB5bgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693107; c=relaxed/relaxed;
	bh=apxfEhXcQpCLzXlFWr4W/aGc5wOX7qggMBCcDMNfMgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYxKMExEUeeL9iTv6FfkNkckstLWiwoa+pLExMCBTThtrnyBgZE0mRy+D2upgzfJP+G7KPjq5oGm32fGGIGhDnzpWnmn6cHO72zYwID+nzT6XfOoG93uyU4uhOOKbtSQXFNJMsxy8RB8310iAuSWDK17L9P7XwDmedEAmK5xz9Hwtjc8pTrjfL2eSRRy9FDjfvIKVnQl6fErMvEGHgUv9o6W8+yGCao/Lb1zEZ/MptWp1vsd5bocZ2iFkSQG8+tUWtjVBMrO9soBsITlY0yFN43QXeXAiSxPPObIJkZELQTzBQDhc8m++IM2jpXwEWn5dTRdKs2FDwBpMwbOT7AKlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P0fYXOpd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P0fYXOpd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGp35Y5z3btR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:26 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Vfm43237219;
	Fri, 14 Aug 2026 07:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=apxfEh
	XcQpCLzXlFWr4W/aGc5wOX7qggMBCcDMNfMgY=; b=P0fYXOpdAUx1mnv2BFe/t5
	3STTW5Wf/0NeUNJniwdCxKGvmyIIyQUTw/RLVB49DhSgCj8dJ25zwyLZN/ClosIY
	CTlqsJbyM98lR5I34YUOa9yLB/JAZed+Gm5JXQjyuh7YTWkAE2SASGUu7K8aA7QF
	Cj+1kBoyXcB8xu9kfQ5r4k70hD4HYd83wpum4cAYpT6UhtWWMv4SiaRkKMkvw7wF
	0VG+LFnYyr/nTHJrlz5bZoo017AYDuXS8OFRtl8DBqBVn4lC4bPHyBp+gzv8wdf3
	oYFK6WnXODLW/EwGclIr7Xgt1i2N3u4BCCbRwqX2QS40gZ78zdf73MrtMvYiAx+Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb244036-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QSfE018422;
	Fri, 14 Aug 2026 07:38:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wegbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cB1x23593572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE6058059;
	Fri, 14 Aug 2026 07:38:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E584158057;
	Fri, 14 Aug 2026 07:38:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:08 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 09/15] ibmveth: Harden RX poll path with helpers
Date: Fri, 14 Aug 2026 00:36:36 -0700
Message-Id: <20260814073642.24630-10-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7ec5e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=9GrW9DZCARAA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hQRxX_qh-pxroQ8BXM0A:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX/IbRhchZG2Pd
 3GuqXTdxERGpYnR8TDZ+NkGUnpI1KHhXd/HDR9RxsEiQKrkdDTlPasjtpEDQ0/V0BZ6AovI1vWk
 ry2Cql/IGBOW0Z1Ewd2fNM5bPbNQdDE1/HuH2G+uClNMMJ+49C5OZH2ggmm3V7khUaGRFtSPacE
 4eyTFd2lJSthtnEH+lU0G6qnOBkCidd7LiBZlO29n5xVuxNqH//ieOld1Hj6XE20bO16XUdS2IF
 4PBAXOFPZbBYl5qAmcXYIi0Y/tQs9MdRsfl90w2/hkTn0CDP+NNuggomX6R93DsJEx8Ty50mKHq
 Mh/dTxJCwB+3N3aGqceqx8Dv2ZAeoMBsyuR5yI2ouVmM6vE5Acy2Rl+reuuA7K4SxWxdXdlSVck
 Qo2K9ZkGO/bGMWBWNQ4DZmmufDrGptJs4mFXm6qlND64wyvND0msBmgtJetgyIxmQtUHlyfQG4t
 oXg0VmmzmJ0EzqMXMHw==
X-Proofpoint-ORIG-GUID: 2nKu6K4WgguV0sVxW_wJuMn1Wsx8MePo
X-Proofpoint-GUID: Zz2-PVDY_QyKSxwOEjk4gn_4bebYFG6J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX6WRpuLdp+Tch
 I3G9365JbzVuw+4mXAcqIPUu6B5FF3ld/U8mCFyStPBpBqs264zgJNPKnYUp4SGAczC+SLI8rVk
 IDS6KEa18jELvH0r+phOUSzNfoLlFTk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

ibmveth_poll() must handle several distinct skip/fail outcomes on each
RX slot, not only the happy path:

  - interface close / napi_disable must not re-arm PHYP delivery
  - bad correlators and harvest errors must not look like successful GRO
  - oversize or wrap-around offset+length must not skb_put() past the
    buffer
  - an out-of-range queue index must napi_complete_done rather than
    fall through and keep polling

Doing all of that inline turns the NAPI callback into a deeply nested
switchyard. Split each outcome into a small helper so ibmveth_poll()
stays a thin budget loop:

  ibmveth_poll_stopping()
  ibmveth_poll_harvest_slot() / recycle_invalid / skip_bad_correlator
  ibmveth_poll_drop_oversize()
  ibmveth_poll_deliver_frame()
  ibmveth_poll_bump_invalid()

Drop schedule_work from rxq_get_buffer() (skip_bad_correlator owns
reset escalation). ibmveth_poll_stopping() ensures close/napi_disable
does not re-arm PHYP. Runtime is still single-queue: helpers are defined
and called from the existing SQ poll path in this same patch (first
use). The next patch turns on MQ and reuses this loop; subordinate
register helpers stay there.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- Wrap poll_stopping return after complete so it stays under 80 cols
- On poll_stopping after the budget loop: return < budget after
  napi_complete_done (was frames_processed-1 even when under budget)
- New in v5: peel SQ poll harden + helpers before MQ enable so tip P10
  stays bring-up focused (mailed v4 09/14 MQ enable -> tip P10; also
  14->15). Kitchen-sink / enable-path poll fixes land here on the live
  single-queue path first.
- After napi_complete_done, check poll_stopping again before enable_irq
  (avoid re-arm while resize/close waits on napi_disable)

 drivers/net/ethernet/ibm/ibmveth.c | 283 ++++++++++++++++++++---------
 1 file changed, 193 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 58a639a962a6..86299c62d4ec 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1346,10 +1346,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
-	}
 
 	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
@@ -2338,125 +2336,230 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	}
 }
 
+static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
+				      int queue_index)
+{
+	adapter->rx_invalid_buffer++;
+}
+
+static bool ibmveth_poll_stopping(struct net_device *netdev,
+				  struct napi_struct *napi)
+{
+	return !netif_running(netdev) || napi_disable_pending(napi);
+}
+
+static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
+				      int queue_index, bool reuse)
+{
+	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
+
+	return !rc || rc == -EINVAL || rc == -EFAULT;
+}
+
+static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
+					 struct ibmveth_adapter *adapter,
+					 int queue_index)
+{
+	netdev_dbg(netdev, "recycling invalid buffer\n");
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
+}
+
+static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
+					     struct ibmveth_adapter *adapter,
+					     int queue_index)
+{
+	if (net_ratelimit())
+		netdev_err(netdev,
+			   "bad correlator on queue %d, skipping slot\n",
+			   queue_index);
+	/* Residual stale slot after resize: recover via reset rather
+	 * than spinning forever. Always escalate; only the log is
+	 * rate-limited.
+	 */
+	schedule_work(&adapter->work);
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
+}
+
+static bool ibmveth_poll_drop_oversize(struct net_device *netdev,
+				       struct ibmveth_adapter *adapter,
+				     int queue_index, unsigned int off,
+				     unsigned int len, unsigned int room)
+{
+	if (net_ratelimit())
+		netdev_err(netdev,
+			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
+			   off, len, room, queue_index);
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
+}
+
+/**
+ * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
+ * @napi: NAPI context for this RX queue
+ * @adapter: ibmveth adapter
+ * @netdev: net_device for @adapter
+ * @queue_index: RX queue index
+ *
+ * Return: 1 frame delivered, 0 if the slot was skipped cleanly, -1 on error.
+ */
+static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
+				      struct ibmveth_adapter *adapter,
+				      struct net_device *netdev,
+				      int queue_index)
+{
+	struct sk_buff *skb, *new_skb;
+	unsigned int room, off, len;
+	int length, offset, csum_good, lrg_pkt;
+	__sum16 iph_check = 0;
+	u16 mss = 0;
+	int rc;
+
+	length = ibmveth_rxq_frame_length(adapter, queue_index);
+	offset = ibmveth_rxq_frame_offset(adapter, queue_index);
+	csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
+	lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
+
+	skb = ibmveth_rxq_get_buffer(adapter, queue_index);
+	if (unlikely(!skb)) {
+		if (!ibmveth_poll_skip_bad_correlator(netdev, adapter,
+						      queue_index))
+			return -1;
+		return 0;
+	}
+
+	room = skb_tailroom(skb);
+	off = offset;
+	len = length;
+	if (unlikely(off >= room || len > room - off)) {
+		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
+						off, len, room))
+			return -1;
+		return 0;
+	}
+
+	if (lrg_pkt) {
+		__be64 *rxmss = (__be64 *)(skb->data + 8);
+
+		mss = (u16)be64_to_cpu(*rxmss);
+	}
+
+	new_skb = NULL;
+	if (length < rx_copybreak)
+		new_skb = netdev_alloc_skb(netdev, length);
+
+	if (new_skb) {
+		skb_copy_to_linear_data(new_skb, skb->data + offset, length);
+		if (rx_flush)
+			ibmveth_flush_buffer(skb->data, length + offset);
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+		if (unlikely(rc)) {
+			kfree_skb(new_skb);
+			return -1;
+		}
+		skb = new_skb;
+	} else {
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
+		if (unlikely(rc))
+			return -1;
+		skb_reserve(skb, offset);
+	}
+
+	skb_put(skb, length);
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	if (skb->protocol == cpu_to_be16(ETH_P_IP))
+		iph_check = ip_hdr(skb)->check;
+
+	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
+	    iph_check == 0xffff) {
+		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
+		adapter->rx_large_packets++;
+	}
+
+	if (csum_good) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		ibmveth_rx_csum_helper(skb, adapter);
+	}
+
+	napi_gro_receive(napi, skb);
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += length;
+
+	return 1;
+}
+
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct net_device *netdev = napi->dev;
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
 	int queue_index, rc;
-	u16 mss = 0;
 
 	queue_index = napi - adapter->napi;
 
+	if (WARN_ON(queue_index < 0 ||
+		    queue_index >= adapter->num_rx_queues)) {
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
+	if (ibmveth_poll_stopping(netdev, napi)) {
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 restart_poll:
 	while (frames_processed < budget) {
+		if (ibmveth_poll_stopping(netdev, napi))
+			break;
+
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
-			netdev_dbg(netdev, "recycling invalid buffer\n");
-			rc = ibmveth_rxq_harvest_buffer(adapter,
-							queue_index, true);
-			if (unlikely(rc))
+			if (!ibmveth_poll_recycle_invalid(netdev, adapter,
+							  queue_index))
 				break;
 		} else {
-			struct sk_buff *skb, *new_skb;
-			int length = ibmveth_rxq_frame_length(adapter,
-							      queue_index);
-			int offset = ibmveth_rxq_frame_offset(adapter,
-							      queue_index);
-			int csum_good = ibmveth_rxq_csum_good(adapter,
-							      queue_index);
-			int lrg_pkt = ibmveth_rxq_large_packet(adapter,
-							       queue_index);
-			__sum16 iph_check = 0;
-
-			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
-			if (unlikely(!skb))
+			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
+							queue_index);
+			if (rc < 0)
 				break;
-
-			/* if the large packet bit is set in the rx queue
-			 * descriptor, the mss will be written by PHYP eight
-			 * bytes from the start of the rx buffer, which is
-			 * skb->data at this stage
-			 */
-			if (lrg_pkt) {
-				__be64 *rxmss = (__be64 *)(skb->data + 8);
-
-				mss = (u16)be64_to_cpu(*rxmss);
-			}
-
-			new_skb = NULL;
-			if (length < rx_copybreak)
-				new_skb = netdev_alloc_skb(netdev, length);
-
-			if (new_skb) {
-				skb_copy_to_linear_data(new_skb,
-							skb->data + offset,
-							length);
-				if (rx_flush)
-					ibmveth_flush_buffer(skb->data,
-							     length + offset);
-				rc = ibmveth_rxq_harvest_buffer(adapter,
-								queue_index,
-								true);
-				if (unlikely(rc))
-					break;
-				skb = new_skb;
-			} else {
-				rc = ibmveth_rxq_harvest_buffer(adapter,
-								queue_index,
-								false);
-				if (unlikely(rc))
-					break;
-				skb_reserve(skb, offset);
-			}
-
-			skb_put(skb, length);
-			skb->protocol = eth_type_trans(skb, netdev);
-
-			/* PHYP without PLSO support places a -1 in the ip
-			 * checksum for large send frames.
-			 */
-			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
-				struct iphdr *iph = (struct iphdr *)skb->data;
-
-				iph_check = iph->check;
-			}
-
-			if ((length > netdev->mtu + ETH_HLEN) ||
-			    lrg_pkt || iph_check == 0xffff) {
-				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-				adapter->rx_large_packets++;
-			}
-
-			if (csum_good) {
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-				ibmveth_rx_csum_helper(skb, adapter);
-			}
-
-			napi_gro_receive(napi, skb);	/* send it up */
-
-			netdev->stats.rx_packets++;
-			netdev->stats.rx_bytes += length;
-			frames_processed++;
+			if (rc > 0)
+				frames_processed++;
 		}
 	}
 
 	ibmveth_replenish_task(adapter, queue_index);
 
+	if (ibmveth_poll_stopping(netdev, napi)) {
+		napi_complete_done(napi, frames_processed);
+		/* After complete, must not return budget (NAPI resched). */
+		if (frames_processed < budget)
+			return frames_processed;
+		return budget - 1;
+	}
+
 	if (frames_processed == budget)
 		goto out;
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
 
-	/* We think we are done - reenable interrupts,
-	 * then check once more to make sure we are done.
+	/*
+	 * napi_disable() sets DISABLE then waits for this poll. Without a
+	 * second stopping check here, enable_irq() can re-arm PHYP after
+	 * resize already masked the queue — late IRQs then hit the handler
+	 * after num_rx_queues was published lower (lab WARN at interrupt).
 	 */
+	if (ibmveth_poll_stopping(netdev, napi))
+		goto out;
+
 	rc = ibmveth_enable_irq(adapter, queue_index);
 	if (rc) {
 		netdev_err(netdev,
-- 
2.50.1 (Apple Git-155)


