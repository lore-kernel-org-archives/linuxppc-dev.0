Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2760A261C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gAsG5bfo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmt323jgz2ynW;
	Tue, 10 Nov 2026 10:57:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268635;
	cv=none; b=nUuPQ/OJpULCTD4UJF1RMfQ8i8NYQEHU+SYOyBkPgT/xENqH8RjQaAK0jJOWdGhTLOmiIQlof4UOMsL5HkA0dwzFIvIqfLmIDTzNZVw4ZZLW5E36nyCE/7uOVhPLVPxnAZadQlIk+90EaYw0nn6D5qHGEb9fV6YWB7vbYLWVbKg5WZWKoM6whrcnuTgT631VPK1byTkQscl99Bzb/GXa5bQT4Ld+okcuHsgAP0ZnpsenVUlSmyEZqKtlw+cl2jCEuqH62QXmVzVW2VcT/2PWfO6+11Z9jmUHdmPAkNfYcV0oA3lsykr+oD6OugR/3xOzqLrGDhhIt7G2TrAV2Be8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268635; c=relaxed/relaxed;
	bh=zdJmn6pXcpFLTja/bi4efDgvi7PxZm3WBjHJP/d+MoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TH+iX58kD2emcUSCTbbPN6ApS78X410OVHx4RWwREb44UQYI/YDI9s2jANH7PtHEBjnb5b7FweDfoMURZXIkmIlCVnxcTtEBjPmfFkLDt6v+MbhIwLGxu1PYeGgYEHFG0yKGwik9IzAaiTjdIVT4OM2wojd5SwoGk4PJ/wpgurI6+QOtfOS8LsaxDmCbsNaxditcoB6F7nwGSsotYBY79bGlo5yNIPphx4AAIf1Bbyw+MxrDL61F+aBk5jUi2Dqik5xbs12H7vhgLAUxspRYh/0IZ8NRkOah1vLHcwrvO0thSwt8q3SKBxeEEHqHD6cdf01+8WG03jOWJ5Rftpx/lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gAsG5bfo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gAsG5bfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmt04nCwz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:12 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEDRZ3484320;
	Mon, 9 Nov 2026 23:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zdJmn6pXcpFLTja/b
	i4efDgvi7PxZm3WBjHJP/d+MoY=; b=gAsG5bfo8/9CCWP6rP4M9fbD2EC8W6S0i
	1LMHoi8Al/feP+UhBvYfpjkDCr+1fq4IX3Fol6IvuT1egIAJxK0e1AD9wSHRJpk/
	TaIzrMONIpAqGbdc2JD4NmogTcnShijRmGVs0tSgLNYsIGhUhZVi35oOzWete0GD
	wvORvGN8EmVQKf0M9qYvNFoWV0/Vbd6KYsH99q6FHnkRlLxp2GbI+tGndTERGhmV
	UClqHrI/dhqUhp/9x/3JAoxT8/1w6Q70tKnP3EsW1KFTkmQxlkSTJ/1RXvaC5G8Y
	Q7AN2cI1AyUwfx9yXtUedfKm4R00jQ2FDqhoWnkSIxgnrMaJIgBOw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg218e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LK1ko3831314;
	Mon, 9 Nov 2026 23:56:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg43y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nuucr17891880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A14E5805C;
	Mon,  9 Nov 2026 23:56:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2BAD58028;
	Mon,  9 Nov 2026 23:56:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:51 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 10/15] ibmveth: Enable multi-queue RX receive path
Date: Mon,  9 Nov 2026 15:55:51 -0800
Message-Id: <20261109235556.60604-11-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af25dcb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DRCtPgE_f9mrDKYUtR4A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX1iRd3nmfgZrF
 HFkGyzTYVPoaPL4qpqtjEgenSml/yY0YkRmHibXQyTfqbMxZsWhyfjrqqENhsce6D2YRRJJhImM
 Kf2MMzubnZLlQdXiJSPul4jyVR9Lag/WwAMhXhJClVubku6x5mjwBeaS67Y92//u8ItnPPAis4j
 OiHYlDasYxdDNfTSSrQYlaW5pWnvIfkL/AiYYri56enZljVtZUMAVL2SFZehx4XJzFHrpRQ+xnb
 G9wD8cblJKndIHZGboJnEowhbAEl4VYrgQ2HQpCkahozUBeLaPTT+pxf5JO4xPlLzqnt514w7Ka
 p7IxyQz8PVBhYiPWKT/drkjpvlrqSKJokQbDOGFhhIIaoRc+iot17hvPSMcp953KGh7UViILwU+
 P8HkBW/JEIgfUTWi2xAUeqRtnESvLZySRNKMaTzehj0kuIlpA9+qxzjDcZMNbyuRm4D3k2oGcVH
 3mXDEtC5r+A+UIlXyLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXzRnoIb33hZCS
 XaUCs7nyHgktxJFXNufpL46XbUSvkkyiL4TlfrdS0A9+l7s69uv356s0UXlTi5RlbVR9UVH2fa+
 BRcDazUNx9Bh8AD0i0aH/5EicreHM9o=
