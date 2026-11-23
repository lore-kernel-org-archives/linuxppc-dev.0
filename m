Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269E60A2628
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AKar9Jd6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXypS39kGz3bmQ;
	Mon, 23 Nov 2026 18:52:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420352;
	cv=none; b=KHdaTrk/iknxk8EB7i1cj7C9nBLFC2E1FiPKrbIbFPssl4IIFTOmxTdx1wcIdMzVFwBgfE5Pz09NFzA79D69ZXoC6rlWDJyMSFiP76kNLgskntN1rhTBldPEj0aXb7I+mQJGDTaC3OkqqzWHE3hcljEIzXPIEtaUT+zjVk73S7vPjp90JmGJNt+cgIRbZOVRT92rcePO5391P32i1ELFEGs9xQ6iI6qzFSYZxFrm2/ojHwrGI2oymPkVtgtJgTZ4ybHCa14/yqQWQkU9E6wXfnxVC7kgB4k4UY4ZP9FyqjacLBySw9PvcmazJBT5ApkkFbOhZ2vIfkLPAsl2rAHlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420352; c=relaxed/relaxed;
	bh=k2OZSvZapU6XPjozMpblWFB1dX4RrFYW2/d9yc62TH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLuSh/QcxSs8FIW3q3HUrzTBE5j+L/gBIZqn3n5FGeFGbunx3lgNz7aQC9xcJG097lDN18IiQyiyY+bGn98B1CMnr6Azl/eIdAtC03pRQrcsWiD2Hdp8L1U41Vbbok252uMA3kVg2hz3LxQiEtPg7p1n9KLr/rpcygIq7l6hi1CHloMScOKkCRFWcWg5+RMpD7YIAcr2DBBsleQhjkIlMYa3yP9Q9n7r01lAjr4cKdwwuHoYcu4jPTksRXK0eqPvVdZoHPhxN0p9tPftK0rS6y4BojBkCnxSuBFpJSMS5nUBr0pBhfR5zYX82pDrDTHzERiOnPyg3ngLttBLcBklVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AKar9Jd6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AKar9Jd6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXypQ4r1Bz3bmH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:52:30 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54gqB982060;
	Mon, 23 Nov 2026 07:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k2OZSvZapU6XPjozM
	pblWFB1dX4RrFYW2/d9yc62TH8=; b=AKar9Jd6OOFclobGL+dOFUvkJICDQ6hoQ
	JGyjaHOlMaZ5gz61QF6OVVwbv9RkONnzjnjjGvDqfFgIQ8nwKBF8Jtx00DpexxkC
	bxjF6durFtFVzC3Fq2urBIkyDHNHw/39uCd9pdRuQDV2oLKYK35/lQ+s9sno090a
	AcR1z6n4T4dAqOoxC22pMQA2aEkGumtJ72pkdLWld0OB8eP/B56dyqBkSEPLLpBZ
	js/uLbtA2Txe2KrZkSeYN9kA7RGnOusaP4340shdfWTKvFoBAwMnwKWD82EvsDao
	3fT1Fd7lxfDiFGCawnN6B48LuehSw/2BFq/lS4Fvh6piBGQcgp0rA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g323b7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:52:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54LDb1346475;
	Mon, 23 Nov 2026 07:52:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqe15s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:52:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7q8R726477122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:52:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE095803F;
	Mon, 23 Nov 2026 07:52:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B02858056;
	Mon, 23 Nov 2026 07:52:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:52:06 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 8/8] ibmveth: Split RX poll into per-slot helpers for MQ
Date: Sun, 22 Nov 2026 23:51:36 -0800
Message-Id: <20261123075136.3278-9-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261123075136.3278-1-mmc@linux.ibm.com>
References: <20261123075136.3278-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b03f0ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ArBf14yY4tDaRipgUXMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX3mc5kK0cArU7
 VCoDAyVttf2xqSwByBoWQ5L/x/Tchdd3yOFWgJk+HCgXOfLqUJbU7z1yIEfYlJuOZiD2mxXW7ix
 bY0Od8bwfJnEtNomyCuqedZwgbQJoGM=
