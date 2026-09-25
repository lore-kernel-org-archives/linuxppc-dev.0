Return-Path: <linuxppc-dev+bounces-28227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F21FC9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzz21Ygcz30hg;
	Sat, 26 Sep 2026 04:40:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361614;
	cv=none; b=J1oYcjoYGuYr3cpMbwXuBZWemDbjIhFQPI/0hpmr3SYImmon8GdwEIXzIZsDUxPc5o5oTIhqsPOJrJMM1YCU05icQCuhufUk5cWOEQhvAdy0jMA341GNrTtyJuQ1r+Hk8EDFCbhDrVDDFg2RFeUjtINGby/18dTE8xDfWrsTiJ8rc59FXhHY5FFfeLpBeNFUCB2aoSqUPl+LPpUPJNFlnO/llX8XDFDhg6o1y1Z0kwWQrOk5n6HobIrfAXBBFOJvbzwZB+OO28Y0RBtNeF7t+Emi/9MjdGOjhIZYmYm6K8+2FbmNTzRmdLgDbBzZZOOWDFBNTYkfvp3C+eBUyOkCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361614; c=relaxed/relaxed;
	bh=WscbyfysXXgNtUmTcVM0lbFfDrExEUtg6iJdf7sJv5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxlpIO1jnDQp0dFO/luhVoUrPBJyRqD8g+MJH/dPVOqaW9zp+81bnAn2fR8NdzQgMqRYzrlUYHx6qOMv1hQm7vvzIj1n64Npcqd4xyZ7PTKXP7Xe/xjs/RBjqCp/18CoSVkxhiZrGz0Km7A8x4UxIClVluLSScCM/uCQc6V+wmT7dKqP5ki9tUTcqXPv5H+wWz4SC29E2rimTUHEjt+hIzdEkJxYEyjmFptzFJ16tRjLQmyFUY4Z2gDLa7HU1ZmSom8qJjtXMmV/Jvdv++ndusuwcNC6C286Jc5LOYShjGBcTVo+bhbJTDuCBo7q66ac3OZlgOWp2Q6jAvmK+4btZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p7+U0eDh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p7+U0eDh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyy6PwKz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:40:10 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5whv1530375;
	Fri, 25 Sep 2026 18:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WscbyfysXXgNtUmTc
	VM0lbFfDrExEUtg6iJdf7sJv5s=; b=p7+U0eDhuZ+pOps7DqAXh3TBE9t50oLJO
	rF2S7WVnBJT405BsrwsRSPNDKd4UvfJyh/2y+n1pFQNQUyxEEgbwpHthupbdrQ9E
	ClGtF8lHOXRlR5Xh+uZ9rJZAmYMOicsAdwsAjynf4C+6wqfiBwv9x/qZzlt14KtW
	UbBsi+/NRky/u39G0mgCBuE5UKNqBb/8HAg4R7c7k8ldKZt/trUS70rBuljIjGnt
	YgCUm4ml4ihWofY+DYRXiMFqnpjXVWn0BTcQqktiHd7Eh87uP0UJXNTIdEam7e45
	zxN04ykEPl1QugF0hwzhCK3kF0j0/fMNpLk8A3roX+tEsg7gRfnow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg30rym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:40:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG34jg4191783;
	Fri, 25 Sep 2026 18:39:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k3kta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdtjV22938206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C5058055;
	Fri, 25 Sep 2026 18:39:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7874258063;
	Fri, 25 Sep 2026 18:39:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:52 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 14/15] ibmveth: Implement incremental MQ RX queue resize
Date: Fri, 25 Sep 2026 11:38:49 -0700
Message-Id: <cecd8fef057ec0d42eff6fc023c36c0702921b6b.1790319558.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Q7455z8b6X40Onp4zeWyP4SvabwDcAmV
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6c000 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0xawAVOsBbK9b1WSZ1EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX1HekWzA3ioYg
 FIceTiilzXASOyGS0CMzylIg0HgXRCzNDz4/xkT+SCKCzzUdo7GWEVmpFxBqd7xtvgb6/X79PSA
 PE/iO8XxfKVAF+OltOmW7VXVH+x3+qs+lRa84/3L+X9i6eb3galjtudYUcPiOlqaTOF4MMxML6K
 qqFRPcTlGUbzcQgnW4XbIkRUI75/8pJvyJWUNA+QPLrjrA7VPMOe6+19IAvL78O+j/4Xysv13jd
 mr41kUVIHoUOlmJCEnzVAYcfBwJhWDDAVMj7yPydSZlA5qpY17FLA9GE0P4QuFwvH/sWX5sbMgd
 d5iGfGo30ueTQiZcsRuvYfssgqtr8SkEgVjF84NrlpCwM9lNUo7BIy0O/Xmkg9EnZQ9w6Dt9Cqw
 oRR+3O6DsCYHR7R1vePAoTBifarmo99P/OhoDunLdoCTx9NvITv1ZxYQk3Yi+LSzZCabGGTPUTh
 b9VcytPbBrtE9YbWqfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX+VoJIoZWy18+
 GH5/kknsWS261lTwFlfJNJBi4NwQ55u5CowjKuVGv1F9KvIIh5Pby7OAhVEeLE2MJbFszGZhjoU
 KCL0Mgc6dPGH4z5qjOJtghGB9CMAsmk=
X-Proofpoint-GUID: 6La7dtU-Neea-BrJ8XO3HpXJb7AM1NBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Add ibmveth_resize_rx_queues_incremental() so the live RX channel
count can change without a full device tear-down, and
ibmveth_resize_rx_channels() as the entry point set_channels() calls.
The two directions live in ibmveth_scale_up_rx_queues() and
ibmveth_scale_down_rx_queues(); the incremental helper validates the
request, dispatches to one of them, and refreshes CMO on success.

Scale-up allocates DMA buffer lists and pool memory for the new
queues, registers them with PHYP via H_REG_LOGICAL_LAN_QUEUE and maps
subordinate IRQs, then brings each queue up: publish the count,
replenish, enable NAPI, and only then unmask PHYP, so the handler
cannot run on an unpublished, empty or NAPI-disabled queue. It
finishes with the same restart helper open() uses, so a total
replenish miss can still get a poll to retry.

Widen netif_set_real_num_rx_queues() to the target count before any
new queue is unmasked, so a frame on a new queue cannot carry an rx
queue index above real_num_rx_queues. Scale-up failure restores
real_num to the surviving count.