X-Proofpoint-GUID: ap9-c8cb88mEUL2SjjF7zPbYfVAypuvM
X-Proofpoint-ORIG-GUID: 9pXO3g4b7kdjCeFP4mSlIv1jaatsMGA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Turn on multi-queue RX when firmware sets
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES. The
earlier patches made every RX path take a queue index; this one
supplies queues 1..N:

  - probe: set multi_queue and publish min(num_online_cpus(),
    IBMVETH_DEFAULT_QUEUES) live queues, matching the TX default
    (cap 8). IBMVETH_MAX_RX_QUEUES goes from 1 to 16, so every array
    sized by it grows; the netdev is allocated with that many RX
    queues and one NAPI each, and real_num_rx_queues is set before
    register_netdev(). MQ firmware also raises the replenish batch
    from 8 to 12 buffers per hcall (IBMVETH_MAX_RX_PER_HCALL).
  - open: register queue 0 and subordinates 1..N, set real_num after
    registration, post buffers to every queue, request IRQs and enable
    NAPI; MQ setup with more than one live queue unmasks PHYP before
    kicking each queue, while SQ
    leaves PHYP masked until poll or restart kicks NAPI (per queue).
  - receive: each queue's interrupt schedules only its own NAPI;
    poll uses that queue's ring, pools and replenish_lock, and tags
    each skb with skb_record_rx_queue() for RPS/RFS.
  - teardown: one H_FREE_LOGICAL_LAN drops every queue.
  - fallback: H_FUNCTION from subordinate register or buffer add
    latches mq_fallback, and the next open comes up single-queue.

Without the firmware bit, behaviour stays single-queue.

num_rx_queues is read through ibmveth_get_num_rx_queues()
(smp_load_acquire) and written through ibmveth_publish_num_rx_queues()
(smp_store_release), so a lockless IRQ, poll or replenish reader that
sees a count also sees the per-queue state behind it. multi_queue
becomes a bool, now that it is a flag and not a count.

Queue 0 keeps netdev->irq and netdev->name in /proc/interrupts and
is never disposed with the subordinates; queue N is named
ibmveth-<unit address>-rxN, as ibmvnic names its sub-CRQs.

Each RX queue gets its own copy of the active buffer pools, so RX
buffer memory and IOMMU mappings scale linearly with num_rx_queues:
N queues use N times the single-queue footprint, eight times by
default on a partition with eight or more CPUs. ethtool -L lowers
it. get_desired_dma() accounts for the mappings (see below).

This commit rejects an ethtool -L that changes rx_count. Later patches
implement live RX set, the down-path publish/rollback, and the max_rx
cap once mq_fallback latches.

Restate open() here:

  ... register_rx_queues / set_real_num_rx_queues ...
  replenish_task() for every live RX queue   (before IRQ setup)
  setup_rx_interrupts()                      (MQ with num>1 unmasks PHYP)
  restart_rx_queue() for every live queue    (schedule NAPI; a poll
                                             already queued unmasks)
  ... alloc_tx_resources / tx_start / opened ...

That path is the same for SQ and MQ; it replaces the prior
setup-then-schedule_rx_queue(0) kick. resume() likewise kicks every
live RX queue rather than only queue 0, and each delivered skb is
tagged with skb_record_rx_queue() so RPS/RFS see the queue it
arrived on. close() keeps its order but skips the frees when
free_all_queues() fails (below).

H_FUNCTION means firmware withdrew MQ. Both the subordinate-register
and the buffer-add path latch mq_fallback, so the next open comes up
single-queue (apply_mq_fallback at open entry). That helper publishes
1 and sets real_num to match, caps rx_buffers_per_hcall back to
IBMVETH_MAX_RX_REGULAR (8) for the legacy hcall, so a failed open
after it does not leave real_num at N. The two H_FUNCTION sites
differ in what happens to the open in progress. Register fails it
outright rather than dropping to
single-queue silently mid-open, and buffer-add schedules a reset.
Reset does not retry if that close/open fails.
Both setup failure paths dispose subordinate virq mappings before
unwinding registration.

A poolN kobject that fails kobject_init_and_add() now fails probe;
the base driver ignored the error and probed without that sysfs node.
The failed kobject is put and its release() waited for on the spot,
and ibmveth_put_pool_kobjs() takes the number of pools added so far.

get_desired_dma() sizes RX from queue-0 pool metadata across
num_rx_queues. CMO (Power9 and earlier) and MQ firmware (Power11+)
do not coexist, so probe does not refresh CMO desired and a CMO
partition keeps its single-queue default.

