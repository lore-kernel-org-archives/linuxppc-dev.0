Return-Path: <linuxppc-dev+bounces-19839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD869F8DFFF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 17:29:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fy21r0C1Hz2xpt;
	Sat, 18 Apr 2026 03:29:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776446975;
	cv=none; b=HRQ7dGEzOZ3pSRsaDvEQSHvC5tgGTtCg9QmK85q/2kGWIDY6h/szFB8sLdoEkeGN0XpjpS72IfclkDpyfv2QR0cyjYXLS/sAi2o9kPq5JIqCQTiCsi3dAgSgOV4iN2Yw3FNvWr86hqrPTiBePZqcad/wkHNxJnuPLJ9jX9eopXL9nuQfBfZaMd1BlmfEksnlKx5k91ruBNXZG896BciMg6U7BmyTbjj3q2iOq3rEfpQvY3h0CjGFiP14pglo8xtLLEur3auwVNb2l3mpc3PkhAS0SiIt3mjtZVVr8AU8pRSpy+we6ENN0sxuNx6wRi2zJg5HK1GSDnCZQXe4AKL/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776446975; c=relaxed/relaxed;
	bh=2dbA6caidxJZX0dCD8ua5pXOUPnLEIhqNDVBBkrNVSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzFQuhJTr7xU6Yp0dLyqqXyLfhxb024A4F5ZdRCKt0T57BiO+bQNwKuUhPln5DY6ptX5nXf9oIYVRzFiVW1nx1RxLTpm8WZN6X6tugv0cYC2rMQe7dNW84utAeTGFKd6w4Thf/gT+gL73sKoOJNB2SnScnlHp4FqU8Isvv6kOsrrWVlMn8dNcgLg10LsTjbvSKfMcgOsF2KLq4fgymrqtub7XugeP4z1aw0w1mI5H59bFCYTgOEW9LDvSOdPQpqBynqsw0f7xagQVzR6lnufPkpoyUoohH8+4tQ0WiBL7NGltCSNYFq4btp6XgdWD+qMSety9bGyD5GL6Wddqm2KbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jtian54t; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jtian54t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fy21p2J9Yz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2026 03:29:33 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H6kPlM087621;
	Fri, 17 Apr 2026 17:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2dbA6caidxJZX0dCD8ua5pXOUPnLEIhqNDVBBkrNV
	SQ=; b=Jtian54t588ILvtuz4ILgwp08/gYivJfxOTl6mHRugtEBW1h6zUE1bIFV
	YkocqqNl85byZrOeY/ytvklJEUOY7DmZI9W9xTViFXbFL4AQnFsxrY1zpa6WIvQe
	UWlN4I6nOvxO6AE9/VA1lnlYBKf7HmMP5usepl/fZxOrxeYYfUwirf6OtL6FlZJG
	Y4hCIFE/RX7IVpLK1j1eWPFzZC9mQsy9S2LhBeELvRooBkCm5McUS78v86+O35K8
	lvW6K6RaqyPrQ7oJlyPZjeCdUO/gBg/qU3Zm5Z78VGakC//dMVDL4U6Aza75Jzfd
	+Evb3IoDe5QgLPPyY/sNmEJavH5TA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rurnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 17:29:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63HHRcHv005103;
	Fri, 17 Apr 2026 17:29:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dkrucr43h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 17:29:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HHTFGq23069438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 17:29:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7466758057;
	Fri, 17 Apr 2026 17:29:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11F8258061;
	Fri, 17 Apr 2026 17:29:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.173.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 17:29:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, Mingming Cao <mmc@linux.ibm.com>,
        Shaik Abdulla <shaik.abdulla1@ibm.com>,
        Naveed Ahmed <naveedaus@in.ibm.com>
Subject: [PATCH net v2] ibmveth: Disable GSO for packets with small MSS
Date: Fri, 17 Apr 2026 10:29:10 -0700
Message-Id: <20260417172910.81433-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE3NCBTYWx0ZWRfX9zSfBUfj1NHh
 Sjwzop2iUZkCfxFWX0z4p+JIj9pk1JJ3YY4Q63AENqPWpkjukTpBdfGWLPqQt5baquLGOi9+Tm5
 2B+MAWE/fYt1id/EQ/k0D6pAhDbZ7qbd/xp57WHGPk8UwzRnWzUr3cS3BKj6CJ01s2V9RFTZ21P
 3AHhKdKf6Bolp7nBCrYapfviQjuVjah+vwC98YDtdW5oWBKdrvyADOBD0s5hIFNncI8kf8L+xTU
 9ZQSb3QfyO1CsBAn1k9zMnbj5o+UceXeMrMvFPAoGeSRqIpKum+RSrTOMO3N0N0kQYwTMlEwHb+
 OQUXBluWHoXOGapiDZqggHFl5B89H7vPsRvPZXnG/qQcUTVTSqLRh7THcXYEwGbu0+gDlxLUpCI
 BI2G0v9GfmT+cer6dor3n9bs1NoevTwIppmQsUC6NV/KkFDWx3i6pDEkvzxPwxvwJqDvnOtKjgJ
 RTtFk9FeEpnzH60G79Q==
X-Proofpoint-ORIG-GUID: aBHJLVuFWYbfzP9VVzdQ9gDuZEjV3tIB
X-Proofpoint-GUID: 9FTDNG4RccCHvMAhTrywhBTS6D84Jnnt
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e26df1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0DtoxFBozvEr3AFqBbAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170174

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

Validated using iptables to force small MSS values. Without the fix,
the adapter freezes. With the fix, packets are segmented in software
and transmission succeeds.

Fixes: 8641dd85799f ("ibmveth: Add support for TSO")
Cc: stable@vger.kernel.org
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
Tested-by: Naveed Ahmed <naveedaus@in.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
v2: Add Fixes tag as requested by automated checks 

 drivers/net/ethernet/ibm/ibmveth.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 58cc3147afe2..7935c9384ef4 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1756,6 +1756,25 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
+static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
+						struct net_device *dev,
+						netdev_features_t features)
+{
+	/* Some physical adapters do not support segmentation offload with
+	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
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
+	return features;
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -1767,6 +1786,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
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


