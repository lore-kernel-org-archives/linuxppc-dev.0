Return-Path: <linuxppc-dev+bounces-28906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A37CA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:07:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hypp66p7Vz2xbQ;
	Mon, 05 Oct 2026 17:07:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791180462;
	cv=none; b=E7HxfNs2PWCYnFdGqadyadLm4nypoXJDSfkxl4Yt6b0/Oq+PgeqQF/QRpWafMD51bp4Yi8Ucqkjb207QrkmnlPRmUBK71qGlHj29Dz22NFp68HpvWUDwywWwm01dZiLGLROXjhJQgLmKt7RmTKj4EMaim+PpsKRVPtyocni1SdEW4U5DMqkYaeSzIJFeOGVx4pp51nDsW89q3ehdVlu/Unoag+rbIMcIdhocn6LOR7QX5SgWNyOj/tgBBG82r9Y3kKDuZSOBjp3jyFExY4gOI5HgHFPw6MvXCakl0eJV5im8rmwgFN9u/7SsQODs2jgMFQ8iIl3HQjqNtHoEnrXVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791180462; c=relaxed/relaxed;
	bh=E5rkQjd/Ryuda49pAbQfLqYEszgayqOEnQMRdlQc7O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHBb4iMWikoCZlO2M8GwbX26nRZwAYlS3AcTGIfFupMBnXGjtQ+lsbKKWnLvsMy+vggCAYbAHbaIH4j63BXYjV4IGNP1AiqSNG5vwTMkf5SLOgsPz54QTPFG1J6PUBMrrbT39IC07gJjWrT+WCUkEfJ1f7T3WiZrH0JNQ+wcIs9X2/HnXCd4E26ZDPvTIAXlhPFJagLERtbcZLgsU4Bf5zaEJGHxIK2gL7vcKtgf3/+FrPlpuSJhu6rYPjDOfOZuspYKbITRP1l2E08pbGn7iw0djQLa2K/Ndj7oacLG3w+qAtHOU4/nf/4cwfOVBMqFhr1FNJo9zR7GGlucO4lJiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mqzTA50C; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mqzTA50C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hypp53lM8z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:07:40 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515PGE2065654;
	Mon, 5 Oct 2026 06:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E5rkQjd/Ryuda49pA
	bQfLqYEszgayqOEnQMRdlQc7O4=; b=mqzTA50CJOf7J7Pe58AvCWy10ps3JSI+9
	b27PQnWRXke42Fr14akVT5c4SznnOcCH1b8crLqHJcaj5QAAGZU7GFbY9V4nFqXq
	IYuYEuvDsAaLFGMa+xMRqyI4JakvtZ3o7gheIrOCnptsWp3lO524+aVA4KzG3y7z
	eE1gN49zQ4sTSJirhc41TZVxuVn36LEJV66DPgCNZ9OowEKCrxHQG2U3mAA27y9o
	g2dJADSxfKJFmxFZCDhvEirzFxx+6iWOL3MjlIDfu9MGxNxtn4w1Y1FGl1hnOuxI
	JcS+So8zQEYZrP0SjetD3T/8x32E0yKAKj0bcwxwUX17NM05USy6g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3d9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:07:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6951HMdH2163432;
	Mon, 5 Oct 2026 06:07:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvm9jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:07:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69567Fmb4850178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:07:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA86A5806A;
	Mon,  5 Oct 2026 06:07:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 373855805E;
	Mon,  5 Oct 2026 06:07:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:07:11 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, santil@us.ibm.com, jeff@garzik.org,
        stephen@networkplumber.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/8] ibmveth: fix netpoll races with RX replenish
Date: Sun,  4 Oct 2026 23:06:02 -0700
Message-Id: <c193ccda2af0b2e91e839d5caa9928274b80f498.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33e96 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qzTZ72RhqM2DaLNR-rAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX4o7jVZuAl+QA
 sssX6H9Wg1hzgUwjQY5Jlw6izOY1lR6XJEbx2VKXqQ8MDcUdlIm/BfpyfKqPFhcS8fLKTud67XD
 Gj3gSTufCcvKDd+SyqkPN68AKVEaXyGRSG1CJTayJGW0ohiALvwG09iBYG81Cdmc8MhRKpXMELR
 D/8BhJLxU14zcLVB++y57rAxMjysbALQeYDN1HM9HICL1os4axT8324aa6WVDYwgqm/zEF8bM8g
 01RpPFoDAa+4O3XbHMjGFP9Y4X5VhhtcvRAyiRIt0SZ3m99aQSq18g4rA3//KPdR/7Xa2sDuYkE
 +MOC1l0EOD9rgDW4YoEjrR0TygpzA/niejn4gAepTr41ODW+9P84KIc4g02R1usd0HsKFAf4hzM
 HdcjuTLNH2ZdFktQ6HIcvcRp5pX3ISNDmiIYT0Kl8282RwNAqhAiET0vI5nlzZP8j1Tff3MHxDa
 C0T7vk3y1frhlW5ochw==
X-Proofpoint-GUID: Td8gs81fWhhR07w6oRKmcYwxExOPI6F3
X-Proofpoint-ORIG-GUID: -pwJkgSvnEbODkjnCbZFNdd_cNkLE3ye
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXwF3yd+YpsGZu
 1vcZ3dCnjgfWIpa23ibqJ/xltBi20TEO++kglDsPtmMotFreMbzgr8jIXtHr02hUjCHxaPHX/9N
 N8pqPJgC1PkiRpzmjh9td8zeJrQow94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

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
ndo_poll_controller"). netpoll then polls NAPI itself with budget 0.
napi->poll_owner serializes that with NAPI, but not with a NAPI poll
that was already running when netpoll was set up, so skip RX
replenish at budget 0, which netpoll uses for TX only. TX completes
synchronously, so ibmveth_poll() has nothing else to do for netpoll.

Enable NAPI just before request_irq(), once everything
ibmveth_poll() touches exists.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection of poll_one_napi() and the direct
close()/open() callers; neither race was reproduced. Tested on a POWER10
LPAR with netconsole over ibmveth: a ping flood (678,470 packets, no
loss) during a printk flood, and MTU changes and buffer pool toggles
under traffic, with no warnings. No kernel selftests cover ibmveth.

Fixes: 6b4223748895 ("[PATCH] ibmveth: Add netpoll function")
Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---

Changes in v2:
- skip RX replenish when ibmveth_poll() runs with budget 0:
  napi->poll_owner does not serialize netpoll with a NAPI poll
  that was already running when netpoll was set up

 drivers/net/ethernet/ibm/ibmveth.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..33af8e57be6e 100644
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

@@ -1540,7 +1545,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}

-	ibmveth_replenish_task(adapter);
+	/* netpoll polls with budget 0 for TX only, and is not serialized
+	 * with a NAPI poll that was already running when it was set up
+	 */
+	if (budget)
+		ibmveth_replenish_task(adapter);

 	if (frames_processed == budget)
 		goto out;
@@ -1680,14 +1689,6 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
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
@@ -1789,9 +1790,6 @@ static const struct net_device_ops ibmveth_netdev_ops = {
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


