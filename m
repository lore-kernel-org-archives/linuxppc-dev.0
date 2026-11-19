Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0976606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HoOP+Ekp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJhH5r5Xz2yNj;
	Thu, 19 Nov 2026 11:07:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046879;
	cv=none; b=SjaZpr9V96uw0xHcBNJsm2i/160JT8H3Rx35vhYRTULSWxalHP4pZ51h3o5tmjukhziZFbA3tNQ47lnddpEwWvEv3SZJBu/QJsksytCWxjilOFZgTN7yqbpuWPQKZQVU+3VLbvAZhGBfP9p5Oq9qXxcbhX3W2iJ8Z0jsNS2KrUao4p1DvAnZm3Wa9VaX695GXIHXVLkEGD0xQ2U1RwdjuamyhFeLOUfQ1IH9wKbrKy+y45kJm/lxRudVI4k03mygyb4Ig3F8/h0M9oJ5hPM73xsAH65VfSFMSNWoXHbA8yGbPb49LEMyplJDq8JR9Xe07f8lGZJTHeXSsUzKFwW5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046879; c=relaxed/relaxed;
	bh=E5/yK5BFL9aZTy9YgRwAkZCOrghRZFHIFixHSWU6da0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gskVIMg8HtNHkVWqq+0HyyhdlWLNSwSFzgtv4O2/00965F0G+wCaTZolV6S/a7uv/mR5n99bLOuzbZT7D2ZzpzRbM8SwoxQ3Xw8Ih06MAUC2gxps7c1JsqU0qWOks5wT3lRsgf2tjW9NzKbwQXRFMUotNG51Hx18dr7tUXhHJKfCsY1Z4uzSXj5JYNRyzfpbgZDkuii68xpQ2wQn/FsA54deMUbh+Dwyl9+n/tkgCx/6J4JrvTO5wGIVurF8SozK6cPYvHSW2vXJGTbFqByJlTjo0Q8GpZy01eS9wAn3mjSSWXJfUd7+0HIzLfd16X6NwCVJEOnP7oCPdJwKJtf54Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HoOP+Ekp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HoOP+Ekp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJhG4WdXz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:58 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQZ5x2200794;
	Thu, 19 Nov 2026 00:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E5/yK5BFL9aZTy9Yg
	RwAkZCOrghRZFHIFixHSWU6da0=; b=HoOP+EkpE7MM0ettOwEsT1sFFTnYaaaTe
	t2ale3aObBjZIjtPBX2H16jc9HjD8IzE+zUG/+FJ7HfmQjfzUgpcJJa8XI1AA7ui
	y/dBjb8C6CluwRWIRC+Uj0QrvteABESHdgT8ocjuOR6soTXUlm/UnSpmxmROsUXz
	5T6loV4EZLckkOS/mzaUgsQclSSVIpRkI5o1QbcdMpw0pshN3IC67+0CuxKjpAo5
	8Sb5CwL8Edlo6iq2uriZ/sJ7bxu4oYNX8vBVDlK4dsLSVs8ZzdaBbwpt3iz6N9Pu
	v5ooG8lZJUg8E/nDg1qVCSmUjhQbz0QNhkND0qPJq5vbtvKFFoyFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105ww4js-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK5ed3990099;
	Thu, 19 Nov 2026 00:07:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6s17b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07hLM20054724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5485E5805C;
	Thu, 19 Nov 2026 00:07:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE08B58065;
	Thu, 19 Nov 2026 00:07:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:40 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 7/8] ibmveth: Pass the RX queue index through replenish and poll
