Return-Path: <linuxppc-dev+bounces-28788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ED4CA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:58:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTLj0S55z2xbQ;
	Sat, 03 Oct 2026 11:57:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992668;
	cv=none; b=S3wJ+pZTsoKyyHMTaPRpwnXRW8yqh8ajTjm2QRNVbGZUIug3buqw/rfT3Wk8UfhXuK0WZqddzGC2N+424vCink3TMTXIIPx5VkC38DAntoJ3LTyQ9MgBoMWCYpdTk1yxsZEFLMwKtSaDZORyaRN5Ty2y7Ge7fksqsHMKHhGWYzjQuCSnT858jKhrf7GN1HPRLIa+FcWY0VSN5VjNuqDRnZA9jx2bdLuimrLMwD6IyBpLMTOMBs78Mgb48xJ0JzrOyBgCliFqAf/Y8GoAvleimgftRyS8aSXJVWVyNQ6Xg21uiC7+rYbpYEYltGrpb9Mv3iWuGbtNdzsZQ9O4cO0wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992668; c=relaxed/relaxed;
	bh=pwinNKpw3m2WkMBO47Fqj6aRqBMRDoikSieZVQeCu48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWkfPUVi+XMy775Olnh1vIwMqRHuSePpCP/H1ZQLVbIfYiKCJt95XWW8Kq/02basNrpXP3mOOEP+0C+dJBMTh1EldzrkLED4o0g4zxqrI7clQCqNx3kNp2P2yChQA87dq18A09LSpom67piIpHGA3aFEvoVHfPoP3SkaLFs+QXR5KBR4lUBRYWfS3pcINV3MIU9AaHSi/w3NjwTwhVqF1iaYp9QXD9HrCS2k4jU9OdRfMyO5WvzOMIfIv2MuJWepfyS3LznJZrUKKf4uwIQd9DYtyuThmggaIcEU7aYKptzedfFouWGIeW8OJHD7fiqHuy5qy3y7E9O1KGLt3zEB/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GbTjYadP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GbTjYadP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTLh1HHxz30Wd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:57:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69305ZKm1946469;
	Sat, 3 Oct 2026 01:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pwinNKpw3m2WkMBO4
	7Fqj6aRqBMRDoikSieZVQeCu48=; b=GbTjYadPtbiwr/lvmrAcTTKsaMEr0vBSg
	EHepNUiKZjlgeTRKs7p69MpMzwxJK8UsrAn7+TUlrKUXS0KA08ZEYCnbsyyB9zQt
	E3hlGpD1BWK/ceVpiLeJErtm1jTaZsv8jYjmis+fhFnvptNK4HEAzZzZ3zuQvL3X
	QCkC1AM/lZHQXGODc3h4A7TSlKQfVFIZxnJazqnomMURNguQXv2J0XPw+KScu8Rv
	6dF3zCcfpuK3HeUxSJr8D8qjQdkO750Jb1Sojaad89wJeVRvi6PgnOGAzTIGKD+N
	FoFZ/l17bzq+4UYL3lAJmHOXtciwkkrjF9TRuoStb2v/gQ8/zzs4g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5vpnm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NliPB3295919;
	Sat, 3 Oct 2026 01:57:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa828q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vaCq26280616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D7758059;
	Sat,  3 Oct 2026 01:57:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D06C658055;
	Sat,  3 Oct 2026 01:57:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:33 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 2/7] ibmveth: do not close twice after a failed reopen
Date: Fri,  2 Oct 2026 18:57:14 -0700
Message-Id: <b4c30518aa4a2e4151eda3aeb1b454429a0e4131.1790991039.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX8EJ/lbqdR0EG
 96M/Qbn/7lRaTwVHNtgSU0TBitNc+/OjjLqAFUUYwuAU/D6Jqk6ui8V4dAs+2LkRuYhyTdijiNz
 Fk6Kmkw1+zX3A1zZcpXI7mKroRnWFqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX1eR3Jo7H4BEW
 WcQEzazemi/YOcvKiYz2E8PJfnhJXrD2yqoEAq48eE4uhH0U/Yd9tElX6d0ck+/2qCyoJNMg/UD
 RSQuowWXvnKfBImTcnK9sLQAZhZQnTBd/cBGa/SLfqE/u5J/8hFeuk6WkET3S47dhpAFtDMVhWc
 m1dKpdtngGJzVf36Y3qXLu45661ZwO5QvbfjAKVLJyT33CsPWf1hbotISWIK1OOa9jgHqnAeQL1
 RXRH5sF1lR79cImF5jk7D2NQhUWhgYXTK2/gSysR5n9hXSZCJNdle2RV9VAfDe3G+YyyhbBYlji
 EvIHOzB18YGl+q9E5kw5GtoGPQ2sYEyIYMcQLFEfR5TLFKTCsK7nYkYLYlKBEiaIlVr6YW2TMgg
 Bs2VaXADCSPY9nhn+lIgzmJBn3/TncBo+ajWYZ8qbSuy3NBEnLPX9H8FwTTUvOFPMPzorZcE+LE
 CQ1/+i0ow8yhfExgTBg==
X-Proofpoint-GUID: -3jOxtHLz_PUkk0Lo30Ds-SDf4gViJyc
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ac06113 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PY5afY-jqzY7CZaCxLEA:9
X-Proofpoint-ORIG-GUID: Bt1FIRtFiaT96nsMENy-E_Ax3GuE6xqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

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
unwind on open-fail"); this patch does not depend on them.

Tested on a POWER10 LPAR with ibmveth_open() forced to fail:
'ip link set dev eth1 mtu 9000' fails, then 'ip link set dev eth1 down'
returns at once and 'ip link set dev eth1 up' recovers the interface.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 24 +++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |  2 ++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index aa2300e97081..00cee2916920 100644
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


