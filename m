Return-Path: <linuxppc-dev+bounces-23659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC48C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:37:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF44514rz3brZ;
	Tue, 07 Jul 2026 05:37:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366628;
	cv=none; b=GxY5A6ABkE0X2xxq9TBSaNfDUEGzV1rqgidXcdFGXTzkc2BJpwfISie/eHfCJste0zjDnFineoh/Cy6Tu1Bn9+t90Ptizlu7fbYAgd2fZqj73XkIV5JU3IkjPKKliBHOdnZf9t/LC4f4R00kr8FHsx6zDw0AXiKd68OZrBctoTPEt8xCVhK4pl0/y9WANTodVHZRnIJX5qDzXtCQYfihSzPCciUXJObmVFhNfkCif+e4UuNULTyz3ZmBwb5c5GmW5vfkOq6ETR2DUYZp2KrRXukPPIJlBiTe0zB66CLQSN3UYFqb1RXuH7sOoqZKsDKSW45bzZ/j5VvwKyLMay/Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366628; c=relaxed/relaxed;
	bh=ZY8cYKwBxYdPjfKqGrgcRidcUdUPYbAGFar6+r++BlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLjvV1W7VRRcMpRMf3z2GRmidgRCBGfPE/4r/c9fe3itg8tNBb4wInxf/r6Ouynz0f3a1t3nngsLAGMwtCz+J4yBUn/Z9T6zYqByX1nGUas2IChdf9VCWauazoELRQ5DE6a04k7GDPGY3KohvuZHUCMTmsXjUZsUOR0bo0OIs8yVJrVKvB5qmo6kTzqkR4nArONxfFl/FJrf2Rzy/QJjI0HoXiEChfJ57Ez9ao2hofn6z8PrLPtvsc87v0dn2EsKIYP6Lqf/WiiFTfb9b0/K0wGBCadEGh2zZLO4XSB63/uHv78Go4N98BVxxpRn93Q99UdOluA/l+7ryTACv5ZudA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=chcS7hnY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=chcS7hnY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF4342N5z3br5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:37:07 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FJAQj757564;
	Mon, 6 Jul 2026 19:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZY8cYKwBxYdPjfKqG
	rgcRidcUdUPYbAGFar6+r++BlA=; b=chcS7hnYK5t6WL2TpxnEXCWS2giBuqj5V
	JuMGUu+O8DLxEOidg/wmSiuh/uxUrVOBtKFBMdvaW0ypnOpQz8wOa/inO1B2aJGD
	080HiM4UPcanwfrQh90kEwVuUPV6erVnjNmXsrTPQBJ/hXi9JIt8JywsBfRWbbfv
	Gs+MEju8oQFpwxGMr/7pJLv56YUEfQ8wB+Ti+a/srUKFS1TSmyLlO67rQMljE+BM
	ztjz/fgTqPdujsCe1Nr9vOOej58SyHrnwRJlSEEBGrmYgZzn775e1Jz7463knAuB
	91ta2kkgOBpnzwQRFE07k6Hs0B0x7wNOFtaRj9g28iHceWxcjRlZA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYrtQ004877;
	Mon, 6 Jul 2026 19:36:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxr75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JatvN29819584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D044C5805A;
	Mon,  6 Jul 2026 19:36:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0D3158051;
	Mon,  6 Jul 2026 19:36:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:54 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 11/15] ibmveth: Add per-queue RX and TX statistics collection and reporting
Date: Mon,  6 Jul 2026 12:35:59 -0700
Message-Id: <20260706193603.8039-12-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sqRLNx2nYX_BRrb1x2YA:9
X-Proofpoint-GUID: -svz6cSVRrmBJ9k4h5D3QGtJYRqF47RC
X-Proofpoint-ORIG-GUID: 3DWO7xakCficF8diPgGujx_JXX9D6OqT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX262O7BFg24Wr
 ZLOm3N/ygppamVnuvM3Cfxw7Kxa2bUnu8ONYovzrx0PJdBBGsyo3kf8CXpMsiTMwPVRW+xLOujE
 dUAnptJiuQBdKGeHBICyqq32kB9zAkQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX5xtwQ35ELfNQ
 s6naBMJetZF1kIGUr9ii3Dvdpy3pMnCFrG7emB38S2RWysLe9DrVYmWnV5f6YMJ2hbP+OksoJ99
 JPPa71IQ5+VsY3mv66GHIf4JaB6XhWWBmjT6K3o1cY7WLZa6D68F9wjawNycreKiNolifFwmlNZ
 fAUbv5uM7fVyNsHvNlV4+/dsnyYmv9zqJO057snrEpi3SlaPBDkgitDLARXYu98dkiY12Btf2aO
 Fj1BqpcPIH5zWVnBmCRJ8S4dD5QySw4xJgQfmoin3Ok2KrkuKGtIS/vPo5U4BeT/NdAWDl/RTLh
 VFJRj+UiMKzyZp9Cgzms3Ii4y/MuIqlea+6PFWxfAFg2g6Qh/lRe3412p1M8wUn1QyA6uk0xOyd
 JU6q9ZXrHeobcCrd8308ym458PkWh2veRNdg2wlE0Lb7kbsYBPH00YNBwKuRx0aHLG4Jfb7CSkd
 4G0OHPfV+uOg6AQZB+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195

