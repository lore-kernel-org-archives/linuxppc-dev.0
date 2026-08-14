Return-Path: <linuxppc-dev+bounces-25858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3778C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 08:31:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLwS02LJ0z2yRZ;
	Fri, 14 Aug 2026 18:31:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786696288;
	cv=none; b=huyZZalJhiowuiha6sYrWL2T20yrIo0wa0gEiLAS0lEwX6/mKvnNOtLUFyVc+WjngiUdAG14khowau2/6PFTh8E+nkpVHbi2MsA3onoLagP4FQevQLFBAAU+FqgtmyFwLkrk2LxhIvq1O0/D6a+kCy2v024O5Ge6VbY30O9P3dD6a4fzgp3/znJNHd0J88OkIyuUxKLDO1OHSlrVPpaZHaK3KspVj4tydXdfLhU2S6qyd0RBRnxMhwdA/445HH5Cl9sbROXHxYeH+2yjSCVo2Ec5XKfWm3zC64HsOLMkmcpz3yNuXYhELIgStnHYnGo2Qr00RlEU25JIpX6h8BidoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786696288; c=relaxed/relaxed;
	bh=i0Ob56bdaQXu+NPSg/gxxc0DgxDJPgGLTYyIyrexD/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgtrYv6/Zfh9K+1qa1MxEgGLF7uepVHa6rJMjn7aH0U1bgMrvihn9+E/i0ml4bqNF0MspHqIuxFDwIhuauSKx+yHLc7wnXn7iGKbl59g8OXMoDwiiYjC8rUkbJUiOxfc48k0xUdn7Fih6dl0YY21FTejdyzThaq8Q7CDiaLBCzxh6rV4ZJvNQESTOauMBz6YyLtf5rgSbEPk6mJkIO8VYpkKiB+SF0FFQdebNTdQPw8g33IT64+MmnsPxVSwomBYbCtBoLabOplTRltMKYKc0OF+/2XkPr2eSEh89yzjjNRwEeJPMyW2702P2kyrEQlqq8fcW/D3hGrplSrd7Hqexw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YOZfQIN6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YOZfQIN6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLwRz3Wk2z2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 18:31:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VodL3237324;
	Fri, 14 Aug 2026 07:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i0Ob56bdaQXu+NPSg
	/gxxc0DgxDJPgGLTYyIyrexD/c=; b=YOZfQIN636c1OCOp102BzkYOqiTS/ae0E
	24g6vt/TtmxXLrCd+n4+SuI3JYNOqSo+h5Q6xwe3JnAH09nbCdACihhdws23NoIr
	BB0B4/vDp6wtCqBBXSaErXmjNXPYj17919dNJ8Bee2x8Uy6Cw/BrdcB7+F5+IP14
	sp0FthMQt+brQFsOAwJg/98tLwmb4LOylp2ypTBtwDi2H7pUb24ZYMs/eTR1Cqwk
	fuCXgTWRg7aK/mzIftTu3V6qj3+wUYRFG0v1SlSglO+iTUdLsnRMAYczIVsHaq6v
	ASfgJpN3XskJVTFys6BxvOewgixb5w4Uby/ql3NZjzcp34ewZA3hw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb244044-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QK1N017907;
	Fri, 14 Aug 2026 07:38:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wegd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cUjd27919004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D537058059;
	Fri, 14 Aug 2026 07:38:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2B0658057;
	Fri, 14 Aug 2026 07:38:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:28 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 15/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Fri, 14 Aug 2026 00:36:42 -0700
