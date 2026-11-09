Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3094606A331
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SWlnjYy+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmtB50G7z3bmR;
	Tue, 10 Nov 2026 10:57:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268642;
	cv=none; b=DLpdvCavMIFYqdTbX3YA0bPWyk9FMkTOhOxLgay5s8UfAbY+fE2+qoKQA8W6EsB/bryGAw345kKhbYcZ66tpHxZyDMYq8cPJngpsTKbimuQsqj9Mppd/gKAxz6QRBkwmsgjEEbzchZRN1z3hLIAHFcVMdTokhKb0KudOWhvs988Bbrg4mEc447EldjS2VbfLQBayxeSddtSINFzUk+QfwxBHQfczlc5sJQmAWFCOcMpJRo2Nrt5PUn8qG8k3jBoc+XMPHvXbj1CnfvH37l+mwqCER3BOGx+4dLeoBpI7KUL/BN+qa1092zXz8gYC9viwqzhHSsBzcRmrt3hGy8oPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268642; c=relaxed/relaxed;
	bh=yDTmnajfHFiFjRuVVEKpw89Ete0uS3kJPvp0R2Se9iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LowL2iXh7h3HdIDXuucX2taADk+bHBbuYigA4NLDOzOAWS4yWF22DpEd7PFdE99Mb+qgbulbj6NUX0kaenO+E+KwrmZr74nPI82lcXF2BAWlZ0dom4PFvloa9MkHSuT5e7yXe0CVnH0znFbVq+Yr25t35cIR7rVeV9hfb6bSXFZEeXxt60HUORPQhNEVchiiQQ8nUwFhkGQr/XdbH9nIuRpSRlAQmXbcF7HL92edlhOnaLBsZsckYMWHXcyTinkXaLbqhubht70ZVBovxk1ABsCBs5hqNv95BAaV9IrrdFHV4jc/6gnVDM8UMCS1OUvO+ERBa8JkKO0kCHeNz4shTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SWlnjYy+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SWlnjYy+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmt66Rgsz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:18 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEKQp512683;
	Mon, 9 Nov 2026 23:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yDTmnajfHFiFjRuVV
	EKpw89Ete0uS3kJPvp0R2Se9iQ=; b=SWlnjYy+waE0mVq9ONWdMIJ2QWPqn0tik
	78hkMmn49ySDNSw6g/j4oyTkh1RzM0LzqYwKiwSqtPlV1qaYhIxfeFYlY6KNDn2L
	vdueA0MLG5Cu7Gs3Bpq8ZXInmv9n2J9k3NbpYEoTgghJt8XRhGyzERuRIkesKEqz
	GxQhWgqIORFnV+Cp7vuDzyhHBp2GqWitryl2T45qnh0UOOcuKfLQ/4hst3EhAyZp
	ADqVej3l3FViw7A26XynJ3PZocH+9fxmEDBc7Mp+EGcl9dBk8SS9rVR4lsAF9vXR
	FqXHinlnIj5rVim97S6p2n8G9+TnhsyFkT7+SAmCYHtxgh6ywtYkw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumusrty-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJsKO812428;
	Mon, 9 Nov 2026 23:57:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y42eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nv03g17957404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:57:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5065958028;
	Mon,  9 Nov 2026 23:57:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1779C58017;
	Mon,  9 Nov 2026 23:56:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:56 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 11/15] ibmveth: Add per-queue RX and TX statistics collection
Date: Mon,  9 Nov 2026 15:55:52 -0800
Message-Id: <20261109235556.60604-12-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX8CrtVuGpa5N+
 g7GBr4K0Z01DY1p0kPbyA0jHt8WVQGTfvNvjE2V0KJ/fpf7eJFeOtJ06Lm41aP0kwKKV/uHtOOf
 8MVk/yDIA8E4nJBaX8MZ4xeSReozh30=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af25dcf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=NhnyW7ceVYaQWTjv2ZcA:9
X-Proofpoint-GUID: zjNP-A1_boyywMzwLYRnoVqrYMSqw83e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX0pG4NypWQVNx
 vpc2xLORyS+a2/3Gbwbi+xdtkDBiI5a7TyTrCn0Yq93JcUGgy7lUtPvMu5W9EPaFXJ/irPipeJD
 Lsm/LkRAdcviDe2E9sNZRTn6pCJR7IVxP54Lty0anwPVE+b1Ysr91lPUEX8OSZamdDsXDse/xD6
 dMiN33+Sve8GEo9lAut0afcTDz41VcyMfFaiMv13jRbSUyEVWI2QpSk01CGOeOgUMAUwxhnj3kG
 h9LYusZ+T8ucrzezm55FKA+Fjw4LEVB7IAW7/vaxsLg6qg6sZKS4aEpcjZjsA2cqEIG2dMSfGPq
 b0ZSmz3wR78Ux0/QJyOewCK4r8Bvl+XE9Y9zk+Wqe6dyvvhjuwDGb2R/ePq4/vxNJFgR/eP1BNS
 SRX13ppyPhE3MRV6V45BlIWZpy8MetW4fp6HacgXa2Cheh9XaOPUdneaikupikW23HmevXllAE4
 0oNMoq/IXzgr5TRoLZw==
X-Proofpoint-ORIG-GUID: ySSQCHb--vVqFQ0HIFuYpvjVNY95uBoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MQ RX points several queues at the same adapter-wide counters, which
races the updates and leaves no way to attribute a count to a queue.

The patch has three parts:

  - storage: every counter with more than one writer moves into
    per-queue structs, allocated at probe and freed at remove, with
    a single writer per slot.
  - export: packets, bytes and hardware drops are reported per queue
    through netdev_stat_ops; ndo_get_stats64() sums every allocated
    slot (live and retired after shrink) into the device totals;
    ethtool -S keeps its thirteen keys (summed on read) and adds a few
    driver-specific per-queue keys.
  - rx_no_buffer: each queue carries the drops from buffer-list
    pages it has already released, so the count is cumulative across
    a reopen and never goes backwards.

The per-queue structs are:

  struct ibmveth_rx_queue_stats
  struct ibmveth_tx_queue_stats