Date: Wed, 18 Nov 2026 16:07:10 -0800
Message-Id: <20261119000711.18093-8-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: B8fM7eBi7f6lyBOvCrXhfNIptTrAK98Q
X-Proofpoint-GUID: wW8Zj7VhFog17WP5_n4-IIzBkGEyAbQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX3NZaS70QxMqo
 dpxDuT+SUueFP8gjUy4D1xjH3q/URN+O5wwMtwIeemcf1A1gPQ+UjseGQdcf87Uk16ZkFMeELlx
 PxAVcmtPu0oxiKQm5ikM7gmp4axW+eq9Hy6D+2mgNb7DPsGadAXSDmmS++flbpmI3dYEh0PyjZa
 Hq+Y0huQGNSgz++rkF5c+Ip9EhliE8wZiYnrIkAUMoz2zifbGr+PKrX7YaiGPzCoJcZLxbC82B4
 Td2Btm2QM0Kq63Taoqt7JHcFn4a/BOdFvHnwxqrILJzvKGJyZQCUA6zzNwBq1Az3GUS/FZ7gCaA
 ZGl33O7jWnEkH9O2lVoHyDDg3ncqTohNrKsFOnjPaFTszbAPPhS4nNVid+1FI45kY+cT2ZBV2ej
 rrt//0EXsCTyWqxoZ7PsY2M5hs2UHTf53JJB3lXaPuQ8c5D/mqUzAydnPUomquZ/aE3g0LWka3E
 sjkblJoV/2J9E4+LzMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX/zmM5IsvDgmk
 GmlrLJGdOe88f1sCiy+340/9jWD4IgGzaZqzC8dg9TqDkz5i9FPlIl59aaSHdzhNk3/pABySHBi
 UogujzRgKixk/kC36zLe5p8U4IkL4aU=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afe3dd2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=mh6nCoZ55WTIQEOp0nAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180088
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The rxq_* accessors, buffer lookup, harvest and replenish still
hardcode queue 0. Give them a queue index, and have ibmveth_poll()
derive it from its NAPI instance.

Only queue 0 is used, so there is no behavior change.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 214 +++++++++++++++++------------
 1 file changed, 129 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ab8c5f6a265b..a40d9a6abf51 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -99,57 +99,67 @@ static struct ibmveth_stat ibmveth_stats[] = {
 };
 
 /* simple methods of getting data from the current rxq entry */
-static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
+static u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter,
+			     int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 
 	return be32_to_cpu(rxq->queue_addr[rxq->index].flags_off);
 }
 
-static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter,
+			      int queue_index)
 {
-	return (ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_TOGGLE) >>
-			IBMVETH_RXQ_TOGGLE_SHIFT;
+	return (ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_TOGGLE) >>
+		IBMVETH_RXQ_TOGGLE_SHIFT;
 }
 
-static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter,
+				      int queue_index)
 {
-	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue[0].toggle;
+	return ibmveth_rxq_toggle(adapter, queue_index) ==
+		adapter->rx_queue[queue_index].toggle;
 }
 
-static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter,
+				    int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_VALID;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_VALID;
 }
 
-static inline int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter,
+				    int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_OFF_MASK;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_OFF_MASK;
 }
 
-static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter,
+				    int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_LRG_PKT;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_LRG_PKT;
 }
 
-static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter,
+				    int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 
 	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
-static u64 ibmveth_rxq_correlator(struct ibmveth_adapter *adapter)
+static u64 ibmveth_rxq_correlator(struct ibmveth_adapter *adapter,
+				  int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	unsigned int idx = rxq->index;
 
 	return READ_ONCE(rxq->queue_addr[idx].correlator);
 }
 
-static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
+				 int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_CSUM_GOOD;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_CSUM_GOOD;
 }
 
 static unsigned int ibmveth_real_max_tx_queues(void)
@@ -720,14 +730,16 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
 	int i;
 
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue_index][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
@@ -773,15 +785,15 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 
 /* The correlator comes back from PHYP; a bad one schedules a reset. */
 static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
-					 u64 correlator)
+					 int queue_index, u64 correlator)
 {
 	unsigned int index = correlator & 0xffffffffUL;
 	unsigned int pool = correlator >> 32;
 
 	/* An inactive pool keeps its size but has no skbuff array. */
 	if (pool < IBMVETH_NUM_BUFF_POOLS &&
-	    index < adapter->rx_buff_pool[0][pool].size &&
-	    adapter->rx_buff_pool[0][pool].skbuff)
+	    index < adapter->rx_buff_pool[queue_index][pool].size &&
+	    adapter->rx_buff_pool[queue_index][pool].skbuff)
 		return true;
 
 	if (net_ratelimit())
@@ -900,6 +912,7 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
  * @correlator: identifies pool and index
+ * @queue_index: RX queue index
  * @reuse: whether to reuse buffer
  *
  * Return:
@@ -909,17 +922,20 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
  * * %-EFAULT - pool and index map to null skb
  */
 static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
