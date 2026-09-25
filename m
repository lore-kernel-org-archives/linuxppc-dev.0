Return-Path: <linuxppc-dev+bounces-28220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E8EC98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:40:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzyb46w6z30WQ;
	Sat, 26 Sep 2026 04:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361591;
	cv=none; b=cUrVErbux5SmfDQ4NdbFoUU5UwTUgDnVfuvPTRgPHkPpEBsP7qRysmYnNrqW3Wm0bWxF5PZ2iBC1BroEHaTt5hbQPw2yHEnmVa8qLhcttMLTUqF2XWB2gvnwC3zKqK3pkuSfmHA0zPe1Qw3tUsyvKkF9zIqfjyAMok/9XgmAhn6EfJjcGe5YIg+8wILHkE33KPyW4GbZ6KTBQEff7w529Vc2smOe+fqoyb47EFs+oo4Olc905IVoDdeVrnvEQbrSgopE7OhhxOwRBWeZZTzQI/3cEttGiRxitj0uqCPbhX2ZDa/LTbDIdYEobSNQXJCFe52mR7CJfnKAJCDPPV3TOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361591; c=relaxed/relaxed;
	bh=iaKb9QopFrYJaItS29VxAFEQOYxILd2F/qTS7RrxfPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtUb6tY+FmyhICbJbS22E2wzYEw/8VWctHb5cD1Q27v+M6peSo3Erd6XrAyEJyKxLTia+s8qWZa5ewBSA1bolubEb//TkPSN1RBFLY5eozrmXvsR1X9OPgs81vI3RFw1pqh77B8F1I1b9hDxFBwKJdjyQKRoHm1YlnGclcCh74wHtqKrRlgOb4ccUm8AvSVpfKlF8VUySDVnFY0JXackbrEBeVTe70KQzgJzBRw8GFer8VeWCb2jzsl/UF78kCekOBQhIZ9A3IyeXv+pQo9lR1WmGOdl6qpnjtCK6i4OmGdbwBup3jB4gfRv5tdvPMkBa0enV24bEzGbZPDsYK97qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ce9CXUHh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ce9CXUHh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyX6bstz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:39:48 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG6A32344135;
	Fri, 25 Sep 2026 18:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iaKb9QopFrYJaItS2
	9VxAFEQOYxILd2F/qTS7RrxfPg=; b=ce9CXUHh3KjEjWIoB4ZtE7UpwFXCIaLKa
	WdHnRlXNSX6spSky+TVPhN4w6SD+GdXOMPSol2wZPpamvr5LNFF+pNx1jr11CBbf
	2dYpEvqEQkxmrzcAXkYWUOKG6EaHi0oOTN1NfCgbSaT5RNEWON665kq6PNhEwBzj
	iqS5tuuBKHxaw2D5T+sUtKpJcEuIdxoISf+FjeXUyrzj9j8AWzSdAED5DlnT3T4A
	VxdL6K/hDuG3GGfXSQHkFuAHQ+DKrvujhA11S7g1WD/ildvnlWfTTXU+8CMOQtPO
	fZIp+jlqnnuIQd3hf9jfpG9AZZi4DuV86PYtwGzG7+HGXvRyRnaKg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqyjd5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG3L9f4140684;
	Fri, 25 Sep 2026 18:39:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu93frg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdWVx20840960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38A1D58059;
	Fri, 25 Sep 2026 18:39:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF815804B;
	Fri, 25 Sep 2026 18:39:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:29 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 08/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Fri, 25 Sep 2026 11:38:43 -0700
Message-Id: <3647dfce84454c5e60269549172fd20f504bddad.1790319558.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6bfe8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1ZARK_YMBu8ooU8kBn0A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXyLcFBXd40K5f
 7xYrgaB66Al/2/OsTQ6ScdubvY6yXGd0EOg4LnkzkJjGTNJZZE7IDhgUv9Hia8ybu7NRlaRJ/oe
 4aNdDWYB9hecb3DYp3yXyt+g5ahrlw1BF/1xDdxnflOKuMYU/EEzU1y5M40q4tF6B0u1LONzCJ+
 AKwoD3RVpEx8F11/8leO09YpgFz0GgZJh2UeYF0oAv4DI+TKYaoCREI5fXrK1+fqxOAKWi724zL
 ylUjzeukekPiQn5vgz66WSdn0xXrH/G6lK7aNTGv2Ut21fJoYU9nikOBIxPyqhngchFWaGZ7CF+
 /S1x+v50x7wEXF5JcAIRvxkKlhR1+flxlmkpNgPxxBnghEgn96n62gegWGyDSkiq6UK8Dv3BCrb
 OujSr6Uqk33ztZ0cfeRWWm3r54m+T3RMAfPDBvgSimfHoaBn+MCsAEAmBFVSWolqczrNPWKj5Rf
 3N7dilc5Zdovm7IuBzg==