Each slot has a single writer -- replenish_* under that queue's
replenish_lock, interrupts from that queue's IRQ handler, the
other RX fields from its NAPI (polls is not counted for
netpoll's budget-0 call), TX under
the stack's per-queue TX lock -- so u64 needs no atomic and no
u64_stats_sync on this PPC64-only driver. Readers run locklessly on
other CPUs, so writers go through WRITE_ONCE() (IBMVETH_STAT_INC/ADD)
and readers use READ_ONCE(), which keeps KCSAN quiet and stops the
compiler from splitting or refetching the accesses.

packets, bytes and hardware RX drops go through struct
netdev_stat_ops (.get_queue_stats_rx, .get_queue_stats_tx,
.get_base_stats). rx-hw-drops is what PHYP dropped: its no-buffer
count and the slots it hands back marked invalid. The no-buffer count
alone is also rx-hw-drop-overruns. rx-alloc-fail is the replenish
skb allocation failures (replenish_no_mem). Driver software drops (bad
correlator, failed harvest, oversize, recycle-invalid) are not separate
netdev_stat_ops or ethtool -S keys; each queue's NAPI increments
rx_qstats[].dropped and ndo_get_stats64() sums that into rtnl
rx_dropped; the poll paths no longer bump netdev->stats.rx_dropped.
TX large sends stay in the existing tx_large_packets key only, with
no per-queue key and no tx-hw-gso-packets: whether anything segments
a large send depends on where the frame goes.
TX hw_drops is left unset: yaml tx-hw-drops is packets that
arrived at the device, and dropped_packets also counts
software xmit rejects. ndo_get_stats64 still sums those
into tx_dropped, same as SQ.
.ndo_get_stats64() sums the per-queue packet and byte counters into
64-bit device totals. ethtool -S keeps the driver-specific keys with
no qstats field of their own: interrupts, polls, large_packets and
invalid_buffers per RX queue (rx-hw-drops folds invalid slots in with
the no-buffer count); send_failures per TX queue.
ETH_SS_STATS becomes variable-length because that block
scales with the live queue count. Hypercall counters and pool%d_ keys
are not added: which hcall a batch picks is not ABI, and size/active
already have sysfs.

The thirteen existing ethtool -S keys keep their exact names, their
order and their adapter-wide values, summed from the per-queue slots
on read. The storage moved; that ABI did not, except that
rx_no_buffer becomes cumulative across a reopen (below). The four
replenish_* counters get per-queue storage but no per-queue key of
their own.

Holding that ABI while the storage moves needs the ethtool -S table
to record where each key lives. IBMVETH_STAT_OFF() could only express
an offset into struct ibmveth_adapter. Tag every entry with an enum
ibmveth_stat_src naming the struct it indexes: adapter-wide keys are
read directly, per-queue keys are summed across the slots by one pair
of offset-keyed helpers. That is what lets the field names change
while the key names do not (rx_invalid_buffer now reads
invalid_buffers, tx_send_failed reads send_failures, and the two
large_packets fields live in different structs). tx_map_failed still
reads from the adapter -- it has no writer, here or in mainline --
and the three fw_enabled_* keys are capability flags, not counters.

The per-queue keys come from their own tables with the counts derived
by ARRAY_SIZE(), so get_strings(), get_ethtool_stats() and
get_sset_count() cannot drift apart.

ndo_get_stats64() walks every allocated slot rather than only the live
queues, so device totals cannot go backwards when ethtool -L shrinks
the queue count. get_base_stats() therefore reports the retired-queue
remainder rather than zero; the core sums it with the live queues it
iterates itself. Zeroing would assert that the live-queue sum is
already complete. Every field the per-queue callbacks fill is also
initialised there, because netdev_nl_stats_add() drops a field from
the device total unless both sides set it.

Give every queue a no_buffer_retired carry. PHYP's drop counter is
absolute for the buffer-list page currently mapped, so a reopen or a
queue reuse restarts it near zero. Storing only the newest absolute in
adapter->rx_no_buffer meant whichever queue ran last won, and the
value could go backwards. The carry sits beside the no_buffer_drops it
accumulates from, so both belong to one queue. Whenever
free_all_queues() lets the caller unmap, fold the last sample into
retired and clear drops while the page is still mapped; as close()
did before, that includes a single-queue H_FREE failure. Live
replenish still stores the page absolute; if the reading drops, the
previous absolute is folded into retired first. Readers snapshot the pair
under that queue's replenish_lock so a page-reset cannot be counted
twice. Every exported no_buffer value sums the two: the adapter-wide
rx_no_buffer key, rx_missed_errors, and per-queue rx-hw-drops and
rx-hw-drop-overruns, so none goes backwards across a close.

remove() frees the per-queue statistics arrays after
unregister_netdev() and after its H_FREE_LOGICAL_LAN retry, which
retires into them; the reset work is already disabled at the top of
remove().

ibmveth_probe_cleanup() also cancels the reset work and clears the
vio drvdata before free_netdev(), so drvdata does not outlive the
netdev on a probe failure, which never reaches ibmveth_remove().

Readers do not test the arrays for NULL: both exist from before
register_netdev() until after unregister_netdev(), with the reset
work already disabled, and probe fails -ENOMEM if either allocation
does.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- the per-queue no_buffer carry is folded by free_all_queues() before
  every unmap, not only when a lower sample is seen, and read under
  replenish_lock, so no exported value goes backwards across a close
- counters use WRITE_ONCE()/READ_ONCE() (IBMVETH_STAT_INC/ADD)
- ndo_get_stats64() fills rx_dropped and rx_missed_errors; rx_qstats
  dropped counts bad-correlator, failed-harvest, recycle-invalid and
  oversize slots
- qstats: rx-hw-drop-overruns filled; TX hw_drops unset; rx%d_polls
  skips budget 0
- ethtool -S drops tx%d_checksum_offload (counter removed),
  rx%d_no_buffer_drops (in qstats) and tx%d_large_packets (the
  summed tx_large_packets stays)
- remove() frees the qstats arrays after its H_FREE retry

Changes in v7:
- close() harvests no_buffer under replenish_lock
- remove() uses put_pool_kobjs so the wait lands
  before free_netdev
- remove-path unregister/cancel reorder and reset gate
  moved to P10 with the reset producer
- noted: -S / get_stats64 / hw_drops mapping stays;
  irqsave / free_buffer_pool / netpoll_poll_disable
  stay leftover

Changes in v6:
- wrap the qstats local in replenish (81 cols)
- replenish_* per-queue u64, summed on the existing adapter-wide keys;
  no per-queue replenish key; no atomics
- netdev_stat_ops for packets/bytes/drops, not private -S strings
- enum ibmveth_stat_src so existing -S keys keep names while storage
  moves; ARRAY_SIZE() for the per-queue key counts
- no hcall_* keys (buffer-submit and H_SEND_LOGICAL_LAN)
- drop the three pool%d_ keys (15 ethtool entries)
- drop the fifteen qstats NULL checks outside the allocators
  (five in the RX hot path)
- per-queue no_buffer_retired carry
- get_base_stats() reports the retired-queue remainder
- gate reset on NETREG_REGISTERED
- noted: harvest no_buffer on -L shrink is patch 14

Changes in v5:
- Series renumber: mailed v4 10/14 stats -> tip P11 (P09 peel;
  get_channels -> P12)
- rx_no_buffer_retired + sum MAX_* slots so adapter no-buffer / qstat
  totals stay monotonic across reopen and channel shrink
- probe_cleanup: clear vio drvdata before free_netdev (CMO cannot see a
  freed netdev on rebind)
- remove: unregister_netdev then cancel_work_sync (no UAF reset worker)

Changes in v4:
- Merge v3's separate RX and TX stats commits into one patch.
- Introduce rx_queue_stats / tx_qstats / NUM macros here (first use).
- Allocate/free qstats at probe/remove instead of open/close.
- Report adapter-level ethtool strings by summing per-queue counters on
  read; drop aggregate_* helpers.
- Sum global rx_no_buffer across MQ queues into this statistics patch.
- Cacheline-align per-queue stats; derive field counts with offsetof so
  alignment padding is not counted as a statistic.
- probe_cleanup() cancels reset work, puts pool kobjects via helper from
  the prior patch, and frees qstats on probe failure paths.
- Keep plain u64 qstats like existing ibmveth / ibmvnic (PPC_PSERIES).

 drivers/net/ethernet/ibm/ibmveth.c | 549 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ibm/ibmveth.h |  60 +++-
 2 files changed, 542 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a0c3c06d2b9d..45adf6e9be09 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -38,6 +38,7 @@
 #include <asm/firmware.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
+#include <net/netdev_queues.h>
 
 #include "ibmveth.h"
 
@@ -75,32 +76,101 @@ module_param(old_large_send, bool, 0444);
 MODULE_PARM_DESC(old_large_send,
 	"Use old large send method on firmware that supports the new method");
 
+/**
+ * enum ibmveth_stat_src - where an ethtool -S counter is stored
+ * @IBMVETH_STAT_ADAPTER: plain u64 in struct ibmveth_adapter
+ * @IBMVETH_STAT_RX_QSUM: per-queue u64, summed over rx_qstats[]
+ * @IBMVETH_STAT_TX_QSUM: per-queue u64, summed over tx_qstats[]
+ * @IBMVETH_STAT_RX_NO_BUFFER: rx_qstats[] live-page absolute plus the
+ *	absolutes carried over from pages the queue has already retired
+ *
+ * Counters live per-queue so multi-queue writers never share a field.
+ * The adapter is only ever read from ethtool, so summing there is free.
+ */
+enum ibmveth_stat_src {
+	IBMVETH_STAT_ADAPTER,
+	IBMVETH_STAT_RX_QSUM,
+	IBMVETH_STAT_TX_QSUM,
+	IBMVETH_STAT_RX_NO_BUFFER,
+};
+
 struct ibmveth_stat {
 	char name[ETH_GSTRING_LEN];
-	int offset;
+	enum ibmveth_stat_src src;
+	/* Offset into the struct named by @src. */
+	size_t off;
 };
 
 #define IBMVETH_STAT_OFF(stat) offsetof(struct ibmveth_adapter, stat)
+#define IBMVETH_RXQ_OFF(stat) offsetof(struct ibmveth_rx_queue_stats, stat)
+#define IBMVETH_TXQ_OFF(stat) offsetof(struct ibmveth_tx_queue_stats, stat)
+
+/* Single writer per counter; lockless readers use READ_ONCE(). */
+#define IBMVETH_STAT_ADD(stat, n)	WRITE_ONCE((stat), (stat) + (n))
+#define IBMVETH_STAT_INC(stat)		IBMVETH_STAT_ADD(stat, 1)
 #define IBMVETH_GET_STAT(a, off) *((u64 *)(((unsigned long)(a)) + off))
 
+#define IBMVETH_ADAPTER_STAT(key, field) \
+	{ key, IBMVETH_STAT_ADAPTER, IBMVETH_STAT_OFF(field) }
+#define IBMVETH_RXQ_STAT(key, field) \
+	{ key, IBMVETH_STAT_RX_QSUM, IBMVETH_RXQ_OFF(field) }
+#define IBMVETH_TXQ_STAT(key, field) \
+	{ key, IBMVETH_STAT_TX_QSUM, IBMVETH_TXQ_OFF(field) }
+
+/*
+ * Key names and their order are ABI. Do not reorder or rename; append
+ * only, and only when the counter is worth a permanent interface.
+ */
 static struct ibmveth_stat ibmveth_stats[] = {
-	{ "replenish_task_cycles", IBMVETH_STAT_OFF(replenish_task_cycles) },
-	{ "replenish_no_mem", IBMVETH_STAT_OFF(replenish_no_mem) },
-	{ "replenish_add_buff_failure",
-			IBMVETH_STAT_OFF(replenish_add_buff_failure) },
-	{ "replenish_add_buff_success",
-			IBMVETH_STAT_OFF(replenish_add_buff_success) },
-	{ "rx_invalid_buffer", IBMVETH_STAT_OFF(rx_invalid_buffer) },
-	{ "rx_no_buffer", IBMVETH_STAT_OFF(rx_no_buffer) },
-	{ "tx_map_failed", IBMVETH_STAT_OFF(tx_map_failed) },
-	{ "tx_send_failed", IBMVETH_STAT_OFF(tx_send_failed) },
-	{ "fw_enabled_ipv4_csum", IBMVETH_STAT_OFF(fw_ipv4_csum_support) },
-	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
-	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
-	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
-	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
+	IBMVETH_RXQ_STAT("replenish_task_cycles", replenish_task_cycles),
+	IBMVETH_RXQ_STAT("replenish_no_mem", replenish_no_mem),
+	IBMVETH_RXQ_STAT("replenish_add_buff_failure",
+			 replenish_add_buff_failure),
+	IBMVETH_RXQ_STAT("replenish_add_buff_success",
+			 replenish_add_buff_success),
+	IBMVETH_RXQ_STAT("rx_invalid_buffer", invalid_buffers),
+	{ "rx_no_buffer", IBMVETH_STAT_RX_NO_BUFFER, 0 },
+	IBMVETH_ADAPTER_STAT("tx_map_failed", tx_map_failed),
+	IBMVETH_TXQ_STAT("tx_send_failed", send_failures),
+	IBMVETH_ADAPTER_STAT("fw_enabled_ipv4_csum", fw_ipv4_csum_support),
+	IBMVETH_ADAPTER_STAT("fw_enabled_ipv6_csum", fw_ipv6_csum_support),
+	IBMVETH_TXQ_STAT("tx_large_packets", large_packets),
+	IBMVETH_RXQ_STAT("rx_large_packets", large_packets),
+	IBMVETH_ADAPTER_STAT("fw_enabled_large_send", fw_large_send_support),
+};
+
+/**
+ * struct ibmveth_qstat - a per-queue counter exposed through ethtool -S
+ * @fmt: key name, taking the queue index as its only argument
+ * @off: offset into the matching per-queue stats struct
+ *
+ * Driving the strings and the values from one table keeps the two in
+ * step; get_sset_count() derives its length from ARRAY_SIZE() so the
+ * three cannot drift apart.
+ */
+struct ibmveth_qstat {
+	const char *fmt;
+	size_t off;
+};
+
+/*
+ * packets, bytes, drops and no-buffer overruns are reported through
+ * netdev_stat_ops. The keys below stay driver-specific.
+ */
+static const struct ibmveth_qstat ibmveth_rx_qstat_keys[] = {
+	{ "rx%d_interrupts", IBMVETH_RXQ_OFF(interrupts) },
+	{ "rx%d_polls", IBMVETH_RXQ_OFF(polls) },
+	{ "rx%d_large_packets", IBMVETH_RXQ_OFF(large_packets) },
+	{ "rx%d_invalid_buffers", IBMVETH_RXQ_OFF(invalid_buffers) },
 };
 
+static const struct ibmveth_qstat ibmveth_tx_qstat_keys[] = {
+	{ "tx%d_send_failures", IBMVETH_TXQ_OFF(send_failures) },
+};
+
+#define IBMVETH_NUM_RX_QSTATS ARRAY_SIZE(ibmveth_rx_qstat_keys)
+#define IBMVETH_NUM_TX_QSTATS ARRAY_SIZE(ibmveth_tx_qstat_keys)
+
 /* simple methods of getting data from the current rxq entry */
 static u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter,
 			     int queue_index)