X-Proofpoint-ORIG-GUID: WY9XT-izS7mmJ1wu61-E9olc82PNwKjx
X-Proofpoint-GUID: fZYKPM6CwKiie6D3XwHJEco9a8rbMGcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX3Nt/EKzOM6V+
 +HmeE3A9AVxgyAXeyV+ZHbqTGa+kIisX9IrqQQ9cE2whwldNxVe22n5hV16LMjZjr3CWMGqpMHN
 HShpRFDxKX4B6wYXKcZPanjw4Kx8VO1HyT2AMExkPGLz1BxwyiOAjXYd/wODdVSD7rRl93HVqGI
 2ItJi3gm9jrKH+klEdh0HtaJ0v/RYMn7SNOMb65uqUfMwCi7xuwVKYty8n/hNNaGtw+egDKJaZl
 I90rQJ28rS6en61+w+uKvwNDBrb1kQroLQF4NahgLNjr/YzBFwwx4NunrA7mCbFJf+v8OgG7xyE
 N9QGuPzbm/e/KLWewGBX3d/Gcm81pskLXZmZaQ6AD9X3KjEEgqS4IPdAgacUia508ZnwvJv0uJ9
 yi0JtWrqpLGVcbTCPKes5mKlgE1rBgiHIlCXAgdiHarxWSdYkjw4avZeKwH2G/rP0bsBmdj070F
 JNjueKp0M5aw1zj7QHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the invalid-slot recycle, the bad-frame drop and frame delivery
out of ibmveth_poll() into helpers. The bad-frame message now names
the queue. Otherwise no behavior change.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- rename ibmveth_poll_drop_oversize() to ibmveth_poll_drop_bad_frame()
  (Sashiko)
- fix two comments that still named ibmveth_poll() (Sashiko)

 drivers/net/ethernet/ibm/ibmveth.c | 277 ++++++++++++++++-------------
 1 file changed, 150 insertions(+), 127 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 820b75e5fadd..e10d1e4c689c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1012,7 +1012,7 @@ static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter,
  * @correlator: correlator of the current rx queue entry, as read by poll
  * @reuse:      whether to reuse buffer
  *
- * Context: called from ibmveth_poll
+ * Context: NAPI poll, from the per-slot RX helpers
  *
  * The ring advances even on error, so poll does not return to a bad
  * slot before the scheduled reset can run.
@@ -1994,6 +1994,148 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	skb->ip_summed = CHECKSUM_NONE;
 }
 
