Return-Path: <linuxppc-dev+bounces-28222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB06C98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:40:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzyk2Cy0z30W5;
	Sat, 26 Sep 2026 04:39:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361598;
	cv=none; b=BIz3q7Mz78ktwgom1JE/Wwbj7oclQgobB5v7LNboW08D7nr6UCBttumkcFXuJTzZk5vgU4HLPpvAZ+Gm7NLNl9VjN0uNlhw9O7wla8VBLI/6pV2U6X1YGpQh5dvVVb/2bVizaA4NyMIEPbuYCoGolfeN/5dDu3zD+T6G/pUZizho20nJ9AzCisI9Y+jWPLCrU1tiPEG7yaPIhEvlStA5SXCNzbpM7FqGCB48mtKCTtBVaoZFvFiLxjcWK5b9u8WQ1lhIuf8pwm/yy+el8/YI/I7aO+pndrowYy6txGm/NnYYXzRZhS2q3DnmLqv4EriFvCwp4ID2yZSRnTvW3jrePw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361598; c=relaxed/relaxed;
	bh=yeX5WgdrAGCwiWl3I/WlFqYDajfamFNTcJeD7jW0mrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AasplgxPBXvvk7Bx5XY5ZSA8i0R/JmUasqevlfSm/XY0g0mHnen3J4j+Fut1pdq/Ojh3wTr1O/MKBmD4+S21S4iBF5WR0HlkaEmeqjDckTymwShRFXopHbLhRMeqavsgn9/It6seDHmYUm1aqtIkf8SABEIULBEcDQ1Zb4okPTwGqQzURMcAlzs8kSRKW7wyYmIIw5yWbcoFBOXAxyyaAWnVRXrB8Tdr8MEUL3qgXo4OxYddSlROEd0VrJ2Zv+2TMLZEq6w+QyACx0iH1w6Unr7qIlFDHjETiChbWzE0a8BoFOJ6wOno4nJgGsjoZsyt/Pz61cOGQNI/sP2Dw4sOMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VrJ4ypZ5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VrJ4ypZ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyh2Rbwz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:56 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5IhY3853610;
	Fri, 25 Sep 2026 18:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yeX5WgdrAGCwiWl3I
	/WlFqYDajfamFNTcJeD7jW0mrA=; b=VrJ4ypZ5g114S5iDieCtLutm9LQEkDrqX
	70yCnqP9ud+I5lPiJoz/2E5q/XtfKN6E3dhfYqyX94cEOQxcvPJu/qrIc5j7728e
	LoUzz1Ku2VDUNtvqNRsZ1rz0RkV9zXlR9bhjZR/o97LTxwEEc3Anmc+PbeCiHN64
	SAyDAeuEIxXpmLj6iySaT0xroC43STFfuTZMqK400ylrhn7OecNSumJRx8mizckl
	YXi1Q7AvJr+3+l6n+rrAyEBLZR+nTM8b3eYicin0gJZOc+E3Z0mIaesCCDQFCB02
	Mzzg5qvR3fNFJNWzdD1C8EnoQYs4tlWsG+4fvCXCJc/KEJpMZbmGQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske28neg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG37pq4192010;
	Fri, 25 Sep 2026 18:39:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k3kry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIcuk89175762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:38:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF51158059;
	Fri, 25 Sep 2026 18:39:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F33558055;
	Fri, 25 Sep 2026 18:39:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:37 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 10/15] ibmveth: Enable multi-queue RX receive path
Date: Fri, 25 Sep 2026 11:38:45 -0700
Message-Id: <5b0d412f10728f5708b02adf90ced701d4303222.1790319558.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790319558.git.mmc@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ogcZsXs2JnORIwB6NCDi_5_vHfIvFZ3B
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6bff2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6dIgW8r3vzBZiC2zQu8A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXxU/KVZI5ku6M
 igO85cDwhINB9HRK+lVH/If7ixwsLs77g6kuE9WkftsUFDA6tGPYvsU+aKrz5rQvHJOGPObfh9Q
 VVdREt5hKyTh6QQrlJv1PqZyr2yaOCc=
X-Proofpoint-GUID: MW5QI602GWwH_RXe8anQE45GVQogE7LR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX6hn0AU9bUqxB
 mSZiuyrwE2q9EVc6JYu0hBC0LJdutNEaLGGIHHE4dRGYxkb5qKjm+a9TQn7WqZPP9B01QirjmBt
 9oyrJwFd9LkqtooYS+XBUsoz11ovNbPx+N/NqUvauacCmrrJnmkyv0+l22twD4GBmSTo6eFB363
 lyIoDYhLN2NiX6YzvPLZHIjDWNtvM4PQBhO4exxmvBCGza4SH6rw5wQXwopuV9EbrlfYBg1Oz1W
 0/gM8zUnOLYuzjLeoxP13VLQ4P3H/2TdTv9QUgtDe8WddP3KcsuoKHe+ELuqUnuc7AO+yj6FBnW
 jwdI8juK6QsGYL7jn7m7jofyXblQkMVbM2dRI6tJYGD+ZkPoOanpMlcvnaqZWPPurQZN5Lwk4n7
 xNaPMzKN9Wn6LqW03Jzlti6Ei7+5nPIaA9lguZKJ2QsmAHrm/BOmosswwQjtSuMs7rpyJYXH10S
 s717TBEC/kvyeeHVsIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Turn on the live MQ RX path when firmware sets
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES. Probe sets
multi_queue and num_rx_queues to min(num_online_cpus(),
IBMVETH_DEFAULT_QUEUES), matching the existing TX default (cap 8).
IBMVETH_MAX_RX_QUEUES goes from 1 to 16, which is what actually gives
the adapter more than one RX ring: every rx_queue[], queue_handle[]
and queue_irq[] array sized by it grows to sixteen entries.
multi_queue also becomes a bool, now that it is a flag and not a count.
MQ firmware also raises the replenish batch from eight buffers per
hypercall to twelve, the argument-list capacity of
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, by setting rx_buffers_per_hcall to
IBMVETH_MAX_RX_PER_HCALL instead of IBMVETH_MAX_RX_REGULAR.
Patch 14 wires live ethtool -L rx (set_channels reads rx_count and
calls resize_rx_channels). Patch 15 completes the down-path
publish/rollback and caps max_rx at the live RX count once mq_fallback
latches.
This commit does not implement set_channels / rx_count. Without the bit,
behaviour stays single-queue.

