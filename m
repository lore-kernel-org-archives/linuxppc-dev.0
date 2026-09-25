Return-Path: <linuxppc-dev+bounces-28223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC25FC9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:40:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzym1zDwz3bnq;
	Sat, 26 Sep 2026 04:40:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361600;
	cv=none; b=XBOSHRxvRQCpXTrvg59kMXQd63s9aj4HFjp5yjq4N/B0Sy7TALKVLNVH04stFNgss/xpJnAxwinaDDyyixRRaIIoZS/RVGRr6kQgcPNYYejuUrtooUFm5LrvVF+aVg7GvPXL4NjL/7uIp3bm3D/jBC78LpvJHc5acWJiGe7oLMnb5CGkzt2Zas7MOvBL9G/Syli4jIPV9bPYY5aQTu5LVjPZz8g0+X0mnODMBKred6YF4Kf28G+lCaJ6hHTS9yGNKKWMGOxVjJgm5JrXBLpcAw76dR6uquh/3RTzkhtka8/YzTJ1DZrVJ7KoWezA9tOjgtgHUHPhsxhRT21xQQSykA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361600; c=relaxed/relaxed;
	bh=QtgiBT9z7G8F9V861uPk2DW1iAfcdeoyEs3zwuImSvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjmLDwazO4/PcAjbgObkRXHX+EVQb3omTx8tBoZlGCIKN/pr+btjSRWF5FgUYFeVCJBoahB67lbiJgEzpRlzsCesoftI/L/p0iBqF4RIX0rvYgo9D7bfblmzHSpH0ffVSZlvwDCp1sLZSR3dvAbPSRGqjem6lBWcpW7YPJgNjtMXBeFizQ4zkWhNOF0RQtvuHuxMPK/3JSOlmjBl89+qo0c7FP2UGA3hawpJxZVGymIycQJ+iXr281TAjvyCal+lVFmmI+6THcaEVYlr+tBEbZvW15WMkw8X7ntLTeqpfw+61StF2xAqTR4IpFi3fQ6a6WmuIuIebO88F8DCinwLPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JTUnbkXw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JTUnbkXw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyl4c2fz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:59 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5UUt3853832;
	Fri, 25 Sep 2026 18:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QtgiBT9z7G8F9V861
	uPk2DW1iAfcdeoyEs3zwuImSvo=; b=JTUnbkXwJtrUtmiRJ0dWk2B4YEOmfKZhE
	Wg03NPPiDf/yc265O3410mJ9InpBKBbJOl8FPwnzpv8PzjuJKr7gcEKZ0fjCVymx
	5mEpKvIr7m8K9yHx3wAPMI10ALsFR4VVKLnj0pjhWnoFcRy0i9Tg9T8q5iKp2bQF
	IQAuRQqeTf4wVfv55bEwzH6wqx4cOhhXPsi4lS+OSczhCsdAwYUAFaViwzqtXilT
	cuCssWKUiSTkhggC/p2KFq1u9GPJVcB70rqAz1AZcaiFAfpMvAhrLWmZaL1TgGMr
	+L4/Le1LLr01TUbcgGfqgga8Q5+eSxKX66ocl5lgl3XLWakNOqfXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske28ney-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG3CW34186689;
	Fri, 25 Sep 2026 18:39:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe23kcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdl4v33030858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86C555804B;
	Fri, 25 Sep 2026 18:39:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9FBB58055;
	Fri, 25 Sep 2026 18:39:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:44 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Fri, 25 Sep 2026 11:38:47 -0700
Message-Id: <9560e3e3b0fa2e90312660d6f32dc54d1073f8a5.1790319558.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790319558.git.mmc@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: BYJ4kLo5NDyYZvjtfoi3_HxWLNX30q0D
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6bff7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=l1mR9hybHIHeT_AEzh4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX2tDdA9WD0RYV
 o5an5qqFuBc7YxRs43+E+sHtWWmcK8UDUcxN4gGApulYjLg0T/1MV97ZIEA3Nkm/36e/6Z4wMLm
 B7Fr4TuMx62eR4mvEiPD7ElqRS7aKH8=
