Return-Path: <linuxppc-dev+bounces-26316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F453C624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:32:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXzW6491z2y2J;
	Tue, 01 Sep 2026 01:32:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788190327;
	cv=none; b=kBb2TvqlZFym9BWr9An/0hUcg6HN/NhiQmx8ec9iIXRox0mbW4l+nhMb3Q7r5u+pmFhGzS3nPKtifoefRoyk0j2OyIya3CUM+IJYEzH6+ZQ0MBjkAnvzix5U9QMXRuhlMZMeGefE52oCBPuHSIRu4h0iJi/ZpzML8KtR/mZTVQhQZh8tgtQlCMByox6I1yaaYX36GRCwloVMPCP/ZAHkOAWWepkv3t9L6QcDRW4dPzFMs/RyGKGBXdVDe8LjD3NeSi+IXXVfv0ZnSDeJKIT9W5Z5SGUrqHLqBZjZ+UseZ6lBuNBbtJPPIVYiCtWv6OexIg2nrkc90lt80E2S6uPG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788190327; c=relaxed/relaxed;
	bh=qXiUS9cnHmvWCR5zHrBW7aSpP84nELBQAgNQ8A6DfTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCb8zCSLv91Z1rQPudgnWj7rHVk9JEXc+F75EKb7K11lT/ymCqwBbHMYtavLD6d1v2SN3sSqAVFbRutYADs+Vx+t+QfwHRochT/tHoZ14LvWjj1oBAPw3ibtN3VxexDS+e7UP7EA30Gn2abDOLrCifYPuiv6E6w4U3dIr6bnINbRN3a0vQKddysFjHRTcUrOmNKdVv1v0xYFWU+OxUpd7zEb/Ur7Xd/29luPYgGOOKP1yOpgxudz3w7WUKM1aQl7dKlI3v+XJgazyY0KN+N0X98U85tIH9Ya44HHAZxO28IMi4rMWJE38M5Yjz/DtKLTFfpSc2UbrukIfv1Q7CRWBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dW3lxOL+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dW3lxOL+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXzV4XPjz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:32:05 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9vO2582959;
	Mon, 31 Aug 2026 15:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qXiUS9cnHmvWCR5zH
	rBW7aSpP84nELBQAgNQ8A6DfTY=; b=dW3lxOL+FQvP11eITzIzjila8Cl/AMJPA
	hmmpjcsk8c/1tdetqIhTr9uySah/m4OqAfsRx4vDGArmJcKz8Mgp2Og5nqLJjPKK
	8W1qBewPzAHN3M0fOAc3B6nT2lAxR/kHrlnCWcTZNCIVRsV3lV22fNlHkDcS6ZKj
	lSHA3IcdtLj2vPho/nGGB3uR4xZ+/GyLmbHEdXQXWAzwsnt7qfbdv2AOP5uTaH8y
	K3wueoLyF9vKhOqiyyOqvbMJpiWbdYmOrB7beSWflW4ktPI1Ndjvw744B3EBZdh7
	TbBATe3Wzt4k67cWGc5ssMT4Pl65JzZA/GNILyIGXsaZjhhm73GFQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1x72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuJJp005205;
	Mon, 31 Aug 2026 15:09:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6g6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8Gjo15139470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02D3E5805A;
	Mon, 31 Aug 2026 15:08:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 474A858051;
	Mon, 31 Aug 2026 15:08:53 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:53 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Mon, 31 Aug 2026 08:07:23 -0700
Message-Id: <cfd6de05a68cd8a4f61a1f1e9e1c45a7d9ee2687.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a95990e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jf6yR0tB5JmaUK2__HYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXwWWz8cqACiJb
 RBz6dH6d59ZBclA95Qbe+SXUXmV/ltCygAx43LDaQ57mYRMbLBB0E4GBxWpRJcQslbrBX58ywY9
 MusC1k2odcFY0wvRHAbj97Us+HH0xiI=
X-Proofpoint-ORIG-GUID: f5KXn2Xy2ei4MCrAOt-z7jQr5moQn85W
X-Proofpoint-GUID: EVG9eo3sx7vEn42kYccU3jo-HFixA1r5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX8U1piN3xiQGR
 YaFVn0N/KQ1+TLDfI5ybySQ92YZ9IDS5UJ0M/GWJE7ue5sCGNGkIynj4s1HrIgGoy4cUd8cI8ae
 cXYmMc4NWtghgfFrcsdwyVX0MrZaxHoDo9I7YYXELTfGC7nwNwzrM0Gz1bGPMFowykSNhsADCkX
 cvh+FirkwpquFHRzk7lgz59jtVXYc/umePmU0fXor9mub+cSnQB03tsVx2esY2Yoc8JPo6KqxER
 H4E77V0HNxRZmAqsmNrQTM6T9nmqfnx3cwGJqImOrMxFR16s1kk9idg4Dx+6PUEa83DwPijxosy
 PTWHV8irVB9fASLzInNH3oZMxcrqVzEswHXZ92Vub8er9xGu/RxmzCVqFUya8G/Sd8AyY9Tn3kH
 n9MbaPElIxhXV9aKpUOkVwEA+jHQK3t0jtwh/llHFfbrOZvuyjEtu9vVLnWPXM1Wa5x5SWi5aC9
 LgA6pm/GXYKfHuTHYPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

Report MQ-aware channel limits and counts from get_channels():

  - max_rx is IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1
  - rx_count tracks the driver's published num_rx_queues

Previously get_channels() mirrored netdev->real_num_rx_queues for both
fields, which under-reports max_rx on MQ firmware and can disagree with
the driver's private RX count before the next open.

This patch only reports. set_channels() still reads only tx_count, so
an RX channel request returns success without changing anything;
raising max_rx widens the range of requests that behave that way from
the live count to IBMVETH_MAX_RX_QUEUES. Patch 14 closes it, with
set_channels() reading rx_count and calling
ibmveth_resize_rx_channels(), and patch 15 completes the down-path
publish/rollback and caps max_rx once mq_fallback latches.

Keep this out of the stats patch: channel reporting is ethtool -l ABI,
independent of per-queue counters, so it can be reviewed and blamed on
its own.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- get_channels rx_count via get_num_rx_queues() (READ_ONCE consistency)
- New peel: get_channels from v4 stats -> tip P12 (14->15)
- get_channels: max_rx = MAX_RX_QUEUES when MQ else 1; rx_count =
  get_num_rx_queues() (was mirroring real_num_rx_queues for both)

 drivers/net/ethernet/ibm/ibmveth.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index f4fddfa56571..4f2d956b4c89 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2537,11 +2537,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
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
-- 
2.50.1 (Apple Git-155)