Wire subordinate queues through H_REG_LOGICAL_LAN_QUEUE (with
irq_create_mapping for subordinate virqs), request_irq/napi_enable,
and PHYP enable_irq when multi_queue && num_rx_queues > 1. Queue 0
continues to use netdev->irq and is never disposed with the
subordinates.

Restate open() here (supersedes the register-helpers patch kick):

  ... register_rx_queues / set_real_num_rx_queues ...
  replenish_task() for every live RX queue   (before IRQ setup)
  setup_rx_interrupts()                      (MQ also unmasks PHYP)
  restart_rx_queue() for every live queue    (schedule NAPI, or
                                             enable_irq if prep fails)
  ... alloc_tx_resources / tx_start / opened ...

That path is the same for SQ and MQ; it replaces the prior
setup-then-schedule_rx_queue(0) kick. Close shape is unchanged.

H_FUNCTION means firmware withdrew MQ. Both the subordinate-register
and the buffer-add path latch mq_fallback, so the next open comes up
single-queue (apply_mq_fallback at open entry); they differ in what
happens to the open in progress. Register fails it outright rather
than dropping to single-queue silently mid-open, and buffer-add
schedules a reset. Reset does not retry if that close/open fails.
Both setup failure paths dispose subordinate virq mappings, so a
request_irq failure after successful registration cannot leak Linux
mappings.

On probe failure after pool kobjects were created, put them before
free_netdev(). The leak is pre-existing and unrelated to multi-queue;
the probe_cleanup helper lands in patch 11.

get_desired_dma() sizes RX from queue-0 pool metadata across
num_rx_queues. CMO (Power9 and earlier) and MQ firmware (Power11+)
do not coexist, so probe does not refresh CMO desired and a CMO
partition keeps its single-queue default.

This commit adds schedule_work() producers on buffer-add H_FUNCTION,
so the remove-path unregister / cancel_work_sync reorder and reset
reg_state gate land here to prevent a queued reset from racing
device teardown. RX counters are knowingly left racy for patch 11:
adapter->rx_no_buffer is assigned rather than summed from one queue's
buffer-list page, so it reports whichever queue replenished last and
can go backwards, while rx_packets, rx_bytes, rx_invalid_buffer and
rx_large_packets are plain read-modify-writes now reached from several
NAPI instances at once, so they can lose counts; patch 11 moves both
to per-queue storage summed on read.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v7:
- register_single_rx_queue logs lpar_rc with %ld
- setup_rx_interrupts kdoc: open posts first in both modes
- wait for pool kobject release before free_netdev
- remove-path unregister/cancel reorder and reset
  reg_state gate land here alongside the reset producer
- drop the probe CMO desired refresh: CMO (Power9 and
  earlier) and MQ (Power11+) do not coexist; say so in
  the get_desired_dma() sizing comment
- commit message: drop the stale net sentence
- noted: restart enable_irq on prep fail stays;
  counters stay in P11; poll_controller
  !opened stays in P15
- noted: no CMO+MQ partition (CMO is P9, MQ is P11+);
  default-8 is the TX match, not a CMO tradeoff;
  get_desired_dma TX term is CMO desired-hint only;
  real TX LTBs already scale; those two CMO leftovers
  drop from the v7 cover

Changes in v6:
- ibmveth_get_num_rx_queues / ibmveth_publish_num_rx_queues are
  static, not static inline
- wrap the rx_buffers_per_hcall assignment (81 cols)
- smp_store_release / smp_load_acquire for num_rx_queues, not
  smp_wmb() + WRITE_ONCE()
- skb_record_rx_queue() before GRO
- drop the IBMVETH_MAX_RX_QUEUE alias (duplicated MAX_RX_PER_HCALL)
- drop WARN_ON on restart enable_irq; the helper already logs.
  Enabling on prep failure is deliberate
- drop unused kick_rx_queue_if_pending() (WERROR); patch 14 uses
  restart_rx_queue() at both sites
- register_rx_queues() kdoc: this function latches mq_fallback on
  -EOPNOTSUPP
- noted: pool kobj vs DEBUG_KOBJECT_RELEASE stays cover leftovers

Changes in v5:
- RTNL/serialized readers use get_num_rx_queues() once the helper exists
  (open/close/register/apply_mq_fallback/alloc/cleanup/IRQ setup)
- Interrupt: quiet IRQ_NONE on out-of-range qindex vs published live
  count (scale-down residual IRQ; no WARN storm)
- Series renumber: mailed v4 09/14 MQ enable -> tip P10 (P09 peel; 14->15)
- Open: replenish all queues before setup; restart_rx_queue after setup
  for SQ and MQ - replaces mailed MQ-only replenish + kick_if_pending vs
  SQ schedule_rx_queue(0)
- update_rx_no_buffer(queue_index): NULL-safe, no all-queue walk under one
  lock (fixes the resize/race class). Still stores adapter->rx_no_buffer
  for now; per-queue slot + monotonic sum lands with qstats next
