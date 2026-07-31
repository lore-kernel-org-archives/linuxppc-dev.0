Return-Path: <linuxppc-dev+bounces-25157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F04C55165
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:49:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6r420jmz30B4;
	Fri, 31 Jul 2026 10:48:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458900;
	cv=none; b=MrDIoNjpLClh3dTCyBbpQA7h3qsqDqwgdIBIwjvfll3lVEYD5mKrFuiVD9iEJydbBX9xXWJSU2UMT/F4wnp1wIAgcH17tFLK5x013snlpsen0Cp5btZg6epA1riOB88gjE67dB89MpZQ1Xk//j8nUvsXTa5ATdFx3O41exGdCVXYjPge13UQfKuRcnKZJVlvjZi/wLh2wn0rNFYixZKJNEU/4rGbi4gHKTw65Su6pkmDeZg+99LE8dUo2VolNgmdtLcKyVrb1VF7diidwbYQzmYZZQ8pgqkpCZKN2QZcB0ZMCZqMdy2zScUaZRNxbgPlobFkrMG74YYuaGebQY85Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458900; c=relaxed/relaxed;
	bh=4HREfPBi16jhsaaE3KCQZxSyLsjZ7tMuMsh+qRSns74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clWptNOXpGMGdDSiGSkcMhrolp6ajb8HYMlfFcDdQtWqt2z+Dl9jWtPjw773Zje7VMw8M8wXOIz0o7GVFxJkLiNoRb0MD2phHP24zmiHwg6gMnQQRlXG0+zcYOoDmENj1NI64CDO7qxHU0wTBfbaV0NJYE20djXJ/l787Iqfv7u1SgY/2ZdcHP4v+J0Wj/Fa4QutCbksNgh9LLZpYSDGEAG+G1s5Nt6Qrwy0AdTp+vU9COF3uwNe8zzyeTUtecbtAdXlh8P6B/obdfGMZr9zkrkuVJ9+v7Zz1fr7qmzpcc0BJ+i2Fc31dKTOpjKuyfOdwGFknpiCkAh7KK9fAmqc1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d0Q2dENr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d0Q2dENr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6r256zgz305M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:18 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNI25W243694;
	Fri, 31 Jul 2026 00:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4HREfPBi16jhsaaE3
	KCQZxSyLsjZ7tMuMsh+qRSns74=; b=d0Q2dENrLMXbvza3Dh61kGRICkAx+s/gl
	XEilAJ6IhFXctRis2ERr1uReod4T690/WnyA1DZqqm6uF8u+5dQzbMKPrTpWVvvO
	9TADNc9wrjTa3VHc5j0H+znBRtEPO1eQl/DAWh5OPtAcbtXgCXjT568Jdb1NRJH+
	7hKsHEsgNpaTN6H8fvc3SiPDnPJbd2iGf5H99gngapDevZNGRE6ry6nuFYHHQ4/Z
	updf6l3TMiGIBSZ5kmY7Z+BvtVf0H6H7HAjVSXNyuxsdsl+HgAYqHCS8DeEJKmQA
	dhrmV6wzb3oFjkmefqc9gVz9bqhh0lEfSZlV8heEiJRGx2YZpHRjQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd9n9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fGGv015648;
	Fri, 31 Jul 2026 00:48:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ydkak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lPiK25428602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 286FC58058;
	Fri, 31 Jul 2026 00:48:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31E7858057;
	Fri, 31 Jul 2026 00:48:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:48:01 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 10/14] ibmveth: Add per-queue RX and TX statistics collection
