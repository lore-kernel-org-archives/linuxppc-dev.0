Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280A60A380F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JdRwMbaz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmst5K5Vz3bgx;
	Tue, 10 Nov 2026 10:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268626;
	cv=none; b=jN7HBfHPiDHc7yTwTcjYvx198VOFXJQb+fuKY2j+wh6hXhbBtgbNPwSdEvpEkUCXTWsmuBenxaQBOZ5zAVQ5ZWXnA/ZDHFhniiHa3yyoBVuzjdm15nu1OZ1+BwoHdCRdTJTqtZfhbwJ4Vq2gutV/1SKE6r7wDcMShECy7W6G3V3LBs6YkdIJsmZuzcC3S0AmevPJW0xfOm7ET5LMV7XA+6RrzGV0NGcJS0KuR36bCH4IKicCnFY+DI0Qw1PODWE9O8s+g/x3MwqB5D7CBr6VIpNcr5ce64JRbwzY7yWZVcs9Tn4KJvXvR87FJy8Eysa1vf3aBJoqeTRQj2yJ689jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268626; c=relaxed/relaxed;
	bh=8tDWq2CioYf9gZqoYD2f7g4liCfZQASe9vS5LgR1B2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EonJrPOQ9ShSKgSycDpk/UHlJYuJ+ZeRmQsS/AAME1tvqIy1TSjRdrfZya0CVseifKkNmi/zhOAY1A0IDxP0Yx7SeF9vXt092FSfGiOpkZCepHtYz0IUamrLGfLYq/qc4QN1IG5YaOdDYyXW1EZD5yKrSKhmx2UyLzyVjW0KOVZWLHcIyC8bKnLK2hm8b5DnStLq6YlP0aJCF2hNeAvMgXdoo3Tv4/j9QzOb40rLjeKQ0jNHW0/l/gbBS0GoFHokURGmRmDRkg/9iP/am9VDrEjMnG4FjszQyR3d9rK9oRRI2ecR7yDIIRypYm1olNtFItTwgz9N5vKBocsiiUeiWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JdRwMbaz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JdRwMbaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsq5l8gz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:03 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEJb83057560;
	Mon, 9 Nov 2026 23:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8tDWq2CioYf9gZqoY
	D2f7g4liCfZQASe9vS5LgR1B2w=; b=JdRwMbazrA9/vK9GRhK7N04hQ7vhDD5Wk
	SOsgdi8/+3iwcukTgWjGhglCIiOUV3HjrxC336+RgvycpuoqBNPvUDO3mMmZSAkj
	AtxAQzKSCtgRKeMSZff4khVsfBU0Tmtj76eDi8MB3iiJDnDAuKzGyG7JyuajwZwu
	hn59CpmI7SjVZlxesO8lpCX4qGeBM4eZPbiDHvTEXD6fmUa6RIQywhpHMRDVStaS
	D4Jp6Oopa7dKgxPLXWGiCkNPtzaku13cJgcAwhCcAKAkvx36SDoq9PGPXvTryBZb
	NtRdzFJZ9VdwRKxC94NaAXmkOjKEPgpENk7Obma5GZM2bTyRnS+sg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt2ceh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LYqoW804989;
	Mon, 9 Nov 2026 23:56:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvvhpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nuoej41156872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DB205805D;
	Mon,  9 Nov 2026 23:56:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D47358059;
	Mon,  9 Nov 2026 23:56:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:47 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 09/15] ibmveth: Split RX poll into per-slot helpers for MQ
Date: Mon,  9 Nov 2026 15:55:50 -0800
Message-Id: <20261109235556.60604-10-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXzytDCVZhvR5/
 geCsMTAAxazRtRocFtam6teuCkrQw8D1lhDqP69LnBhyMR2zfgJm782pFh295tj+uii7/0oKLFG
 8/Bjnqcw0MCRVQY8jCdvIv4PoyzgoJyQMdLXh436/WO/1tsDSUaZvHrY2ymWgeW34kH9QDX48gN
 z6IqvYQhG1vaWC9OFTBJ12f6/QkV8IDbLJ6vQbutwnwY0nfKovQU4YhWz1JeTY0Q+lbybUk+3cN
 VKGLrFVq93vpiNyrPUa3JiWKgpFeCPjoV/vw66JGC4eYjMUW57Ogdcsq2moJn1IGWZZq+5IZ6pQ
 4kTeMA/Ed5j1S3jIJEZMyHdN269n/wb67XKU+3eU9FGUxQPSfiOXXMWhLrdgEw5Y/FtDfSNrgnL
 C+SfWcbUX5YB7I1yZEGyPZcMGz1FgJRwEU5Bo1QFoJNNkRb9IicIvqkJbcYgJzbWm4UqKEgyLto
 QkA4zTZYHAcm+oMhW0A==