- H_FUNCTION: subordinate register fails open + stash mq_fallback;
  buffer-add schedules reset + mq_fallback so next open drops to SQ
- Introduce get_num_rx_queues / publish_num_rx_queues (READ/WRITE_ONCE)
  at first use; lockless IRQ/poll/replenish/interrupt bounds use the getter
- Introduce kick_rx_queue_if_pending() for pending-after-unmask; open uses
  restart_rx_queue, resize calls the helper later
- resume() schedules every live RX queue (not only queue 0)
- Call out enable_irq-fail synchronize_irq and unused mac register-arg
  cleanup (mailed enable-path review; code already earlier in tip)

Changes in v4:
- Fold subordinate register helpers and their review fixes into the MQ
  enablement patch that first uses them.
- Prefer request_irq -> napi_enable -> PHYP enable on MQ open.
- Preserve open unwind so set_real_num_rx / IRQ failures free LAN
  before buffer pools.
- MQ open replenishes every queue before setup_rx_interrupts() unmasks
  PHYP (drop avoidance during open; PHYP only interrupts after a
  successful enqueue). SQ keeps classic setup-then-schedule kick.
- Dispose subordinate virq mappings on setup_rx_interrupts()
  request_irq failure (err_free_irqs), matching err_disable_napi.
- Open unwind: setup/cleanup own subordinate dispose; skip duplicate
  dispose on those paths.
- H_FUNCTION on subordinate register is a hard open failure (no blind
  retry / no fake single-queue fallback).
- Note: hot-path netdev->stats accounting moves to the next patch (qstats).
- Put already-created pool kobjects on probe kobject_init_and_add /
  set_real_num_tx_queues / register_netdev failure (bisect-safe).

 drivers/net/ethernet/ibm/ibmveth.c | 549 ++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |   8 +-
 2 files changed, 473 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 7b6c0283e5c3..3f31793645a3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -156,6 +156,28 @@ static int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
 	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_CSUM_GOOD;
 }
 
+/* Lockless IRQ/poll readers vs resize publishers. */
+static unsigned int
+ibmveth_get_num_rx_queues(const struct ibmveth_adapter *adapter)
+{
+	/*
+	 * Pairs with the release in ibmveth_publish_num_rx_queues(): a reader
+	 * that sees the new count also sees the per-queue state behind it.
+	 */
+	return smp_load_acquire(&adapter->num_rx_queues);
+}
+
+static void
+ibmveth_publish_num_rx_queues(struct ibmveth_adapter *adapter,
+			      unsigned int num)
+{
+	/*
+	 * Pairs with the acquire in ibmveth_get_num_rx_queues(): per-queue
+	 * state must be visible to a reader before it observes the new count.
+	 */
+	smp_store_release(&adapter->num_rx_queues, num);
+}
+
 static unsigned int ibmveth_real_max_tx_queues(void)
 {
 	unsigned int n_cpu = num_online_cpus();
@@ -233,7 +255,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
 		adapter->buffer_list_addr[i] =
 			(void *)get_zeroed_page(GFP_KERNEL);
 		if (!adapter->buffer_list_addr[i]) {
@@ -284,7 +306,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
 	}
 
 	netdev_dbg(netdev, "allocated %u RX queue(s) with %d entries each\n",
-		   adapter->num_rx_queues, rxq_entries);
+		   ibmveth_get_num_rx_queues(adapter), rxq_entries);
 
 	return 0;
 
@@ -328,9 +350,9 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
 	int i;
 
 	netdev_dbg(adapter->netdev, "cleaning up %u RX queue(s)\n",
-		   adapter->num_rx_queues);
+		   ibmveth_get_num_rx_queues(adapter));
 
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
 		if (adapter->buffer_list_addr[i]) {
 			dma_unmap_single(dev, adapter->buffer_list_dma[i],
 					 4096, DMA_BIDIRECTIONAL);
@@ -487,7 +509,7 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
 {
 	int i;
 
-	for (i = 1; i < adapter->num_rx_queues; i++)
+	for (i = 1; i < ibmveth_get_num_rx_queues(adapter); i++)
 		ibmveth_dispose_subordinate_irq_mapping(adapter, i);
 }
 
@@ -497,12 +519,11 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
  *
  * Registers interrupt handlers for all RX queues, enables NAPI, then
  * enables hypervisor interrupt delivery for multi-queue mode after
- * every queue has a Linux handler installed. For multi-queue open the
- * caller should replenish RX buffers before this helper so traffic
- * during open is not dropped (PHYP only interrupts after a successful
- * enqueue, which needs buffers). Single-queue open leaves PHYP masked
- * here and kicks NAPI afterward (classic path: first poll posts then
- * enables).
+ * every queue has a Linux handler installed. The caller replenishes
+ * every live queue before this helper so traffic during open is not
+ * dropped (PHYP only interrupts after a successful enqueue, which
+ * needs buffers). Single-queue open still leaves PHYP masked here;
+ * restart_rx_queue then kicks NAPI.
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -510,7 +531,7 @@ static int
 ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int i, rc, num = adapter->num_rx_queues;
+	int i, rc, num = ibmveth_get_num_rx_queues(adapter);
 
 	for (i = 0; i < num; i++) {
 		if (!adapter->queue_irq[i]) {
@@ -600,24 +621,24 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 	if (!adapter->rx_irq_setup)
 		return;
 
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
 		if (!adapter->queue_irq[i])
 			continue;
 		ibmveth_disable_irq(adapter, i);
 		synchronize_irq(adapter->queue_irq[i]);
 	}
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
 		napi_disable(&adapter->napi[i]);
 
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
 		if (!adapter->queue_irq[i])
 			continue;
 		ibmveth_disable_irq(adapter, i);
 		synchronize_irq(adapter->queue_irq[i]);
 	}
 
-	for (i = 0; i < adapter->num_rx_queues; i++) {
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
 		if (adapter->queue_irq[i])
 			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
 	}
@@ -647,7 +668,7 @@ static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
 {
 	struct napi_struct *napi = &adapter->napi[qindex];
 
-	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+	if (WARN_ON(qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter)))
 		return false;
 
 	/*
@@ -993,15 +1014,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  * because there was not a buffer in the buffer list capable of holding
  * the frame.
  */
-static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
+static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
+					int queue_index)
 {
 	__be64 *p;
+	u64 drops;
 
-	if (!adapter->buffer_list_addr[0])
+	if (queue_index < 0 ||
+	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
+	    !adapter->buffer_list_addr[queue_index])
 		return;
 
-	p = adapter->buffer_list_addr[0] + 4096 - 8;
-	adapter->rx_no_buffer = be64_to_cpup(p);
+	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
+	drops = be64_to_cpup(p);
+
+	adapter->rx_no_buffer = drops;
 }
 
 /* replenish routine */