Message-Id: <20260814073642.24630-16-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7ec5fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yMe-tZgr8oQhn_PHCEoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXx910BPO3twxO
 X9Lu4TJlIh9jzXxio6MDKB00qIu0/viq2TFk4GF+KQUnycRt5G0GWQrSw3RE1mJi2JgVdgSrAPU
 pn6fN6dYjvq4KVt1luapemth1nVNcIcn1EXjg6T/xqWbzkQTVTqdxUkDwVd9vR0z6za6A0r47PC
 lcEWJwvRRLZ2a98/Mxd7WmSWa2MLHtevjJ5MrCxgvtCVGWeYpltT/qi/FagFmiAsQf7fuAOzur1
 NDjs/pYewVehj2eaLRiQCOiah2pCr2VLIAF3hIOXaPDhO2cbkXbI7T9ab3paLgACyOIeaksucbv
 P05bYO7dt2pb8cz7ckyb49d/jEa9qfnp4E1PghDOqOt8xcuy7+O+55BIxNZNeFBJpJm/o/+LqF/
 dic5NlJrTJVpEoc514+EKcxKw73yRUv1WyQnRSjCTbCuBkUNZoaTTCC3sw5roVDcGT97/yjucQC
 umiMQgfEXzhPmP+FNPw==
X-Proofpoint-ORIG-GUID: pJasYkd_CJgL4bvWVKovMJRwwljdPdsO
X-Proofpoint-GUID: kKG07ru1zU5sOqLLAEMRIUBHhRnmDwTI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX8rZkpqxcKT2m
 P+x73RLBOt7Iir/q1w4Ru6bfKo2UnhpTRFf571J8tuY4/GnrgTDG3+hDG9jnkFy4hQi+OWZtiuf
 U4b9z+q+sVknmEBjCBG5rP0Xas4+4io=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Complete set_channels() RX handling around ibmveth_resize_rx_channels():

  - When down: set TX queues first, then stash the desired RX count
    in adapter->num_rx_queues for the next open() (open publishes via
    netif_set_real_num_rx_queues). There are no RX mappings/buffers/IRQs
    to grow or shrink while down, so do not allocate immediately.
  - When up: resize RX, then adjust TX LTBs with the existing
    stop/alloc/set_real_num_tx/free/wake path.
  - Skip TX stop/wake when the TX count is unchanged.

Make TX/RX updates fail atomically: validate both ranges up front;
apply TX before stashing RX while down; when up, roll RX back if TX
cannot reach the requested count. Initialize the TX alloc loop bound
so a scale-down path that never allocates still has defined cleanup
if set_real_num_tx_queues() fails.

Gate live RX resize on adapter->opened (not IFF_UP): RX resources
exist only after a successful open, matching the while-down stash path.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- set_channels / resize_rx_channels read via get_num_rx_queues()
- Series renumber: mailed v4 13/14 set_channels -> tip P15 (end; 14->15)
- set_channels: gate on adapter->opened (not IFF_UP) for live RX resize
  vs while-down stash
- Down-path RX stash also refreshes CMO (publish + set_real_num_rx)
- When up: resize RX then TX; roll RX back if TX cannot reach goal

Changes in v4:
- On !IFF_UP, stash num_rx_queues only after TX set succeeds; do not
  allocate live subordinate IRQs/buffers while down.
- Initialize i = old_tx on the TX adjust path.
- Always return rc from set_channels().
- Split from the resize-helper patch (same split as v3) while keeping
  a live caller of resize_rx_channels() in the previous patch.

 drivers/net/ethernet/ibm/ibmveth.c | 107 +++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 84f4a0deb0c5..35cbd2553e86 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -800,6 +800,7 @@ ibmveth_kick_rx_queue_if_pending(struct ibmveth_adapter *adapter,
 	if (ibmveth_rxq_pending_buffer(adapter, queue_index))
 		ibmveth_schedule_rx_queue(adapter, queue_index);
 }
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
@@ -3175,28 +3176,75 @@ static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned int old = netdev->real_num_tx_queues,
-		     goal = channels->tx_count;
+	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
+	unsigned int goal_rx = channels->rx_count;
+	unsigned int old_tx = netdev->real_num_tx_queues;
+	unsigned int goal_tx = channels->tx_count;
+	unsigned int want_tx = goal_tx;
+	int rxq_entries = adapter->rx_queue[0].num_slots;
+	bool rx_changed = false;
 	int rc, i;
 