@@ -241,6 +311,60 @@ ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
 	}
 }
 
+/**
+ * ibmveth_alloc_rx_qstats - Allocate per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->rx_qstats = kcalloc(IBMVETH_MAX_RX_QUEUES,
+				     sizeof(*adapter->rx_qstats),
+				     GFP_KERNEL);
+	if (!adapter->rx_qstats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_rx_qstats - Free per-queue RX statistics
+ * @adapter: ibmveth adapter structure
+ */
+static void ibmveth_free_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	kfree(adapter->rx_qstats);
+	adapter->rx_qstats = NULL;
+}
+
+/**
+ * ibmveth_alloc_tx_qstats - Allocate per-queue TX statistics
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_tx_qstats(struct ibmveth_adapter *adapter)
+{
+	adapter->tx_qstats = kcalloc(IBMVETH_MAX_QUEUES,
+				     sizeof(*adapter->tx_qstats),
+				     GFP_KERNEL);
+	if (!adapter->tx_qstats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_tx_qstats - Free per-queue TX statistics
+ * @adapter: ibmveth adapter structure
+ */
+static void ibmveth_free_tx_qstats(struct ibmveth_adapter *adapter)
+{
+	kfree(adapter->tx_qstats);
+	adapter->tx_qstats = NULL;
+}
+
 /**
  * ibmveth_alloc_rx_queues - Allocate per-queue RX resources
  * @adapter: ibmveth adapter structure
@@ -861,6 +985,14 @@ struct ibmveth_replenish_fail {
 	u32 batch;
 };
 
+static void ibmveth_count_add_fail(struct ibmveth_rx_queue_stats *qstats,
+				   bool no_mem)
+{
+	if (no_mem)
+		IBMVETH_STAT_INC(qstats->replenish_no_mem);
+	IBMVETH_STAT_INC(qstats->replenish_add_buff_failure);
+}
+
 /* Replenish the buffers for a pool. The skbs are not skb_reserve()d:
  * PHYP reports the offset of each received frame.
  * Caller must hold the per-queue replenish_lock.
@@ -873,6 +1005,8 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 					 int queue_index,
 					 struct ibmveth_replenish_fail *fail)
 {
+	struct ibmveth_rx_queue_stats *qstats =
+		&adapter->rx_qstats[queue_index];
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
 	u64 correlators[IBMVETH_MAX_RX_PER_HCALL] = {0};
@@ -899,7 +1033,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		for (filled = 0; filled < min(remaining, batch); filled++) {
 			index = pool->free_map[free_index];
 			if (index == IBM_VETH_INVALID_MAP) {
-				adapter->replenish_add_buff_failure++;
+				ibmveth_count_add_fail(qstats, false);
 				outcome = IBMVETH_REPLENISH_RESET_MAP;
 				break;
 			}
@@ -910,8 +1044,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 				skb = netdev_alloc_skb(adapter->netdev,
 						       pool->buff_size);
 				if (!skb) {
-					adapter->replenish_no_mem++;
-					adapter->replenish_add_buff_failure++;
+					ibmveth_count_add_fail(qstats, true);
 					break;
 				}
 
@@ -927,7 +1060,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 							     DMA_ATTR_NO_WARN);
 				if (dma_mapping_error(dev, dma_addr)) {
 					dev_kfree_skb_any(skb);
-					adapter->replenish_add_buff_failure++;
+					ibmveth_count_add_fail(qstats, false);
 					break;
 				}
 
@@ -988,7 +1121,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		}
 
 		buffers_added += filled;
-		adapter->replenish_add_buff_success += filled;
+		IBMVETH_STAT_ADD(qstats->replenish_add_buff_success, filled);
 		remaining -= filled;
 
 		memset(&descs, 0, sizeof(descs));
@@ -1011,7 +1144,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 				pool->skbuff[index] = NULL;
 			}
 		}
-		adapter->replenish_add_buff_failure += filled;
+		IBMVETH_STAT_ADD(qstats->replenish_add_buff_failure, filled);
 
 		if (lpar_rc == H_FUNCTION) {
 			if (adapter->multi_queue) {
@@ -1052,6 +1185,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
 					int queue_index)
 {
+	struct ibmveth_rx_queue_stats *qstats;
 	__be64 *p;
 	u64 drops;
 
@@ -1063,7 +1197,45 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
 	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
 	drops = be64_to_cpup(p);
 
-	adapter->rx_no_buffer = drops;
+	qstats = &adapter->rx_qstats[queue_index];
+
+	if (drops < qstats->no_buffer_drops)
+		IBMVETH_STAT_ADD(qstats->no_buffer_retired,
+				 qstats->no_buffer_drops);
+	WRITE_ONCE(qstats->no_buffer_drops, drops);
+}
+
+/* Snapshot live+retired under replenish_lock; see retire_rx_no_buffer(). */
+static u64 ibmveth_rx_no_buffer_pair(struct ibmveth_adapter *adapter, int i)
+{
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[i];
+	struct ibmveth_rx_queue_stats *qstats = &adapter->rx_qstats[i];
+	u64 drops, retired;
+
+	spin_lock_bh(&rxq->replenish_lock);
+	drops = qstats->no_buffer_drops;
+	retired = qstats->no_buffer_retired;
+	spin_unlock_bh(&rxq->replenish_lock);
+	return drops + retired;
+}
+
+/*
+ * Call whenever the caller is about to unmap the buffer-list page.
+ * Take the last sample, then fold it into retired so the next page
+ * cannot overwrite the total.
+ */
+static void ibmveth_retire_rx_no_buffer(struct ibmveth_adapter *adapter,
+					int queue_index)
+{
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	struct ibmveth_rx_queue_stats *qstats;
+
+	spin_lock_bh(&rxq->replenish_lock);
+	ibmveth_update_rx_no_buffer(adapter, queue_index);
+	qstats = &adapter->rx_qstats[queue_index];
+	IBMVETH_STAT_ADD(qstats->no_buffer_retired, qstats->no_buffer_drops);
+	WRITE_ONCE(qstats->no_buffer_drops, 0);
+	spin_unlock_bh(&rxq->replenish_lock);
 }
 
 /* replenish routine */
