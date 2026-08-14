Return-Path: <linuxppc-dev+bounces-25854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E1C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 08:00:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvlj0kFzz2y8f;
	Fri, 14 Aug 2026 18:00:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786694401;
	cv=none; b=dwVkCFd2Xrf1XepvPqbVDsFxKZqvAW/Yw3f0dl0FjMsWy25rqM81zI1vbD+WBvY7LOUF0R14ZIWkUqRiD59CZrBn9rsE4SSzppZN/KLX8SGmmRh855Sik3kfaP5+bjKP9YQjd/UGiEihAlTmAuwa1KXeHuY/m88Kpjja2Mxu0cJqbzV3jzi3mxgXbZOh7wER6FBEFSbry8gjwIQ3yNdijCjxVwlLkHhENLFxOGy2OS2bqwt8VGdhwyqVhZe0TdISai2nwPP0QpLyWrMVptMv45jqZu92Ki2wlxq7KLoPMkwBDoeZJ7aOfQai21+4NNVp5feUYeMXcOd4Gm6w/dUSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786694401; c=relaxed/relaxed;
	bh=PbVAUNGx9/XtU8ujmggUMLnWn0arc3l3krHyL1I6sxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXYM5zcNkorEHeX67uyF2zqjdVS2ilP/zrc/gTEQnnrPOPazjRmbnSHy7J0EpmvJn+wo5tofYMHuOU9oT9/OCk32TwetO3jjLd7ThxKMY3pkO35iGfkEObAWWFDQPaDR4xpFpXbwZ2iUu4v4OUYfgFOYeI/wudvNnJexZBDY7zoWB4wLyPVV4ffv3Q5im/Sq3F9ql6ck1IuiVN7wok/dpcKjH2baJkVpAe1njxi1oLM/ih3R8fuQ2DlsCrnLO2FZDN4GzYQFB2z0k4HVEx2a1+HE5f+JDWHi6g3P86AXB1T29jVPDsnL6h1igWY79gwQLj/IXaZ1Zk704dp3sPrzwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mjCAuhHc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mjCAuhHc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvlh1MJfz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:59:59 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4WN9w059711;
	Fri, 14 Aug 2026 07:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PbVAUNGx9/XtU8ujm
	ggUMLnWn0arc3l3krHyL1I6sxY=; b=mjCAuhHctJ4ID4+1Xr9TWaUIcSu/onDi2
	sgbcQa2yN6qLxmtxQJppNyjjWzejXhiBLLqlSQE2kz9zuLpST0RkhpOtX0a8Olbo
	mrJ74H6ApltLq69ofIMf99DEwz2vgwu85PzaxbFZhaSSrkIg9W3g6sx9y2mS/IC4
	IODbEoqPD7kLFbF8XrnYhbbytaIEeFmgyjxSFUWMzfW5ogebu7fIU4ZwSdOgS3jj
	NAFSWy0equgc1qaL4BhvBi+1FnzdDsWNoyjlsTdQ7xOQ87liW1e08ZT1omOkBH3K
	wPUKgM7m8MTIoMlHPnqW0MPT3G88Huda8kUpa9rphXOYIxmfu5JFA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3amq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QK1J017907;
	Fri, 14 Aug 2026 07:38:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wegca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cKrM18547288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5CD58057;
	Fri, 14 Aug 2026 07:38:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C907B58062;
	Fri, 14 Aug 2026 07:38:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Fri, 14 Aug 2026 00:36:39 -0700
Message-Id: <20260814073642.24630-13-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260814073642.24630-1-mmc@linux.ibm.com>
References: <20260814073642.24630-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ec5f1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=PA20WcGQiNPz0IH_SaMA:9
X-Proofpoint-GUID: OFY_pIYdNsnMHERuVagvMTdclJeUo0W5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX4M+9+NbxmhbL
 N2a4zIwmYqkGt+Czu0KwV3u/qkGKaICmcHH0xMDqM37auC807ZigNf3+1J8j9I1duI+6ulM0/kV
 a8uDLTQRmKJ6lSRM1N3a0b4efseQOf/iMvy39ETN6RQ6e0m6NTyxIGu2w1TGm5I76fR8QbaJ62k
 +T7H7MYFpdusxjp73J0WX36gywAYWIxruarj6qjrSPcAKhu2OLi7wCNHAbNgNXXqdNMpmZ/ECdr
 AGuRh0rqd+xxOJny9VK28/s5Vwr68MrkaUBQxxSB7miX62Hvx33i9W02lCSbBr87Y4PHEKZ9nQ4
 xFT2Be91i6/jILff/WV1YeZKawki3WQv3TTN5CIJRzSucWi8IZJl4xuPPUVsTt+HmlDUNuIJm2k
 lpRc5NwNS1dQBe4kqqu2WCjIWN952vlv9yGaVczONL8VC07EROT7MuImC1gbBJLbKJscaztlMER
 8tmzlAcHgoVafGznW8A==
X-Proofpoint-ORIG-GUID: keTKK_sb57NeJGs1ev2ZJFw4dfENrEur
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXxpy/nK/C46SL
 nhbSoeZZDvTRdfbpHerqwqGeOR93yhwB/RJsPrqteaPZ0B4zEfagjHy00u20nwkIAZbrOcn+t0Y
 xTkWJekYyVaekL7c1ODEDe+S6nz3ZEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

Report MQ-aware channel limits and counts from get_channels():

  - max_rx is IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1
  - rx_count tracks the driver's published num_rx_queues

Previously get_channels() mirrored netdev->real_num_rx_queues for both
fields, which under-reports max_rx on MQ firmware and can disagree with
the driver's private RX count before the next open.

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
index 3202b657c9b8..5d4ca4b3d3d0 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2522,11 +2522,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
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


