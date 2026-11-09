Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A520606A335
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ShXUyOsu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmss54xjz2yYY;
	Tue, 10 Nov 2026 10:57:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268625;
	cv=none; b=HuDioz0IIw0hNV4wsxG+ldvBmf8btGUS1YA9XulrorrVde9h+L9VUo2+zm7DJjIWPh7C3PRdrcQuYgJIODTmFVjUhaboXTsLjFsgmyeJZdC+1JGPsdvsxS2j9/1Heq7ToHnPcWOdvyH07UMrSpSXaJXblTKuIXdPIqm+UWioh/5F2NCiYBZVX5xfyX7Qa07dkNjbu1K7iNAILt747N+KTLEoYoMVs+1Zo9+oz67A6JcOVDfqbGT5HdnYHz4TkhpF8kdsKheaFO59pxA4H2Z5wQ4GJslS81beXDr5rHdVrNx49Iwm7Rn+1lNAQVESie4a87pVaxlTa6f13ZpWhDu+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268625; c=relaxed/relaxed;
	bh=xKG7lGqE5BGaoQatufUXEBO5YquInkO+s2UOLZMdnZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSbFcSkPj6UYeEvFRXjv53fsghbzKbBNWvT1eihRvIbvK567i526geEp/GnLGuVkR8/xu0JBLykE8/ivDSX7WxkRWHqUWl6XmPvB/3IVKAsGRKElyVfAUHzDaT9Uu8YiGTRqJIZXMNoGluN0LFAIM4cNaFwnQ9XUW8Ul5cIcFsP3k1o50p9+IBcWEmVdNZXy5Ozp9pKnUa35x2s87TL0FdzMHtHGkBO8LrOtBfaGZ/2avDYCU/cSYr0i5b+VMtydK1W2IY1bxbdhVoS7ELpfyXS/iuLhtAKXprJmFegRtWMlR+kS9txNeDuMeemBRk67HmLd5OSOZ6quByErZIAuqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ShXUyOsu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ShXUyOsu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsp2bPrz3bfZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:02 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEDRY3484320;
	Mon, 9 Nov 2026 23:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xKG7lGqE5BGaoQatu
	fUXEBO5YquInkO+s2UOLZMdnZA=; b=ShXUyOsuOQ9i3Eu6sLjLTWYRnuiyNLTjg
	bLhYr1C6/eMlvDGGTR9aRnMUKsUqq//7RDyO5HRsXXqHyIv3KNdNahwyZ6xzE95v
	QTf6ANy3b1f+10gVentln20hucJt8PN3sp+NspkWo9LfPzH2tL+ILe2fCYhqJQ5b
	8idINSbR7B9cpclBaL0zGQZbU7yHVS3N7cnUuxYIZTsCmhtCDBfZKP5FzDBW3dtf
	6IAEmHhoaxSYpz7vylHnDdHvzbzmJ0tIdapIMdYVZIPZsAFn+n1Y3cCCU8YNAW+h
	pUkFTvakFwhqCOOsEohLMDJy7AbQfLSazkUWTX+9zIBjbhc0Kgs7g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg2182-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LYqoV804989;
	Mon, 9 Nov 2026 23:56:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvvhpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nukga31064822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4045A58059;
	Mon,  9 Nov 2026 23:56:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD5258017;
	Mon,  9 Nov 2026 23:56:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:42 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 08/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Mon,  9 Nov 2026 15:55:49 -0800