@@ -1016,10 +1043,10 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	int batch_fallback = 0;
 	int hcall_fail = 0;
 
-	if (queue_index >= adapter->num_rx_queues) {
+	if (queue_index >= ibmveth_get_num_rx_queues(adapter)) {
 		netdev_dbg(adapter->netdev,
 			   "Skipping replenish for freed queue %d (num_queues=%u)\n",
-			   queue_index, adapter->num_rx_queues);
+			   queue_index, ibmveth_get_num_rx_queues(adapter));
 		return;
 	}
 
@@ -1053,7 +1080,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	}
 
 out_unlock:
-	ibmveth_update_rx_no_buffer(adapter);
+	ibmveth_update_rx_no_buffer(adapter, queue_index);
 
 	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
 
@@ -1067,6 +1094,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 		dev_err_ratelimited(&adapter->netdev->dev,
 				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
 				    queue_index, fail.batch);
+		adapter->mq_fallback = true;
 		schedule_work(&adapter->work);
 	}
 
@@ -1086,6 +1114,27 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 				     fail.filled, fail.lpar_rc, fail.batch);
 }
 
+/**
+ * ibmveth_restart_rx_queue - Post buffers and ensure Q can take RX
+ * @adapter: ibmveth adapter
+ * @qindex: RX queue index
+ *
+ * SQ open leaves PHYP masked until the first poll. If schedule_prep fails,
+ * NAPI never runs and the queue stays masked (TX OK, RX/ARP dead) until
+ * reload. Replenish first so an enable_irq fallback can actually deliver.
+ * Also used after every open (SQ and MQ) and after scale-down so a
+ * queue is not left idle+masked.
+ */
+static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
+				     int qindex)
+{
+	ibmveth_replenish_task(adapter, qindex);
+	if (ibmveth_schedule_rx_queue(adapter, qindex))
+		return;
+
+	ibmveth_enable_irq(adapter, qindex);
+}
+
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
 static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 				     struct ibmveth_buff_pool *pool)
@@ -1214,7 +1263,7 @@ ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 	int i, q, rc;
 
 	/* Initialize pool metadata for queues 1..N from queue 0 settings */
-	for (q = 1; q < adapter->num_rx_queues; q++) {
+	for (q = 1; q < ibmveth_get_num_rx_queues(adapter); q++) {
 		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 			struct ibmveth_buff_pool *src =
 				&adapter->rx_buff_pool[0][i];
@@ -1230,7 +1279,7 @@ ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 	}
 
 	/* Allocate actual buffers for all queues */
-	for (q = 0; q < adapter->num_rx_queues; q++) {
+	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
 		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
 		if (rc) {
 			/* Free pools for all previous queues */
@@ -1241,7 +1290,7 @@ ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 	}
 
 	netdev_dbg(netdev, "allocated buffer pools for %u queue(s)\n",
-		   adapter->num_rx_queues);
+		   ibmveth_get_num_rx_queues(adapter));
 	return 0;
 }
 
@@ -1257,11 +1306,11 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 	int q;
 
 	/* Free buffer pools for all queues */
-	for (q = 0; q < adapter->num_rx_queues; q++)
+	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++)
 		ibmveth_free_queue_buffer_pools(adapter, q);
 
 	netdev_dbg(adapter->netdev, "freed buffer pools for %u queue(s)\n",
-		   adapter->num_rx_queues);
+		   ibmveth_get_num_rx_queues(adapter));
 }
 
 static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
