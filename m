Return-Path: <linuxppc-dev+bounces-25158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3498C55165
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:49:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6r50wvKz30Fk;
	Fri, 31 Jul 2026 10:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458901;
	cv=none; b=bhB+f1Qao+eYTwd2RU2RKN4GF426+VNWzicXvyWhKE58YakKpizQ5sVqqyk9VM8LZryagbDpppKe3Oc5/2QT1Wjffs326cAUakHpPlM0l8P0bM2lr6aYkEE6e3KXMWderAgKKYYZXn3llaGnqLO9d06pc9NHTtEYXDaVcTMS7lowXwko37f5/3Mc5kUxxJrWqoxsuC+G4Hc1N28XqYbUT6x+vCGm7AG6wfjmD1GW2vQHOK3K2joTQ0aUOF5jq8uOdXoQunCT6wv4sTwLuFFjpXRcUAabqTH1nV1V1Xm9FJvymF5qvIyR5D4pLWoUSyzLcvyfycPGX37zj0UV7jVNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458901; c=relaxed/relaxed;
	bh=zLJ/dafNENzfjD/t8jWh9w+mUrIC4ukWC462Uy06lNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROO+ThT5fWquYg022xwp8hFz8NvwjYRurjDuWn1IkttYoX1ykkfH8G1N0KhiIjJmRLnLh4meZmVmXbhRBHO617ua5aojkRDARUOhD0aP7sMZffnV+7iZshVc3Wh6KNgzViDY/0A0IL2QgyHMdFBUl17JwZzZ0J3hcp/kNhffLuxLfXe4SVgDAKe68AhJHemV5HUVFTy7DNQvgLwYD8594tY0nG78jlTrgdW2M/UJM3fRhOAb+DSLGox/WHmYHUbawuDWYpm8OwxS+LXypxhMHGjCupKJk1thcUcJOfVz2rMbhPFXejUjT58N9XtFTKqO49Ynp/tT63KvkiJXTYJF/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JW+KYbYK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JW+KYbYK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6r42CvLz304N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHqI8185235;
	Fri, 31 Jul 2026 00:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zLJ/dafNENzfjD/t8
	jWh9w+mUrIC4ukWC462Uy06lNQ=; b=JW+KYbYKgxVy6WUtLgVepgFNj0cN9Qonc
	znhtH9EeqgnSiQfFAmqa8dQ6fv4QKt6Wz0hOJ/bJ9Fng9kdvFoCdUSKx32B0AKj8
	q4FN0+O43i2tK24JhSRb/EPYjHxK2Ln4WEIkaSGWJbALC3bwK2kM6Uc23jUcA0Zo
	87ArP0roBRqUmXMkUmRL0UQW/bqVzEdoejG4b6Xrb0qxK7YuIbey1KcEXtPokHUA
	uvmly9TYqvLFqY0KX2bL5kTYfmg/qxTFgu12a7LCWnZgHLqddZBCnjjow6v9y0h4
	Hl2W5VIO8tOn2FWdWxHOXUzIBPfAs3h6fYuVf7DG7xmLDpEPCduRQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7tkcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fJc1007448;
	Fri, 31 Jul 2026 00:48:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkdv1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0m7oi59769134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:48:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D70C58063;
	Fri, 31 Jul 2026 00:48:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC7E58061;
	Fri, 31 Jul 2026 00:48:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:48:06 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 13/14] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Thu, 30 Jul 2026 17:47:16 -0700
Message-Id: <135011a5c18abead73784a587ed20d1518168a2d.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: e6x9EFFRHErqV1tHOKujDENHsf7kHruc
X-Proofpoint-ORIG-GUID: WNLQGtvU274q4di16EW5D1RYK-Wa-OAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX4rA9BPWFyT06
 SxDX7Q2/7zR9kEQ895giBm1cT1DyjMjmOMxT1Iy8Y5s2KT5zRQ3aN/uiLJlISII0Ws5gIzl3iLd
 rNumZphQKD3/V2q7SfvBeTUKmVsYg60F4chkHJasKC6x6ezy1TGIsKrgeQdxuAjZOIYcmcqJ9nq
 fwBKaxGe9zwpJUAZcQwzRZg/+adovpx5vcCfbUrk57x9TwnV24FXl1UPHbM6YSNZNeSggOIGp6I
 HsGskyXxnd5bcXQMeHaYf2CL8vWwec8Y+uoqMH4r1Hap9zYttXwcI/0AWNufP5Nv92wN0ALgBrj
 IYhd1VM8Jj79BNseO9AKaYcAHyX10XWzKVnhn6fwfWziD54gSDvbpzi5JztCUSyeucy6nrHMXTR
 pPs1MzFAEpA5p5RgwsVo49XCgJOsaqHNZwOXzhkGoHSaOJKXjQAlEOHo80oiwO5q2Ba1V1SI095
 7pfpuFJwAxAgijTUWcA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bf0ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Myu75y3gW_q-F6-6Ej8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX+aIO1Y3RMk1x
 MkbqP7EpD+CrVNjanXLzmWw2ZTCwb7Eo3zQR+GnQaOiePRulMbZOVTTAouVXDMlW8zsolBUznWa
 VFQ1f74IykxMkHo7+4Zg31H/Z8lKN/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310003