Message-Id: <20261109235556.60604-9-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af25dc1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=FqPrdr54Sxz1Ufj-woMA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX9ecM2C/b+x79
 3jItOggokqpE3RYXh6yBpOdiBbvo831AjEs9wBKlLcnIitwH7i3KQqYUSkkRBnjbduA7/RPuMWU
 AfXC95WwLLelMDqKg2nqZqNJKZoWIl5eL6EXQ/ycjWE0UlvvxaPJ3+6mwhUYY6GsXu/AHdgEc2r
 yhz0pHPqE5Q3P0VlbrpOpFlVOXFyRHXGcrJuhdYXwTfuHdkVp5KK76AYDtiV+mrgtrXKxfktQIX
 0pkE++I5ZXfSWcEjWbvmsrJDfaJI4s6kyNWQCgVRAvFVs7UcuxrwFtE96OFfwSsCtD9S37N0rkP
 +Xxihwc/TyyyB+691Mb9uQrJzRk9/tb9nEbhveSU4/vfHjctdIUzwz9L2kjWn9vRdviSIfG4Ihh
 vsEiYXIxLFCQS5Lt8oVXKpIyq1Df9mbi47tyajgosje5mmdOdVgcIrT2TTZw9ptmYAwUkZ0gK2D
 OeOC4sdzN9U80spzPvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX9H0tMie2uy/v
 /z/fMbkAa1x89cu93yzxO9YtcQ9VSA/A4hZjl/cdrtkdUeHRj5EV5VMhUjq8nb1bOi7w+wFo6OX
 G0SNvqumwXQoyAQOpowkHLbRA5No5wc=
X-Proofpoint-GUID: draQGeSUVp4gKwxOaHenapGL1vJPGj2W
X-Proofpoint-ORIG-GUID: xn4RhKcuTqdF943sUovuuzzM7Rn9dGYC
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

This patch queue-indexes RX replenish and pool access ahead of MQ
enable:

  - hcall: ibmveth_add_logical_lan_buffers() (MQ queue hcall vs legacy)
  - concurrency: per-queue replenish_lock; replenish outcomes logged
    after unlock
  - poll/pool: rxq_* take queue_index; INVALID_MAP and correlator
    errors refactored
  - limits: IBMVETH_MAX_RX_PER_HCALL 12, IBMVETH_MAX_RX_REGULAR 8

Runtime stays single-queue until the MQ enable patch; correlator,
lock and replenish return paths apply on queue 0 immediately.

Replenish is the last open-path hypercall that still assumes queue 0.
Registration is already queue-aware, and multi-queue posts buffers
through H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against adapter->queue_handle[],
but ibmveth_replenish_buffer_pool() still calls
h_add_logical_lan_buffer() or h_add_logical_lan_buffers() directly.

Add ibmveth_add_logical_lan_buffers() to route RX buffer pool
replenishment through H_ADD_LOGICAL_LAN_BUFFERS_QUEUE in multi-queue
mode, falling back to the legacy 8-buffer and single-buffer hypercalls
in single-queue mode.

Supporting that helper means the RX side can no longer assume queue 0.
The queue index is 0 everywhere until multi-queue RX is enabled, so
the queue plumbing below does not change behaviour yet. The correlator
and locking changes do take effect immediately, on the single queue.

Parameterise the RX accessors by queue. The eight ibmveth_rxq_*
helpers took only the adapter and hardcoded rx_queue[0]; they now take
a queue_index, as do ibmveth_remove_buffer_from_pool() and
ibmveth_rxq_get_buffer(). ibmveth_rxq_correlator() becomes
ibmveth_rxq_read_correlator(); poll still reads the correlator once
per slot, as net-next does, and now passes the queue index with it
to rxq_get_buffer() and rxq_harvest_buffer().

Add a per-queue replenish_lock to struct ibmveth_rx_q, initialised in
probe. Replenish is not the only writer of a pool's free_map: the
harvest and remove consumer runs from that queue's NAPI instance. At
this commit replenish also runs only from NAPI (netpoll's budget-0
poll skips it), but later patches (MQ open and the queue resize)
replenish from process context while that queue's NAPI may run, so
producer and consumer can run at once. Its users are NAPI and process
context, so it is taken with spin_lock_bh().

Give ibmveth_replenish_buffer_pool() a return value. It was void and
logged from inside what is now a critical section. It now returns one
of IBMVETH_REPLENISH_OK, _RESET_MAP, _RESET_MQ, _HCALL_FAIL or
_BATCH_FALLBACK, and ibmveth_replenish_task() does the logging and any
schedule_work() after dropping replenish_lock. Replenish map paths use
DMA_ATTR_NO_WARN; failures are counted, and the next poll's replenish
retries. As before this patch, a queue whose pools are left with
nothing posted gets no further poll and waits for a reopen. The
hcall-failure warning now logs against the netdev rather than the vio
device, the two batch-fallback info messages become one ratelimited
warning, and DMA_ATTR_NO_WARN silences the DMA layer's map-failure
warning. In multi-queue mode an H_FUNCTION from the buffer-add hcall
schedules a reset instead of the legacy single-buffer fallback;
that arm is unreachable until MQ RX is enabled.

