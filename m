Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1566607180E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BT5ktn03
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmtP5Kmvz30V0;
	Tue, 10 Nov 2026 10:57:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268653;
	cv=none; b=jBb0JAt3FClAhcD9DaW91/RHoe0HUA8k2r6jsezGzIjsgbdQ/YAput9Uubmx+UibAqtLgwGLljFj1qP2BPc73z+2faaeOoqoiDaYrLDqpeXlId18HXZuwQ/kt6iQGPLcidQ06ZDof7ppCWm/o3EkLGRs8sFZOjKSJ7jxoJYq35f+d6MMPe3O6MKvZv7gPx+BToGr4si8tyOE855QZ/utAAyIw2DYgUIu9AIfVtfEGimNZmgYyC+hqDk0CNEeQ3hOVQDx4v+codCuBZ3+K1th0QBFj0KgysaPN3oXkPwmfDdd1cP5wXL9qQ6Umhp+BMUYBht4Se5m1VJWCLwIRyo1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268653; c=relaxed/relaxed;
	bh=Wm5NOf2+BnLNhkGuGJppaOxsAzma4xv3p1c2rm5yjTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b03OBuPQGUk9nnJaINg37Z27fUsQFc5Zgjg0p+P3gAr6wPgYEPsHjrWPv3NlBCpWwsh6nINWY3qW0r+V/+7saxFDr/fZxX2ppqneBkYGDZ6tAgt8PumdDPlVxfPaJsVOJ9uwWqVMYl+F8f1xyt3IzSCwPo3nsTDSsqSZ+mcRjASA8G4UCXdCBgR+oS0elQtqQiUD7gSUiHHLIONO8qeXCWpbCcY3yLUgS9WLcdlzTPzUMY+R3M9rhTrMxHqOTnSlautge4Pds+IEc675A4bL7wMP+Z+45cXOBqOrThCFI7mW5keSJBm6o7tJvZh9gVOhUhoEU/DTglxE4cYUu4RcGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BT5ktn03; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BT5ktn03;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmtL2ww8z30Tm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:57:30 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LE8DR502399;
	Mon, 9 Nov 2026 23:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Wm5NOf2+BnLNhkGuG
	JppaOxsAzma4xv3p1c2rm5yjTc=; b=BT5ktn03TuiJSsN2u+uHRdp6u92z0lh3z
	Mtny4YjvlB8pGSf/IfkOLZ24MMk+hom0oSUALgvsKwzly5QYUOKSuM46BwI3dNUU
	vv//J82U5x1Z7uhWJP7GgaGqDsxDx3B86tT29aDqM1jDJOLBRoAblrJykxUPB8g5
	k5UrTiq4jGESMoqJX3BrIQguzLGqJKM5ss0pU/1XnO5rY739QW2QviGOf8UIdSnu
	0vScGzKuf3Y1gDvmrrAK3VhhObTPyIEdaW9g84qKWyBOhtz81bf7HrjKxM83JxPo
	LOgdqyMGswm5abeUy3wQ/JYOEyhn8IT/U19HnAxIvp4oz+VEZ2uQQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6ta2f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJxqH715427;
	Mon, 9 Nov 2026 23:57:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak4dce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:57:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NvEGw27394644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:57:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D480F58017;
	Mon,  9 Nov 2026 23:57:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85AA858028;
	Mon,  9 Nov 2026 23:57:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:57:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 14/15] ibmveth: Implement incremental MQ RX queue resize
Date: Mon,  9 Nov 2026 15:55:55 -0800
Message-Id: <20261109235556.60604-15-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX4lDTJ4FruJsb
 YZZ1NyR7iU042NeoPCqxCnQOojc0k1IulyL35rPMzpNMWNysF4jtsfpX3/4BwpVUeR05dp5pO4v
 3V8gEtGx6Qgknngs2kN+FEeHd1WNN1k=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af25ddd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cz-S7UFTOWUvUmpALmAA:9
