Return-Path: <linuxppc-dev+bounces-25457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8935C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 22:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFlpg2WPBz2yFP;
	Thu, 06 Aug 2026 08:44:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785969883;
	cv=none; b=GSVEz6TPRtonMzaKqTKhux14E6RziS2aSH+gm0pxXmFcrrqaw3/KqC3k50dC1lwffkNqXYLObiNc6pZDQr62ZslMkUwFqnDPRFntH5v6LcqqXrtT6X/3CyN/kfQgJgkVE4VsBQS7i0QZZihFi1D1H/7IXQcO8ZiSBlgt7zmd0q+7xr07N6IOcL+79y4G11dmdyEVUpOpYvVMqDjrTQQqJEePQGqtoU0O1u58eYiTf5f8S8sNriK0wj9eFdrGSPRzXadEJ3n4R5VlBJBjhz4iI+klgK/Yc0PVobUDEm74NU+OGAhto6LgnhpNn4m7NcMaGuqMb/1c842WMesBBfQjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785969883; c=relaxed/relaxed;
	bh=Fjg6ka5Dn7iDM5BCZStyd3kQGt6PDnZGoGcX+SA5/5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFOExB+8Zwlh5cAZMqYP9M3xqrIwbKQw2T6nhiPIPeoVSHUVi5Fr8vg9md34wkkTHKwwadXiqwZp1s+excGnK1jzFmFn2YVO4Me67KaQh2H1EfILci+AJ/3yge8D1hshMuFO3oeuF7dvwB9Wsw22ezoofcN4hbqEfgXztM61bqebtkOnNjAkdatCY/EZ+XA9ifdWLK71IL9KuvjPhgJQzSBPvqj/U8nuUlktAmbCyOj32hs0QlqobjNDLpgcsiBZnunOLaaL0X3hwMXjNUEo3tcJgTqHJZobe9woTXpOxpVKwa+t1ISNpFmyM09I+czVXU2AEfq1YJ2aC/GQxoLtNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AiyVtyfB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AiyVtyfB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFlpf3qSWz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 08:44:42 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Hm8ff244693;
	Wed, 5 Aug 2026 22:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fjg6ka5Dn7iDM5BCZ
	Styd3kQGt6PDnZGoGcX+SA5/5A=; b=AiyVtyfBoqT9n0lZOnGpE6BU5DIXjlJQq
	GYdtKzXgvzdlmLi8vqWFwfR5Oj5wV3bNvZ0BVeksEbifmnju7k5tCG1KcLuW9SPA
	AhKGUTtJG45dev+QA87XEireIPvcTeHM9y3sYnD5PdiIjgehi/iyS1dgAz9IZm9w
	2ZoUWGzYlz+JaHEnR38lLp3/DjKY7fFmD3wZQV7nREQHe7vprIFzohlkHv9+WP/U
	1OaRb9SPJXvkzsEk5omdqNArTfYKVLw8acJfgUqIhT1RGD0sK5zwj+iAj9HG/zZs
	aNhgLClyq2DHDeJ1vnjVqcIRNK3VFRlC1EEGScgyv1Bgy8m9BwpFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hw4bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfFPd016549;
	Wed, 5 Aug 2026 22:44:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qrs27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiXeY36962844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69EA15805A;
	Wed,  5 Aug 2026 22:44:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 454B25805C;
	Wed,  5 Aug 2026 22:44:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:31 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 6/6] ibmvnic: change the mtu without a reset where the buffers allow it
Date: Wed,  5 Aug 2026 15:44:01 -0700
Message-Id: <20260805224401.58791-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX7mMc1mlr5isK
 fASDXgsgBrwKZZ9WLIkhlGcSz1DmEV9quOuo+O/xgePYXmMHm8mTCIs0yrDgHkhUIEag7cErZm0
 bDIZM1rPbJWDMAVtKG5HoiO0eeQH/5g=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a73bcd5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=pSfWoSSszF9U6n5C:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=XP5BPIdsy2US-nDsdGsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX2M0XksK0Jatp
 FMT67SKQmd1l25aqBd0RLrDGGNG5Fpf4KbdfrA3hoqWdoXWoTAzNucEKFB91EJ/QfDsCFEAm8To
 VnYxXcX03sJzBj5pzSvBH6RRb3oNKjqEvsXw+2Imu9JGv0w6cXW3IiYCxkE3SNcaWh5eUd7DwhN
 QHsnChO2D4qX3Fqy3ZjZv2u5ww/Y2s1o3ZVLeWHVoy7AG3jDJBB/v0qG2indiJbnQ7DGcMbsWbD
 5HaOMyL5o9ysxfjBr05fXTEKW2cwotKs2vmvsD0HqXN+zG3Bhg1z4iUtMdSCZKHcePhNsiGILDn
 eEhf36Yow/cZd9Svik48f5OBlBeUYcInu37pO9v83YGyGQ68ohwgsRNt51OdyiG592Ra6j7F+Y8
 9K7DgAfTw8IOTsYXoBpZr6XbyFqLD/gkTm56ILd4SVswFoBaM9i6OCEADQMJV8JR+kXFCVYnXZZ
 8N+gnbKwLoJwTnqT5ug==