@@ -1562,6 +1611,138 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+/**
+ * ibmveth_register_logical_lan_queue - Register subordinate queue with
+ * hypervisor
+ * @adapter: ibmveth adapter structure
+ * @rxq_desc: Receive queue descriptor
+ * @queue_index: RX queue index (1..N for subordinate queues)
+ *
+ * Registers a subordinate receive queue using H_REG_LOGICAL_LAN_QUEUE.
+ * On success, stores the queue handle and virtual IRQ in the adapter.
+ * If IRQ mapping fails after a successful hypervisor registration, the
+ * queue is freed before returning.
+ *
+ * Return: H_SUCCESS on success, negative errno on IRQ mapping failure,
+ *         hypervisor error code otherwise
+ */
+static int
+ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
+				   union ibmveth_buf_desc rxq_desc,
+				   int queue_index)
+{
+	unsigned long handle, hwirq;
+	unsigned int virq;
+	long lpar_rc;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long bl = adapter->buffer_list_dma[queue_index];
+
+	netdev_dbg(adapter->netdev,
+		   "register queue %d: ua=0x%lx bl=0x%lx rxq=0x%llx\n",
+		   queue_index, ua, bl, rxq_desc.desc);
+	do {
+		lpar_rc = h_register_logical_lan_queue(ua, bl,
+						       rxq_desc.desc, &handle,
+						       &hwirq);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+	netdev_dbg(adapter->netdev,
+		   "h_register_logical_lan_queue queue %d rc=%ld\n",
+		   queue_index, lpar_rc);
+
+	if (lpar_rc == H_SUCCESS) {
+		virq = irq_create_mapping(NULL, hwirq);
+		if (!virq) {
+			unsigned long free_rc;
+
+			netdev_err(adapter->netdev,
+				   "Failed to map IRQ for queue %d (hwirq=%lu)\n",
+				   queue_index, hwirq);
+			do {
+				free_rc = h_free_logical_lan_queue(ua, handle);
+			} while (H_IS_LONG_BUSY(free_rc) ||
+				  (free_rc == H_BUSY));
+			if (free_rc != H_SUCCESS)
+				netdev_err(adapter->netdev,
+					   "h_free_logical_lan_queue failed for queue %d after IRQ map failure: rc=0x%lx\n",
+					   queue_index, free_rc);
+			return -EINVAL;
+		}
+
+		adapter->queue_handle[queue_index] = handle;
+		adapter->queue_irq[queue_index] = virq;
+
+		netdev_dbg(adapter->netdev,
+			   "queue %d registered: handle=0x%llx irq=%u\n",
+			   queue_index, adapter->queue_handle[queue_index],
+			   adapter->queue_irq[queue_index]);
+		return H_SUCCESS;
+	}
+
+	/*
+	 * H_FUNCTION means firmware rejected this subordinate register
+	 * (MQ unsupported / dropped after LPM). Caller fails this open and
+	 * latches mq_fallback so the next open applies SQ; keep a specific
+	 * log then the generic failure lines below.
+	 */
+	if (lpar_rc == H_FUNCTION)
+		netdev_err(adapter->netdev,
+			   "h_register_logical_lan_queue H_FUNCTION for queue %d (firmware MQ unsupported)\n",
+			   queue_index);
+
+	netdev_err(adapter->netdev,
+		   "h_register_logical_lan_queue failed for queue %d with %ld\n",
+		   queue_index, lpar_rc);
+	netdev_err(adapter->netdev,
+		   "queue %d params: unit_addr=0x%x buffer_list_dma=0x%llx rxq_desc=0x%llx\n",
+		   queue_index, adapter->vdev->unit_address,
+		   adapter->buffer_list_dma[queue_index],
+		   rxq_desc.desc);
+
+	return lpar_rc;
+}
+
+/**
+ * ibmveth_register_single_rx_queue - Register one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to register (1..N)
+ *
+ * Builds the queue descriptor and registers with the hypervisor via
+ * ibmveth_register_logical_lan_queue().
+ *
+ * Return: 0 on success, -EINVAL if @queue_idx is invalid, -EOPNOTSUPP if
+ *         firmware rejects MQ (H_FUNCTION), -EIO on other failures
+ */
+static int
+ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
+				 int queue_idx)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	long lpar_rc;
+
+	if (WARN_ON(queue_idx < 1 || queue_idx >= IBMVETH_MAX_RX_QUEUES))
+		return -EINVAL;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[queue_idx].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[queue_idx].queue_dma;
+
+	lpar_rc = ibmveth_register_logical_lan_queue(adapter, rxq_desc,
+						     queue_idx);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev, "Failed to register queue %d: rc=%ld\n",
+			   queue_idx, lpar_rc);
+		if (lpar_rc == H_FUNCTION)
+			return -EOPNOTSUPP;
+		return -EIO;
+	}
+
+	netdev_dbg(netdev, "Registered queue %d with handle 0x%llx\n",
+		   queue_idx, adapter->queue_handle[queue_idx]);
+
+	return 0;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -1579,7 +1760,8 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
  * afterward (same as pre-helper close()).
  *
  * Clears queue handles only; queue_irq[] is released by
- * ibmveth_cleanup_rx_interrupts().
+ * ibmveth_cleanup_rx_interrupts() on close, or by
+ * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
  */
 static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 {
@@ -1597,7 +1779,7 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 			   "h_free_logical_lan failed: %ld\n", lpar_rc);
 	}
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
 		adapter->queue_handle[i] = 0;
 }
 
@@ -1606,10 +1788,13 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
  * @adapter: ibmveth adapter structure
  * @mac_address: MAC address for device registration
  *
- * Registers queue 0 via ibmveth_register_logical_lan(). Subordinate queue
- * registration is added when multi-queue RX is enabled.
+ * Registers queue 0 via ibmveth_register_logical_lan(), then subordinate
+ * queues 1..N when multi-queue mode is enabled.
  *
- * Return: 0 on success, -ENONET if queue 0 registration fails
+ * Return: 0 on success, -ENONET if queue 0 registration fails,
+ *         -EOPNOTSUPP if firmware rejects a subordinate queue (H_FUNCTION;
+ *         this function latches mq_fallback), -EIO on other subordinate
+ *         failures
  */
 static int
 ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
@@ -1617,7 +1802,8 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
 	struct net_device *netdev = adapter->netdev;
 	union ibmveth_buf_desc rxq_desc;
 	unsigned long lpar_rc;
-	int rc;
+	unsigned int num;
+	int i, rc;
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 				    adapter->rx_queue[0].queue_len;
@@ -1642,9 +1828,67 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
 		return -ENONET;
 	}
 
