Return-Path: <linuxppc-dev+bounces-25840-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3294C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:38:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGM5M7Yz2y8f;
	Fri, 14 Aug 2026 17:38:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693083;
	cv=none; b=ImMkZogRHnKPkJxXrVbmdWYvekP61/oSIFTUbwrxEKLMfSFReT95cLmHlgsXyfLZFAOiYDYeUpmWUOqinAvrGcDmDOciyLI+sq2CBVEY2/drPrAl1wrCBxvw5l7Yf7JCtaKwgd0HrOTdQGOvn54ZziFoCcSgWXkTqztlKMDlHIKppxAv1+E9e7lfUw2nqhdL2q5x+ngbnYiRuN1Z/G3zOkoOnNp1jGOjT8runmub3tL90m6sJiUwtexszk7OgSKqcb/sEK+r8ijAHmI7vl/4DsTzs+cQqnmegw6Pb4vXu4lzU6PR/vDV8Kz+xyQbt2+MK7sqQRDNZ2MuVulpmD75eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693083; c=relaxed/relaxed;
	bh=KPTcvlaWLvP505fhsgZjJGz61eMPcL1PSLSCbEjT9yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bf/PTy47qtgaBOgQS1SJDRW7mvINY+zDqHkh1yrr6Ef2nWzDmAclIUKMbYRgnPsOHn65rcn9Zw2G3xmXs5TU7H8EAaVbLVMUHjVZJO02Zvx0hb1NK4/RJTz8i2i74lCI96tuo4U5kmkEooIaFzQZnj5c/aGjP+2fCp1yk5H+CWy+WntyiZ1TxVUWNYo8ObV3tGrzpL63/Ekqiduap2QIMeGgkadQVXzWVhvzJKpn+hsA+3Tm+mCqR6wPLI4S4D9CTNS+mfLjCMBf7IcdFORfBTp5awhj6402td/4G6ZZKNke0nZIMY2dsvZ4sCcjjQA9JnHmCub/dqBE2CNzrYK5zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=USNEe2xk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=USNEe2xk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGK6Mbsz2y81
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:00 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Vo6u182958;
	Fri, 14 Aug 2026 07:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KPTcvlaWLvP505fhsgZjJGz61eMPcL1PSLSCbEjT9
	yY=; b=USNEe2xkVFHxAJ+GV/04XiPFE+wYUfka+bPrctMKIHptIpU/L2UI+5nuX
	lN2d/4ogjPVWDM4fOlp3NujFWlAlpHEvgb0ftdq0yJrb6gTOdMdQxpkB9yDUUEJv
	6gYjRDz7bXMNeCSgE1b4cbcn6GLl2gp41c7FW0WggPzfUwn85hJVhlwV2znfFHn9
	/etEbyT+GLREbHHid3pkqSA33Cr1pY3Tyb2YK4bf0Azfvx8h24kt0uxaqo7AhW4b
	7jm3CvMcm0YWwsew/iSP8EPXSZrTKgIjMUzumADT7rvsovJGf2qCb2WKDhqD5UyK
	MYifbNWSab0MHwxb9U+pdoomv94IA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwjmem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:37:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QJRJ013784;
	Fri, 14 Aug 2026 07:37:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv94vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:37:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7bb2o5374702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:37:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F7658057;
	Fri, 14 Aug 2026 07:37:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48D0458058;
	Fri, 14 Aug 2026 07:37:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:37:35 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 00/15] ibmveth: Add multi-queue RX support
Date: Fri, 14 Aug 2026 00:36:27 -0700
Message-Id: <20260814073642.24630-1-mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ec5c7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Kah-MRFPZU9cj4q-DmkA:9
X-Proofpoint-GUID: JVHUhWlKlOOv5Bjm_qT0duPVlku1n35H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX3sWC6MQbAD8p
 gfYtDOh8lW481wKNmLBmoQs7XQh6NDEa7Xk38JJuzjCvQojb5CEQtCYLzBZIaGoyG+KqzRRtHQD
 KDMSys6ZwV4Aiet+3jF3JJ9VxKvkUkvIlm+gEgaJrxFdR5xOzes1TDmI28Qg64OoGu7ZACvVOTr
 K8AX0J8NpO0D2usq7utHwIjHsBT3o0ynPzON7Z8YQi0bqxQYV5IJHKlDbFHi/w1HEJpqtKoK/P2
 ANOHP5LRGAsdYfCnAadi5jdlNAdQkf22V6xxSg6qGG1GGZkvLKUMhrSz26r6sAUbmHgkNSsyHZt
 yjqHOklbzJg9WhGAYILZ9ZPOg048KzG8ccxj9b0FZuwzQ9b/YkpP/CcMe4A0piEBOTVxv7yXNpN
 MrKylZxOJmEb7JyCa8+v1dB4AU4KQCkkTxs8mT8zwNM54gpNAstu1mkGz+WxzAUGh3XnVTYSXUJ
 GdFUjesoTBTTHwMemKg==
X-Proofpoint-ORIG-GUID: s9F6iwW6Bx8mqDg2muxiYjecjGmV4ciR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX5/XfQB90jJKe
 qusj9MGLlUKgF3kqsOtUJsMJzm/TVnsKm/vDubn9/DINY4ezLuFkJq+GFqKu9Azap/lA2rgx6q6
 tm/mmHCzFcA6F8kFg3nsa8vlSmFfyGI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

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

User-visible bits: ethtool -l/-L (channels), ethtool -S and
ndo_get_stats64 (per-queue + aggregate), and a read-only debugfs
buffer_pools dump (v3's multi-line sysfs dump moved to debugfs; the
historical queue-0 poolN/ sysfs ABI is unchanged).

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
  14-15 Incremental RX resize (+ resize_rx_channels); wire ethtool
        set_channels

- Helper patches (3-8) reshape ibmveth_open()/close() into
  queue-aware helpers. Patch 9 hardens the SQ poll path with the same
  queue-index helpers; it does not change open/close. Runtime
  behaviour is unchanged through 3-9: num_rx_queues stays 1 and
  multi_queue is false until patch 10.
- Patch 10 is the switch: probe sets multi_queue from firmware, raises
  num_rx_queues, registers subordinates, and replenishes every active
  queue.
- Statistics types land with first use (hcall_stats in 7, rx/tx qstats
  in 11).

Testing:

ppc64le PowerVM LPAR, MQ-capable firmware:
* ethtool -L cycling (16/1/8/11/1/3/16/8/1) with ping - no hangs
* ethtool -L under iperf3; link down/up during traffic
* ifdown/ifup under iperf3 RX+TX (MQ and ethtool -L rx 1)
* Legacy firmware (no MQ bit): open/close/stress on helper path
* Bisect-friendly restack; W=1 clean at tip

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
Previous versions
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
  ibmveth: Wire ethtool set_channels to MQ RX queue resize

 arch/powerpc/include/asm/hvcall.h  |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c | 3950 ++++++++++++++++++++++------
 drivers/net/ethernet/ibm/ibmveth.h |  218 +-
 3 files changed, 3432 insertions(+), 742 deletions(-)

-- 
2.50.1 (Apple Git-155)