Date: Thu, 30 Jul 2026 17:47:13 -0700
Message-Id: <69368babf33c52163881c33d3929ab17b61d0629.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: k01lflXz8EYEeIYbKj3nu6P4XuVDRE9C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX9g76qtW3Sju+
 tuJQ95QFWhTwWkSun3wu0RoCa4D1GYGCUj7oVfWxZAaRurkkEe6PdZIXfCBlAPv3LfDBaqxlhuD
 TKW6XyYgMcLpeWsXVgwuby3WBn0nBM0=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6bf0c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2rhNORJRK7eK1ZGt-9AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX68queFEWubwF
 Ad3S27R2/CxlAUQOXwA51D9h7mpgmwK/4o/n67dxlRpPXXZS9mrqEGVkDH7AOARlclhT0HZBAsW
 DQR+GBW6KykG5omuG1JU8rUPcx8X9eJ+Nl7o7VNPmj8Pvoii2LjTl6MfQYJqt4Pe6i4Vvj7AkTk
 uttWDix4K0RlZ0sWZOdYXttTdmHtpYr92TJ59dLTX1FzqEyoZmhmiW7+n4/mQHOyj0B1GV4qjAh
 Xq4X+MN07oGRF9jCFB5a2PfJM1m02LqtoqXgk8NvjJgKwGJsbkOuy77DwRghkc8ulQVvfkFUVAu
 RZxGvaHCUZiVrxfTA7oUPwIyuBRIvDosodLSh0dzWXWJhxdUGeKWhLPhxYGx/fNYndtqeiRrmBl
 V3WQOqv2wNk7m0nwaEgFl3b6MMRU2iHzA0IEL97WU8v0jNV4/UoOlLf4Geree1YoWtuAMPBdgUA
 PXqpwjD/YZXvEldYvHA==
X-Proofpoint-GUID: wZgu1kwfN2VHcLgyf729LdntE3GCzsF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

Count per-queue RX and TX statistics and expose them via ethtool -S
and ndo_get_stats64().

RX hot path (poll / IRQ / replenish) updates rx_qstats[] for packets,
bytes, polls, interrupts, large_packets, invalid_buffers, and
no_buffer_drops. TX hot path updates tx_qstats[] for packets, bytes,
large_packets, dropped_packets, send_failures, and checksum_offload.

Allocate qstat arrays for the adapter lifetime (probe/remove) and free
them from ibmveth_remove() / ibmveth_probe_cleanup(). Adapter-level
ethtool strings sum per-queue counters on read.
ibmveth_update_rx_no_buffer() fills rx_qstats[i].no_buffer_drops and
sums into adapter->rx_no_buffer.

Also fix get_channels() reporting: max_rx is IBMVETH_MAX_RX_QUEUES only
when MQ firmware is enabled; rx_count tracks adapter->num_rx_queues.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Merge v3's separate RX and TX stats commits into one patch.
- Introduce rx_queue_stats / tx_qstats / NUM macros here (first use).
- Allocate/free qstats at probe/remove instead of open/close.
- Report adapter-level ethtool strings by summing per-queue counters on
  read; drop aggregate_* helpers.
- Sum global rx_no_buffer across MQ queues into this statistics patch.
- Cacheline-align per-queue stats; derive field counts with offsetof so
  alignment padding is not counted as a statistic.
- probe_cleanup() cancels reset work, puts pool kobjects via helper from
  the prior patch, and frees qstats on probe failure paths.
- Keep plain u64 qstats like existing ibmveth / ibmvnic (PPC_PSERIES).

 drivers/net/ethernet/ibm/ibmveth.c | 320 +++++++++++++++++++++++++++--
 drivers/net/ethernet/ibm/ibmveth.h |  34 +++
 2 files changed, 338 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4ad7ced3c608..dbb47a42b4cb 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -228,6 +228,60 @@ ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
 	}
 }
 
+/**
+ * ibmveth_alloc_rx_qstats - Allocate per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->rx_qstats = kcalloc(IBMVETH_MAX_RX_QUEUES,
+				     sizeof(*adapter->rx_qstats),
+				     GFP_KERNEL);
+	if (!adapter->rx_qstats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_rx_qstats - Free per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ */
+static void ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	kfree(adapter->rx_qstats);
+	adapter->rx_qstats = NULL;
+}
+
+/**
+ * ibmveth_alloc_tx_qstats - Allocate per-queue TX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_tx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->tx_qstats = kcalloc(IBMVETH_MAX_QUEUES,
+				     sizeof(*adapter->tx_qstats),
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
@@ -921,6 +975,8 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
 		u64 drops = be64_to_cpup(p);
 
+		if (adapter->rx_qstats)
+			adapter->rx_qstats[i].no_buffer_drops = drops;
 		adapter->rx_no_buffer += drops;
 	}
 }
@@ -1972,22 +2028,131 @@ static int ibmveth_set_features(struct net_device *dev,
  * globals on the hot path (ibmvnic-style); with qstats allocated for the
  * adapter lifetime, these sums remain meaningful across ifdown/up.
  */