Scale-down masks PHYP on the retiring queues first, then disables NAPI,
then masks and synchronises again, because an in-flight poll can re-arm
PHYP while napi_disable() is waiting. It then drains the ring, harvests
the queue's final no_buffer count under that queue's replenish_lock,
since netpoll can still reach it until the count is lowered, publishes
the surviving count with smp_store_release() and calls
synchronize_net(), then netif_set_real_num_rx_queues(). On success
it then deregisters via H_FREE_LOGICAL_LAN_QUEUE, releases the IRQ
mapping and frees the DMA and pool memory. Deregistration has to
precede the unmap so PHYP releases ownership of the buffers while the
queue metadata its correlators index is still valid. If the free
hcall fails, leave the handle set and skip the unmap. Destroy walks
high-to-low so a failed free keeps 0..i live, publishes that count,
and restores NAPI/IRQ on the surviving new queues.

Scale-up register failure matches that skip-unmap rule: if IRQ
mapping fails after H_REG and the matching H_FREE fails, keep the
handle so the caller does not unmap. Scale-up enable_irq failure
that cannot destroy the new queue keeps that queue in the live set
with the queues this -L already added, instead of publishing below
it and orphaning the mapping.

A scale-up register or IRQ-setup failure whose H_FREE also fails
leaves that queue above the live count with its handle set. close()
frees it after successful H_FREE_LOGICAL_LAN, which drops every
subordinate queue; until then a scale-up that reaches that index
returns -EBUSY.

Both directions unwind. Scale-up failures jump to cleanup_new_queues:,
which restores real_num to the surviving count and destroys only the
queues this call created. Scale-down failures republish the remaining
count, then replenish, napi_enable and unmask each surviving new
queue (and restart if the IRQ comes back). If the IRQ cannot be
re-enabled they schedule a reset.

Use buffer-list allocation presence, not DMA-address truthiness, to
decide whether an incrementally removed queue needs
dma_unmap_single(): DMA address zero is valid.

Scale-up register failure returning -EOPNOTSUPP latches
mq_fallback so future scale-ups are blocked immediately. Reject
rx > 1 with -EOPNOTSUPP when firmware lacks MQ support or
mq_fallback is set. That rejection lives here rather than in
set_channels(), and it sits below the no-op check: ethtool -L is
read-modify-write, so a TX-only request arrives carrying the current
RX count and must not be rejected once mq_fallback is set. An rx_count
outside 1..IBMVETH_MAX_RX_QUEUES is rejected with -EINVAL ahead of both
checks; the ethtool core already range-checks against the max_rx that
get_channels() reports, and this is the driver's own guard.

Refresh CMO entitlement across the resize. ibmveth_desired_dma_for_rxqs()
is factored out of ibmveth_get_desired_dma() so the same math can be
applied to a prospective queue count before the driver commits to it.

Key the resize path's down check on adapter->opened rather than
IFF_UP: RX buffers, mappings and IRQs exist only after a successful
open, so IFF_UP alone does not mean there is anything to resize. An
RX count change while down is rejected with -EOPNOTSUPP here rather
than reported as success and discarded; patch 15 publishes the
down-path count and lifts the rejection.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v7:
- drain_rx_queue kdoc and debug log: slots
  processed, not buffers recycled
- skip unmap when H_FREE_LOGICAL_LAN_QUEUE fails;
  keep the handle and restore remaining queues
- widen set_real before scale-up unmask;
  restore real_num on scale-up failure
- scale-up register fail: keep handle and skip
  unmap if H_FREE after IRQ map fails
- scale-up enable_irq fail: if destroy fails,
  keep that queue in the live set
- scale-up register / IRQ-setup failure with a failed
  H_FREE: close() frees that queue after successful
  H_FREE_LOGICAL_LAN; a scale-up to it returns -EBUSY
- scale-up register site latches mq_fallback
  on -EOPNOTSUPP
- scale-up enable_irq failure: remask PHYP after
  napi_disable(), as scale-down does
- CMO desired sites share ibmveth_refresh_cmo_desired();
  desired_dma_for_rxqs comment notes CMO and MQ do not
  coexist
- free_single_rx_queue() keys buffer-list unmap on
  allocation presence because DMA address zero is valid
- reject an RX count change while down with -EOPNOTSUPP
  until patch 15 publishes the down-path count
- split resize_rx_queues_incremental() into
  scale_up_rx_queues() / scale_down_rx_queues() plus a
  dispatcher; code motion only
- schedule_rx_queue kdoc: past the live count is quiet
- noted: mask-then-napi_disable stays;
  no PHYP mask ack; no reset on failed
  H_FREE (skip unmap); shrinks to 2..live-1
  stay -EOPNOTSUPP once mq_fallback; P15
  owns TX-fail RX rollback

Changes in v6:
- harvest no_buffer on retiring queues under that queue's
  replenish_lock before publish: netpoll still reaches them until
  the surviving count is stored, and update_rx_no_buffer() ignores
  indexes at or above the live count
- publish num_rx_queues, then synchronize_net(), then destroy.
  Scale-down runs set_real_num_rx_queues() between sync and destroy
  (destroy only if that succeeds); cleanup_new_queues does not harvest
- napi_disable() before publishing the lowered count on scale-up
  enable_irq failure, matching scale-down
- restart_rx_queue() after the checked enable_irq() on scale-up and
  on scale-down rollback; kick_rx_queue_if_pending() cannot retry a
  queue whose replenish posted nothing
- drop the scale-down survivor restart_rx_queue() loop: those queues
  were never quiesced, and enable_irq() on prep-fail unmasks behind
  a live poll (subordinate H_PARAMETER on enable is -EIO and reset)
- schedule_rx_queue() returns quietly when only the upper bound
  trips: netpoll walks a snapshot of the old count, so an ethtool -L
  shrink raced it into a WARN userspace can trigger at will
- drop leftover spin_lock_init() from alloc_single_rx_queue(); scale-up
  runs on a live adapter and probe already inits the lock
- zero buffer_list_dma[] on the alloc_single_rx_queue() map-failure
  path; free_single_rx_queue() keys its unmap on that field
- skip PHYP mask and remask on scale-down when queue_irq[i] is 0
- put the rx > 1 / mq_fallback gate below the no-op check, and refuse
  any rx > 1 once mq_fallback is set, so a TX-only read-modify-write
  is not rejected
