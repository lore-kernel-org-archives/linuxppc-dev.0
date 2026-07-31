Return-Path: <linuxppc-dev+bounces-25154-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCAFC55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:48:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6qz31PYz2ygg;
	Fri, 31 Jul 2026 10:48:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458895;
	cv=none; b=gxpIik2ztXDDCHtyvVYhe5YjJxJriEongte6shooHeVAdrlopDZCQ/7aIJLhq2wHFOHOqkyT3O9zIrvXT5K0xP0JkmRON0sAGbzc4hqihRTU/S2bH7ijo+YwYdGhkOkS+XlTyaq404lm4hQnVPkQSWMb5CHtEhevbJj2IoMby0sZpudkSO/1b3L9vTDjCvuDAA4Kn0DT0dNGo3wuL6nSjNguozHi4/Ry6nSEFwlImo47D5dsDeqZOoy6vIj1j0kT7nQRuBmJtK9bDCYeTv6Uf8CDuCu8fgMYJsH30czUjPNE1Dp665VaqvT/F1BaHeTF3CFG/u5pkmCSmxwQg7klBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458895; c=relaxed/relaxed;
	bh=5YZyMSSkOarzBrZuZ1gffHv0OOYI9VtIPYtcUwxMFjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8eGBbl0fM2owmU3gMsU32gL9B1u5kwpFFfVF3yBWHVW1y3PyN8aoT8PHCFomrjyDCaIKnWsQz8VnexmBP+4SKFE5v/TuB1daA3ndIMHwk/ae/a4I8vIs3OFi+gLbUh6gRxyMXFqjxXc3xZb4TYxMlEhUdRMo9vwgO2fGDuAeophRgfbhAzUTswkRoGSJzec90hv4YgJtTWVeRHr7wyKY4zLMnBhMp5At5CGF6vpb2xwvO9Q5C7QBAAzEZmP3MM8Uo+988J53JHZWnWLZlowV9i18Pz6PgRacBrvdtpENfcLrTHzcHoJm1yE9WpMYm4dLK9ZrNyv1/YKY/r8c9YiGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qoR0mJfq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qoR0mJfq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6qy0QKlz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHgVf119025;
	Fri, 31 Jul 2026 00:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5YZyMSSkOarzBrZuZ
	1gffHv0OOYI9VtIPYtcUwxMFjQ=; b=qoR0mJfqZ8cxZkpdQfB8QtpjKQf9cb3je
	WBsaKVyjTdf+GtkJzlIyyZV4SV4JwKFwPnglSRe78DkaZ/ct+REYn82+URWHIcjn
	91jXH7QtVmQiyecw6nvl1xkQ0t0p1txsh+3SArA1QPB/ZelSWWq5HVYlByfr6WlN
	GCB/fezgenOQSsujfAAR4jf7E+9lI+TCpv7lroY2k31vwt1soBmxzC9kNDeO1GGz
	76lBlumw6BF5Efmi3XxwCEwAMN9PB23Ixh2nGVZ7GXe88n7d9J18W6zLbTu3hG42
	/DO5MRAeV5IWMJVaDRPm6iQq+mobruEDtRarvQn0Nn0fptjvgQFrQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjhmta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fMok031566;
	Fri, 31 Jul 2026 00:47:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgnpdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lw7x25625146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FC3358057;
	Fri, 31 Jul 2026 00:47:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78C2F58061;
	Fri, 31 Jul 2026 00:47:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:57 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 08/14] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Thu, 30 Jul 2026 17:47:11 -0700
Message-Id: <358f3660dbf83279a5218792d432746bc8b845ac.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX19CFNtDoet+t
 7djxaov8dwWwUHcegCWUk79/uhEQD7UUqpF+ZrVbXi7P9uMYqUxRgB4NdlhoxXxipv/Fs4hmeMO
 oU1+qeAwY9EceaagvlayQL0z14T7JkE=
