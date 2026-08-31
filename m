Return-Path: <linuxppc-dev+bounces-26301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F1BC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:08:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXRr55DZz2yCt;
	Tue, 01 Sep 2026 01:08:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188888;
	cv=none; b=biVtLkUX+f0az1A2qyivEuPjMX8am4r6tNDiluskYGplu8Gv5nIwm+Nhs17lCT1HcyjxrGyvN30HFuTHLK9EcBw6CmZMcc2F+KfjZwLe8BWAQfvIuK5+hie+dJg/02avAvsKMIaqBPTSwcpTNnCqmQezNuqvSwv85glcT5UzEc6M5NJkkMBDPyKfM5hTFmgNGGwZMDm3aIkBFZK/PA/02sgbxI37BGP+Uux2i0MXGl7NTNvfbMGI8TLkIQbrCukG2E+g0MRCr0qoYW4Odjgi7Q5xXpfD9pWgRVkZtwVOdqRPuLBylFHH6PhPOR0C7FlW8IIGQXvmqwY4xcI+DJgAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188888; c=relaxed/relaxed;
	bh=LDSa0I+AiaXDNpWeFfTa5cggn1V37zo7/UZeK2Z5Zu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z+xtxfy/WfXF0UPAqQQU7jmxPfdNtKlkDT1Ym7JlRz2RFrHvH/juleGqHi6BKDrW9YShIn3kQ/ata3lktBe8MBgoySmDWBlSQqCEYZDsjQZSyMrECkMQBKdepr1WZGPsG9XpaKNkW6ywyRhpdEsmoaJ/j44h7yJnoKMs68dGjnHGz63SONUZU0cGGIX0OshtufSTuLkKbc+yoejPyx8HAioZSkbwTF9vo1ZXTvjXf6m6kvi+NxH70kyfZYUxCgyxcQ0Xtye2lHyR1Sbg8Mz++rH0YwX3yQhL2c06dOyJERCqYmYeDlUPVOGse5yUUuRHqTrmvYK4qFENbbYp4tap7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AH7Ftw6M; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AH7Ftw6M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXRq25Wcz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:07 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZAh2652869;
	Mon, 31 Aug 2026 15:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=LDSa0I+AiaXDNpWeFfTa5cggn1V3
	7zo7/UZeK2Z5Zu8=; b=AH7Ftw6MXzaja/AnFlAaZhryQwjfmu4FFBZq3cF8PCfc
	wvpi+dCZbRwfI4uGLVaJJiaXJZzwvZQxL1SZiHG5vibIz1Q8XXpMpSQZoJcNyMk+
	rbtnPxtHFhYb6JtJ2i+eknxxjyu12wgafAYTHrRs8nXGwOr5b4xld+Mow35U2LMB
	dsx47vbKlGrCQx2m43ixRA7E2gaiNr8IxRQjPDwqjY2z06Q9238gVr2gJXD8LsIB
	MzQvgt6t7PY8ZF+8lAT11pAMch1Om06EubwnxevEopRreHexkZhhNZh6gBVmaPDK
	NJK4E/U2rUpYcYgBx+GD9zJJ1moKM6wNEjlTnAWiYg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r2331-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:07:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuPg3017174;
	Mon, 31 Aug 2026 15:07:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexxb67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:07:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF7B4v10027562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:07:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5464A58051;
	Mon, 31 Aug 2026 15:07:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647635805E;
	Mon, 31 Aug 2026 15:07:48 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:07:48 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 00/15] ibmveth: Add multi-queue RX support
Date: Mon, 31 Aug 2026 08:07:11 -0700
Message-Id: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9598cd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=9R54UkLUAAAA:8 a=vtar6q14ZexPuHi9m2MA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX0vAiY2PTLUtx
 4ww1OEnlsiDlxxJloushpXGMt0vIHxN5Fhl1Q1M0DJFcT88NJ+Q4dj2LIMaG87wde5eyGzS7My/
 Ka2rmmSdeqG/3Sz+m/ZgYLxMwFnuD1zc+Fl3r2+cepGq6mQLqy28lBUkOPWhBNCAb2aH4etKiHe
 rVVYpHwbqWSbL/Qc6wPPeUcaS5hSqs8SnLS0u5BEWObOM12LNQ7+P7vciKevne7foytJHhZhHyl
 6ObjhhNWEVadAxhZwcZ1kGQ/OZDSULDb8l/MEcZr0vdyhfmq66N2+waxbz8MsqK+NIgYKSYIZ5r
 jwQqHDuCc3tGj/00TqRz4XeufiCm2Y6XLyQIuKi6UDjXhy7L4YknV6d5FWOfZ2sdsiTZr9/lgCG
 8Ai6lMV//pQ7s435edTtxsu2VccUjZO4upk57IQSzX7TBqJT/S2ebiwdVEt1hHcncIsJknzdT4L
 aGXLkq8Qy+rZ2WAvyeA==
X-Proofpoint-GUID: uL1XLpsbdq5KZqM9d1zEKo-iJ4bSxSP9
X-Proofpoint-ORIG-GUID: mlwvULyZIGA5-XgJTxnSRaG9SvJhIr6s
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX22ktZbgN1B0p
 AgPgUd416mrqSZ72DrcqaEXEkam4srxP6pYZ7bY0cILLyDrMXLheBixhcZe2+3xLNaBNVjdxVzN
 +5lwtpuj1Bww7re1xWY3mT9yIG3H27U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

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
* W=1 clean at every commit (15/15 PASS, 0 warnings per-patch and
  in aggregate, ARCH=powerpc ibmveth.o)

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
* Open-fail double-free (d43732ce021f) rides in patches 3 and 6;
  standalone fix to net follows this series.

Known limitations (not this series):

* h_free_logical_lan[_queue] still log-and-continue on non-busy
  failure; fixing requires status propagation through all teardown
  callers. Pre-existing; incremental shrink copies the same path.
* Internal close+open restarts (pool_store, change_mtu) do not call
  netpoll_poll_disable(); pre-existing single-queue behaviour,
  unchanged by this series.
* CMO desired is not recomputed when a down-path set_channels publish
  is never realised (mq_fallback or failed reopen); fixing requires
  recomputing on every path that changes the realised queue count.
* Pool kobject .release is NULL; put then free_netdev() is unsafe
  under CONFIG_DEBUG_KOBJECT_RELEASE. Requires a proper release
  callback; pre-existing pattern.
* ethtool -L TX shrink uses netif_tx_stop_all_queues(), not
  netif_tx_disable(); close() already uses disable. Pre-existing;
  needs its own patch with a Fixes: tag.
* get_desired_dma() TX term is one LTB regardless of TX queue count;
  should scale with real_num_tx_queues. Pre-existing.
* max_tx from num_online_cpus() can fall below a configured tx_count
  after CPU hotplug; pre-existing.

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
v5 lore:
  https://lore.kernel.org/r/20260814073642.24630-1-mmc@linux.ibm.com
v5 review (Jakub Kicinski):
  https://lore.kernel.org/r/20260818014710.3853684-1-kuba@kernel.org
Sashiko Gemini (sashiko.dev):
  https://sashiko.dev/#/patchset/20260814073642.24630-1-mmc@linux.ibm.com
Sashiko NIPA (netdev-ai):
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814073642.24630-1-mmc@linux.ibm.com

Previous versions
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

 arch/powerpc/include/asm/hvcall.h  |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c | 4159 +++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |  227 +-
 3 files changed, 3630 insertions(+), 762 deletions(-)

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.50.1 (Apple Git-155)


