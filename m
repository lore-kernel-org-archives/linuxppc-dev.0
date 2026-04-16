Return-Path: <linuxppc-dev+bounces-19815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7232F8D76E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 19:11:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxSLH2TQ8z2yVt;
	Fri, 17 Apr 2026 05:11:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776366711;
	cv=none; b=Sy3FdlBjQAle1p5eVbFzVtvfUCuo/hVoOcX8KeC+7vfLD3D2eLO6sABW3CRbQiBn5cBffmQkekB2mgSTcpZHrGK/Ivya0RLw8C0Gk+o43IDbrOo7zHE0dzJt19+YLWIy+OrwSbMjrbPlSC2eAamIjbbRbH6XGAIT/HmxQdD2RGVW6J/IzScLMPB5/OCW0JuBU3gwoxoUhtepQ8HwChz41fDnQa03CM+ket+xuRdCrsVxaTjUxJK+BgRf8j0gQMW1VOs/wWXcsq1oycmorOFcMoAiZiylYwGBlR8ZNK/ALFxXGxj4uu6vkVmqt0NbZQvganSIXXf9QZRTJPG4w4wOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776366711; c=relaxed/relaxed;
	bh=z9f2WoTgIfJ4Lt/PFrfw/gZW2lqfBvsWodpCT/WHvkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVqlNj2uXqNBaFca6y9FjIPM35Vms3wEwo0FTBQbwTfAe/Lbl90hm+OTx6sdMhKBWZxoshVJ+D2IGSFl0Zd+MddxvhHrfM/poPRYUHGXQiAxyy5CAdZpZvPwdX/Cv0i7xBGKOtIQ5lb/ufGVJVpo45X8cu+Bct1NMCKsWQg1jg6byKkDAez/cvjvfi67OEOXx8uNXzo4bi0+ZzZPaPZ+FzMslFNRHmmZhxz2KYBXryk1Qy7Zbas2lyscBTIeDmfv4Uu93p7uDAJsWyy/tStEtWY/CFL6ybB/J9ejvn5vA1+dXN2iKVAzT+9mjR5lJ5QhS/LnAODCujlYAAdYNro6ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=avrXiipw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=avrXiipw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxSLG2pnMz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 05:11:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G89wLk1860612;
	Thu, 16 Apr 2026 19:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z9f2WoTgIfJ4Lt/PFrfw/gZW2lqfBvsWodpCT/WHv
	kY=; b=avrXiipwGhKKmW39TcCPg30LkOG54f34muqRGm9PQKGD3U4qYiolw8S74
	/k738qXbVJfx+lTJK2Q1yYZsIvx7F1ZLikPKddSDPwNdayFAwAUM4cNoAsYX5DtD
	oNSUiH8jcfvUhUtuKGtA5Hb5+wVxXn1/hXaEXXpPjzNNLBAKUQcVc0akBIGLh4Rn
	thZslDrb/jILDxPwh9KneWVRBKJiARvQMG7rSrpcnPKWYlTU1FC97enDc/aCjYJU
	EI/OAh0fkOG0+VIhUz62GYPchdG4vrkoJFj4+Qw8aK5fVDAR7gJESRXvUNo650ix
	uVlLj8tZl3LMYpgZfFZqL7rKFQ1Dg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pp78q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 19:11:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GF6lAJ015164;
	Thu, 16 Apr 2026 19:11:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msvfam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 19:11:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GJBW3W7078640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 19:11:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32CF35805C;
	Thu, 16 Apr 2026 19:11:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E5C58058;
	Thu, 16 Apr 2026 19:11:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.12.189])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 19:11:30 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, Mingming Cao <mmc@linux.ibm.com>,
        Shaik Abdulla <shaik.abdulla1@ibm.com>,
        Naveed Ahmed <naveedaus@in.ibm.com>
Subject: [PATCH net] ibmveth: Disable GSO for packets with small MSS
Date: Thu, 16 Apr 2026 12:11:26 -0700
Message-Id: <20260416191126.95336-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: ioZ6CX6QVo8vsH9VSgrCPNanekD26vNx
X-Proofpoint-ORIG-GUID: k_DCrsCbumqLIMI8Bp7BTxOvzEMclNFT
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e13468 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=13N5Qnvyu_7Mey2fMVwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE3OSBTYWx0ZWRfX/0y1W4SeUqxY
 51RRBnHeeKIcG81i5wocxedY6jBrgo9Eq2WgPnFZEHJKc+gf9KbJyxQ8Z6Pg3xXKcA/5WxcGoBu
 BldGT2AeBY79mo2pccex8AyuIh7dFSmu4p1fJXb1VxWucqq/LHLI2hUIU8ASvH4KlW07SgqrYFQ
 SNTkSepegJSMDSRvVqVj6fYLA21lKiqwX/lbuQfFSlMdYKzRYChCodN9okvq6YAMCgXyaL+rQZu
 Z/rnurdgpRTKR9k1Pb4hx7xjMU4tO/jTepCJOMs8A2cqxRux43CPKWpVkPBt2ipD/RMatO0OhY/
 vm/a2g0Z9/8tHOLznicT4Y7LnrlNMZ7IdwpjPy2oIo4PLgqjcVw5pf4BxGM6jGrjD+y/3++F3wC
 TUtjY+9p/15t2NutPp2Bn/F2Lozu3h1vz7JbaQv82nEcqzgXEVOjRk8qXTy47YIk57F6Jyr4CSb
 EdIS3DFDK2qRRnc3RGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160179

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

Cc: stable@vger.kernel.org
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
Tested-by: Naveed Ahmed <naveedaus@in.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
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