remove() already disables the reset work before unregister_netdev().
Per-queue RX and TX statistics land in the next patch. Until then MQ
reuses the adapter-wide counter fields used on the single-queue path.
Those fields now have one writer per queue, so the RX and replenish
counters can lose increments when several NAPI polls run at once,
and rx_no_buffer reports the buffer-list page sampled last.

On subordinate register failure, honor H_FREE_LOGICAL_LAN: if that
hard-fails, ibmveth_free_all_queues() returns -EIO,
register_rx_queues() reports it through @skip_unmap, and open() skips
the unmap even when queue_handle[0] is 0, since handle 0 is a valid
PHYP cookie. The buffer pool arrays are still freed on that path: no
buffer is posted before registration, so PHYP never saw them.

The same skip applies after buffers are posted: open() post-register
unwind and close() skip DMA unmap when free_all_queues() returns
-EIO, which it does before clearing queue_registered[]. ndo_stop
still returns 0. The next open() and remove() retry
H_FREE_LOGICAL_LAN before a new allocation or free_netdev(), and
release the old memory once it succeeds. If the retry in remove()
fails too, the memory is leaked rather than unmapped under PHYP, and
remove() says so. That relies on CMO and MQ firmware not coexisting
(above): on a CMO partition the leaked entitlement would BUG() at
remove.

That deferred free walks queue 0's pools with pool->size and
pool->buff_size, so a poolN sysfs write returns -EBUSY while the old
pools are still mapped, after reopening a running device so the free
is retried with the old geometry; if that reopen fails, its error is
returned instead. A write whose reopen with the new geometry fails
keeps that geometry if the new pools stay mapped, for the same
reason. free_tx_resources() walks every TX LTB slot rather
than real_num_tx_queues, since an ethtool -L while down can lower
real_num_tx_queues under LTBs that are still mapped.

Only MQ adapters get -EIO, and not for H_PARAMETER (already free).
Single-queue adapters keep what close() did before this series: log
the failure and unmap. Keeping that memory mapped instead is not a
drop-in change there; one reason is that on a CMO partition
vio_cmo_bus_remove() BUG()s on outstanding IO entitlement at remove.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- MQ hard H_FREE_LOGICAL_LAN failure (not H_PARAMETER) keeps the LAN
  memory mapped: register failure, the open() unwind and close() skip
  the unmap; the next open() and remove() retry and then free it
  (remove() leaves it mapped if that fails); poolN writes return -EBUSY
  meanwhile, and a write whose reopen fails keeps the new geometry
  if its pools stay mapped. Single queue keeps the base log-and-unmap
- free_tx_resources() walks every TX LTB slot
- apply_mq_fallback() sets real_num to 1; set_channels rejects an
  rx_count change until the resize patch
- restart_rx_queue() does not unmask PHYP when napi_schedule_prep()
  fails
- subordinate IRQs are named ibmveth-<unit>-rxN; queue 0 keeps
  netdev->name
- a probe kobject_init_and_add() failure puts only the pool kobjects
  already added (pools_ready)
- commit message: RX counters stay adapter-wide until the next patch;
  remove() relies on CMO and MQ firmware not coexisting

Dropped from this series (merged fixes own them):
- commit 8d9ecac6b96e: poll_controller per-queue loop (ndo removed)
- commit 141223544786: remove unregister/cancel reorder and reset gate
  text (in base)
- commit fd052c6823b3: pool kobject release/wait hunks and probe
  message paragraph (in base; pools_ready unwind added here)
- commit 3f872b34368c: extra open() poll wait (err_disable_napi in P05)

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

 drivers/net/ethernet/ibm/ibmveth.c | 681 ++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |   7 +-
 2 files changed, 579 insertions(+), 109 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b12bfa1e485e..a0c3c06d2b9d 100644
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
@@ -489,22 +511,45 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
 {
 	int i;
 
-	for (i = 1; i < adapter->num_rx_queues; i++)
+	for (i = 1; i < ibmveth_get_num_rx_queues(adapter); i++)
 		ibmveth_dispose_subordinate_irq_mapping(adapter, i);
 }
 