- noted: down-path stash/CMO and RX rollback on TX fail are patch 15
- noted: KUnit free_map fixtures are patch 8

Changes in v5:
- resize / get_desired_dma read live count via get_num_rx_queues()
- Scale-down / scale-up-fail: remask+sync after napi_disable (poll may
  re-arm while disable waits)
- Series renumber: mailed v4 12/14 resize -> tip P14 (14->15)
- Absorb kitchen-sink resize ownership: teardown-first scale-down
  (drain/deregister before unmap) + live-pool correlator_valid /
  schedule_work (cover has peel map)
- Ordered num_rx_queues publish + publish-before-destroy
- After unmask: kick if pending; enable_irq errno + rollback check;
  raise CMO before scale-up allocs
- Scale-up enable_irq-fail: publish-down / napi_disable / drain / destroy
- After scale-down destroy, restart remaining RX queues so Q0 cannot stay
  masked with NAPI idle
- resize_rx_channels: reject rx>1 without MQ / validate 1..MAX; call
  before !opened early return (stash still tip P15)

Changes in v4:
- Copy pool->index when cloning buffer pools for incrementally added
  queues.
- Scale-up order: publish -> replenish -> napi_enable -> enable_irq
  (vs older enable-before-publish drafts); mirror NAPI-before-unmask on
  set_real_num_rx rollback.
- Linux-owned subordinate virq disposal; deregister is PHYP-only;
  dispose bound to MAX_RX_QUEUES; dispose on request_irq failure.
- Drain-path smp_rmb() before harvest.
- Mask PHYP before napi_disable/drain on scale-down and scale-up fail
  cleanup.
- Replenish before re-enabling IRQ/NAPI on set_real_num_rx scale-down
  rollback.
- Keep set_channels wiring as the following patch (same split as v3)
  but call resize_rx_channels() here when IFF_UP so the helper is not
  an unused static.

 drivers/net/ethernet/ibm/ibmveth.c | 1003 ++++++++++++++++++++++++++--
 1 file changed, 942 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 0ac0359bb71e..1b1dd89dadf7 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -774,6 +774,58 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 	adapter->rx_irq_setup = false;
 }
 
+/**
+ * ibmveth_setup_single_rx_interrupt - Setup interrupt for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to setup
+ *
+ * Registers the IRQ handler for one queue. Used during incremental
+ * scale-up when adding new RX queues. The caller publishes the queue,
+ * replenishes buffers, enables NAPI, then unmasks PHYP delivery.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_setup_single_rx_interrupt(struct ibmveth_adapter *adapter,
+				  int queue_idx)
+{
+	struct net_device *netdev = adapter->netdev;
+	int rc;
+
+	rc = request_irq(adapter->queue_irq[queue_idx], ibmveth_interrupt,
+			 0, netdev->name, &adapter->napi[queue_idx]);
+	if (rc) {
+		netdev_err(netdev, "request_irq() failed for queue %d: %d\n",
+			   queue_idx, rc);
+		return rc;
+	}
+
+	netdev_dbg(netdev, "Setup IRQ %d for queue %d\n",
+		   adapter->queue_irq[queue_idx], queue_idx);
+	return 0;
+}
+
+/**
+ * ibmveth_cleanup_single_rx_interrupt - Cleanup interrupt for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to cleanup
+ *
+ * Frees the IRQ handler for one queue and releases the subordinate virq
+ * mapping. Used during incremental scale-down.
+ */
+static void
+ibmveth_cleanup_single_rx_interrupt(struct ibmveth_adapter *adapter,
+				    int queue_idx)
+{
+	if (adapter->queue_irq[queue_idx]) {
+		free_irq(adapter->queue_irq[queue_idx],
+			 &adapter->napi[queue_idx]);
+		ibmveth_dispose_subordinate_irq_mapping(adapter, queue_idx);
+		netdev_dbg(adapter->netdev,
+			   "Freed IRQ for queue %d\n", queue_idx);
+	}
+}
+
 /**
  * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
  * @adapter: ibmveth adapter structure
@@ -785,15 +837,25 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
  * Return: true if napi_schedule_prep() succeeded and NAPI was scheduled.
  * Mask is attempted in that case; a failed disable_irq() is logged by the
  * helper and does not change the return (queue may still be unmasked).
- * false if the index is out of range (WARN_ON, then return) or
- * prep failed (including NAPI already scheduled).
+ * false if the index is negative (WARN_ON), past the live count (quiet:
+ * a shrink can race netpoll), or prep failed (including NAPI already
+ * scheduled).
  */
 static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
 				      int qindex)
 {
 	struct napi_struct *napi = &adapter->napi[qindex];
 
-	if (WARN_ON(qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter)))
+	if (WARN_ON(qindex < 0))
+		return false;
+
+	/*
+	 * A live shrink can publish a lower count while netpoll walks a
+	 * snapshot of the old one, so an index past the end is expected
+	 * here and must not splat. ibmveth_replenish_task() skips the
+	 * same way; callers already treat false as "queue is gone".
+	 */
+	if (qindex >= ibmveth_get_num_rx_queues(adapter))
 		return false;
 
 	/*
@@ -1261,8 +1323,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
  * SQ open leaves PHYP masked until the first poll. If schedule_prep fails,
  * NAPI never runs and the queue stays masked (TX OK, RX/ARP dead) until
  * reload. Replenish first so an enable_irq fallback can actually deliver.
- * Also used after every open (SQ and MQ) and after scale-down so a
- * queue is not left idle+masked.
+ * Also used after every open (SQ and MQ) and after scale-down rollback.
  */
 static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
 				     int qindex)
@@ -1452,6 +1513,141 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   ibmveth_get_num_rx_queues(adapter));
 }
 