X-Proofpoint-ORIG-GUID: -Qex5pkA3L1YhNXuTO-SkwupYboTaPgr
X-Proofpoint-GUID: 5c8WfobEii3ydKC1tB56rHx9nRZyL2Dq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX6IRD0VyvZwR/
 ls6eHqm1TpUNrQUNSzCskFsj+eC1LUoh+TTYF8b6dgikTQDQuGGgL9lwSrpb3okt0WA2N2RLTpg
 f51Xi1CYyvijc9qbGsZ3Uf4DNYrWPq5rvmpXjIQTFcvDhZwkZJn6ngwkmpvTY1Ian6aQl47qn9M
 wKThHF307MREtRmEDfx1CGhBxx3cYvFdfRzImRIIpoiUENFNp9y5nbMBlNMQQ5/dgbDoIaLKuRe
 kYcazlIrlzD1SAXHUor5XFOQ3Px10WTypVyMDD9VxHy5u/w5axe/Il/To4ESLeUz5lv5KZ/owra
 H1mH6O04MRY7g/jI7fnFMdglJeIxdYf7KUkPCO8VCW4DnGq9GmnztOKR794zPw99KKwFVai6OLQ
 gReRQbEPeUE7x/gWkutRwZYtTYScin5ZUNHFe7brhVNI9RLjYXFjAL/BdXtoB3sY4isbYnbTSTX
 QsRFWhsBaYwd29RS5Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ethtool -L can now change the RX queue count while the device is up,
one queue at a time, without a full close/open:

  - scale-up: for each new queue, allocate it, register it with PHYP,
    set up its IRQ, then publish the count, replenish, enable NAPI
    and unmask PHYP.
  - scale-down: quiesce the retiring queues, drain them, publish the
    smaller count, then deregister each with H_FREE_LOGICAL_LAN_QUEUE
    and free it.
  - failure: either direction unwinds to a consistent live count. A
    queue that PHYP will not release stays mapped, either kept in the
    live set or parked above it until the next H_FREE_LOGICAL_LAN.
  - entry: set_channels() calls ibmveth_resize_rx_channels(), which
    validates the request; a combined -L resizes RX first and rolls
    RX back if TX fails. A change while down is still rejected until
    the next patch.

Add ibmveth_resize_rx_queues_incremental() so the live RX channel
count can change without a full device tear-down, and
ibmveth_resize_rx_channels() as the entry point set_channels() calls.
The two directions live in ibmveth_scale_up_rx_queues() and
ibmveth_scale_down_rx_queues(); the incremental helper validates the
request, dispatches to one of them, and refreshes CMO on success.

Scale-up works one new queue at a time: allocate its DMA buffer list
and pool memory, register it with PHYP via H_REG_LOGICAL_LAN_QUEUE,
map its subordinate IRQ and request it, then bring it up: publish the
count, replenish, enable NAPI, and only then unmask PHYP, so the handler
cannot run on an unpublished, empty or NAPI-disabled queue. It
finishes with the same restart helper open() uses, so a total
replenish miss can still get a poll to retry.

Widen netif_set_real_num_rx_queues() to the target count before any
new queue is unmasked, so a frame on a new queue cannot carry an rx
queue index above real_num_rx_queues. Scale-up failure restores
real_num to the surviving count.

Scale-down masks PHYP on the retiring queues first, then disables NAPI,
waits for the poll tail with synchronize_net(), then masks and
synchronises again: napi_disable() does not wait for a poll past
napi_complete_done(), which can still re-arm PHYP; napi_disable() also
keeps netpoll's poll_napi() off the retiring queues. The scale-up
unwind does the same. Scale-down then drains the ring,
publishes the surviving count with smp_store_release() and calls
synchronize_net(), then netif_set_real_num_rx_queues().

Once real_num is lowered, it deregisters via
H_FREE_LOGICAL_LAN_QUEUE, takes the queue's final no_buffer sample
under its replenish_lock while the page is still mapped, releases
the IRQ mapping and frees the DMA and pool memory. That last sample
skips the live-count bound the replenish path uses, since the count
was already lowered. Deregistration has to precede the unmap so PHYP
releases ownership of the buffers while the queue metadata its
correlators index is still valid. If the free
hcall fails, leave the handle set and skip the unmap.
H_PARAMETER from H_FREE_LOGICAL_LAN_QUEUE means the unit has no
logical LAN or the handle names no registered queue (already freed),
as the PHYP interface defines it and the wrapper kdoc records: clear
the handle and unmap. Destroy walks high-to-low so a failed free keeps
0..i live, publishes that count,
and restores NAPI/IRQ on the queues it could not remove.

