Return-Path: <linuxppc-dev+bounces-23334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2336C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:26:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF391RBCz301X;
	Thu, 02 Jul 2026 08:25:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944757;
	cv=none; b=f8R5OUJBep7ycRnGXwq02PaDy7qkFGNVONWP//PWWML/A7N32Q+uDDzIFs+QwiqXTQEUvED8FhfBuXf3KBePT+Atskk0QtFWRLxQFpqBvYdzN9zjKSrLvKdINXQkKGtQstj7ZbZaxsddo4NihFErP90+WrQ2sKRZ5j+JaA5bM0gLKfCcFpnXkiwSYxGnJ98NOp40DOcpm18+jZA5QnO5Sy0OGLwPe1w9cPLnfl49o4AtEzeeLae7KZbIut6QKR5LX19zaNLKR01VvCxpgOtib/fWf4ptMlOipz4dOiN01g5ja4Kpl61uFE9AAYKpEbz+r7lgGAltmmd3v85pgpkLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944757; c=relaxed/relaxed;
	bh=+pUyZ4MUz9j84RZWmCd/0CX0xUn3pEC7D/yomefZtXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=he1GLet55JR3V6bQdGsvmlEDgLpvEeywytyHxj42/uIP80g6cUqrP7dy9cqP1UZx0g7ET9RCAHTAvJh2kzS57Ogr+C+PW8JbbJOVpGkZKUqu2bthtLPMZwC7FE8qKVlJ7ahedsTDc+OauTP7bTFXgmDOuPgJN9RnZwjXAAE3r3Mc5usO5RCwDnlYTi+zdBIxZGYhJFO7LGFVzrVNqPEq50ZmZ9pruxw9qE5RPeOWytuvYD3vDbBM0qke5h5NvQ7yjn9GL/1LeJijYG7/3Su9PWnO2Dn4/BwznUIYFizDEGcY7N9sW7U3nKARKXqf7/8KBhU16p/ON7B2quM08z3caQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hBAznz8H; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hBAznz8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF366pscz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:54 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmdAM1926471;
	Wed, 1 Jul 2026 22:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+pUyZ4MUz9j84RZWm
	Cd/0CX0xUn3pEC7D/yomefZtXA=; b=hBAznz8HPNAsDGjIru47bw6ZL6ArhOQA+
	8+/EBgaEowtiFCbVI1T8vTrXpUZ8PjdCYA/ROCHiV7lQbVj6LeT6e21m5EJt9IRM
	BcocouGOjrAUaMvF967lQki71nI7esFuBCbdGdKsaTcUnDVWqXqh5oa4c40/fyHQ
	Y5EgJ41g6oLxxrbASbBfeKN4+XDM8d3ANnSxvipT3muJswtgHHWKR2KpIq4QpuAW
	s8afLQAYBXPpvp9zX+WG+KGNUKyh3X44dD0CwXFnxkLr2eZ47IYDiLwr5reG6ieA
	uiBLBIkU6sfgmoTJNKFgX4kdvoyWPWI/NhhzpWXvk7Mj9Ya4YX5dw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjxm4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MOKrP026520;
	Wed, 1 Jul 2026 22:25:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqhkak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPfAr66519402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA4058055;
	Wed,  1 Jul 2026 22:25:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CE795804B;
	Wed,  1 Jul 2026 22:25:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:40 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 10/15] ibmveth: Add per-queue TX statistics reporting
Date: Wed,  1 Jul 2026 15:23:22 -0700
Message-Id: <20260701222327.61325-11-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX+psJjxLvwo+y
 kPVAIFoZKLTf/m1EvMB7bGF+mJcb3luwfhAEJx0OL1pVsVKSUFFB5FogjtCvcpr7kztCmwHpCln
 rgVgZApCE6DF9Tdm+rtkyX4i6bO29rCK2KG0MpnJkUq5AvRWApX8wCC9yrf0noIclLs+H0qxZCV
 XulSozcb0Uj3urHU50jujwRW99+GFajbqKKZTMFMDfefypTK3Lz3VtE8W7DXSJCTASSf70GXQmj
 7K+sJE+7LB3CND/EYBPhvMKBpo7+EUYjs0xtXoOG6SwZsLfG4MoTzj+KDgnvoM7l6QDXAnncZRZ
 t2qKPPHe0G4gDVU/0Ajkv+arHYujLjJv0vk4XjgzVACoPfZ2rKS+rANApq9HgwVTip3sYI3VLxO
 VLRK/r5Wl+rlhlhA2zvqGz1V/+cPgSbkJ/OoTi8RXLbFReF+RnlWOQeQvuppTkLB2JKHv4TmLHk
 zkHYCC4SYW2L2H6tMGw==
X-Proofpoint-GUID: FVGdm4mffJGOtv5oRHEFqbvWQLck4bPq
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a4593e9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=9-YVOS1jIkQ23tt7c54A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfXxW24z6hzD0KJ
 2uPC4jpypeBFDIu3vq/XDzJr13W/cRUF+q89X28oP8H3pbg9InnDR2qyPg9lcZUNVLvekCdTnz2
 DXHOcyiCdFKG/6Ik199TyRCcBJNBoU4=
X-Proofpoint-ORIG-GUID: eeZEylVeuTRWR5shmQqA_1CG9ySLP-Hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

Track transmit counters per TX queue to avoid cache line contention in
the xmit hot path and expose per-queue visibility via ethtool -S and
ndo_get_stats64() aggregation.