@@ -1088,7 +1260,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 
 	spin_lock_bh(&rxq->replenish_lock);
 
-	adapter->replenish_task_cycles++;
+	IBMVETH_STAT_INC(adapter->rx_qstats[queue_index].replenish_task_cycles);
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
 		struct ibmveth_buff_pool *pool =
@@ -1875,6 +2047,9 @@ static void ibmveth_release_lan_resources(struct ibmveth_adapter *adapter)
  * reason it cannot simply keep the memory mapped is that on a CMO
  * partition vio_cmo_bus_remove() BUG()s on an outstanding entitlement.
  *
+ * Whenever the caller will unmap, retire each queue's no_buffer
+ * sample first, while the page is still mapped.
+ *
  * On return 0, clears registered flags and cookies of queues
  * [0, num_rx_queues); queue_irq[] is released by
  * ibmveth_cleanup_rx_interrupts() on close, or by
@@ -1900,6 +2075,9 @@ static int ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 			return -EIO;
 	}
 
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+		ibmveth_retire_rx_no_buffer(adapter, i);
+
 	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
 		ibmveth_clear_rx_queue_handle(adapter, i);
 
@@ -2172,7 +2350,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	int i;
 
 	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
 	 * open() directly. If that open() fails, IFF_UP stays set and
@@ -2189,8 +2366,6 @@ static int ibmveth_close(struct net_device *netdev)
 	ibmveth_cleanup_rx_interrupts(adapter);
 
 	if (!ibmveth_free_all_queues(adapter)) {
-		for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
-			ibmveth_update_rx_no_buffer(adapter, i);
 		/* netif_tx_disable() above keeps xmit off the TX LTBs. */
 		ibmveth_release_lan_resources(adapter);
 	}