Scale-up register failure matches that skip-unmap rule: if IRQ
mapping fails after H_REG and the matching H_FREE fails, keep the
handle so the caller does not unmap. Scale-up enable_irq failure
that cannot destroy the new queue keeps that queue in the live set
with the queues this -L already added, instead of publishing below
it and orphaning the mapping, and sizes CMO desired for that count.

A scale-up register or IRQ-setup failure whose H_FREE also fails
leaves that queue above the live count with queue_registered[]
set (the cookie may be 0). ibmveth_free_stranded_rx_queues()
frees such slots after a successful H_FREE_LOGICAL_LAN, which drops
every subordinate queue, retiring each one's no_buffer sample first:
in close(), and in the open() and remove() H_FREE retry that the MQ
enable patch added for a hard H_FREE_LOGICAL_LAN failure. Until then
a scale-up that reaches that index returns -EBUSY.

Whenever the caller is going to unmap a live queue, its final
no_buffer sample is taken first. The scale-up register and IRQ-setup
unwinds free a queue they registered moments earlier without that
sample, so drops PHYP counted in its page in that window are not
added.

As in the MQ enable patch, a hard H_FREE_LOGICAL_LAN failure keeps
the LAN memory mapped only in multi-queue mode; single-queue keeps
the base close() behaviour of logging and unmapping (one reason it
cannot simply keep the memory mapped is the vio_cmo_bus_remove()
BUG() on outstanding IO entitlement on a CMO partition). The new
scale-up H_FUNCTION fallback below latches mq_fallback, and the next
open() then clears multi_queue, which puts the adapter on that
single-queue rule.

Both directions unwind. Scale-up failures jump to cleanup_new_queues:,
which restores real_num to the surviving count and destroys only the
queues this call created. Scale-down failures republish the remaining
count, then replenish, napi_enable and unmask each retiring queue that
stays (and restart it if the IRQ comes back). If the IRQ cannot be
re-enabled they schedule a reset.
If growing real_num back to the surviving count fails after it
was lowered, skip the unmask; still napi_enable so close/reset
is not a second napi_disable hang. Reset is already queued. The
scale-down path that failed to lower real_num still re-enables:
those indexes stay in range.

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

A combined ethtool -L resizes RX first. If TX does not reach
the request, restore the previous RX count (best effort: a failed restore
is logged) and return rc ? rc : -ENOMEM so the call cannot report
success with RX committed and TX unchanged. An RX count change
while not opened is
rejected with -EOPNOTSUPP here rather than reported as success and
discarded; the following commit publishes the down-path count and
lifts the rejection.

The keep path can leave queues above real_num_rx_queues with NAPI
still enabled and PHYP masked. Bound every path that could reach them
by real_num: poll records an RX queue index only below it, and poll
completion does not enable_irq above it (that would undo the skipped
unmask); interrupt() returns IRQ_NONE above it rather than scheduling
NAPI; resume() walks min(num_rx_queues, real_num_rx_queues).
ibmveth_schedule_rx_queue() skips an index at or past the live count
without a WARN, since a shrink can race resume()'s walk.

Deregister and the scale-up -EBUSY check key off
queue_registered[], not a zero handle. Handle 0 can still be
a live cookie.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- scale-down and the scale-up unwinds: synchronize_net() after
  napi_disable(), then remask; if set_real(keep) fails after real_num
  was lowered, skip the unmask but still napi_enable()
- a combined ethtool -L rolls RX back, best effort, if TX fails (moved
  here from patch 15)
- H_FREE_LOGICAL_LAN_QUEUE H_PARAMETER (already free) clears the slot
  and unmaps
- a slot stranded by a scale-up failure is freed (no_buffer retired
  first) after the next successful H_FREE_LOGICAL_LAN in close(),
  open() or remove()
- deregister and the scale-up -EBUSY check key on queue_registered[],
  not a zero handle; scale-down retires no_buffer after a successful
  H_FREE_LOGICAL_LAN_QUEUE
- keep path: poll, completion, interrupt and resume honour real_num;
  CMO desired is refreshed before -EIO
- scale-up unmasks only through enable_irq(), as restart_rx_queue() no
  longer unmasks (patch 10)

Dropped from this series (merged fixes own them):
- commit 8d9ecac6b96e: comments that cited ndo_poll_controller
- commit 95811c873d1b: set_channels IFF_UP -> adapter->opened. It
  already gates set_channels() on opened

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
  stay -EOPNOTSUPP once mq_fallback

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

