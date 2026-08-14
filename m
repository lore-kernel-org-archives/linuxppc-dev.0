Return-Path: <linuxppc-dev+bounces-25848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B3EC5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGm1Jtsz2yrS;
	Fri, 14 Aug 2026 17:38:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693104;
	cv=none; b=aATtdNflDxqWU4bkJXpQM7ZYV/zRM95AsKoedddt+oTetDvU1vFC41UtDCCoKDNoVzdggHXOpG8GXpuM9pS3ewMZ+ZC1Uv+yscT/DyKYv2dDplbM9rRIg/mvqANzy9CklpaCNhNdGaVm5JkzDZ9c+vzfg8Ln7+y5jPjzjy3Uc8A+fe80FTuUzqL4iOF+4G8Y7Mly7I8Sgd4NU5vsfui2fh/pNl+BHu5vRHPlGjjSXaixBhwuz6gxIDj6ryjdhls9dqVkwfdiAGXzcWcBOt4ltQIsbDlIYurSusa2o68b4h2Bxfki5Sjp0teSF79MStKQSzgdCA9zOogO3C+AFsPSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693104; c=relaxed/relaxed;
	bh=Ad9QiTHUyNYRgt1IG14Ao09JkWHrx0idANQVd4U4aSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVcPLBfTKHaEZ2EICavgXiYOwpr46vbdiopkU6Np8FY+bnUL+fkhUJ4FhMO/GF+KvU58G5xMVF8DEyY7jmgqTCls63d5xK+YrCDp6+a7aarW8XesONPLAgYcyYpV9il8WPHYp3KLZPnb1KDj1Vijd2huYm7t4SOjwo86CsXVLsplLuoya5am5wGoIAiPY2B3pSZC7f28t1UciKS//Wnv/I001/7QowbDOsMQBb/ymApEhkSYkxAcCAfin2BLHs+fbMWwnfct9HM2WDDzTy/1ldA5LHfRl2ddBT2ucC/G6XCdX6zqVMZ5blUMGIVMdu6Bk+5LsHLERGJZTc8M+MW4bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sv4qYpRj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sv4qYpRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGk1WrQz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:22 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Veop154741;
	Fri, 14 Aug 2026 07:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ad9QiT
	HUyNYRgt1IG14Ao09JkWHrx0idANQVd4U4aSs=; b=Sv4qYpRjuuPb8zafbSXgz2
	qLRiF+4WGdqLQzYJ72EKSX53Q3mNRseJw3MmdL+Dk6iMGUgKg9uyuRQKuiVtWKeV
	+iaka0K3ddmjcTfyGtOrHQ4727Gb8w4D5F2RccuQtEhqiwPSxNKtKJYInZ6s+NpQ
	u49fkyqMrIyoyy9lU8uA8aFMItZv0iQBrxnfDgx6IyobEWnLDBjvRPoCUWoaSu2a
	l6noZCdIUcx7h+kU2pkCkStUQLnaUUtbwNCE1xCzLvV2DcjQrE8b8vnG95dfl+5m
	gGRPs+cooVwYNBifL7N/IHaDnctVI+UTOjKLCg/ZpsUkUJjcoMoKtQaX2akdBtvw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma3tt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QUmS018434;
	Fri, 14 Aug 2026 07:38:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wegb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7c7Ip8389242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF0E58059;
	Fri, 14 Aug 2026 07:38:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AF6258057;
	Fri, 14 Aug 2026 07:38:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:05 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 08/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Fri, 14 Aug 2026 00:36:35 -0700
