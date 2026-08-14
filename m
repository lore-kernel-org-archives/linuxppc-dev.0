Return-Path: <linuxppc-dev+bounces-25856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E81C5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 08:04:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvsQ13tKz2yRZ;
	Fri, 14 Aug 2026 18:04:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786694698;
	cv=none; b=MDpHvDrxx2qT+QtIqm4P/YlpRceu168UgPcaDyyTyurNEMTrFZF/d+er39qELXODcqzt9rZ366Q9D32WqrEInzZ77HvEqew30ojVdUDhm4zAPc8gYtq5xgDbqC1sAoXKTgGaEEiatoaAynZU57EVmFIdXqp91H1Cl+CggRY0g0uMHiMyDHg6QbpFdqAWnidjPYz8wZ7vsj5Gft/2aGe3QPVqBPqNpbIPjDIbyqto/WiPnYEkyxaORmdirioxm3pzG3tIdSEawCJwJ0UAUa/fguP8uIisnepzn5GmwikO15IQ1WMc10ggCQ3e/+WBQGQ9fFaWtobPqNaoiFzBYiPI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786694698; c=relaxed/relaxed;
	bh=+bcCeyJRESsEwgcYWR8nlFTyGzGF+rfjhQzytYbpK2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVU7SRex/DGzEffJ3/v5UK+xWaSdlITQE+/UhvKUHIno02Rs0B2NSVow6LAXrz1svVSURRiSkubOCtlm+06IqshCyQBR5pAEDrnCfX8v/LXrXh89QyHD/R8ZNkVUayxCYiFu8xS2vX7h84b2cykYhZXBjBcPPYW8Ll79xgITjOwQTLtqEa4omUKfsV58UIdm0k2AZh/BGGyHLSEKF1tGs8qkeIOrSW92mB5J/yPLG/7S9WcFslgPBKb6mQQW+PsPM4rB0et6F4rbiDpwswOZK1pf3EefyoaxszJeK5jNKKDXdtfgT4bWTEUTPIh88JMlO8XyKi8uGXMFFhMZ20Kqmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HftxXDLk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HftxXDLk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvsN5SLgz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 18:04:56 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4WAJC059545;
	Fri, 14 Aug 2026 07:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+bcCeyJRESsEwgcYW
	R8nlFTyGzGF+rfjhQzytYbpK2M=; b=HftxXDLkvZyXekkc1BlbjD3a7gT0yyF8/
	0r9Z0afHBsgparMk4WtyBbGWe59SYbfXBPox9NmXgJvRRok//6Kv8oTs/AVmPdWC
	tdTnb4mZR8uAlrQcZeVUq+z0nSbTI+bHgw4Jihkfi10IWVttDtsTo0UI6yDDh6of
	5oY7sIy4npv/VBxWG3mDhwU63WaVoWz5oVoo8cpt/xz6e0tGOmELvIb1iAyyoQFm
	iL6oQ4BJv6surK6/+zmHAKEC13W/G+2yYpEWbayQoxVfBBktIW9dpCnJVO77SJs4
	NQ+4RDgLiPQ5ofJLBgf4U9AW3pfQsyX7wwob1BaZR1gVkFO6q7dZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3ampv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7U4aw012401;
	Fri, 14 Aug 2026 07:38:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk6d05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cHHq22610570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97ECD5805D;
	Fri, 14 Aug 2026 07:38:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95B9558057;
	Fri, 14 Aug 2026 07:38:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:15 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 11/15] ibmveth: Add per-queue RX and TX statistics collection
Date: Fri, 14 Aug 2026 00:36:38 -0700
Message-Id: <20260814073642.24630-12-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ec5ed cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=a06geL2n3CAD-Qc1HMcA:9
X-Proofpoint-GUID: pPi0ARL_qTMaOSw2MvQ0VD45sP0S-JYe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX9W0GQt8s2m5p
 6fTNoSJrVJkBVbhH4vkWNvCXRgx/4hqWh4UnDtcbHyrzO4DZ/KlzN3rJs3ncca8u+ERHlqsLueq
 HFUd6B7Kr2a63GNziNgArx2S4h87jld9o9AZEjsHHxPpZBrCbq39Z2ZNNiXTxQY8Ee3AFVIjhiP
 U1uxNATYA7RL+Yba+62K8d8gaILTOxtRzK4PTsmkwlMYrinRrS0fu1yHP+pYmRM1/WQB/K67RQv
 MrT5IXAY4A+jTOo3ZThIRMrJr6dKJs+ayre0Rv7s7hTTdQbBIxV1L5FsJO+MyafT47iFU2E7BZa
 SXE5NpbabsOxDxh48TyVkeHX9SIZeCrFgGu7Ug35d4L39RJbF2T0dWXjnEaHNza3SIvbfobP4JV
 hm8q7JJ1/79+3kStIoyeiLdSzrtV+Rk7aPPGKqBufietRFHflLJPYKfGM/Bbr67/WLfDUPr3LLW
 VPEpy6qmU1mppFO6N+g==