+/**
+ * ibmveth_alloc_single_rx_queue - Allocate resources for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to allocate
+ * @rxq_entries: Number of RX queue entries
+ *
+ * Allocates buffer list, RX queue, and per-queue buffer pools for one queue.
+ * Used during incremental scale-up without affecting existing queues.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx,
+			      int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i, rc = -ENOMEM;
+
+	adapter->buffer_list_addr[queue_idx] =
+		(void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->buffer_list_addr[queue_idx]) {
+		netdev_err(netdev, "unable to allocate buffer list for queue %d\n",
+			   queue_idx);
+		return -ENOMEM;
+	}
+
+	adapter->rx_queue[queue_idx].queue_len =
+		sizeof(struct ibmveth_rx_q_entry) * rxq_entries;
+	adapter->rx_queue[queue_idx].queue_addr =
+		dma_alloc_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+				   &adapter->rx_queue[queue_idx].queue_dma,
+				   GFP_KERNEL);
+	if (!adapter->rx_queue[queue_idx].queue_addr) {
+		netdev_err(netdev, "unable to allocate RX queue for queue %d\n",
+			   queue_idx);
+		goto out_free_buflist;
+	}
+
+	adapter->buffer_list_dma[queue_idx] =
+		dma_map_single(dev, adapter->buffer_list_addr[queue_idx],
+			       4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma[queue_idx])) {
+		netdev_err(netdev, "unable to map buffer list for queue %d\n",
+			   queue_idx);
+		adapter->buffer_list_dma[queue_idx] = 0;
+		goto out_free_rxq;
+	}
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *src =
+			&adapter->rx_buff_pool[0][i];
+		struct ibmveth_buff_pool *dst =
+			&adapter->rx_buff_pool[queue_idx][i];
+
+		dst->size = src->size;
+		dst->index = src->index;
+		dst->buff_size = src->buff_size;
+		dst->threshold = src->threshold;
+		dst->active = src->active;
+	}
+
+	rc = ibmveth_alloc_queue_buffer_pools(adapter, queue_idx);
+	if (rc) {
+		netdev_err(netdev,
+			   "Failed to allocate buffer pools for queue %d\n",
+			   queue_idx);
+		goto out_unmap_buflist;
+	}
+
+	adapter->rx_queue[queue_idx].index = 0;
+	adapter->rx_queue[queue_idx].num_slots = rxq_entries;
+	adapter->rx_queue[queue_idx].toggle = 1;
+
+	netdev_dbg(netdev,
+		   "Allocated queue %d: buffer_list @ %p (DMA: 0x%llx), rx_queue @ %p (DMA: 0x%llx), %d entries\n",
+		   queue_idx, adapter->buffer_list_addr[queue_idx],
+		   (unsigned long long)adapter->buffer_list_dma[queue_idx],
+		   adapter->rx_queue[queue_idx].queue_addr,
+		   (unsigned long long)adapter->rx_queue[queue_idx].queue_dma,
+		   rxq_entries);
+
+	return 0;
+
+out_unmap_buflist:
+	dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
+			 4096, DMA_BIDIRECTIONAL);
+	adapter->buffer_list_dma[queue_idx] = 0;
+out_free_rxq:
+	dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+			  adapter->rx_queue[queue_idx].queue_addr,
+			  adapter->rx_queue[queue_idx].queue_dma);
+	adapter->rx_queue[queue_idx].queue_addr = NULL;
+out_free_buflist:
+	free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
+	adapter->buffer_list_addr[queue_idx] = NULL;
+	return rc;
+}
+
+/**
+ * ibmveth_free_single_rx_queue - Free resources for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to free
+ *
+ * Frees buffer list, RX queue, and per-queue buffer pools for one queue.
+ * Used during incremental scale-down without affecting remaining queues.
+ */
+static void
+ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	ibmveth_free_queue_buffer_pools(adapter, queue_idx);
+
+	if (adapter->buffer_list_addr[queue_idx]) {
+		dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
+				 4096, DMA_BIDIRECTIONAL);
+		adapter->buffer_list_dma[queue_idx] = 0;
+	}
+
+	if (adapter->rx_queue[queue_idx].queue_addr) {
+		dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+				  adapter->rx_queue[queue_idx].queue_addr,
+				  adapter->rx_queue[queue_idx].queue_dma);
+		adapter->rx_queue[queue_idx].queue_addr = NULL;
+	}
+
+	if (adapter->buffer_list_addr[queue_idx]) {
+		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
+		adapter->buffer_list_addr[queue_idx] = NULL;
+	}
+
+	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
+}
+
 static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
 					 int queue_index, u64 correlator)
 {
@@ -1614,6 +1810,58 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ibmveth_drain_rx_queue - Drain pending buffers from an RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Queue index to drain
+ *
+ * Harvests pending completions back to the per-queue buffer pools.
+ * A corrupt slot still advances the ring, so the return is slots
+ * processed, not buffers recycled.
+ * Must be called with NAPI disabled for this queue.
+ *
+ * Return: number of slots processed
+ */
+static int
+ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
+{
+	struct net_device *netdev = adapter->netdev;
+	int drained = 0;
+	int limit = adapter->rx_queue[queue_index].num_slots;
+	int rc;
+
+	netdev_dbg(netdev, "Draining RX queue %d (limit: %d slots)\n",
+		   queue_index, limit);
+
+	while (drained < limit &&
+	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
+		/* Match poll-side order before harvesting completion state. */
+		smp_rmb();
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+		if (rc) {
+			/* -EINVAL/-EFAULT already advanced past the slot. */
+			if (rc == -EINVAL || rc == -EFAULT) {
+				drained++;
+				continue;
+			}
+			netdev_err(netdev,
+				   "Failed to harvest buffer from queue %d during drain: %d\n",
+				   queue_index, rc);
+			break;
+		}
+		drained++;
+	}
+
+	if (drained > 0)
+		netdev_dbg(netdev, "Drained %d slot(s) from RX queue %d\n",
+			   drained, queue_index);
+	else
+		netdev_dbg(netdev, "No slots to drain from RX queue %d\n",
+			   queue_index);
+
+	return drained;
+}
+
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
 	void *ltb = adapter->tx_ltb_ptr[idx];
@@ -1760,7 +2008,8 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
  * Registers a subordinate receive queue using H_REG_LOGICAL_LAN_QUEUE.
  * On success, stores the queue handle and virtual IRQ in the adapter.
  * If IRQ mapping fails after a successful hypervisor registration, the
- * queue is freed before returning.
+ * queue is freed before returning. If that free fails, the handle is
+ * kept so the caller can skip unmap.
  *
  * Return: H_SUCCESS on success, negative errno on IRQ mapping failure,
  *         hypervisor error code otherwise
@@ -1800,10 +2049,17 @@ ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
 				free_rc = h_free_logical_lan_queue(ua, handle);
 			} while (H_IS_LONG_BUSY(free_rc) ||
 				  (free_rc == H_BUSY));