X-Proofpoint-ORIG-GUID: Fx8U7hjwimH0_oJWXiCI3pmM9UJSfnGQ
X-Proofpoint-GUID: Zmx6IVmgndqXgKB_mH6msRWsulHd_e_U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX3Z14hAOxgA1J
 WXTiwcNGun0Cj2xws5kOMpgoevoJShti5scun6hl+ESLn6F2s5dkBO5hBXLDDHgAzhbaFPugK+o
 DN8BRISxH56StBuLwQo6b8sBLSJ2LyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

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
ibmveth_rxq_get_buffer().

Add a per-queue replenish_lock to struct ibmveth_rx_q, initialised in
probe. Replenish is not the only writer of a pool's free_map: the
harvest and remove consumer runs from that queue's NAPI instance, and
ndo_poll_controller() runs replenish on the same queue from outside
NAPI, so producer and consumer can run at once on one queue.

Give ibmveth_replenish_buffer_pool() a return value. It was void and
logged from inside the critical section, where a printk can re-enter
replenish through netconsole on the same device. It now returns one of
IBMVETH_REPLENISH_OK, _RESET_MAP, _RESET_MQ, _HCALL_FAIL or
_BATCH_FALLBACK, and ibmveth_replenish_task() does the logging and any
schedule_work() after dropping replenish_lock. The replenish map uses
DMA_ATTR_NO_WARN so the iommu path cannot printk under that lock.

Replace the correlator WARN_ON()s with ibmveth_rxq_correlator_valid().
The pool and buffer index come from a hypervisor-supplied correlator,
which is not a kernel invariant, so WARN_ON() was the wrong tool: with
panic_on_warn set, a malformed correlator would take the partition
down. The helper returns false instead, callers propagate -EINVAL or
-EFAULT, and ibmveth_rxq_advance() still advances the ring so poll
makes progress. On a NULL buffer poll advances past the slot so it
does not spin on an invalid completion at this commit.
remove_buffer_from_pool() no longer schedules the reset itself;
rxq_get_buffer() schedules the reset on a bad correlator at this
commit, and the next patch moves that escalation into poll's skip
helper. The KUnit expectations are updated to match.

Redefine IBMVETH_MAX_RX_PER_HCALL from 8 to 12, the argument-list
capacity of H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, and add
IBMVETH_MAX_RX_REGULAR (8) for the legacy hypercall.

free_buffer_pool() keeps probe/sysfs geometry (active/size/threshold)
and zeroes pool->available so teardown cannot leave a stale count.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

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

 drivers/net/ethernet/ibm/ibmveth.c | 563 +++++++++++++++++++++--------
 drivers/net/ethernet/ibm/ibmveth.h |   6 +-
 2 files changed, 423 insertions(+), 146 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cc01b03d0e4b..ed75dea90a95 100644
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
@@ -101,49 +102,58 @@ static struct ibmveth_stat ibmveth_stats[] = {
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
 
-static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
+static int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
+				 int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_CSUM_GOOD;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_CSUM_GOOD;
 }
 
 static unsigned int ibmveth_real_max_tx_queues(void)
@@ -713,11 +723,100 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
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
+/* Replenish the buffers for a pool.
+ * Caller must hold the per-queue replenish_lock. Do not printk here:
+ * netconsole on the same device can re-enter replenish_task.
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
@@ -729,6 +828,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 	dma_addr_t dma_addr;
 	struct device *dev;
 	u32 index;
+	int outcome = IBMVETH_REPLENISH_OK;
 
 	vdev = adapter->vdev;
 	dev = &vdev->dev;
@@ -743,12 +843,9 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
 
@@ -763,9 +860,15 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 					break;
 				}
 
-				dma_addr = dma_map_single(dev, skb->data,
-							  pool->buff_size,
-							  DMA_FROM_DEVICE);
+				/* NO_WARN: hold replenish_lock; iommu
+				 * printk can re-enter via netconsole.
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
@@ -800,28 +903,21 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
 
@@ -861,30 +957,35 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
@@ -904,21 +1005,85 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 }
 
 /* replenish routine */