X-Proofpoint-ORIG-GUID: Py12PQAy8QVoaMfPtqPLIyM_0id4xsgK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXycVvxA7uvHYt
 daTNU9bXNFWY0AFMFb97RK2mzzj8rt2pts4G6Gn+K1cQPNkTt6Udt5/qg8sh81k3wnSbGikgkJO
 qWskOV76iOhKVL2jCNig3QJOU4f3bJI=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af25dc6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=iQ-tVgl2pCaVilusPSoA:9
X-Proofpoint-GUID: aj0m2vHq3DPwAd7vtgrRZJwMlQu1SaRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Multi-queue RX needs two things from ibmveth_poll() that
single-queue never did. Resize disables one queue's NAPI while
the device stays up, so poll must stop consuming the ring and
not re-arm PHYP once a disable is pending. A NAPI whose index is
past the queue count must never be polled (napi_disable() keeps
netpoll away from it), so poll warns, completes it and returns
rather than touch a queue that may be gone.

Adding those checks inline would make the NAPI callback a deeply
nested switchyard. Split each slot outcome into a small helper,
moving the checks net-next already has (correlator bound, frame
bound, header checks) with it, so ibmveth_poll() stays a thin
budget loop:

  ibmveth_poll_stopping()
  ibmveth_poll_recycle_invalid() / skip_bad_correlator()
  ibmveth_poll_drop_oversize()
  ibmveth_poll_deliver_frame()
  ibmveth_poll_bump_invalid()

Not pure motion. ibmveth_poll_bump_invalid() still counts only the
slots PHYP marks invalid, so rx_invalid_buffer keeps its meaning;
bad-correlator and oversize frames count in rx_dropped. Deliver keeps
the frame bound from commit c9b95adc755f ("ibmveth: step past bad RX
correlators instead of spinning or oopsing"): a PHYP
offset+length beyond min(skb_tailroom, pool->buff_size) is dropped;
skb_tailroom is the skb_put bound, the DMA map is pool->buff_size.
A slot skipped for a bad correlator or an oversize frame counts against
the NAPI budget like a delivered frame, so a run of them cannot keep
one poll going. Recycling a slot PHYP marked invalid stays outside the
budget unless its harvest fails, as before.

deliver_frame() and recycle_invalid() each read the RX-ring correlator
once with ibmveth_rxq_read_correlator() (previous patch) and pass that
value through get_buffer(), the room check and harvest, as poll did
before.

mss becomes a local of deliver_frame() rather than living across
ibmveth_poll()'s whole budget loop; it was never read stale, because
ibmveth_rx_mss_helper() only uses it under lrg_pkt, so that part is
scoping hygiene and not a fix.

rxq_get_buffer() becomes a plain lookup on that correlator and no
longer reports. skip_bad_correlator escalates to reset, and
rxq_harvest_correlator() (the previous patch's rxq_harvest_buffer(),
renamed) still logs and resets on a bad correlator, so recycle_invalid
does too. Skipped slots and failed harvests still count in rx_dropped,
and a failed copybreak harvest still frees new_skb. A bad-correlator
or oversize slot does not end the loop: poll advances and continues.
A failed harvest of a frame being delivered does end it, without
consuming budget. The lookup has just found that buffer and nothing
changes the pool before the harvest at this commit, so the check is
defensive; the harvest has already advanced the ring. The poll tail
masks then schedules NAPI like schedule_rx_queue().

Poll stops consuming the ring once the device is down or a
napi_disable() is pending (close today; live resize removes a queue
in a later patch), so frames still pending when the device goes down
are not delivered.
The check after napi_complete_done() narrows a PHYP re-arm during
close; teardown does not rely on it, since cleanup_rx_interrupts()
waits for the poll tail and masks again.
If poll is stopping with the budget used up, it returns the budget
without completing NAPI, which the core still owns at that point.
Runtime is still single-queue: helpers are defined and called from the
existing SQ poll path in this same patch (first use). The next patch
turns on MQ and reuses this loop; that MQ enable work stays in the
following commit.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- bad-correlator and oversize slots count rx_dropped (not
  rx_invalid_buffer) and consume budget
- a failed invalid-slot recycle consumes budget, as in net-next
- a poll that stops with its budget used returns budget without
  completing NAPI
- rxq_harvest_buffer() is renamed rxq_harvest_correlator() and takes
  the correlator poll read
- deliver_frame() adopts net-next's frame bound and header checks
  (ETH_HLEN, skb_headlen(), mss helper result)
- deliver_frame() kdoc: 0 means the slot was consumed without delivery
  (skipped or dropped); drop a dead flush_work() in the get_buffer
  KUnit test

Dropped from this series (merged fixes own them):
- commit c9b95adc755f: duplicate copybreak/NULL-skb hunks and message
  paragraphs (in base; deliver_frame keeps the frame bound)

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

 drivers/net/ethernet/ibm/ibmveth.c | 435 +++++++++++++++++------------
 1 file changed, 259 insertions(+), 176 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a1f286b37eff..b12bfa1e485e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1414,33 +1414,29 @@ static u64 ibmveth_rxq_read_correlator(struct ibmveth_adapter *adapter,
 	return READ_ONCE(rxq->queue_addr[rxq->index].correlator);
 }
 
-/* get the buffer for @correlator, read once from the current rx queue entry */
+/* Get the buffer behind @correlator. Does not report a bad correlator:
+ * the harvest of that slot does, after re-checking it under the lock.
+ */
 static struct sk_buff *
 ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 		       int queue_index, u64 correlator)
 {
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
-	struct sk_buff *skb;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
-		ibmveth_rxq_bad_correlator(adapter, correlator);
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
-	}
 
