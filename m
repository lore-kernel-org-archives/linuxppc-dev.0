Return-Path: <linuxppc-dev+bounces-28213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CD9C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzy32v4vz30YZ;
	Sat, 26 Sep 2026 04:39:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361563;
	cv=none; b=EXS+Sbx7IfC2Cwa8WPQDPlkHXw9F1e6vzlo/NwBzRJNDpyRwFTCJ/K2DroOGJMX1pygRE7ouUGonnXkNw3zJmMRoewkhn2soBUxKMdmr/3wBdsPSE1psWaf79hoTlaOYjJSroeVLVx55bdlLh2w3wM/GIxbAtNp0jb0r+mEFGbE4PN5nk7nfyuh84MySFg1O5KRdJs74L1X3s6x2pb5HrMGit3HX+AzkNUNllLs2MrVQpX+j9GSl0nr25pFkXenG6wvE2oPTsnaIRUQPC/ANg9ISQDrZzgSPbJV0BDwon136tKBKUUODK+unRMYDnjOmHH+tjQB1ezCDpDdwMbahJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361563; c=relaxed/relaxed;
	bh=1czMwG/uhMP0vsL0VxASfFfZkR5PjDpkIyHUPT3Hzuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iT/qn6BJprK8FzDWT3xTLuimOAkwDg9+h79HdIUyvNhRcQ/veK32NHmtUGjc7F+JSgvsFprSzSeWta5EDKQ+JRsKF5oRDChe2+XWcXckbAhkFP0TgsoQWxWi/i0uJG0RNyKbNfhlElZ0drluHbla66l2GTyAPiPiahtBjsxsl9KuTb6TgQpaEPp/jGd0v5pZ7zTnSfpY9rjr8mSElaUhIItnIS5cjXglP7S3XpdTRs1qWjGq/O4ZpBpZ+zdw6FUzjOtBeFj88/PakFjv1QwcZGe62RGLXbdg0yVP052wGFsjfoWoieXUOcG66l6wcSbzI3e9Dmpu6T7tSK0Aks5EUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rq/mIYLt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rq/mIYLt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzy20jJGz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:21 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5riP1371805;
	Fri, 25 Sep 2026 18:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=1czMwG/uhMP0vsL0VxASfFfZkR5P
	jDpkIyHUPT3Hzuw=; b=rq/mIYLtJaG0fj3xHtC2JAlAPqAtjeOF+++dXfFvjOey
	alH6mBR5gCIqN+bw84ZVZs4gdIQgfO6Xteta8Rtm8wMbHRDrnw3QgJGHHnQQAfWv
	4u+fs8DhTCDIXlbtUpEfXRU5SstcDiGnxFH1AUwQDU5vBmPfugLUW9d/qAksxIu8
	8CrVZIQsYL7PWW+95QQtvtZMTC33JiIQ8ETlHEjcdbUW78T50wqhVbutSrZUUiiN
	hItNT/6sxP9uX7p5lEJzUCacEgzoA+nrs9n6qBJZWt8U8Gs9/TF18wMWzSOjd/XE
	sOZTIql7EF2LidcIKP9GJhZaRJgFbqcFPPoU6e45mQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1yqkd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG36jN2859319;
	Fri, 25 Sep 2026 18:39:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7efst1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIcx0W32310012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:38:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F142258055;
	Fri, 25 Sep 2026 18:38:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4905A58063;
	Fri, 25 Sep 2026 18:38:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:38:56 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 00/15] ibmveth: Add multi-queue RX support
Date: Fri, 25 Sep 2026 11:38:35 -0700
Message-Id: <cover.1790319558.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: J9JWmAtjxIaPMOhrWIJI8YWBfPHcB330
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXymDbusSTnP93
 GmEWEJifYClKiIBQ8iWKeai8vSix4JbmuRPfFeDgb0p6uSOJqbt8vcKjj3XMMUW4zd/PROsSmsX
 0QsHtWrTN8oaox7ZlRE5lwnVyWU4V9qy1N6lhyuXKQ8ZNVd8TreTVJfyl8skKEIwATTblbuhn63
 HCiAvBrr6HT9fpvAOh9OrKvOe6Cp1X6DW6cZ0V9U6yR/vyC0Djci3X/s8dyuGaqJ3WjiP/ZNyr0
 AUkrgEKwgQHlINfH48aYtNTr/1lCUleRwPgSkJJHskXHxAZDFzko+d5CeSNKmcm53zzpyR7NmXJ
 auHmyd4NRGQFs+R08TjvC6RouN5oCABab4ITkLrMXW/XQu3trPgJg7mC3haUczU+uO3LJ9BIRen
 if0oTE/J6JGQm12mb25FEBNM7/a1KrlcwEFjsaj8hz3eEzs/XnTFEGuOA/yY3cuIUxcODj+UYti
 4ulg2QrGISetOAwYcmA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6bfcc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9R54UkLUAAAA:8 a=c92rfblmAAAA:8 a=u-kuS8aJhmmeio9VChwA:9
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX8MY5epCUzzGn
 Wv9SRHTdCRvl5lMweB72f7eUtchbjZAwIp8kctmkt6kcCnsrZJAoWW6Bx/AO4izlokhwQiOIasP
 PEz4ruKJiBlPWjmPmXRaw1Ok9BBa7Z0=