+	num = ibmveth_get_num_rx_queues(adapter);
+	if (num == 1 || !adapter->multi_queue) {
+		netdev_dbg(netdev,
+			   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+		return 0;
+	}
+
+	netdev_dbg(netdev, "Registering %u subordinate queues (1-%u)\n",
+		   num - 1, num - 1);
+
+	for (i = 1; i < num; i++) {
+		rc = ibmveth_register_single_rx_queue(adapter, i);
+		if (rc) {
+			/* Firmware MQ gone: fall back to SQ on next open. */
+			if (rc == -EOPNOTSUPP)
+				adapter->mq_fallback = true;
+			goto err_unregister;
+		}
+	}
+
 	netdev_dbg(netdev,
-		   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+		   "registered %u RX queues with hypervisor (multi-queue mode)\n",
+		   num);
+
 	return 0;
+
+err_unregister:
+	ibmveth_dispose_subordinate_irq_mappings(adapter);
+	ibmveth_free_all_queues(adapter);
+	return rc;
+}
+
+/**
+ * ibmveth_apply_mq_fallback - Drop multi-queue mode after firmware rejection
+ * @adapter: ibmveth adapter
+ *
+ * mq_fallback is set when firmware rejects MQ (subordinate register or
+ * buffer-add H_FUNCTION). Apply only at the start of open after teardown so
+ * num_rx_queues is not shrunk while IRQ/NAPI still reference higher queues.
+ * Consumes the flag and clears multi_queue, which is what makes the
+ * single-queue decision permanent for this device.
+ */
+static void ibmveth_apply_mq_fallback(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	if (!adapter->mq_fallback)
+		return;
+
+	adapter->mq_fallback = false;
+
+	if (!adapter->multi_queue && ibmveth_get_num_rx_queues(adapter) == 1)
+		return;
+
+	netdev_warn(netdev,
+		    "Falling back to single RX queue (firmware MQ unavailable)\n");
+	adapter->multi_queue = false;
+	ibmveth_publish_num_rx_queues(adapter, 1);
+	/* real_num_rx_queues is set later in open after resources exist. */
+	if (adapter->rx_buffers_per_hcall > IBMVETH_MAX_RX_REGULAR)
+		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 }
 
 static int ibmveth_open(struct net_device *netdev)
@@ -1657,6 +1901,8 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
+	ibmveth_apply_mq_fallback(adapter);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
@@ -1676,18 +1922,34 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_buffer_pools;
 
-	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
+	rc = netif_set_real_num_rx_queues(netdev,
+					  ibmveth_get_num_rx_queues(adapter));
+
 	if (rc) {
 		netdev_err(netdev, "failed to set number of rx queues\n");
 		goto out_unregister_queues;
 	}
 
+	/*
+	 * Post buffers before setup_rx_interrupts(). MQ setup then unmasks
+	 * PHYP; SQ setup leaves PHYP masked. Scheduling NAPI only when a
+	 * descriptor is already pending is not enough: after ifdown/up
+	 * (RX=8, no -L) NAPI can be idle with nothing pending and the
+	 * queue stays dead (TX OK, ARP/RX fail).
+	 * restart_rx_queue() replenishes, schedules NAPI, and unmasks if
+	 * prep fails.
+	 */
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
+		netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
+		ibmveth_replenish_task(adapter, i);
+	}
+
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
 		goto out_free_all_queues; /* setup already disposed IRQs */
 
-	netdev_dbg(netdev, "initial replenish cycle\n");
-	ibmveth_schedule_rx_queue(adapter, 0);
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+		ibmveth_restart_rx_queue(adapter, i);
 
 	rc = ibmveth_alloc_tx_resources(adapter);
 	if (rc)
@@ -1722,6 +1984,7 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	int i;
 
 	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
 	 * leave IFF_UP set after a failed reopen.
@@ -1742,7 +2005,8 @@ static int ibmveth_close(struct net_device *netdev)
 	/* Wait for softirq/poll that already passed shutdown checks. */
 	synchronize_net();
 
-	ibmveth_update_rx_no_buffer(adapter);
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+		ibmveth_update_rx_no_buffer(adapter, i);
 	ibmveth_free_all_queues(adapter);
 	/* Free TX LTBs after quiesce and after H_FREE_LOGICAL_LAN so xmit
 	 * cannot touch unmapped bounce buffers while the LAN is live.
@@ -1777,6 +2041,10 @@ static void ibmveth_reset(struct work_struct *w)
 	netdev_dbg(netdev, "reset starting\n");
 
 	rtnl_lock();
+	if (netdev->reg_state != NETREG_REGISTERED) {
+		rtnl_unlock();
+		return;
+	}
 
 	dev_close(adapter->netdev);
 	dev_open(adapter->netdev, NULL);
@@ -2538,6 +2806,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 		ibmveth_rx_csum_helper(skb, adapter);
 	}
 
+	skb_record_rx_queue(skb, queue_index);
 	napi_gro_receive(napi, skb);
 
 	netdev->stats.rx_packets++;
@@ -2556,7 +2825,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	queue_index = napi - adapter->napi;
 
 	if (WARN_ON(queue_index < 0 ||
-		    queue_index >= adapter->num_rx_queues)) {
+		    queue_index >= ibmveth_get_num_rx_queues(adapter))) {
 		if (budget)
 			napi_complete_done(napi, 0);
 		return 0;
@@ -2649,10 +2918,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 
 	qindex = napi - adapter->napi;
 	/*
-	 * Quiet on out-of-range: teardown can leave a residual IRQ after the
-	 * live count drops. Do not WARN-storm; return IRQ_NONE until free_irq.
+	 * Quiet on out-of-range: scale-down publishes a lower live count
+	 * before free_irq(). A residual IRQ must not WARN-storm; return
+	 * IRQ_NONE until the handler is removed.
 	 */