-	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
-	if (!skb)
-		ibmveth_rxq_no_skb(adapter, correlator);
-	return skb;
+	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
 
 /**
- * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
+ * ibmveth_rxq_harvest_correlator - Harvest buffer from a known correlator
  *
  * @adapter: pointer to adapter
  * @queue_index: RX queue index to harvest from
- * @correlator: correlator of the current rx queue entry, as read by poll
  * @reuse:   whether to reuse buffer
+ * @correlator: pool and index already read from this slot
  *
  * Context: called from ibmveth_poll
  *
@@ -1455,15 +1451,16 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
  * * other - non-zero return from ibmveth_remove_buffer_from_pool; ring has
  *           still been advanced for -EINVAL/-EFAULT
  */
-static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				      int queue_index, u64 correlator,
-				      bool reuse)
+static int ibmveth_rxq_harvest_correlator(struct ibmveth_adapter *adapter,
+					  int queue_index, bool reuse,
+					  u64 correlator)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	int rc;
 
 	rc = ibmveth_remove_buffer_from_pool(adapter, correlator, queue_index,
 					     reuse);
-	ibmveth_rxq_advance(&adapter->rx_queue[queue_index]);
+	ibmveth_rxq_advance(rxq);
 	if (unlikely(rc == -EFAULT))
 		ibmveth_rxq_no_skb(adapter, correlator);
 	else if (unlikely(rc))