X-Proofpoint-ORIG-GUID: W168DPjc480TLlNMAnbwo4HOKpTnQU4V
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX+YwGMBjsArUs
 OeRdH+ZVhiC3bfz+ZxAw0w4xPe0aBqDWy1srlCx7fvErAyEckBV8dUaNqCpdeOWVQDqWoNxJVAV
 wjWIjcq4SjpNyrLzNaN7uyuFgLdSoYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

Count per-queue RX and TX statistics and expose them via ethtool -S
and ndo_get_stats64().

RX hot path (poll / IRQ / replenish) updates rx_qstats[] for packets,
bytes, polls, interrupts, large_packets, invalid_buffers, and
no_buffer_drops. TX hot path updates tx_qstats[] for packets, bytes,
large_packets, dropped_packets, send_failures, and checksum_offload.

Allocate qstat arrays for the adapter lifetime (probe/remove) and free
them from ibmveth_remove() / ibmveth_probe_cleanup(). Adapter-level
ethtool strings sum per-queue counters on read.

ibmveth_update_rx_no_buffer() assigns PHYP's page-absolute no_buffer
count into rx_qstats[i].no_buffer_drops (= not +=): that PHYP field is
absolute for the life of the buffer-list page (zeroed each open).
When the absolute decreases (reopen / queue reuse after -L), fold the
previous slot value into adapter->rx_no_buffer_retired so the adapter
ethtool sum stays monotonic. Per-queue ethtool still shows the live
page absolute.

Keep get_stats64 / adapter ethtool totals monotonic across channel
shrink by summing the full allocated qstat arrays.

Expose hcall_* counters via ethtool -S string table here (with the other
stats), not in earlier IRQ/MQ enable patches.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- Series renumber: mailed v4 10/14 stats -> tip P11 (P09 peel;
  get_channels -> P12)
- rx_no_buffer_retired + sum MAX_* slots so adapter no-buffer / qstat
  totals stay monotonic across reopen and channel shrink
- probe_cleanup: clear vio drvdata before free_netdev (CMO cannot see a
  freed netdev on rebind)
- remove: unregister_netdev then cancel_work_sync (no UAF reset worker)

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

 drivers/net/ethernet/ibm/ibmveth.c | 401 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  36 +++
 2 files changed, 400 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 36f0926711e6..3202b657c9b8 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -98,7 +98,17 @@ static struct ibmveth_stat ibmveth_stats[] = {
 	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
 	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
 	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
-	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
+	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) },
+	{ "hcall_reg_lan_queue", IBMVETH_STAT_OFF(hcall_stats.reg_lan_queue) },
+	{ "hcall_reg_lan", IBMVETH_STAT_OFF(hcall_stats.reg_lan) },
+	{ "hcall_add_bufs_queue",
+	  IBMVETH_STAT_OFF(hcall_stats.add_bufs_queue) },
+	{ "hcall_add_bufs", IBMVETH_STAT_OFF(hcall_stats.add_bufs) },
+	{ "hcall_add_buf", IBMVETH_STAT_OFF(hcall_stats.add_buf) },
+	{ "hcall_free_lan_queue",
+	  IBMVETH_STAT_OFF(hcall_stats.free_lan_queue) },
+	{ "hcall_free_lan", IBMVETH_STAT_OFF(hcall_stats.free_lan) },
+	{ "hcall_send_lan", IBMVETH_STAT_OFF(hcall_stats.send_lan) },
 };
 
 /* simple methods of getting data from the current rxq entry */
@@ -237,6 +247,60 @@ ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
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
@@ -1011,7 +1075,23 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
 	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
 	drops = be64_to_cpup(p);
 
-	adapter->rx_no_buffer = drops;
+	/*
+	 * PHYP's buffer-list page counter is absolute for that page. A new
+	 * page (reopen / queue reuse after -L) starts near zero; fold the
+	 * previous absolute into retired so adapter-level sums stay
+	 * monotonic.
+	 */
+	if (adapter->rx_qstats) {
+		u64 *slot = &adapter->rx_qstats[queue_index].no_buffer_drops;
+
+		if (drops < *slot)
+			adapter->rx_no_buffer_retired += *slot;
+		*slot = drops;
+	} else {
+		if (drops < adapter->rx_no_buffer)
+			adapter->rx_no_buffer_retired += adapter->rx_no_buffer;
+		adapter->rx_no_buffer = drops;
+	}
 }
 
 /* replenish routine */