Global tx_large_packets and tx_send_failed continue to be aggregated on
the ethtool read path for backward compatibility with existing tools.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 129 +++++++++++++++++++++++++----
 drivers/net/ethernet/ibm/ibmveth.h |  13 +++
 2 files changed, 124 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 1c08082ffbd6..4e3f49b6346f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -252,6 +252,33 @@ static void ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
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
@@ -1628,6 +1655,10 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_cleanup_rx_interrupts;
 
+	rc = ibmveth_alloc_tx_qstats(adapter);
+	if (rc)
+		goto out_free_tx_resources;
+
 	netif_tx_start_all_queues(netdev);
 
 	netdev_dbg(netdev, "open complete\n");
@@ -1668,6 +1699,7 @@ static int ibmveth_close(struct net_device *netdev)
 		}
 	}
 
+	ibmveth_free_tx_qstats(adapter);
 	ibmveth_free_tx_resources(adapter);
 	ibmveth_cleanup_rx_interrupts(adapter);
 	ibmveth_update_rx_no_buffer(adapter);
@@ -1960,6 +1992,32 @@ static void ibmveth_aggregate_rx_qstats(struct ibmveth_adapter *adapter)
 	adapter->rx_large_packets = total_large;
 }
 
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
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
@@ -1984,6 +2042,15 @@ static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 		ethtool_sprintf(&p, "rx%d_no_buffer_drops", i);
 	}
 
+	for (i = 0; i < dev->real_num_tx_queues; i++) {
+		ethtool_sprintf(&p, "tx%d_packets", i);
+		ethtool_sprintf(&p, "tx%d_bytes", i);
+		ethtool_sprintf(&p, "tx%d_large_packets", i);
+		ethtool_sprintf(&p, "tx%d_dropped_packets", i);
+		ethtool_sprintf(&p, "tx%d_send_failures", i);
+		ethtool_sprintf(&p, "tx%d_checksum_offload", i);
+	}
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		ethtool_sprintf(&p, "pool%d_size", i);
 		ethtool_sprintf(&p, "pool%d_active", i);
@@ -1999,6 +2066,7 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 	case ETH_SS_STATS:
 		return ARRAY_SIZE(ibmveth_stats) +
 		       adapter->num_rx_queues * IBMVETH_NUM_RX_QSTATS +
+		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
 		       IBMVETH_NUM_BUFF_POOLS * 3;
 	default:
 		return -EOPNOTSUPP;
@@ -2012,6 +2080,7 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
 	int i, j;
 
 	ibmveth_aggregate_rx_qstats(adapter);
+	ibmveth_aggregate_tx_qstats(adapter);
 
 	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
 		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
@@ -2030,6 +2099,19 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
 		}
 	}
 
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
 	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
 		data[i++] = adapter->rx_buff_pool[0][j].size;
 		data[i++] = adapter->rx_buff_pool[0][j].active;
@@ -2152,8 +2234,10 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 }
 
 static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
-					 struct net_device *netdev)
+					 struct ibmveth_adapter *adapter,
+					 int queue_num)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct ethhdr *ether_header;
 	int ret = 0;
 
@@ -2161,7 +2245,8 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-		netdev->stats.tx_dropped++;
+		if (adapter->tx_qstats)
+			adapter->tx_qstats[queue_num].dropped_packets++;
 		ret = -EOPNOTSUPP;
 	}
 
@@ -2177,7 +2262,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
-	if (ibmveth_is_packet_unsupported(skb, netdev))
+	if (ibmveth_is_packet_unsupported(skb, adapter, queue_num))
 		goto out;
 	/* veth can't checksum offload UDP */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -2188,7 +2273,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 
@@ -2200,6 +2285,8 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 		desc_flags |= (IBMVETH_BUF_NO_CSUM | IBMVETH_BUF_CSUM_GOOD);
 
+		adapter->tx_qstats[queue_num].checksum_offload++;
+
 		/* Need to zero out the checksum */
 		buf[0] = 0;
 		buf[1] = 0;
@@ -2211,7 +2298,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -2220,7 +2307,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		}
 	}
 
@@ -2228,7 +2315,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -2245,7 +2332,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -2254,11 +2341,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
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
@@ -2759,12 +2846,13 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 }
 
 /**
- * ibmveth_get_stats64 - Return aggregated per-queue RX statistics
+ * ibmveth_get_stats64 - Return aggregated per-queue statistics
  * @dev: network device
  * @stats: rtnl link statistics storage
  *
- * Sums per-queue rx_qstats into rx_packets/rx_bytes for multi-queue mode.
- * TX counters continue to come from netdev->stats (updated in start_xmit).
+ * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
+ * Callers use ndo_get_stats64(); avoid updating netdev->stats on the
+ * xmit/poll paths to keep per-queue counters off the hot cache line.
  */
 static void ibmveth_get_stats64(struct net_device *dev,
 				struct rtnl_link_stats64 *stats)
@@ -2779,9 +2867,14 @@ static void ibmveth_get_stats64(struct net_device *dev,
 		}
 	}
 
-	stats->tx_packets = dev->stats.tx_packets;
-	stats->tx_bytes = dev->stats.tx_bytes;
-	stats->tx_dropped = dev->stats.tx_dropped;
+	if (adapter->tx_qstats) {
+		for (i = 0; i < dev->real_num_tx_queues; i++) {
+			stats->tx_packets += adapter->tx_qstats[i].packets;
+			stats->tx_bytes += adapter->tx_qstats[i].bytes;
+			stats->tx_dropped += adapter->tx_qstats[i].dropped_packets;
+		}
+	}
+
 	stats->tx_errors = dev->stats.tx_errors;
 }
 
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


