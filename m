Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0C606A338
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTHS31Mg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmtN0Qdwz30V6;
	Tue, 10 Nov 2026 10:57:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268652;
	cv=none; b=e2o9HRRgzicsTcMMUye5jIekLIdHRBJdTxy7w7sDcnuHQaDWrKDhpTH93K7f4Ao/pQEt8xRM9MEm/cVHG9+oFhV15q8W0JXuIMCbG7Ztr15Ceb4VmKjayvU7yZUGjFFXe5XdEdWzwZX9hexIONggWcH+oKUViBU5dfeCbvgkjHVJZBOrgrZVoJAVL4hnlxDCkjZBgwV29hQ8ti1Y/NQ3toUKs/D5ZmL4IMuT+Nc8kisuiRTlpC4KPkOX4mr3ps4EQS5vMFf3nY7XLvs3BkuIZl+DMCuCYZuUE/Acd4OwO3Tj1UeXXQtELcHobbLrpq2N1AVQXYyjhUfeUos2xpEBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268652; c=relaxed/relaxed;
	bh=2Hsokp9waAJf093y60/kgsGj/i9BSCYqMDeaedQAvbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFDlnaVyOOcAqKKM7ninvgB9ExW9EBCo9u5Bo55C4TCWAahVfrFcjbaqe72nP6nSBGEViM+qHO7uvxQn9bwdyObzI4wzgEHWgbz6PL6lnUVgsNLuTpEXrk1bEWI33vZwS0jb8GIIBepdzjcofbNGroVzlnhJ4F1WPIspxd9ocskgG+fxZn8SN1HiFNuWevbu/OP39pVJlg6MLnDxs6V8YoN2lp58T1rs9c1c6G/I8hZTRXesHSkQnEx/zLF0HeOtwzCmGCo+Z34d8ho6tTcUU6dD78WwiAbXSNFor1/+VYxkefw6lvjrfHyDw+8BHN8XpBh8Q3Gt5DPuboPE/mMgwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTHS31Mg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTHS31Mg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmtL4nXpz30V0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:30 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LERko3057652;
	Mon, 9 Nov 2026 23:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Hsokp9waAJf093y6
	0/kgsGj/i9BSCYqMDeaedQAvbY=; b=TTHS31MgNK76CmvWk5iBNGCh0mlppxLbm
	t5l7kJaxks4KuGyTzBqGMCsg+MZZdKUsLW8MKVj64ib2rnM8Wia+Q4WtsKzYvT2e
	iYnrCKiqHtBGo9Ot2hAxZ5GY7/e+1Syj0OyImQfJgZ1/OR4RUBLlI/1jmZZoFAZI
	yGFcWu3Yp5zyNV8CLxr9KiAd4O65sN6aGbHAjezqLuvZuGVH0n+qEGLZSnXXl/zd
	mUaLXuSGJSRli23gjz5kxwPTbWFRM/EXPWCljUJOodY9b6VKzTH5bTCqorhiKAT5
	9yGUh1d2okUsy+Uy6lQigNUZuzWIuplgQJ2KQRfGrVghD5lqcM3+A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt2cfg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LK0Zj756289;
	Mon, 9 Nov 2026 23:57:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq4kht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NvI0n6161222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:57:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8644E58028;
	Mon,  9 Nov 2026 23:57:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF1758059;
	Mon,  9 Nov 2026 23:57:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:57:15 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 15/15] ibmveth: Complete set_channels down-path
