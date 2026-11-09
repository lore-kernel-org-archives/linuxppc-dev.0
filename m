Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D610606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4NJBitw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsB11D5z2xns;
	Tue, 10 Nov 2026 10:56:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268590;
	cv=none; b=CJGq1jnFxSrppyB720wTmeqc9TFBey/iApB2eHZJnYaaaq24W8wMDDkTwR+CI1YpFNHV2hlcmq42DoGEoSqr+QHbtghymUzjQv4bV7w7/Iklh9DVHYvFjHUtBnn33nOTRB1VxbKXVRQzjtdO48CNJBZWUIgQSeYcEPKLPfE/hvrRzMKnbjHLsl+Hniwlm50D4q+ztMjSwm5nSlRuzEgkVd1Vki4Du9PkIf5PXYK/b8BcI+x3SvXgSeMhjqnx1sK714zldo9dFzUjRO1wCm0QLgGUKb8rnOaU1wunsDeadoosJtQupvbscsl+jXqikSLHeJ2ZhFP/+blXJykoeXNzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268590; c=relaxed/relaxed;
	bh=fc3xgMoVJ+Z0pQKIvdskwV42JM1Myfbtedpu947h7Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cTBwbGggW7EXKW+O7GRWM39JSGd0r48tNtFEs57xMg4EpiNmML7kFN/5L0l36xlFN0C3FkmDV+GF1hrmo3c4YACY65X5ZDnC/D8KOg2o13UJvShxZeqZ7DcXb1RkuRcKz6OTB7cCiigcnvr9x0flavYZ4zo1yH3P+f48/adkIZotQJGuFWhJfJOKV8IJ4eAsgptUFo0lQxcjVCASKnRXIYAC4FucWUzT3XQbcHjpMmB6f/2QQY2DMlWV1c/1FnCx/1iyb/uA+kK8l4ogGcY0lgOQ/JRiehPa2DS5C902//XY9x8VV9U8Ba4VyDhbw8NAknvR1KFuCe+rnRiYcup/hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4NJBitw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4NJBitw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNms75cr7z2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:27 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LELLP3484442;
	Mon, 9 Nov 2026 23:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fc3xgMoVJ+Z0pQKIvdskwV42JM1Myfbtedpu947h7
	Ys=; b=b4NJBitwBl8hMKpR1C6zVtxxQZmboXUFvFxPBWV9h/M9cY7mr431rnbrP
	a53cYabcjPdV0N5xEv08flZXTf8o96t6jWCffeTub+n5rnIQ2jQ1TrQWnz7RETKN
	gsi7t51QXsUlJrtG6+xDeCmnc6wxfvdcrEnaCCQ+41lF6APiXrr5wThoTuiLLVc+
	e1gA8FMCTgteyhWTgfeuyIOTFLpIJjNDXnoRgVKIz2fOIQtjXI7I6Z9jEfl6/zMs
	R6EyJoCcmRew2Sut7kKjp2jCfQyduUTMOBygy0/lvbIV5/GHQUtlmFRchJGiPUye
	WR22K5SiqJyVVBYOPDKe/fL96l39g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg2169-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LK2KV715559;
	Mon, 9 Nov 2026 23:56:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak4d9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Nu4Ys19137028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E7958028;
	Mon,  9 Nov 2026 23:56:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 292BA58017;
	Mon,  9 Nov 2026 23:56:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:00 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 00/15] ibmveth: Add multi-queue RX support
