Return-Path: <linuxppc-dev+bounces-20090-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F263AFED3F0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:29:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2JMR3bZVz2yYs;
	Sat, 25 Apr 2026 02:29:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777048179;
	cv=none; b=M0/Zhaqda1JX8Ecwi4zTUkpYiWcuN74YM83QInXNibRUaWfgOugKbdg99PwpXTqRPUr63TAGvbroI+DYuxRdGV5eRYrrC1i8zouP8cZ6U7cYIao94774RHlriiRVElbQdxlK4WgJUTCtNTHQATl6IBG7dSWX7P6iCsBka2Sq95xrlCpaxjHTOrs+QinAIGOO9oKEkqlNB7m5NW01tUjTl5eMbI82YgiZ9LYx+ww6lXu0zttTIRK3d60kGA0AV0wXXkU7AFBBH24EkKP/85gQs+Ge8KeBIBH8omIF64PpiJs+L4ZYDwHERU+VZynLpNHfyWiDtEtzRjYMJI+4htAhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777048179; c=relaxed/relaxed;
	bh=ckwhgSUaP7LH9m/h4L7W5HcS4Chg6ISwqU+JO7cotMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ec04SRzI6jnR1rjSAYjWKh1oOWwzHYzfsb2ViY7h77MKfXHSJRmpubE7/qcpoPdyFyrgVfkPH9QzFf6pxT5EaQa2GyNSJScd63NmkUkduVtu0nnEc1/4RVawUwrqH1TI3Pt1u5xTYjuvlO60zWBgxThEZqPWWzjrkZsdE2okfy+fG5X6gpN3Ko7Pt6FJthsFDiQD/vZhIQb6Ldp0JRtB51AyuliVOZGCxPlUKa1FJMikNyL7FkzQgQ9Mzd5tbUpqNYP+Kr08AJJK9m4h/4nejhR/CNIjOmTPVHpbi6vES4t0eopkvR5lImRFem4eLcPuB61U8msnh4BaWNceyuk6+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZMEyTdGE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZMEyTdGE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2JMQ5dy7z2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 02:29:38 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OAqZpa3292244;
	Fri, 24 Apr 2026 16:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ckwhgSUaP7LH9m/h4L7W5HcS4Chg6ISwqU+JO7cot
	Mo=; b=ZMEyTdGExiivj2XALhSOiS3lnICOjFyO+ZrsLHKWvX3v+EYgYFlRXGiJp
	ZIIIQLChwfEnbAHTUTsbOW32baOrQBSPebbqfbQRGT89/31fYZ1LN3JQccxt5zqo
	ilsO+IPRZRqNw82T28peHBmDMRkLOIVY4HCj9lZD3gwdpemOIyGRNwfWpav54Ve2
	bXTVBVEd6JPrWtC0w0gsOgT6zSbf+h5gaUC6BQ6etyz4HJt3qVL8fmShx3ayNsDt
	jn2HM8+Wky5VGGUXcP07jzW08I9D61OjJYJXvSlqInULUd0+T6Fw7lR9LuUe28Xe
	76A+lwg4mc9yvaN2F2cNswy7IVoIQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrp659-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 16:29:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OGKLYv032021;
	Fri, 24 Apr 2026 16:29:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkybjad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 16:29:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OGSufB28377822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 16:28:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99CAF5805C;
	Fri, 24 Apr 2026 16:29:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A7058058;
	Fri, 24 Apr 2026 16:29:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.24.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 16:29:20 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, bjking1@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, Mingming Cao <mmc@linux.ibm.com>,
        Shaik Abdulla <shaik.abdulla1@ibm.com>,
        Naveed Ahmed <naveedaus@in.ibm.com>
