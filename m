Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87A60A2618
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZoKa+pFT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmt83wzFz3bl7;
	Tue, 10 Nov 2026 10:57:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268640;
	cv=none; b=a0U97F52FfnLFFnFXqV9hhCmWwGjBPvb6cXTUu7tu4AZEiK1UMwHmXHFkW/E/d3RQ/CJNrothCXW5rjfXb8pqT+tXu/YDNSq5Q/1DktmI+1PHbwYssfb2dTkmzoSKrQ+H0nP6LF4budpcV1G6w9UYqJl+Z09OfM0vYmo5Bmipg+ys3iLZc2BjdLa5zAghlHbTOPx72Kid744RtJwgdy8gpbrk2eE/l3Vc/RTm7FuP0VKGjPr7+P8PM+cUlM9/ISzZEC8r2jZSBjRbVd73mzcF4XIMEzD8wk/ksv8YtJbEXikjjZC2EiqzTcSQR1Oz33J/VNLbiQs/Mq3o9XrVc1o6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268640; c=relaxed/relaxed;
	bh=aYmdUIdy4uuwX+FcOsoquIBAoon3hB3dOJMlA08DCr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzfYClAWOha+yLkE9PsZuumxrjetGTVpX5zXz8LmyAdWlkpTWgS17g3TCXLEgMpcH9KU4IsAeNk2pcFMkUI7OikLY7b+WlfrTr9MVKJ9ArgMST05yIuTq/YKSz5XoMSr5KpkbKwfPgiKEFrROx0SuNTXgaI4VXQmTSdn+N/zmxaDx9UqCfGR0KKPnkwbE2biWlNWDUwEWBpiGDuNtymwj1TewRTGcE9v6tIHEXy3sg9v4RJ86CdTO/dwQ0NpaiIylKAs5gUhZn8qFJk06Q8zU1V4dPgSX7gmpUCYgvXRnh466NP960wboKUv8YKLUKzMgQwyBsBwFGCv7UEJ9reijw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZoKa+pFT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZoKa+pFT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmt72Pcsz308Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:19 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEI1s512655;
	Mon, 9 Nov 2026 23:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aYmdUIdy4uuwX+FcO
	soquIBAoon3hB3dOJMlA08DCr4=; b=ZoKa+pFT1sBWdx3eSCQFoQTK0FKENn2Jf
	8hvdHOxnkTTaniqqC63SCKZa0Ux1PmXB6p5mLZeYnILLRybHpNfOxHMKShj88oPI
	NzKadFIlz1QYTFvdYitD7s6RlWis2V7dUlERjmiCFbnd1kf+L4Y1S+M5k88dz+jo
	NAZsX1IYBq/jKzXG+EkJlPt0vH2TRHCwzEB/4ACrIPclceJ09MWubRV9rnJLWpCt
	boAFA2EMKU/adn9c2Dx8zkFctk4A8IaxlcbIHU86xcfo7/mtiYvlfpg/mG6Hydql
	1n2IFjo1O2X2Yzii1id7UmMRy7WAhyIgpMMQd/X4lORphjFSXfUOA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumusru7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LK05m812485;
	Mon, 9 Nov 2026 23:57:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y42et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nv4vQ64946624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:57:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBA758059;
	Mon,  9 Nov 2026 23:57:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D7CD58028;
	Mon,  9 Nov 2026 23:57:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:57:01 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Mon,  9 Nov 2026 15:55:53 -0800
Message-Id: <20261109235556.60604-13-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXzEAYG0EnRxAQ
 YT4qk5cRWl0NEga6zP3AqByjzLpP9nN9HeaM20bA/TpnXlMcYP9t7JGrZX4+HAtQrcqLGunUTLE
 sGeGSBMA2xJPASjO8F6lz/Av3ucAvkc=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af25dd3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=OHkRmo7XnONMdPLYg5MA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: wVbhvH-MnqYPJe-c9hNlo8VDXvc_bVwo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX40UWc9PnSUod
 wQyDyutNzF+Y5qa/0kTW43nHTiDCHLFAkRrNKi+spVzAjo15+FQu6nx+2B2Jq7zX11RMDOvC9j4
 /ecoXZsk6R4SpnQ/Vm343C1dCtJuB8EfT3sZ4NpM2SOWdDZp3sGSxbqyYqbyTLnbbuLwkJPNj6f
 YheSZ180EjcnV+/lU8ecP3duN2GsJgg8j/Jmr7J8hZCiygap5R8yoyIisP0ustdEqa7hUe6x4sc
 Vur7SnD2mrrRIY34cJ1gmSjFWTu8gBeZ9W3yLEqD6Mq1QeEQVvjO3lmDvSXnDSMd4lf+FKzHmWP
 x/W3BIyjWoZf4vlQsYbg3mFqsqHPShgd33b5wbokXlJJ3l3iWcEBUOl9X0TcMhh8InvtxMEVDoI
 JA3eXzPQR5Yb/QtAw1fhBZUJ1DUrXfvowxDwI/UiJX9CgdqRJyqMu3dL+LhlSBfe0SuMYfbWksd
 VkzYT6Lwc2XbFKGStxA==
