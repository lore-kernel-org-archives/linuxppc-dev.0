Return-Path: <linuxppc-dev+bounces-28786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB93FCA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:57:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTLf73Zhz30B0;
	Sat, 03 Oct 2026 11:57:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992666;
	cv=none; b=Y9AFQZohJiYBvanr0Rsw008b8V+Y2NiiwgNiQf/j7QxD46uXKnfuZKaaTEaIkDDt1KasReS2lq+djKifuUpFyFHWL7ChHIsEevb/OHDhJI6bFQfThnmZO3zELu2lNoA2zmxVjU+2/u9f07ApbERy3wMomHf3dnxRIGImpfHsGRx7Tw5CTM0IKIFsPq6bKncY5C6/lWG52QPCp0hI9de7zYjT+c3F97SmAO/MR8JcqOo0SaQ6Ycu9FOfnXhuvo1a2dMHBPJ7uMBaYS3zVZlCDd3aO5fdZoMHhv+MA/fs04m/8Vy49KUQz7ja6LieH4nQ7YYA2jw7DrGSSAbzSAnbxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992666; c=relaxed/relaxed;
	bh=GPMp2H8ZDsAXte6hjWHGBoERRDY1KGqgBi4/rHPKQ7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkDyJRi2cPILvVK2D5drt+Hl/32UB+mFyMQZDdVz6/Pl8CDMmLbRk+YtW71NNXXV8WPADcFVHPnbJCeAsQiFldEYCJ1FJeht7lGRHao9NfiMHv11YHLPzGCZgNutgR3Oq37SoTdC4jNFRAEWphSnIqlCSX+O65y03LaeopXLps5/SAZdt1Nvgd8OTATPmMowEL+hvjO+KaQ1L0akcSkLPwz9BvQ/j0b1G9yfPqyD2WmiY6qsHSju8NCAi+SfbQdDA9CZMLX9ckWmWqOIW2HKFri1Efu8QIenMv2iJ+x+EtXNXtSezYXhggY7ItVg3Iwqiq1tQTIbXFY4msEfLX++Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QHHaJWvz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QHHaJWvz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTLc4gCrz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:57:43 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693079NG1899220;
	Sat, 3 Oct 2026 01:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GPMp2H8ZDsAXte6hj
	WHGBoERRDY1KGqgBi4/rHPKQ7I=; b=QHHaJWvzYEcbPEsU4Nkou9Z/mZMAie6MI
	ztQZ4FkPEYwDmjNgIIpYx/EQx5xxNE8ZBoA6LbwpgyeuoGNY18tnkFW9g6CCK85p
	KNFNNtp206VTfXGyXt6XXTrv3jDu0gd/S5vJRxVhKcS60bNZXBFc6t8oU8b8OnUi
	F9vdbS5u0OtefPcg7b3vbDpDey2OYahZw7Tnj1cQRZ6OdEtClBKGlOqq/UFQu/fq
	MGFWUJCPaA1XSNftUFiXmA93ygHqLrK7Z7eAmwcdCU/eRdWGhvZCFIey8co+lpJq
	UVp1nudMeCOy8dME1ucSRZlSyjYcEmwg4vMW18olhIcuYe3BQwcqA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5vef2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NlroG1988532;
	Sat, 3 Oct 2026 01:57:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h2kfm8vup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vWba25887338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B3D58055;
	Sat,  3 Oct 2026 01:57:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 105DF5804B;
	Sat,  3 Oct 2026 01:57:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:29 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 1/7] ibmveth: fix netpoll races with RX replenish
Date: Fri,  2 Oct 2026 18:57:13 -0700
Message-Id: <4efd18b3b511d47d0a0bacafa77ce3e007d2584f.1790991039.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790991039.git.mmc@linux.ibm.com>
References: <cover.1790991039.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX6lkR8ZftZyOs
 dcqMKweS6tHuYOsmJ2rErAifEtff3qH7TY3iahjbZhMb+Rk7JnESLm8RNf6l5R8oV/0U7zIUg4E
 FvkOCtkfPGndRh2HPNFeNaIHXyAMIuE=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6ac0610f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cwuRzhAPRJiUn7T7YroA:9