Complete set_channels() RX handling around ibmveth_resize_rx_channels():

  - When the interface is down: set TX queues first, then stash the
    desired RX count in adapter->num_rx_queues for the next open()
    (open publishes via netif_set_real_num_rx_queues). While down
    there are no RX queue mappings, buffers, or IRQs to grow or
    shrink, so do not allocate immediately.
  - When up: resize RX via ibmveth_resize_rx_channels(), then adjust
    TX LTBs with the existing stop/alloc/set_real_num_tx/free/wake
    path.
  - Non-MQ firmware returns -EOPNOTSUPP for rx > 1.
  - Validate rx_count within 1..IBMVETH_MAX_RX_QUEUES.

TX path hardening:
  - Initialize i = old_tx so a scale-down path that never enters the
    alloc loop still has defined bounds if set_real_num_tx_queues()
    fails.
  - Always return rc from set_channels().

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- On !IFF_UP, stash num_rx_queues only after TX set succeeds; do not
  allocate live subordinate IRQs/buffers while down.
- Initialize i = old_tx on the TX adjust path.
- Always return rc from set_channels().
- Split from the resize-helper patch (same split as v3) while keeping
  a live caller of resize_rx_channels() in the previous patch.

 drivers/net/ethernet/ibm/ibmveth.c | 51 ++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b57c7df92853..c99d8e8be7b3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2723,20 +2723,28 @@ static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned int old = netdev->real_num_tx_queues,
-		     goal = channels->tx_count;
 	unsigned int goal_rx = channels->rx_count;
+	unsigned int old_tx = netdev->real_num_tx_queues;
+	unsigned int goal_tx = channels->tx_count;
 	int rc, i;
 
 	/* If ndo_open has not been called yet then don't allocate, just set
 	 * desired netdev_queue's and return
 	 */
-	if (!(netdev->flags & IFF_UP))
-		return netif_set_real_num_tx_queues(netdev, goal);
+	if (!(netdev->flags & IFF_UP)) {
+		if (goal_tx != old_tx) {
+			rc = netif_set_real_num_tx_queues(netdev, goal_tx);
+			if (rc)
+				return rc;
+		}
+
+		/* Stash desired RX count only after TX succeeds (or was
+		 * already correct); open() publishes it via
+		 * netif_set_real_num_rx_queues().
+		 */
+		return ibmveth_resize_rx_channels(adapter, goal_rx);
+	}
 
-	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
-	 * in this patch. !IFF_UP RX stash ordering lands next.
-	 */
 	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
 	if (rc)
 		return rc;
@@ -2744,10 +2752,17 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
+	if (goal_tx == old_tx)
+		return 0;
+
 	netif_tx_stop_all_queues(netdev);
 
-	/* Allocate any queue that we need */
-	for (i = old; i < goal; i++) {
+	/* Allocate any queue that we need. Initialize i to old_tx so a
+	 * scale-down path that never enters the loop still has defined
+	 * bounds if set_real_num_tx_queues() fails.
+	 */
+	i = old_tx;
+	for (; i < goal_tx; i++) {
 		if (adapter->tx_ltb_ptr[i])
 			continue;
 
@@ -2755,20 +2770,22 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		if (!rc)
 			continue;
 
+		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
-			   old);
-		goal = old;
-		old = i;
+			   old_tx);
+		goal_tx = old_tx;
+		old_tx = i;
 		break;
 	}
-	rc = netif_set_real_num_tx_queues(netdev, goal);
+	rc = netif_set_real_num_tx_queues(netdev, goal_tx);
 	if (rc) {
 		netdev_err(netdev, "Failed to set real tx queues, returning to %d queues\n",
-			   old);
-		goal = old;
-		old = i;
+			   old_tx);
+		goal_tx = old_tx;
+		old_tx = i;
 	}
-	for (i = old; i > goal; i--) {
+	/* Free any that are no longer needed */
+	for (i = old_tx; i > goal_tx; i--) {
 		if (adapter->tx_ltb_ptr[i - 1])
 			ibmveth_free_tx_ltb(adapter, i - 1);
 	}
-- 
2.50.1 (Apple Git-155)


