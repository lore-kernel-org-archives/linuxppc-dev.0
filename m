Return-Path: <linuxppc-dev+bounces-29159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843EACA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:34:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1b9D41fqz3c6f;
	Sat, 10 Oct 2026 05:33:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791570832;
	cv=none; b=XgG3gw1RgX8jJ8Awb05wxH8lxxaI7a/W8IC6erCw9SlaQ9sWml7VI8VJFJQUpHYJl4CXJu70zvwofAR7Q2nFCJ6e4yHSnQDhleCr2nCI4CWmG/3yFRbyB0dCfanJblUYstMQ6/oeWVoNUEg/3jzoc7mLzz1bmYoVR8AdOzh98Qzv+zHQHE2kHhjCxMMJ2cF1a16ogED1Ubb+xZ7pKzOXPp3McLr+E1XEnu/xv6K4hpYm9qx6wAd9RYvCuwfS/iLL25x4ZeSpYyST4HUYbgY1MIfN4LTnz6fQSWcVrgU3lND7LDuB7pLlVuyg7MDkoSCTKgjvyec/9r/fN6eiSotV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791570832; c=relaxed/relaxed;
	bh=aTcoX4wcyA9ZQBdmbT8zi2sxWCyzyXMENk9fC39lbYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0LN0kkuBpzjoKSbGo9vCRnmB66Ik7VWMIAniXNRtzhBaCUn+dIUtKwgLj1GegL475vmU6Ts7ugbRzKi0RHLyNTVdvHNtiUetROKhbdxAXSKPm4pVNt6lr4WWZRJTMMXAIFUHHxMwIFobSzMMWFezBFzrZDoHM/T72y/ColnYPLxWN7H2yyUdTmZI7jnpWWLrBJaAP/AOYqHok84AY/kPqvNVLDe3TC6wjZuwEmqzTulEySpLJkn8AsNRs3qVi8rC379haHNpG8ywORkyUR3HHtN12I16NCbuiEt3mDse2sgaPmibJPa/O1K+3tdVki6wcTh40QD3VunsCphAIXShQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GCS5jkwI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GCS5jkwI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1b9C6NfZz3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:33:51 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699HZp8S592343;
	Fri, 9 Oct 2026 18:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aTcoX4wcyA9ZQBdmb
	T8zi2sxWCyzyXMENk9fC39lbYE=; b=GCS5jkwIdbKfAPeK8LozT1Sws96z+nhKB
	xfoscxtz5cqWhhhBW9LFi3YjjY9j+5vvMmxhhS4QgzR/gTToj6jjLwu9zG3+3O0Q
	J6AIYr0y8Tsi7Ifgxk7cTijoY7a8/ghUcK5bPPKsrkXcB93dCuYQ2MXWJWhfkV5p
	ZlMFCGciJsjFIkhbLnl9LCE9BjW4cKldmsBD8R0hjH7+L7oIDdee+l7ocuAhofFh
	rfpCDp2lhJG+Ig3dp8fVRKyqdvQmiDfIXOhCwcGsofCzukqGl0wTzwPS7VwkLKWk
	kZa3L3pI0YvrsFiBxVZq5D46o8Iiv9fSlK5AWtWaKTQOPFzWAgGXw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg941-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699HN9Hi1169783;
	Fri, 9 Oct 2026 18:33:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s351xhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXbeb30474980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46D2958060;
	Fri,  9 Oct 2026 18:33:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E94435805C;
	Fri,  9 Oct 2026 18:33:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:34 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        stephen@networkplumber.org
Subject: [PATCH net-next v3 8/8] ibmveth: wait for the RX poll to return before freeing the RX queue
Date: Fri,  9 Oct 2026 11:32:58 -0700
Message-Id: <20261009183258.18624-9-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX3V7PPT4eUOEY
 zIL+tAbGF49xwqGeQA4jR3CeECneYX6bdQDiQQRzwIRzqnXfZ5y4XCjneGtoWgCwB66S9HnhvCK
 6vNRkCMWNeYxpfyW5YjkqO7F/m1On/c3JqeL2mOG4rfS6A7IoqmrLRfTqdujTdHYKKSwBfLKMI4
 HBfm0hIg/a7G1KJv2zG10M8RTNk5mZZWBtY4lufme62C42ZvZotNAvpzP17BcmKJ9G9Aj5R7QVI
 5PX+kD3j2jgomWpxK9Q+yV5NAInCAv/JztaUP36ybKHQJUGwbJM3wASZTAdIUD+q0Cia0VhEeNq
 xDPfojH8d2H05HCcSIHYOLqb/LyJEF+epd7itKC0K6rJQdAfr67+p6uZYJPSVzmquo2XIqCVsFT
 kLtbQugpyQFVK6llrllLcw0rU4ICru32GjTdILkZZAi+0MmJq7o9BFxgI5z+PggmbJBXf/hV+9h
 0j57JTdIdvAydfB9dGA==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac93384 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1jQH5Hc4uxvP87yPb2kA:9
X-Proofpoint-GUID: hiMxG18_hJMxAJkojVn-wUVgyHV1An78
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX6uQXN8IWcNGB
 KcFMDgB4pt0Fs6LswuuhG2ap1IJHvQLbBEvmfo55n8+tB0qWO33lIpsASmWRlWqJRHHaYsKylBc
 FK9+q/L68Cy3mQDUIkkiHZ/gMEcHzBA=
X-Proofpoint-ORIG-GUID: jpBxUvuCWwkhS7QhnDKDH5TUFYI2KWm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072

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
index 7dec7ca9753b..fc90ee6663c3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -769,6 +769,7 @@ static int ibmveth_open(struct net_device *netdev)
 			 netdev);
 	if (rc != 0) {
 		napi_disable(&adapter->napi);
+		synchronize_net();
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
 		goto out_free_buffer_pools;
@@ -835,6 +836,11 @@ static int ibmveth_close(struct net_device *netdev)
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