X-Proofpoint-GUID: r4dLDmYfzbB8QywSqlUoB6WByf-0qEWH
X-Proofpoint-ORIG-GUID: uiaUvA2mLRXwXEBXSoLYpgPXc9JPTqSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX7GntB2NzFNsT
 63VwyUb8bpwwQrnHuPSGAU0O03rHW8igOv1Ryirs8Wwd2mkrQxJOJKNuClRAcRsKgzDTMryVlGA
 C1CSm2wYYivOYevBCmPFK/RMV+K4m21XF7uxDc4+/C/UXoAS5urVKMvh+12LWSqdAGH9L2fenOB
 KbJSBNol0fIyYydo4UHUMP6VYD1xUJgcIBH0MNCaq4Q4Mx3gLXJb5qYZA6bdttsOKGw6Rpjbyz1
 6V7ygPsV337goekxq/vYlx4dbhXoTMW9xrTLC66DYNAixBrUe2Q73aHcPfzecYaiUiNTkFBr8p6
 iEVqNqkYH8ltlbRmZoJuRHhe21RLan9KS72VHaBx34uIYdY+mQ1ORPRUCA9W1CGSWyoA21LDzmY
 wNMAYTeO1F+q0GQf4XdJY4f+Mfx8juKsnU850kawAFOAHLxfFDiRnTRcodDvggMv/ZUJceY/huo
 2vg140gBIey+g0nYG7w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6bf0c0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3gwwhyn38vbcN_j4CZIA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310003

Replenish is the last open-path hypervisor call that still needs
per-queue awareness before MQ is turned on. Today
ibmveth_replenish_buffer_pool() calls h_add_logical_lan_buffer() or
h_add_logical_lan_buffers() directly; MQ posts via
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against adapter->queue_handle[].

Add ibmveth_add_logical_lan_buffers() to pick the hcall:
multi_queue uses h_add_logical_lan_buffers_queue() (up to 12 buffers,
IOBAs packed with odd counts in the upper 32 bits); legacy uses the
existing single- and multi-buffer hcalls. Count add_buf/add_bufs/
add_bufs_queue in hcall_stats.

Thread queue_index through the RX helpers used by poll and replenish:

  ibmveth_rxq_* accessors
  ibmveth_remove_buffer_from_pool()
  ibmveth_rxq_get_buffer() / ibmveth_rxq_harvest_buffer()
  ibmveth_replenish_buffer_pool() / ibmveth_replenish_task()

and update open/poll/netpoll callers in the same patch so arity stays
consistent. Also add per-queue replenish_lock so later concurrent
NAPI/resize paths can serialize buffer posting.

Until MQ enablement, callers still pass queue 0 and legacy hcalls
remain the live path.

H_FUNCTION handling is split:
  - multi_queue: hard-fail and break
  - legacy multi-buffer LPM fallback: set rx_buffers_per_hcall = 1 and
    break so the next replenish_buffer_pool() re-samples batch as 1
    (do not continue with a stale local batch)

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Introduce queue-aware replenish/poll helpers with their first callers
  in the same patch; do not leave a 2-arg replenish call ahead of the
  signature change.
- Restore the pre-MQ LPM H_FUNCTION break instead of continue; do not
  loop forever on a stale local batch size.
- Fold per-queue replenish_lock into this patch.
- Update kdoc for MQ parameters on remove_buffer_from_pool /
  rxq_harvest_buffer.

 drivers/net/ethernet/ibm/ibmveth.c | 341 +++++++++++++++++++----------
 drivers/net/ethernet/ibm/ibmveth.h |   7 +-
 2 files changed, 237 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 9d1242dbcb19..cb93659fc057 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -101,49 +101,58 @@ static struct ibmveth_stat ibmveth_stats[] = {
 };
 
 /* simple methods of getting data from the current rxq entry */
-static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
+static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter,
+				    int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 
 	return be32_to_cpu(rxq->queue_addr[rxq->index].flags_off);
 }
 
-static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter,
+				     int queue_index)
 {
-	return (ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_TOGGLE) >>
-			IBMVETH_RXQ_TOGGLE_SHIFT;
+	return (ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_TOGGLE) >>
+		IBMVETH_RXQ_TOGGLE_SHIFT;
 }
 
-static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter,
+					     int queue_index)
 {
-	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue[0].toggle;
+	return ibmveth_rxq_toggle(adapter, queue_index) ==
+		adapter->rx_queue[queue_index].toggle;
 }
 
-static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_VALID;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_VALID;
 }
 
-static inline int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_OFF_MASK;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_OFF_MASK;
 }
 
-static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_LRG_PKT;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_LRG_PKT;
 }
 
-static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 
 	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
-static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
+					int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_CSUM_GOOD;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_CSUM_GOOD;
 }
 
 static unsigned int ibmveth_real_max_tx_queues(void)