-static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
+static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
+				   int queue_index)
 {
-	int i;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	struct ibmveth_replenish_fail fail = {};
+	unsigned long flags;
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
 
 	adapter->replenish_task_cycles++;
 
-	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
+	spin_lock_irqsave(&rxq->replenish_lock, flags);
 
-		if (pool->active &&
-		    (atomic_read(&pool->available) < pool->threshold))
-			ibmveth_replenish_buffer_pool(adapter, pool);
+	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
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
+				batch_fallback = 1;
+				break;
+			case IBMVETH_REPLENISH_HCALL_FAIL:
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
+	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
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
+				     fail.batch);
+
+	if (hcall_fail)
+		dev_warn_ratelimited(&adapter->netdev->dev,
+				     "RX %s failed: filled=%u, rc=%lu, batch=%u\n",
+				     adapter->multi_queue ?
+				     "h_add_logical_lan_buffers_queue" :
+				     (fail.filled == 1 ?
+				      "h_add_logical_lan_buffer" :
+				      "h_add_logical_lan_buffers"),
+				     fail.filled, fail.lpar_rc, fail.batch);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -953,6 +1118,12 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
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
 
 /**
@@ -1093,35 +1264,75 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   adapter->num_rx_queues);
 }
 
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
+ * Context: may run concurrently with netpoll replenish_task on the same
+ * queue; takes per-queue replenish_lock to serialize free_map /
+ * producer_index / available against the producer.
+ *
  * Return:
  * * %0       - success
- * * %-EINVAL - correlator maps to pool or index out of range
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
+	unsigned long flags;
+	int rc = 0;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
-		schedule_work(&adapter->work);
-		return -EINVAL;
+	spin_lock_irqsave(&rxq->replenish_lock, flags);
+
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
+		rc = -EINVAL;
+		goto out_unlock;
 	}
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
-	if (WARN_ON(!skb)) {
-		schedule_work(&adapter->work);
-		return -EFAULT;
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
+	if (!skb) {
+		rc = -EFAULT;
+		goto out_unlock;
 	}
 
 	/* if we are going to reuse the buffer then keep the pointers around
@@ -1132,75 +1343,88 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
+	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
+	return rc;
 }
 
 /* get the current buffer on the rx queue */
-static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
+static struct sk_buff *
+ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
+		       int queue_index)
 {
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	u64 correlator = rxq->queue_addr[rxq->index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
-	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
+	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
 		schedule_work(&adapter->work);
 		return NULL;
 	}
 
-	return adapter->rx_buff_pool[0][pool].skbuff[index];
+	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
 
 /**
  * ibmveth_rxq_harvest_buffer - Harvest buffer from pool
  *
  * @adapter: pointer to adapter
+ * @queue_index: RX queue index to harvest from
  * @reuse:   whether to reuse buffer
  *
  * Context: called from ibmveth_poll
  *
+ * On a bad correlator (-EINVAL/-EFAULT) the ring is still advanced so poll
+ * cannot spin forever on one slot. The error is still returned: callers must
+ * not treat it as a successful take from the pool (especially reuse=false,
+ * which would hand the SKB to the stack while it remains pool-owned).
+ *
  * Return:
- * * %0    - success
- * * other - non-zero return from ibmveth_remove_buffer_from_pool
+ * * %0    - buffer removed from pool (or marked for reuse) and ring advanced
+ * * other - non-zero return from ibmveth_remove_buffer_from_pool; ring has
+ *           still been advanced for -EINVAL/-EFAULT
  */
 static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				      bool reuse)
+				      int queue_index, bool reuse)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	u64 cor;
 	int rc;
 
-	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
-
 	cor = rxq->queue_addr[rxq->index].correlator;
-	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
-	if (unlikely(rc))
+	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
+	if (unlikely(rc)) {
+		/* Skip a corrupt slot without claiming pool ownership. */
+		if (rc == -EINVAL || rc == -EFAULT)
+			ibmveth_rxq_advance(rxq);
 		return rc;
-
-	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
-		adapter->rx_queue[0].index = 0;
-		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
 	}
 
+	ibmveth_rxq_advance(rxq);
+
 	return 0;
 }
 
@@ -2168,36 +2392,48 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
-	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi[0]);
-	struct net_device *netdev = adapter->netdev;
+	struct net_device *netdev = napi->dev;
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
-	int rc;
+	int queue_index, rc;
 	u16 mss = 0;
 