Message-Id: <20260814073642.24630-9-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX7ny8AdyABklH
 vUPFDFK9F74zRwlXoTRJ41YhVOxhylffrMoIL4HyGmoMJYitZDD9MFwACXvL1BT6nX0HMg9aWXS
 jlTk4MFD20Opu0C/4CxRIeP52/kcXnWdsXD60qkyPip6ajwTI5e0LZoTXr9aWZnkXaDs2eo/6cs
 basjAFcGwYW0ZVK1okEnGZRhT7Z7IvA61ADzMlNsnpMkm3Z7nFCE3uc9Xi6Qw9Mp1ZI2LFRK5bv
 lY4EymDe3qwsuAjHNx+AwjuRwi5Dmlz+kZXVl0UZ8ELiwLJ1zt7NCTaSHu1nLxaSSIikiTeTq5z
 ffnhA4IUKnc7Xt6vtqJ3IxxaSGq3LOxXsIj4Wnm/7Ii+7gWpIHNq0jr5NFRtNXCUSm7VmfWtRZn
 8Y/5lv7Fx+c9gKdRi9jkzMwROuUOMfsLb241/ZYpKxdnNhERkgzPKFac1lLx+Tv4lLin2HkBht4
 xHaDuWWJbJy/OH6yWBw==
X-Proofpoint-ORIG-GUID: 7Ufj-QeOGq7tM4Vv4gEANHMK_ZqAHDEf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX32EtpTPkBEyd
 UlJuqygqXDCxkuJ2Fx+KAowfhczcKJF3W2lyOpxCy6QtOVsYGbt6CaIFmXxaIQromFPCOdSbpmX
 lF4o/kNaU0ykyQOOVAeR6dM9qEhYAvg=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ec5e5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=9GrW9DZCARAA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ItV1hPmXq1jqDTiKBwIA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: HZP0idTRpxUOV6lt6KiXoIliEwyue_4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Replenish is the last open-path hypervisor call that still needs
per-queue awareness before MQ is turned on. Today
ibmveth_replenish_buffer_pool() calls h_add_logical_lan_buffer() or
h_add_logical_lan_buffers() directly; MQ posts via
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against adapter->queue_handle[].

Add ibmveth_add_logical_lan_buffers() to pick the hcall:
multi_queue uses h_add_logical_lan_buffers_queue() (up to 12 buffers;
IOBAs packed two per word: even indices in the high 32 bits, odd in
the low); legacy uses the existing single- and multi-buffer hcalls.
Count add_buf/add_bufs/add_bufs_queue in hcall_stats.

Thread queue_index through the RX helpers used by poll and replenish,
and update open/poll/netpoll callers so arity stays consistent. Add
per-queue replenish_lock so later concurrent NAPI/resize paths can
serialize buffer posting (producer and harvest/remove consumer).

Until MQ enablement, callers still pass queue 0 and legacy hcalls
remain the live path.

H_FUNCTION handling is split:
  - multi_queue: schedule adapter reset after dropping replenish_lock
    (do not printk under the lock - netconsole can re-enter replenish)
  - legacy multi-buffer LPM fallback: set rx_buffers_per_hcall = 1 and
    break so the next replenish re-samples batch as 1

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- On MQ buffer-add H_FUNCTION: schedule adapter reset after dropping
  replenish_lock (v4 logged/broke with no recovery; can permanently dry
  the pool)
- Move replenish fail logging / reset scheduling out from under
  replenish_lock so netconsole cannot deadlock re-entering replenish
- Serialize harvest/remove with per-queue replenish_lock (netpoll
  replenish vs NAPI consumer; v4 locked producer only)
- Fail logs use real wrapper names: h_add_logical_lan_buffers[_queue] /
  h_add_logical_lan_buffer (v4 interpolated broken lan[_queue] strings)
- Document replenish_lock + no-printk-under-lock for netconsole (first
  lock use); outcomes enum + ibmveth_replenish_fail defined here
- Defer adapter-global counter atomics and irqsave critical-section
  shorten to cover follow-up
- Bad queue_index poll path: napi_complete before return lands with
  poll harden (not claimed fully here)
- Keep pool active/size/threshold across free_buffer_pool (probe/sysfs
  geometry); only clear runtime allocations + available (ifdown/up
  reopen must still see active pools)
- get_buffer: use correlator_valid (drop WARN_ON; keep schedule_work
  until poll skip owns reset)