An IBM_VETH_INVALID_MAP free_map entry no longer WARNs. It now drops
the partly filled batch (those skbs stay in the pool for reuse),
skips the remaining pools and schedules a reset, where the old code
posted the partial batch and moved on to the next pool.
replenish_task() also returns early for a queue index at or past the
live count, and ibmveth_poll() logs an IRQ enable failure before it
schedules the reset.

Update replenish_task_cycles under replenish_lock; the statistics patch
moves that counter per queue.

Snapshot the first BATCH_FALLBACK and HCALL_FAIL into their own
copies and log those after unlock, so a later pool cannot overwrite
the values those two messages print.

Make the correlator check per queue. ibmveth_rxq_correlator_valid()
takes the queue index and also requires the pool to be active with a
free_map. It no longer logs or schedules the reset, because
remove_buffer_from_pool() now calls it under replenish_lock:
ibmveth_rxq_bad_correlator() and ibmveth_rxq_no_skb() do the
ratelimited log and the reset, called by rxq_harvest_buffer() after
remove_buffer_from_pool() returns and by rxq_get_buffer() directly.
The ring still advances on every error. The KUnit tests pass the queue
index and set up free_map and replenish_lock.

Redefine IBMVETH_MAX_RX_PER_HCALL from 8 to 12, the argument-list
capacity of H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, and add
IBMVETH_MAX_RX_REGULAR (8) for the legacy hypercall. Probe sets
rx_buffers_per_hcall to IBMVETH_MAX_RX_REGULAR, so the legacy batch
stays at 8 until multi-queue RX is enabled.

free_buffer_pool() keeps probe/sysfs geometry (active/size/threshold)
and zeroes pool->available so teardown cannot leave a stale count.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- poll reads each RX-ring correlator once (READ_ONCE) and passes it to
  lookup and harvest, as net-next does
- harvest logs and resets on a bad correlator or a missing skb
- replenish_lock is spin_lock_bh(); replenish_task_cycles is counted
  under it; the first batch-fallback and hcall failures are both kept
  for the log

Dropped from this series (merged fixes own them):
- commit 8d9ecac6b96e: the poll_controller() replenish_task(adapter, 0)
  change. ndo_poll_controller is gone. poll keeps commit 8d9ecac6b96e's
  if (budget) around the per-queue replenish. The commit message drops
  that reason, and the DMA_ATTR_NO_WARN, lock-init and
  remove_buffer_from_pool comments no longer cite netpoll
- commit c9b95adc755f: the correlator WARN_ON() -> correlator_valid()
  conversion and poll's advance on a NULL buffer. The commit message
  drops that WARN_ON paragraph

Changes in v7:
- extend remove_buffer_from_pool Return: -EINVAL also
  inactive / not live (skbuff or free_map NULL)
- replenish fail log names the wrapper from
  filled, not batch
- advance past slot on NULL buffer so poll does not spin
  at this commit; P09 skip_bad refactors error
  escalation into helper
- noted: irqsave CS and free_buffer_pool vs lock stay
  cover leftovers (lock-protocol rewrite, not
  two conditions)

Changes in v6:
- drop inline on the queue-index rxq_* accessors (plain static)
- initialise the replenish locks once in probe; open() no longer
  reinitialises them in alloc_rx_queues(), where it could reset a
  lock another CPU was holding through poll_controller()
- pass DMA_ATTR_NO_WARN to dma_map_single_attrs() in the replenish
  loop. The iommu warning could re-enter via netconsole and deadlock
  on the replenish_lock this CPU already holds
- static_assert IBMVETH_MAX_RX_REGULAR == 8 and
  IBMVETH_MAX_RX_PER_HCALL == 12 against the hand-written
  legacy descs[0..7] and MQ ioba[0..5] argument lists