-	if (qindex < 0 || qindex >= adapter->num_rx_queues)
+	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
 		return IRQ_NONE;
 
 	ibmveth_schedule_rx_queue(adapter, qindex);
@@ -2761,9 +3031,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	unsigned int num = ibmveth_get_num_rx_queues(adapter);
+	int i;
 
-	ibmveth_replenish_task(adapter, 0);
-	ibmveth_schedule_rx_queue(adapter, 0);
+	for (i = 0; i < num; i++)
+		ibmveth_replenish_task(adapter, i);
+
+	for (i = 0; i < num; i++)
+		ibmveth_schedule_rx_queue(adapter, i);
 }
 #endif
 
@@ -2781,8 +3056,7 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
 	unsigned long ret;
-	int i;
-	int rxqentries = 1;
+	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -2792,23 +3066,38 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
 	adapter = netdev_priv(netdev);
 
-	ret = IBMVETH_BUFF_LIST_SIZE + IBMVETH_FILT_LIST_SIZE;
+	/* One buffer list page per RX queue; filter list is shared. */
+	ret = IBMVETH_BUFF_LIST_SIZE * ibmveth_get_num_rx_queues(adapter) +
+	      IBMVETH_FILT_LIST_SIZE;
 	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
 	/* add size of mapped tx buffers */
 	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		/* add the size of the active receive buffers */
-		if (adapter->rx_buff_pool[0][i].active)
-			ret +=
-			    adapter->rx_buff_pool[0][i].size *
-			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
-					     buff_size, tbl);
-		rxqentries += adapter->rx_buff_pool[0][i].size;
-	}
-	/* add the size of the receive queue entries */
-	ret += IOMMU_PAGE_ALIGN(
-		rxqentries * sizeof(struct ibmveth_rx_q_entry), tbl);
+	/*
+	 * Pool metadata for queues 1+ is copied from queue 0 at open.
+	 * Always size from pool 0 x num_rx_queues.
+	 *
+	 * CMO (Power9 and earlier) and MQ firmware (Power11+) do not
+	 * coexist, so a CMO partition always sizes one queue here. The
+	 * MQ terms are defensive only.
+	 */
+	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
+		int rxqentries = 1;
+
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *bpool =
+				&adapter->rx_buff_pool[0][i];
+
+			if (bpool->active)
+				ret += bpool->size *
+					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
+			rxqentries += bpool->size;
+		}
+
+		/* add the size of the receive queue entries */
+		ret += IOMMU_PAGE_ALIGN(rxqentries *
+					sizeof(struct ibmveth_rx_q_entry), tbl);
+	}
 
 	return ret;
 }
@@ -2873,9 +3162,45 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 #endif
 };
 
+/**
+ * ibmveth_pool_kobj_release - Mark a pool kobject finished
+ * @kobj: kobject embedded in the pool
+ *
+ * Pool kobjects live in netdev_priv(). Last put waits for this
+ * before free_netdev() so DEBUG_KOBJECT_RELEASE delayed cleanup
+ * does not run on freed memory.
+ */
+static void ibmveth_pool_kobj_release(struct kobject *kobj)
+{
+	struct ibmveth_buff_pool *pool = container_of(kobj,
+						      struct ibmveth_buff_pool,
+						      kobj);
+
+	complete(&pool->released);
+}
+
+/**
+ * ibmveth_put_pool_kobjs - Drop pool kobjects and wait for release
+ * @adapter: ibmveth adapter
+ * @pools_ready: number of queue-0 pools that were initialized
+ *
+ * Put every initialized pool kobject, then wait so free_netdev()
+ * cannot race DEBUG_KOBJECT_RELEASE delayed cleanup.
+ */
+static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
+				   int pools_ready)
+{
+	int i;
+
+	for (i = 0; i < pools_ready; i++)
+		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
+	for (i = 0; i < pools_ready; i++)
+		wait_for_completion(&adapter->rx_buff_pool[0][i].released);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
-	int rc, i, mac_len;
+	int rc, i, mac_len, pools_ready = 0;
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter;
 	unsigned char *mac_addr_p;
@@ -2910,7 +3235,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		return -EINVAL;
 	}
 
-	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter), IBMVETH_MAX_QUEUES, 1);
+	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter),
+				    IBMVETH_MAX_QUEUES, IBMVETH_MAX_RX_QUEUES);
 	if (!netdev)
 		return -ENOMEM;
 
