Return-Path: <linuxppc-dev+bounces-26317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A14C624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYY6W0dLzz2yCt;
	Tue, 01 Sep 2026 01:38:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788190691;
	cv=none; b=i1jy4JqWXodlZOHR42ZGl7LbNDmsskHtS5pvREuK/SX6UQQHFH3TNNVzl8yKdtoNXUMBPM1kT8oqc2RhXthz/BR2r3yg4ylI/374YILPpyJnA0kpY3v03lvg3vrE59Ssj2pt3PJGnEO96tE/WJNk+G+8egqR2wz/XvGIq/xz53a+YySfW/HAB8qbfiFHzQAsJaPSUYaGta1ZAGVGEbYZ/0ScfF3Goh7erh2/sjdt40wKUUIQPcKpUad+aJVWOeohwYzVxQ6GbKKUp8m/mBB9Lm4GoSmgWxa+ZX7gn81fLOl6KZHeHT92VCraU586ubvzEBWd5zOFWA/qhtiYxXpEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788190691; c=relaxed/relaxed;
	bh=A/EE6SfXGYyffFrbfz8YMyyeSJjthm5Fb55m7U03D4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHG02w6KlOKw1KG5dz9Evi8CC+DVURqM6dBq5o/i5fKQYi5y9V+vAI90vLtDWDirAsDupv86n5Hw1aM5xzCSV0lSixQBH1y46N0e/O3MfaCfqmdZlnaF7Bv7W+sgVkjhQ1n9tsywutS7BWsHM0QFm4aMceswbVz7m0O5tt8k1poIMvqaJY3EXkfngIBjxGgWe3ATSk7oqb2v7x+TciTpWiJpt2DBYcxV/GHr39ATTvEzYFc4BxigZy9W8Lx/+qUI15c4ey37Gu8zNb4jsytOlAwBINEqxUpv+KrdJUc3dEFeh5q3JtUsxstzO+89CGqBgf+u3ofY3f31hZcS7Y1SPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B2cJIEYK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B2cJIEYK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYY6T3pB2z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:38:08 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9GO2582944;
	Mon, 31 Aug 2026 15:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A/EE6SfXGYyffFrbf
	z8YMyyeSJjthm5Fb55m7U03D4M=; b=B2cJIEYKdcFolEa/8KWvbIMt6Mpi7iYzo
	wQ2WBUE5jCfUsEPfy4I47nVzBqngF8Fn1UwlBV8dtXOdyCJQdNlTUL389Ctlr4VD
	kOrafRdNHT8Nlt7rhK5oFp8nbq3VZr9sAGxR1ZwL8MOwROfLonAfWYnWl8QcShuD
	Or/EFlrfzKaG7wFvn8hNS028ZAEcc/vrxGjOHoT+9YQtQrAHJierCpMUyDrpxYU8
	hUX3/ASKGGKayYXR+f73fGndb4Tphw2+if9TKNbn/ZOM3s7Z8PJwoEa9jJds9A6+
	S9jJSdsbPuZtsaWhbTydpsa/1LmcjlDHCgQkZktFxVXj/UQs5KIqg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1x8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuOr8024797;
	Mon, 31 Aug 2026 15:09:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxk3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF96Kc31064754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:09:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB8115805F;
	Mon, 31 Aug 2026 15:09:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D0775805A;
	Mon, 31 Aug 2026 15:09:03 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:09:02 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 14/15] ibmveth: Implement incremental MQ RX queue resize
Date: Mon, 31 Aug 2026 08:07:25 -0700
Message-Id: <78b7ee90a73d9849e2bf119d6c5f576e29b20159.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a959917 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=RNNLkBzVs7WOcDH24voA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX6jUgCjqUYAvM
 yqSeCK4jr1KaZz603Vl8ohnhB4/+NlYxPCEptheTu+bSA/ETmIo36FnNmXn9ZlAzKHhn4DYkvta
 nklP/K2/bTajohfwyh4F/JJmt8y1VEI=