@@ -2512,154 +2509,226 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	skb->ip_summed = CHECKSUM_NONE;
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
+/* Return: true if the harvest failed; that slot then consumes budget. */
+static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
+					 struct ibmveth_adapter *adapter,
+					 int queue_index)
+{
+	u64 correlator = ibmveth_rxq_read_correlator(adapter, queue_index);
+	int rc;
+
+	netdev_dbg(netdev, "recycling invalid buffer\n");
+	ibmveth_poll_bump_invalid(adapter, queue_index);
+	rc = ibmveth_rxq_harvest_correlator(adapter, queue_index, true,
+					    correlator);
+	if (unlikely(rc))
+		netdev->stats.rx_dropped++;
+	return rc;
+}
+
+static void ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
+					     struct ibmveth_adapter *adapter,
+					     int queue_index, u64 correlator)
+{
+	/* Stale or corrupt slot: recover via reset rather than spinning
+	 * forever. Always escalate, even if the harvest below succeeds;
+	 * the harvest logs the correlator when it fails.
+	 */
+	schedule_work(&adapter->work);
+	netdev->stats.rx_dropped++;
+	ibmveth_rxq_harvest_correlator(adapter, queue_index, true, correlator);
+}
+
+static void ibmveth_poll_drop_oversize(struct net_device *netdev,
+				       struct ibmveth_adapter *adapter,
+				       int queue_index, unsigned int off,
+				       unsigned int len, unsigned int room,
+				       u64 correlator)
+{
+	if (net_ratelimit())
+		netdev_err(netdev,
+			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
+			   off, len, room, queue_index);
+	netdev->stats.rx_dropped++;
+	ibmveth_rxq_harvest_correlator(adapter, queue_index, true, correlator);
+}
+
+/**
+ * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
+ * @napi: NAPI context for this RX queue
+ * @adapter: ibmveth adapter
+ * @netdev: net_device for @adapter
+ * @queue_index: RX queue index
+ *
+ * Return: 1 frame delivered, 0 if slot consumed without delivery (skipped
+ * or dropped), -1 on error.
+ */
+static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
+				      struct ibmveth_adapter *adapter,
+				      struct net_device *netdev,
+				      int queue_index)
+{
+	struct sk_buff *skb, *new_skb;
+	unsigned int room, off, len, pool;
+	struct ibmveth_buff_pool *bpool;
+	int length, offset, csum_good, lrg_pkt;
+	__sum16 iph_check = 0;
+	u16 mss = 0;
+	u64 correlator;
+	int rc;
+
+	length = ibmveth_rxq_frame_length(adapter, queue_index);
+	offset = ibmveth_rxq_frame_offset(adapter, queue_index);
+	csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
+	lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
+
+	correlator = ibmveth_rxq_read_correlator(adapter, queue_index);
+	skb = ibmveth_rxq_get_buffer(adapter, queue_index, correlator);
+	if (unlikely(!skb)) {
+		ibmveth_poll_skip_bad_correlator(netdev, adapter, queue_index,
+						 correlator);
+		return 0;
+	}
+
+	pool = correlator >> 32;
+	bpool = &adapter->rx_buff_pool[queue_index][pool];
+	room = min_t(unsigned int, skb_tailroom(skb),
+		     bpool->buff_size);
+	off = offset;
+	len = length;
+	if (unlikely(len < ETH_HLEN || off >= room ||
+		     len > room - off)) {
+		ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
+					   off, len, room, correlator);
+		return 0;
+	}
+
+	if (lrg_pkt) {
+		/* if the large packet bit is set in the rx queue
+		 * descriptor, the mss will be written by PHYP eight
+		 * bytes from the start of the rx buffer, which is
+		 * skb->data at this stage
+		 */
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
+		rc = ibmveth_rxq_harvest_correlator(adapter, queue_index, true,
+						    correlator);
+		if (unlikely(rc)) {
+			dev_kfree_skb_any(new_skb);
+			netdev->stats.rx_dropped++;
+			return -1;
+		}
+		skb = new_skb;
+	} else {
+		rc = ibmveth_rxq_harvest_correlator(adapter, queue_index,
+						    false, correlator);
+		if (unlikely(rc)) {
+			netdev->stats.rx_dropped++;
+			return -1;
+		}
+		skb_reserve(skb, offset);
+	}
+
+	skb_put(skb, length);
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	if (skb->protocol == cpu_to_be16(ETH_P_IP) &&
+	    skb_headlen(skb) >= sizeof(struct iphdr)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		iph_check = iph->check;
+	}
+
+	/* PHYP without PLSO support places a -1 in the ip
+	 * checksum for large send frames.
+	 */
+	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
+	    iph_check == 0xffff) {
+		if (!ibmveth_rx_mss_helper(skb, mss, lrg_pkt))
+			csum_good = 0;
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
-	int queue_index;
-	u64 correlator;
-	u16 mss = 0;
-	int rc;
+	int queue_index, rc;
 
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
 	while (frames_processed < budget) {
+		if (ibmveth_poll_stopping(netdev, napi))
+			break;
+
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
-		correlator = ibmveth_rxq_read_correlator(adapter, queue_index);
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
-			netdev_dbg(netdev, "recycling invalid buffer\n");
-			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
-							correlator, true);
-			if (unlikely(rc)) {
-				netdev->stats.rx_dropped++;
+			if (ibmveth_poll_recycle_invalid(netdev, adapter,
+							 queue_index))
 				frames_processed++;
-				continue;
-			}
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
-			unsigned int pool, room, off, len;
-			struct ibmveth_buff_pool *bpool;
-			struct ibmveth_rx_q *rxq;
-			__sum16 iph_check = 0;
-
-			skb = ibmveth_rxq_get_buffer(adapter, queue_index,
-						     correlator);
-			if (unlikely(!skb)) {
-				rxq = &adapter->rx_queue[queue_index];
-				ibmveth_rxq_advance(rxq);
-				netdev->stats.rx_dropped++;
-				frames_processed++;
-				continue;
-			}
-
-			pool = correlator >> 32;
-			bpool = &adapter->rx_buff_pool[queue_index][pool];
-			room = min_t(unsigned int, skb_tailroom(skb),
-				     bpool->buff_size);
-			off = offset;
-			len = length;
-			if (unlikely(len < ETH_HLEN || off >= room ||
-				     len > room - off)) {
-				if (net_ratelimit())
-					netdev_err(netdev,
-						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
-						   off, len, room);
-				ibmveth_rxq_harvest_buffer(adapter, queue_index,
-							   correlator, true);
-				netdev->stats.rx_dropped++;
-				frames_processed++;
-				continue;
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
-								correlator,
-								true);
-				if (unlikely(rc)) {
-					dev_kfree_skb_any(new_skb);
-					netdev->stats.rx_dropped++;
-					frames_processed++;
-					continue;
-				}
-				skb = new_skb;
-			} else {
-				rc = ibmveth_rxq_harvest_buffer(adapter,
-								queue_index,
-								correlator,
-								false);
-				if (unlikely(rc)) {
-					netdev->stats.rx_dropped++;
-					frames_processed++;
-					continue;
-				}
-				skb_reserve(skb, offset);
-			}
-
-			skb_put(skb, length);
-			skb->protocol = eth_type_trans(skb, netdev);
-
-			/* PHYP without PLSO support places a -1 in the ip
-			 * checksum for large send frames.
+			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
+							queue_index);
+			if (rc < 0)
+				break;
+			/* A slot skipped for a bad correlator or an oversize
+			 * frame consumes budget too, so a run of them cannot
+			 * keep this poll going.
 			 */