- add clarifying comment on the legacy 8-buffer hcall batch bound
- drop the three buffer-submit hypercall counters along with the rest
  of hcall_stats; see patch 7
- fix the KUnit fixtures to allocate a dummy free_map
- noted: irqsave CS and free_buffer_pool vs replenish stay cover
- noted: skip_bad_correlator lands in P09

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

 drivers/net/ethernet/ibm/ibmveth.c | 632 +++++++++++++++++++++--------
 drivers/net/ethernet/ibm/ibmveth.h |   5 +-
 2 files changed, 459 insertions(+), 178 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index e2aa10865567..a1f286b37eff 100644
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
@@ -101,57 +102,58 @@ static struct ibmveth_stat ibmveth_stats[] = {
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
+static int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
+				 int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
-	unsigned int idx = rxq->index;
-
-	return READ_ONCE(rxq->queue_addr[idx].correlator);
-}
-
-static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
-{
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_CSUM_GOOD;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_CSUM_GOOD;
 }
 
 static unsigned int ibmveth_real_max_tx_queues(void)
@@ -726,11 +728,103 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
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
+	/*
+	 * The MQ hcall takes six ioba words (12 packed addresses). The
+	 * legacy hcall takes eight descriptors. The argument lists below
+	 * are written out by hand; keep the defines matched to those lists.
+	 */
+	static_assert(IBMVETH_MAX_RX_PER_HCALL == 12);
+	static_assert(IBMVETH_MAX_RX_REGULAR == 8);
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
+	} else if (filled == 1) {
+		rc = h_add_logical_lan_buffer(vdev->unit_address,
+					      descs[0].desc);
+	} else {
+		/* Legacy 8-desc hcall; probe/mq_fallback keep batch <=
+		 * IBMVETH_MAX_RX_REGULAR.
+		 */
+		rc = h_add_logical_lan_buffers(vdev->unit_address,
+					       descs[0].desc, descs[1].desc,
+					       descs[2].desc, descs[3].desc,
+					       descs[4].desc, descs[5].desc,
+					       descs[6].desc, descs[7].desc);
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
+/* Replenish the buffers for a pool. The skbs are not skb_reserve()d:
+ * PHYP reports the offset of each received frame.
+ * Caller must hold the per-queue replenish_lock.
+ * Do not log here: failures are returned for replenish_task to log
+ * after it drops the lock, so console output does not extend that
+ * section. A failed GFP_ATOMIC skb allocation can still warn.
  */
-static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
-					  struct ibmveth_buff_pool *pool)
+static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
+					 struct ibmveth_buff_pool *pool,
+					 int queue_index,
+					 struct ibmveth_replenish_fail *fail)
 {
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
@@ -742,6 +836,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 	dma_addr_t dma_addr;
 	struct device *dev;
 	u32 index;
+	int outcome = IBMVETH_REPLENISH_OK;
 
 	vdev = adapter->vdev;
 	dev = &vdev->dev;
@@ -756,12 +851,9 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
 
@@ -776,9 +868,16 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 					break;
 				}
 