+/**
+ * ibmveth_queue_irq_name - Name for one RX queue's Linux IRQ
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: RX queue index
+ *
+ * Queue 0 keeps netdev->name, as before multi-queue. Subordinate queues
+ * use "ibmveth-<unit address>-rx<N>", which survives a rename.
+ * request_irq() keeps the pointer, so the string lives in the adapter.
+ *
+ * Return: the name to pass to request_irq()
+ */
+static const char *ibmveth_queue_irq_name(struct ibmveth_adapter *adapter,
+					  int queue_idx)
+{
+	char *name = adapter->queue_irq_name[queue_idx];
+
+	if (!queue_idx)
+		return adapter->netdev->name;
+
+	snprintf(name, sizeof(adapter->queue_irq_name[0]), "ibmveth-%x-rx%d",
+		 adapter->vdev->unit_address, queue_idx);
+	return name;
+}
+
 /**
  * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
  * @adapter: ibmveth adapter structure
  *
- * Registers interrupt handlers for all RX queues, enables NAPI, then
- * enables hypervisor interrupt delivery for multi-queue mode after
- * every queue has a Linux handler installed. For multi-queue open the
- * caller should replenish RX buffers before this helper so traffic
- * during open is not dropped (PHYP only interrupts after a successful
- * enqueue, which needs buffers). Single-queue open leaves PHYP masked
- * here and kicks NAPI afterward (classic path: first poll posts then
- * enables).
+ * Registers interrupt handlers for all RX queues, enables NAPI, then,
+ * in multi-queue mode with more than one live queue, enables
+ * hypervisor interrupt delivery after every queue has a Linux handler
+ * installed. The caller replenishes every live queue before this
+ * helper so traffic during open is not dropped (PHYP only interrupts
+ * after a successful enqueue, which needs buffers). With one queue
+ * PHYP stays masked here; restart_rx_queue then kicks NAPI.
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -512,7 +557,7 @@ static int
 ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int i, rc, num = adapter->num_rx_queues;
+	int i, rc, num = ibmveth_get_num_rx_queues(adapter);
 
 	for (i = 0; i < num; i++) {
 		if (!adapter->queue_irq[i]) {
@@ -522,7 +567,8 @@ ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 		}
 
 		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
-				 0, netdev->name, &adapter->napi[i]);
+				 0, ibmveth_queue_irq_name(adapter, i),
+				 &adapter->napi[i]);
 		if (rc) {
 			netdev_err(netdev,
 				   "request_irq() failed for irq 0x%x queue %d: %d\n",
@@ -606,26 +652,26 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
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
 
 	synchronize_net();
 
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
@@ -654,7 +700,7 @@ static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
 {
 	struct napi_struct *napi = &adapter->napi[qindex];
 
-	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
+	if (WARN_ON(qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter)))
 		return;
 
 	/*
@@ -758,6 +804,7 @@ static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
 	if (adapter->multi_queue) {
 		unsigned long buffersznum = (buff_size << 32) | filled;
 		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
+		/* PHYP queue handle; 0 can be valid. */
 		unsigned long handle = adapter->queue_handle[queue_index];
 		int i;
 
@@ -1002,15 +1049,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
@@ -1026,10 +1079,10 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
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
 
@@ -1067,7 +1120,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	}
 
 out_unlock:
-	ibmveth_update_rx_no_buffer(adapter);
+	ibmveth_update_rx_no_buffer(adapter, queue_index);
 
 	spin_unlock_bh(&rxq->replenish_lock);
 
@@ -1081,6 +1134,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 		dev_err_ratelimited(&adapter->netdev->dev,
 				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
 				    queue_index, fail.batch);
+		adapter->mq_fallback = true;
 		schedule_work(&adapter->work);
 	}
 
@@ -1101,6 +1155,27 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 				     fail_hcall.batch);
 }
 
+/**
+ * ibmveth_restart_rx_queue - Post buffers and ensure Q can take RX
+ * @adapter: ibmveth adapter
+ * @qindex: RX queue index
+ *
+ * SQ open leaves PHYP masked until the first poll, so every queue needs
+ * a NAPI run. Callers enable NAPI first, so napi_schedule_prep() fails
+ * only when a poll is already scheduled. That poll unmasks PHYP when it
+ * completes, so do not unmask here: while NAPI is scheduled the handler
+ * cannot remask, and PHYP would interrupt once per frame. Replenish
+ * first so the queue has buffers to deliver into.
+ * Also used after every open (SQ and MQ) so a queue is not left
+ * idle+masked.
+ */
+static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
+				     int qindex)
+{
+	ibmveth_replenish_task(adapter, qindex);
+	ibmveth_schedule_rx_queue(adapter, qindex);
+}
+
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
 static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 				     struct ibmveth_buff_pool *pool)
@@ -1248,7 +1323,7 @@ ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 	int i, q, rc;
 
 	/* Initialize pool metadata for queues 1..N from queue 0 settings */
-	for (q = 1; q < adapter->num_rx_queues; q++) {
+	for (q = 1; q < ibmveth_get_num_rx_queues(adapter); q++) {
 		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 			struct ibmveth_buff_pool *src =
 				&adapter->rx_buff_pool[0][i];
@@ -1264,7 +1339,7 @@ ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 	}
 
 	/* Allocate actual buffers for all queues */
-	for (q = 0; q < adapter->num_rx_queues; q++) {
+	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
 		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
 		if (rc) {
 			/* Free pools for all previous queues */
@@ -1275,7 +1350,7 @@ ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
 	}
 
 	netdev_dbg(netdev, "allocated buffer pools for %u queue(s)\n",
-		   adapter->num_rx_queues);
+		   ibmveth_get_num_rx_queues(adapter));
 	return 0;
 }
 
