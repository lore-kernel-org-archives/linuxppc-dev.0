Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0700606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dn54Yenp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJhJ71Q0z2xnQ;
	Thu, 19 Nov 2026 11:08:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046880;
	cv=none; b=obh1mKdVsCUqN9vik7mLzPF/r1mMDCHmgFXfA+1PugWqjqrLwtCoQYSfSq/O82QmBZLHV9hrj0iiu5ketEX++xoJ3H5QuLAM5osNLwffADI7SlmXRR28ARYPHSOALw3GhrG/Y0evCThC4MEalGWujss8+rhBNHThum2N0JFgSBGsBjYkfl/HrROhQF85KfhMRG8baos4e/P5mimlAKB0tkgcQjKgybl1KeIzr7CbgS6PHiWvmEJ1BYar67lRN2uYXqrYBmQozQcHw7z5fOIZxMKT2e4UV4Bu9CDLUEFW2OEW22UPIn/ofldxvnUAQc6mtgAxcM++Vr5nK4hgkxJIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046880; c=relaxed/relaxed;
	bh=D49qK1qsI5OKwfXnbMp/fXJeWlU0W8V6GQpVpknaQLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gkJ7lA7iOdCKEFjmfhLmqPuGBAz/LKCaqJ6JvGRM3N3tOrQ11QkFLJ18OORVBQn9W4Mx0/PqNDnSItTOB1/fMMC5gc7+QaD5m8LNYzWxUmtQkCianmdruvVqsxteGX34wvKWg9fhBVwecqBoHymqTG5r1zRwjleJyFNt8C1uIwWNhD3zO1RrCXZ0XBWNQaYf80czYSr1EWyZNwlgp9MD1TtYHfEJBma3ksRF20iBvWCvHTd41q7JsJEIiH8K23MzTImbj6UJbvmNZOWsF9Vno/vyPk2yj9lbP+vz7oC6ycXd9rlg4jfYUsMo5mHJ7YBd1vhLbJgYw5DU8WtX6D2Whw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dn54Yenp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dn54Yenp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJhH6Lttz2yQl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:59 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQL0o583347;
	Thu, 19 Nov 2026 00:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D49qK1qsI5OKwfXnb
	Mp/fXJeWlU0W8V6GQpVpknaQLY=; b=dn54YenpF5n0HRkvm7pWbOFpl+WHOjcIl
	TujpMO9vGchbbWyVL8b4j6q8o9lsee9NR+84t8dVH59l8CA0fVFctYingj4eBPE3
	pea0tI6oMw6pY6qTQhvikZj1Kqu4RyfPKr1xzeEGodtUqxYI5kyqpwa71KRoqyd9
	lnKU1OQu0zHDBalqw3mPsgnxYWl6kaLmVscgvDZbLhIoM2qO2nz354HDlgZDnNlA
	5Xhw8jZ2PrC543vXuJFzzqDG1QglATWWDTOryEWgaTWKTO5l5FCYplhbtavGMWmh
	SRN8LW8KC0WmzBLtKirCoT+h6YhGVpzrpr9QP7+lpvbjQjRjw3YLQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rn9ns-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK5ef3990099;
	Thu, 19 Nov 2026 00:07:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6s17n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07lWl28705302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F90658051;
	Thu, 19 Nov 2026 00:07:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7232F5805A;
	Thu, 19 Nov 2026 00:07:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:44 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 8/8] ibmveth: Split RX poll into per-slot helpers for MQ
Date: Wed, 18 Nov 2026 16:07:11 -0800
Message-Id: <20261119000711.18093-9-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: Qh9uUwBeAn2AZSKtIE-J0mJYoNR01MEG
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afe3dd6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MGlliSgDEa_joRyuWpQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX8HVQlLUJvVgT
 FoH4Uf2pTnc6jEAM/ZDm70Pn5GvknwgCtZM8svIM8KxgViw8CbaUWH7C98tARe0Fy1TsSHWN0S/
 5+Sd6YRNOcAwwTkD0X4GpITJvapc47A=
X-Proofpoint-ORIG-GUID: 9dx9Qi1qvsh5xm1vnJZB8GUrcx6Wo7Fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX0/qvRt7RjRe7
 eutQLzaDQ05/+PycK9ektoJJay+lgxeYC07Uq4lhwCCp7e6IkKwQmmJkiGuz6Gggrf7eBJBhCio
 1PNW8BpYISkoO8/Ytf13T95lbUw59H+irqd+LtSN3AIFEHwFvPnkDikCrPRXOw2GNIkJhu7tTno
 YcPf8i8ZPeGQOBcWQAoX4jECdkEusosNwnX8Va0ZydFuxbhTOi6sTdoD5jZxz6iqsBklXrYLO7D
 NDULKPCNyXnAKPjdvyznO9hwhdCpO10iGFFag+Pf3xSJbEEdz/i4Zwk1seUbOCnEqhWQeRgMaK1
 hTFtCGg2CtaMwWkUPWbsk8CTSuRwgLNg36aal9GUpFn6kHUU2pvLgEnwv+R+eCOYsF09dJAb32d
 WnV3aDg4h5iMVssC5c8cds4Kdityo9++kbnV6P6ofwKCQ6OZEaeBtB+4xm7oTLDXDZKiQ7SqiOx
 +4At0iwjZfxzQJeqAyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180088
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the invalid-slot recycle, the oversize-frame drop and frame
delivery out of ibmveth_poll() into helpers. The bad-frame message now
names the queue. Otherwise no behavior change.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 272 ++++++++++++++++-------------
 1 file changed, 147 insertions(+), 125 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a40d9a6abf51..a36dafb8e893 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1995,6 +1995,148 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
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
+static void ibmveth_poll_drop_oversize(struct net_device *netdev,
+				       struct ibmveth_adapter *adapter,
+				       int queue_index, unsigned int off,
+				       unsigned int len, unsigned int room,
+				       u64 correlator)
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
+		ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
+					   off, len, room, correlator);
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
@@ -2002,7 +2144,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	int frames_processed = 0;
 	int queue_index;
 	u64 correlator;
-	u16 mss = 0;
 	int rc;
 
 	queue_index = napi - adapter->napi;
@@ -2015,132 +2156,13 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
-- 
2.50.1 (Apple Git-155)