-				dma_addr = dma_map_single(dev, skb->data,
-							  pool->buff_size,
-							  DMA_FROM_DEVICE);
+				/* NO_WARN: a map failure under TCE pressure
+				 * is expected; it is counted below and the
+				 * next poll's replenish retries.
+				 */
+				dma_addr =
+					dma_map_single_attrs(dev,
+							     skb->data,
+							     pool->buff_size,
+							     DMA_FROM_DEVICE,
+							     DMA_ATTR_NO_WARN);
 				if (dma_mapping_error(dev, dma_addr)) {
 					dev_kfree_skb_any(skb);
 					adapter->replenish_add_buff_failure++;
@@ -813,28 +912,21 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
 
@@ -874,30 +966,35 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
@@ -917,21 +1014,91 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
-	int i;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	struct ibmveth_replenish_fail fail = {};
+	struct ibmveth_replenish_fail fail_fallback = {};
+	struct ibmveth_replenish_fail fail_hcall = {};
+	int i, rc;
+	int need_reset = 0;
+	int batch_fallback = 0;
+	int hcall_fail = 0;
+
+	if (queue_index >= adapter->num_rx_queues) {
+		netdev_dbg(adapter->netdev,
+			   "Skipping replenish for freed queue %d (num_queues=%u)\n",
+			   queue_index, adapter->num_rx_queues);
+		return;
+	}
+
+	spin_lock_bh(&rxq->replenish_lock);
 
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
-
-		if (pool->active &&
-		    (atomic_read(&pool->available) < pool->threshold))
-			ibmveth_replenish_buffer_pool(adapter, pool);
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
+				if (!batch_fallback)
+					fail_fallback = fail;
+				batch_fallback = 1;
+				break;
+			case IBMVETH_REPLENISH_HCALL_FAIL:
+				if (!hcall_fail)
+					fail_hcall = fail;
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
+	spin_unlock_bh(&rxq->replenish_lock);
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
+				     fail_fallback.batch);
+
+	if (hcall_fail)
+		dev_warn_ratelimited(&adapter->netdev->dev,
+				     "RX %s failed: filled=%u, rc=%lu, batch=%u\n",
+				     adapter->multi_queue ?
+				     "h_add_logical_lan_buffers_queue" :
+				     (fail_hcall.filled == 1 ?
+				      "h_add_logical_lan_buffer" :
+				      "h_add_logical_lan_buffers"),
+				     fail_hcall.filled, fail_hcall.lpar_rc,
+				     fail_hcall.batch);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -966,27 +1133,25 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 		kfree(pool->skbuff);
 		pool->skbuff = NULL;
 	}
+
+	/*
+	 * Keep probe/sysfs geometry (active, size, buff_size, threshold).
+	 * Only tear down runtime allocations; open reuses active pools.
+	 */
+	atomic_set(&pool->available, 0);
 }
 
-/* The correlator comes back from PHYP; a bad one schedules a reset. */
-static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
-					 u64 correlator)
+/* A bad correlator loses the pool slot behind it; schedule a reset.
+ * Logs, so call it only after dropping replenish_lock.
+ */
+static void ibmveth_rxq_bad_correlator(struct ibmveth_adapter *adapter,
+				       u64 correlator)
 {
-	unsigned int index = correlator & 0xffffffffUL;
-	unsigned int pool = correlator >> 32;
-
-	/* An inactive pool keeps its size but has no skbuff array. */
-	if (pool < IBMVETH_NUM_BUFF_POOLS &&
-	    index < adapter->rx_buff_pool[0][pool].size &&
-	    adapter->rx_buff_pool[0][pool].skbuff)
-		return true;
-
 	if (net_ratelimit())
 		netdev_err(adapter->netdev,
 			   "invalid RX correlator %llx, resetting\n",
 			   correlator);
 	schedule_work(&adapter->work);
-	return false;
 }
 
 static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
@@ -1133,33 +1298,77 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   adapter->num_rx_queues);
 }
 
+/* The correlator comes back from PHYP, so check it rather than trust it.
+ * Does not log: remove_buffer_from_pool() calls it under replenish_lock.
+ */
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
+	/* Require a live pool with allocated arrays before indexing.
+	 * Inactive pools still have size from init; free clears skbuff.
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
+ * Context: may run concurrently with a process-context replenish_task
+ * on the same queue; takes per-queue replenish_lock to serialize
+ * free_map / producer_index / available against the producer.
+ *
  * Return:
  * * %0       - success
- * * %-EINVAL - correlator maps to pool or index out of range, or to an
- *              inactive pool
+ * * %-EINVAL - pool or index out of range, or the pool is
+ *              inactive / not live (skbuff or free_map NULL)
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
+	int rc = 0;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
-		return -EINVAL;
+	spin_lock_bh(&rxq->replenish_lock);
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 	if (!skb) {
-		ibmveth_rxq_no_skb(adapter, correlator);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out_unlock;
 	}
 
 	/* if we are going to reuse the buffer then keep the pointers around
@@ -1170,78 +1379,95 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
+	spin_unlock_bh(&rxq->replenish_lock);
+	return rc;
+}
+
+static u64 ibmveth_rxq_read_correlator(struct ibmveth_adapter *adapter,
+				       int queue_index)
+{
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+
+	return READ_ONCE(rxq->queue_addr[rxq->index].correlator);
 }
 
 /* get the buffer for @correlator, read once from the current rx queue entry */