@@ -1291,11 +1366,11 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 	int q;
 
 	/* Free buffer pools for all queues */
-	for (q = 0; q < adapter->num_rx_queues; q++)
+	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++)
 		ibmveth_free_queue_buffer_pools(adapter, q);
 
 	netdev_dbg(adapter->netdev, "freed buffer pools for %u queue(s)\n",
-		   adapter->num_rx_queues);
+		   ibmveth_get_num_rx_queues(adapter));
 }
 
 /* The correlator comes back from PHYP, so check it rather than trust it.
@@ -1544,17 +1619,19 @@ static int ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
 }
 
 /**
- * ibmveth_free_tx_resources - Free TX LTBs for real_num_tx_queues
+ * ibmveth_free_tx_resources - Free every allocated TX LTB
  * @adapter: ibmveth adapter structure
  *
- * Frees TX Long Term Buffers (LTBs) for real_num_tx_queues.
+ * Walks IBMVETH_MAX_QUEUES, not real_num_tx_queues. An ethtool -L
+ * while down can shrink real_num while skip-unmap close left bounce
+ * buffers mapped; stopping the walk at real_num would skip those
+ * slots. ibmveth_free_tx_ltb() is a no-op on a NULL slot.
  */
 static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 {
-	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	for (i = 0; i < netdev->real_num_tx_queues; i++)
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
 		ibmveth_free_tx_ltb(adapter, i);
 }
 
