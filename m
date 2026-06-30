Return-Path: <linuxppc-dev+bounces-23208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FF5C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:55:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4S1mhTz303F;
	Wed, 01 Jul 2026 00:54:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831256;
	cv=none; b=AsaLS9RGaHv0qcwlzIvPIRYvR9Ep3HQNPdjfzxoTWdCZ67f2+/IqcGXsxeKvzMPLwxbtUsWuvS3mVqG5OtyROS4fxhSkDx6T/j8J/kwYCw4ltH/UquuIY2av4/uOqUXeW0s43PD9QNdo3mVjMw1w3buoYYIqcoXpDyyJl8xmOAcQs10kK56/ED9uV2SR0+45tnE+6TW+GCFdfC1GD9OXlRJpgkgTCAmfSjA6WWUnSEp4KAd/N3+mPau88VkhgL+FfBf8/rl47kvx8+98kEsMW/FJoZIVo4GKiGLqofxTrJmj4NwYUD0gG7nLukaHde/6T3W0MGL4kfb3ghQP6AM1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831256; c=relaxed/relaxed;
	bh=UYGiXCIYODZfOiEgr8brLWoayiy96x4uNZR0YI3Jopo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKhKjtBLFHCfbiN98AOTqiKNndhaxopUPUikjXmuwgw5mLg/R0OUj8c6NpO3HjU9+M5AVHiQMXh5MsHPtAsoFqxyAYyy2vZrTVHMUzBhvA9AvE51tBuJWwnrUhrYIpnT/YFTzG2gifb0r+3Rb3n2O4I7UfduDr77KGLhLV+VjDbcYCW26k83SRJWl5HAa+6XV27UGLcMK2dTLiDe+Mtnl3p6j8/L00vHTcnx+avlO7LZP8+XenHtNa7mIfaKPScxAZDLi8fAp48wAbV1cGaHpmZu64A6JFrIGLirsJyc9r7w+86Ze2t8tXheQmKj9PKCDKp9XMwrNjbkKBF5Tc25AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cktqDat8; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cktqDat8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR4R2Mnjz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:54:15 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIWTh2429267;
	Tue, 30 Jun 2026 14:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UYGiXCIYODZfOiEgr
	8brLWoayiy96x4uNZR0YI3Jopo=; b=cktqDat8IWot+3BuHfisf/8sBexTGCxGo
	xMh41u5NiABxuPbVWSbdjctpHHrMttIyv8rAWJUX7OR5NKmhlpnxDir86+cX9jKX
	qBOnSzs3gt98MdNwlyA6VZgwrAUBUYDEmH5tSFSCGo8sn0TKlhV1LpOvPPsFMOeo
	BbSw6mGYboeqnVuTcpo4QLCWR6aSNycsfuw5wP2hRa6lLuIPcIgFFJwCE2TfAOye
	c2o6wlRsgE1fzs5mX2ruQWePbP1kuLv8FfUoMVyouAg26nCoaRVLXQBibHnwATM9
	YCXaofwoZT12XrvtGILCwkM8+5bRzgrhEaahhOwwM5TpPonvpny5A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfycc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEndGJ024608;
	Tue, 30 Jun 2026 14:54:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gakqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEs5Vg30671480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A7A45805A;
	Tue, 30 Jun 2026 14:54:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB65558054;
	Tue, 30 Jun 2026 14:54:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:54:03 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 12/18] ibmveth: Add per-queue RX statistics collection and reporting
Date: Tue, 30 Jun 2026 07:53:19 -0700
Message-Id: <7c92d260caf41870720449ea866928b46675e832.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43d88f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=yQpt-_ILD-ttr8A9-FoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX1jWDMrPNA+uN
 ViWoYeJYjyti7t/LK5dZ9KtVVYcsB0GmUIoAqNOF1BLBYyJT8mCmaCuBW7ht1t2kJS61H7OZnd4
 HrrGXmj5xE3FoXwgmcLSctHaugeBHTg=
X-Proofpoint-GUID: Xkjj1KDrjafnBAbaZBZ7n3Xy659LvNau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX0Ew9z1bYM0Td
 ziFb6AgUuZIu6/Ee+M656QCXFqgnSCL37PEOBHFjBwY3R7EFwigap3WRR5+qiDxRmQGZxScJ3d8
 JeDgrtJcT2sW7ZxzwB1TtaeDeqDuLt6kB1r3evQemx3p7ocJ7BslhGPzFQzi8OXMUze+kmDWJKz
 Wu9ai83VjKs/duoCKDyhJcIqhpk9Og+WiMe0MTDPaUKSch+ESYSW6Q2dpjaEFYUlNMhgQEr+yzW
 DbFzywS0XyuiUvpGkAdWiZE+7two73aFxRnEZshUXk220yN3NIvAElkDj0f4wG1Bj/Mn8aDSWDw
 jzQ4aTL80DXXV9gY4uf/p7hl/zAwK1F7wVRkImdQslg/AB2nvai4U1t/0qqmVZT9Dxj1bnmoCze
 dIC4b2/2nh7gP0TbxsAmwv8zCU3lmobNuTTBmik+d5JDBaoa1fW4Se06/TctrPujm4/OtpIrnpk
 ZzGIh+hKhWEg2sJDv6w==
