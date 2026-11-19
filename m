Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5184606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b1N3HKQs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJgm4qmgz2xkr;
	Thu, 19 Nov 2026 11:07:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046852;
	cv=none; b=XNr3nQ1xUXM/a6YUqzMHJ4C2HLHKr+JcnjD5ogXhTgErv9DMalBao6dsG8YnguM9gTg6gP4VmiPFqjGYJ8WAXfGVqD493+qHJX4vEWeXv7puuAdj+7HPOCZ+T31F7oAz0srAAaBkQWYnh1sSMmXdGJ/O1M4TgyFy2uhH4o9nyYfI18uw+/IIEv/mO5zJJ7b8eguoxWn/JTgpt+kCqc2UvWxeK7AgufzHUKDckfHRpFJ6TGKVoygWaEySTThokUraEUEFcgQQTy3CtsnZB9tCTg1gyV+wrjlXy809RfzXUxTQRfd2TWpjEeiAP30SenbTFnQUSCU+PfFQ2ABTsNJ3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046852; c=relaxed/relaxed;
	bh=V7UUsaq0CzgMBYgcJ7Ry1gZbCKq1Dk3fOnzk4itrLTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPFKdSM421gkq0Cf7SMJy3uyrVdEHvFIHUnU5S+MUDq8Vtuqd35Rjsq7HMSPswI1O5htvrI4cDRYmbRlD0Oox8w3wl3/gn5eC6Wzye3TwP7HwHsADgfpofyrW6i6MfVnpM0jYB1WP7Noyu6HVLly8Lyjhnvo6tVsq5Vj4zZomJdOnjLUIWPrdHhzjNne7oaHm80Y52k9t0YFBu6iBWbibH9qgkjdm0Wmhz+hwgTqqlOIL8MRaUDLDnk3LdR9jwlkFpNape3yFnpGI0cbV9vOoZmyu9PLqerPTTvlonU5bMBSRJ+YBJ6+yITn+Sga7NYKQ4IerXTD3JS7EDp577p3cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b1N3HKQs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b1N3HKQs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJgl5Wc6z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:31 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQX071015283;
	Thu, 19 Nov 2026 00:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=V7UUsaq0CzgMBYgcJ7Ry1gZbCKq1Dk3fOnzk4itrL
	TE=; b=b1N3HKQsp4xNPiQXgbp1SZeAT0c8XzVOiZpHAt96p87RfN+Nq3+1EWNWz
	hSVKU/hu+ETYXUd+xhBpUBb+adtJ5mBEeUG3xOJ4u8KUR4fBb3061BDQLO3ky0FL
	zzS+fUQgzPt9tEIAh6AEgAzs5e54rPQalGH/vmAGrVKUU3OEBpHsvqAFunoQkMx8
	Bdji3AqbfzBIEGkVNlV2SKUwk9Bbg+sTYBeAFTLmiL2EYp8eUySYMb+6A326hZs7
	24NYOrHkVPEW38WaSIT4iRKfqeyZn1WVKrS53XEpoHFTyptVF8/muIv9LDUHPPP/
	1J1T3OuLqTBtKT0T1lurrFEv9E5jg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vw43n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILbKX93716164;
	Thu, 19 Nov 2026 00:07:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3hrd3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07GA723593522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D2D5805A;
	Thu, 19 Nov 2026 00:07:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC8EA58051;
	Thu, 19 Nov 2026 00:07:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 0/8] ibmveth: prepare the RX path for multi-queue
Date: Wed, 18 Nov 2026 16:07:03 -0800
Message-Id: <20261119000711.18093-1-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: qVrkezkKqKCL-_eYYOGyF2AXJ24_V9iM
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afe3db7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pTEnhOEyEOFkSSAe0uIA:9
X-Proofpoint-ORIG-GUID: xy5wQK48HzOARm2e0B4kWLf-jdsxLLr8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX7bei4lJXWDbd
 K9smMO/YvJzWjaud0kRVWEGMKC6JtWjpMve5YWlCjYlJYuRv0hRqB7o6gtbv+SKMk83iN0Sww+a
 BcUkulUgsSWELck8FuXT+dGT7qtLsyY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX9ElSKuWP6pCa
 iqFqpbSV39kV+RBxtWMDMyRpGUlRsc0e2qu841XG9NSPxHsU+f2be2qAaXthal0GJkIr8FXZGQ+
 e+KL7zO22a8mjs6ESg6kKEo7S0M2L4bW2VmciXWBV0HuB25vZas0RSERF6vCKPuy6fz6q3tB5vy
 7ornrEzT7e2+Dke90DWqOoem9ybT2agPTSil/4Hgqt4OzfroWU/C5c28igb7NJvy9QjEddSehjM
 Dm0f0OzEbD/OmSvlxAmc5X0qcciyh+O2Pk9XOx297YM6MGhO4SDQ9JHR6F0gbrqVUKbRUX5AMd/
 xd1NkYthd+kWAr3kjoS8w2g5TdAARYt2vxYKeOvdl62D8sRBnMPwmuY/mWbTqbATEYYQL2P1MwX
 38UCD5EaXXLzrYT/j40qoPs5F1NRCMnhPk3BojUPGTlnHMst5nkeT1T39zmjItoYR7qr/aFT+S4
 8ZlygBdbWIzatnIt0eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180088
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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

Tested: PowerVM LPAR, one RX queue. ifdown/up under iperf3, MTU
change, ethtool -L rx 2 rejected, TX shrink under traffic.

[1] https://lore.kernel.org/netdev/20261109235556.60604-1-mmc@linux.ibm.com/
[2] https://lore.kernel.org/netdev/20261116174225.7d9e9611@kernel.org/

Mingming Cao (8):
  ibmveth: Prepare MQ RX adapter data structures
  ibmveth: Refactor RX resource allocation for MQ RX bring-up
  ibmveth: Refactor buffer pool management for per-queue MQ RX
  ibmveth: Refactor RX interrupt control for MQ RX queues
  ibmveth: Refactor TX resource allocation in open/close paths
  ibmveth: Add RX queue register helpers for MQ
  ibmveth: Pass the RX queue index through replenish and poll
  ibmveth: Split RX poll into per-slot helpers for MQ

 drivers/net/ethernet/ibm/ibmveth.c | 1344 +++++++++++++++++++---------
 drivers/net/ethernet/ibm/ibmveth.h |   15 +-
 2 files changed, 928 insertions(+), 431 deletions(-)


base-commit: 6bc9aed3994cb04708fef02dd6d2f1cc5c5e8229
-- 
2.50.1 (Apple Git-155)