@@ -1621,6 +1698,163 @@ static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
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
+		ibmveth_set_rx_queue_handle(adapter, queue_index, handle);
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
+static bool ibmveth_lan_resources_live(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	if (adapter->filter_list_addr)
+		return true;
+	if (adapter->tx_ltb_ptr[0])
+		return true;
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
+		if (adapter->queue_registered[i])
+			return true;
+		if (adapter->buffer_list_addr[i])
+			return true;
+	}
+	return false;
+}
+
+static void ibmveth_release_lan_resources(struct ibmveth_adapter *adapter)
+{
+	ibmveth_free_tx_resources(adapter);
+	ibmveth_free_buffer_pools(adapter);
+	ibmveth_cleanup_rx_resources(adapter);
+	ibmveth_free_filter_list(adapter);
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -1630,17 +1864,25 @@ static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
  * it. Incremental scale-down uses H_FREE_LOGICAL_LAN_QUEUE per queue
  * instead; do not use this helper for partial live-set shrink.
  *
- * Used by close() and the post-register open() unwind.
+ * Used by close(), the open() unwind and retry, and remove().
  *
- * Retries only H_BUSY and H_IS_LONG_BUSY. On other failures, logs and
- * returns; callers cannot observe hypercall status. Registered slots
- * are cleared regardless. Callers still run RX pool and DMA teardown
- * afterward (same as pre-helper close()).
+ * Retries only H_BUSY and H_IS_LONG_BUSY. Other failures are logged.
+ * In multi-queue mode a failure other than H_PARAMETER (already free)
+ * is fail-before-start: PHYP may still DMA into the LAN memory, so
+ * return -EIO with the slots still registered. The caller skips the
+ * unmap, and the next open() or remove() retries. Single-queue mode
+ * keeps what close() always did, log and let the caller unmap; one
+ * reason it cannot simply keep the memory mapped is that on a CMO
+ * partition vio_cmo_bus_remove() BUG()s on an outstanding entitlement.
  *
- * Clears registered flags and cookies of queues [0, num_rx_queues);
- * queue_irq[] is released by ibmveth_cleanup_rx_interrupts().
+ * On return 0, clears registered flags and cookies of queues
+ * [0, num_rx_queues); queue_irq[] is released by
+ * ibmveth_cleanup_rx_interrupts() on close, or by
+ * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
+ *
+ * Return: 0 if the caller may unmap, -EIO if it must not
  */
-static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+static int ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 {
 	unsigned long lpar_rc;
 	int i;
@@ -1654,29 +1896,45 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 	if (lpar_rc != H_SUCCESS) {
 		netdev_err(adapter->netdev,
 			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+		if (lpar_rc != H_PARAMETER && adapter->multi_queue)
+			return -EIO;
 	}
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
 		ibmveth_clear_rx_queue_handle(adapter, i);
+
+	return 0;
 }
 
 /**
  * ibmveth_register_rx_queues - Register RX queues with hypervisor
  * @adapter: ibmveth adapter structure
  * @mac_address: MAC address for device registration
+ * @skip_unmap: set when H_FREE_LOGICAL_LAN hard-fails after a
+ *              subordinate register error so open() will not unmap
+ *              pages PHYP still owns (handle 0 is a valid cookie;
+ *              queue_registered[] is the live-slot flag)
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
-ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
+ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address,
+			   bool *skip_unmap)
 {
 	struct net_device *netdev = adapter->netdev;
 	union ibmveth_buf_desc rxq_desc;
 	unsigned long lpar_rc;
-	int rc;
+	unsigned int num;
+	int i, rc;
+
+	if (skip_unmap)
+		*skip_unmap = false;
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 				    adapter->rx_queue[0].queue_len;
@@ -1701,9 +1959,77 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
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
+	/*
+	 * Honor H_FREE. A hard-fail is fail-before-start: open()
+	 * must skip unmap even if queue 0's handle is 0.
+	 */
+	if (ibmveth_free_all_queues(adapter)) {
+		if (skip_unmap)
+			*skip_unmap = true;
+		return rc;
+	}
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
+ * single-queue decision permanent for this device. Publish 1 and set
+ * real_num to match so a later alloc fail cannot leave real_num at N.
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
+	if (netif_set_real_num_rx_queues(netdev, 1))
+		netdev_err(netdev, "failed to set number of rx queues\n");
+	if (adapter->rx_buffers_per_hcall > IBMVETH_MAX_RX_REGULAR)
+		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 }
 
 static int ibmveth_open(struct net_device *netdev)
@@ -1711,6 +2037,7 @@ static int ibmveth_open(struct net_device *netdev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
 	int rxq_entries = 1;
+	bool skip_unmap = false;
 	int rc;
 	int i;
 
@@ -1721,6 +2048,23 @@ static int ibmveth_open(struct net_device *netdev)
 	 */
 	netif_tx_disable(netdev);
 
+	/*
+	 * close() may have skipped unmap on H_FREE fail-before-start.
+	 * Retry before apply_mq_fallback so the live count still
+	 * matches the mapped set, and before a new alloc overwrites
+	 * those pages.
+	 */
+	if (ibmveth_lan_resources_live(adapter)) {
+		if (ibmveth_free_all_queues(adapter)) {
+			netdev_err(netdev,
+				   "h_free_logical_lan still failing; LAN remains registered\n");
+			return -EIO;
+		}
+		ibmveth_release_lan_resources(adapter);
+	}
+
+	ibmveth_apply_mq_fallback(adapter);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
@@ -1747,16 +2091,38 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_queue_mem;
 	}
 
-	rc = ibmveth_register_rx_queues(adapter, mac_address);
-	if (rc)
+	rc = ibmveth_register_rx_queues(adapter, mac_address, &skip_unmap);
+	if (rc) {
+		if (skip_unmap) {
+			/* Nothing is posted yet: PHYP never saw the pools. */
+			ibmveth_free_buffer_pools(adapter);
+			goto out;
+		}
 		goto out_free_buffer_pools;
+	}
+
+	rc = netif_set_real_num_rx_queues(netdev,
+					  ibmveth_get_num_rx_queues(adapter));
 
-	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
 	if (rc) {
 		netdev_err(netdev, "failed to set number of rx queues\n");
 		goto out_unregister_queues;
 	}
 
+	/*
+	 * Post buffers before setup_rx_interrupts(). With more than one
+	 * live queue, MQ setup then unmasks PHYP; otherwise PHYP stays
+	 * masked. Scheduling NAPI only when a descriptor is already
+	 * pending is not enough: after ifdown/up
+	 * (RX=8, no -L) NAPI can be idle with nothing pending and the
+	 * queue stays dead (TX OK, ARP/RX fail).
+	 * restart_rx_queue() replenishes and schedules NAPI.
+	 */
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
+		netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
+		ibmveth_replenish_task(adapter, i);
+	}
+
 	/* Enables NAPI, so everything ibmveth_poll() touches must exist:
 	 * netpoll during the direct close()/open() pairs, or a direct
 	 * kick, can run it as soon as it is enabled.
@@ -1765,8 +2131,8 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_all_queues; /* setup already disposed IRQs */
 
-	netdev_dbg(netdev, "initial replenish cycle\n");
-	ibmveth_schedule_rx_queue(adapter, 0);
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+		ibmveth_restart_rx_queue(adapter, i);
 
 	rc = ibmveth_alloc_tx_resources(adapter);
 	if (rc)
@@ -1791,7 +2157,8 @@ static int ibmveth_open(struct net_device *netdev)
 out_unregister_queues:
 	ibmveth_dispose_subordinate_irq_mappings(adapter);
 out_free_all_queues:
-	ibmveth_free_all_queues(adapter);
+	if (ibmveth_free_all_queues(adapter))
+		goto out;
 out_free_buffer_pools:
 	ibmveth_free_buffer_pools(adapter);
 out_free_queue_mem:
