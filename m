Return-Path: <linuxppc-dev+bounces-29431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFE5CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 18:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j42wR1J6bz3btP;
	Wed, 14 Oct 2026 05:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791916279;
	cv=none; b=m1HduzWWIlH9AlsUJnfqMoq1ivv7fgIIiNrxKcbwS+S20NANss6KK68rehvnSQp4dFvKtuFj5l/ULwxPQxJScSL/6LFQUiI60ICrNrRhB0w6rmzYRg2wuPdWx8iAaXj6hZF8VA35M61rHjN9fm2A0vVsk6moEh19TxmHxvjTaMXD2IoNp6mhpeLjsjN8UB+H0gHkwOKyMOJ9Wpg3/dRwxodZWz8rcIpsGLIYHED0oV8MTSSbFJaU1kNwxH23yvsjpWvENJFyCrncUZ8EwWxz7Oc5hBboIppfHe7c1M13DRpTM6UIJ2N11/wpbExxQ8oBv+ekFxJTUJMAKYWVUWyobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791916279; c=relaxed/relaxed;
	bh=2rnmBQk/OqyjgJfUfp1Qj62k6F2z1rzCN4yDoBQp2r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKgcDPLNTJdh+3ngDtmubMQ6TjN2X1N6KWKzflS7U/VM31dYDj8Q+swHafqsQlvAVjxgIOeHQcJ6V+3C5gmYXE9jStDQWbgXzaC+FXc2fZCPqxge4avv+7rX2tI4zMG7bSIWX4piPov0gRMgCDZOpS5Osqax86WJ6/CyntS1PGQ+D6UcjmPFpHnEwshoFs0AR2irAum7e3LLK2keYxkz8sRk2u0CBzTSk6oPNJr6ES0NjJvUTahGEmOqkUtZqnCvYNSntepUbX3nIuJ4fIoom/5RbTAPqAoEqNndzg/97XIRHhkkHA/fDQJCISy3jU6Sn+ZpTcv0VX8nNtW4PcpCHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V5r4/z+0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V5r4/z+0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j42wQ197Gz3btZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 05:31:17 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDp2WS150090;
	Tue, 13 Oct 2026 18:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2rnmBQk/OqyjgJfUf
	p1Qj62k6F2z1rzCN4yDoBQp2r8=; b=V5r4/z+0H6zyan+tJi5k+KwCUOnHfNUW5
	qHnrbhUqCj6/0wurkBKqsRYrELvo+81dEHlZSfB41/zjIAIbpVmFz1iPcErh2GOv
	61XSf8RMcT6bOQYQFdO9QNFGcldmwkPInK+N3Y0MbUdJa7sD9tKeBaCfE9YdCK94
	2nBavjbZ+Uu73HIcs8ZsI89qzLIP7pB7MXkhGzcbFGldVHwln0+nqYybJeT8swt9
	pP/hcAQ1MvKAavB/fywkIdpWXWCoSkNnd8Fx4WGBzA+g2Iw0JZr/UsI8AkdARsLT
	EG2DHcReXBBdp1Cpd59L99iHm8GkcSBOi9DCRjj9ntMJl1+ikubLA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhg5j8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DIFemE2709292;
	Tue, 13 Oct 2026 18:30:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h3hxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DIUPhT28115704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:30:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 670E25805C;
	Tue, 13 Oct 2026 18:30:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6B645805A;
	Tue, 13 Oct 2026 18:30:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:30:21 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, tlfalcon@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com, zdai@us.ibm.com,
        pradeeps@linux.vnet.ibm.com, ksiva@linux.vnet.ibm.com