@@ -260,6 +269,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
 		adapter->rx_queue[i].index = 0;
 		adapter->rx_queue[i].num_slots = rxq_entries;
 		adapter->rx_queue[i].toggle = 1;
+		spin_lock_init(&adapter->rx_queue[i].replenish_lock);
 
 		netdev_dbg(netdev, "queue %d: buffer_list @ 0x%p (DMA: 0x%llx), rx_queue @ 0x%p (DMA: 0x%llx), %llu entries\n",
 			   i, adapter->buffer_list_addr[i],
@@ -588,11 +598,75 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
+/**
+ * ibmveth_add_logical_lan_buffers - Add receive buffers to hypervisor
+ * @adapter: ibmveth adapter structure
+ * @descs: array of buffer descriptors to add
+ * @filled: number of valid descriptors in the array
+ * @buff_size: size of each buffer (multi-queue mode only)
+ * @queue_index: RX queue index
+ *
+ * Return: hypervisor return code
+ */
+static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
+					    union ibmveth_buf_desc *descs,
+					    int filled,
+					    unsigned long buff_size,
+					    int queue_index)
+{
+	struct vio_dev *vdev = adapter->vdev;
+	unsigned long rc;
+
+	if (adapter->multi_queue) {
+		unsigned long buffersznum = (buff_size << 32) | filled;
+		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
+		unsigned long handle = adapter->queue_handle[queue_index];
+		int i;
+
+		/* Pack descriptor addresses into ioba pairs.
+		 * Each ioba holds two 32-bit addresses packed into 64 bits:
+		 * - Even descriptors (0,2,4...) go in high 32 bits
+		 * - Odd descriptors (1,3,5...) go in low 32 bits
+		 */
+		for (i = 0; i < filled && i < IBMVETH_MAX_RX_PER_HCALL; i++) {
+			int pair_idx = i / 2;
+			int is_high = (i % 2 == 0);
+
+			if (is_high)
+				ioba[pair_idx] = (unsigned long)
+					descs[i].fields.address << 32;
+			else
+				ioba[pair_idx] |= descs[i].fields.address;
+		}
+
+		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
+						     handle,
+						     buffersznum,
+						     ioba[0], ioba[1], ioba[2],
+						     ioba[3], ioba[4], ioba[5]);
+		adapter->hcall_stats.add_bufs_queue++;
+	} else if (filled == 1) {
+		rc = h_add_logical_lan_buffer(vdev->unit_address,
+					      descs[0].desc);
+		adapter->hcall_stats.add_buf++;
+	} else {
+		rc = h_add_logical_lan_buffers(vdev->unit_address,
+					       descs[0].desc, descs[1].desc,
+					       descs[2].desc, descs[3].desc,
+					       descs[4].desc, descs[5].desc,
+					       descs[6].desc, descs[7].desc);
+		adapter->hcall_stats.add_bufs++;
+	}
+
+	return rc;
+}
+
 /* replenish the buffers for a pool.  note that we don't need to
  * skb_reserve these since they are used for incoming...
  */
 static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
-					  struct ibmveth_buff_pool *pool)
+					  struct ibmveth_buff_pool *pool,
+					  int queue_index)
 {
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
@@ -678,24 +752,16 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		if (!filled)
 			break;
 
-		/* single buffer case*/
-		if (filled == 1)
-			lpar_rc = h_add_logical_lan_buffer(vdev->unit_address,
-							   descs[0].desc);
-		else
-			/* Multi-buffer hcall */
-			lpar_rc = h_add_logical_lan_buffers(vdev->unit_address,
-							    descs[0].desc,
-							    descs[1].desc,
-							    descs[2].desc,
-							    descs[3].desc,
-							    descs[4].desc,
-							    descs[5].desc,
-							    descs[6].desc,
-							    descs[7].desc);
+		lpar_rc = ibmveth_add_logical_lan_buffers(adapter, descs,
+							  filled,
+							  pool->buff_size,
+							  queue_index);
+
 		if (lpar_rc != H_SUCCESS) {
 			dev_warn_ratelimited(dev,
-					     "RX h_add_logical_lan failed: filled=%u, rc=%lu, batch=%u\n",
+					     "RX h_add_logical_lan %s failed: filled=%u, rc=%lu, batch=%u\n",
+					     adapter->multi_queue ?
+					     "_queue" : "",
 					     filled, lpar_rc, batch);
 			goto hcall_failure;
 		}
@@ -736,24 +802,23 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		}
 		adapter->replenish_add_buff_failure += filled;
 
