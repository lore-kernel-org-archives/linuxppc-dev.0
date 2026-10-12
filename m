Return-Path: <linuxppc-dev+bounces-29223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5FCCA9ED5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 05:06:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j355t64Gpz3c2v;
	Mon, 12 Oct 2026 16:06:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791781570;
	cv=none; b=GDuAgyZuMiJWKeOtCfZSErByxzVaRBOaAPXQqOfhpyGo/PPwynrI4w4n+CGaTPFQmtzCAS1gTIiFvKAdtSfIr0oU4cXaZkLEOWCcAVjJRUQHNFeQ+JX5Hmb18f+tN/i0sxDbzkKhxOEY867zqbKBlqkjeWao+tB/7TzaGnNyIh70QL3pU/FIkfeU9gcvi3hTMow+yCuVrHPUFzFWabjHX63vHie63TBsE/N64UVGHM1xLPmlhNlBdzsZEjgajV1YrkcWrnDuAut80td/TwLUKtreAfXf4mWktUKZrVJOCon+nzEDxTWqvqLa2NPcCHuijtjkC5Xdgt2g5sOANocOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791781570; c=relaxed/relaxed;
	bh=Xu4UrNjiGgoJxELCZITGce0esnpi4fpjcBiYbcVpm5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mq28dqRyeB3DP4XYWpNQONbHK/CgAvXHNP2xGuwGkDf6JWGXq9CWKIIqywB4XcGlOG1BlSdxHhYJT9NbXWL5tS+JnLZxxChnQfFpBXyvAbT3G084OH1SOT/cMM+w/X1h6NCr62m+D2H9k8hOzO+mF+xT7fozPon/B0w13seJvEPQFnqmdv1L2MVUZPXsyDbkmObH57utv1T1VWX7kq7O9a+lG7APJF7Wfe+DOTbKtieQL5ee6s/IByMgJ5dWnBCaDGG1bsI2m9b6e/2iMdcj2gAaLNcSx8seEENQ2voD1JkbxxvfzLoftsNfgIlUItBdRHneWnVoO7eu/Ad5nVYi/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LJxm9hZY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LJxm9hZY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j355t0kwjz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 16:06:09 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EVPk1284102;
	Mon, 12 Oct 2026 05:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xu4UrNjiGgoJxELCZ
	ITGce0esnpi4fpjcBiYbcVpm5o=; b=LJxm9hZYkv9twEoC1FgZ7J39RfHy9nr7O
	mIRR/BU0bUPktSTlzCPCM7ANJu6y2b/JPWJVTh4vrZmXNetzwUvLfCG1RBuxRtyj
	JfFo4ODKRu+CpZZIouPk0kVD8zspD3xjnpWblDjRDmDLZnwNJoU1iiQQJjtmeA4G
	zo5eEqFKFIZJY7WjtxC+iNqgIxRtZowMMQMf2Za4mqNNaZeERffWK/0rcasR1K2z
	OYu0QYqEpsW/s/6jGBj+zBcfeELuxmg4UpaZu23zpAHT+fI8SIyuBiL5YVG5AgQU
	8V/zSUZg3JY87gsDcM+QGTgL6Mlo54jdC93p5AB3q/LewkOgXL+Jg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh7888-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:06:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5546r804839;
	Mon, 12 Oct 2026 05:06:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cybgvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:06:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55CCe9634406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBCC75810F;
	Mon, 12 Oct 2026 05:05:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5F015811C;
	Mon, 12 Oct 2026 05:05:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:55 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, stephen@networkplumber.org
Subject: [PATCH net-next v4 8/9] ibmveth: wait for the RX poll to return before freeing the RX queue
Date: Sun, 11 Oct 2026 22:05:17 -0700
Message-Id: <20261012050518.88858-9-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261012050518.88858-1-mmc@linux.ibm.com>
References: <20261012050518.88858-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX3sOVK4tT3zmM
 OMOUuZrtK+BXWqY/p1bg7nGHWVeOavpqWs5A0qnXpuu27V2WkEVIwi90dgVlTGIJjdbrE2LTD2d
 nT37xlcoZb3GHpGacCIaWcIWuDGhqHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX5GCOyX+84UGc
 VkkiZd16NYId9MgxaxE0zXjBAB8WqriNEP62W+wcYCnYEXpsLfW96gygrrnTbH0T0k1WDR5Owd7
 la2VJU7kRs8XB8mr/P2gruJogMSODAQA21hUGtEyOLZSqPK53R4V//okNKZxNUXPAxGv1vnQ3vE
 vhK7OGTX3UYL2454T7WrxqPyBlrRxjQ3ZgiWIi8Zyy0ABu4Z1VxdhRrvLyRpfWdrraPSqp5EQwa
 N8f0T2mpyyPEO9TWZsdp99muuDYBNDVT2TlsP3Xgxr6V6gsSXBc/f6y8MPMA3cnnyB3x+5TviTb
 hI+OP6k5ADUPwkLkoYCySbgW2hyuIjmTTp01XReEhoTvyMEirpTSkc9pscv+mhr0KQifhKIdOy/
 PPOL5zpbkcf3AS2K0Qt3vq3F6kXFQ+gab0XB92rEZVX0PzSHt3zK8kPRkbrofvjjqYAHOH57RGI
 tEb4WCkTWcR5gbCJD6A==
X-Proofpoint-GUID: L81PZWox8c57kUAUy9aq97qrivWZR9Oz
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acc6aba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1jQH5Hc4uxvP87yPb2kA:9
X-Proofpoint-ORIG-GUID: g8HYuPh93cVLovfFFUAWrta4vPK7AgYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018

napi_disable() returns once ibmveth_poll() has called
napi_complete_done(), but the poll is not finished: it then re-enables
the interrupt and calls ibmveth_rxq_pending_buffer(), which reads the
RX queue. ibmveth_close() can free that queue in the meantime, and the
late enable can leave the interrupt unmasked after close() masked it.
The request_irq() failure path in ibmveth_open() frees the same memory
after napi_disable() too.

Call synchronize_net() after napi_disable() on both paths. Every
caller of ibmveth_poll() runs it with bottom halves or interrupts
disabled, so this waits for the poll to return.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; also raised by the Sashiko AI review of
the first version of this series. The race was not reproduced. Tested
on a POWER10 LPAR under an incoming ping flood with 30 rapid link
down/up cycles and 30 rapid MTU cycles (1500 <-> 9000); ran cleanly
with no warnings or faults. No kernel selftests cover ibmveth.

Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- new patch; raised by the Sashiko review of v1 patch 1 as a
  pre-existing bug

 drivers/net/ethernet/ibm/ibmveth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index f2570d637301..85e176d0ed32 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -768,6 +768,7 @@ static int ibmveth_open(struct net_device *netdev)
 			 netdev);
 	if (rc != 0) {
 		napi_disable(&adapter->napi);
+		synchronize_net();
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
 		goto out_free_buffer_pools;
@@ -834,6 +835,11 @@ static int ibmveth_close(struct net_device *netdev)
 	netdev_dbg(netdev, "close starting\n");
 
 	napi_disable(&adapter->napi);
+	/* napi_disable() returns once ibmveth_poll() has called
+	 * napi_complete_done(), but the poll still re-enables the
+	 * interrupt and reads the RX queue after that.
+	 */
+	synchronize_net();
 
 	netif_tx_disable(netdev);
 
-- 
2.50.1 (Apple Git-155)