-static struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
-					      u64 correlator)
+static struct sk_buff *
+ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
+		       int queue_index, u64 correlator)
 {
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 	struct sk_buff *skb;
 
-	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
+		ibmveth_rxq_bad_correlator(adapter, correlator);
 		return NULL;
+	}
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 	if (!skb)
 		ibmveth_rxq_no_skb(adapter, correlator);
 	return skb;
 }
 
-static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
-{
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
-
-	if (++rxq->index == rxq->num_slots) {
-		rxq->index = 0;
-		rxq->toggle = !rxq->toggle;
-	}
-}
-
 /**
  * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
  *
- * @adapter:    pointer to adapter
+ * @adapter: pointer to adapter
+ * @queue_index: RX queue index to harvest from
  * @correlator: correlator of the current rx queue entry, as read by poll
- * @reuse:      whether to reuse buffer
+ * @reuse:   whether to reuse buffer
  *
  * Context: called from ibmveth_poll
  *
  * The ring advances even on error, so poll does not return to a bad
- * slot before the scheduled reset can run.
+ * slot before the scheduled reset can run. The error is still returned:
+ * callers must not treat it as a successful take from the pool (especially
+ * reuse=false, which would hand the SKB to the stack while it remains
+ * pool-owned).
  *
  * Return:
- * * %0    - success
- * * other - non-zero return from ibmveth_remove_buffer_from_pool
+ * * %0    - buffer removed from pool (or marked for reuse) and ring advanced
+ * * other - non-zero return from ibmveth_remove_buffer_from_pool; ring has
+ *           still been advanced for -EINVAL/-EFAULT
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
+	ibmveth_rxq_advance(&adapter->rx_queue[queue_index]);
+	if (unlikely(rc == -EFAULT))
+		ibmveth_rxq_no_skb(adapter, correlator);
+	else if (unlikely(rc))
+		ibmveth_rxq_bad_correlator(adapter, correlator);
 
 	return rc;
 }
@@ -2288,25 +2514,28 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
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
+		correlator = ibmveth_rxq_read_correlator(adapter, queue_index);
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
@@ -2314,24 +2543,33 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
+			struct ibmveth_rx_q *rxq;
 			__sum16 iph_check = 0;
 
-			skb = ibmveth_rxq_get_buffer(adapter, correlator);
+			skb = ibmveth_rxq_get_buffer(adapter, queue_index,
+						     correlator);
 			if (unlikely(!skb)) {
-				ibmveth_rxq_advance(adapter);
+				rxq = &adapter->rx_queue[queue_index];
+				ibmveth_rxq_advance(rxq);
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
@@ -2340,8 +2578,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
@@ -2368,8 +2606,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 							length);
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
-						length + offset);
+							     length + offset);
 				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
 								correlator,
 								true);
 				if (unlikely(rc)) {
@@ -2381,6 +2620,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 				skb = new_skb;
 			} else {
 				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
 								correlator,
 								false);
 				if (unlikely(rc)) {
@@ -2428,7 +2668,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	 * with a NAPI poll that was already running when it was set up
 	 */
 	if (budget)
-		ibmveth_replenish_task(adapter);
+		ibmveth_replenish_task(adapter, queue_index);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2439,8 +2679,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	rc = ibmveth_enable_irq(adapter, 0);
+	rc = ibmveth_enable_irq(adapter, queue_index);
 	if (rc) {
+		netdev_err(netdev,
+			   "Failed to enable IRQ for queue %d (rc=%d), scheduling reset\n",
+			   queue_index, rc);
 		schedule_work(&adapter->work);
 		goto out;
 	}
@@ -2448,8 +2691,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
@@ -2758,6 +3002,15 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
 	INIT_WORK(&adapter->work, ibmveth_reset);