Date: Mon,  9 Nov 2026 15:55:56 -0800
Message-Id: <20261109235556.60604-16-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX4SRr8S/Vgzyk
 bWuWURkXol4WaTHqm64xrkK2BdRaVnjowXwCidU+Yirwik2wqQlhG5irMbnxKy50yMHezwySZSu
 8M8ZDIWt3kQm5lBIg9dyNOHN+g3Nd1J3inswBxovg7Co88MfAyIf+F52K2aNeVOeC+JIWW8jzHe
 VCKSgbHHnDM65ICGP+HYgB1ELZXb6S7en2zh0uHG0bdozJRAmx+SvyNyY9SztbylzQjduijVaXF
 PK+jhNJudHGITlOp/nf1itmuoH2QpxP8e9cudjNU1Vj/p/VoD6MxcrfwSttAZ/TNyTW7suGGS9U
 buTIO6ZpUghFJPWWcpOds03kXONNrei990nEnd6uvDHH5A38SoDTcU/UgQCKP4MbkB4mrqbT2CK
 lFNqYM7q9ryipZzOXaJGtASKA87zRudOoGwxjztlcM+U9CTbfXjdWfG7pqYpfQdDEqoQRwOVt0f
 VZMGhXm923riJzQm0qw==
X-Proofpoint-ORIG-GUID: cydmN1XzQjs5GVYidPDYw5-iwmjUmEDo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXwOzowsvQvPuG
 vI9oD2cGhNnQRAA0/nTtyNNKc45pwi+tksDbmlc27LcxFDLARI0GllBGzMfwH1NY5jdwWSAKavt
 PMSuTzbaoqiOUVk6d8bkadBLijMMxAU=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af25de2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=QfwA01cfH_qfFI-V7SEA:9
X-Proofpoint-GUID: WlaTVASUOxAtuLyIV47po9O3OGuiCaX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The previous commit, "ibmveth: Implement incremental MQ RX queue
resize", wires live ethtool -L rx. This patch completes the
down-path publish, replacing that commit's temporary -EOPNOTSUPP
for an RX count change while down.

This patch finishes ethtool -L for ibmveth:

  - while down: publish desired RX and TX counts (and CMO/sysfs);
    no PHYP register, buffer pools, or IRQ setup; -EBUSY if a new
    queue slot is still registered; never unmap on this path
  - while up: validate tx_count before RX resize; skip TX LTB work
    when tx_count is unchanged (the previous commit already resizes
    RX then TX)
  - get/set_channels: max_tx is at least the live tx_count so CPU
    offline cannot block an RX-only -L via max_tx below real_num

When down: if the RX count grows and a queue in [old, goal) is
still registered (queue_registered[]), return
-EBUSY before changing TX, same as live scale-up. Then set TX
queues, then publish the desired RX count in
adapter->num_rx_queues and netdev->real_num_rx_queues (rx-N sysfs
and CMO desired change immediately). Do not allocate RX mappings,
buffers or IRQs while down. If RX set_real fails, restore the old
TX real_num. set_channels never unmaps while down: a queue left
registered by a failed H_FREE is still owned by PHYP, and the next
open() retries the free.

When up: the previous patch already resizes RX then TX and rolls RX
back, best effort, if TX cannot reach the request. This patch skips
the TX LTB path when the TX count is unchanged.

Validate tx_count before touching RX so a request the driver will
reject does not resize RX first. The ethtool core already range-checks
against the max_tx get_channels() reports; this is the driver's own
guard.