X-Proofpoint-ORIG-GUID: uhh0evd2nws06A1bEcv00w133KX5a88o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report MQ-aware channel limits and counts from get_channels():

  - max_rx is IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled and
    mq_fallback is not set, else the live rx_count
  - rx_count tracks the driver's published num_rx_queues

Previously get_channels() mirrored netdev->real_num_rx_queues for both
fields, which under-reports max_rx on MQ firmware. Here every publish
of num_rx_queues is paired with a matching real_num, so rx_count does
not change yet; reading the published count keeps it right once the
resize patches can publish a count that real_num fails to reach.

This patch only reports. The set_channels() rx_count reject lives in
the MQ enable patch; the live RX set lands with the incremental resize
patch. Once mq_fallback is set but not yet applied, rx_count is still N
until the next open; max_rx follows rx_count rather than dropping
to 1, because the ethtool core rejects a TX-only -L that
resubmits rx_count above max_rx.

mq_fallback is set from the replenish path without RTNL and is now
read under RTNL here, so its accesses use READ_ONCE()/WRITE_ONCE(),
including the two writers the MQ enable patch added.

Keep this out of the stats patch: channel reporting is ethtool -l ABI,
independent of per-queue counters, so it can be reviewed and blamed on
its own.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- get_channels max_rx is the live rx_count when single queue or once
  mq_fallback is set, not a fixed 1 (the v7 patch 15 cap moves here)
- mq_fallback uses READ_ONCE()/WRITE_ONCE(): replenish writes it
  without RTNL
- the set_channels rx_count reject is now in patch 10

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

 drivers/net/ethernet/ibm/ibmveth.c | 17 +++++++++++------
 drivers/net/ethernet/ibm/ibmveth.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 45adf6e9be09..1e2e845f8011 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1306,7 +1306,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 		dev_err_ratelimited(&adapter->netdev->dev,
 				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
 				    queue_index, fail.batch);
-		adapter->mq_fallback = true;
+		WRITE_ONCE(adapter->mq_fallback, true);
 		schedule_work(&adapter->work);
 	}
 
@@ -2152,7 +2152,7 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address,
 		if (rc) {
 			/* Firmware MQ gone: fall back to SQ on next open. */
 			if (rc == -EOPNOTSUPP)
-				adapter->mq_fallback = true;
+				WRITE_ONCE(adapter->mq_fallback, true);
 			goto err_unregister;
 		}
 	}
@@ -2192,10 +2192,10 @@ static void ibmveth_apply_mq_fallback(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 
-	if (!adapter->mq_fallback)
+	if (!READ_ONCE(adapter->mq_fallback))
 		return;
 
-	adapter->mq_fallback = false;
+	WRITE_ONCE(adapter->mq_fallback, false);
 
 	if (!adapter->multi_queue && ibmveth_get_num_rx_queues(adapter) == 1)
 		return;
@@ -2756,11 +2756,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
 static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
 	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
 
-	channels->max_rx = netdev->real_num_rx_queues;
-	channels->rx_count = netdev->real_num_rx_queues;
+	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
+	if (adapter->multi_queue && !READ_ONCE(adapter->mq_fallback))
+		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
+	else
+		channels->max_rx = channels->rx_count;
 }
 
 static int ibmveth_set_channels(struct net_device *netdev,
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 76640bd5598e..66288f8e8349 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -374,6 +374,7 @@ struct ibmveth_adapter {
 	char queue_irq_name[IBMVETH_MAX_RX_QUEUES][32];
 	bool multi_queue;
 	unsigned int num_rx_queues;
+	/* Set from replenish without RTNL: READ_ONCE()/WRITE_ONCE(). */
 	bool mq_fallback;
 	/* Lifetime: true while RX IRQ handlers / NAPI are installed. */
 	bool rx_irq_setup;
-- 
2.50.1 (Apple Git-155)