- Introduce ibmveth_rxq_correlator_valid / ibmveth_rxq_advance at first
  remove/harvest use; init replenish_lock in remove_buffer KUnit
- On RESET_MAP/RESET_MQ, stop remaining pool walks (goto unlock)

Changes in v4:
- Introduce queue-aware replenish/poll helpers with their first callers
  in the same patch; do not leave a 2-arg replenish call ahead of the
  signature change.
- Restore the pre-MQ LPM H_FUNCTION break instead of continue; do not
  loop forever on a stale local batch size.
- Fold per-queue replenish_lock into this patch.
- Update kdoc for MQ parameters on remove_buffer_from_pool /
  rxq_harvest_buffer.

 drivers/net/ethernet/ibm/ibmveth.c | 523 +++++++++++++++++++++--------
 drivers/net/ethernet/ibm/ibmveth.h |   6 +-
 2 files changed, 387 insertions(+), 142 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 8519cad50322..58a639a962a6 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -30,6 +30,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <asm/hvcall.h>
 #include <linux/atomic.h>
 #include <asm/vio.h>
@@ -101,49 +102,58 @@ static struct ibmveth_stat ibmveth_stats[] = {
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
@@ -262,6 +272,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
 		adapter->rx_queue[i].index = 0;
 		adapter->rx_queue[i].num_slots = rxq_entries;
 		adapter->rx_queue[i].toggle = 1;
+		spin_lock_init(&adapter->rx_queue[i].replenish_lock);
 
 		netdev_dbg(netdev, "queue %d: buffer_list @ 0x%p (DMA: 0x%llx), rx_queue @ 0x%p (DMA: 0x%llx), %llu entries\n",
 			   i, adapter->buffer_list_addr[i],
@@ -696,11 +707,92 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
-/* replenish the buffers for a pool.  note that we don't need to
- * skb_reserve these since they are used for incoming...
+/**
+ * ibmveth_add_logical_lan_buffers - Add receive buffers to hypervisor
+ * @adapter: ibmveth adapter structure
+ * @descs: array of buffer descriptors to add
+ * @filled: number of valid descriptors in the array
+ * @buff_size: size of each buffer (multi-queue mode only)
+ * @queue_index: RX queue index
+ *
+ * Return: hypervisor return code
  */
-static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
-					  struct ibmveth_buff_pool *pool)
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
+/* Outcomes for ibmveth_replenish_buffer_pool(); logged after unlock. */
+enum {
+	IBMVETH_REPLENISH_OK = 0,
+	IBMVETH_REPLENISH_RESET_MAP,
+	IBMVETH_REPLENISH_RESET_MQ,
+	IBMVETH_REPLENISH_HCALL_FAIL,
+	IBMVETH_REPLENISH_BATCH_FALLBACK,
+};
+
+struct ibmveth_replenish_fail {
+	unsigned long lpar_rc;
+	u32 filled;
+	u32 batch;
+};
+
+/* Replenish the buffers for a pool.
+ * Caller must hold the per-queue replenish_lock. Do not printk here —
+ * netconsole on the same device can re-enter replenish_task.
+ */
+static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
+					 struct ibmveth_buff_pool *pool,
+					 int queue_index,
+					 struct ibmveth_replenish_fail *fail)
 {
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
@@ -712,6 +804,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 	dma_addr_t dma_addr;
 	struct device *dev;
 	u32 index;
+	int outcome = IBMVETH_REPLENISH_OK;
 
 	vdev = adapter->vdev;
 	dev = &vdev->dev;
@@ -726,12 +819,9 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		/* Fill a batch of descriptors */
 		for (filled = 0; filled < min(remaining, batch); filled++) {
 			index = pool->free_map[free_index];
-			if (WARN_ON(index == IBM_VETH_INVALID_MAP)) {
+			if (index == IBM_VETH_INVALID_MAP) {
 				adapter->replenish_add_buff_failure++;
-				netdev_info(adapter->netdev,
-					    "Invalid map index %u, reset\n",
-					    index);
-				schedule_work(&adapter->work);
+				outcome = IBMVETH_REPLENISH_RESET_MAP;
 				break;
 			}
 
@@ -783,28 +873,21 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 				free_index = 0;
 		}
 
+		if (outcome != IBMVETH_REPLENISH_OK)
+			break;
+
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
-			dev_warn_ratelimited(dev,
-					     "RX h_add_logical_lan failed: filled=%u, rc=%lu, batch=%u\n",
-					     filled, lpar_rc, batch);
+			fail->lpar_rc = lpar_rc;
+			fail->filled = filled;
+			fail->batch = batch;
 			goto hcall_failure;
 		}
 
@@ -844,30 +927,35 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
+				/*
+				 * LPM / firmware may drop MQ buffer hcalls.
+				 * Schedule reset so we do not sit forever in
+				 * no-buffer with the link still up.
+				 */
+				outcome = IBMVETH_REPLENISH_RESET_MQ;
+			} else if (batch > 1) {
+				/*
+				 * Live Partition Migration may drop multi-
+				 * buffer support. Fall back to single-buffer
+				 * on the next replenish; do not continue with
+				 * a stale local batch size (infinite loop).
+				 */
+				adapter->rx_buffers_per_hcall = 1;
+				outcome = IBMVETH_REPLENISH_BATCH_FALLBACK;
+			} else {
+				outcome = IBMVETH_REPLENISH_HCALL_FAIL;
+			}
+		} else {
+			outcome = IBMVETH_REPLENISH_HCALL_FAIL;
 		}
 		break;
 	}
 
 	mb();
 	atomic_add(buffers_added, &(pool->available));