X-Proofpoint-GUID: EkRxSffwfWYabom8BKFITwG_oSRPD0Qc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXzRFrS6+YbD64
 +DpyC6nRt7opCwK+24yUW1tsnREpDaCQG2cPFgCnk1BO6b0xstXnVAW1TyhaaX0T44KIkK4geF3
 arWkFhLOn94AkJx0voWbc+1345MzxZJGmN0CkM0wOI3phK1KBfLw+VUG6fO22TeTcGrzJokawrl
 hHtfUjyW1TXFGU05FBaY6QZsOxJF9ghcqVyab2G+T+9tPYwvi+c2M0ZelYWWi63iRArB2rkB/Vh
 oXHbbezbXl10Wt9CqVy+WrBb7HveeRl1wYmTlOzqtf1aZFYMaU4dquucm/pP3IPxZ8WDDyLdnpV
 qHA1aQ1QZjAvWlcu09ocktbMh1SdMVvr/Cu6eyUhKg4lmAFzLBePswY6OyVORFAs4Lks8xo5aTH
 LsWYZFfz6BRntPkM2FdWMsXSOSTo/EC4v6ljZhqR2K+dj54oHR33uljGHfhK/gwvlUTi26qwVR3
 PjMj7KfnmMi8txrziEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Report MQ-aware channel limits and counts from get_channels():

  - max_rx is IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1
  - rx_count tracks the driver's published num_rx_queues

Previously get_channels() mirrored netdev->real_num_rx_queues for both
fields, which under-reports max_rx on MQ firmware and can disagree with
the driver's private RX count before the next open.

This patch only reports. set_channels() still only adjusts tx_count, so
an RX channel request returns -EOPNOTSUPP if rx_count changes, while
read-modify-write TX requests pass through with the live rx_count.
Patch 14 implements live RX resizing via ibmveth_resize_rx_channels(),
and patch 15 completes the down-path publish/rollback and caps max_rx
once mq_fallback latches.

Keep this out of the stats patch: channel reporting is ethtool -l ABI,
independent of per-queue counters, so it can be reviewed and blamed on
its own.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v7:
- reject rx_count change with -EOPNOTSUPP in
  set_channels() until patch 14 implements resize
- noted: TX-only read-modify-write still passes;
  max_rx stays here (reject, not reorder);
  get_channels uses the adapter count,
  get_base_stats uses real_num; RX max is
  MAX_RX_QUEUES, not the TX CPU cap; P14
  wires live rx_count resize; P15 is the
  tip ABI (live rx_count, max_rx cap on
  mq_fallback, max_tx at least the live tx_count)

Changes in v5:
- get_channels rx_count via get_num_rx_queues() (READ_ONCE consistency)
- New peel: get_channels from v4 stats -> tip P12 (14->15)
- get_channels: max_rx = MAX_RX_QUEUES when MQ else 1; rx_count =
  get_num_rx_queues() (was mirroring real_num_rx_queues for both)

 drivers/net/ethernet/ibm/ibmveth.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 2575a7c11afb..cd2e5e4a81fe 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2546,11 +2546,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
 static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
 	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
 
-	channels->max_rx = netdev->real_num_rx_queues;
-	channels->rx_count = netdev->real_num_rx_queues;
+	if (adapter->multi_queue)
+		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
+	else
+		channels->max_rx = 1;
+	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
 }
 
 static int ibmveth_set_channels(struct net_device *netdev,
@@ -2561,6 +2566,14 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;
 
+	/*
+	 * RX channel resize is implemented in a later patch; reject any
+	 * request that changes rx_count. Read-modify-write TX adjustments
+	 * submit the current rx_count and proceed.
+	 */
+	if (channels->rx_count != ibmveth_get_num_rx_queues(adapter))
+		return -EOPNOTSUPP;
+
 	/* If ndo_open has not been called yet then don't allocate, just set
 	 * desired netdev_queue's and return
 	 */
-- 
2.50.1 (Apple Git-155)