-		/*
-		 * If multi rx buffers hcall is no longer supported by FW
-		 * e.g. in the case of Live Partition Migration
-		 */
-		if (batch > 1 && lpar_rc == H_FUNCTION) {
-			/*
-			 * Instead of retry submit single buffer individually
-			 * here just set the max rx buffer per hcall to 1
-			 * buffers will be respleshed next time
-			 * when ibmveth_replenish_buffer_pool() is called again
-			 * with single-buffer case
-			 */
-			netdev_info(adapter->netdev,
-				    "RX Multi buffers not supported by FW, rc=%lu\n",
-				    lpar_rc);
-			adapter->rx_buffers_per_hcall = 1;
-			netdev_info(adapter->netdev,
-				    "Next rx replesh will fall back to single-buffer hcall\n");
+		if (lpar_rc == H_FUNCTION) {
+			if (adapter->multi_queue) {
+				netdev_err(adapter->netdev,
+					   "MQ buffer add H_FUNCTION (q=%d, batch=%d)\n",
+					   queue_index, batch);
+			} else if (batch > 1) {
+				/*
+				 * Live Partition Migration may drop multi-
+				 * buffer support. Fall back to single-buffer
+				 * on the next replenish; do not continue with
+				 * a stale local batch size (infinite loop).
+				 */
+				netdev_warn(adapter->netdev,
+					    "Legacy batch add H_FUNCTION (batch=%d), fallback\n",
+					    batch);
+				adapter->rx_buffers_per_hcall = 1;
+			}
 		}
 		break;
 	}
@@ -775,21 +840,33 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	unsigned long flags;
 	int i;
 
+	if (queue_index >= adapter->num_rx_queues)
+		return;
+
 	adapter->replenish_task_cycles++;
 
+	spin_lock_irqsave(&rxq->replenish_lock, flags);
+
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue_index][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
-			ibmveth_replenish_buffer_pool(adapter, pool);
+			ibmveth_replenish_buffer_pool(adapter, pool,
+						      queue_index);
 	}
 
 	ibmveth_update_rx_no_buffer(adapter);
+
+	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -969,6 +1046,7 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
  * @correlator: identifies pool and index
+ * @queue_index: RX queue index (0..num_rx_queues-1)
  * @reuse: whether to reuse buffer
  *
  * Return:
@@ -977,7 +1055,8 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
  * * %-EFAULT - pool and index map to null skb
  */
 static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
-					   u64 correlator, bool reuse)
+					   u64 correlator, int queue_index,
+					   bool reuse)
 {
 	unsigned int pool  = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
@@ -985,12 +1064,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	struct sk_buff *skb;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
 		schedule_work(&adapter->work);
 		return -EINVAL;
 	}
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 	if (WARN_ON(!skb)) {
 		schedule_work(&adapter->work);
 		return -EFAULT;
@@ -1004,50 +1083,55 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 		/* remove the skb pointer to mark free. actual freeing is done
 		 * by upper level networking after gro_receive
 		 */
-		adapter->rx_buff_pool[0][pool].skbuff[index] = NULL;
+		struct ibmveth_buff_pool *bpool =
+			&adapter->rx_buff_pool[queue_index][pool];
+
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
+	free_index = adapter->rx_buff_pool[queue_index][pool].producer_index;
+	adapter->rx_buff_pool[queue_index][pool].producer_index++;
+	if (adapter->rx_buff_pool[queue_index][pool].producer_index >=
+	    adapter->rx_buff_pool[queue_index][pool].size)
+		adapter->rx_buff_pool[queue_index][pool].producer_index = 0;
+	adapter->rx_buff_pool[queue_index][pool].free_map[free_index] = index;
 
 	mb();
 
-	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
+	atomic_dec(&adapter->rx_buff_pool[queue_index][pool].available);
 
 	return 0;
 }
 
 /* get the current buffer on the rx queue */
 static inline struct sk_buff *
-ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
+ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
+		       int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	u64 correlator = rxq->queue_addr[rxq->index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
 		schedule_work(&adapter->work);
 		return NULL;
 	}
 