+	return outcome;
 }
 
 /*
@@ -883,21 +971,85 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
-	int i;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	struct ibmveth_replenish_fail fail = {};
+	unsigned long flags;
+	int i, rc;
+	int need_reset = 0;
+	int batch_fallback = 0;
+	int hcall_fail = 0;
+
+	if (queue_index >= adapter->num_rx_queues) {
+		netdev_dbg(adapter->netdev,
+			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
+			   queue_index, adapter->num_rx_queues);
+		return;
+	}
 
 	adapter->replenish_task_cycles++;
 
-	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
+	spin_lock_irqsave(&rxq->replenish_lock, flags);
 
-		if (pool->active &&
-		    (atomic_read(&pool->available) < pool->threshold))
-			ibmveth_replenish_buffer_pool(adapter, pool);
+	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue_index][i];
+
+		if (pool->active && pool->free_map &&
+		    (atomic_read(&pool->available) < pool->threshold)) {
+			rc = ibmveth_replenish_buffer_pool(adapter, pool,
+							   queue_index, &fail);
+			switch (rc) {
+			case IBMVETH_REPLENISH_RESET_MAP:
+			case IBMVETH_REPLENISH_RESET_MQ:
+				need_reset = rc;
+				goto out_unlock;
+			case IBMVETH_REPLENISH_BATCH_FALLBACK:
+				batch_fallback = 1;
+				break;
+			case IBMVETH_REPLENISH_HCALL_FAIL:
+				hcall_fail = 1;
+				break;
+			default:
+				break;
+			}
+		}
 	}
 
+out_unlock:
 	ibmveth_update_rx_no_buffer(adapter);
+
+	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
+
+	/* Log and schedule reset only after dropping replenish_lock. */
+	if (need_reset == IBMVETH_REPLENISH_RESET_MAP) {
+		netdev_info(adapter->netdev,
+			    "Invalid RX free_map entry on queue %d, reset\n",
+			    queue_index);
+		schedule_work(&adapter->work);
+	} else if (need_reset == IBMVETH_REPLENISH_RESET_MQ) {
+		dev_err_ratelimited(&adapter->netdev->dev,
+				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
+				    queue_index, fail.batch);
+		schedule_work(&adapter->work);
+	}
+
+	if (batch_fallback)
+		dev_warn_ratelimited(&adapter->netdev->dev,
+				     "Legacy batch add H_FUNCTION (batch=%u), fallback\n",
+				     fail.batch);
+
+	if (hcall_fail)
+		dev_warn_ratelimited(&adapter->netdev->dev,
+				     "RX %s failed: filled=%u, rc=%lu, batch=%u\n",
+				     adapter->multi_queue ?
+				     "h_add_logical_lan_buffers_queue" :
+				     (fail.batch == 1 ?
+				      "h_add_logical_lan_buffer" :
+				      "h_add_logical_lan_buffers"),
+				     fail.filled, fail.lpar_rc, fail.batch);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -932,6 +1084,14 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 		kfree(pool->skbuff);
 		pool->skbuff = NULL;
 	}