@@ -2453,22 +2628,100 @@ static int ibmveth_set_features(struct net_device *dev,
 	return rc1 ? rc1 : rc2;
 }
 
-static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+/*
+ * Sum per-queue counters for rare ethtool reads. The hot paths only ever
+ * touch their own queue's slot, so nothing here needs an atomic; the cost
+ * of aggregation is paid by the reader instead (ibmvnic-style).
+ *
+ * Every slot is summed, not just the live ones, so that shrinking the
+ * queue count with ethtool -L cannot make a counter go backwards.
+ */
+static u64 ibmveth_sum_rx_qstat(struct ibmveth_adapter *adapter, size_t off)
 {
+	u64 total = 0;
 	int i;
 
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
+		const u8 *q = (const u8 *)&adapter->rx_qstats[i];
+
+		total += READ_ONCE(*(const u64 *)(q + off));
+	}
+
+	return total;
+}
+
+static u64 ibmveth_sum_tx_qstat(struct ibmveth_adapter *adapter, size_t off)
+{
+	u64 total = 0;
+	int i;
+
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++) {
+		const u8 *q = (const u8 *)&adapter->tx_qstats[i];
+
+		total += READ_ONCE(*(const u64 *)(q + off));
+	}
+
+	return total;
+}
+
+static u64 ibmveth_ethtool_adapter_stat(struct ibmveth_adapter *adapter,
+					int index)
+{
+	const struct ibmveth_stat *stat = &ibmveth_stats[index];
+
+	switch (stat->src) {
+	case IBMVETH_STAT_RX_QSUM:
+		return ibmveth_sum_rx_qstat(adapter, stat->off);
+	case IBMVETH_STAT_TX_QSUM:
+		return ibmveth_sum_tx_qstat(adapter, stat->off);
+	case IBMVETH_STAT_RX_NO_BUFFER: {
+		u64 total = 0;
+		int i;
+
+		for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+			total += ibmveth_rx_no_buffer_pair(adapter, i);
+		return total;
+	}
+	case IBMVETH_STAT_ADAPTER:
+		break;
+	}
+
+	return IBMVETH_GET_STAT(adapter, stat->off);
+}
+
+static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	u8 *p = data;
+	int i, j;
+
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++, data += ETH_GSTRING_LEN)
-		memcpy(data, ibmveth_stats[i].name, ETH_GSTRING_LEN);
+	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++) {
+		memcpy(p, ibmveth_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+	}
+
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+		for (j = 0; j < IBMVETH_NUM_RX_QSTATS; j++)
+			ethtool_sprintf(&p, ibmveth_rx_qstat_keys[j].fmt, i);
+
+	for (i = 0; i < dev->real_num_tx_queues; i++)
+		for (j = 0; j < IBMVETH_NUM_TX_QSTATS; j++)
+			ethtool_sprintf(&p, ibmveth_tx_qstat_keys[j].fmt, i);
 }
 
 static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return ARRAY_SIZE(ibmveth_stats);