@@ -1805,6 +2172,7 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	int i;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -1820,13 +2188,12 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_cleanup_rx_interrupts(adapter);
 
-	ibmveth_free_all_queues(adapter);
-	ibmveth_update_rx_no_buffer(adapter);
-	/* netif_tx_disable() above keeps xmit off the TX LTBs. */
-	ibmveth_free_tx_resources(adapter);
-	ibmveth_free_buffer_pools(adapter);
-	ibmveth_cleanup_rx_resources(adapter);
-	ibmveth_free_filter_list(adapter);
+	if (!ibmveth_free_all_queues(adapter)) {
+		for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+			ibmveth_update_rx_no_buffer(adapter, i);
+		/* netif_tx_disable() above keeps xmit off the TX LTBs. */
+		ibmveth_release_lan_resources(adapter);
+	}
 
 	netdev_dbg(netdev, "close complete\n");
 
@@ -2135,6 +2502,14 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i, alloc_rc = 0;
 
+	/*
+	 * RX channel resize is implemented later; reject any request
+	 * that changes rx_count. Read-modify-write TX adjustments
+	 * submit the current rx_count and proceed.
+	 */
+	if (channels->rx_count != ibmveth_get_num_rx_queues(adapter))
+		return -EOPNOTSUPP;
+
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
 	 * netdev_queue's and return
@@ -2677,6 +3052,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 		ibmveth_rx_csum_helper(skb, adapter);
 	}
 
+	skb_record_rx_queue(skb, queue_index);
 	napi_gro_receive(napi, skb);
 
 	netdev->stats.rx_packets++;
@@ -2695,7 +3071,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	queue_index = napi - adapter->napi;
 
 	if (WARN_ON(queue_index < 0 ||
-		    queue_index >= adapter->num_rx_queues)) {
+		    queue_index >= ibmveth_get_num_rx_queues(adapter))) {
 		if (budget)
 			napi_complete_done(napi, 0);
 		return 0;
@@ -2795,10 +3171,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 
 	qindex = napi - adapter->napi;
 	/*
-	 * Quiet on out-of-range: teardown can leave a residual IRQ after the
-	 * live count drops. Do not WARN-storm; return IRQ_NONE until free_irq.
+	 * Quiet on out-of-range: a live-count shrink publishes the lower
+	 * count before free_irq(). A residual IRQ must not WARN-storm;
+	 * return IRQ_NONE until the handler is removed.
 	 */
-	if (qindex < 0 || qindex >= adapter->num_rx_queues)
+	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
 		return IRQ_NONE;
 
 	ibmveth_schedule_rx_queue(adapter, qindex);
@@ -2917,8 +3294,7 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
 	unsigned long ret;
-	int i;
-	int rxqentries = 1;
+	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -2928,23 +3304,38 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
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
@@ -3025,24 +3416,26 @@ static void ibmveth_pool_kobj_release(struct kobject *kobj)
 /**
  * ibmveth_put_pool_kobjs - Drop the pool kobjects and wait for release
  * @adapter: ibmveth adapter
+ * @pools_ready: number of queue-0 pool kobjects that were added
  *
  * With CONFIG_DEBUG_KOBJECT_RELEASE the cleanup, including removing the
  * sysfs files, runs later from a work item in the kobject; wait for it
  * so free_netdev() cannot free the pools first.
  */
-static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter)
+static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
+				   int pools_ready)
 {
 	int i;
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+	for (i = 0; i < pools_ready; i++)
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+	for (i = 0; i < pools_ready; i++)
 		wait_for_completion(&adapter->rx_buff_pool[0][i].released);
 }
 
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
-	int rc, i, mac_len;
+	int rc, i, mac_len, pools_ready = 0;
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter;
 	unsigned char *mac_addr_p;
@@ -3077,7 +3470,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		return -EINVAL;
 	}
 
-	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter), IBMVETH_MAX_QUEUES, 1);
+	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter),
+				    IBMVETH_MAX_QUEUES, IBMVETH_MAX_RX_QUEUES);
 	if (!netdev)
 		return -ENOMEM;
 
@@ -3099,7 +3493,9 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		netif_napi_add_weight(netdev, &adapter->napi[i],
+				      ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -3131,16 +3527,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
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
@@ -3158,16 +3568,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
-		int error;
 
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 		init_completion(&adapter->rx_buff_pool[0][i].released);
-		error = kobject_init_and_add(kobj, &ktype_veth_pool,
-					     &dev->dev.kobj, "pool%d", i);
-		if (!error)
-			kobject_uevent(kobj, KOBJ_ADD);
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
+			goto err_put_pools;
+		}
+
+		pools_ready++;
+		kobject_uevent(kobj, KOBJ_ADD);
 	}
 
 	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