- wrap close() TX-LTB free comment to 80 cols (two-step)

 drivers/net/ethernet/ibm/ibmveth.c | 1152 ++++++++++++++++++++++++++--
 1 file changed, 1078 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index e805e7b1d2fe..510d9d80e2df 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -807,25 +807,90 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
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
+			 0, ibmveth_queue_irq_name(adapter, queue_idx),
+			 &adapter->napi[queue_idx]);
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
+ * mapping. Used during incremental scale-down and on scale-up
+ * destroy via ibmveth_destroy_subordinate_rx_queue().
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
  * @qindex: RX queue index
  *
  * Shared by the IRQ handler and process-context kick sites (open, resume,
- * pool sysfs).
+ * pool sysfs, and ethtool -L scale-up, keep and rollback through
+ * ibmveth_restart_rx_queue()).
  *
- * Does nothing if the index is out of range (WARN_ON) or
- * napi_schedule_prep() fails (NAPI already scheduled, or disabled
- * because the device is closed). A failed
- * disable_irq() is logged by the helper; the queue may stay unmasked.
+ * Does nothing if the index is negative (WARN_ON), past the live count
+ * (quiet: a shrink can race resume()), or napi_schedule_prep() fails
+ * (NAPI already scheduled, or disabled because the device is closed).
+ * A failed disable_irq() is logged by the helper; the queue may stay
+ * unmasked.
  */
 static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
 				      int qindex)
 {
 	struct napi_struct *napi = &adapter->napi[qindex];
 
-	if (WARN_ON(qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter)))
+	if (WARN_ON(qindex < 0))
+		return;
+
+	/*
+	 * A live shrink can publish a lower count while resume() walks a
+	 * snapshot of the old one, so an index past the end is expected
+	 * here and must not splat. ibmveth_replenish_task() skips the
+	 * same way.
+	 */
+	if (qindex >= ibmveth_get_num_rx_queues(adapter))
 		return;
 
 	/*
@@ -1181,18 +1246,17 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 /*
  * The final 8 bytes of the buffer list is a counter of frames dropped
  * because there was not a buffer in the buffer list capable of holding
- * the frame.
+ * the frame. No live-count bound: retire samples a queue scale-down has
+ * already unpublished but not yet freed.
  */
-static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
+static void ibmveth_sample_rx_no_buffer(struct ibmveth_adapter *adapter,
 					int queue_index)
 {
 	struct ibmveth_rx_queue_stats *qstats;
 	__be64 *p;
 	u64 drops;
 
-	if (queue_index < 0 ||
-	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
-	    !adapter->buffer_list_addr[queue_index])
+	if (!adapter->buffer_list_addr[queue_index])
 		return;
 
 	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
@@ -1206,6 +1270,15 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
 	WRITE_ONCE(qstats->no_buffer_drops, drops);
 }
 
+static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
+					int queue_index)
+{
+	if (queue_index < 0 ||
+	    queue_index >= ibmveth_get_num_rx_queues(adapter))
+		return;
+	ibmveth_sample_rx_no_buffer(adapter, queue_index);
+}
+
 /* Snapshot live+retired under replenish_lock; see retire_rx_no_buffer(). */
 static u64 ibmveth_rx_no_buffer_pair(struct ibmveth_adapter *adapter, int i)
 {
@@ -1220,10 +1293,16 @@ static u64 ibmveth_rx_no_buffer_pair(struct ibmveth_adapter *adapter, int i)
 	return drops + retired;
 }
 
-/*
- * Call whenever the caller is about to unmap the buffer-list page.
- * Take the last sample, then fold it into retired so the next page
- * cannot overwrite the total.
+/**
+ * ibmveth_retire_rx_no_buffer - Fold the page drop counter before unmap
+ * @adapter: ibmveth adapter
+ * @queue_index: RX queue index
+ *
+ * Sample the buffer-list tail while the page is still mapped, then move
+ * the live absolute into retired. Call whenever the caller is about to
+ * unmap the buffer-list page.
+ * ibmveth_sample_rx_no_buffer() has no live-count bound so scale-down
+ * can sample queues already unpublished.
  */
 static void ibmveth_retire_rx_no_buffer(struct ibmveth_adapter *adapter,
 					int queue_index)