+/* Returns true if the slot could not be recycled; poll then counts it
+ * against the budget.
+ */
+static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
+					 struct ibmveth_adapter *adapter,
+					 int queue_index, u64 correlator)
+{
+	int rc;
+
+	adapter->rx_invalid_buffer++;
+	netdev_dbg(netdev, "recycling invalid buffer\n");
+	rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, correlator,
+					true);
+	if (unlikely(rc))
+		netdev->stats.rx_dropped++;
+	return rc;
+}
+
+static void ibmveth_poll_drop_bad_frame(struct net_device *netdev,
+					struct ibmveth_adapter *adapter,
+					int queue_index, unsigned int off,
+					unsigned int len, unsigned int room,
+					u64 correlator)
+{
+	if (net_ratelimit())
+		netdev_err(netdev,
+			   "bad RX frame offset %u length %u (buffer %u) on queue %d, dropping\n",
+			   off, len, room, queue_index);
+	ibmveth_rxq_harvest_buffer(adapter, queue_index, correlator, true);
+	netdev->stats.rx_dropped++;
+}
+
+/**
+ * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
+ * @napi: NAPI context for this RX queue
+ * @adapter: ibmveth adapter
+ * @netdev: net_device for @adapter
+ * @queue_index: RX queue index
+ * @correlator: correlator of the current rx queue entry, as read by poll
+ */
+static void ibmveth_poll_deliver_frame(struct napi_struct *napi,
+				       struct ibmveth_adapter *adapter,
+				       struct net_device *netdev,
+				       int queue_index, u64 correlator)
+{
+	int length = ibmveth_rxq_frame_length(adapter, queue_index);
+	int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
+	int csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
+	int lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
+	unsigned int pool, room, off, len;
+	struct ibmveth_buff_pool *bpool;
+	struct sk_buff *skb, *new_skb;
+	__sum16 iph_check = 0;
+	u16 mss = 0;
+	int rc;
+
+	skb = ibmveth_rxq_get_buffer(adapter, queue_index, correlator);
+	if (unlikely(!skb)) {
+		ibmveth_rxq_advance(adapter, queue_index);
+		netdev->stats.rx_dropped++;
+		return;
+	}
+
+	pool = correlator >> 32;
+	bpool = &adapter->rx_buff_pool[queue_index][pool];
+	room = min_t(unsigned int, skb_tailroom(skb), bpool->buff_size);
+	off = offset;
+	len = length;
+	if (unlikely(len < ETH_HLEN || off >= room || len > room - off)) {
+		ibmveth_poll_drop_bad_frame(netdev, adapter, queue_index,
+					    off, len, room, correlator);
+		return;
+	}
+
+	/* if the large packet bit is set in the rx queue
+	 * descriptor, the mss will be written by PHYP eight
+	 * bytes from the start of the rx buffer, which is
+	 * skb->data at this stage
+	 */
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
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
+						correlator, true);
+		if (unlikely(rc)) {
+			dev_kfree_skb_any(new_skb);
+			netdev->stats.rx_dropped++;
+			return;
+		}
+		skb = new_skb;
+	} else {
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
+						correlator, false);
+		if (unlikely(rc)) {
+			netdev->stats.rx_dropped++;
+			return;
+		}
+		skb_reserve(skb, offset);
+	}
+
+	skb_put(skb, length);
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	/* PHYP without PLSO support places a -1 in the ip
+	 * checksum for large send frames.
+	 */
+	if (skb->protocol == cpu_to_be16(ETH_P_IP) &&
+	    skb_headlen(skb) >= sizeof(struct iphdr)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		iph_check = iph->check;
+	}
+
+	if ((length > netdev->mtu + ETH_HLEN) ||
+	    lrg_pkt || iph_check == 0xffff) {
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
+	napi_gro_receive(napi, skb);	/* send it up */
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += length;
+}
+
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct net_device *netdev = napi->dev;
@@ -2001,7 +2143,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	int frames_processed = 0;
 	int queue_index;
 	u64 correlator;
-	u16 mss = 0;
 	int rc;
 
 	queue_index = napi - adapter->napi;
@@ -2014,132 +2155,13 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		correlator = ibmveth_rxq_correlator(adapter, queue_index);
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
-			netdev_dbg(netdev, "recycling invalid buffer\n");
-			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
-							correlator, true);
-			if (unlikely(rc)) {
-				netdev->stats.rx_dropped++;
+			if (ibmveth_poll_recycle_invalid(netdev, adapter,
+							 queue_index,
+							 correlator))
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
-			__sum16 iph_check = 0;
-
-			skb = ibmveth_rxq_get_buffer(adapter, queue_index,
-						     correlator);
-			if (unlikely(!skb)) {
-				ibmveth_rxq_advance(adapter, queue_index);
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
-						length + offset);
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
-			 */
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
+			ibmveth_poll_deliver_frame(napi, adapter, netdev,
+						   queue_index, correlator);
 			frames_processed++;
 		}
 	}
@@ -2964,7 +2986,8 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
  *
  * A bad correlator must still advance the RX ring, wrapping and flipping
  * the toggle at the end. This covers the harvest path; the advance after
- * ibmveth_rxq_get_buffer() fails in ibmveth_poll() is not tested here.
+ * ibmveth_rxq_get_buffer() fails in ibmveth_poll_deliver_frame() is not
+ * tested here.
  *
  * Return: void
  */
-- 
2.50.1 (Apple Git-155)