@@ -3177,6 +3598,21 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 			   rc);
 		goto err_put_pools;
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
+		goto err_put_pools;
+	}
+
 	adapter->tx_ltb_size = PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE);
 	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
 		adapter->tx_ltb_ptr[i] = NULL;
@@ -3198,7 +3634,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	return 0;
 
 err_put_pools:
-	ibmveth_put_pool_kobjs(adapter);
+	ibmveth_put_pool_kobjs(adapter, pools_ready);
 	free_netdev(netdev);
 	return rc;
 }
@@ -3210,10 +3646,18 @@ static void ibmveth_remove(struct vio_dev *dev)
 
 	disable_work_sync(&adapter->work);
 
-	ibmveth_put_pool_kobjs(adapter);
+	ibmveth_put_pool_kobjs(adapter, IBMVETH_NUM_BUFF_POOLS);
 
 	unregister_netdev(netdev);
 
+	if (ibmveth_lan_resources_live(adapter)) {
+		if (ibmveth_free_all_queues(adapter))
+			dev_err(&dev->dev,
+				"h_free_logical_lan still failing at remove; leaking LAN buffers\n");
+		else
+			ibmveth_release_lan_resources(adapter);
+	}
+
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
 }
@@ -3255,8 +3699,11 @@ static ssize_t veth_pool_show(struct kobject *kobj,
  * Return:
  * * %-EPERM  - Not allowed to disabled all MTU-sized buffer pools
  * * %-EINVAL - New pool size or buffer size is out of range
+ * * %-EBUSY  - The old pools are still mapped after a failed
+ *              H_FREE_LOGICAL_LAN; nothing was changed
  * * count    - Return count for success
- * * other    - Return value from a failed ibmveth_open call
+ * * other    - Return value from a failed ibmveth_open call; the new
+ *              geometry stays if that left its pools mapped
  */
 static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 			       const char *buf, size_t count)
@@ -3338,6 +3785,18 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 		if (netif_running(netdev))
 			ibmveth_close(netdev);
 
+		/* close() keeps the pools mapped when H_FREE_LOGICAL_LAN
+		 * fails; open() or remove() frees them later with
+		 * pool->size and pool->buff_size, so the geometry must not
+		 * change until they are gone.
+		 */
+		if (ibmveth_lan_resources_live(adapter)) {
+			rc = -EBUSY;
+			if (netif_running(netdev))
+				rc = ibmveth_open(netdev) ?: -EBUSY;
+			goto unlock_err;
+		}
+
 		pool->active = newactive;
 		pool->buff_size = newbuff_size;
 		pool->size = newsize;
@@ -3345,9 +3804,14 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 		if (netif_running(netdev)) {
 			rc = ibmveth_open(netdev);
 			if (rc) {
-				pool->active = oldactive;
-				pool->buff_size = oldbuff_size;
-				pool->size = oldsize;
+				/* A failed open() can keep the new pools
+				 * mapped; their free needs this geometry.
+				 */
+				if (!ibmveth_lan_resources_live(adapter)) {
+					pool->active = oldactive;
+					pool->buff_size = oldbuff_size;
+					pool->size = oldsize;
+				}
 				goto unlock_err;
 			}
 		}
@@ -3363,7 +3827,6 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	return rc;
 }
 
-
 #define ATTR(_name, _mode)				\
 	struct attribute veth_##_name##_attr = {	\
 	.name = __stringify(_name), .mode = _mode,	\
@@ -3396,8 +3859,12 @@ static int ibmveth_resume(struct device *dev)
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
index bdc8ea7069ec..393d37add10c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -31,6 +31,7 @@
 #define IbmVethMcastRemoveFilter     0x2UL
 #define IbmVethMcastClearFilterTable 0x3UL
 
+#define IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT	0x0000000000080000UL
 #define IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT	0x0000000000040000UL
 #define IBMVETH_ILLAN_LRG_SR_ENABLED	0x0000000000010000UL
 #define IBMVETH_ILLAN_LRG_SND_SUPPORT	0x0000000000008000UL
@@ -270,7 +271,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
-#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_MAX_RX_QUEUES 16U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_REGULAR 8U
 #define IBMVETH_MAX_RX_PER_HCALL 12U
@@ -330,8 +331,10 @@ struct ibmveth_adapter {
 	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
 	bool queue_registered[IBMVETH_MAX_RX_QUEUES];
 	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
-	int multi_queue;
+	char queue_irq_name[IBMVETH_MAX_RX_QUEUES][32];
+	bool multi_queue;
 	unsigned int num_rx_queues;
+	bool mq_fallback;
 	/* Lifetime: true while RX IRQ handlers / NAPI are installed. */
 	bool rx_irq_setup;
 	int rx_csum;
-- 
2.50.1 (Apple Git-155)