Date: Mon,  9 Nov 2026 15:55:41 -0800
Message-Id: <20261109235556.60604-1-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af25d97 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=c92rfblmAAAA:8 a=qG2clzYjeD1B5d1RadEA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=YTcpBFlVQWkNscrzJ_Dz:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX4fAHso4+uHhj
 tLX1ccPxzoM0xrcL5Zqa0i6G/wdZKiIbYpXToAzsdh0gXVb6WgVwlKlO9BN5HterWZ+dVV6DNsR
 cyvOojoqVlrCPPiQpmgskBjCJkl55Ef+deNbD/j/nXDNhV+5Yd4WjGdGL42H6VTj+ojhnMgI7t9
 qcwir1Q7US9We0aVpk9eH9YRhdLmYErn7mJUiYCs0fIz+ob/ubUwxsBMZMN0+MVdK601YiSKyd6
 2DVT1Jt9bWMw7TEPWnqOWEk/n1kifLFUeqHAESVmaxAUVHWpFUu061bbngfhoDQYyNf2MOpzu2M
 2QNBat6+51tU/RxFzKhbg7+aIMLROtz3TeAKZ3uJD5ig0mNYhXEFaZ9ngFipodkH7VWSDOAwgqb
 r/9eFUWIne08DB5yMP8GVSj1U39V1V2tVbXpES1o+DAJlrIGXYZilCHDk0NQBNG72lAGRlFuWMR
 AS+JIwsuRCj198lX5GA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXzWA5JXddJmuE
 yt2GHKIC33GL+wHStngbunaJWzODa5IWHn8/6+e/JklG5BTx3yqmVExxu2tXq2m4Cgpp1KXc5Og
 8k4QS+2dnSvHAIQFA9rSxxk0Osoi9Bc=
X-Proofpoint-GUID: AquKjavMDO5dcC2N81ZgcQFfRRExBtlo
X-Proofpoint-ORIG-GUID: I6QtE9nPC9BbHt16mW9jlRFnRLfmJI2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
packets/bytes and RX drops via netdev_stat_ops, with ndo_get_stats64
as the aggregate (including queues since removed); and a read-only
debugfs buffer_pools dump. ethtool -S keeps its existing keys and adds
per-queue driver counters (rx%d_interrupts, rx%d_polls,
rx%d_large_packets, rx%d_invalid_buffers, tx%d_send_failures).
rx_no_buffer is now cumulative across close/open instead of the
current buffer-list page's count, and no-buffer drops show up as
rx_missed_errors. poolN/ sysfs is unchanged.

