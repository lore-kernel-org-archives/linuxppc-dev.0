Return-Path: <linuxppc-dev+bounces-28909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD37CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:08:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hypqH3Pnfz30Vd;
	Mon, 05 Oct 2026 17:08:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791180523;
	cv=none; b=gkEAryB9lvSGDl4hlrXtjNkRK+2VMscDeK76UMyYDDZ+Xjob4aTQ+lTNzheEFj1dyfe+e5gbtM7R1vVPHcd2CjI2WuZNccKXAasYq/Qcyto1SrqSt8mymnAvFIlJnXVMYloSCxbicfddPGypOJCQwXG1MXmjRz7fUDeLwRJA5eLY4vV9dFHwkTN8vOWthVmxGIOFsZR8rxVQ3EU2y8eVWmpZHyd3JfckQZu2zmDXExWw6lI34LfB+/z11iuXno8Cz3Qyxmup9rzqpc0g2N6ZKQbgWUHuGBa6G/QqoTrjlhLdf0iCaSclnWl6L3+D0tokq9DT1pA5/5ZZBZWVRG0+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791180523; c=relaxed/relaxed;
	bh=tYClt3lmIILQLA821d39NNFWxQV/4Pb0zdEwca4t53o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QIZ60IbJpFIvswWxpq6+jDC6CB4Z5DJNFZKk8hOoy8Vxo9F4TMCHepIjetHUwU0kPu1BkAVI/isXCCF4g7M781dHEkIemdyL/NVO8XXhmQ4YLkjkGwozYrAsfYds8/+M5w1bEa9lA3Og3RBX7JeOx5bHmFluyHVWbVOcPznrQC2mMtEI6vbcMHJthhfNp+G+Oy8sjvqK6afjKEuJRv46xAY1k5PQj/GeMnMmHeGfWkWxLS5WijuA5V9N7M2rNB9asKL6/kgg4R+IYojj54jOhhQ0kNyKYSLl5388rehFmiizJtjjyX248h6Akdx49MGdQFOs9dLq1hV7Umoi2PyRBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bSiX+cFJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bSiX+cFJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hypqG4bxCz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:08:42 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515aND2065851;
	Mon, 5 Oct 2026 06:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tYClt3lmIILQLA821
	d39NNFWxQV/4Pb0zdEwca4t53o=; b=bSiX+cFJehstqd0TR0Exay9EvFpWjaj83
	5t3lkyupQ13ukivfQmbH7k6u3VzaJiY5RWyT/JQ2pZn5dKGn85+cb3ni2zWMgKKk
	2kawnRDhIcoiUNkfJvFYyvoN1QMyPo5iB0UUImwXVBkq085ctmg5b8ikgA0pwNHL
	JegqswIWDI7o5eFfFLr4H/3wUw0/Q5wsPcvo7XsERPhWXWC4xtyjya/xEFS6Rbko
	byfejrnXYEAqPjnwF2vAYicS/oL56JdvY5s5Rz7l4HUgPuP9mGGHuopGZNwQkgYN
	eb0d8x+j1cW7VFS5a0AxQlS9JVSfNi93cjjw8Veu/+XTRKfb+A2Mw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3gk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:08:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512SG82175570;
	Mon, 5 Oct 2026 06:08:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy3xx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:08:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69568HXT13107750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:08:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D335805B;
	Mon,  5 Oct 2026 06:08:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59C7E5805D;
	Mon,  5 Oct 2026 06:08:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:08:14 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/8] ibmveth: do not close twice after a failed reopen
Date: Sun,  4 Oct 2026 23:06:03 -0700
Message-Id: <f9f424944b0ed249ea5288e728832867cd945e1d.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33ed4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=PY5afY-jqzY7CZaCxLEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXwhkAFKlmE4xN
 l4cR2u+yD0Nz1eWkide6+i4Ro2psF0baAQFYp7pOiMxEaR26K/Q2qqeM9oL4hNXpkOJTXOuSE30
 pxGqmlcQLYQyb5vZxZag8/BGcGre84T7WXwaw7Q/4ej/CRuh6n4ukedQuz66BL9nsGwlfgIJYfU
 EPdegt7oOL2Is6WCP3dSdrmBFbJSUiBaT0e4g3ReLWWyW5PQeen/VoXMbPagrU+ny/QlXOUqn3O
 zJdWg05H/2uMEFfZNLmMWY1A9QJ1kYZq1HYSXvUWAqGU4PQtyJ5tJ1CTBvX+jz033+G7m33qIHA
 GzG9JQauEk84HYKfhSrx/U7m9t8rX73FWMgqmNHG5gxjqiccN7JgIq/67fPGE75pzudP8QHmrwX
 IHKXGLjdyCop5iC5j6zt/A0ntgtbTT4zW54YessUoLpHFbH6sGzR4Ka0pMcaQM7YQp1B+mHgHEq
 f6JDdGfGXl7k4UhpFXA==