Subject: [PATCH net-next v5 9/9] ibmveth: check headers in the RX large send and checksum helpers
Date: Tue, 13 Oct 2026 11:29:26 -0700
Message-Id: <20261013182926.30417-10-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
References: <20261013182926.30417-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX0K2n5ETzK6kS
 eGpNzU3wwtUQO3Qxm78kW5GdSq891LEN9EFLt3aT98aXPXGAn7s6vU+tIeyUp/jbfRskzO+u+jp
 +ec2PLcw3HwL7k1cbD1I1hI5sjeKOGI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX6RkBsfc36qKw
 AaOUup+uIf86QPilFyq1gyBaNdZqxpLPvJc3lB40BkjdXD+VJskZSAvQVHQppyxCoAP6vyXmIju
 lcdiA8drRcYXLc8Tl4tFal2OAk3EWddfX13kyNCH0dyANHuP8jl8FhFpyLsl5eQFVqZBh3WUxRu
 GxIekOdA9R/KLVeakX+8lhXr3Rx2NNZOJ9qff5Ql65oRo0JHdj7+xo2gL0itgarYaFAEXetMpWH
 E9mEmUrXPbSDlUZuAvsNeGxi20dKH6lSXlSR8MsbQ07D8ceO1J8t7bNB/HPGsaEF0SOkhSjilgr
 u1C5uu6V3vBLPH8PQBNyclewOfbNm5V4wSSJHSnqiO1oGr17t2OCsnSyDRD7ILPH0Pf4coCnVGi
 Oc8vg6u4PWsEgs+7wEq79Xqe+OplDadVIH2X8PldCZV3rql7rDcHUXRmlYpupabphbW8fJHXNpx
 tsZoE4d8BXAD5Y+nfhQ==
X-Proofpoint-GUID: 1DY73SGBlo2emAE4gHFnBcsZIbVp9fmi
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace78c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lnEnYHUSIB_L1mNt7_8A:9
X-Proofpoint-ORIG-GUID: L5PxvDrpgJvZSmRX-I_vF8B1_ZRkb7yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130072

ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper() trust the IP and
TCP headers of received frames, which come from another partition on
the virtual LAN.

The worst case is an IPv4 frame with ihl 0 and iph->check 0xffff: the
checksum helper calls ip_fast_csum(iph, 0), and the ppc64 version
loops ihl - 1 times on an unsigned count, reading up to 16 GiB in
softirq: a long stall, or an oops once the read leaves mapped memory.
Both helpers also read and write header fields past the end of a short
frame. The large send helper takes the segment size from the TCP
checksum field and gso_segs from a TCP header length it never checks,
and treats an IPv4 TCP fragment as a large send, which can zero two of
its bytes; the checksum helper can write a checksum into a later
fragment's payload.

The ihl problem dates from the first commit in Fixes:, the large send
helper from the second, and the checksum helper from the third.