X-Proofpoint-GUID: zKCh-J0KKf-f9fPygtyUDLfX43ahVjJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Hi,

Power11 PHYP adds Virtual Ethernet multi-queue (MQ) RX: multiple
logical-LAN RX queues, per-queue buffer posting, and completion
delivery. Guest Linux did not use that; ibmveth still registered one
RX queue even when PHYP was MQ-capable.

This series adds the ibmveth MQ client for net-next. When PHYP
advertises IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT via H_ILLAN_ATTRIBUTES,
probe enables MQ with a default RX count of min(num_online_cpus(), 8)
(same cap as TX today); ethtool -L can raise RX up to 16. Packets are
received on per-queue NAPI. Older firmware without the bit is unchanged.
Queue selection remains firmware-defined (PHYP hash). Ethtool RSS hash
get/set for that algorithm is deferred to a follow-up series so this
one stays MQ datapath only.

User-visible bits: ethtool -l/-L (channels); standard per-queue
packets/bytes/drops via netdev_stat_ops (ethtool -S keeps only
driver-specific counters; ndo_get_stats64 is the aggregate, including
retired-queue history); and a read-only debugfs buffer_pools dump
(v3's multi-line sysfs dump moved to debugfs; the historical queue-0
poolN/ sysfs ABI is unchanged).

Background:

ibmveth today uses one logical LAN, one set of buffer pools, and one
NAPI context. PHYP MQ mode gives each RX queue its own handle (post via
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, subordinate register via
H_REG_LOGICAL_LAN_QUEUE); traffic can land on any active queue. The
driver needs per-queue pools, IRQs, and NAPI to match. Legacy firmware
keeps the original hcall path.

Series layout (15 patches):

  1-2   Hypercall wrappers; MQ adapter layout (MAX_RX_QUEUES stays 1)
  3-9   Queue-aware helpers (still SQ runtime): RX, per-queue pools,
        IRQ, TX, PHYP, buffer submit (open/close 3-8); poll harden (9)
  10    Enable MQ datapath at probe/open (subordinate register helpers
        land here with first use)
  11-13 Per-queue RX/TX stats; get_channels MQ counts; debugfs buffer_pools
  14    Incremental RX resize; live ethtool -L rx
  15    Down-path rollback and mq_fallback max_rx cap

- Helper patches (3-8) reshape ibmveth_open()/close() into
  queue-aware helpers. Patch 9 hardens the SQ poll path with the same
  queue-index helpers; it does not change open/close. MQ stays off
  through 3-9: num_rx_queues stays 1 and multi_queue is false until
  patch 10. The live single-queue path still changes where the review
  required it (open/close unwind, IRQ remask, replenish lock, poll
  harden).
- Patch 10 is the switch: probe sets multi_queue from firmware, raises
  num_rx_queues, registers subordinates, and replenishes every active
  queue.
- Patch 11 moves counters per-queue and exports packets/bytes/drops
  through netdev_stat_ops. The thirteen existing -S keys stay; no
  hcall_* or pool%d_ keys.

Testing:

ppc64le PowerVM LPAR, MQ-capable firmware:
* ethtool -L cycling (16/1/8/11/1/3/16/8/1) with ping - no hangs
* ethtool -L under iperf3; link down/up during traffic
* ifdown/ifup under iperf3 RX+TX (MQ and ethtool -L rx 1)
* Legacy firmware (no MQ bit): open/close/stress on helper path
* Bisect-safe build and boot at every commit; W=1 clean at tip

Changes in v7:

Same 15 patches as v6. We followed up the v6 netdev-bot review
with replies; this v7 is the series after that, plus a few items
from our own re-review.

* Patch 3: update_rx_no_buffer() returns if buffer_list_addr[0] is
  NULL (the per-queue form stays in patch 10).
* Patch 6: synchronize_net() on the late TX-alloc unwind before RX is
  freed.
* Patch 8: replenish failure log names the wrapper from the filled
  count; advance ring on NULL buffer so poll does not spin.
