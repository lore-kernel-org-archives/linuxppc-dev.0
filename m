Return-Path: <linuxppc-dev+bounces-28910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7156CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:09:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyprH2yypz2yqx;
	Mon, 05 Oct 2026 17:09:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791180575;
	cv=none; b=GBLLIiD/fS+I02qfS3tV6XXjZCHwnx6VnxYR2YXo1o8B2TvWe4hUc9YSOvN1PZKL8dxIQI258gqt6O3vUXLhySL7R+BAzS5HOoEp2VC7wp5XhZReFkZES1/BhjqcKBfRZBGlMZC0ztIZT3FNZyS2804U6dg2P7vfAFyx9dJ5MrU7bL1uHWnUV9GIDfULw6rXPnj6Hi5fgMyhPnGmdD0FOPFt4S84D5CKPp8nj2Y1/Bpv9ssc+F8NA0o3zOUCNLbEoCl0gHqm4qGorBHHFLF/2dpIuNzE25wx2Yr2x53dxy4FO9huF956Z6xYppnlnZvJz6xUJH5aqRQjMojTqldiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791180575; c=relaxed/relaxed;
	bh=n190gGFblrlj4Vd9xOJlzVfmnNPLZPFuu2RtjmnW43s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhmR8Ozbu6yrHMcZXoWBgKwVzAtX2VTg479yYQoIHyLq0gPfwFZWI/DZc9j6tNWeVsE+jzhlZrzo69inLw6Tcloim7Hfa5PLPtWCk7KCu+z1XaorJMTt95PuMLsmIJzcIGuyMPWE8hsHGzidXbqAvHbYXYthgq+Wy6c05qyfeBZmYMwVRYZj45hMUB2OM50Q9uZTGie6nWL7OGYD46+22ozNnDJPedCTIYpCFtjmYJVn7GyeLF3I0k9C15D1/DOfDDGPE0pgamiz/6FO0tS76XHyOymz+5U8B2WcmhtlLhhlgSipVG2aGrfZdfBqFBGQ3GbCwNMVU1pzmapySPl1BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jw3UE9p0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jw3UE9p0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyprG4Qncz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:09:34 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515e4i2066010;
	Mon, 5 Oct 2026 06:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n190gGFblrlj4Vd9x
	OJlzVfmnNPLZPFuu2RtjmnW43s=; b=Jw3UE9p0HVdLQkybytFlH6VQuai8G6/s6
	KfFo1Ad0uRDgDxydXKHK9hw6aR4xmiIeowACRY882kYDK4/zS755w09kM7PrWd0f
	h3qOy7NSBVWtbMp5Azar72G1kDC+3Arkqd/RWYUxJbkC4m5s6DqHFaL5k2ThaDwQ
	LTaqhiJ+Ana3BSwr8ZOWmlEHcbzVBqNulft953pEPliWXT/O9oUT7ohRYu6bDa3A
	+Z8gxJM7GNe87D209MTanYfiUN7USvRFmjCfzSWzvfMyPASHjutX0qdmEOBpjYGE
	cFUxe2eXWWWecPb7F95AdEqJXvkCPmSb8fMk6Yjjunxo4V6v9bJkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3mg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6951HM5S2163433;
	Mon, 5 Oct 2026 06:09:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvm9tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69569LF531326732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:09:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A9C58059;
	Mon,  5 Oct 2026 06:09:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A82D45805B;
	Mon,  5 Oct 2026 06:09:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:09:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, nnac123@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/8] ibmveth: return the error when set_channels cannot add TX queues
Date: Sun,  4 Oct 2026 23:06:07 -0700
Message-Id: <5685e3b9be9c24021f73404d2269899e3a099af1.1791178212.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1791178212.git.mmc@linux.ibm.com>
References: <cover.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33f14 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=RZ4y7BAnkfP1csG6fq0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX4Y0t6FtMuqQJ
 4X6UNf//uPSFiCPoNEXkx8iYRRp0eExclvJF2e5EhsC8mrCTfAGksWUAwXoPPmd1/5U9pdeQLar
 nVQQlrjeC+WnCw+Wdpe1S+nnyiqtRPSxKcKe04nLW652G1p9wOb95SjxCYLVTrevjAGAX3rFfOh
 3cXILSdCzoclDANGiBfCg0B0F18bEnb+S8ICCgHddwy8oz+4r8DH8Tr9wqHjUHeu3M3PZ8ApNWk
 E6PVmIhb2wqMjtbx/UKN4grGHGXR9UnWRQcEqrEQ9bLh7Q+xwIiA6ZeOiO4zJTNzSEWn79oj3Yg
 74T6F6a/1MVPLsaM1CNahm4EhPUU0cjiiJFy8aFjoXGdP00+exP7v1Sgefe7jI1+zGZAqOEUaPS
 /1ABAI654d3GebX1RNMBqzRdPKwYnc/B1e8G/swsD4Eg0F0ysSiJkPNwmJCmSZuXnZajgmhpWJU
 116+hfYJQMT+qE7r9vA==
X-Proofpoint-GUID: jh2600aLDox0hEEfSLqe9Z_x0VuVkenV
X-Proofpoint-ORIG-GUID: 6T9bsJOlhyLqHuk2S6IKoSOCNbnc7vSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX/NhMIFmlp5av
 3ILMPh771AfM4mW6xX1xqbE34IEdpurEy4/olOlT6HZTZ3nc9h2Ztx2g4DO2y3TtHRg3AKwyOlu
 lXTDruAAJJu0UVovPRA1qtaOXipRizY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

When ibmveth_set_channels() cannot allocate a TX buffer for a new
queue, it falls back to the old queue count, and the successful
netif_set_real_num_tx_queues() call then overwrites rc. ethtool -L
reports success while the queue count is unchanged.

Return the allocation error when the fallback succeeds.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection. Tested on a POWER10 LPAR with the TX
buffer allocation forced to fail by a test-only module parameter (not
part of this patch): ethtool -L tx 8 now fails with -ENOMEM and the
device keeps its four queues and passes traffic. No kernel selftests
cover ibmveth.

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a10ebaca9081..e242417ed8da 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1169,7 +1169,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
-	int rc, i;
+	int rc, i, alloc_rc = 0;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -1195,6 +1195,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
+		alloc_rc = rc;
 		goal = old;
 		old = i;
 		break;
@@ -1205,6 +1206,8 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			   old);
 		goal = old;
 		old = i;
+	} else if (alloc_rc) {
+		rc = alloc_rc;
 	}
 	/* Free any that are no longer needed */
 	for (i = old; i > goal; i--) {
-- 
2.39.3 (Apple Git-146)