X-Proofpoint-ORIG-GUID: IQCXncGbAhIUimBwbDbIGSrnH5P2kwXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

Count per-queue RX stats in poll, replenish, and the IRQ handler:
packets, bytes, polls, large_packets, invalid_buffers, no_buffer_drops,
and interrupts. Stop updating netdev->stats.rx_* in poll; totals are
summed from rx_qstats[] in get_stats64(). Per-queue TX stats follow in
the next patch.

Expose the counters via:

- ethtool -S: per-queue rxN_* strings and aggregated invalid/large
  packet globals via ibmveth_aggregate_rx_qstats(). pool%d_* reports
  queue-0 pool geometry (size, active, available) only: static probe
  config used as the template for every queue. Live per-queue pool
  usage is exported through sysfs in the next patch.
- get_stats64: sum rx_qstats[] so ip -s and /proc/net/dev report total RX
- ethtool hcall_stats counters and count send_lan on successful TX hcalls

Fix get_channels() reporting: max_rx is IBMVETH_MAX_RX_QUEUES only when
MQ firmware is enabled, rx_count tracks adapter->num_rx_queues.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 152 ++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 863e5c68b42c..1c08082ffbd6 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -98,7 +98,15 @@ static struct ibmveth_stat ibmveth_stats[] = {
 	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
 	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
 	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
-	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
+	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) },
+	{ "hcall_reg_lan_queue", IBMVETH_STAT_OFF(hcall_stats.reg_lan_queue) },
+	{ "hcall_reg_lan", IBMVETH_STAT_OFF(hcall_stats.reg_lan) },
+	{ "hcall_add_bufs_queue", IBMVETH_STAT_OFF(hcall_stats.add_bufs_queue) },
+	{ "hcall_add_bufs", IBMVETH_STAT_OFF(hcall_stats.add_bufs) },
+	{ "hcall_add_buf", IBMVETH_STAT_OFF(hcall_stats.add_buf) },
+	{ "hcall_free_lan_queue", IBMVETH_STAT_OFF(hcall_stats.free_lan_queue) },
+	{ "hcall_free_lan", IBMVETH_STAT_OFF(hcall_stats.free_lan) },
+	{ "hcall_send_lan", IBMVETH_STAT_OFF(hcall_stats.send_lan) },
 };
 
 /* simple methods of getting data from the current rxq entry */
@@ -847,6 +855,8 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
 		u64 drops = be64_to_cpup(p);
 
+		if (adapter->rx_qstats)
+			adapter->rx_qstats[i].no_buffer_drops = drops;
 		if (i == 0)
 			adapter->rx_no_buffer = drops;
 	}
@@ -1925,22 +1935,71 @@ static int ibmveth_set_features(struct net_device *dev,
 	return rc1 ? rc1 : rc2;
 }
 
+/**
+ * ibmveth_aggregate_rx_qstats - Sum per-queue RX stats into globals
+ * @adapter: ibmveth adapter
+ *
+ * Cold path only (ethtool). Keeps legacy global counters meaningful for
+ * tools that read the adapter-level fields in ibmveth_stats[].
+ */
+static void ibmveth_aggregate_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	u64 total_invalid = 0;
+	u64 total_large = 0;
+	int i;
+
+	if (!adapter->rx_qstats)
+		return;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		total_invalid += adapter->rx_qstats[i].invalid_buffers;
+		total_large += adapter->rx_qstats[i].large_packets;
+	}
+
+	adapter->rx_invalid_buffer = total_invalid;
+	adapter->rx_large_packets = total_large;
+}
+
 static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	u8 *p = data;
 	int i;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++, data += ETH_GSTRING_LEN)