@@ -2933,7 +3259,9 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		netif_napi_add_weight(netdev, &adapter->napi[i],
+				      ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -2965,16 +3293,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
-	/* Initialize queue count - always 1 for now */
-	adapter->multi_queue = 0;
-	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
+	if (ret == H_SUCCESS &&
+	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
+		adapter->multi_queue = true;
+		ibmveth_publish_num_rx_queues(adapter,
+					      min(num_online_cpus(),
+						  IBMVETH_DEFAULT_QUEUES));
+		netdev_dbg(netdev, "RX multi queue mode enabled: %u queues\n",
+			   ibmveth_get_num_rx_queues(adapter));
+	} else {
+		adapter->multi_queue = false;
+		ibmveth_publish_num_rx_queues(adapter,
+					      IBMVETH_DEFAULT_RX_QUEUES);
+	}
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
+		if (adapter->multi_queue)
+			adapter->rx_buffers_per_hcall =
+				IBMVETH_MAX_RX_PER_HCALL;
+		else
+			adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
-			    adapter->rx_buffers_per_hcall);
+			   adapter->rx_buffers_per_hcall);
 	} else {
 		adapter->rx_buffers_per_hcall = 1;
 		netdev_dbg(netdev,
@@ -2992,15 +3334,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
-		int error;
 
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
-		error = kobject_init_and_add(kobj, &ktype_veth_pool,
-					     &dev->dev.kobj, "pool%d", i);
-		if (!error)
-			kobject_uevent(kobj, KOBJ_ADD);
+		init_completion(&adapter->rx_buff_pool[0][i].released);
+		rc = kobject_init_and_add(kobj, &ktype_veth_pool,
+					  &dev->dev.kobj, "pool%d", i);
+		if (rc) {
+			struct ibmveth_buff_pool *pool =
+				&adapter->rx_buff_pool[0][i];
+
+			dev_err(&dev->dev,
+				"failed to create pool%d kobject: %d\n", i, rc);
+			/* init_and_add takes a ref even on failure */
+			kobject_put(kobj);
+			wait_for_completion(&pool->released);
+			ibmveth_put_pool_kobjs(adapter, pools_ready);
+			dev_set_drvdata(&dev->dev, NULL);
+			free_netdev(netdev);
+			return rc;
+		}
+
+		pools_ready++;
+		kobject_uevent(kobj, KOBJ_ADD);
 	}
 
 	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
@@ -3008,9 +3365,29 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
+		ibmveth_put_pool_kobjs(adapter, pools_ready);
+		dev_set_drvdata(&dev->dev, NULL);
 		free_netdev(netdev);
 		return rc;
 	}
+
+	/*
+	 * alloc_etherdev_mqs() sized real_num_rx_queues to MAX. Match the
+	 * advertised default (or SQ 1) before register_netdev so down-state
+	 * readers agree with adapter->num_rx_queues / ethtool -l.
+	 */
+	rc = netif_set_real_num_rx_queues(netdev,
+					  ibmveth_get_num_rx_queues(adapter));
+
+	if (rc) {
+		netdev_dbg(netdev, "failed to set number of rx queues rc=%d\n",
+			   rc);
+		ibmveth_put_pool_kobjs(adapter, pools_ready);
+		dev_set_drvdata(&dev->dev, NULL);
+		free_netdev(netdev);
+		return rc;
+	}
+
 	adapter->tx_ltb_size = PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE);
 	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
 		adapter->tx_ltb_ptr[i] = NULL;
@@ -3024,6 +3401,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
+		ibmveth_put_pool_kobjs(adapter, pools_ready);
+		dev_set_drvdata(&dev->dev, NULL);
 		free_netdev(netdev);
 		return rc;
 	}
@@ -3037,14 +3416,17 @@ static void ibmveth_remove(struct vio_dev *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(&dev->dev);
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	int i;
 
-	cancel_work_sync(&adapter->work);
-
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
+	ibmveth_put_pool_kobjs(adapter, IBMVETH_NUM_BUFF_POOLS);
 
+	/*
+	 * Unregister first so NAPI/xmit cannot re-arm reset work after we
+	 * cancel it. cancel_work_sync() before unregister left a window
+	 * where poll could schedule_work() and the worker ran after
+	 * free_netdev().
+	 */
 	unregister_netdev(netdev);
+	cancel_work_sync(&adapter->work);
 
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
@@ -3195,7 +3577,6 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	return rc;
 }
 
-
 #define ATTR(_name, _mode)				\
 	struct attribute veth_##_name##_attr = {	\
 	.name = __stringify(_name), .mode = _mode,	\
@@ -3219,7 +3600,7 @@ static const struct sysfs_ops veth_pool_ops = {
 };
 
 static struct kobj_type ktype_veth_pool = {
-	.release        = NULL,
+	.release        = ibmveth_pool_kobj_release,
 	.sysfs_ops      = &veth_pool_ops,
 	.default_groups = veth_pool_groups,
 };
@@ -3228,8 +3609,12 @@ static int ibmveth_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	unsigned int num = ibmveth_get_num_rx_queues(adapter);
+	int i;
+
+	for (i = 0; i < num; i++)
+		ibmveth_schedule_rx_queue(adapter, i);
 
-	ibmveth_schedule_rx_queue(adapter, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index dc0e5c25209a..84e703692aae 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -15,6 +15,7 @@
 #define _IBMVETH_H
 
 #include <linux/spinlock_types.h>
+#include <linux/completion.h>
 
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
@@ -30,6 +31,7 @@
 #define IbmVethMcastRemoveFilter     0x2UL
 #define IbmVethMcastClearFilterTable 0x3UL
 
+#define IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT	0x0000000000080000UL
 #define IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT	0x0000000000040000UL
 #define IBMVETH_ILLAN_LRG_SR_ENABLED	0x0000000000010000UL
 #define IBMVETH_ILLAN_LRG_SND_SUPPORT	0x0000000000008000UL
@@ -265,7 +267,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
-#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_MAX_RX_QUEUES 16U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_REGULAR 8U
 #define IBMVETH_MAX_RX_PER_HCALL 12U
@@ -290,6 +292,7 @@ struct ibmveth_buff_pool {
     struct sk_buff **skbuff;
     int active;
     struct kobject kobj;
+	struct completion released;
 };
 
 struct ibmveth_rx_q {
@@ -320,8 +323,9 @@ struct ibmveth_adapter {
 	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
 	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
 	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
-	int multi_queue;
+	bool multi_queue;
 	unsigned int num_rx_queues;
+	bool mq_fallback;
 	/* Lifetime: true after successful ndo_open until close clears it. */
 	bool opened;
 	/* Lifetime: true while RX IRQ handlers / NAPI are installed. */
-- 
2.50.1 (Apple Git-155)