+
+	/*
+	 * Initialise the replenish locks once. open() is re-entered on
+	 * MTU and offload changes, so a lock set up there could be
+	 * reinitialised while still held.
+	 */
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		spin_lock_init(&adapter->rx_queue[i].replenish_lock);
+
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
@@ -2799,7 +3052,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
+		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
 			    adapter->rx_buffers_per_hcall);
@@ -3122,7 +3375,7 @@ static void ibmveth_reset_kunit(struct work_struct *w)
  * @test: pointer to kunit structure
  *
  * Tests the error returns from ibmveth_remove_buffer_from_pool.
- * Each error also logs a ratelimited netdev_err.
+ * Bad correlators return -EINVAL/-EFAULT (no WARN_ON).
  *
  * Return: void
  */
@@ -3137,6 +3390,8 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
+	spin_lock_init(&adapter->rx_queue[0].replenish_lock);
+
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
@@ -3146,26 +3401,41 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+	pool->free_map = kunit_kcalloc(test, pool->size, sizeof(u16),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->free_map);
 
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
@@ -3207,30 +3477,33 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+	pool->free_map = kunit_kcalloc(test, pool->size, sizeof(u16),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->free_map);
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_read_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_read_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)2 << 32 | 0;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_read_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	pool->skbuff[0] = skb;
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
-	cor = ibmveth_rxq_correlator(adapter);
+	cor = ibmveth_rxq_read_correlator(adapter, 0);
 	KUNIT_EXPECT_PTR_EQ(test, skb,
-			    ibmveth_rxq_get_buffer(adapter, cor));
+			    ibmveth_rxq_get_buffer(adapter, 0, cor));
 
 	flush_work(&adapter->work);
 }
@@ -3257,6 +3530,8 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
+	spin_lock_init(&adapter->rx_queue[0].replenish_lock);
+
 	adapter->rx_queue[0].num_slots = 2;
 	adapter->rx_queue[0].index = 0;
 	adapter->rx_queue[0].toggle = 1;
@@ -3275,20 +3550,23 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *),
 				     GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+	pool->free_map = kunit_kcalloc(test, pool->size, sizeof(u16),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->free_map);
 
 	/* Slot 0: pool out of range. Slot 1: valid, but no skb. */
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
 	adapter->rx_queue[0].queue_addr[1].correlator = (u64)0 << 32 | 0;
 
-	cor = ibmveth_rxq_correlator(adapter);
-	ret = ibmveth_rxq_harvest_buffer(adapter, cor, true);
+	cor = ibmveth_rxq_read_correlator(adapter, 0);
+	ret = ibmveth_rxq_harvest_buffer(adapter, 0, cor, true);
 	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
 	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].index);
 	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].toggle);
 
-	cor = ibmveth_rxq_correlator(adapter);
-	ret = ibmveth_rxq_harvest_buffer(adapter, cor, true);
+	cor = ibmveth_rxq_read_correlator(adapter, 0);
+	ret = ibmveth_rxq_harvest_buffer(adapter, 0, cor, true);
 	KUNIT_EXPECT_EQ(test, -EFAULT, ret);
 	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].index);
 	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].toggle);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 1433f62aaaca..bdc8ea7069ec 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -15,6 +15,7 @@
 #define _IBMVETH_H
 
 #include <linux/completion.h>
+#include <linux/spinlock_types.h>
 
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
@@ -271,7 +272,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_DEFAULT_QUEUES 8U
 #define IBMVETH_MAX_RX_QUEUES 1U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
-#define IBMVETH_MAX_RX_PER_HCALL 8U
+#define IBMVETH_MAX_RX_REGULAR 8U
+#define IBMVETH_MAX_RX_PER_HCALL 12U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
@@ -303,6 +305,7 @@ struct ibmveth_rx_q {
     dma_addr_t queue_dma;
     u32        queue_len;
     struct ibmveth_rx_q_entry *queue_addr;
+	spinlock_t	replenish_lock;	/* per-queue buffer replenish */
 };
 
 struct ibmveth_adapter {
-- 
2.50.1 (Apple Git-155)