+		return ARRAY_SIZE(ibmveth_stats) +
+		       ibmveth_get_num_rx_queues(adapter) *
+		       IBMVETH_NUM_RX_QSTATS +
+		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2477,11 +2730,27 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 static void ibmveth_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
-	int i;
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i, j, k;
 
 	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
-		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
+		data[i] = ibmveth_ethtool_adapter_stat(adapter, i);
+
+	for (j = 0; j < ibmveth_get_num_rx_queues(adapter); j++) {
+		const u8 *q = (const u8 *)&adapter->rx_qstats[j];
+
+		for (k = 0; k < IBMVETH_NUM_RX_QSTATS; k++)
+			data[i++] = READ_ONCE(*(const u64 *)
+				(q + ibmveth_rx_qstat_keys[k].off));
+	}
+
+	for (j = 0; j < dev->real_num_tx_queues; j++) {
+		const u8 *q = (const u8 *)&adapter->tx_qstats[j];
+
+		for (k = 0; k < IBMVETH_NUM_TX_QSTATS; k++)
+			data[i++] = READ_ONCE(*(const u64 *)
+				(q + ibmveth_tx_qstat_keys[k].off));
+	}
 }
 
 static void ibmveth_get_channels(struct net_device *netdev,
@@ -2605,8 +2874,10 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 }
 
 static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
-					 struct net_device *netdev)
+					 struct ibmveth_adapter *adapter,
+					 int queue_num)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct ethhdr *ether_header;
 	int ret = 0;
 
@@ -2614,7 +2885,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-		netdev->stats.tx_dropped++;
+		IBMVETH_STAT_INC(adapter->tx_qstats[queue_num].dropped_packets);
 		ret = -EOPNOTSUPP;
 	}
 
@@ -2625,20 +2896,23 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 				      struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	struct ibmveth_tx_queue_stats *txs;
 	unsigned int desc_flags, total_bytes;
 	union ibmveth_buf_desc desc;
 	int i, queue_num = skb_get_queue_mapping(skb);
 	unsigned long mss = 0;
 
+	txs = &adapter->tx_qstats[queue_num];
+
 	/* TX LTBs are freed on shrink; a sender that picked its queue
 	 * before the shrink can get here after the free.
 	 */
 	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
-		netdev->stats.tx_dropped++;
+		IBMVETH_STAT_INC(txs->dropped_packets);
 		goto out;
 	}
 
-	if (ibmveth_is_packet_unsupported(skb, netdev))
+	if (ibmveth_is_packet_unsupported(skb, adapter, queue_num))
 		goto out;
 	/* veth can't checksum offload UDP */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -2649,7 +2923,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
-		netdev->stats.tx_dropped++;
+		IBMVETH_STAT_INC(txs->dropped_packets);
 		goto out;
 	}
 
@@ -2672,7 +2946,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
-			adapter->tx_large_packets++;
+			IBMVETH_STAT_INC(txs->large_packets);
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -2681,7 +2955,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
-			adapter->tx_large_packets++;
+			IBMVETH_STAT_INC(txs->large_packets);
 		}
 	}
 
@@ -2689,7 +2963,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
-		netdev->stats.tx_dropped++;
+		IBMVETH_STAT_INC(txs->dropped_packets);
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -2706,7 +2980,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
-		netdev->stats.tx_dropped++;
+		IBMVETH_STAT_INC(txs->dropped_packets);
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -2715,11 +2989,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 
 	if (ibmveth_send(adapter, desc.desc, mss)) {
-		adapter->tx_send_failed++;
-		netdev->stats.tx_dropped++;
+		IBMVETH_STAT_INC(txs->send_failures);
+		IBMVETH_STAT_INC(txs->dropped_packets);
 	} else {
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
+		IBMVETH_STAT_INC(txs->packets);
+		IBMVETH_STAT_ADD(txs->bytes, skb->len);
 	}
 
 out:
@@ -2887,7 +3161,7 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
 				      int queue_index)
 {
-	adapter->rx_invalid_buffer++;
+	IBMVETH_STAT_INC(adapter->rx_qstats[queue_index].invalid_buffers);
 }
 
 static bool ibmveth_poll_stopping(struct net_device *netdev,
@@ -2909,7 +3183,7 @@ static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
 	rc = ibmveth_rxq_harvest_correlator(adapter, queue_index, true,
 					    correlator);
 	if (unlikely(rc))
-		netdev->stats.rx_dropped++;
+		IBMVETH_STAT_INC(adapter->rx_qstats[queue_index].dropped);
 	return rc;
 }
 
@@ -2922,7 +3196,7 @@ static void ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
 	 * the harvest logs the correlator when it fails.
 	 */
 	schedule_work(&adapter->work);
-	netdev->stats.rx_dropped++;
+	IBMVETH_STAT_INC(adapter->rx_qstats[queue_index].dropped);
 	ibmveth_rxq_harvest_correlator(adapter, queue_index, true, correlator);
 }
 
@@ -2936,7 +3210,7 @@ static void ibmveth_poll_drop_oversize(struct net_device *netdev,
 		netdev_err(netdev,
 			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
 			   off, len, room, queue_index);
-	netdev->stats.rx_dropped++;
+	IBMVETH_STAT_INC(adapter->rx_qstats[queue_index].dropped);
 	ibmveth_rxq_harvest_correlator(adapter, queue_index, true, correlator);
 }
 