X-Proofpoint-ORIG-GUID: 11DNsMJtVFK7BModD4gl1_WXMtJegd76
X-Proofpoint-GUID: Z9HRyOmZn2-r_mfp08E29yNEMLJa3V8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050183

With the earlier patches in this series, in-range mtus are honoured
instead of snapped to 1500 or 9000. Every such change still cycles the
adapter through wait_for_reset(), which tears down the CRQ, logs in
again and rebuilds every queue. The link goes down for around two
seconds each time, even when the change needs nothing from the VIOS.

Most of them do not. The backing device runs at one of a small set of
fixed sizes and the vnicserver reports that size when it answers
REQ_MTU, so any mtu within it is already carried end to end. Record it
as adapter->backing_mtu (set when the covering PARTIALSUCCESS path from
the honour-mtu patch accepts a request) and skip the reset when the new
mtu is within it and the tx buffers are large enough as they are, which
covers every decrease and the increases that stay inside the current
buffer size.

Both conditions are needed. Buffer sizes are rounded up to a cache
line, so buffers alone would also admit an mtu somewhat past what the
backing device carries: with a 1514 backing mtu, everything up to 1532
aligns to the same 1536-byte buffer. Those frames would leave the
partition and be dropped by a backing device still configured for the
smaller size.

An increase past backing_mtu still resets, since it has to be put to
the vnicserver rather than assumed. Whatever comes back becomes the new
backing_mtu, so if the device does move up, later changes within the
larger size settle without a reset, and if it does not, the mtu is
renegotiated down to what the device carries and the fast path keeps
measuring against the truth.

Buffers are left at their existing size on a decrease rather than
shrunk. reuse_tx_pools() compares prev_mtu against req_mtu, so the next
reset for any reason reallocates them.

Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 35 +++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmvnic.h |  1 +
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 88d0c231a74f..1d18a0e13cad 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3705,8 +3705,34 @@ out:
 static int ibmvnic_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
+	u64 new_mtu_with_hdr = new_mtu + ETH_HLEN;
+	u64 old_buff_size, new_buff_size;
+
+	if (adapter->req_mtu == new_mtu_with_hdr)
+		return 0;
+
+	old_buff_size = ALIGN(adapter->prev_mtu + VLAN_HLEN, L1_CACHE_BYTES);
+	new_buff_size = ALIGN(new_mtu_with_hdr + VLAN_HLEN, L1_CACHE_BYTES);
+
+	/* Skip the reset when backing_mtu and the current buffers already
+	 * cover the new mtu. Keep desired.mtu in sync with req_mtu.
+	 */
+	if (new_mtu_with_hdr <= adapter->backing_mtu &&
+	    new_buff_size <= old_buff_size) {
+		netdev_dbg(netdev, "mtu %u->%d without reset\n",
+			   netdev->mtu, new_mtu);
+
+		WRITE_ONCE(netdev->mtu, new_mtu);
+		adapter->req_mtu = new_mtu_with_hdr;
+		adapter->desired.mtu = new_mtu_with_hdr;
+
+		return 0;
+	}
+
+	netdev_dbg(netdev, "mtu %u->%d needs larger buffers, resetting\n",
+		   netdev->mtu, new_mtu);
 
-	adapter->desired.mtu = new_mtu + ETH_HLEN;
+	adapter->desired.mtu = new_mtu_with_hdr;
 
 	return wait_for_reset(adapter);
 }
@@ -5558,14 +5584,17 @@ static void handle_request_cap_rsp(union ibmvnic_crq *crq,
 
 	switch (crq->request_capability_rsp.rc.code) {
 	case SUCCESS:
+		if (cap == REQ_MTU)
+			adapter->backing_mtu = *req_value;
 		break;
 	case PARTIALSUCCESS:
 		rsp_value = be64_to_cpu(crq->request_capability_rsp.number);
 
-		/* Covering PARTIALSUCCESS: keep the request. Otherwise
-		 * retry with rsp_value.
+		/* Covering PARTIALSUCCESS: keep the request and record
+		 * backing_mtu. Otherwise retry with rsp_value.
 		 */
 		if (cap == REQ_MTU && rsp_value >= *req_value) {
+			adapter->backing_mtu = rsp_value;
 			netdev_dbg(adapter->netdev,
 				   "backing mtu %llu covers requested %llu\n",
 				   rsp_value, *req_value);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 4cfedae5d89d..80e1b2f6ede5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1020,6 +1020,7 @@ struct ibmvnic_adapter {
 	u64 max_mtu;
 	u64 req_mtu;
 	u64 prev_mtu;
+	u64 backing_mtu; /* mtu the backing device currently carries */
 	u64 max_multicast_filters;
 	u64 vlan_header_insertion;
 	u64 rx_vlan_header_insertion;
-- 
2.50.1 (Apple Git-155)