get_channels() ("ibmveth: Report MQ-aware RX counts in ethtool
get_channels") already reports the live rx_count
and caps max_rx at that count once mq_fallback. This patch does not
change that getter ABI. It adds the max_tx floor: max_tx is at least
the live tx_count. After CPU offline, ibmveth_real_max_tx_queues()
can drop below real_num_tx_queues; ethtool -L resubmits that count
and the core rejects tx_count > max_tx, which also blocked an
RX-only request. set_channels uses the same ceiling (live count or
the online-CPU cap, whichever is larger) and refuses only a request
above that.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- down-path: -EBUSY if a queue in the new range is still registered,
  checked before the TX change
- subject drops "and mq_fallback max_rx cap" (now patch 12); the TX
  failure RX rollback moved to patch 14

Dropped from this series (merged fixes own them):
- commit 8d9ecac6b96e: the poll_controller !opened guard.
  ndo_poll_controller is gone

Changes in v7:
- refresh the TX-fail RX rollback comment
- get_channels max_tx is at least the live
  tx_count; set_channels uses that same
  ceiling and refuses only a request above it
- lift patch 14's temporary -EOPNOTSUPP for an RX
  count change while down
- noted: get_channels keeps the live rx_count;
  mq_fallback caps max_rx at that count; do
  not advertise max_rx = 1 and do not clamp
  rx_count

Changes in v6:
- get_channels() caps max_rx at the live rx_count when mq_fallback
  is set; rx_count stays live
- roll back TX real_num if down-path RX set_real fails
- poll_controller() returns if !opened
- noted: rx > 1 reject once mq_fallback is set is patch 14

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

 drivers/net/ethernet/ibm/ibmveth.c | 144 +++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 510d9d80e2df..3ced6f5bad2d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -3687,15 +3687,32 @@ static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	unsigned int rx_count = ibmveth_get_num_rx_queues(adapter);
 
-	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
+	/*
+	 * Never advertise max_tx below the live count. After CPU
+	 * offline, real_max can drop below real_num_tx_queues;
+	 * ethtool -L is read-modify-write and the core rejects
+	 * tx_count > max_tx, which would also block an RX-only
+	 * request. set_channels uses this same ceiling.
+	 */
+	channels->max_tx = max_t(unsigned int, channels->tx_count,
+				 ibmveth_real_max_tx_queues());
 
-	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
+	/*
+	 * Always report the live RX count. ethtool -L is read-modify-
+	 * write, so a TX-only request echoes rx_count back at us; an
+	 * understated value would be applied as a silent RX shrink.
+	 * mq_fallback instead caps max_rx at the live count, which
+	 * blocks growth in the core without misreporting what is
+	 * currently configured.
+	 */
+	channels->rx_count = rx_count;
 	if (adapter->multi_queue && !READ_ONCE(adapter->mq_fallback))
 		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
 	else
-		channels->max_rx = channels->rx_count;
+		channels->max_rx = rx_count;
 }
 
 /**
@@ -3704,9 +3721,9 @@ static void ibmveth_get_channels(struct net_device *netdev,
  * @goal_rx: requested RX queue count
  *
  * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
- * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). An RX count change while the
- * device is down is rejected (-EOPNOTSUPP); publishing it without
- * allocating arrives in the next patch. When up, apply via
+ * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). While down, return 0 here;
+ * ibmveth_set_channels() publishes the desired counts without
+ * allocating. When up, apply via
  * ibmveth_resize_rx_queues_incremental().
  *
  * Return: 0 or negative errno
@@ -3750,14 +3767,9 @@ static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
-	/*
-	 * Down / failed-open: there is nothing to resize, and publishing
-	 * the desired count without allocating arrives in the next
-	 * patch. Refuse rather than report success for a request that
-	 * would be discarded.
-	 */
+	/* Down / failed-open: do not allocate. */
 	if (!adapter->opened)
-		return -EOPNOTSUPP;
+		return 0;
 
 	rxq_entries = adapter->rx_queue[0].num_slots;
 	rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
@@ -3771,30 +3783,84 @@ static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned int old = netdev->real_num_tx_queues,
-		     goal = channels->tx_count;
 	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
-	unsigned int want_tx = goal;
+	unsigned int goal_rx = channels->rx_count;
+	unsigned int old_tx = netdev->real_num_tx_queues;
+	unsigned int goal_tx = channels->tx_count;
+	unsigned int want_tx = goal_tx;
+	unsigned int max_tx;
 	bool rx_changed = false;
 	int rc, i, alloc_rc = 0;
 
-	/* Validate RX (and resize when opened) before the down-path
-	 * early return so MQ/range errors are reported here. Publishing
-	 * the desired RX count and CMO while down is the next patch.
+	/*
+	 * Same ceiling get_channels reports: live count or the
+	 * online-CPU cap, whichever is larger.
 	 */