-			if (skb->protocol == cpu_to_be16(ETH_P_IP) &&
-			    skb_headlen(skb) >= sizeof(struct iphdr)) {
-				struct iphdr *iph = (struct iphdr *)skb->data;
-
-				iph_check = iph->check;
-			}
-
-			if ((length > netdev->mtu + ETH_HLEN) ||
-			    lrg_pkt || iph_check == 0xffff) {
-				if (!ibmveth_rx_mss_helper(skb, mss, lrg_pkt))
-					csum_good = 0;
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
 			frames_processed++;
 		}
 	}
@@ -2670,15 +2739,30 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (budget)
 		ibmveth_replenish_task(adapter, queue_index);
 
+	/* At full budget the NAPI core still owns the instance and
+	 * completes it itself if a disable is pending.
+	 */
+	if (ibmveth_poll_stopping(netdev, napi)) {
+		if (budget && frames_processed < budget)
+			napi_complete_done(napi, frames_processed);
+		return frames_processed;
+	}
+
 	if (frames_processed == budget)
 		goto out;
 
 	if (!napi_complete_done(napi, frames_processed))
 		goto out;
 
-	/* We think we are done - reenable interrupts,
-	 * then check once more to make sure we are done.
+	/*
+	 * Narrows the window in which enable_irq() re-arms PHYP for a
+	 * queue that close() is tearing down. It is not a barrier:
+	 * napi_disable() does not wait for this tail, so teardown waits
+	 * for it with synchronize_net() and then remasks.
 	 */
+	if (ibmveth_poll_stopping(netdev, napi))
+		goto out;
+
 	rc = ibmveth_enable_irq(adapter, queue_index);
 	if (rc) {
 		netdev_err(netdev,
@@ -2688,8 +2772,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		goto out;
 	}
 
-	/* Mask before queueing, as schedule_rx_queue() does: a threaded
-	 * NAPI can start polling, and unmask, as soon as it is queued.
+	/* Mask before queueing, as ibmveth_schedule_rx_queue() does: a
+	 * threaded NAPI can start polling, and unmask, as soon as it
+	 * is queued.
 	 */
 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
 	    napi_schedule_prep(napi)) {
@@ -3444,8 +3529,8 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
  * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
  * @test: pointer to kunit structure
  *
- * Tests ibmveth_rxq_get_buffer. Each NULL return also logs a ratelimited
- * netdev_err.
+ * Tests ibmveth_rxq_get_buffer. A NULL return does not log; the harvest
+ * of that slot reports it.
  *
  * Return: void
  */
@@ -3454,7 +3539,6 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	struct ibmveth_adapter *adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
 	struct sk_buff *skb = kunit_kzalloc(test, sizeof(*skb), GFP_KERNEL);
 	struct ibmveth_buff_pool *pool;
-	u64 cor;
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
@@ -3481,49 +3565,48 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 				       GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->free_map);
 