-	/* Validate RX (and resize when opened) before the down-path early
-	 * return so MQ/range errors are not deferred to the wiring patch.
-	 * RX stash + CMO while down still lands with that patch.
-	 */
-	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	if (goal_tx < 1 || goal_tx > ibmveth_real_max_tx_queues()) {
+		netdev_err(netdev,
+			   "Invalid TX queue count %u (must be 1-%u)\n",
+			   goal_tx, ibmveth_real_max_tx_queues());
+		return -EINVAL;
+	}
+
+	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
+	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
 	if (rc)
 		return rc;
 
-	if (!adapter->opened)
-		return netif_set_real_num_tx_queues(netdev, goal);
+	/* If RX resources are not live (never opened, or close+open failed
+	 * while IFF_UP stayed set), only stash desired queue counts.
+	 */
+	if (!adapter->opened) {
+		/* Apply TX first so a failure leaves RX stash unchanged. */
+		rc = netif_set_real_num_tx_queues(netdev, goal_tx);
+		if (rc)
+			return rc;
+
+		/* Stash desired RX count; open() publishes it via
+		 * netif_set_real_num_rx_queues() after queue registration.
+		 * Refresh CMO now so open() can map the larger footprint;
+		 * open itself does not call vio_cmo_set_dev_desired.
+		 */
+		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
+			ibmveth_publish_num_rx_queues(adapter, goal_rx);
+			rc = netif_set_real_num_rx_queues(netdev, goal_rx);
+			if (rc) {
+				ibmveth_publish_num_rx_queues(adapter, old_rx);
+				return rc;
+			}
+			if (firmware_has_feature(FW_FEATURE_CMO)) {
+				unsigned long dma;
+
+				dma = ibmveth_get_desired_dma(adapter->vdev);
+				vio_cmo_set_dev_desired(adapter->vdev, dma);
+			}
+		}
+		return 0;
+	}
+
+	if (goal_rx != old_rx)
+		rx_changed = true;
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
+	if (goal_tx == old_tx)
+		return 0;
+
 	netif_tx_stop_all_queues(netdev);
 
-	/* Allocate any queue that we need */
-	for (i = old; i < goal; i++) {
+	/* Allocate any new TX LTBs. i starts at old_tx for the free walk
+	 * below when this loop body never runs (goal_tx == old_tx already
+	 * returned; goal_tx < old_tx is scale-down).
+	 */
+	i = old_tx;
+	for (; i < goal_tx; i++) {
 		if (adapter->tx_ltb_ptr[i])
 			continue;
 
@@ -3205,28 +3253,43 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			continue;
 
 		/* if something goes wrong, free everything we just allocated */
-		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
-			   old);
-		goal = old;
-		old = i;
+		netdev_err(netdev, "Failed to allocate more tx queues, returning to %u queues\n",
+			   old_tx);
+		goal_tx = old_tx;
+		old_tx = i;
 		break;
 	}
-	rc = netif_set_real_num_tx_queues(netdev, goal);
+	rc = netif_set_real_num_tx_queues(netdev, goal_tx);
 	if (rc) {
-		netdev_err(netdev, "Failed to set real tx queues, returning to %d queues\n",
-			   old);
-		goal = old;
-		old = i;
+		netdev_err(netdev, "Failed to set real tx queues, returning to %u queues\n",
+			   old_tx);
+		goal_tx = old_tx;
+		old_tx = i;
 	}
 	/* Free any that are no longer needed */
-	for (i = old; i > goal; i--) {
+	for (i = old_tx; i > goal_tx; i--) {
 		if (adapter->tx_ltb_ptr[i - 1])
 			ibmveth_free_tx_ltb(adapter, i - 1);
 	}
 
 	netif_tx_wake_all_queues(netdev);
 
-	return rc;
+	if (netdev->real_num_tx_queues != want_tx) {
+		if (rx_changed) {
+			int rb;
+
+			rb = ibmveth_resize_rx_queues_incremental(adapter,
+								  old_rx,
+								  rxq_entries);
+			if (rb)
+				netdev_err(netdev,
+					   "Failed to roll back RX queues to %u after TX failure: %d\n",
+					   old_rx, rb);
+		}
+		return rc ? rc : -ENOMEM;
+	}
+
+	return 0;
 }
 
 static const struct ethtool_ops netdev_ethtool_ops = {
-- 
2.50.1 (Apple Git-155)


