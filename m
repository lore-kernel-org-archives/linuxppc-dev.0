Return-Path: <linuxppc-dev+bounces-29597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444F7CCA464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:05:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htB73RDz2ynZ;
	Fri, 16 Oct 2026 22:05:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148706;
	cv=none; b=irfAfykS14UO9yRy9FwBM278Rf9yTdZUh8teV208kZ14jY+j/KAx190YsICEs371TVKuDGOTDVfGV8Gb2xOVnt3P5yeZYvdvT/XSWX3/Gm4SOuLkEJWva2JqktZh6EwYL8ElXmmemLzAUL9bBzI6Ic8sdKccxGXKUN9KRv+BGlSC5q/zOjQ2uzoqS2MnXrzosoKrvnnJnf172rEe7B8EQPpGcJR4utUl+EehpSQPGvENPFtjJBGybF/EKGUFE1XS90ZL8x/LBWoDS/J9XAh6AZ6IgFY8TaOTp8xloUzZZesZpovsUW00irAw7oW+WHd3DTq9QCpY1jZQyiv1cPh66g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148706; c=relaxed/relaxed;
	bh=EO75CWaEjAqYMfywU9aURbtMvtVLfvYBxAzB+D0/4CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOWcP5lLcXdFlinl1KRGbfxOA+hWPGopRyPWv3DgjyzMSKTHQouUryqT/UfAcQ+PEGwT5CuewVkCytq1UXCd4GV4KDlVB9eROM7kwXM8BvT+L1fQzN+puZqjDz9UEog23cZGmV7eo6BObNy02pM9NVygYBjlorbBL4q9F3BNzRtCWSSkM24bIB0PDLOTEqiq5nuIblUjc9GxU/5EndFg426/l2pStvFXzBtGonyo/Le0Ai77oyqwX7nnn5mNs+Z1oEeWXCdc4iKQtg8lBdTw/tg99lX77ZxAJPAXiCutymOaGrhgZafLk0tam/eIenMWmjmfc66C4SOO01ALVg1imw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HBsw2Mys; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HBsw2Mys;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5ht938b2z2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:04 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAETpX3425952;
	Fri, 16 Oct 2026 11:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EO75CWaEjAqYMfywU
	9aURbtMvtVLfvYBxAzB+D0/4CM=; b=HBsw2MysMbGw+sTd0pEZ0MOOX26NDMo3T
	L4zms9s+4Tb0xFNKe7dTGYQlBiPF95jNmM42LZD4q69WYxmgtTDIwc+31CajtOrR
	tmszuJ2rJNPxlFQ/nLS7r7XM0U3KlFpy26Ljmnv69hPPBmWSS0cWsSOPGXFrdcTj
	P2NcUexNWjWFCfbseLTkVGczHdFZMgCNUsk1cJe7KxLt9wqBR0VHTeToGEVd11Ln
	jw4u+PKAXqrCktNTLIaem1VoGl7733BLWVUdfqfTZnS+vUdWAcSCwmwoTAa/KxaU
	XaaaRIBo+Hs7/30/e7yCqUGFsocPUwwR3RVT7A1W7uPNvrsUYiOOg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwje9n6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAK2CU3586577;
	Fri, 16 Oct 2026 11:04:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb36wk58f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4jRC51184008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E40B420043;
	Fri, 16 Oct 2026 11:04:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3095120040;
	Fri, 16 Oct 2026 11:04:43 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:43 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] powerpc/numa: Remove redundant coregroup enablement
Date: Fri, 16 Oct 2026 16:34:06 +0530
Message-ID: <20261016110412.1380298-2-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016110412.1380298-1-srikar@linux.ibm.com>
References: <20261016110412.1380298-1-srikar@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX5LF5LZVUnuuG
 oTTkrjtX79fPDLp01y46ItIOIwB/BsZmJxvnAi/DkEBRVsqVYNml/jm0yo1S1My0heIpW7JpKht
 v104CCFsQyadnuaXkz/s8d+0WxOOhrlFeqBV2x7oSYunO9QtlyFjIn84NuTdiUqde80IlvJ8jSQ
 h8lbS1p30bJWkxoaNe5WhARxdYA7EeW3nmZWrDqHjEdPRloSyvEnEZ3BV0EubMvh8WzOoUFuoDI
 PNSIHJ3haaMtXlITiraGPVPwLx+MV2fIo3HZdMiUxHwnkTSxZjGvHrNQgXJJ5LweMnp7cTlA3Dk
 1Vz07/Yyofql4RufCmam3m47nIRPlIaJV5zCi17wKfLvbEL+UeZALfqcrcsz8ManXyYsBhbe7p4
 6XwLtqyh3dsYxCqhGB7HgpdJIuhk4wKxeH8WgN/JqNI0UbDFGyxTFKjj7tTLeXgLBVo8KIjimLR
 zPryB8p5IFZLs3kxrpA==
X-Proofpoint-GUID: GHGjWdd6aiVQIODPBfDDIGcgV0DEcsT3
X-Proofpoint-ORIG-GUID: s9uEXL8S-AyRNBne7TiU2zafETkeEeUE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX6503Y6GW7LOe
 bb/a+cL93Ruo8V4Tw7SsWliiuoKFS6V+YVRGAm3gJ2wjYdtTXJHwXNy2JkGgTFUN0WVn9vCROYu
 PIlujLTLuQDDiYlpF5wXa31aMRq305Y=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ad204d1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CDgvEfb8gciP4XstMcMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160042

parse_numa_properties() determines whether the coregroup associativity
level is present and sets coregroup_enabled before find_possible_nodes()
is called.

Therefore, there is no need for find_possible_nodes() to determine the
same information again from the length of the associativity domain
property.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e97b624203ea..09f7e7b2b192 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1124,7 +1124,7 @@ static void __init find_possible_nodes(void)
 {
 	struct device_node *rtas, *root;
 	const __be32 *domains = NULL;
-	int prop_length, max_nodes;
+	int max_nodes;
 	u32 i;
 
 	if (!numa_enabled)
@@ -1145,13 +1145,10 @@ static void __init find_possible_nodes(void)
 	 */
 	root = of_find_node_by_path("/");
 	if (!of_get_property(root, "ibm,migratable-partition", NULL))
-		domains = of_get_property(rtas,
-					  "ibm,current-associativity-domains",
-					  &prop_length);
+		domains = of_get_property(rtas, "ibm,current-associativity-domains", NULL);
 	of_node_put(root);
 	if (!domains) {
-		domains = of_get_property(rtas, "ibm,max-associativity-domains",
-					&prop_length);
+		domains = of_get_property(rtas, "ibm,max-associativity-domains", NULL);
 		if (!domains)
 			goto out;
 	}
@@ -1164,10 +1161,6 @@ static void __init find_possible_nodes(void)
 			node_set(i, node_possible_map);
 	}
 
-	prop_length /= sizeof(int);
-	if (prop_length > primary_domain_index + 2)
-		coregroup_enabled = 1;
-
 out:
 	of_node_put(rtas);
 }
-- 
2.47.1


