Return-Path: <linuxppc-dev+bounces-28221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5E9C98328
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:40:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzyb5ysJz3blT;
	Sat, 26 Sep 2026 04:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361591;
	cv=none; b=nwhetSt40jiRUsospM4y6y26MztDHH0HfoywFCRlNOgTouYG3oZ926cZRXMLJw1iaRq19MfeB49dJtQOLddyV1ygJqI0Y5WVosNxMZvR9U3P5RFFUSu1QA6gdT87M7ueNU0CfFn8oJ/5UIDZveA54G95Cvv5Kc++HnLaKOAFdNZ4kAS5llKW5Z+1QUS1hSUpDnH/0raxWz4i8fsKxO3jQAem8f4tgKKs9e9G99CybymUKXalcwizIqgahNTRfpvfXnexdTp2w9CTic8AC4rF4ub3dWujVRFEYTEYhUGZTTrvzy18s4FpvIb+zKJWMleZ+8dpJeS5kNpH1NMBPJDdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361591; c=relaxed/relaxed;
	bh=yd3bG5sGqhB6u5oC5MJGdO7pd0cBjWw0rOk0lImiedI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+pCQ9ykmPSQcsvFst6qm0OeFUizXbTFj/PXwnhKBYIcJunD8pjdHTuRQBwQMHwQ75FE1xLo55xkedUYyDdDmE2+vnXWdTtE8GzsBdms/GSQeSddHeZQ1b2/OMkP2U5HXO3c0L4o4nSEVjTdVAZyR4spVU0YYm1D+xsT6xVcpR0XiIvQG7wHsDTtu38z4umWqOZ7ss0Wrgm8zMA9CihZFMg1EODYAcboJNdKw5hH6kEuhGA4NWbrDdKNwPsA0WNYhPbUobMeDka5pKHuBqmnfwE+b1s+R0QeyMuLuvdsrbwVcDQ1Q9IXDAOwEU4SxBDWSeed5lOZna4BdDAm2o+4Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qqa/nFSg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qqa/nFSg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyY6rtgz30WX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:49 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5TEi342819;
	Fri, 25 Sep 2026 18:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yd3bG5sGqhB6u5oC5
	MJGdO7pd0cBjWw0rOk0lImiedI=; b=qqa/nFSg8aWQPHZgaagJeTbjqJs4UqhcR
	BWlm1Wc5ejZtoyDmAcN4kgt/e1+p8Sp883V2+sTpj38MKEZaDKRGwO9imW8vlfkA
	hnMRQjFFOX4QYpbq82LNBRiWgWNJ7+wN0oTjaqHNfLcYvCQO9X5ALHIEANpUqxcJ
	ybxXqi2BgBDRMt7FXqtbiJ1S1t2R92A8CMYGRqwJVx8DbO4u1lxjnUts4+PPOxQU
	xhT8dXFq9gF5y7z4Dx7t9I9LMt02Zl9eoEVjkNRoZRocqedafifuKTuU2fn4Q7DG
	Ney5q0FreD7AIe0xOjZS87XeGWNdrd81OfEPHtBeKr37sKmAs93Pg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqyjdb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG37pm4192010;
	Fri, 25 Sep 2026 18:39:38 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k3kr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdaCT17105462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187AF58059;
	Fri, 25 Sep 2026 18:39:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE6858055;
	Fri, 25 Sep 2026 18:39:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:33 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 09/15] ibmveth: Harden RX poll path with helpers
Date: Fri, 25 Sep 2026 11:38:44 -0700
Message-Id: <8a7621e33cc595cff0e1712c1415051d8c5679d2.1790319558.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790319558.git.mmc@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6bfeb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZnO335mD0f2ZzhB7t6kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX0scuzPDNvtHN
 hEiPgCwNcdNN71UFAn3H9h/BoRMhfoi0b7fPQXG94w7CimkF4zDt7KxiBjA3sFoCgEaubRAJaW4
 8coG9zbUTlqn8UeHn9I1HmycDTE3WqzPnDdjUFSK4Qmv/9TrS2Kt69n8MW6ayKU8gsShtrHyJ5T
 c3PP2miGLTjB7EVQEkMKybhSNi+doKIwWYwLldxLJ8QNoarC+je5iPKPMVj6pyOG79cHt+mvOVi
 Xped1BqwqkPXTl4j2jWiVaWQyaFvtPzL7fZei/0fbFFzrCB/w9Tdto+cH5iQQh3ZUa1FCkwrJn/
 oEahf3kiqwSbVnpd9Xf0/UsHryx75yZU1mlzQRR1VgOMoiUtAV/CsNUgFkjIgjVSQ2qhpleChLc
 u5sfX/Yrg8l0RGnjGvF1jLNIyPfcbzpQbJXO4+n2p7kD0a2cjT0HstO1KcEug65M/8MfVIE2ygP
 T6pS/HR4eHLrfo2cOwA==
