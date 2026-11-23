Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E97606A332
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D2tKUxJl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXyp23tfRz2y7p;
	Mon, 23 Nov 2026 18:52:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420330;
	cv=none; b=Hom2QdEx/E2hs8SqpWJbfPosjAam4uB4CjzGEGrYm7jKlzh8y6t4arGPnm/gX1RD8rrpnP8u09KASyLvwDVmXoeknkosSsRH0CYFWphx2znFE5rwiKLpgR4b3ICjLSmKL3gAJy1FlxRdBIMQEg52Jv6c7TQyAuzEUA+YBR8EI08Lm2oob60ymhJL5Gmv5PwqGEx3ZTLJINRojY/oR4zrQiDo7TuXrJdR+j4OCyHORvgv6TYwPJDDzluqea1drv1s718tKpdK496yKPAL/WyYPEpBhqvUNJWQhhlxDjWNeun9UFXJEJuq3V/cDZXqn4WpW5am2Kcbb6MZt/1ZcKU0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420330; c=relaxed/relaxed;
	bh=LRTb7b9P5EWgNK6Kqxv6XCLxXQEMXknfi7m6mgp0EHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVWoNNemf3raLQCy3E2nHsUtfUOnVuvEQF4/siiWCfGdcUpkM+/DDg9+eVDqLiqreeKuahsNzehbFNFQhyg/4p2AQAqLCzMWvhXzksr7LTcLe+P2eGtPVA0B1BesXT7Lox31GQk44q8TWnWP+Fnr09vDWeB61yCra8n7xGWz1pvSOSVPjQJs32bu7t5uqrDDjONLxAR8LzbJNaHzX66ah/FvNClzojtt3y3scPOmm6zBSkXLEhQGYD27ukYy7VGelAoN8o7ji9p7oA/BX1nk6ZSambON+A1Xr1ltHOD/T+0VA1RT/0DRU0suVNGPD8wsSKaGLhGeKho5ad6nZ4Ur7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D2tKUxJl; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D2tKUxJl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXyp15g4yz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:52:09 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6gg3G1585121;
	Mon, 23 Nov 2026 07:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LRTb7b9P5EWgNK6Kqxv6XCLxXQEMXknfi7m6mgp0E
	Ho=; b=D2tKUxJltgIPnd7QwNDJYFJW6YG4ZBOwhkldpHt9xjB4ydLWg2y9s6+QE
	fMJqcMVuEy78LPD9r00FAWeME5cNnxjai5tofkLYQfvp2tngcBJ0V2g6OSgRggjO
	Ied1LdKi5jX1C1OtQTdB80hw9WNDk2MKWtFmluAVuHp4Z6efTgKuxssxj5wVnlNj
	KGrXkgTmyrvaESW6PMi0AsWTklzxBqw+SnlWqnh3xqoEIp16SK5LHXRDqN3c+L0U
	OPCLFOMwpXDAPeGdrxXwV+PGhV2VmdJ3is6ohgb+0DnIyD4uSqxAw7ZnVsMq1TlQ
	1Dqs05BSddeIvEOQ61Xtt6GoGYByg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p49p1v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54E2O1436218;
	Mon, 23 Nov 2026 07:51:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3raydgwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7pfsJ7537280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 627AF5803F;
	Mon, 23 Nov 2026 07:51:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0AA258063;
	Mon, 23 Nov 2026 07:51:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:38 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 0/8] ibmveth: prepare the RX path for multi-queue
Date: Sun, 22 Nov 2026 23:51:28 -0800
Message-Id: <20261123075136.3278-1-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfXx7uCp4CBhywM
 MrQKppkScIs7uTn7PE3ttsW+6t0cNIJjSMMfra56rgO7R5tN59JAG7bDffHVPzoNvpib+D7e0wC
 c3NWBf8OJ02Qv2BWZwk2gb3Sqdo1WWY=
X-Proofpoint-GUID: DTfO2c19Cr7xJPSGBTbYAJyd_5-HrquQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX6rWl0U5Iogwc
 LnUT8RVSb9NmbTplfqRdlZ/BKthVI85oGoYSODcalLjaHgRT1DPSn9D1e1oVQAr7QG93Zx54fGc
 ef+yxzi5mjlM1rtMNvH6wO1pJIGn4Nx/HfhqcFjVHyOQcd1JTxLqQJz8dpKsUwyi92K6yO5GJi7
 CdwAxkUzh9tZHJPtoVvMA6raF6LL8/CG0wj1gnHQzRZdxWmIdVFc6RXQD0QWfI7hkoBo4qy8Wo9
 38Yy944pt2Y9TG9fYw/SZzK3CorBj+8LKzc84ge+Y2I6USoFnydzgySij4sc1iREyM1LP0RnVer
 61GK9mAMQF4X73w0hm/nGrtJA1QCGCylxfzmfCCS7ZJpjG2bv4BMdL1Gld01wQco3ZuHfKzfTMt
 hg0LSbX5C5KpZNll5zUztA9KoBFFeAKyQyj0CukEKI3oJQvijy5A1JHs4mTj7ONvK05/EQWJnIi
 WzCWO+0rg6ntnW9YHHQ==
X-Proofpoint-ORIG-GUID: bIwtpxXFTqGwvbs9TxTaByT9hs7kPh-Y
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b03f090 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pTEnhOEyEOFkSSAe0uIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ibmveth receives on a single RX queue with one interrupt, so all of a
virtual ethernet adapter's receive processing runs on one CPU. Power11
firmware can give the adapter several RX queues, each with its own
interrupt and buffers.

This series only reshapes the existing RX path: open/close, buffer
pools, interrupts, replenish and poll now take a queue index.
IBMVETH_MAX_RX_QUEUES stays 1, so every loop runs once. Same
hypercalls, same ethtool behaviour, no new ABI. Multi-queue enable
is a later series.

Patches 1-5 move the open/close path onto per-queue helpers. Patch 6
moves LAN registration and teardown out of open()/close(). Patch 7
passes the queue index through replenish and poll. Patch 8 splits poll
into per-slot helpers.

This series was split from an earlier posting of the full multi-queue
work [1], which was too large to review as one [2]. Two related bug
fixes go to net-next in a separate thread; neither depends on the
other, and they apply in either order.

Tested: on a PowerVM LPAR, one RX queue: ifdown/up under iperf3,
MTU change, ethtool -L rx 2 rejected, TX shrink under traffic. v2 on
QEMU pseries only, with the net fixes v2 applied: the same checks
with UDP traffic, and the KUnit suite.

Changes in v2:
- 5/8: keep mapping the TX long-term buffers before RX buffers go to
  PHYP, as today; v1 moved them after RX bring-up, which can fail
  open() under CMO. Drop the netif_tx_disable() that order needed.
  (Sashiko)
- 2/8, 4/8, 6/8, 7/8, 8/8: comment, naming and argument-order fixes
  (Sashiko); details in each patch

v1: https://lore.kernel.org/netdev/20261119000711.18093-1-mmc@linux.ibm.com/

[1] https://lore.kernel.org/netdev/20261109235556.60604-1-mmc@linux.ibm.com/
[2] https://lore.kernel.org/netdev/20261116174225.7d9e9611@kernel.org/