-					   u64 correlator, bool reuse)
+					   u64 correlator, int queue_index,
+					   bool reuse)
 {
 	unsigned int pool  = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
+	struct ibmveth_buff_pool *bpool;
 	unsigned int free_index;
 	struct sk_buff *skb;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return -EINVAL;
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
+	bpool = &adapter->rx_buff_pool[queue_index][pool];
+	skb = bpool->skbuff[index];
 	if (!skb) {
 		ibmveth_rxq_no_skb(adapter, correlator);
 		return -EFAULT;
@@ -933,48 +949,48 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 		/* remove the skb pointer to mark free. actual freeing is done
 		 * by upper level networking after gro_receive
 		 */
-		adapter->rx_buff_pool[0][pool].skbuff[index] = NULL;
+		bpool->skbuff[index] = NULL;
 
 		dma_unmap_single(&adapter->vdev->dev,
-				 adapter->rx_buff_pool[0][pool].dma_addr[index],
-				 adapter->rx_buff_pool[0][pool].buff_size,
+				 bpool->dma_addr[index],
+				 bpool->buff_size,
 				 DMA_FROM_DEVICE);
 	}
 
-	free_index = adapter->rx_buff_pool[0][pool].producer_index;
-	adapter->rx_buff_pool[0][pool].producer_index++;
-	if (adapter->rx_buff_pool[0][pool].producer_index >=
-	    adapter->rx_buff_pool[0][pool].size)
-		adapter->rx_buff_pool[0][pool].producer_index = 0;
-	adapter->rx_buff_pool[0][pool].free_map[free_index] = index;
+	free_index = bpool->producer_index;
+	bpool->producer_index++;
+	if (bpool->producer_index >= bpool->size)
+		bpool->producer_index = 0;
+	bpool->free_map[free_index] = index;
 
 	mb();
 
-	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
+	atomic_dec(&bpool->available);
 
 	return 0;
 }
 
 /* get the buffer for @correlator, read once from the current rx queue entry */
 static struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
-					      u64 correlator)
+					      int queue_index, u64 correlator)
 {
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 	struct sk_buff *skb;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
 		return NULL;
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 	if (!skb)
 		ibmveth_rxq_no_skb(adapter, correlator);
 	return skb;
 }
 
-static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
+static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter,
+				int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 
 	if (++rxq->index == rxq->num_slots) {
 		rxq->index = 0;
@@ -986,6 +1002,7 @@ static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
  * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
  *
  * @adapter:    pointer to adapter
+ * @queue_index: RX queue index
  * @correlator: correlator of the current rx queue entry, as read by poll
  * @reuse:      whether to reuse buffer
  *
@@ -999,12 +1016,14 @@ static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
  * * other - non-zero return from ibmveth_remove_buffer_from_pool
  */
 static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				      u64 correlator, bool reuse)
+				      int queue_index, u64 correlator,
+				      bool reuse)
 {
 	int rc;
 
-	rc = ibmveth_remove_buffer_from_pool(adapter, correlator, reuse);
-	ibmveth_rxq_advance(adapter);
+	rc = ibmveth_remove_buffer_from_pool(adapter, correlator, queue_index,
+					     reuse);
+	ibmveth_rxq_advance(adapter, queue_index);
 
 	return rc;
 }
@@ -1978,25 +1997,28 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
-	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi[0]);
-	struct net_device *netdev = adapter->netdev;
+	struct net_device *netdev = napi->dev;
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
+	int queue_index;
 	u64 correlator;
 	u16 mss = 0;
 	int rc;
 