X-Proofpoint-GUID: Hb5eOzAGqp0FmG0CqjefUF0RKF9haxEl
X-Proofpoint-ORIG-GUID: Z8fDKquMtiuzC57Zum9vcTqpyvfHtIe8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX9TDumu4Q3yGJ
 b7ZQXJxdfFZNGH6TekLTmhsHqu7dfMdARqABOl46C0KYI4FNWdjfpoxNGdqDo62yjAm1HAZO41v
 Cq7KakZ9jiB3iHFF0JKyxNfAm3l/GLPBSGMhlZkeUYbXSpLKs06KpLjI1mbNkkEPDCZ4h1ec0Fv
 kXIN1vM0yM6jhs4O/Hrju9FlVaV92tlo5e1AagZtY7brXYbZx7SxZPHYSaoFB1McMC83p3IVb2N
 QQTIc0MfmhO9BWNiz5/eNmu6zr4kwwL50rzt/GQHp1kkMWqE0bbEZX/cgTORSSzO/P5njcPXacp
 QLGKAtp2EjI9nvAops2XzP7nWU2l/+jioRRWaO5bMTnF/OpQPXR6GXePEWH+SX6RsRuAtsu3VA+
 DpgerfOo/Vp5naJ01bOvuVIrW0sajNzw8sBrQ8rxeWxDGUgJjf1R45JSDMXeYZS9y4x9vxaZ1Ka
 E+q5D4V4Uvj4JwKvQ8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

ibmveth_poll_controller() runs RX replenish outside NAPI and without
a lock, racing NAPI's replenish on another CPU. Both can fill the
same slot, so an skb and its DMA mapping leak and PHYP can write
into an unmapped buffer. netpoll calls it from netconsole and from
netpoll-enabled bonds.

ibmveth_open() also enables NAPI before the RX resources exist.
ibmveth_change_mtu(), veth_pool_store(), ibmveth_set_csum_offload()
and ibmveth_set_tso() call close() and open() directly, so while
open() is still setting up, netpoll and the direct ibmveth_interrupt()
calls can replenish NULL pools and read freed memory.

Remove the callback, as Eric Dumazet did for many drivers after
commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional"),
including ibmvnic in commit 0c3b9d1b37df ("ibmvnic: remove
ndo_poll_controller"). netpoll then polls NAPI itself with budget 0,
serialized with NAPI by napi->poll_owner. ibmveth_poll() handles
budget 0 and TX completes synchronously, so nothing else is needed.

Enable NAPI just before request_irq(), once everything
ibmveth_poll() touches exists.

Neither race was reproduced. Tested on a POWER10 LPAR with netconsole
over ibmveth: a ping flood (678,470 packets, no loss) during a printk
flood, and MTU changes and buffer pool toggles under traffic, with no
warnings.

Fixes: 6b4223748895 ("[PATCH] ibmveth: Add netpoll function")
Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..aa2300e97081 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -623,8 +623,6 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi);
-
 	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[i].size;
 
@@ -712,10 +710,18 @@ static int ibmveth_open(struct net_device *netdev)
 		}
 	}
 
+	/* NAPI can run as soon as it is enabled, from netpoll during the
+	 * direct close()/open() pairs or from a direct ibmveth_interrupt()
+	 * call, so enable it only once everything ibmveth_poll() touches
+	 * exists.
+	 */
+	napi_enable(&adapter->napi);
+
 	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
 	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
 			 netdev);
 	if (rc != 0) {
+		napi_disable(&adapter->napi);
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
 		do {
@@ -763,7 +769,6 @@ static int ibmveth_open(struct net_device *netdev)
 out_free_buffer_list:
 	free_page((unsigned long)adapter->buffer_list_addr);
 out:
-	napi_disable(&adapter->napi);
 	return rc;
 }
 
@@ -1680,14 +1685,6 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void ibmveth_poll_controller(struct net_device *dev)
-{
-	ibmveth_replenish_task(netdev_priv(dev));
-	ibmveth_interrupt(dev->irq, dev);
-}
-#endif
-
 /**
  * ibmveth_get_desired_dma - Calculate IO memory desired by the driver
  *
@@ -1789,9 +1786,6 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= ibmveth_poll_controller,
-#endif
 };
 
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
-- 
2.39.3 (Apple Git-146)