* Patch 9: oversize bound is min(skb_tailroom, pool->buff_size).
* Patch 10: unregister_netdev before cancel_work_sync and gate reset
  on NETREG_REGISTERED (moved from patch 11); wait for pool kobject
  release before free_netdev(). Drop the probe CMO refresh and the two
  CMO follow-ups: CMO (Power9 and earlier) and MQ firmware (Power11+)
  do not coexist.
* Patch 11: replenish_lock on the close harvest (remove-path
  unregister/cancel reorder moved to patch 10 with the reset producer).
* Patch 12: set_channels() returns -EOPNOTSUPP on rx_count changes until
  patch 14 implements live resize.
* Patch 14: key buffer-list unmap on allocation presence because
  DMA address zero is valid; reject an RX count change while down
  with -EOPNOTSUPP. Failed H_FREE skips unmap and restores the
  surviving count; widen real_num before scale-up unmask. Scale-up
  register -EOPNOTSUPP latches mq_fallback. The scale-up /
  scale-down helper split is code motion only.
* Patch 15: publish the down-path RX count, which lifts patch 14's
  temporary rejection. get_channels max_tx is at least the live
  tx_count, and set_channels uses the same ceiling, so CPU offline
  cannot block an RX-only ethtool -L.
* Commit message / kdoc / comment / debug-log updates on 1, 3, 4, 5,
  7, 8, 9, 10, 11, 12, 14 and 15 (patch 1 also names the new hcalls in the perf
  powerpc-hcalls script and documents H_BUSY on the register-queue
  wrapper; patch 10 prints the register-queue failure with %ld).
* Kept: enable_irq on schedule_prep failure; mask PHYP before
  napi_disable; get_channels reports the live rx_count (no clamp).
* Reopen unwind in patches 3 and 6 is pre-existing. No Fixes: tag
  here. The SQ open-fail path is already on the list as
  [PATCH net 0/2] (Message-ID:
  <cover.1790357373.git.mmc@linux.ibm.com>). This series does
  not depend on it. If both land, keep the helper versions in
  patches 3/4/6; the net pair is the current single-queue path
  only.

Known leftovers (not this series):

* Single-queue: replenish vs free_buffer_pool is not serialized,
  irqsave still covers the whole fill, and close skips
  netpoll_poll_disable. That is a lock-protocol rewrite, not this
  series.
* RX IRQ teardown: teardown masks PHYP, disables NAPI, then masks
  again, but a poll tail that already passed the shutdown checks can
  still re-enable PHYP after that second mask and after free_irq, and
  a mask hcall that failed is never acknowledged. Closing this needs a
  poll/teardown handshake rather than another remask, so the ordering
  is unchanged here.

Changes in v6:

Same 15 patches as v5. Jakub v5 review folded in; per-patch detail is
below --- on each commit.

* Both new registration wrappers use plpar_hcall(), not plpar_hcall9().
* Poll: IPv4 check through skb->data; budget 0 does not complete NAPI.
* Scale-down: publish the surviving count, then synchronize_net(),
  then destroy. num_rx_queues uses smp_store_release / smp_load_acquire.
* packets/bytes/drops through netdev_stat_ops, not private -S strings.
  Thirteen existing -S keys kept. No hcall_* or pool%d_ keys.
  replenish_* are per-queue u64; no atomics. get_base_stats() is the
  retired-queue remainder.
* Reset worker gated on NETREG_REGISTERED (cannot reopen after
  unregister).
* get_channels() keeps the live rx_count; mq_fallback caps max_rx so
  a TX-only ethtool -L is not a silent RX shrink.

Changes in v5:

* Restack mailed v4 (14 patches) to v5 (15):

    v4 1-8  helpers                -> v5 1-8
    (new)   SQ poll harden         -> v5 9   (before MQ enable)
    v4 9    MQ enable              -> v5 10
    v4 10   stats                  -> v5 11
    (new)   get_channels           -> v5 12  (peeled from stats)
    v4 11   debugfs                -> v5 13
    v4 12   resize                 -> v5 14
    v4 13   set_channels           -> v5 15
    v4 14   trailing poll/shutdown -> folded into v5 5/9/10/14
            (mailed "P14" was that trailer, not v5 14)
* Teardown-first resize after aggressive ethtool -L; thin defensive
  poll skip remains; no correlator generation field this series
* opened / rx_irq_setup; set_channels keys on opened (not IFF_UP)
* filter_list_dma=0 on map error; restore default-active 64 KiB pool;
  unwind pools by allocation presence; probe_cleanup clears vio
  drvdata; remove: unregister then cancel_work