Before using a header, check that it fits the frame, that the IPv4 ihl
is at least 5, and that an IPv4 TCP frame is not a fragment. In the
large send helper, also require a TCP doff of at least 5, TCP payload
within the IP length, and an IP length equal to the frame length:
Ethernet padding or other bytes past the IP length would otherwise
stay in a bridged or switched frame, which the stack does not trim,
and be segmented but not counted in gso_segs. Compute gso_segs from
the IP length, and keep the segment size at or above TCP_MIN_GSO_SIZE,
as virtio_net_hdr_to_skb() does since commit c27c449d455a ("virtio-net:
Ensure that TCP packets don't overflow gso_segs"), and below
GSO_BY_FRAGS, which virtio rejects. With the headers checked and
gso_segs computed, the skb is not marked SKB_GSO_DODGY, which would
also keep it from hardware TSO on the egress device.

A frame that fails a check is passed up unchanged, without the GSO
fields or CHECKSUM_UNNECESSARY, so nothing downstream trusts its
segment count or checksum. The skb is linear, so the checks use
skb_headlen(); pskb_may_pull() could reallocate the head under the
helpers' header pointers.

Add KUnit cases for both helpers: valid IPv4 and IPv6 large sends, the
segment size clamp, and refused frames. With any one of the ihl, doff,
IP length, TCP payload, fragment or clamp checks, or the checksum
helper's IPv4 options, IPv6 header or TCP header length checks,
removed, a case fails; without the checksum helper's ihl check,
ip_fast_csum() oopses on qemu.

Found by the Sashiko review of the previous version of this series and
confirmed by code inspection and the KUnit cases above. Tested with
KUnit on qemu pseries (ppc64le) and on a POWER10 LPAR with iperf3 large
sends over IPv4 and IPv6 at MTU 1500 and 9000, threaded NAPI and busy
polling, with no new drops or InCsumErrors. No kernel selftests cover
ibmveth.

Fixes: 9c7e8bc584f5 ("ibmveth: Add support for Large Receive Offload")
Fixes: 7b5967389f5a ("ibmveth: set correct gso_size and gso_type")
Fixes: 66aa0678efc2 ("ibmveth: Support to enable LSO/CSO for Trunk VEA.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v5:
- also refuse a large send whose IP length is not the frame length:
  bytes past the IP length stay in a bridged or switched frame, so
  gso_segs computed from the IP length undercounted the segments the
  egress path produces (Sashiko review of v4)
- KUnit: cover that case, and header-only IPv4 and IPv6 frames so the
  TCP payload check is still tested
- message and comment no longer say a refused frame is checked by the
  stack; bridged or switched frames are not

New in v4: the helper header checks from v3 patch 4, split out with
their own Fixes: tags.

 drivers/net/ethernet/ibm/ibmveth.c | 286 ++++++++++++++++++++++++++++-
 1 file changed, 277 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 85e176d0ed32..e9874dfedf37 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1396,8 +1396,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 }
 
-static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
+/* Returns false when the IP or TCP headers fail the checks; the frame is
+ * then left unchanged and not marked GSO.
+ */
+static bool ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
 {
+	unsigned int gso_type, ip_len;
 	struct tcphdr *tcph;
 	int offset = 0;
 	int hdr_len;
@@ -1406,28 +1410,41 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
 	if (skb->protocol == htons(ETH_P_IP)) {
 		struct iphdr *iph = (struct iphdr *)skb->data;
 
+		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5)
+			return false;
 		if (iph->protocol == IPPROTO_TCP) {
+			/* only a whole datagram has a TCP header to segment */
+			if (ip_is_fragment(iph))
+				return false;
 			offset = iph->ihl * 4;
-			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
+			ip_len = ntohs(iph->tot_len);
+			gso_type = SKB_GSO_TCPV4;
 		} else {
-			return;
+			return true;
 		}
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		struct ipv6hdr *iph6 = (struct ipv6hdr *)skb->data;
 
+		if (skb_headlen(skb) < sizeof(*iph6))
+			return false;
 		if (iph6->nexthdr == IPPROTO_TCP) {
 			offset = sizeof(struct ipv6hdr);
-			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
+			ip_len = offset + ntohs(iph6->payload_len);
+			gso_type = SKB_GSO_TCPV6;
 		} else {
-			return;
+			return true;
 		}
 	} else {
-		return;
+		return true;
 	}
 	/* if mss is not set through Large Packet bit/mss in rx buffer,
 	 * expect that the mss will be written to the tcp header checksum.
 	 */
 	tcph = (struct tcphdr *)(skb->data + offset);
+	if (skb_headlen(skb) < offset + sizeof(*tcph) || tcph->doff < 5 ||
+	    ip_len != skb_headlen(skb) || ip_len <= offset + tcph->doff * 4)
+		return false;
+	skb_shinfo(skb)->gso_type = gso_type;
 	if (lrg_pkt) {
 		skb_shinfo(skb)->gso_size = mss;
 	} else if (offset) {
@@ -1436,11 +1453,18 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
 	}
 
 	if (skb_shinfo(skb)->gso_size) {
+		/* chosen by the sending partition: at least the floor
+		 * virtio_net_hdr_to_skb() uses, and never GSO_BY_FRAGS
+		 */
+		skb_shinfo(skb)->gso_size =
+			clamp_t(u16, skb_shinfo(skb)->gso_size,
+				TCP_MIN_GSO_SIZE, GSO_BY_FRAGS - 1);
 		hdr_len = offset + tcph->doff * 4;
 		skb_shinfo(skb)->gso_segs =
-				DIV_ROUND_UP(skb->len - hdr_len,
+				DIV_ROUND_UP(ip_len - hdr_len,
 					     skb_shinfo(skb)->gso_size);
 	}
+	return true;
 }
 
 static void ibmveth_rx_csum_helper(struct sk_buff *skb,
@@ -1457,6 +1481,10 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 	if (skb_proto == ETH_P_IP) {
 		iph = (struct iphdr *)skb->data;
+		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5 ||
+		    skb_headlen(skb) < iph->ihl * 4 ||
+		    (iph->protocol == IPPROTO_TCP && ip_is_fragment(iph)))
+			goto bad_hdr;
 
 		/* If the IP checksum is not offloaded and if the packet
 		 *  is large send, the checksum must be rebuilt.
@@ -1471,6 +1499,8 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 		iph_proto = iph->protocol;
 	} else if (skb_proto == ETH_P_IPV6) {
 		iph6 = (struct ipv6hdr *)skb->data;
+		if (skb_headlen(skb) < sizeof(*iph6))
+			goto bad_hdr;
 		iphlen = sizeof(struct ipv6hdr);
 		iph_proto = iph6->nexthdr;
 	}
@@ -1493,6 +1523,8 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	if (iph_proto == IPPROTO_TCP) {
 		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
 
+		if (skb_headlen(skb) < iphlen + sizeof(*tcph))
+			goto bad_hdr;
 		if (tcph->check == 0x0000) {
 			/* Recompute TCP pseudo header checksum  */
 			tcphdrlen = skb->len - iphlen;
@@ -1510,6 +1542,13 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 			skb_reset_network_header(skb);
 		}
 	}