+	queue_index = napi - adapter->napi;
+
 restart_poll:
 	while (frames_processed < budget) {
-		if (!ibmveth_rxq_pending_buffer(adapter))
+		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
-		if (!ibmveth_rxq_buffer_valid(adapter)) {
+		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+			rc = ibmveth_rxq_harvest_buffer(adapter,
+							queue_index, true);
+			if (unlikely(rc))
 				break;
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
 			__sum16 iph_check = 0;
 
-			skb = ibmveth_rxq_get_buffer(adapter);
-			if (unlikely(!skb))
+			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
+			if (unlikely(!skb)) {
+				struct ibmveth_rx_q *rxq =
+					&adapter->rx_queue[queue_index];
+
+				ibmveth_rxq_advance(rxq);
 				break;
+			}
 
 			/* if the large packet bit is set in the rx queue
 			 * descriptor, the mss will be written by PHYP eight
@@ -2220,12 +2456,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 							length);
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
-						length + offset);
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+							     length + offset);
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								true);
+				if (unlikely(rc))
 					break;
 				skb = new_skb;
 			} else {
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
+				rc = ibmveth_rxq_harvest_buffer(adapter,
+								queue_index,
+								false);
+				if (unlikely(rc))
 					break;
 				skb_reserve(skb, offset);
 			}
@@ -2261,7 +2503,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, queue_index);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2272,14 +2514,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
 
-	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
-		ibmveth_disable_irq(adapter, 0);
+	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    napi_schedule(napi)) {
+		ibmveth_disable_irq(adapter, queue_index);
 		goto restart_poll;
 	}
 
@@ -2409,7 +2655,7 @@ static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
 
-	ibmveth_replenish_task(adapter);
+	ibmveth_replenish_task(adapter, 0);
 	ibmveth_schedule_rx_queue(adapter, 0);
 }
 #endif
@@ -2567,6 +2813,16 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
 	INIT_WORK(&adapter->work, ibmveth_reset);
+
+	/*
+	 * Initialise the replenish locks once. open() is re-entered on
+	 * MTU and offload changes without netpoll_poll_disable(), so a
+	 * lock set up there could be reinitialised while poll_controller()
+	 * holds it.
+	 */
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		spin_lock_init(&adapter->rx_queue[i].replenish_lock);
+
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
@@ -2608,7 +2864,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
+		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
 			    adapter->rx_buffers_per_hcall);
@@ -2929,8 +3185,7 @@ static void ibmveth_reset_kunit(struct work_struct *w)
  * @test: pointer to kunit structure
  *
  * Tests the error returns from ibmveth_remove_buffer_from_pool.
- * ibmveth_remove_buffer_from_pool also calls WARN_ON, so dmesg should be
- * checked to see that these warnings happened.
+ * Bad correlators return -EINVAL/-EFAULT (no WARN_ON).
  *
  * Return: void
  */
@@ -2944,6 +3199,8 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
+	spin_lock_init(&adapter->rx_queue[0].replenish_lock);
+
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
@@ -2953,19 +3210,34 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
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
@@ -2974,9 +3246,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
  * ibmveth_rxq_get_buffer_test - unit test for ibmveth_rxq_get_buffer
  * @test: pointer to kunit structure
  *
- * Tests ibmveth_rxq_get_buffer. ibmveth_rxq_get_buffer also calls WARN_ON for
- * the NULL returns, so dmesg should be checked to see that these warnings
- * happened.
+ * Tests ibmveth_rxq_get_buffer invalid correlator returns NULL without WARN.
  *
  * Return: void
  */
@@ -3007,18 +3277,21 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
+	pool->free_map = kunit_kcalloc(test, pool->size, sizeof(u16),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->free_map);
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter, 0));
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter, 0));
 
 	pool->skbuff[0] = skb;
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter, 0));
 
 	flush_work(&adapter->work);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index a3178032c6f2..dc0e5c25209a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -14,6 +14,8 @@
 #ifndef _IBMVETH_H
 #define _IBMVETH_H
 
+#include <linux/spinlock_types.h>
+
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
 #define IbmVethMcastReceptionEnableBit     0x20000UL
@@ -265,7 +267,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_DEFAULT_QUEUES 8U
 #define IBMVETH_MAX_RX_QUEUES 1U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
-#define IBMVETH_MAX_RX_PER_HCALL 8U
+#define IBMVETH_MAX_RX_REGULAR 8U
+#define IBMVETH_MAX_RX_PER_HCALL 12U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
@@ -296,6 +299,7 @@ struct ibmveth_rx_q {
     dma_addr_t queue_dma;
     u32        queue_len;
     struct ibmveth_rx_q_entry *queue_addr;
+	spinlock_t	replenish_lock;	/* per-queue buffer replenish */
 };
 
 struct ibmveth_adapter {
-- 
2.50.1 (Apple Git-155)