+
+	/*
+	 * Keep probe/sysfs geometry (active, size, buff_size, threshold).
+	 * Clearing active here was a v3 ifdown/up regression: open skips
+	 * !active pools, so reopen posted no RX buffers (TX OK, ARP/RX
+	 * dead) at any queue count, including RX=8 with no -L.
+	 */
+	atomic_set(&pool->available, 0);
 }
 
 /**
@@ -1070,35 +1230,75 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   adapter->num_rx_queues);
 }
 
+static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
+					 int queue_index, u64 correlator)
+{
+	unsigned int pool = correlator >> 32;
+	unsigned int index = correlator & 0xffffffffUL;
+	struct ibmveth_buff_pool *bpool;
+
+	if (pool >= IBMVETH_NUM_BUFF_POOLS)
+		return false;
+
+	bpool = &adapter->rx_buff_pool[queue_index][pool];
+
+	/* init_buffer_pool() sets size for inactive pools; free_buffer_pool()
+	 * clears skbuff but used to leave size/active set. Require a live
+	 * pool with allocated arrays before indexing.
+	 */
+	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
+		return false;
+
+	return index < bpool->size;
+}
+
+static void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
+{
+	if (++rxq->index == rxq->num_slots) {
+		rxq->index = 0;
+		rxq->toggle = !rxq->toggle;
+	}
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
  * @correlator: identifies pool and index
+ * @queue_index: RX queue index (0..num_rx_queues-1)
  * @reuse: whether to reuse buffer
  *
+ * Context: may run concurrently with netpoll replenish_task on the same
+ * queue; takes per-queue replenish_lock to serialize free_map /
+ * producer_index / available against the producer.
+ *
  * Return:
  * * %0       - success
  * * %-EINVAL - correlator maps to pool or index out of range
  * * %-EFAULT - pool and index map to null skb
  */
 static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
-					   u64 correlator, bool reuse)
+					   u64 correlator, int queue_index,
+					   bool reuse)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	unsigned int pool  = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 	unsigned int free_index;
 	struct sk_buff *skb;
+	unsigned long flags;
+	int rc = 0;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
-		schedule_work(&adapter->work);
-		return -EINVAL;
+	spin_lock_irqsave(&rxq->replenish_lock, flags);
+
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
+		rc = -EINVAL;
+		goto out_unlock;
 	}
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
-	if (WARN_ON(!skb)) {
-		schedule_work(&adapter->work);
-		return -EFAULT;
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
+	if (!skb) {
+		rc = -EFAULT;
+		goto out_unlock;
 	}
 
 	/* if we are going to reuse the buffer then keep the pointers around
@@ -1109,75 +1309,88 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
 
-	return 0;
+out_unlock:
+	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
+	return rc;
 }
 
 /* get the current buffer on the rx queue */
-static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
+static inline struct sk_buff *
+ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
+		       int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	u64 correlator = rxq->queue_addr[rxq->index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
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
  *
+ * On a bad correlator (-EINVAL/-EFAULT) the ring is still advanced so poll
+ * cannot spin forever on one slot. The error is still returned: callers must
+ * not treat it as a successful take from the pool (especially reuse=false,
+ * which would hand the SKB to the stack while it remains pool-owned).
+ *
  * Return:
- * * %0    - success
- * * other - non-zero return from ibmveth_remove_buffer_from_pool
+ * * %0    - buffer removed from pool (or marked for reuse) and ring advanced
+ * * other - non-zero return from ibmveth_remove_buffer_from_pool; ring has
+ *           still been advanced for -EINVAL/-EFAULT
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
-	if (unlikely(rc))
+	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
+	if (unlikely(rc)) {
+		/* Skip a corrupt slot without claiming pool ownership. */
+		if (rc == -EINVAL || rc == -EFAULT)
+			ibmveth_rxq_advance(rxq);
 		return rc;
-
-	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
-		adapter->rx_queue[0].index = 0;
-		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
 	}
 
+	ibmveth_rxq_advance(rxq);
+
 	return 0;
 }
 
@@ -2127,34 +2340,41 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
-	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi[0]);
-	struct net_device *netdev = adapter->netdev;
+	struct net_device *netdev = napi->dev;
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
-	int rc;
+	int queue_index, rc;
 	u16 mss = 0;
 