+	return;
+
+bad_hdr:
+	/* headers do not fit the frame, or a fragment has no whole TCP
+	 * segment; let the stack check it
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
 }
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
@@ -1624,7 +1663,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			/* PHYP without PLSO support places a -1 in the ip
 			 * checksum for large send frames.
 			 */
-			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
+			if (skb->protocol == cpu_to_be16(ETH_P_IP) &&
+			    skb_headlen(skb) >= sizeof(struct iphdr)) {
 				struct iphdr *iph = (struct iphdr *)skb->data;
 
 				iph_check = iph->check;
@@ -1632,7 +1672,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			if ((length > netdev->mtu + ETH_HLEN) ||
 			    lrg_pkt || iph_check == 0xffff) {
-				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
+				if (!ibmveth_rx_mss_helper(skb, mss, lrg_pkt))
+					csum_good = 0;
 				adapter->rx_large_packets++;
 			}
 
@@ -2508,10 +2549,237 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 	flush_work(&adapter->work);
 }
 
+KUNIT_DEFINE_ACTION_WRAPPER(ibmveth_kfree_skb, kfree_skb, struct sk_buff *);
+
+/* A TCP frame after eth_type_trans(): IP header, 20 byte TCP header and
+ * payload bytes of data, with the IP length matching the frame.
+ */
+static struct sk_buff *ibmveth_test_tcp_skb(struct kunit *test, bool ipv6,
+					    unsigned int payload)
+{
+	unsigned int iplen = ipv6 ? sizeof(struct ipv6hdr) :
+				    sizeof(struct iphdr);
+	unsigned int len = iplen + sizeof(struct tcphdr) + payload;
+	struct sk_buff *skb = alloc_skb(len, GFP_KERNEL);
+	struct tcphdr *tcph;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test,
+							   ibmveth_kfree_skb,
+							   skb));
+	skb_put_zero(skb, len);
+	if (ipv6) {
+		struct ipv6hdr *iph6 = (struct ipv6hdr *)skb->data;
+
+		skb->protocol = htons(ETH_P_IPV6);
+		iph6->version = 6;
+		iph6->nexthdr = IPPROTO_TCP;
+		iph6->payload_len = htons(len - iplen);
+	} else {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		skb->protocol = htons(ETH_P_IP);
+		iph->version = 4;
+		iph->ihl = 5;
+		iph->protocol = IPPROTO_TCP;
+		iph->tot_len = htons(len);
+	}
+	tcph = (struct tcphdr *)(skb->data + iplen);
+	tcph->doff = 5;
+	return skb;
+}
+
+/**
+ * ibmveth_rx_mss_helper_test - unit test for ibmveth_rx_mss_helper
+ * @test: pointer to kunit structure
+ *
+ * Large send frames get gso_size from the descriptor or the TCP checksum
+ * field, clamped, and gso_segs from the IP length. Frames whose headers
+ * do not fit, whose IP length is not the frame length, with no TCP
+ * payload within the IP length, or that are IPv4 fragments, are refused
+ * and left without GSO.
+ *
+ * Return: void
+ */
+static void ibmveth_rx_mss_helper_test(struct kunit *test)
+{
+	struct sk_buff *skb;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	tcph = (struct tcphdr *)(skb->data + sizeof(*iph));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, SKB_GSO_TCPV4, skb_shinfo(skb)->gso_type);
+	KUNIT_EXPECT_EQ(test, 1448, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 2, skb_shinfo(skb)->gso_segs);
+	KUNIT_EXPECT_EQ(test, 0, (__force u16)tcph->check);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 1000, 1));
+	KUNIT_EXPECT_EQ(test, 1000, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 3, skb_shinfo(skb)->gso_segs);
+
+	skb = ibmveth_test_tcp_skb(test, true, 2896);
+	tcph = (struct tcphdr *)(skb->data + sizeof(struct ipv6hdr));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, SKB_GSO_TCPV6, skb_shinfo(skb)->gso_type);
+	KUNIT_EXPECT_EQ(test, 1448, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 2, skb_shinfo(skb)->gso_segs);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 1, 1));
+	KUNIT_EXPECT_EQ(test, TCP_MIN_GSO_SIZE, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, GSO_BY_FRAGS, 1));
+	KUNIT_EXPECT_EQ(test, GSO_BY_FRAGS - 1, skb_shinfo(skb)->gso_size);
+
+	/* refused: ihl 0, doff 4, IP length past the frame. With ihl 0 the
+	 * TCP header would overlap the IP header; saddr makes its doff 5.
+	 */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->ihl = 0;
+	((struct iphdr *)skb->data)->saddr = htonl(0x50000000);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct tcphdr *)(skb->data + sizeof(*iph)))->doff = 4;
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->tot_len = htons(skb->len + 1);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+
+	/* refused: bytes past the IP length, its large send fields left
+	 * alone; gso_segs from the IP length would undercount them
+	 */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->tot_len = htons(skb->len - 100);
+	tcph = (struct tcphdr *)(skb->data + sizeof(*iph));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 1448, ntohs((__force __be16)tcph->check));
+
+	/* refused: a fragment past the first, its payload left alone */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->frag_off = htons(185);
+	tcph = (struct tcphdr *)(skb->data + sizeof(*iph));
+	tcph->check = (__force __sum16)htons(1448);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 0, 0));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+	KUNIT_EXPECT_EQ(test, 1448, ntohs((__force __be16)tcph->check));
+
+	/* refused: only Ethernet padding past the TCP header */
+	skb = ibmveth_test_tcp_skb(test, false, 6);
+	((struct iphdr *)skb->data)->tot_len = htons(40);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, true, 2896);
+	((struct ipv6hdr *)skb->data)->payload_len = 0;
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+
+	/* refused: no TCP payload, with the IP length matching the frame */
+	skb = ibmveth_test_tcp_skb(test, false, 0);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+
+	skb = ibmveth_test_tcp_skb(test, true, 0);
+	KUNIT_EXPECT_FALSE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+
+	/* not TCP: accepted and left alone */
+	skb = ibmveth_test_tcp_skb(test, false, 2896);
+	((struct iphdr *)skb->data)->protocol = IPPROTO_UDP;
+	KUNIT_EXPECT_TRUE(test, ibmveth_rx_mss_helper(skb, 1448, 1));
+	KUNIT_EXPECT_EQ(test, 0, skb_shinfo(skb)->gso_size);
+}
+
+/**
+ * ibmveth_rx_csum_helper_test - unit test for ibmveth_rx_csum_helper
+ * @test: pointer to kunit structure
+ *
+ * A large send IPv4 header checksum of 0xffff is rebuilt. Headers that
+ * do not fit the frame, an IPv4 ihl below 5, or a TCP fragment, clear
+ * CHECKSUM_UNNECESSARY instead of being read.
+ *
+ * Return: void
+ */
+static void ibmveth_rx_csum_helper_test(struct kunit *test)
+{
+	struct sk_buff *skb;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+
+	skb = ibmveth_test_tcp_skb(test, false, 100);
+	iph = (struct iphdr *)skb->data;
+	iph->check = (__force __sum16)0xffff;
+	tcph = (struct tcphdr *)(skb->data + sizeof(*iph));
+	tcph->check = (__force __sum16)htons(1);
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, 0, (__force u16)ip_fast_csum(iph, iph->ihl));
+	KUNIT_EXPECT_EQ(test, CHECKSUM_UNNECESSARY, (int)skb->ip_summed);
+
+	skb = ibmveth_test_tcp_skb(test, false, 100);
+	iph = (struct iphdr *)skb->data;
+	iph->ihl = 0;
+	iph->check = (__force __sum16)0xffff;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+	KUNIT_EXPECT_EQ(test, 0xffff, (__force u16)iph->check);
+
+	/* IPv4 options past the frame; UDP, so no TCP check follows */
+	skb = ibmveth_test_tcp_skb(test, false, 0);
+	iph = (struct iphdr *)skb->data;
+	iph->protocol = IPPROTO_UDP;
+	iph->ihl = 15;
+	iph->check = (__force __sum16)0xffff;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+
+	/* a TCP fragment past the first: header and payload left alone */
+	skb = ibmveth_test_tcp_skb(test, false, 100);
+	iph = (struct iphdr *)skb->data;
+	iph->frag_off = htons(185);
+	iph->check = (__force __sum16)0xffff;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+	KUNIT_EXPECT_EQ(test, 0xffff, (__force u16)iph->check);
+	KUNIT_EXPECT_EQ(test, 0,
+			(__force u16)((struct tcphdr *)(skb->data +
+							sizeof(*iph)))->check);
+
+	/* TCP header past the frame */
+	skb = ibmveth_test_tcp_skb(test, false, 0);
+	skb_trim(skb, sizeof(struct iphdr));
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+
+	/* IPv6 header past the frame; UDP, so no TCP check follows */
+	skb = ibmveth_test_tcp_skb(test, true, 0);
+	((struct ipv6hdr *)skb->data)->nexthdr = IPPROTO_UDP;
+	skb_trim(skb, sizeof(struct ipv6hdr) - 1);
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	ibmveth_rx_csum_helper(skb, NULL);
+	KUNIT_EXPECT_EQ(test, CHECKSUM_NONE, (int)skb->ip_summed);
+}
+
 static struct kunit_case ibmveth_test_cases[] = {
 	KUNIT_CASE(ibmveth_remove_buffer_from_pool_test),
 	KUNIT_CASE(ibmveth_rxq_get_buffer_test),
 	KUNIT_CASE(ibmveth_rxq_harvest_buffer_test),
+	KUNIT_CASE(ibmveth_rx_mss_helper_test),
+	KUNIT_CASE(ibmveth_rx_csum_helper_test),
 	{}
 };
 
-- 
2.50.1 (Apple Git-155)