-	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	max_tx = max_t(unsigned int, old_tx,
+		       ibmveth_real_max_tx_queues());
+	if (goal_tx < 1 || goal_tx > max_tx) {
+		netdev_err(netdev,
+			   "Invalid TX queue count %u (must be 1-%u)\n",
+			   goal_tx, max_tx);
+		return -EINVAL;
+	}
+
+	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
+	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
 	if (rc)
 		return rc;
 
-	if (channels->rx_count != old_rx)
+	/* If not opened (never opened, close+open failed while IFF_UP
+	 * stayed set, or close() kept the LAN memory after a failed
+	 * H_FREE_LOGICAL_LAN), publish desired queue counts without
+	 * allocating.
+	 */
+	if (!adapter->opened) {
+		if (goal_rx > old_rx) {
+			for (i = old_rx; i < goal_rx; i++) {
+				if (adapter->queue_registered[i]) {
+					netdev_err(netdev,
+						   "RX queue %d still held by PHYP, free retried on next open\n",
+						   i);
+					return -EBUSY;
+				}
+			}
+		}
+		/* Apply TX first so a failure leaves the published RX
+		 * count unchanged.
+		 */
+		rc = netif_set_real_num_tx_queues(netdev, goal_tx);
+		if (rc)
+			return rc;
+
+		/* Publish desired RX count for next open() and refresh CMO;
+		 * do not allocate while down.
+		 */
+		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
+			ibmveth_publish_num_rx_queues(adapter, goal_rx);
+			rc = netif_set_real_num_rx_queues(netdev, goal_rx);
+			if (rc) {
+				int tx_rc;
+
+				ibmveth_publish_num_rx_queues(adapter, old_rx);
+				tx_rc = netif_set_real_num_tx_queues(netdev,
+								     old_tx);
+				if (tx_rc)
+					netdev_err(netdev,
+						   "Failed to restore TX queues to %u after RX failure: %d\n",
+						   old_tx, tx_rc);
+				return rc;
+			}
+			ibmveth_refresh_cmo_desired(adapter);
+		}
+		return 0;
+	}
+
+	if (goal_rx != old_rx)
 		rx_changed = true;
 
-	/* If the device is not open (including a failed close/open with
-	 * IFF_UP still set) then don't allocate, just set desired
-	 * netdev_queue's and return
-	 */
-	if (!adapter->opened)
-		return netif_set_real_num_tx_queues(netdev, goal);
+	if (goal_tx == old_tx)
+		return 0;
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
@@ -3802,7 +3868,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	netif_tx_stop_all_queues(netdev);
 
 	/* Allocate any queue that we need */
-	for (i = old; i < goal; i++) {
+	for (i = old_tx; i < goal_tx; i++) {
 		if (adapter->tx_ltb_ptr[i])
 			continue;
 
@@ -3811,24 +3877,24 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			continue;
 
 		/* if something goes wrong, free everything we just allocated */
-		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
-			   old);
+		netdev_err(netdev, "Failed to allocate more tx queues, returning to %u queues\n",
+			   old_tx);
 		alloc_rc = rc;
-		goal = old;
-		old = i;
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
 	} else if (alloc_rc) {
 		rc = alloc_rc;
 	}
 	/* Free any that are no longer needed */
-	for (i = old; i > goal; i--) {
+	for (i = old_tx; i > goal_tx; i--) {
 		if (adapter->tx_ltb_ptr[i - 1])
 			ibmveth_free_tx_ltb(adapter, i - 1);
 	}
@@ -3857,7 +3923,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		return rc ? rc : -ENOMEM;
 	}
 
-	return rc;
+	return 0;
 }
 
 static const struct ethtool_ops netdev_ethtool_ops = {
-- 
2.50.1 (Apple Git-155)