+static u64 ibmveth_sum_rx_invalid_buffers(struct ibmveth_adapter *adapter)
+{
+	u64 total = 0;
+	int i;
+
+	if (!adapter->rx_qstats)
+		return adapter->rx_invalid_buffer;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		total += adapter->rx_qstats[i].invalid_buffers;
+
+	return total;
+}
+
+static u64 ibmveth_sum_rx_large_packets(struct ibmveth_adapter *adapter)
+{
+	u64 total = 0;
+	int i;
+
+	if (!adapter->rx_qstats)
+		return adapter->rx_large_packets;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		total += adapter->rx_qstats[i].large_packets;
+
+	return total;
+}
+
+static u64 ibmveth_sum_tx_large_packets(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	u64 total = 0;
+	int i;
+
+	if (!adapter->tx_qstats)
+		return adapter->tx_large_packets;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++)
+		total += adapter->tx_qstats[i].large_packets;
+
+	return total;
+}
+
+static u64 ibmveth_sum_tx_send_failed(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	u64 total = 0;
+	int i;
+
+	if (!adapter->tx_qstats)
+		return adapter->tx_send_failed;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++)
+		total += adapter->tx_qstats[i].send_failures;
+
+	return total;
+}
+
+static u64 ibmveth_ethtool_adapter_stat(struct ibmveth_adapter *adapter,
+					int index)
+{
+	unsigned long offset = ibmveth_stats[index].offset;
+
+	if (offset == IBMVETH_STAT_OFF(rx_invalid_buffer))
+		return ibmveth_sum_rx_invalid_buffers(adapter);
+	if (offset == IBMVETH_STAT_OFF(rx_large_packets))
+		return ibmveth_sum_rx_large_packets(adapter);
+	if (offset == IBMVETH_STAT_OFF(tx_large_packets))
+		return ibmveth_sum_tx_large_packets(adapter);
+	if (offset == IBMVETH_STAT_OFF(tx_send_failed))
+		return ibmveth_sum_tx_send_failed(adapter);
+
+	return IBMVETH_GET_STAT(adapter, offset);
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
@@ -1996,21 +2161,59 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 static void ibmveth_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
-	int i;
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
-		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
+		data[i] = ibmveth_ethtool_adapter_stat(adapter, i);
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
@@ -2124,6 +2327,8 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
+		if (adapter->tx_qstats)
+			adapter->tx_qstats[queue_num].dropped_packets++;
 		ret = -EOPNOTSUPP;
 	}
 
@@ -2150,6 +2355,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 
@@ -2161,6 +2367,8 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 		desc_flags |= (IBMVETH_BUF_NO_CSUM | IBMVETH_BUF_CSUM_GOOD);
 
+		adapter->tx_qstats[queue_num].checksum_offload++;
+
 		/* Need to zero out the checksum */
 		buf[0] = 0;
 		buf[1] = 0;
@@ -2172,6 +2380,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
+			adapter->tx_qstats[queue_num].large_packets++;
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -2180,6 +2389,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
+			adapter->tx_qstats[queue_num].large_packets++;
 		}
 	}
 
@@ -2187,6 +2397,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -2203,6 +2414,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -2211,7 +2423,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 
 	if (ibmveth_send(adapter, desc.desc, mss)) {
+		adapter->tx_qstats[queue_num].send_failures++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 	} else {
+		adapter->tx_qstats[queue_num].packets++;
+		adapter->tx_qstats[queue_num].bytes += skb->len;
 	}
 
 out:
@@ -2350,6 +2566,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
 		return 0;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[queue_index].polls++;
+
 restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
@@ -2358,7 +2577,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		smp_rmb();
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
+			if (adapter->rx_qstats)
+				adapter->rx_qstats[queue_index]
+					.invalid_buffers++;
+			else
+				adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
 			rc = ibmveth_rxq_harvest_buffer(adapter,
 							queue_index, true);