+	queue_index = napi - adapter->napi;
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
 
@@ -2179,12 +2399,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
@@ -2220,7 +2446,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, queue_index);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2231,14 +2457,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	rc = ibmveth_enable_irq(adapter, 0);
-	if (WARN_ON(rc)) {
+	rc = ibmveth_enable_irq(adapter, queue_index);
+	if (rc) {
+		netdev_err(netdev,
+			   "Failed to enable IRQ for queue %d (rc=%d), scheduling reset\n",
+			   queue_index, rc);
 		schedule_work(&adapter->work);
 		goto out;
 	}
 
-	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
-		rc = ibmveth_disable_irq(adapter, 0);
+	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    napi_schedule(napi)) {
+		rc = ibmveth_disable_irq(adapter, queue_index);
 		WARN_ON(rc);
 		goto restart_poll;
 	}
@@ -2369,7 +2599,7 @@ static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, 0);
 	ibmveth_schedule_rx_queue(adapter, 0);
 }
 #endif
@@ -2568,7 +2798,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
+		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
 			    adapter->rx_buffers_per_hcall);
@@ -2889,8 +3119,7 @@ static void ibmveth_reset_kunit(struct work_struct *w)
  * @test: pointer to kunit structure
  *
  * Tests the error returns from ibmveth_remove_buffer_from_pool.
- * ibmveth_remove_buffer_from_pool also calls WARN_ON, so dmesg should be
- * checked to see that these warnings happened.
+ * Bad correlators return -EINVAL/-EFAULT (no WARN_ON).
  *
  * Return: void
  */
@@ -2904,6 +3133,8 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
+	spin_lock_init(&adapter->rx_queue[0].replenish_lock);
+
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
@@ -2915,17 +3146,29 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
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
@@ -2934,9 +3177,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
  * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
  * @test: pointer to kunit structure
  *
- * Tests ibmveth_rxq_get_buffer. ibmveth_rxq_get_buffer also calls WARN_ON for
- * the NULL returns, so dmesg should be checked to see that these warnings
- * happened.
+ * Tests ibmveth_rxq_get_buffer invalid correlator returns NULL without WARN.
  *
  * Return: void
  */
@@ -2970,15 +3211,15 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
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
index fae3473cc498..d02444d5b3b8 100644
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
@@ -259,7 +261,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_DEFAULT_QUEUES 8U
 #define IBMVETH_MAX_RX_QUEUES 1U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
-#define IBMVETH_MAX_RX_PER_HCALL 8U
+#define IBMVETH_MAX_RX_REGULAR 8U
+#define IBMVETH_MAX_RX_PER_HCALL 12U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
@@ -301,6 +304,7 @@ struct ibmveth_rx_q {
     dma_addr_t queue_dma;
     u32        queue_len;
     struct ibmveth_rx_q_entry *queue_addr;
+	spinlock_t	replenish_lock;	/* per-queue buffer replenish */
 };
 
 struct ibmveth_adapter {
-- 
2.50.1 (Apple Git-155)