X-Proofpoint-ORIG-GUID: kbFLAbJ4U_QsxqOw-y6e340xLwX_XB84
X-Proofpoint-GUID: 2_RboAx4QNS_DKWM6x-_oNcW9CZyFkCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX9parVFLxvSqT
 Cn0aKJdrLTnN+zxqcrLwQo/ta3VB41SElsN0/M12eQJVxLdr62TVX3vn1egfu9XPBu94jn8mgWq
 iE85kPcl6PPEzU+qDvBAjPbR1v1aPH2181QE9bjaNEUUkMIUQf65KxU1tEr/WkCU5CtogkR95L1
 fowZsRH7nNwRpw6+gKLmWmB4P7eiDqUFwHr3uqH2NR7HGp/rILVwAA79fTlU8HgPMFaW2YamJ0v
 AHHYCShgZOB/8UdA11ShoQwnhKpOThCJhboECKA6BWtGpAmJrmu9OTZ8o84/90GKnbBdegzOctt
 p9iQ8ISpw76naQ3lJV8CBfta8lxRS1QtqmjRuKRtrRlWKnARnMZgeHA6QRfC9b6GSW8u2pqtg9K
 raT+qriU/ueRf2KbzDEGh71sX542QLPeZ5Gs6/uAFWqlF2Cr1Ge4mH/8cf/SRheBkn9tcdE8JAg
 f+OcbB7DfldE94j58IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

Add ibmveth_resize_rx_queues_incremental() so the live RX channel
count can change without a full device tear-down, and
ibmveth_resize_rx_channels() as the entry point set_channels() calls.

Scale-up allocates DMA buffer lists and pool memory for the new
queues, registers them with PHYP via H_REG_LOGICAL_LAN_QUEUE and maps
subordinate IRQs, then brings each queue up: publish the count,
replenish, enable NAPI, and only then unmask PHYP, so the handler
cannot run on an unpublished, empty or NAPI-disabled queue. It
finishes with the same restart helper open() uses, so a total
replenish miss can still get a poll to retry.

Queues come up before netif_set_real_num_rx_queues() widens, so a frame
on a new queue can briefly carry an rx queue index above
real_num_rx_queues. RPS then skips steering and takes the default path,
tripping the WARN_ONCE in get_rps_cpu() if the device already had more
than one queue. Transient, and delivery is unaffected.

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
queue metadata its correlators index is still valid.

Both directions unwind. Scale-up failures jump to cleanup_new_queues:,
which destroys only the queues this call created and leaves the
previous set live and running. Scale-down failures republish the old
count, then replenish, napi_enable and unmask each retiring queue
(and restart if the IRQ comes back). If the IRQ cannot be re-enabled
they schedule a reset.

Reject rx > 1 with -EOPNOTSUPP when firmware lacks MQ support or
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

Key the resize path's early return on adapter->opened rather than
IFF_UP: RX buffers, mappings and IRQs exist only after a successful
open, so IFF_UP alone does not mean there is anything to resize.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

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

 drivers/net/ethernet/ibm/ibmveth.c | 732 +++++++++++++++++++++++++++--
 1 file changed, 692 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 954846c9ec7b..5aef8a1f2c23 100644
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
@@ -793,7 +845,16 @@ static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
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
@@ -1261,8 +1322,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
  * SQ open leaves PHYP masked until the first poll. If schedule_prep fails,
  * NAPI never runs and the queue stays masked (TX OK, RX/ARP dead) until
  * reload. Replenish first so an enable_irq fallback can actually deliver.
- * Also used after every open (SQ and MQ) and after scale-down so a
- * queue is not left idle+masked.
+ * Also used after every open (SQ and MQ) and after scale-down rollback.
  */
 static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
 				     int qindex)
@@ -1452,6 +1512,141 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
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
+	if (adapter->buffer_list_dma[queue_idx]) {
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
@@ -1613,6 +1808,56 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ibmveth_drain_rx_queue - Drain pending buffers from an RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Queue index to drain
+ *
+ * Recycles all pending buffers back to the per-queue buffer pools.
+ * Must be called with NAPI disabled for this queue.
+ *
+ * Return: Number of buffers drained
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
+		netdev_dbg(netdev, "Drained %d buffer(s) from RX queue %d\n",
+			   drained, queue_index);
+	else
+		netdev_dbg(netdev, "No buffers to drain from RX queue %d\n",
+			   queue_index);
+
+	return drained;
+}
+
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
 	void *ltb = adapter->tx_ltb_ptr[idx];