This version is based on net-next, which now has the two open()
error-path fixes (af0524bf4ce1, 84bec0bf0352) and the nine ibmveth
fixes that came out of the v7 review (merge d53a5309cc4a, [1]). The
MQ patches extend that handling per queue instead of carrying their
own copy, so this series no longer fixes single-queue bugs. Patch 5
makes the wait from commit 3f872b34368c ("ibmveth: wait for the RX
poll to return before freeing the RX queue") per queue, and patch 9
keeps the header checks from commit 9486c89a8e15 ("ibmveth: check
headers in the RX large send and checksum helpers").

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
        IRQ, TX, PHYP register (open/close 3-7); buffer submit (8);
        split RX poll helpers for MQ (9)
  10    Enable MQ datapath at probe/open (subordinate register helpers
        land here with first use)
  11-13 Per-queue RX/TX stats; get_channels MQ counts; debugfs buffer_pools
  14    Incremental RX resize; live ethtool -L rx
  15    Down-path publish

- Helper patches (3-7) reshape ibmveth_open()/close() into
  queue-aware helpers; patch 8 adds the queue-aware buffer submit used
  by replenish. Patch 9 splits the SQ poll path into per-slot helpers
  for MQ; it does not change open/close. MQ stays off
  through 3-9: num_rx_queues stays 1 and multi_queue is false until
  patch 10. The live single-queue path still changes where the review
  required it (IRQ teardown wait and remask, replenish lock, poll
  harden).
- Patch 10 is the switch: probe sets multi_queue from firmware and
  raises num_rx_queues; open() registers the subordinate queues and
  replenishes every active queue.
- Patch 11 moves counters per queue and exports packets/bytes and RX
  drops through netdev_stat_ops. The existing -S keys stay, and
  per-queue driver keys are added.

Testing:

W=1 ibmveth.o at every commit (plain and KUnit), KUnit 5/5 at tip
(qemu pseries).

ppc64le PowerVM LPARs on POWER11, MQ and legacy firmware, all passing
on this version:
* channels: ethtool -l/-L with the interface up and down,
  mq_fallback, module reload
* stats: qstats vs ethtool -S vs ip -s link; counters across
  ifdown/up and queue removal
* resize under iperf3 RX+TX: ethtool -L 1..16 with RX spread checked
  at each step, and -L cycling in parallel with ifdown/up
* close/open under iperf3 load (MQ and rx 1)
* rx 1 on MQ firmware and legacy firmware: ifdown/up churn, soak,
  stats

Changes in v8:

Same 15 patches as v7, rebased onto net-next, which now carries the
open-fail pair and the nine ibmveth fixes. v7's in-tree copies of
those single-queue fixes are gone; the per-patch --- notes list what
each commit dropped and which merged commit owns it. The rest comes
from the v7 review and our own re-review.

Code changes:
* Patch 4: a pool-alloc failure in open() unwinds through
  h_free_logical_lan(), as the merged open-fail fix does.
* Patch 5: teardown runs synchronize_net() after napi_disable(), then
  remasks and frees the IRQ; close() keeps net-next's no_buffer order.
* Patch 6: open() starts with netif_tx_disable() and starts the TX
  queues under netif_tx_lock_bh(), since NAPI and generic XDP_TX are
  already live.
* Patch 7: queue_registered[] marks a live slot (handle 0 is valid);
  ibmveth_register_logical_lan() returns long.
* Patch 8: replenish_lock is spin_lock_bh(); poll reads each
  correlator once and harvest resets on a bad one.
* Patch 9: bad and oversize slots count rx_dropped and consume budget;
  a poll that uses its whole budget returns without completing NAPI.
* Patch 10: in MQ mode a hard H_FREE_LOGICAL_LAN failure keeps the LAN
  memory mapped until the next open() or remove() frees it; poolN
  writes return -EBUSY meanwhile. Single queue still unmaps.
  restart_rx_queue() no longer unmasks PHYP; apply_mq_fallback() sets
  real_num to 1; set_channels rejects an RX change until patch 14.
* Patch 11: counters use WRITE_ONCE()/READ_ONCE(); no_buffer is
  retired at every unmap, so no counter goes backwards; three
  per-queue -S keys are dropped.
* Patch 12: max_rx is the live rx_count, not a fixed 1, on single
  queue or once mq_fallback is set.
* Patch 14: live -L waits after napi_disable() before remasking and
  rolls RX back if TX fails; a rollback whose set_real() fails skips
  the unmask, and scale-up unmasks only through enable_irq(). A queue
  stranded by a failed scale-up is freed after the next successful
  H_FREE_LOGICAL_LAN.
* Patch 15: the down-path returns -EBUSY if a queue in the new range
  is still registered.

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
  7, 8, 9, 10, 11, 12, 14 and 15 (patch 1 also names the new hcalls in
  the perf powerpc-hcalls script and documents H_BUSY on the register-queue
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

[1] https://patch.msgid.link/20261013182926.30417-1-mmc@linux.ibm.com

---
v7 lore:
  https://lore.kernel.org/r/cover.1790319558.git.mmc@linux.ibm.com
Sashiko NIPA (v7):
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc@linux.ibm.com
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
v7: https://lore.kernel.org/r/cover.1790319558.git.mmc@linux.ibm.com
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
  ibmveth: Split RX poll into per-slot helpers for MQ
  ibmveth: Enable multi-queue RX receive path
  ibmveth: Add per-queue RX and TX statistics collection
  ibmveth: Report MQ-aware RX counts in ethtool get_channels
  ibmveth: Expose per-queue buffer pool details via debugfs
  ibmveth: Implement incremental MQ RX queue resize
  ibmveth: Complete set_channels down-path

 arch/powerpc/include/asm/hvcall.h   |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c  | 5007 ++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h  |  240 +-
 tools/perf/python/powerpc-hcalls.py |    4 +
 4 files changed, 4318 insertions(+), 939 deletions(-)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.50.1 (Apple Git-155)