-	return adapter->rx_buff_pool[0][pool].skbuff[index];
+	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
 
 /**
  * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
  *
  * @adapter: pointer to adapter
+ * @queue_index: RX queue index to harvest from
  * @reuse:   whether to reuse buffer
  *
  * Context: called from ibmveth_poll
@@ -1057,21 +1141,20 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
  * * other - non-zero return from ibmveth_remove_buffer_from_pool
  */
 static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				      bool reuse)
+				      int queue_index, bool reuse)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	u64 cor;
 	int rc;
 
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
-
 	cor = rxq->queue_addr[rxq->index].correlator;
-	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
+	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
 	if (unlikely(rc))
 		return rc;
 
-	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
-		adapter->rx_queue[0].index = 0;
-		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
+	if (++rxq->index == rxq->num_slots) {
+		rxq->index = 0;
+		rxq->toggle = !rxq->toggle;
 	}
 
 	return 0;
@@ -1993,34 +2076,45 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
-	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi[0]);
-	struct net_device *netdev = adapter->netdev;
+	struct net_device *netdev = napi->dev;
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
 	unsigned long lpar_rc;
+	int queue_index, rc;
 	u16 mss = 0;
 
+	queue_index = napi - adapter->napi;
+
+	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
+		return 0;
+
 restart_poll:
 	while (frames_processed < budget) {
-		if (!ibmveth_rxq_pending_buffer(adapter))
+		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
-		if (!ibmveth_rxq_buffer_valid(adapter)) {
+		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+			rc = ibmveth_rxq_harvest_buffer(adapter,
+							queue_index, true);
+			if (unlikely(rc))
 				break;
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
 			__sum16 iph_check = 0;
 
-			skb = ibmveth_rxq_get_buffer(adapter);
+			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
 			if (unlikely(!skb))
 				break;
 
@@ -2045,12 +2139,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 							length);
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
-						length + offset);
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+							     length + offset);
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								true);
+				if (unlikely(rc))
 					break;
 				skb = new_skb;
 			} else {
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								false);
+				if (unlikely(rc))
 					break;
 				skb_reserve(skb, offset);
 			}
@@ -2086,7 +2186,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, queue_index);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2097,14 +2197,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	lpar_rc = ibmveth_enable_irq(adapter, 0);
-	if (WARN_ON(lpar_rc != H_SUCCESS)) {
+	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev,
+			   "Failed to enable IRQ for queue %d (rc=0x%lx), scheduling reset\n",
+			   queue_index, lpar_rc);
 		schedule_work(&adapter->work);
 		goto out;
 	}
 
-	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
-		lpar_rc = ibmveth_disable_irq(adapter, 0);
+	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    napi_schedule(napi)) {
+		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
+		WARN_ON(lpar_rc != H_SUCCESS);
 		goto restart_poll;
 	}
 
@@ -2229,9 +2334,13 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i;
 
-	ibmveth_replenish_task(adapter);
-	ibmveth_schedule_rx_queue(adapter, 0);
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		ibmveth_replenish_task(adapter, i);
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		ibmveth_schedule_rx_queue(adapter, i);
 }
 #endif
 
@@ -2428,7 +2537,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
+		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
 			    adapter->rx_buffers_per_hcall);
@@ -2775,17 +2884,29 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
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
@@ -2830,15 +2951,15 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter, 0));
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter, 0));
 
 	pool->skbuff[0] = skb;
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter, 0));
 
 	flush_work(&adapter->work);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 2cfabddeee3d..f0b2d470d012 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -14,6 +14,8 @@
 #ifndef _IBMVETH_H
 #define _IBMVETH_H
 
+#include <linux/spinlock_types.h>
+
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
 #define IbmVethMcastReceptionEnableBit     0x20000UL
@@ -260,7 +262,9 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_DEFAULT_QUEUES 8U
 #define IBMVETH_MAX_RX_QUEUES 1U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
-#define IBMVETH_MAX_RX_PER_HCALL 8U
+#define IBMVETH_MAX_RX_REGULAR 8U
+#define IBMVETH_MAX_RX_QUEUE 12U
+#define IBMVETH_MAX_RX_PER_HCALL 12U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
@@ -302,6 +306,7 @@ struct ibmveth_rx_q {
     dma_addr_t queue_dma;
     u32        queue_len;
     struct ibmveth_rx_q_entry *queue_addr;
+	spinlock_t	replenish_lock;	/* per-queue buffer replenish */
 };
 
 struct ibmveth_adapter {
-- 
2.50.1 (Apple Git-155)