+	queue_index = napi - adapter->napi;
+
 	while (frames_processed < budget) {
-		if (!ibmveth_rxq_pending_buffer(adapter))
+		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
-		correlator = ibmveth_rxq_correlator(adapter);
-		if (!ibmveth_rxq_buffer_valid(adapter)) {
+		correlator = ibmveth_rxq_correlator(adapter, queue_index);
+		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			rc = ibmveth_rxq_harvest_buffer(adapter, correlator, true);
+			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
+							correlator, true);
 			if (unlikely(rc)) {
 				netdev->stats.rx_dropped++;
 				frames_processed++;
@@ -2004,24 +2026,31 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			}
 		} else {
 			struct sk_buff *skb, *new_skb;
-			int length = ibmveth_rxq_frame_length(adapter);
-			int offset = ibmveth_rxq_frame_offset(adapter);
-			int csum_good = ibmveth_rxq_csum_good(adapter);
-			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
+			int length = ibmveth_rxq_frame_length(adapter,
+							      queue_index);
+			int offset = ibmveth_rxq_frame_offset(adapter,
+							      queue_index);
+			int csum_good = ibmveth_rxq_csum_good(adapter,
+							      queue_index);
+			int lrg_pkt = ibmveth_rxq_large_packet(adapter,
+							       queue_index);
 			unsigned int pool, room, off, len;
+			struct ibmveth_buff_pool *bpool;
 			__sum16 iph_check = 0;
 
-			skb = ibmveth_rxq_get_buffer(adapter, correlator);
+			skb = ibmveth_rxq_get_buffer(adapter, queue_index,
+						     correlator);
 			if (unlikely(!skb)) {
-				ibmveth_rxq_advance(adapter);
+				ibmveth_rxq_advance(adapter, queue_index);
 				netdev->stats.rx_dropped++;
 				frames_processed++;
 				continue;
 			}
 
 			pool = correlator >> 32;
+			bpool = &adapter->rx_buff_pool[queue_index][pool];
 			room = min_t(unsigned int, skb_tailroom(skb),
-				     adapter->rx_buff_pool[0][pool].buff_size);
+				     bpool->buff_size);
 			off = offset;
 			len = length;
 			if (unlikely(len < ETH_HLEN || off >= room ||
@@ -2030,8 +2059,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 					netdev_err(netdev,
 						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
 						   off, len, room);
-				ibmveth_rxq_harvest_buffer(adapter, correlator,
-							   true);
+				ibmveth_rxq_harvest_buffer(adapter, queue_index,
+							   correlator, true);
 				netdev->stats.rx_dropped++;
 				frames_processed++;
 				continue;
@@ -2060,6 +2089,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 					ibmveth_flush_buffer(skb->data,
 						length + offset);
 				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
 								correlator,
 								true);
 				if (unlikely(rc)) {
@@ -2071,6 +2101,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 				skb = new_skb;
 			} else {
 				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
 								correlator,
 								false);
 				if (unlikely(rc)) {
@@ -2118,7 +2149,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	 * with a NAPI poll that was already running when it was set up
 	 */
 	if (budget)
-		ibmveth_replenish_task(adapter);
+		ibmveth_replenish_task(adapter, queue_index);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2129,7 +2160,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	rc = ibmveth_enable_irq(adapter, 0);
+	rc = ibmveth_enable_irq(adapter, queue_index);
 	if (rc) {
 		schedule_work(&adapter->work);
 		goto out;
@@ -2138,8 +2169,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* Mask before queueing, as schedule_rx_queue() does: a threaded
 	 * NAPI can start polling, and unmask, as soon as it is queued.
 	 */
-	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule_prep(napi)) {
-		ibmveth_disable_irq(adapter, 0);
+	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    napi_schedule_prep(napi)) {
+		ibmveth_disable_irq(adapter, queue_index);
 		__napi_schedule(napi);
 	}
 
@@ -2827,24 +2859,36 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
 	correlator = ((u64)IBMVETH_NUM_BUFF_POOLS << 32) | 0;
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter,
+							correlator, 0, false));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter,
+							correlator, 0, true));
 
 	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0][0].size;
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter,
+							correlator, 0, false));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter,
+							correlator, 0, true));
 
 	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
 	correlator = ((u64)2 << 32) | 0;
-	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, false);
+	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false);
 	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
-	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, true);
+	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, 0, true);
 	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
 
 	correlator = (u64)0 | 0;
 	pool->skbuff[0] = NULL;
-	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
-	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+	KUNIT_EXPECT_EQ(test, -EFAULT,
+			ibmveth_remove_buffer_from_pool(adapter,
+							correlator, 0, false));
+	KUNIT_EXPECT_EQ(test, -EFAULT,
+			ibmveth_remove_buffer_from_pool(adapter,
+							correlator, 0, true));
 
 	flush_work(&adapter->work);
 }
@@ -2889,27 +2933,27 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)2 << 32 | 0;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	pool->skbuff[0] = skb;
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, skb,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	flush_work(&adapter->work);
 }
@@ -2960,14 +3004,14 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
 	adapter->rx_queue[0].queue_addr[1].correlator = (u64)0 << 32 | 0;
 
-	cor = ibmveth_rxq_correlator(adapter);
-	ret = ibmveth_rxq_harvest_buffer(adapter, cor, true);
+	cor = ibmveth_rxq_correlator(adapter, 0);
+	ret = ibmveth_rxq_harvest_buffer(adapter, 0, cor, true);
 	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
 	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].index);
 	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].toggle);
 
-	cor = ibmveth_rxq_correlator(adapter);
-	ret = ibmveth_rxq_harvest_buffer(adapter, cor, true);
+	cor = ibmveth_rxq_correlator(adapter, 0);
+	ret = ibmveth_rxq_harvest_buffer(adapter, 0, cor, true);
 	KUNIT_EXPECT_EQ(test, -EFAULT, ret);
 	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].index);
 	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].toggle);
-- 
2.50.1 (Apple Git-155)