Subject: [PATCH v3] ibmveth: Disable GSO for packets with small MSS
Date: Fri, 24 Apr 2026 09:29:17 -0700
Message-Id: <20260424162917.65725-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
X-Proofpoint-GUID: Ezjy5Ob4oUAQdfX0fVUxoRkGAaFCfE-r
X-Proofpoint-ORIG-GUID: VHY8sa6bnoQIzbYQJcpzf9tct2Oza9zB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE1OCBTYWx0ZWRfX2UAHSO8Otbyd
 vFiSyn9IcJegoYyPSC7QQKDHdc5MawBeuaO1AjvEGHDrCGoZknvMKba6e+rgpJUIoBNttAmiJ4b
 AlUsVxHTV6Yk3BnmDAKF4WozMd3H+mobd1QQiEBMg/mN0pqQC3BAGxqOPpxRp2lFsLdcK2Si5+3
 fRnTR/OLSQPBYPv42546i6NQFQp8cI1bI9OL1jG410Hf1RlzncxdBD1UtXe9cbLnrsR+YchZYC+
 xDTkuDvad3DgWsA2yi0Jj6T56PmAiXaj1lSxohz9aarjJ1QnIDK9EkKnO0EiJ4bqRTQRxJH1POt
 ZfE0RmMeR8Q7vQaVStVqf8et8YpKL8sGn9Tg3OpiM+RXRdU17Ptzsvf/OglBGINwQoj7v/EiEO0
 lWt6W3Mx0UvcfUuJ/Wrvrfb+nnAMPpEmhXoGD34U50pJ+zzeqt+dOYAyyp/hBEb5Owh+DBgHeiP
 zRFvDuA0VGAEQ81Sxtg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb9a68 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pS6RR9H1IJa285FGuL8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240158

Some physical adapters on Power systems do not support segmentation
offload when the MSS is less than 224 bytes. Attempting to send such
packets causes the adapter to freeze, stopping all traffic until
manually reset.

Implement ndo_features_check to disable GSO for packets with small MSS
values. The network stack will perform software segmentation instead.

The 224-byte minimum matches ibmvnic
commit <f10b09ef687f> ("ibmvnic: Enforce stronger sanity checks
on GSO packets")
which uses the same physical adapters in SEA configurations.

The issue occurs specifically when the hardware attempts to perform
segmentation (gso_segs > 1) with a small MSS. Single-segment GSO packets
(gso_segs == 1) do not trigger the problematic LSO code path and are
transmitted normally without segmentation.

Add an ndo_features_check callback to disable GSO when MSS < 224 bytes.
Also call vlan_features_check() to ensure proper handling of VLAN packets,
particularly QinQ (802.1ad) configurations where the hardware parser may
not support certain offload features.

Validated using iptables to force small MSS values. Without the fix,
the adapter freezes. With the fix, packets are segmented in software
and transmission succeeds. Comprehensive regression testing completedd 
(MSS tests, performance, stability).

Fixes: 8641dd85799f ("ibmveth: Add support for TSO")
Cc: stable@vger.kernel.org
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
Tested-by: Naveed Ahmed <naveedaus@in.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v3:
- Call vlan_features_check() to handle VLAN packets correctly
- Clarified that gso_segs == 1 check is not needed for ibmveth
  (unlike ibmvnic, single-segment packets don't enter LSO path)
- Updated commit message to explain the difference

Changes in v2:
- Add Fixes tag as requested by automated checks
---
 drivers/net/ethernet/ibm/ibmveth.c | 22 ++++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 58cc3147afe2..73e051d26b9d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1756,6 +1756,27 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
+static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
+						struct net_device *dev,
+						netdev_features_t features)
+{
+	/* Some physical adapters do not support segmentation offload with
+	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
+	 * Note: Single-segment packets (gso_segs == 1) don't need this check
+	 * as they bypass the LSO path and are transmitted without segmentation.
+	 */
+	if (skb_is_gso(skb)) {
+		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
+			netdev_warn_once(dev,
+					 "MSS %u too small for LSO, disabling GSO\n",
+					 skb_shinfo(skb)->gso_size);
+			features &= ~NETIF_F_GSO_MASK;
+		}
+	}
+
+	return vlan_features_check(skb, features);
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -1767,6 +1788,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_set_features	= ibmveth_set_features,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
+	.ndo_features_check	= ibmveth_features_check,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 068f99df133e..d87713668ed3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -37,6 +37,7 @@
 #define IBMVETH_ILLAN_IPV4_TCP_CSUM		0x0000000000000002UL
 #define IBMVETH_ILLAN_ACTIVE_TRUNK		0x0000000000000001UL
 
+#define IBMVETH_MIN_LSO_MSS		224	/* Minimum MSS for LSO */
 /* hcall macros */
 #define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
   plpar_hcall_norets(H_REGISTER_LOGICAL_LAN, ua, buflst, rxq, fltlst, mac)
-- 
2.39.3 (Apple Git-146)