-		memcpy(data, ibmveth_stats[i].name, ETH_GSTRING_LEN);
+	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++) {
+		memcpy(p, ibmveth_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		ethtool_sprintf(&p, "rx%d_packets", i);
+		ethtool_sprintf(&p, "rx%d_bytes", i);
+		ethtool_sprintf(&p, "rx%d_interrupts", i);
+		ethtool_sprintf(&p, "rx%d_polls", i);
+		ethtool_sprintf(&p, "rx%d_large_packets", i);
+		ethtool_sprintf(&p, "rx%d_invalid_buffers", i);
+		ethtool_sprintf(&p, "rx%d_no_buffer_drops", i);
+	}
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		ethtool_sprintf(&p, "pool%d_size", i);
+		ethtool_sprintf(&p, "pool%d_active", i);
+		ethtool_sprintf(&p, "pool%d_available", i);
+	}
 }
 
 static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return ARRAY_SIZE(ibmveth_stats);
+		return ARRAY_SIZE(ibmveth_stats) +
+		       adapter->num_rx_queues * IBMVETH_NUM_RX_QSTATS +
+		       IBMVETH_NUM_BUFF_POOLS * 3;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1949,21 +2008,48 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 static void ibmveth_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
-	int i;
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i, j;
+
+	ibmveth_aggregate_rx_qstats(adapter);
 
 	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
 		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
+
+	for (j = 0; j < adapter->num_rx_queues; j++) {
+		if (adapter->rx_qstats) {
+			data[i++] = adapter->rx_qstats[j].packets;
+			data[i++] = adapter->rx_qstats[j].bytes;
+			data[i++] = adapter->rx_qstats[j].interrupts;
+			data[i++] = adapter->rx_qstats[j].polls;
+			data[i++] = adapter->rx_qstats[j].large_packets;
+			data[i++] = adapter->rx_qstats[j].invalid_buffers;
+			data[i++] = adapter->rx_qstats[j].no_buffer_drops;
+		} else {
+			i += IBMVETH_NUM_RX_QSTATS;
+		}
+	}
+
+	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
+		data[i++] = adapter->rx_buff_pool[0][j].size;
+		data[i++] = adapter->rx_buff_pool[0][j].active;
+		data[i++] = atomic_read(&adapter->rx_buff_pool[0][j].available);
+	}
 }
 
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
+	channels->rx_count = adapter->num_rx_queues;
 }
 
 static int ibmveth_set_channels(struct net_device *netdev,
@@ -2061,6 +2147,7 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 		return 1;
 	}
 
+	adapter->hcall_stats.send_lan++;
 	return 0;
 }
 
@@ -2311,6 +2398,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
 		return 0;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[queue_index].polls++;
+
 restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
@@ -2319,7 +2409,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		smp_rmb();
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
+			if (adapter->rx_qstats)
+				adapter->rx_qstats[queue_index].invalid_buffers++;
+			else
+				adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
 			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
 			if (unlikely(rc))
@@ -2384,7 +2477,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			if ((length > netdev->mtu + ETH_HLEN) ||
 			    lrg_pkt || iph_check == 0xffff) {
 				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-				adapter->rx_large_packets++;
+				if (adapter->rx_qstats)
+					adapter->rx_qstats[queue_index].large_packets++;
+				else
+					adapter->rx_large_packets++;
 			}
 
 			if (csum_good) {
@@ -2394,8 +2490,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			napi_gro_receive(napi, skb);	/* send it up */
 
-			netdev->stats.rx_packets++;
-			netdev->stats.rx_bytes += length;
+			if (adapter->rx_qstats) {
+				adapter->rx_qstats[queue_index].packets++;
+				adapter->rx_qstats[queue_index].bytes += length;
+			}
+
 			frames_processed++;
 		}
 	}
@@ -2444,6 +2543,9 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
 		return IRQ_NONE;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[qindex].interrupts++;
+
 	if (napi_schedule_prep(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, qindex);
 		WARN_ON(lpar_rc != H_SUCCESS);
@@ -2656,6 +2758,33 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+/**
+ * ibmveth_get_stats64 - Return aggregated per-queue RX statistics
+ * @dev: network device
+ * @stats: rtnl link statistics storage
+ *
+ * Sums per-queue rx_qstats into rx_packets/rx_bytes for multi-queue mode.
+ * TX counters continue to come from netdev->stats (updated in start_xmit).
+ */
+static void ibmveth_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i;
+
+	if (adapter->rx_qstats) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			stats->rx_packets += adapter->rx_qstats[i].packets;
+			stats->rx_bytes += adapter->rx_qstats[i].bytes;
+		}
+	}
+
+	stats->tx_packets = dev->stats.tx_packets;
+	stats->tx_bytes = dev->stats.tx_bytes;
+	stats->tx_dropped = dev->stats.tx_dropped;
+	stats->tx_errors = dev->stats.tx_errors;
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -2668,6 +2797,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
-- 
2.39.3 (Apple Git-146)