@@ -2239,22 +2319,158 @@ static int ibmveth_set_features(struct net_device *dev,
 	return rc1 ? rc1 : rc2;
 }
 
+/*
+ * Sum per-queue counters for rare ethtool reads. Do not write adapter
+ * globals on the hot path (ibmvnic-style). Accumulated qstats remain
+ * meaningful across ifdown/up. no_buffer_drops slots stay PHYP-page
+ * absolute (=); ibmveth_update_rx_no_buffer() folds decreases into
+ * rx_no_buffer_retired so the adapter sum never goes backwards across
+ * reopen or queue reuse.
+ */
+static u64 ibmveth_sum_rx_invalid_buffers(struct ibmveth_adapter *adapter)
+{
+	u64 total = 0;
+	int i;
+
+	if (!adapter->rx_qstats)
+		return adapter->rx_invalid_buffer;
+
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
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
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		total += adapter->rx_qstats[i].large_packets;
+
+	return total;
+}
+
+static u64 ibmveth_sum_rx_no_buffer(struct ibmveth_adapter *adapter)
+{
+	u64 total = adapter->rx_no_buffer_retired;
+	int i;
+
+	if (!adapter->rx_qstats)
+		return total + adapter->rx_no_buffer;
+
+	/* Sum-on-read: hot path only refreshes the local queue's qstat. */
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		total += adapter->rx_qstats[i].no_buffer_drops;
+
+	return total;
+}
+
+static u64 ibmveth_sum_tx_large_packets(struct ibmveth_adapter *adapter)
+{
+	u64 total = 0;
+	int i;
+
+	if (!adapter->tx_qstats)
+		return adapter->tx_large_packets;
+
+	/* Sum every allocated slot so shrinking TX channels cannot drop
+	 * historical counters from retired queues.
+	 */
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
+		total += adapter->tx_qstats[i].large_packets;
+
+	return total;
+}
+
+static u64 ibmveth_sum_tx_send_failed(struct ibmveth_adapter *adapter)
+{
+	u64 total = 0;
+	int i;
+
+	if (!adapter->tx_qstats)
+		return adapter->tx_send_failed;
+
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
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
+	if (offset == IBMVETH_STAT_OFF(rx_no_buffer))
+		return ibmveth_sum_rx_no_buffer(adapter);
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
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
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
+		       ibmveth_get_num_rx_queues(adapter) *
+		       IBMVETH_NUM_RX_QSTATS +
+		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
+		       IBMVETH_NUM_BUFF_POOLS * 3;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2263,11 +2479,44 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
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
+	for (j = 0; j < ibmveth_get_num_rx_queues(adapter); j++) {
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
@@ -2380,8 +2629,10 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 }
 
 static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
-					 struct net_device *netdev)
+					 struct ibmveth_adapter *adapter,
+					 int queue_num)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct ethhdr *ether_header;
 	int ret = 0;
 
@@ -2389,7 +2640,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		ret = -EOPNOTSUPP;
 	}
 
@@ -2411,7 +2662,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	if (ibmveth_is_packet_unsupported(skb, netdev))
+	if (ibmveth_is_packet_unsupported(skb, adapter, queue_num))
 		goto out;
 	/* veth can't checksum offload UDP */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -2422,7 +2673,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 
@@ -2434,6 +2685,8 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 		desc_flags |= (IBMVETH_BUF_NO_CSUM | IBMVETH_BUF_CSUM_GOOD);
 
+		adapter->tx_qstats[queue_num].checksum_offload++;
+
 		/* Need to zero out the checksum */
 		buf[0] = 0;
 		buf[1] = 0;
@@ -2445,7 +2698,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -2454,7 +2707,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		}
 	}
 