Count per-queue RX stats in poll, replenish, and the IRQ handler:
packets, bytes, polls, large_packets, invalid_buffers, no_buffer_drops,
and interrupts. Track transmit counters per TX queue to avoid cache
line contention in the xmit hot path.

Expose counters via ethtool -S (rxN_* and txN_*), get_stats64()
aggregation for ip -s and /proc/net/dev, and hcall_stats counters.
Fix get_channels() reporting: max_rx is IBMVETH_MAX_RX_QUEUES only when
MQ firmware is enabled, rx_count tracks adapter->num_rx_queues.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 269 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  13 ++
 2 files changed, 259 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 863e5c68b42c..4e3f49b6346f 100644
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
@@ -244,6 +252,33 @@ static void ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
 	adapter->rx_qstats = NULL;
 }
 
+/**
+ * ibmveth_alloc_tx_qstats - Allocate per-queue TX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_tx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->tx_qstats = kcalloc(IBMVETH_MAX_QUEUES,
+				     sizeof(struct ibmveth_tx_queue_stats),
+				     GFP_KERNEL);
+	if (!adapter->tx_qstats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_tx_qstats - Free per-queue TX statistics
+ * @adapter: ibmveth adapter structure
+ */
+static void ibmveth_free_tx_qstats(struct ibmveth_adapter *adapter)
+{
+	kfree(adapter->tx_qstats);
+	adapter->tx_qstats = NULL;
+}
+
 /**
  * ibmveth_alloc_rx_queues - Allocate per-queue RX resources
  * @adapter: ibmveth adapter structure
@@ -847,6 +882,8 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
 		u64 drops = be64_to_cpup(p);
 
+		if (adapter->rx_qstats)
+			adapter->rx_qstats[i].no_buffer_drops = drops;
 		if (i == 0)
 			adapter->rx_no_buffer = drops;
 	}
@@ -1618,6 +1655,10 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_cleanup_rx_interrupts;
 
+	rc = ibmveth_alloc_tx_qstats(adapter);
+	if (rc)
+		goto out_free_tx_resources;
+
 	netif_tx_start_all_queues(netdev);
 
 	netdev_dbg(netdev, "open complete\n");
@@ -1658,6 +1699,7 @@ static int ibmveth_close(struct net_device *netdev)
 		}
 	}
 
+	ibmveth_free_tx_qstats(adapter);
 	ibmveth_free_tx_resources(adapter);
 	ibmveth_cleanup_rx_interrupts(adapter);
 	ibmveth_update_rx_no_buffer(adapter);
@@ -1925,22 +1967,107 @@ static int ibmveth_set_features(struct net_device *dev,
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
+/**
+ * ibmveth_aggregate_tx_qstats - Sum per-queue TX stats into globals
+ * @adapter: ibmveth adapter
+ *
+ * Cold path only (ethtool). Keeps legacy global counters meaningful for
+ * tools that read the adapter-level fields in ibmveth_stats[].
+ */
+static void ibmveth_aggregate_tx_qstats(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	u64 total_large = 0;
+	u64 total_send_failed = 0;
+	int i;
+
+	if (!adapter->tx_qstats)
+		return;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++) {
+		total_large += adapter->tx_qstats[i].large_packets;
+		total_send_failed += adapter->tx_qstats[i].send_failures;
+	}
+
+	adapter->tx_large_packets = total_large;
+	adapter->tx_send_failed = total_send_failed;
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
+	for (i = 0; i < dev->real_num_tx_queues; i++) {
+		ethtool_sprintf(&p, "tx%d_packets", i);
+		ethtool_sprintf(&p, "tx%d_bytes", i);
+		ethtool_sprintf(&p, "tx%d_large_packets", i);
+		ethtool_sprintf(&p, "tx%d_dropped_packets", i);
+		ethtool_sprintf(&p, "tx%d_send_failures", i);
+		ethtool_sprintf(&p, "tx%d_checksum_offload", i);
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
+		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
+		       IBMVETH_NUM_BUFF_POOLS * 3;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1949,21 +2076,62 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 static void ibmveth_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
-	int i;
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i, j;
+
+	ibmveth_aggregate_rx_qstats(adapter);
+	ibmveth_aggregate_tx_qstats(adapter);
 
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
+	for (j = 0; j < dev->real_num_tx_queues; j++) {
+		if (adapter->tx_qstats) {
+			data[i++] = adapter->tx_qstats[j].packets;
+			data[i++] = adapter->tx_qstats[j].bytes;
+			data[i++] = adapter->tx_qstats[j].large_packets;
+			data[i++] = adapter->tx_qstats[j].dropped_packets;
+			data[i++] = adapter->tx_qstats[j].send_failures;
+			data[i++] = adapter->tx_qstats[j].checksum_offload;
+		} else {
+			i += IBMVETH_NUM_TX_QSTATS;
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
@@ -2061,12 +2229,15 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 		return 1;
 	}
 
+	adapter->hcall_stats.send_lan++;
 	return 0;
 }
 
 static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
-					 struct net_device *netdev)
+					 struct ibmveth_adapter *adapter,
+					 int queue_num)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct ethhdr *ether_header;
 	int ret = 0;
 