@@ -1881,6 +2126,378 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
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
+ */
+static void
+ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
+				   int queue_idx)
+{
+	unsigned long lpar_rc;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long qh = adapter->queue_handle[queue_idx];
+
+	if (!qh)
+		return;
+
+	do {
+		lpar_rc = h_free_logical_lan_queue(ua, qh);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+	}
+
+	adapter->queue_handle[queue_idx] = 0;
+
+	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
+}
+
+/**
+ * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to destroy (1..N)
+ *
+ * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
+ * ownership is released while queue metadata is still valid.
+ */
+static void
+ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
+				     int queue_idx)
+{
+	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
+	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
+	ibmveth_free_single_rx_queue(adapter, queue_idx);
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
+	 * Always size from pool 0 x @rxqs (valid at probe before that copy).
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
+ * ibmveth_resize_rx_queues_incremental - Resize RX queue count incrementally
+ * @adapter: ibmveth adapter structure
+ * @new_count: Target number of RX queues
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Adds or removes RX queues without tearing down the entire adapter.
+ * Active queues continue receiving during scale-up; scale-down drains
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
+	int failed_queue;
+	int rc, i;
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
+	if (new_count > old_count) {
+		netdev_dbg(netdev, "Scale-up: adding queues %d-%d\n",
+			   old_count, new_count - 1);
+
+		/*
+		 * Raise CMO desired for the target count before dma_map /
+		 * dma_alloc_coherent / replenish (same order as change_mtu).
+		 * Do not bump live num_rx_queues here, only entitlement.
+		 */
+		if (firmware_has_feature(FW_FEATURE_CMO)) {
+			unsigned long dma;
+
+			dma = ibmveth_desired_dma_for_rxqs(adapter, new_count);
+			vio_cmo_set_dev_desired(adapter->vdev, dma);
+		}
+
+		for (i = old_count; i < new_count; i++) {
+			rc = ibmveth_alloc_single_rx_queue(adapter, i,
+							   rxq_entries);
+			if (rc) {
+				netdev_err(netdev, "Failed to allocate queue %d: %d\n",
+					   i, rc);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_register_single_rx_queue(adapter, i);
+			if (rc) {
+				netdev_err(netdev, "Failed to register queue %d: %d\n",
+					   i, rc);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_setup_single_rx_interrupt(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to setup IRQ for queue %d: %d\n",
+					   i, rc);
+				/* request_irq failed: mapped but no handler */
+				ibmveth_dispose_subordinate_irq_mapping(adapter,
+									i);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			/*
+			 * Fully ready before PHYP delivery, matching open():
+			 * publish -> replenish -> napi_enable -> enable_irq.
+			 * That way ibmveth_interrupt() cannot run on an
+			 * unpublished, empty, or NAPI-disabled queue.
+			 */
+			ibmveth_publish_num_rx_queues(adapter, i + 1);
+			ibmveth_replenish_task(adapter, i);
+			napi_enable(&adapter->napi[i]);
+
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d: %d\n",
+					   i, rc);
+				/*
+				 * Published, replenished, and NAPI-enabled,
+				 * but PHYP never unmasked. Match scale-down /
+				 * shared cleanup: drain posted buffers, then
+				 * deregister before unmap via
+				 * destroy_subordinate.
+				 *
+				 * napi_disable() must come BEFORE the count
+				 * is lowered, matching scale-down and
+				 * cleanup_new_queues. Lowering it first does
+				 * not hide queue i from netpoll: after
+				 * ndo_poll_controller, netpoll_poll_dev()
+				 * calls poll_napi(), which walks dev->napi_list
+				 * unbounded by the queue count and skips a NAPI
+				 * only once NAPI_STATE_NPSVC is set. Queue i is
+				 * enabled here, so ibmveth_poll() would run and
+				 * trip its queue_index >= num_rx_queues
+				 * WARN_ON. napi_disable() sets NPSVC, so
+				 * poll_napi() skips the queue instead.
+				 */
+				napi_disable(&adapter->napi[i]);
+				ibmveth_publish_num_rx_queues(adapter, i);
+				ibmveth_drain_rx_queue(adapter, i);
+				synchronize_net();
+				ibmveth_destroy_subordinate_rx_queue(adapter,
+								     i);
+				/* enable_irq returns errno; keep -EIO. */
+				rc = -EIO;
+				goto cleanup_new_queues;
+			}
+			ibmveth_restart_rx_queue(adapter, i);
+		}
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			goto cleanup_new_queues;
+		}
+	} else {
+		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
+			   new_count, old_count - 1);
+
+		/*
+		 * Mask PHYP before napi_disable so the handler cannot miss
+		 * a mask while NAPI is already dead. An in-flight poll can
+		 * still re-arm PHYP while napi_disable() waits, so remask
+		 * and sync again after NAPI is stopped. Then drain, harvest
+		 * final no_buffer stats, publish the surviving count, and
+		 * synchronize_net() before destroy so netpoll cannot walk
+		 * dying queues (handler may still be registered until destroy).
+		 */
+		for (i = new_count; i < old_count; i++) {
+			if (!adapter->queue_irq[i])
+				continue;
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		for (i = new_count; i < old_count; i++)
+			napi_disable(&adapter->napi[i]);
+
+		for (i = new_count; i < old_count; i++) {
+			if (!adapter->queue_irq[i])
+				continue;
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_drain_rx_queue(adapter, i);
+
+		/*
+		 * netpoll still reaches these queues until the publish
+		 * below, and ibmveth_replenish_task() folds the same
+		 * counters under the queue's replenish_lock. Take it here
+		 * so the harvest stays the single writer it documents.
+		 */
+		for (i = new_count; i < old_count; i++) {
+			struct ibmveth_rx_q *rxq = &adapter->rx_queue[i];
+			unsigned long flags;
+
+			spin_lock_irqsave(&rxq->replenish_lock, flags);
+			ibmveth_update_rx_no_buffer(adapter, i);
+			spin_unlock_irqrestore(&rxq->replenish_lock, flags);
+		}
+
+		ibmveth_publish_num_rx_queues(adapter, new_count);
+		synchronize_net();
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			ibmveth_publish_num_rx_queues(adapter, old_count);
+			for (i = new_count; i < old_count; i++) {
+				int irq_rc;
+
+				ibmveth_replenish_task(adapter, i);
+				/* START: NAPI before PHYP unmask. */
+				napi_enable(&adapter->napi[i]);
+				irq_rc = ibmveth_enable_irq(adapter, i);
+				if (irq_rc) {
+					netdev_err(netdev,
+						   "Failed to re-enable IRQ for queue %d during scale-down rollback (rc=%d), scheduling reset\n",
+						   i, irq_rc);
+					schedule_work(&adapter->work);
+					continue;
+				}
+				ibmveth_restart_rx_queue(adapter, i);
+			}
+			return rc;
+		}
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_destroy_subordinate_rx_queue(adapter, i);
+	}
+
+	netdev_info(netdev, "Successfully resized to %u RX queues (incremental)\n",
+		    ibmveth_get_num_rx_queues(adapter));
+
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
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
+	synchronize_net();
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_destroy_subordinate_rx_queue(adapter, i);
+
+	/* Roll CMO desired back to the surviving queue count. */
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+
+	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
+		    old_count);
+	return rc;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -2550,6 +3167,68 @@ static void ibmveth_get_channels(struct net_device *netdev,
 	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
 }
 
+/**
+ * ibmveth_resize_rx_channels - Validate and apply a new RX queue count
+ * @adapter: ibmveth adapter
+ * @goal_rx: requested RX queue count
+ *
+ * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
+ * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). When RX resources are not live
+ * (!opened), only validate; do not allocate. When up, apply via
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
+	/* Down / failed-open: do not allocate. */
+	if (!adapter->opened)
+		return 0;
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
@@ -2558,10 +3237,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;
 
-	/* If ndo_open has not been called yet then don't allocate, just set
-	 * desired netdev_queue's and return
+	/* Validate RX (and resize when opened) before the down-path
+	 * early return so MQ/range errors are reported here. Publishing
+	 * the desired RX count and CMO while down is the next patch.
 	 */
-	if (!(netdev->flags & IFF_UP))
+	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	if (rc)
+		return rc;
+
+	if (!adapter->opened)
 		return netif_set_real_num_tx_queues(netdev, goal);
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
@@ -3291,8 +3975,6 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct net_device *netdev = dev_get_drvdata(&vdev->dev);
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
-	unsigned long ret;
-	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -3301,38 +3983,8 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
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
-	 * Always size from pool 0 x num_rx_queues (valid at probe before that
-	 * copy).
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