-	adapter->rx_queue[0].queue_addr[0].correlator =
-		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	cor = ibmveth_rxq_read_correlator(adapter, 0);
+	u64 correlator;
+
+	correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = correlator;
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, 0, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, correlator));
 
-	adapter->rx_queue[0].queue_addr[0].correlator =
-		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
-	cor = ibmveth_rxq_read_correlator(adapter, 0);
+	correlator = (u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
+	adapter->rx_queue[0].queue_addr[0].correlator = correlator;
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, 0, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, correlator));
 
 	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
-	adapter->rx_queue[0].queue_addr[0].correlator = (u64)2 << 32 | 0;
-	cor = ibmveth_rxq_read_correlator(adapter, 0);
+	correlator = (u64)2 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = correlator;
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, 0, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, correlator));
 
 	pool->skbuff[0] = skb;
-	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
-	cor = ibmveth_rxq_read_correlator(adapter, 0);
+	correlator = (u64)0 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = correlator;
 	KUNIT_EXPECT_PTR_EQ(test, skb,
-			    ibmveth_rxq_get_buffer(adapter, 0, cor));
-
-	flush_work(&adapter->work);
+			    ibmveth_rxq_get_buffer(adapter, 0, correlator));
 }
 
 /**
- * ibmveth_rxq_harvest_buffer_test - unit test for ibmveth_rxq_harvest_buffer
+ * ibmveth_rxq_harvest_correlator_test - unit test for
+ * ibmveth_rxq_harvest_correlator
  * @test: pointer to kunit structure
  *
  * A bad correlator must still advance the RX ring, wrapping and flipping
- * the toggle at the end. This covers the harvest path; the advance after
- * ibmveth_rxq_get_buffer() fails in ibmveth_poll() is not tested here.
+ * the toggle at the end. Poll's skip of a slot whose
+ * ibmveth_rxq_get_buffer() fails advances through the same function.
  *
  * Return: void
  */
-static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
+static void ibmveth_rxq_harvest_correlator_test(struct kunit *test)
 {
 	struct ibmveth_adapter *adapter;
 	struct ibmveth_buff_pool *pool;
-	u64 cor;
 	int ret;
+	u64 cor;
 
 	adapter = kunit_kzalloc(test, sizeof(*adapter), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter);
@@ -3560,13 +3643,13 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 	adapter->rx_queue[0].queue_addr[1].correlator = (u64)0 << 32 | 0;
 
 	cor = ibmveth_rxq_read_correlator(adapter, 0);
-	ret = ibmveth_rxq_harvest_buffer(adapter, 0, cor, true);
+	ret = ibmveth_rxq_harvest_correlator(adapter, 0, true, cor);
 	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
 	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].index);
 	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].toggle);
 
 	cor = ibmveth_rxq_read_correlator(adapter, 0);
-	ret = ibmveth_rxq_harvest_buffer(adapter, 0, cor, true);
+	ret = ibmveth_rxq_harvest_correlator(adapter, 0, true, cor);
 	KUNIT_EXPECT_EQ(test, -EFAULT, ret);
 	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].index);
 	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].toggle);
@@ -3802,7 +3885,7 @@ static void ibmveth_rx_csum_helper_test(struct kunit *test)
 static struct kunit_case ibmveth_test_cases[] = {
 	KUNIT_CASE(ibmveth_remove_buffer_from_pool_test),
 	KUNIT_CASE(ibmveth_rxq_get_buffer_test),
-	KUNIT_CASE(ibmveth_rxq_harvest_buffer_test),
+	KUNIT_CASE(ibmveth_rxq_harvest_correlator_test),
 	KUNIT_CASE(ibmveth_rx_mss_helper_test),
 	KUNIT_CASE(ibmveth_rx_csum_helper_test),
 	{}
-- 
2.50.1 (Apple Git-155)