@@ -2462,7 +2715,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -2479,7 +2732,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -2488,11 +2741,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
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
@@ -2621,7 +2874,10 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
 				      int queue_index)
 {
-	adapter->rx_invalid_buffer++;
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[queue_index].invalid_buffers++;
+	else
+		adapter->rx_invalid_buffer++;
 }
 
 static bool ibmveth_poll_stopping(struct net_device *netdev,
@@ -2757,7 +3013,10 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
 	    iph_check == 0xffff) {
 		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-		adapter->rx_large_packets++;
+		if (adapter->rx_qstats)
+			adapter->rx_qstats[queue_index].large_packets++;
+		else
+			adapter->rx_large_packets++;
 	}
 
 	if (csum_good) {
@@ -2767,8 +3026,10 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 
 	napi_gro_receive(napi, skb);
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += length;
+	if (adapter->rx_qstats) {
+		adapter->rx_qstats[queue_index].packets++;
+		adapter->rx_qstats[queue_index].bytes += length;
+	}
 
 	return 1;
 }
@@ -2793,6 +3054,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[queue_index].polls++;
+
 restart_poll:
 	while (frames_processed < budget) {
 		if (ibmveth_poll_stopping(netdev, napi))
@@ -2878,6 +3142,9 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
 		return IRQ_NONE;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[qindex].interrupts++;
+
 	ibmveth_schedule_rx_queue(adapter, qindex);
 	return IRQ_HANDLED;
 }
@@ -3095,6 +3362,42 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+/**
+ * ibmveth_get_stats64 - Return aggregated per-queue statistics
+ * @dev: network device
+ * @stats: rtnl link statistics storage
+ *
+ * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
+ * Walk the full allocated arrays (not the live queue count) so shrinking
+ * channels cannot make the totals go backwards.
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
+		for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
+			stats->rx_packets += adapter->rx_qstats[i].packets;
+			stats->rx_bytes += adapter->rx_qstats[i].bytes;
+		}
+	}
+
+	if (adapter->tx_qstats) {
+		for (i = 0; i < IBMVETH_MAX_QUEUES; i++) {
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
@@ -3107,6 +3410,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
@@ -3121,6 +3425,23 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
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
+	/* Probe failure never reaches ibmveth_remove(); clear before free so
+	 * CMO get_desired_dma() cannot see a freed netdev on rebind.
+	 */
+	dev_set_drvdata(&adapter->vdev->dev, NULL);
+	free_netdev(netdev);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len, pools_ready = 0;
@@ -3176,6 +3497,12 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netif_napi_add_weight(netdev, &adapter->napi[i],
 				      ibmveth_poll, 16);
 
+	if (ibmveth_alloc_rx_qstats(adapter) ||
+	    ibmveth_alloc_tx_qstats(adapter)) {
+		ibmveth_probe_cleanup(adapter, 0);
+		return -ENOMEM;
+	}
+
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
 	netdev->ethtool_ops = &netdev_ethtool_ops;
@@ -3257,9 +3584,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 				"failed to create pool%d kobject: %d\n", i, rc);
 			/* init_and_add takes a ref even on failure */
 			kobject_put(kobj);
-			ibmveth_put_pool_kobjs(adapter, pools_ready);
-			dev_set_drvdata(&dev->dev, NULL);
-			free_netdev(netdev);
+			ibmveth_probe_cleanup(adapter, pools_ready);
 			return rc;
 		}
 
@@ -3279,9 +3604,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		dev_set_drvdata(&dev->dev, NULL);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -3296,9 +3619,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of rx queues rc=%d\n",
 			   rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		dev_set_drvdata(&dev->dev, NULL);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -3315,9 +3636,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		dev_set_drvdata(&dev->dev, NULL);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -3332,12 +3651,20 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
-
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
+	/*
+	 * Unregister first so NAPI/xmit cannot re-arm reset work after we
+	 * cancel it. cancel_work_sync() before unregister left a window
+	 * where poll could schedule_work() and the worker ran after
+	 * free_netdev().
+	 */
 	unregister_netdev(netdev);
+	cancel_work_sync(&adapter->work);
+
+	ibmveth_free_tx_qstats(adapter);
+	ibmveth_free_rx_qstats(adapter);
 
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 1394ef97bd8d..0960448f53ea 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -284,6 +284,38 @@ struct ibmveth_hcall_stats {
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
@@ -349,6 +381,7 @@ struct ibmveth_adapter {
 	u64 replenish_add_buff_success;
 	u64 rx_invalid_buffer;
 	u64 rx_no_buffer;
+	u64 rx_no_buffer_retired; /* PHYP page reset / queue-reuse carry */
 	u64 tx_map_failed;
 	u64 tx_send_failed;
 	u64 tx_large_packets;
@@ -356,6 +389,9 @@ struct ibmveth_adapter {
 
 	/* Hypercall statistics */
 	struct ibmveth_hcall_stats hcall_stats;
+	struct ibmveth_rx_queue_stats *rx_qstats;
+	struct ibmveth_tx_queue_stats *tx_qstats;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)