@@ -2955,6 +3229,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 				      struct net_device *netdev,
 				      int queue_index)
 {
+	struct ibmveth_rx_queue_stats *rxs = &adapter->rx_qstats[queue_index];
 	struct sk_buff *skb, *new_skb;
 	unsigned int room, off, len, pool;
 	struct ibmveth_buff_pool *bpool;
@@ -3013,7 +3288,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 						    correlator);
 		if (unlikely(rc)) {
 			dev_kfree_skb_any(new_skb);
-			netdev->stats.rx_dropped++;
+			IBMVETH_STAT_INC(rxs->dropped);
 			return -1;
 		}
 		skb = new_skb;
@@ -3021,7 +3296,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 		rc = ibmveth_rxq_harvest_correlator(adapter, queue_index,
 						    false, correlator);
 		if (unlikely(rc)) {
-			netdev->stats.rx_dropped++;
+			IBMVETH_STAT_INC(rxs->dropped);
 			return -1;
 		}
 		skb_reserve(skb, offset);
@@ -3044,7 +3319,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 	    iph_check == 0xffff) {
 		if (!ibmveth_rx_mss_helper(skb, mss, lrg_pkt))
 			csum_good = 0;
-		adapter->rx_large_packets++;
+		IBMVETH_STAT_INC(rxs->large_packets);
 	}
 
 	if (csum_good) {
@@ -3055,8 +3330,8 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 	skb_record_rx_queue(skb, queue_index);
 	napi_gro_receive(napi, skb);
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += length;
+	IBMVETH_STAT_INC(rxs->packets);
+	IBMVETH_STAT_ADD(rxs->bytes, length);
 
 	return 1;
 }
@@ -3083,6 +3358,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
+	/* budget 0 is netpoll; polls stays single-writer. */
+	if (budget)
+		IBMVETH_STAT_INC(adapter->rx_qstats[queue_index].polls);
+
 	while (frames_processed < budget) {
 		if (ibmveth_poll_stopping(netdev, napi))
 			break;
@@ -3178,6 +3457,8 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
 		return IRQ_NONE;
 
+	IBMVETH_STAT_INC(adapter->rx_qstats[qindex].interrupts);
+
 	ibmveth_schedule_rx_queue(adapter, qindex);
 	return IRQ_HANDLED;
 }
@@ -3383,6 +3664,133 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+/**
+ * ibmveth_get_stats64 - Return aggregated per-queue statistics
+ * @dev: network device
+ * @stats: rtnl link statistics storage
+ *
+ * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
+ * rx_missed_errors is the PHYP no-buffer pair (live + retired),
+ * which if_link.h counts separately from rx_dropped.
+ * Walk the full allocated arrays (not the live queue count) so shrinking
+ * channels cannot make the totals go backwards.
+ */
+static void ibmveth_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
+		stats->rx_packets += READ_ONCE(adapter->rx_qstats[i].packets);
+		stats->rx_bytes += READ_ONCE(adapter->rx_qstats[i].bytes);
+		stats->rx_dropped += READ_ONCE(adapter->rx_qstats[i].dropped);
+		stats->rx_missed_errors +=
+			ibmveth_rx_no_buffer_pair(adapter, i);
+	}
+
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++) {
+		stats->tx_packets += READ_ONCE(adapter->tx_qstats[i].packets);
+		stats->tx_bytes += READ_ONCE(adapter->tx_qstats[i].bytes);
+		stats->tx_dropped +=
+			READ_ONCE(adapter->tx_qstats[i].dropped_packets);
+	}
+}
+
+static void ibmveth_get_queue_stats_rx(struct net_device *dev, int idx,
+				       struct netdev_queue_stats_rx *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	u64 no_buffer;
+
+	stats->packets = READ_ONCE(adapter->rx_qstats[idx].packets);
+	stats->bytes = READ_ONCE(adapter->rx_qstats[idx].bytes);
+	/*
+	 * Only frames PHYP itself dropped: the no-buffer pair (live page
+	 * plus pages this queue already released) and slots PHYP handed
+	 * back marked invalid. Frames the driver rejects count in
+	 * rx_dropped instead.
+	 */
+	no_buffer = ibmveth_rx_no_buffer_pair(adapter, idx);
+	stats->hw_drops = no_buffer +
+			  READ_ONCE(adapter->rx_qstats[idx].invalid_buffers);
+	stats->hw_drop_overruns = no_buffer;
+	stats->alloc_fail = READ_ONCE(adapter->rx_qstats[idx].replenish_no_mem);
+}
+
+static void ibmveth_get_queue_stats_tx(struct net_device *dev, int idx,
+				       struct netdev_queue_stats_tx *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
+	stats->packets = READ_ONCE(adapter->tx_qstats[idx].packets);
+	stats->bytes = READ_ONCE(adapter->tx_qstats[idx].bytes);
+	/* TX hw_drops left unset: dropped_packets includes
+	 * software xmit rejects that never reached PHYP.
+	 */
+}
+
+/**
+ * ibmveth_get_base_stats - account for traffic not on a live queue
+ * @dev: network device
+ * @rx: RX base statistics storage
+ * @tx: TX base statistics storage
+ *
+ * get_queue_stats_{rx,tx}() only report queues the core still iterates,
+ * i.e. below real_num_{rx,tx}_queues, while ibmveth_get_stats64() walks
+ * the full arrays so device totals stay monotonic across a shrink.
+ * Report the retired-queue remainder here, otherwise qstats and
+ * rtnl_link_stats64 disagree by a delta that grows with every shrink.
+ * Zeroing would not be neutral: per netdev_stat_ops it asserts the
+ * per-queue sum is already exact.
+ *
+ * Bound the live side with real_num_*_queues rather than the adapter's
+ * own count, so the split lines up with the core's iteration exactly.
+ *
+ * Every field the per-queue callbacks fill must also be initialised
+ * here: netdev_nl_stats_add() starts the sum at NETDEV_STAT_NOT_SET and
+ * only accumulates while both sides are set, so a field left unset here
+ * is dropped from the device total even though the queues report it.
+ */
+static void ibmveth_get_base_stats(struct net_device *dev,
+				   struct netdev_queue_stats_rx *rx,
+				   struct netdev_queue_stats_tx *tx)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	unsigned int i;
+
+	rx->packets = 0;
+	rx->bytes = 0;
+	rx->alloc_fail = 0;
+	rx->hw_drops = 0;
+	rx->hw_drop_overruns = 0;
+	tx->packets = 0;
+	tx->bytes = 0;
+
+	for (i = dev->real_num_rx_queues; i < IBMVETH_MAX_RX_QUEUES; i++) {
+		u64 no_buffer = ibmveth_rx_no_buffer_pair(adapter, i);
+
+		rx->packets += READ_ONCE(adapter->rx_qstats[i].packets);
+		rx->bytes += READ_ONCE(adapter->rx_qstats[i].bytes);
+		rx->hw_drops += no_buffer +
+			READ_ONCE(adapter->rx_qstats[i].invalid_buffers);
+		rx->hw_drop_overruns += no_buffer;
+		rx->alloc_fail +=
+			READ_ONCE(adapter->rx_qstats[i].replenish_no_mem);
+	}
+
+	for (i = dev->real_num_tx_queues; i < IBMVETH_MAX_QUEUES; i++) {
+		tx->packets += READ_ONCE(adapter->tx_qstats[i].packets);
+		tx->bytes += READ_ONCE(adapter->tx_qstats[i].bytes);
+	}
+}
+
+static const struct netdev_stat_ops ibmveth_stat_ops = {
+	.get_queue_stats_rx	= ibmveth_get_queue_stats_rx,
+	.get_queue_stats_tx	= ibmveth_get_queue_stats_tx,
+	.get_base_stats		= ibmveth_get_base_stats,
+};
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -3395,6 +3803,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 };
 
 /**
@@ -3433,6 +3842,23 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
 		wait_for_completion(&adapter->rx_buff_pool[0][i].released);
 }
 
+static void ibmveth_probe_cleanup(struct ibmveth_adapter *adapter,
+				  int pools_ready)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	cancel_work_sync(&adapter->work);
+	ibmveth_put_pool_kobjs(adapter, pools_ready);
+
+	ibmveth_free_tx_qstats(adapter);
+	ibmveth_free_rx_qstats(adapter);
+	/* Probe failure never reaches ibmveth_remove(); clear before free
+	 * so drvdata does not outlive the netdev.
+	 */
+	dev_set_drvdata(&adapter->vdev->dev, NULL);
+	free_netdev(netdev);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len, pools_ready = 0;
@@ -3497,9 +3923,16 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netif_napi_add_weight(netdev, &adapter->napi[i],
 				      ibmveth_poll, 16);
 