X-Proofpoint-GUID: oBTQaqYdFR82klUvB5jFSbLy5Xfyn3vc
X-Proofpoint-ORIG-GUID: swkk5krLBCBfrrVKkgAvryegfiJ-aPoy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX79BwGzyUeTbe
 0VgH0XAxhJxSI5FdtHSkkEwoqPQ3UJ5JILYWca5ZMfA9VU7/axg74SF3sPX35gsXEI50u40FeHn
 YxgSLv2y7YUlnciYfU3cXGoNm03ul9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

ibmveth_change_mtu(), veth_pool_store(), ibmveth_set_csum_offload()
and ibmveth_set_tso() call close() and open() directly. If open() fails,
NAPI is left disabled while IFF_UP stays set, so the next close()
(ifdown, unregister or another reconfiguration) calls napi_disable()
again and waits forever with RTNL held. Networking and shutdown
hang; only a reboot recovers. ethtool -L in that state also wakes
queues that have no TX buffer and dereferences NULL in
ibmveth_start_xmit().

Any open() failure on those paths triggers it, for example an
allocation failure on an MTU change to jumbo frames.

Track a successful open in adapter->opened. close() returns early
when it is clear, and set_channels() checks it instead of IFF_UP.

The open() error-path leaks are fixed separately in net by
commit af0524bf4ce1 ("ibmveth: h_free logical LAN on open-fail after
register") and commit 84bec0bf0352 ("ibmveth: fix TX LTB and filter
unwind on open-fail"); this patch does not depend on them. Without
them, the TX buffers and the logical LAN registration that a failed
open() leaves behind stay in place after the early return, as they
did before this patch.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection. Tested on a POWER10 LPAR with
ibmveth_open() forced to fail by a test-only module parameter (not part
of this patch): 'ip link set dev eth1 mtu 9000' fails, then 'ip link set
dev eth1 down' returns at once and 'ip link set dev eth1 up' recovers
the interface. No kernel selftests cover ibmveth.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---

Changes in v2:
- commit message: say what a failed open() leaves behind without the
  two net fixes

 drivers/net/ethernet/ibm/ibmveth.c | 24 +++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |  2 ++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 33af8e57be6e..dab571fe8dde 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -738,6 +738,7 @@ static int ibmveth_open(struct net_device *netdev)

 	netif_tx_start_all_queues(netdev);

+	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");

 	return 0;
@@ -779,6 +780,14 @@ static int ibmveth_close(struct net_device *netdev)
 	long lpar_rc;
 	int i;

+	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
+	 * open() directly. If that open() fails, IFF_UP stays set and
+	 * NAPI is disabled; a second close() would hang in napi_disable().
+	 */
+	if (!adapter->opened)
+		return 0;
+	adapter->opened = false;
+
 	netdev_dbg(netdev, "close starting\n");

 	napi_disable(&adapter->napi);
@@ -830,10 +839,10 @@ static int ibmveth_close(struct net_device *netdev)
  *
  * @w: pointer to work_struct embedded in adapter structure
  *
- * Context: This routine acquires rtnl_mutex and disables its NAPI through
- *          ibmveth_close. It can't be called directly in a context that has
- *          already acquired rtnl_mutex or disabled its NAPI, or directly from
- *          a poll routine.
+ * Context: This routine acquires rtnl_mutex and, if the device is open,
+ *          disables its NAPI through ibmveth_close. It can't be called
+ *          directly in a context that has already acquired rtnl_mutex or
+ *          disabled its NAPI, or directly from a poll routine.
  *
  * Return: void
  */
@@ -1127,10 +1136,11 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;

-	/* If ndo_open has not been called yet then don't allocate, just set
-	 * desired netdev_queue's and return
+	/* If the device is not open (including a failed close/open with
+	 * IFF_UP still set) then don't allocate, just set desired
+	 * netdev_queue's and return
 	 */
-	if (!(netdev->flags & IFF_UP))
+	if (!adapter->opened)
 		return netif_set_real_num_tx_queues(netdev, goal);

 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..3f2240823f6a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -172,6 +172,8 @@ struct ibmveth_adapter {
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
+	/* Set by a successful ibmveth_open(), cleared by ibmveth_close(). */
+	bool opened;
 	unsigned int rx_buffers_per_hcall;

 	u64 fw_ipv6_csum_support;
--
2.39.3 (Apple Git-146)