* TX quiesce before freeing bounce buffers; guard start_xmit if LTB gone
* MQ H_FUNCTION recovery (reset + SQ fallback); no printk under
  replenish_lock; lock harvest with replenish; resume kicks all queues
* Per-queue update_rx_no_buffer; publish-before-free on resize;
  CMO refresh; IRQ helpers return errno
* Harvest abort (no fake GRO / UAF); poll refuses PHYP re-arm on close;
  wrap-safe skb_put; atomic set_channels; monotonic stats across shrink
* Keep mask -> sync -> napi_disable on teardown; open stays
  request_irq -> napi_enable while PHYP masked; scale-up/recovery keep
  napi_enable before enable_irq
* Pool geometry kept on free; restart_rx_queue after open/scale-down;
  remask after napi_disable; schedule_rx_queue masks only when
  napi_schedule_prep succeeds (STOP + poll no-rearm for storms)

Changes in v4:

Addresses Simon's v3 review and related fixes:
* First-use helpers/includes (irqdomain.h with first dispose); no
  unused statics; dropped orphan open/close pipeline patch
* Open/close unwind (free LAN before RX pools); no double TX teardown
* MQ open: replenish all queues before PHYP unmask; H_FUNCTION on
  subordinate register is a hard open failure
* Resize/set_channels hardenings; stats probe-lifetime + sum-on-read;
  buffer_pools diagnostic on debugfs
* Patch 9: put already-created pool kobjects on probe failure paths
* Patch 14: correlator skip, skb tailroom check, napi_complete_done
  shutdown return < budget
* Bisect-friendly restack (helpers with first use)

Changes in v3:

* Dropped RFC; addressed style / DMA feedback from earlier revisions
* Early MQ enablement iterations (see lore links below)

Comments welcome.

---
v6 lore:
  https://lore.kernel.org/r/cover.1788102125.git.mmc@linux.ibm.com
Sashiko NIPA (v6):
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc@linux.ibm.com
v5 lore:
  https://lore.kernel.org/r/20260814073642.24630-1-mmc@linux.ibm.com
v5 review (Jakub Kicinski):
  https://lore.kernel.org/r/20260818014710.3853684-1-kuba@kernel.org
Sashiko Gemini (sashiko.dev):
  https://sashiko.dev/#/patchset/20260814073642.24630-1-mmc@linux.ibm.com
Sashiko NIPA (v5):
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814073642.24630-1-mmc@linux.ibm.com

Previous versions
v6: https://lore.kernel.org/r/cover.1788102125.git.mmc@linux.ibm.com
v5: https://lore.kernel.org/r/20260814073642.24630-1-mmc@linux.ibm.com
v4: https://lore.kernel.org/r/cover.1785457143.git.mmc@linux.ibm.com
v3: https://lore.kernel.org/r/20260706193603.8039-1-mmc@linux.ibm.com
v2: https://lore.kernel.org/r/20260701222327.61325-1-mmc@linux.ibm.com
v1: https://lore.kernel.org/r/cover.1782758799.git.mmc@linux.ibm.com
v4 review (Jakub Kicinski):
  https://lore.kernel.org/r/20260806183614.3171785-1-kuba@kernel.org
v3 review (Simon Horman):
  https://lore.kernel.org/r/20260714124327.GJ1364329@horms.kernel.org

Mingming Cao (15):
  ibmveth: Add MQ RX hypercall wrappers and call definitions
  ibmveth: Prepare MQ RX adapter data structures
  ibmveth: Refactor RX resource allocation for MQ RX bring-up
  ibmveth: Refactor buffer pool management for per-queue MQ RX
  ibmveth: Refactor RX interrupt control for MQ RX queues
  ibmveth: Refactor TX resource allocation in open/close paths
  ibmveth: Add RX queue register helpers for MQ
  ibmveth: Add queue-aware RX buffer submit helper for MQ
  ibmveth: Harden RX poll path with helpers
  ibmveth: Enable multi-queue RX receive path
  ibmveth: Add per-queue RX and TX statistics collection
  ibmveth: Report MQ-aware RX counts in ethtool get_channels
  ibmveth: Expose per-queue buffer pool details via debugfs
  ibmveth: Implement incremental MQ RX queue resize
  ibmveth: Complete set_channels down-path and mq_fallback max_rx cap

 arch/powerpc/include/asm/hvcall.h           |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c          | 4441 +++++++++++++++----
 drivers/net/ethernet/ibm/ibmveth.h          |  232 +-
 tools/perf/scripts/python/powerpc-hcalls.py |    4 +
 4 files changed, 3921 insertions(+), 762 deletions(-)


base-commit: 161ea2d4f2a7e784f14b5b0548fcef3e05fc34f8
-- 
2.50.1 (Apple Git-155)