+	if (ibmveth_alloc_rx_qstats(adapter) ||
+	    ibmveth_alloc_tx_qstats(adapter)) {
+		ibmveth_probe_cleanup(adapter, 0);
+		return -ENOMEM;
+	}
+
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
 	netdev->ethtool_ops = &netdev_ethtool_ops;
+	netdev->stat_ops = &ibmveth_stat_ops;
 	SET_NETDEV_DEV(netdev, &dev->dev);
 	netdev->hw_features = NETIF_F_SG;
 	if (vio_get_attribute(dev, "ibm,illan-options", NULL) != NULL) {
@@ -3634,8 +4067,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	return 0;
 
 err_put_pools:
-	ibmveth_put_pool_kobjs(adapter, pools_ready);
-	free_netdev(netdev);
+	ibmveth_probe_cleanup(adapter, pools_ready);
 	return rc;
 }
 
@@ -3658,6 +4090,9 @@ static void ibmveth_remove(struct vio_dev *dev)
 			ibmveth_release_lan_resources(adapter);
 	}
 
+	ibmveth_free_tx_qstats(adapter);
+	ibmveth_free_rx_qstats(adapter);
+
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 393d37add10c..76640bd5598e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -283,6 +283,46 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
+/*
+ * Per-queue RX counters. No field has two concurrent writers:
+ * interrupts is written only from this queue's IRQ handler; polls,
+ * packets, bytes, large_packets, invalid_buffers and dropped only from
+ * its NAPI poll (polls not from netpoll's budget-0 call);
+ * replenish_* only under its replenish_lock; and no_buffer_drops and
+ * no_buffer_retired only under that lock. Readers snapshot that pair
+ * under the same lock. No atomic or u64_stats_sync is therefore
+ * needed: the driver is PPC64-only, so 64-bit loads and stores do not
+ * tear. Readers still run locklessly on other CPUs, so writers use
+ * IBMVETH_STAT_INC()/IBMVETH_STAT_ADD() and readers READ_ONCE(), which
+ * keeps the compiler from splitting or refetching the accesses.
+ */
+struct ibmveth_rx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 interrupts;
+	u64 polls;
+	u64 large_packets;
+	u64 invalid_buffers;
+	u64 dropped;
+	/* PHYP's per-page absolute drop count for the live page. */
+	u64 no_buffer_drops;
+	/* Absolutes from pages this queue has already retired. */
+	u64 no_buffer_retired;
+	u64 replenish_task_cycles;
+	u64 replenish_no_mem;
+	u64 replenish_add_buff_failure;
+	u64 replenish_add_buff_success;
+} ____cacheline_aligned_in_smp;
+
+/* Per-queue TX counters; serialized by the stack's per-queue TX lock. */
+struct ibmveth_tx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 large_packets;
+	u64 dropped_packets;
+	u64 send_failures;
+} ____cacheline_aligned_in_smp;
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -347,17 +387,17 @@ struct ibmveth_adapter {
 	u64 fw_ipv6_csum_support;
 	u64 fw_ipv4_csum_support;
 	u64 fw_large_send_support;
-	/* adapter specific stats */
-	u64 replenish_task_cycles;
-	u64 replenish_no_mem;
-	u64 replenish_add_buff_failure;
-	u64 replenish_add_buff_success;
-	u64 rx_invalid_buffer;
-	u64 rx_no_buffer;
+	/*
+	 * Every other ethtool -S counter lives in rx_qstats/tx_qstats and is
+	 * summed on read. tx_map_failed predates multi-queue, has never been
+	 * updated by any code path, and is kept only so the key keeps
+	 * reporting the zero userspace already sees.
+	 */
 	u64 tx_map_failed;
-	u64 tx_send_failed;
-	u64 tx_large_packets;
-	u64 rx_large_packets;
+
+	struct ibmveth_rx_queue_stats *rx_qstats;
+	struct ibmveth_tx_queue_stats *tx_qstats;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)