@@ -1232,7 +1311,7 @@ static void ibmveth_retire_rx_no_buffer(struct ibmveth_adapter *adapter,
 	struct ibmveth_rx_queue_stats *qstats;
 
 	spin_lock_bh(&rxq->replenish_lock);
-	ibmveth_update_rx_no_buffer(adapter, queue_index);
+	ibmveth_sample_rx_no_buffer(adapter, queue_index);
 	qstats = &adapter->rx_qstats[queue_index];
 	IBMVETH_STAT_ADD(qstats->no_buffer_retired, qstats->no_buffer_drops);
 	WRITE_ONCE(qstats->no_buffer_drops, 0);
@@ -1339,8 +1418,9 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
  * completes, so do not unmask here: while NAPI is scheduled the handler
  * cannot remask, and PHYP would interrupt once per frame. Replenish
  * first so the queue has buffers to deliver into.
- * Also used after every open (SQ and MQ) so a queue is not left
- * idle+masked.
+ * Also used after every open (SQ and MQ), after each successful
+ * scale-up queue bring-up, and on the scale-up keep and
+ * scale-down rollback paths.
  */
 static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
 				     int qindex)
@@ -1546,6 +1626,142 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
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
+ * Used by scale-down, the scale-up unwind and the stranded-queue
+ * cleanup; other queues are not touched.
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
 /* The correlator comes back from PHYP, so check it rather than trust it.
  * Does not log: remove_buffer_from_pool() calls it under replenish_lock.
  */
@@ -1717,6 +1933,65 @@ static int ibmveth_rxq_harvest_correlator(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
+				      int queue_index, bool reuse)
+{
+	return ibmveth_rxq_harvest_correlator(adapter, queue_index, reuse,
+			ibmveth_rxq_read_correlator(adapter, queue_index));
+}
+
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
@@ -1881,7 +2156,8 @@ static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
  * Registers a subordinate receive queue using H_REG_LOGICAL_LAN_QUEUE.
  * On success, stores the queue handle and virtual IRQ in the adapter.
  * If IRQ mapping fails after a successful hypervisor registration, the
- * queue is freed before returning.
+ * queue is freed before returning. If that free fails, the handle is
+ * kept so the caller can skip unmap.
  *
  * Return: H_SUCCESS on success, negative errno on IRQ mapping failure,
  *         hypervisor error code otherwise
@@ -1921,10 +2197,20 @@ ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
 				free_rc = h_free_logical_lan_queue(ua, handle);
 			} while (H_IS_LONG_BUSY(free_rc) ||
 				  (free_rc == H_BUSY));
-			if (free_rc != H_SUCCESS)
+			if (free_rc != H_SUCCESS &&
+			    free_rc != H_PARAMETER) {
 				netdev_err(adapter->netdev,
 					   "h_free_logical_lan_queue failed for queue %d after IRQ map failure: rc=0x%lx\n",
 					   queue_index, free_rc);
+				/*
+				 * PHYP still owns this queue. Keep the
+				 * handle so the caller skips unmap.
+				 */
+				ibmveth_set_rx_queue_handle(adapter,
+							    queue_index,
+							    handle);
+				return -EIO;
+			}
 			return -EINVAL;
 		}
 