-			if (free_rc != H_SUCCESS)
+			if (free_rc != H_SUCCESS) {
 				netdev_err(adapter->netdev,
 					   "h_free_logical_lan_queue failed for queue %d after IRQ map failure: rc=0x%lx\n",
 					   queue_index, free_rc);
+				/*
+				 * PHYP still owns this queue. Keep the
+				 * handle so the caller skips unmap.
+				 */
+				adapter->queue_handle[queue_index] = handle;
+				return -EIO;
+			}
 			return -EINVAL;
 		}
 
@@ -1882,6 +2138,596 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ibmveth_deregister_single_rx_queue - Deregister one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to deregister (1..N)
+ *
+ * Deregisters a single queue via H_FREE_LOGICAL_LAN_QUEUE. Linux IRQ handler
+ * teardown and subordinate virq mapping disposal are owned by interrupt
+ * cleanup helpers; queue 0 is freed only through ibmveth_free_all_queues()
+ * (H_FREE_LOGICAL_LAN).
+ *
+ * Return: 0 if the queue was freed or had no handle, -EIO if
+ *         H_FREE_LOGICAL_LAN_QUEUE failed. On -EIO the handle is
+ *         left set so the caller can skip unmap.
+ */
+static int
+ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
+				   int queue_idx)
+{
+	unsigned long lpar_rc;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long qh = adapter->queue_handle[queue_idx];
+
+	if (!qh)
+		return 0;
+
+	do {
+		lpar_rc = h_free_logical_lan_queue(ua, qh);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan_queue failed, queue %d rc=%ld\n",
+			   queue_idx, lpar_rc);
+		return -EIO;
+	}
+
+	adapter->queue_handle[queue_idx] = 0;
+
+	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
+	return 0;
+}
+
+/**
+ * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to destroy (1..N)
+ *
+ * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
+ * ownership is released while queue metadata is still valid. If the
+ * hcall fails, leave the queue mapped and keep the handle.
+ *
+ * Return: 0 on success, -EIO if deregister failed
+ */
+static int
+ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
+				     int queue_idx)
+{
+	int rc;
+
+	rc = ibmveth_deregister_single_rx_queue(adapter, queue_idx);
+	if (rc)
+		return rc;
+	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
+	ibmveth_free_single_rx_queue(adapter, queue_idx);
+	return 0;
+}
+
+/**
+ * ibmveth_desired_dma_for_rxqs - CMO entitlement for a given RX queue count
+ * @adapter: ibmveth adapter
+ * @rxqs: number of RX queues to size for
+ *
+ * Same math as ibmveth_get_desired_dma(), but uses @rxqs instead of the
+ * live adapter->num_rx_queues. Scale-up raises desired for the *target*
+ * count before allocating so vio_cmo_alloc cannot fail mid-resize.
+ *
+ * Return: bytes of IO memory desired for @rxqs RX queues
+ */
+static unsigned long
+ibmveth_desired_dma_for_rxqs(struct ibmveth_adapter *adapter,
+			     unsigned int rxqs)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct iommu_table *tbl;
+	unsigned long ret;
+	int i, q;
+
+	tbl = get_iommu_table_base(&adapter->vdev->dev);
+
+	ret = IBMVETH_BUFF_LIST_SIZE * rxqs + IBMVETH_FILT_LIST_SIZE;
+	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
+	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
+
+	/*
+	 * Pool metadata for queues 1+ is copied from queue 0 at open.
+	 * Always size from pool 0 x @rxqs.
+	 *
+	 * CMO (Power9 and earlier) and MQ firmware (Power11+) do not
+	 * coexist, so a CMO partition always sizes one queue here. The
+	 * MQ terms and the ethtool -L CMO refreshes are defensive only.
+	 */
+	for (q = 0; q < rxqs; q++) {
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
+		ret += IOMMU_PAGE_ALIGN(rxqentries *
+					sizeof(struct ibmveth_rx_q_entry), tbl);
+	}
+
+	return ret;
+}
+
+/**
+ * ibmveth_free_stranded_rx_queues - Free queues stranded above the live count
+ * @adapter: ibmveth adapter structure
+ *
+ * A scale-up register or IRQ-setup failure whose H_FREE_LOGICAL_LAN_QUEUE
+ * also fails leaves that queue out of the live set with its handle set
+ * and its memory still mapped. Call only after successful H_FREE_LOGICAL_LAN,
+ * which drops every subordinate queue, so the memory can be released.
+ */
+static void ibmveth_free_stranded_rx_queues(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = ibmveth_get_num_rx_queues(adapter);
+	     i < IBMVETH_MAX_RX_QUEUES; i++) {
+		if (!adapter->queue_handle[i])
+			continue;
+		adapter->queue_handle[i] = 0;
+		ibmveth_free_single_rx_queue(adapter, i);
+	}
+}
+
+/* Set CMO desired entitlement from the live RX queue count. */
+static void ibmveth_refresh_cmo_desired(struct ibmveth_adapter *adapter)
+{
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+}
+
+/**
+ * ibmveth_scale_up_rx_queues - Add RX queues to a live adapter
+ * @adapter: ibmveth adapter structure
+ * @old_count: Current number of RX queues
+ * @new_count: Target number of RX queues, above @old_count
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Raises CMO entitlement and widens real_num_rx_queues before any new
+ * queue is unmasked, then brings each queue up in turn. A failure
+ * unwinds only the queues this call added; a queue PHYP refuses to
+ * release stays in the live set instead.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_scale_up_rx_queues(struct ibmveth_adapter *adapter, int old_count,
+			   int new_count, int rxq_entries)
+{
+	struct net_device *netdev = adapter->netdev;
+	int failed_queue;
+	int rc, i;
+
+	netdev_dbg(netdev, "Scale-up: adding queues %d-%d\n",
+		   old_count, new_count - 1);
+
+	/*
+	 * Raise CMO desired for the target count before dma_map /
+	 * dma_alloc_coherent / replenish (same order as change_mtu).
+	 * Do not bump live num_rx_queues here, only entitlement.
+	 */
+	if (firmware_has_feature(FW_FEATURE_CMO)) {
+		unsigned long dma;
+
+		dma = ibmveth_desired_dma_for_rxqs(adapter, new_count);
+		vio_cmo_set_dev_desired(adapter->vdev, dma);
+	}
+
+	/*
+	 * Widen real_num before any new queue is unmasked so
+	 * skb_record_rx_queue() cannot trip get_rps_cpu()
+	 * WARN_ONCE. Probe already allocated num_rx_queues.
+	 */
+	rc = netif_set_real_num_rx_queues(netdev, new_count);
+	if (rc) {
+		netdev_err(netdev,
+			   "Failed to set real RX queues to %d: %d\n",
+			   new_count, rc);
+		ibmveth_refresh_cmo_desired(adapter);
+		return rc;
+	}
+
+	for (i = old_count; i < new_count; i++) {
+		if (adapter->queue_handle[i]) {
+			/* Left by a failed H_FREE; close frees it. */
+			netdev_err(netdev,
+				   "RX queue %d still held by PHYP, reset pending\n",
+				   i);
+			rc = -EBUSY;
+			goto cleanup_new_queues;
+		}
+		rc = ibmveth_alloc_single_rx_queue(adapter, i,
+						   rxq_entries);
+		if (rc) {
+			netdev_err(netdev, "Failed to allocate queue %d: %d\n",
+				   i, rc);
+			goto cleanup_new_queues;
+		}
+
+		rc = ibmveth_register_single_rx_queue(adapter, i);
+		if (rc) {
+			netdev_err(netdev, "Failed to register queue %d: %d\n",
+				   i, rc);
+			if (rc == -EOPNOTSUPP)
+				adapter->mq_fallback = true;
+			if (!ibmveth_deregister_single_rx_queue(adapter,
+								i))
+				ibmveth_free_single_rx_queue(adapter,
+							     i);
+			else
+				schedule_work(&adapter->work);
+			goto cleanup_new_queues;
+		}
+
+		rc = ibmveth_setup_single_rx_interrupt(adapter, i);
+		if (rc) {
+			netdev_err(netdev,
+				   "Failed to setup IRQ for queue %d: %d\n",
+				   i, rc);
+			/* request_irq failed: mapped but no handler */
+			ibmveth_dispose_subordinate_irq_mapping(adapter,
+								i);
+			if (!ibmveth_deregister_single_rx_queue(adapter,
+								i))
+				ibmveth_free_single_rx_queue(adapter,
+							     i);
+			else
+				schedule_work(&adapter->work);
+			goto cleanup_new_queues;
+		}
+
+		/*
+		 * Fully ready before PHYP delivery, matching open():
+		 * publish -> replenish -> napi_enable -> enable_irq.
+		 * That way ibmveth_interrupt() cannot run on an
+		 * unpublished, empty, or NAPI-disabled queue.
+		 */
+		ibmveth_publish_num_rx_queues(adapter, i + 1);
+		ibmveth_replenish_task(adapter, i);
+		napi_enable(&adapter->napi[i]);
+
+		rc = ibmveth_enable_irq(adapter, i);
+		if (rc) {
+			netdev_err(netdev,
+				   "Failed to enable IRQ for queue %d: %d\n",
+				   i, rc);
+			/*
+			 * Published, replenished, and NAPI-enabled,
+			 * but PHYP never unmasked. Match scale-down /
+			 * shared cleanup: drain posted buffers, then
+			 * deregister before unmap via
+			 * destroy_subordinate.
+			 *
+			 * napi_disable() must come BEFORE the count
+			 * is lowered, matching scale-down and
+			 * cleanup_new_queues. Lowering it first does
+			 * not hide queue i from netpoll: after
+			 * ndo_poll_controller, netpoll_poll_dev()
+			 * calls poll_napi(), which walks dev->napi_list
+			 * unbounded by the queue count and skips a NAPI
+			 * only once NAPI_STATE_NPSVC is set. Queue i is
+			 * enabled here, so ibmveth_poll() would run and
+			 * trip its queue_index >= num_rx_queues
+			 * WARN_ON. napi_disable() sets NPSVC, so
+			 * poll_napi() skips the queue instead.
+			 */
+			napi_disable(&adapter->napi[i]);
+			/* A poll may have unmasked PHYP; remask. */
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+			ibmveth_publish_num_rx_queues(adapter, i);
+			ibmveth_drain_rx_queue(adapter, i);
+			synchronize_net();
+		}
+		if (rc &&
+		    ibmveth_destroy_subordinate_rx_queue(adapter, i)) {
+			int keep = i + 1;
+
+			/*
+			 * PHYP still owns queue i. Keep it in the
+			 * live set with the queues this -L already
+			 * added. cleanup_new_queues would publish
+			 * below i and orphan this mapping.
+			 */
+			ibmveth_publish_num_rx_queues(adapter, keep);
+			if (netif_set_real_num_rx_queues(netdev,
+							 keep))
+				schedule_work(&adapter->work);
+			ibmveth_replenish_task(adapter, i);
+			napi_enable(&adapter->napi[i]);
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "IRQ %d rc=%d\n",
+					   i, rc);
+				schedule_work(&adapter->work);
+			} else {
+				ibmveth_restart_rx_queue(adapter, i);
+			}
+			return -EIO;
+		}
+		if (rc) {
+			/* enable_irq errno; keep -EIO. */
+			rc = -EIO;
+			goto cleanup_new_queues;
+		}
+		ibmveth_restart_rx_queue(adapter, i);
+	}
+
+	return 0;
+
+cleanup_new_queues:
+	failed_queue = i;
+	if (failed_queue > old_count)
+		netdev_err(netdev,
+			   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
+			   failed_queue, old_count, failed_queue - 1);
+	else
+		netdev_err(netdev,
+			   "Scale-up failed at queue %d, nothing to clean up\n",
+			   failed_queue);
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++)
+		napi_disable(&adapter->napi[i]);
+
+	/* Same remask as scale-down: poll may have re-armed during disable. */
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	/* Drop the live count before freeing the half-added queues. */
+	ibmveth_publish_num_rx_queues(adapter, old_count);
+	if (netif_set_real_num_rx_queues(netdev, old_count))
+		schedule_work(&adapter->work);
+	synchronize_net();
+
+	for (i = failed_queue - 1; i >= old_count; i--) {
+		int keep;
+
+		if (!ibmveth_destroy_subordinate_rx_queue(adapter, i))
+			continue;
+
+		keep = i + 1;
+		ibmveth_publish_num_rx_queues(adapter, keep);
+		if (netif_set_real_num_rx_queues(netdev, keep))
+			schedule_work(&adapter->work);
+		for (i = old_count; i < keep; i++) {
+			int irq_rc;
+
+			ibmveth_replenish_task(adapter, i);
+			/* START: NAPI before PHYP unmask. */
+			napi_enable(&adapter->napi[i]);
+			irq_rc = ibmveth_enable_irq(adapter, i);
+			if (irq_rc) {
+				netdev_err(netdev,
+					   "IRQ %d rc=%d\n",
+					   i, irq_rc);
+				schedule_work(&adapter->work);
+				continue;
+			}
+			ibmveth_restart_rx_queue(adapter, i);
+		}
+		ibmveth_refresh_cmo_desired(adapter);
+		netdev_warn(netdev,
+			    "Keeping %d queues after scale-up failure\n",
+			    keep);
+		return rc;
+	}
+
+	/* Roll CMO desired back to the surviving queue count. */
+	ibmveth_refresh_cmo_desired(adapter);
+
+	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
+		    old_count);
+	return rc;
+}
+
+/**
+ * ibmveth_scale_down_rx_queues - Remove RX queues from a live adapter
+ * @adapter: ibmveth adapter structure
+ * @old_count: Current number of RX queues
+ * @new_count: Target number of RX queues, below @old_count
+ *
+ * Quiesces the retiring queues, drains them and harvests their final
+ * no_buffer counts, publishes the surviving count, and only then
+ * deregisters them. Walks high to low so a failed free leaves 0..i
+ * live and republishes that count.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_scale_down_rx_queues(struct ibmveth_adapter *adapter, int old_count,
+			     int new_count)
+{
+	struct net_device *netdev = adapter->netdev;
+	int rc, i;
+
+	netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
+		   new_count, old_count - 1);
+
+	/*
+	 * Mask PHYP before napi_disable so the handler cannot miss
+	 * a mask while NAPI is already dead. An in-flight poll can
+	 * still re-arm PHYP while napi_disable() waits, so remask
+	 * and sync again after NAPI is stopped. Then drain, harvest
+	 * final no_buffer stats, publish the surviving count, and
+	 * synchronize_net() before destroy so netpoll cannot walk
+	 * dying queues (handler may still be registered until destroy).
+	 */
+	for (i = new_count; i < old_count; i++) {
+		if (!adapter->queue_irq[i])
+			continue;
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = new_count; i < old_count; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = new_count; i < old_count; i++) {
+		if (!adapter->queue_irq[i])
+			continue;
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = new_count; i < old_count; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	/*
+	 * netpoll still reaches these queues until the publish
+	 * below, and ibmveth_replenish_task() folds the same
+	 * counters under the queue's replenish_lock. Take it here
+	 * so the harvest stays the single writer it documents.
+	 */
+	for (i = new_count; i < old_count; i++) {
+		struct ibmveth_rx_q *rxq = &adapter->rx_queue[i];
+		unsigned long flags;
+
+		spin_lock_irqsave(&rxq->replenish_lock, flags);
+		ibmveth_update_rx_no_buffer(adapter, i);
+		spin_unlock_irqrestore(&rxq->replenish_lock, flags);
+	}
+
+	ibmveth_publish_num_rx_queues(adapter, new_count);
+	synchronize_net();
+
+	rc = netif_set_real_num_rx_queues(netdev, new_count);
+	if (rc) {
+		netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+			   new_count, rc);
+		ibmveth_publish_num_rx_queues(adapter, old_count);
+		for (i = new_count; i < old_count; i++) {
+			int irq_rc;
+
+			ibmveth_replenish_task(adapter, i);
+			/* START: NAPI before PHYP unmask. */
+			napi_enable(&adapter->napi[i]);
+			irq_rc = ibmveth_enable_irq(adapter, i);
+			if (irq_rc) {
+				netdev_err(netdev,
+					   "Failed to re-enable IRQ for queue %d during scale-down rollback (rc=%d), scheduling reset\n",
+					   i, irq_rc);
+				schedule_work(&adapter->work);
+				continue;
+			}
+			ibmveth_restart_rx_queue(adapter, i);
+		}
+		return rc;
+	}
+
+	for (i = old_count - 1; i >= new_count; i--) {
+		int keep;
+
+		rc = ibmveth_destroy_subordinate_rx_queue(adapter, i);
+		if (!rc)
+			continue;
+
+		/*
+		 * High-to-low so a failed free leaves 0..i live.
+		 * Queues i+1..old_count-1 are already gone.
+		 */
+		keep = i + 1;
+		ibmveth_publish_num_rx_queues(adapter, keep);
+		if (netif_set_real_num_rx_queues(netdev, keep))
+			schedule_work(&adapter->work);
+		for (i = new_count; i < keep; i++) {
+			int irq_rc;
+
+			ibmveth_replenish_task(adapter, i);
+			/* START: NAPI before PHYP unmask. */
+			napi_enable(&adapter->napi[i]);
+			irq_rc = ibmveth_enable_irq(adapter, i);
+			if (irq_rc) {
+				netdev_err(netdev,
+					   "IRQ %d rc=%d\n",
+					   i, irq_rc);
+				schedule_work(&adapter->work);
+				continue;
+			}
+			ibmveth_restart_rx_queue(adapter, i);
+		}
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_resize_rx_queues_incremental - Resize RX queue count incrementally
+ * @adapter: ibmveth adapter structure
+ * @new_count: Target number of RX queues
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Adds or removes RX queues without tearing down the entire adapter.
+ * Active queues continue receiving during scale-up. Scale-up widens
+ * real_num_rx_queues before unmasking a new queue. Scale-down drains
+ * excess queues before deregistering them with the hypervisor.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
+				     int new_count, int rxq_entries)
+{
+	struct net_device *netdev = adapter->netdev;
+	int old_count = ibmveth_get_num_rx_queues(adapter);
+	int rc;
+
+	if (old_count == new_count) {
+		netdev_dbg(netdev, "RX queue count unchanged (%d), nothing to do\n",
+			   old_count);
+		return 0;
+	}
+
+	if (new_count < 1 || new_count > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev, "Invalid RX queue count %d (must be 1-%d)\n",
+			   new_count, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	netdev_info(netdev, "Incrementally resizing RX queues: %d to %d\n",
+		    old_count, new_count);
+
+	if (new_count > old_count)
+		rc = ibmveth_scale_up_rx_queues(adapter, old_count, new_count,
+						rxq_entries);
+	else
+		rc = ibmveth_scale_down_rx_queues(adapter, old_count,
+						  new_count);
+	if (rc)
+		return rc;
+
+	netdev_info(netdev, "Successfully resized to %u RX queues (incremental)\n",
+		    ibmveth_get_num_rx_queues(adapter));
+
+	ibmveth_refresh_cmo_desired(adapter);
+
+	return 0;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -1894,15 +2740,16 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
  * Used during interface close and registration error cleanup.
  *
  * Retries only H_BUSY and H_IS_LONG_BUSY. On other failures, logs and
- * returns; callers cannot observe hypercall status. queue_handle[] is
- * cleared regardless. Callers still run RX pool and DMA teardown
- * afterward (same as pre-helper close()).
+ * returns -EIO; queue_handle[] is cleared regardless. Callers still run
+ * RX pool and DMA teardown afterward (same as pre-helper close()).
  *
  * Clears queue handles only; queue_irq[] is released by
  * ibmveth_cleanup_rx_interrupts() on close, or by
  * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
+ *
+ * Return: 0 on success, -EIO if H_FREE_LOGICAL_LAN failed
  */
-static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+static int ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 {
 	unsigned long lpar_rc;
 	int i;
@@ -1913,13 +2760,16 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+		adapter->queue_handle[i] = 0;
+
 	if (lpar_rc != H_SUCCESS) {
 		netdev_err(adapter->netdev,
 			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+		return -EIO;
 	}
 
-	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
-		adapter->queue_handle[i] = 0;
+	return 0;
 }
 
 /**
@@ -2152,7 +3002,8 @@ static int ibmveth_close(struct net_device *netdev)
 		ibmveth_update_rx_no_buffer(adapter, i);
 		spin_unlock_irqrestore(&rxq->replenish_lock, flags);
 	}
-	ibmveth_free_all_queues(adapter);
+	if (!ibmveth_free_all_queues(adapter))
+		ibmveth_free_stranded_rx_queues(adapter);
 	/* Free TX LTBs after quiesce and after H_FREE_LOGICAL_LAN so xmit
 	 * cannot touch unmapped bounce buffers while the LAN is live.
 	 */
@@ -2559,6 +3410,74 @@ static void ibmveth_get_channels(struct net_device *netdev,
 	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
 }
 
+/**
+ * ibmveth_resize_rx_channels - Validate and apply a new RX queue count
+ * @adapter: ibmveth adapter
+ * @goal_rx: requested RX queue count
+ *
+ * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
+ * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). An RX count change while the
+ * device is down is rejected (-EOPNOTSUPP); publishing it without
+ * allocating arrives in the next patch. When up, apply via
+ * ibmveth_resize_rx_queues_incremental().
+ *
+ * Return: 0 or negative errno
+ */
+static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
+				      unsigned int goal_rx)
+{
+	struct net_device *netdev = adapter->netdev;
+	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
+	int rxq_entries;
+	int rc;
+
+	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev,
+			   "Invalid RX queue count %u (must be 1-%d)\n",
+			   goal_rx, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	/*
+	 * Check for a no-op before the capability gate. ethtool -L is
+	 * read-modify-write, so a TX-only request arrives carrying the
+	 * current RX count; gating first would fail those with
+	 * -EOPNOTSUPP once mq_fallback is set.
+	 */
+	if (goal_rx == old_rx)
+		return 0;
+
+	/*
+	 * Refuse any rx > 1, not just growth: once mq_fallback is set the
+	 * next open comes up single-queue, so an intermediate count could
+	 * not be honoured either, and accepting it would only repeat the
+	 * silent clamp at open. max_rx stays at the live count so that
+	 * read-modify-write TX-only requests still clear the core.
+	 */
+	if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
+		netdev_err(netdev,
+			   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
+			   goal_rx);
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Down / failed-open: there is nothing to resize, and publishing
+	 * the desired count without allocating arrives in the next
+	 * patch. Refuse rather than report success for a request that
+	 * would be discarded.
+	 */
+	if (!adapter->opened)
+		return -EOPNOTSUPP;
+
+	rxq_entries = adapter->rx_queue[0].num_slots;
+	rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
+						  rxq_entries);
+	if (rc)
+		netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
+	return rc;
+}
+
 static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
@@ -2567,18 +3486,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;
 
-	/*
-	 * RX channel resize is implemented in a later patch; reject any
-	 * request that changes rx_count. Read-modify-write TX adjustments
-	 * submit the current rx_count and proceed.
+	/* Validate RX (and resize when opened) before the down-path
+	 * early return so MQ/range errors are reported here. Publishing
+	 * the desired RX count and CMO while down is the next patch.
 	 */
-	if (channels->rx_count != ibmveth_get_num_rx_queues(adapter))
-		return -EOPNOTSUPP;
+	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	if (rc)
+		return rc;
 
-	/* If ndo_open has not been called yet then don't allocate, just set
-	 * desired netdev_queue's and return
-	 */
-	if (!(netdev->flags & IFF_UP))
+	if (!adapter->opened)
 		return netif_set_real_num_tx_queues(netdev, goal);
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
@@ -3311,8 +4227,6 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct net_device *netdev = dev_get_drvdata(&vdev->dev);
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
-	unsigned long ret;
-	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -3321,41 +4235,8 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 		return IOMMU_PAGE_ALIGN(IBMVETH_IO_ENTITLEMENT_DEFAULT, tbl);
 
 	adapter = netdev_priv(netdev);
-
-	/* One buffer list page per RX queue; filter list is shared. */
-	ret = IBMVETH_BUFF_LIST_SIZE * ibmveth_get_num_rx_queues(adapter) +
-	      IBMVETH_FILT_LIST_SIZE;
-	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
-	/* add size of mapped tx buffers */
-	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
-
-	/*
-	 * Pool metadata for queues 1+ is copied from queue 0 at open.
-	 * Always size from pool 0 x num_rx_queues.
-	 *
-	 * CMO (Power9 and earlier) and MQ firmware (Power11+) do not
-	 * coexist, so a CMO partition always sizes one queue here. The
-	 * MQ terms are defensive only.
-	 */
-	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
-		int rxqentries = 1;
-
-		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-			struct ibmveth_buff_pool *bpool =
-				&adapter->rx_buff_pool[0][i];
-
-			if (bpool->active)
-				ret += bpool->size *
-					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
-			rxqentries += bpool->size;
-		}
-
-		/* add the size of the receive queue entries */
-		ret += IOMMU_PAGE_ALIGN(rxqentries *
-					sizeof(struct ibmveth_rx_q_entry), tbl);
-	}
-
-	return ret;
+	return ibmveth_desired_dma_for_rxqs(adapter,
+					    ibmveth_get_num_rx_queues(adapter));
 }
 
 static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
-- 
2.50.1 (Apple Git-155)