@@ -2432,7 +2655,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			if ((length > netdev->mtu + ETH_HLEN) ||
 			    lrg_pkt || iph_check == 0xffff) {
 				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-				adapter->rx_large_packets++;
+				if (adapter->rx_qstats)
+					adapter->rx_qstats[queue_index]
+						.large_packets++;
+				else
+					adapter->rx_large_packets++;
 			}
 
 			if (csum_good) {
@@ -2442,6 +2669,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			napi_gro_receive(napi, skb);	/* send it up */
 
+			if (adapter->rx_qstats) {
+				adapter->rx_qstats[queue_index].packets++;
+				adapter->rx_qstats[queue_index].bytes += length;
+			}
+
 			frames_processed++;
 		}
 	}
@@ -2488,6 +2720,9 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
 		return IRQ_NONE;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[qindex].interrupts++;
+
 	ibmveth_schedule_rx_queue(adapter, qindex);
 	return IRQ_HANDLED;
 }
@@ -2698,6 +2933,40 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
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
+			stats->tx_dropped +=
+				adapter->tx_qstats[i].dropped_packets;
+		}
+	}
+
+	stats->tx_errors = dev->stats.tx_errors;
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -2710,13 +2979,14 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
 };
 
 static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
-				   int pools_ready)
+				  int pools_ready)
 {
 	int i;
 
@@ -2724,6 +2994,19 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 }
 
+static void ibmveth_probe_cleanup(struct ibmveth_adapter *adapter,
+				  int pools_ready)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	cancel_work_sync(&adapter->work);
+	ibmveth_put_pool_kobjs(adapter, pools_ready);
+
+	ibmveth_free_tx_qstats(adapter);
+	ibmveth_free_rx_qstats(adapter);
+	free_netdev(netdev);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len, pools_ready = 0;
@@ -2779,6 +3062,11 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netif_napi_add_weight(netdev, &adapter->napi[i],
 				      ibmveth_poll, 16);
 
+	if (ibmveth_alloc_rx_qstats(adapter) ||
+	    ibmveth_alloc_tx_qstats(adapter)) {
+		ibmveth_probe_cleanup(adapter, 0);
+		return -ENOMEM;
+	}
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -2859,8 +3147,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 				"failed to create pool%d kobject: %d\n", i, rc);
 			/* init_and_add takes a ref even on failure */
 			kobject_put(kobj);
-			ibmveth_put_pool_kobjs(adapter, pools_ready);
-			free_netdev(netdev);
+			ibmveth_probe_cleanup(adapter, pools_ready);
 			return rc;
 		}
 
@@ -2873,8 +3160,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 	adapter->tx_ltb_size = PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE);
@@ -2890,8 +3176,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -2913,6 +3198,9 @@ static void ibmveth_remove(struct vio_dev *dev)
 
 	unregister_netdev(netdev);
 
+	ibmveth_free_tx_qstats(adapter);
+	ibmveth_free_rx_qstats(adapter);
+
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 6e1a964df42a..8e20ccd4a1d5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -285,6 +285,38 @@ struct ibmveth_hcall_stats {
 	u64 send_lan;		/* H_SEND_LOGICAL_LAN */
 };
 
+struct ibmveth_rx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 interrupts;
+	u64 polls;
+	u64 large_packets;
+	u64 invalid_buffers;
+	u64 no_buffer_drops;
+} ____cacheline_aligned_in_smp;
+
+struct ibmveth_tx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 large_packets;
+	u64 dropped_packets;
+	u64 send_failures;
+	u64 checksum_offload;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * ethtool string count: use offsetof of the last counter so alignment
+ * padding from ____cacheline_aligned_in_smp is not counted. When adding
+ * a new counter at the end, point these at the new last field (same idea
+ * as sizeof(struct)/sizeof(u64) before alignment was added).
+ */
+#define IBMVETH_NUM_RX_QSTATS \
+	(offsetof(struct ibmveth_rx_queue_stats, no_buffer_drops) / \
+		sizeof(u64) + 1)
+#define IBMVETH_NUM_TX_QSTATS \
+	(offsetof(struct ibmveth_tx_queue_stats, checksum_offload) / \
+		sizeof(u64) + 1)
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -352,6 +384,8 @@ struct ibmveth_adapter {
 
 	/* Multi-queue statistics */
 	struct ibmveth_hcall_stats hcall_stats;
+	struct ibmveth_rx_queue_stats *rx_qstats;
+	struct ibmveth_tx_queue_stats *tx_qstats;
 
 	/* Ethtool settings */
 	u8 duplex;
-- 
2.50.1 (Apple Git-155)