@@ -1940,9 +2226,10 @@ ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
 
 	/*
 	 * H_FUNCTION means firmware rejected this subordinate register
-	 * (MQ unsupported / dropped after LPM). Caller fails this open and
-	 * latches mq_fallback so the next open applies SQ; keep a specific
-	 * log then the generic failure lines below.
+	 * (MQ unsupported / dropped after LPM). The caller (open or
+	 * ethtool -L scale-up) fails and latches mq_fallback so the next
+	 * open applies SQ; keep a specific log then the generic failure
+	 * lines below.
 	 */
 	if (lpar_rc == H_FUNCTION)
 		netdev_err(adapter->netdev,
@@ -2028,6 +2315,644 @@ static void ibmveth_release_lan_resources(struct ibmveth_adapter *adapter)
 	ibmveth_free_filter_list(adapter);
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
+ * Return: 0 if the queue was freed or was not registered, -EIO if
+ *         H_FREE_LOGICAL_LAN_QUEUE failed. On -EIO the slot stays
+ *         registered so the caller can skip unmap. Handle 0 is a
+ *         live cookie; do not use it as "unregistered".
+ *
+ * H_PARAMETER is no-adapter or already-free, same as
+ * H_FREE_LOGICAL_LAN: clear the registered flag and return 0 so
+ * the caller can unmap.
+ */
+static int
+ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
+				   int queue_idx)
+{
+	unsigned long lpar_rc;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long qh = adapter->queue_handle[queue_idx];
+
+	if (!adapter->queue_registered[queue_idx])
+		return 0;
+
+	do {
+		lpar_rc = h_free_logical_lan_queue(ua, qh);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		if (lpar_rc == H_PARAMETER) {
+			ibmveth_clear_rx_queue_handle(adapter, queue_idx);
+			return 0;
+		}
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan_queue failed, queue %d rc=%ld\n",
+			   queue_idx, lpar_rc);
+		return -EIO;
+	}
+
+	ibmveth_clear_rx_queue_handle(adapter, queue_idx);
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
+ * ownership is released while queue metadata is still valid. After a
+ * successful H_FREE, fold the last no_buffer sample into retired while
+ * the page is still mapped. If the hcall fails, leave the queue mapped,
+ * keep the handle, and skip retire.
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
+	ibmveth_retire_rx_no_buffer(adapter, queue_idx);
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
+ * count before allocating. CMO rebalances asynchronously, so an
+ * allocation can still fail; the scale-up unwind handles that.
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
+ * also fails leaves that queue out of the live set with its slot still
+ * registered and its memory still mapped. Slots below the live count,
+ * including those a skip-unmap open fail left mapped, are released by
+ * ibmveth_release_lan_resources() instead. Call only after successful
+ * H_FREE_LOGICAL_LAN, which drops every subordinate queue, so the memory
+ * can be released. Retire each queue's no_buffer sample first, as
+ * free_all_queues() does for the live set.
+ */
+static void ibmveth_free_stranded_rx_queues(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = ibmveth_get_num_rx_queues(adapter);
+	     i < IBMVETH_MAX_RX_QUEUES; i++) {
+		if (!adapter->buffer_list_addr[i] &&
+		    !adapter->rx_queue[i].queue_addr)
+			continue;
+		ibmveth_retire_rx_no_buffer(adapter, i);
+		ibmveth_clear_rx_queue_handle(adapter, i);
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
+		if (adapter->queue_registered[i]) {
+			/*
+			 * Stranded by a failed deregister, which queued a
+			 * reset. Its close frees the queue after H_FREE;
+			 * if that fails, the next open retries.
+			 */
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
+				WRITE_ONCE(adapter->mq_fallback, true);
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
+			 * not hide queue i from netpoll:
+			 * netpoll_poll_dev() calls poll_napi(),
+			 * which walks dev->napi_list
+			 * unbounded by the queue count and skips a NAPI
+			 * only once NAPI_STATE_NPSVC is set. Queue i is
+			 * enabled here, so ibmveth_poll() would run and
+			 * trip its queue_index >= num_rx_queues
+			 * WARN_ON. napi_disable() sets NPSVC, so
+			 * poll_napi() skips the queue instead.
+			 */
+			napi_disable(&adapter->napi[i]);
+			/* Wait for the poll tail, then remask. */
+			synchronize_net();
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+			ibmveth_publish_num_rx_queues(adapter, i);
+			ibmveth_drain_rx_queue(adapter, i);
+			synchronize_net();
+		}
+		if (rc) {
+			if (ibmveth_destroy_subordinate_rx_queue(adapter,
+								 i)) {
+				int keep = i + 1;
+
+				/*
+				 * PHYP still owns queue i. Keep it in
+				 * the live set with the queues this
+				 * -L already added.
+				 * cleanup_new_queues would publish
+				 * below i and orphan this mapping.
+				 */
+				ibmveth_publish_num_rx_queues(adapter,
+							      keep);
+				if (netif_set_real_num_rx_queues(netdev,
+								 keep))
+					schedule_work(&adapter->work);
+				ibmveth_replenish_task(adapter, i);
+				napi_enable(&adapter->napi[i]);
+				rc = ibmveth_enable_irq(adapter, i);
+				if (rc) {
+					netdev_err(netdev,
+						   "queue %d enable_irq rc=%d\n",
+						   i, rc);
+					schedule_work(&adapter->work);
+				} else {
+					ibmveth_restart_rx_queue(adapter,
+								 i);
+				}
+				ibmveth_refresh_cmo_desired(adapter);
+				return -EIO;
+			}
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
+	/* As scale-down: wait for the poll tail, then remask. */
+	synchronize_net();
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
+		if (netif_set_real_num_rx_queues(netdev, keep)) {
+			schedule_work(&adapter->work);
+			/*
+			 * Grow to keep failed; real_num stayed
+			 * lowered. Leave PHYP masked. Reset
+			 * already queued.
+			 */
+		}
+		for (i = old_count; i < keep; i++) {
+			int irq_rc;
+
+			ibmveth_replenish_task(adapter, i);
+			/* START: NAPI before PHYP unmask. */
+			napi_enable(&adapter->napi[i]);
+			/*
+			 * Skip unmask while real_num is below
+			 * keep (RPS WARN). NAPI is still
+			 * enabled so close/reset is not a
+			 * second napi_disable hang.
+			 */
+			if (netdev->real_num_rx_queues < keep)
+				continue;
+			irq_rc = ibmveth_enable_irq(adapter, i);
+			if (irq_rc) {
+				netdev_err(netdev,
+					   "queue %d enable_irq rc=%d\n",
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
+ * Quiesces the retiring queues, drains them, publishes the surviving
+ * count, and only then deregisters them. Successful H_FREE folds the
+ * last no_buffer sample into retired. Walks high to low so a failed
+ * free leaves 0..i live and republishes that count.
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
+	 * a mask while NAPI is already dead. napi_disable() does not
+	 * wait for the poll tail, which can still re-arm PHYP, so
+	 * wait for it, then remask and sync again. Then drain, publish
+	 * the surviving count, and synchronize_net() before destroy
+	 * so NAPI/softirq cannot walk dying queues (handler may still
+	 * be registered until destroy). napi_disable() also keeps
+	 * netpoll's poll_napi() off the retiring queues.
+	 * Destroy retires no_buffer after successful H_FREE, while
+	 * the page is still mapped.
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
+	synchronize_net();
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
+		if (netif_set_real_num_rx_queues(netdev, keep)) {
+			schedule_work(&adapter->work);
+			/*
+			 * Grow to keep failed; real_num stayed
+			 * lowered. Leave PHYP masked. Reset
+			 * already queued.
+			 */
+		}
+		for (i = new_count; i < keep; i++) {
+			int irq_rc;
+
+			ibmveth_replenish_task(adapter, i);
+			/* START: NAPI before PHYP unmask. */
+			napi_enable(&adapter->napi[i]);
+			/*
+			 * Skip unmask while real_num is below
+			 * keep (RPS WARN). NAPI is still
+			 * enabled so close/reset is not a
+			 * second napi_disable hang.
+			 */
+			if (netdev->real_num_rx_queues < keep)
+				continue;
+			irq_rc = ibmveth_enable_irq(adapter, i);
+			if (irq_rc) {
+				netdev_err(netdev,
+					   "queue %d enable_irq rc=%d\n",
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
@@ -2056,7 +2981,9 @@ static void ibmveth_release_lan_resources(struct ibmveth_adapter *adapter)
  * ibmveth_cleanup_rx_interrupts() on close, or by
  * ibmveth_dispose_subordinate_irq_mappings() on partial register failure.
  *
- * Return: 0 if the caller may unmap, -EIO if it must not
+ * Return: 0 if the caller may unmap (the LAN is off, or single-queue
+ *         mode after any failure), -EIO if H_FREE_LOGICAL_LAN failed
+ *         before start in multi-queue mode
  */
 static int ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
 {
@@ -2239,6 +3166,7 @@ static int ibmveth_open(struct net_device *netdev)
 				   "h_free_logical_lan still failing; LAN remains registered\n");
 			return -EIO;
 		}
+		ibmveth_free_stranded_rx_queues(adapter);
 		ibmveth_release_lan_resources(adapter);
 	}
 
@@ -2367,6 +3295,7 @@ static int ibmveth_close(struct net_device *netdev)
 	ibmveth_cleanup_rx_interrupts(adapter);
 
 	if (!ibmveth_free_all_queues(adapter)) {
+		ibmveth_free_stranded_rx_queues(adapter);
 		/* netif_tx_disable() above keeps xmit off the TX LTBs. */
 		ibmveth_release_lan_resources(adapter);
 	}
@@ -2769,21 +3698,96 @@ static void ibmveth_get_channels(struct net_device *netdev,
 		channels->max_rx = channels->rx_count;
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
+	if (goal_rx > 1 &&
+	    (!adapter->multi_queue || READ_ONCE(adapter->mq_fallback))) {
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
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
+	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
+	unsigned int want_tx = goal;
+	bool rx_changed = false;
 	int rc, i, alloc_rc = 0;
 
-	/*
-	 * RX channel resize is implemented later; reject any request
-	 * that changes rx_count. Read-modify-write TX adjustments
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
+
+	if (channels->rx_count != old_rx)
+		rx_changed = true;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -2831,6 +3835,28 @@ static int ibmveth_set_channels(struct net_device *netdev,
 
 	netif_tx_wake_all_queues(netdev);
 
+	if (netdev->real_num_tx_queues != want_tx) {
+		if (rx_changed) {
+			/*
+			 * Best-effort restore of the RX count from before
+			 * this -L; a failure is logged and the TX error
+			 * returned. num_slots is the live size after that
+			 * resize.
+			 */
+			int rxq_entries = adapter->rx_queue[0].num_slots;
+			int rb;
+
+			rb = ibmveth_resize_rx_queues_incremental(adapter,
+								  old_rx,
+								  rxq_entries);
+			if (rb)
+				netdev_err(netdev,
+					   "Failed to roll back RX queues to %u after TX failure: %d\n",
+					   old_rx, rb);
+		}
+		return rc ? rc : -ENOMEM;
+	}
+
 	return rc;
 }
 
@@ -3333,7 +4359,10 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 		ibmveth_rx_csum_helper(skb, adapter);
 	}
 
-	skb_record_rx_queue(skb, queue_index);
+	/* Past real_num on the resize keep-path: deliver untagged. */
+	if ((unsigned int)queue_index <
+	    READ_ONCE(netdev->real_num_rx_queues))
+		skb_record_rx_queue(skb, queue_index);
 	napi_gro_receive(napi, skb);
 
 	IBMVETH_STAT_INC(rxs->packets);
@@ -3424,6 +4453,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (ibmveth_poll_stopping(netdev, napi))
 		goto out;
 
+	if (queue_index >= READ_ONCE(netdev->real_num_rx_queues))
+		goto out; /* keep-path: skip enable_irq past real_num */
+
 	rc = ibmveth_enable_irq(adapter, queue_index);
 	if (rc) {
 		netdev_err(netdev,
@@ -3456,11 +4488,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 
 	qindex = napi - adapter->napi;
 	/*
-	 * Quiet on out-of-range: a live-count shrink publishes the lower
-	 * count before free_irq(). A residual IRQ must not WARN-storm;
-	 * return IRQ_NONE until the handler is removed.
+	 * IRQ_NONE when out of range: scale-down before free_irq(), or
+	 * qindex >= real_num on resize keep-path (do not schedule).
 	 */
-	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
+	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter) ||
+	    qindex >= READ_ONCE(netdev->real_num_rx_queues))
 		return IRQ_NONE;
 
 	IBMVETH_STAT_INC(adapter->rx_qstats[qindex].interrupts);
@@ -3580,8 +4612,6 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct net_device *netdev = dev_get_drvdata(&vdev->dev);
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
-	unsigned long ret;
-	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -3590,41 +4620,8 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
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
@@ -4154,11 +5151,13 @@ static void ibmveth_remove(struct vio_dev *dev)
 	unregister_netdev(netdev);
 
 	if (ibmveth_lan_resources_live(adapter)) {
-		if (ibmveth_free_all_queues(adapter))
+		if (ibmveth_free_all_queues(adapter)) {
 			dev_err(&dev->dev,
 				"h_free_logical_lan still failing at remove; leaking LAN buffers\n");
-		else
+		} else {
+			ibmveth_free_stranded_rx_queues(adapter);
 			ibmveth_release_lan_resources(adapter);
+		}
 	}
 
 	ibmveth_free_tx_qstats(adapter);
@@ -4366,8 +5365,13 @@ static int ibmveth_resume(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int num = ibmveth_get_num_rx_queues(adapter);
+	unsigned int live;
 	int i;
 
+	live = READ_ONCE(netdev->real_num_rx_queues);
+	if (num > live)
+		num = live; /* same as interrupt() */
+
 	for (i = 0; i < num; i++)
 		ibmveth_schedule_rx_queue(adapter, i);
 
-- 
2.50.1 (Apple Git-155)