X-Proofpoint-ORIG-GUID: tQqzRKtqjlBgqsFD10ekRMM4uF8UgKji
X-Proofpoint-GUID: H6vsExsWplLfzT_WZvhTAjCHVz7fKr6Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX3D8Uv8UinUa0
 dxER4p62vlvV45Djx7IaeTKEZZgiXG/UhqsqcZRGw9mp/BZzk48Tok4/1sVTk9XZkd9IMpEl8PM
 kFPbe8rh6J6S0iIMqaQWviN/UOg5vyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

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

Not pure motion: ibmveth_poll_bump_invalid() also counts oversize
frames and skipped slots (intentional). skip_bad_correlator escalates
a valid correlator with a NULL skb (-EFAULT) to reset, not only an
out-of-range correlator. Deliver also rejects a PHYP offset+length
beyond min(skb_tailroom, pool->buff_size);
skb_tailroom is the skb_put bound, the DMA
map is pool->buff_size. Skipped and dropped slots do not
count against the NAPI budget; only a delivered frame does.

Two further behaviour changes come with the split. On the rx_copybreak
path a harvest failure, after the frame has already been copied into
new_skb, used to break out of the loop and leak that skb;
deliver_frame() kfree_skb()s it before returning an error. And mss
becomes a local of deliver_frame() rather than living across
ibmveth_poll()'s whole budget loop; it was never read stale, because
ibmveth_rx_mss_helper() only uses it under lrg_pkt, so that part is
scoping hygiene and not a fix.

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

Changes in v7:
- bound oversize against min(skb_tailroom, pool->buff_size);
  name that bound in the commit message
- noted: poll_stopping stays mask-first; skip vs budget stays;
  cancel_work stays in P10

Changes in v6:
- read the IPv4 header check through skb->data, as mainline does.
  v5 used ip_hdr(), which reads the network header offset that
  eth_type_trans() does not set on this path
- do not complete NAPI or consume budget when budget is 0. That is
  the netpoll case, where v5 completed and returned budget - 1,
  underflowing to -1
- noted: the split is not pure motion; the body lists what changed

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

 drivers/net/ethernet/ibm/ibmveth.c | 297 ++++++++++++++++++++---------
 1 file changed, 202 insertions(+), 95 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ed75dea90a95..7b6c0283e5c3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1380,10 +1380,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
-		schedule_work(&adapter->work);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
-	}
 
 	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
@@ -2390,130 +2388,239 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
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
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	unsigned int room, off, len, pool;
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
+	pool = rxq->queue_addr[rxq->index].correlator >> 32;
+	room = min_t(unsigned int, skb_tailroom(skb),
+		     adapter->rx_buff_pool[queue_index][pool].buff_size);
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
+		iph_check = ((struct iphdr *)skb->data)->check;
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
+		if (budget)
+			napi_complete_done(napi, 0);
+		return 0;
+	}
+
+	if (ibmveth_poll_stopping(netdev, napi)) {
+		if (budget)
+			napi_complete_done(napi, 0);
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
-			if (unlikely(!skb)) {
-				struct ibmveth_rx_q *rxq =
-					&adapter->rx_queue[queue_index];
-
-				ibmveth_rxq_advance(rxq);
+			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
+							queue_index);
+			if (rc < 0)
 				break;
-			}
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
+		/* budget 0 is netpoll, which must not complete NAPI.
+		 * Otherwise returning budget after completing would ask
+		 * NAPI to reschedule, so cap the return at budget - 1.
+		 */
+		if (budget) {
+			napi_complete_done(napi, frames_processed);
+			return min(frames_processed, budget - 1);
+		}
+		return 0;
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
+	 * resize already masked the queue; late IRQs then hit the handler
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