@@ -2074,7 +2245,8 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-		netdev->stats.tx_dropped++;
+		if (adapter->tx_qstats)
+			adapter->tx_qstats[queue_num].dropped_packets++;
 		ret = -EOPNOTSUPP;
 	}
 
@@ -2090,7 +2262,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
-	if (ibmveth_is_packet_unsupported(skb, netdev))
+	if (ibmveth_is_packet_unsupported(skb, adapter, queue_num))
 		goto out;
 	/* veth can't checksum offload UDP */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -2101,7 +2273,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 
@@ -2113,6 +2285,8 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 		desc_flags |= (IBMVETH_BUF_NO_CSUM | IBMVETH_BUF_CSUM_GOOD);
 
+		adapter->tx_qstats[queue_num].checksum_offload++;
+
 		/* Need to zero out the checksum */
 		buf[0] = 0;
 		buf[1] = 0;
@@ -2124,7 +2298,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -2133,7 +2307,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		}
 	}
 
@@ -2141,7 +2315,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -2158,7 +2332,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -2167,11 +2341,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 
 	if (ibmveth_send(adapter, desc.desc, mss)) {
-		adapter->tx_send_failed++;
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].send_failures++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 	} else {
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
+		adapter->tx_qstats[queue_num].packets++;
+		adapter->tx_qstats[queue_num].bytes += skb->len;
 	}
 
 out:
@@ -2311,6 +2485,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
 		return 0;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[queue_index].polls++;
+
 restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
@@ -2319,7 +2496,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
@@ -2384,7 +2564,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
@@ -2394,8 +2577,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
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
@@ -2444,6 +2630,9 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
 		return IRQ_NONE;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[qindex].interrupts++;
+
 	if (napi_schedule_prep(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, qindex);
 		WARN_ON(lpar_rc != H_SUCCESS);
@@ -2656,6 +2845,39 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+/**
+ * ibmveth_get_stats64 - Return aggregated per-queue statistics
+ * @dev: network device
+ * @stats: rtnl link statistics storage
+ *
+ * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
+ * Callers use ndo_get_stats64(); avoid updating netdev->stats on the
+ * xmit/poll paths to keep per-queue counters off the hot cache line.
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
+	if (adapter->tx_qstats) {
+		for (i = 0; i < dev->real_num_tx_queues; i++) {
+			stats->tx_packets += adapter->tx_qstats[i].packets;
+			stats->tx_bytes += adapter->tx_qstats[i].bytes;
+			stats->tx_dropped += adapter->tx_qstats[i].dropped_packets;
+		}
+	}
+
+	stats->tx_errors = dev->stats.tx_errors;
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -2668,6 +2890,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index f7b20fd01acb..390c660af979 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -316,9 +316,21 @@ struct ibmveth_rx_queue_stats {
 	u64 no_buffer_drops;
 };
 
+struct ibmveth_tx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 large_packets;
+	u64 dropped_packets;
+	u64 send_failures;
+	u64 checksum_offload;
+};
+
 #define IBMVETH_NUM_RX_QSTATS \
 	(sizeof(struct ibmveth_rx_queue_stats) / sizeof(u64))
 
+#define IBMVETH_NUM_TX_QSTATS \
+	(sizeof(struct ibmveth_tx_queue_stats) / sizeof(u64))
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -386,6 +398,7 @@ struct ibmveth_adapter {
 	/* Multi-queue statistics */
 	struct ibmveth_hcall_stats hcall_stats;
 	struct ibmveth_rx_queue_stats *rx_qstats;
+	struct ibmveth_tx_queue_stats *tx_qstats;
 
 	/* Ethtool settings */
 	u8 duplex;
-- 
2.39.3 (Apple Git-146)


