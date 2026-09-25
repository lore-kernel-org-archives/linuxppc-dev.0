Return-Path: <linuxppc-dev+bounces-28224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782ECC9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzyq2hYyz30WJ;
	Sat, 26 Sep 2026 04:40:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790361603;
	cv=none; b=UHFPFwGQMeg2E5xJ8Y30hv54344v3jenPfWGKIKTkqtfSUzgk4b61n4B2h1PjavTbFuf5s2b2qH4ES605aNl1cBcselBhlyN0Dn9uVYO1BSwUWK57sy0UjGlYVQ4eeXNr+JDXRazBW/KJyvTs1jjQ1aIV9Kh0/Ki7vngOsde+1K4ErwiPAB1Ixr1i671vmZT4BsmcHU6Nrk9aJCX/25Z4jjCzo+l0nOnkjETWnaBd/6KuZSrICGZkmq5OtXgZs4DDx5JUDBd+tAnwp1DB7TETsT5OJ51Wabp+SZx2nUUI7vtWQpnRn/Eqp0FSneyxA6/dovjLijR9Hi/cYUphKriEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790361603; c=relaxed/relaxed;
	bh=MLCQTQUaH/0Y58QebLTksvlN6RXTXA3HJDCBaHjzzeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqLpc+EBZeNFFW4SLVLun6hadSWTuv/adWCG32wb/+lgtDcbkHnciZ7hYirpniSvdnm6ePHizD+zYqEEInbuFaapkLh6Yb0Oog5AIon3hZ80ZEZrCPBGqW9ilOEeoYY8r3HCnwlcnhGdAejve995wg0Nc5c9oF3Lj105E2TqV/FF6TCH7vb08c9CJ+eMCT8PMsbZfz+E6PdgjdW34lckJLRVMEOYNncqGK62no9/LRHZjUAMyyfJjZy8Xjvs2FREhIt+xWzRGplIXFyJzaxezZAYoD+jV1cqFsOzQwrAFd2GWRn+WYcpK+eRmeOwyUu5yrE8tDq4nVlVYGAYi7ou9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nlMAn6gB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nlMAn6gB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzyn03Jkz3btf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:40:00 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5YpM1556415;
	Fri, 25 Sep 2026 18:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MLCQTQ
	UaH/0Y58QebLTksvlN6RXTXA3HJDCBaHjzzeM=; b=nlMAn6gBidcdxnCiOtWFVo
	tR4U1WXaLdpS/9nXezw7YxRcJQ7nvnmZeC/0HoutYXY2MBtNmbJYN5wv2yum0h/i
	PMrJK6v2ow3DD5T9DIjFk5SJUsPmez1ScZseDES3L5Cwv0dFDB4KTzaeMZWw3gnE
	6hslR+Ddg5wVDjo/4euNSBTm/9BkFK3/m/FCY9NaUa1ae3PYaoEF0BHDMU5WtA7/
	vlxEumRz5ozEyJZC0dcNNjReFj3ks2OzP6iu9zqfzu+DyecMwdqeNSwB08rx6LqK
	AiCrKoh8Lpqffcrh2PxaQArQWupv9hoY9JXHOmxm1bGuBLd5xw0nuc16PE/0pKyw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvqmad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG36ux4186411;
	Fri, 25 Sep 2026 18:39:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe23kcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdhOR28574412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C6EC58055;
	Fri, 25 Sep 2026 18:39:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E568C58059;
	Fri, 25 Sep 2026 18:39:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:40 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 11/15] ibmveth: Add per-queue RX and TX statistics collection
Date: Fri, 25 Sep 2026 11:38:46 -0700
Message-Id: <b839ded0f86ec9e064261a99135ae1ad8aa4ac58.1790319558.git.mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: a5IlXM4CF33Tr4SnzfbS50meMyGmfjO3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX0NvwQqeUIV67
 88JhoyIjwN58Co+cZOgsB57sdSJ3mUIZZnGaHdTozVAxgMq9280HVX+RF+8NYhMLgW8Jcuo2UTz
 5bJlzoQHK9TjMluPdU3PCOpjvbsygqg=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab6bff4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=NGuPb9nUZ_g2g_c-cfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lnIZayXQsoZBWmuw4VJYbW43F8V_Jf4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX45dzGOehcAZu
 J1UOo0v4iqYJg7MmzaPKP8iFBENhU0/rah9iGZNSC9R9TMyq5rjWAz7EpJiu7ChnKciO+kxOazZ
 bfcezEhnuS3kNg27MQi+GZsBN/Xl0G4+qrI949ButjzSEnN6WSs/IdHVkHyxKXC+mYAdZRa+k/p
 tK54RQYtApheae7HjMg6so3brzhU5ZdrbUSRILnvrevLXT7OZFgKI2ODSMCbOQVmflO/T4xNrtV
 iejPgRi3K7eqmBIPceQPaI4q0CdeMbha0QSIaUn2pGNPsbfGmPue3Vnb9L8bPg0vAmTpBjsEhnT
 1MDESmol2XjrfCsu1I9wkd10RE+l2E9avU9daFmE/taYaAoIbSCII/x9fpcJ1LVmWJ9efzZ9+9J
 nV5M5ouVlyx4DfFF2yWJQuz0PrSXY97GJvk3aUgoeSKqJimoqzceehGmKWLfHW/lb6sRJ/LZNsa
 0LSo4Lst8pMJf43q0PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250074

MQ RX points several queues at the same adapter-wide counters, which
races the updates and leaves no way to attribute a count to a queue.

Move every counter that has more than one writer into per-queue
structs allocated at probe and freed at remove:

  struct ibmveth_rx_queue_stats
  struct ibmveth_tx_queue_stats

Each slot has a single writer — replenish_* under that queue's
replenish_lock, the other RX fields from that queue's NAPI, TX under
the stack's per-queue TX lock — so plain u64 is enough on this
PPC64-only driver. No atomic and no u64_stats_sync.

packets, bytes and drops go through struct netdev_stat_ops
(.get_queue_stats_rx, .get_queue_stats_tx, .get_base_stats).
.ndo_get_stats64() sums the per-queue packet and byte counters into
64-bit device totals. ethtool -S keeps only the driver-specific keys
that have no standard equivalent: interrupts, polls, large_packets,
invalid_buffers and no_buffer_drops per RX queue; large_packets,
send_failures and checksum_offload per TX queue. ETH_SS_STATS becomes
variable-length because that block scales with the live queue count.
Hypercall counters and pool%d_ keys are not added: which hcall a
batch picks is not ABI, and size/active already have sysfs (available
for every queue is patch 13).

The thirteen existing ethtool -S keys keep their exact names, their
order and their adapter-wide values, summed from the per-queue slots
on read. The storage moved; that ABI did not. The four replenish_*
counters get per-queue storage but no per-queue key of their own.

Holding that ABI while the storage moves needs the ethtool -S table
to record where each key lives. IBMVETH_STAT_OFF() could only express
an offset into struct ibmveth_adapter. Tag every entry with an enum
ibmveth_stat_src naming the struct it indexes: adapter-wide keys are
read directly, per-queue keys are summed across the slots by one pair
of offset-keyed helpers. That is what lets the field names change
while the key names do not (rx_invalid_buffer now reads
invalid_buffers, tx_send_failed reads send_failures, and the two
large_packets fields live in different structs). tx_map_failed still
reads from the adapter — it has no writer, here or in mainline —
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
accumulates from, so both belong to one queue. The rx%d_no_buffer_drops
key reports that live page absolute on its own, so it is the one
exported value that is not monotonic; the adapter-wide rx_no_buffer
sums the two and per-queue rx-hw-drops includes both.

The remove-path unregister / cancel_work_sync reorder and reset
reg_state gate landed in the prior patch when the reset producer was
added; this patch frees the per-queue statistics arrays in remove()
between cancel_work_sync() and free_netdev().

ibmveth_probe_cleanup() also clears the vio drvdata before
free_netdev(). A probe failure never reaches ibmveth_remove(), and
CMO get_desired_dma() reads that pointer on a later rebind.

Readers do not test the arrays for NULL: both exist from before
register_netdev() until after unregister_netdev() and
cancel_work_sync(), and probe fails -ENOMEM if either allocation
does.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

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

 drivers/net/ethernet/ibm/ibmveth.c | 502 +++++++++++++++++++++++++----
 drivers/net/ethernet/ibm/ibmveth.h |  57 +++-
 2 files changed, 488 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3f31793645a3..2575a7c11afb 100644
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
+	{ "rx_no_buffer", IBMVETH_STAT_RX_NO_BUFFER,
+	  IBMVETH_RXQ_OFF(no_buffer_drops) },
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
+ * Only counters with no home in the standard interfaces belong here.
+ * packets, bytes and drops are reported through netdev_stat_ops.
+ */
+static const struct ibmveth_qstat ibmveth_rx_qstat_keys[] = {
+	{ "rx%d_interrupts", IBMVETH_RXQ_OFF(interrupts) },
+	{ "rx%d_polls", IBMVETH_RXQ_OFF(polls) },
+	{ "rx%d_large_packets", IBMVETH_RXQ_OFF(large_packets) },
+	{ "rx%d_invalid_buffers", IBMVETH_RXQ_OFF(invalid_buffers) },
+	{ "rx%d_no_buffer_drops", IBMVETH_RXQ_OFF(no_buffer_drops) },
 };
 
+static const struct ibmveth_qstat ibmveth_tx_qstat_keys[] = {
+	{ "tx%d_large_packets", IBMVETH_TXQ_OFF(large_packets) },
+	{ "tx%d_send_failures", IBMVETH_TXQ_OFF(send_failures) },
+	{ "tx%d_checksum_offload", IBMVETH_TXQ_OFF(checksum_offload) },
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
@@ -839,6 +963,8 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 					 int queue_index,
 					 struct ibmveth_replenish_fail *fail)
 {
+	struct ibmveth_rx_queue_stats *qstats =
+		&adapter->rx_qstats[queue_index];
 	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
 	u32 remaining = pool->size - atomic_read(&pool->available);
 	u64 correlators[IBMVETH_MAX_RX_PER_HCALL] = {0};
@@ -865,7 +991,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		for (filled = 0; filled < min(remaining, batch); filled++) {
 			index = pool->free_map[free_index];
 			if (index == IBM_VETH_INVALID_MAP) {
-				adapter->replenish_add_buff_failure++;
+				qstats->replenish_add_buff_failure++;
 				outcome = IBMVETH_REPLENISH_RESET_MAP;
 				break;
 			}
@@ -876,8 +1002,8 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 				skb = netdev_alloc_skb(adapter->netdev,
 						       pool->buff_size);
 				if (!skb) {
-					adapter->replenish_no_mem++;
-					adapter->replenish_add_buff_failure++;
+					qstats->replenish_no_mem++;
+					qstats->replenish_add_buff_failure++;
 					break;
 				}
 
@@ -892,7 +1018,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 							     DMA_ATTR_NO_WARN);
 				if (dma_mapping_error(dev, dma_addr)) {
 					dev_kfree_skb_any(skb);
-					adapter->replenish_add_buff_failure++;
+					qstats->replenish_add_buff_failure++;
 					break;
 				}
 
@@ -953,7 +1079,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 		}
 
 		buffers_added += filled;
-		adapter->replenish_add_buff_success += filled;
+		qstats->replenish_add_buff_success += filled;
 		remaining -= filled;
 
 		memset(&descs, 0, sizeof(descs));
@@ -976,7 +1102,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 				pool->skbuff[index] = NULL;
 			}
 		}
-		adapter->replenish_add_buff_failure += filled;
+		qstats->replenish_add_buff_failure += filled;
 
 		if (lpar_rc == H_FUNCTION) {
 			if (adapter->multi_queue) {
@@ -1017,6 +1143,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
 					int queue_index)
 {
+	struct ibmveth_rx_queue_stats *qstats;
 	__be64 *p;
 	u64 drops;
 
@@ -1028,7 +1155,18 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
 	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
 	drops = be64_to_cpup(p);
 
-	adapter->rx_no_buffer = drops;
+	/*
+	 * PHYP's buffer-list page counter is absolute for that page. A new
+	 * page (reopen / queue reuse after -L) starts near zero; fold the
+	 * previous absolute into this queue's retired carry so sums stay
+	 * monotonic. Both fields belong to the queue being updated, so this
+	 * stays single-writer under the queue's replenish_lock.
+	 */
+	qstats = &adapter->rx_qstats[queue_index];
+
+	if (drops < qstats->no_buffer_drops)
+		qstats->no_buffer_retired += qstats->no_buffer_drops;
+	qstats->no_buffer_drops = drops;
 }
 
 /* replenish routine */
@@ -1050,10 +1188,10 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 		return;
 	}
 
-	adapter->replenish_task_cycles++;
-
 	spin_lock_irqsave(&rxq->replenish_lock, flags);
 
+	adapter->rx_qstats[queue_index].replenish_task_cycles++;
+
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
 		struct ibmveth_buff_pool *pool =
 			&adapter->rx_buff_pool[queue_index][i];
@@ -2005,8 +2143,14 @@ static int ibmveth_close(struct net_device *netdev)
 	/* Wait for softirq/poll that already passed shutdown checks. */
 	synchronize_net();
 
-	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
+	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
+		struct ibmveth_rx_q *rxq = &adapter->rx_queue[i];
+		unsigned long flags;
+
+		spin_lock_irqsave(&rxq->replenish_lock, flags);
 		ibmveth_update_rx_no_buffer(adapter, i);
+		spin_unlock_irqrestore(&rxq->replenish_lock, flags);
+	}
 	ibmveth_free_all_queues(adapter);
 	/* Free TX LTBs after quiesce and after H_FREE_LOGICAL_LAN so xmit
 	 * cannot touch unmapped bounce buffers while the LAN is live.
@@ -2278,22 +2422,96 @@ static int ibmveth_set_features(struct net_device *dev,
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
+{
+	u64 total = 0;
+	int i;
+
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		total += *(u64 *)((u8 *)&adapter->rx_qstats[i] + off);
+
+	return total;
+}
+
+static u64 ibmveth_sum_tx_qstat(struct ibmveth_adapter *adapter, size_t off)
 {
+	u64 total = 0;
 	int i;
 
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
+		total += *(u64 *)((u8 *)&adapter->tx_qstats[i] + off);
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
+	case IBMVETH_STAT_RX_NO_BUFFER:
+		/*
+		 * PHYP's page counter is absolute for the page currently
+		 * mapped, so a reopen or queue reuse restarts it near zero.
+		 * ibmveth_update_rx_no_buffer() folds each decrease into the
+		 * queue's retired carry; add both back to stay monotonic.
+		 */
+		return ibmveth_sum_rx_qstat(adapter, stat->off) +
+		       ibmveth_sum_rx_qstat(adapter,
+					    IBMVETH_RXQ_OFF(no_buffer_retired));
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
@@ -2302,11 +2520,27 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
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
+			data[i++] = *(const u64 *)
+				(q + ibmveth_rx_qstat_keys[k].off);
+	}
+
+	for (j = 0; j < dev->real_num_tx_queues; j++) {
+		const u8 *q = (const u8 *)&adapter->tx_qstats[j];
+
+		for (k = 0; k < IBMVETH_NUM_TX_QSTATS; k++)
+			data[i++] = *(const u64 *)
+				(q + ibmveth_tx_qstat_keys[k].off);
+	}
 }
 
 static void ibmveth_get_channels(struct net_device *netdev,
@@ -2418,8 +2652,10 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 }
 
 static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
-					 struct net_device *netdev)
+					 struct ibmveth_adapter *adapter,
+					 int queue_num)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct ethhdr *ether_header;
 	int ret = 0;
 
@@ -2427,7 +2663,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		ret = -EOPNOTSUPP;
 	}
 
@@ -2445,11 +2681,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
 	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 
-	if (ibmveth_is_packet_unsupported(skb, netdev))
+	if (ibmveth_is_packet_unsupported(skb, adapter, queue_num))
 		goto out;
 	/* veth can't checksum offload UDP */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -2460,7 +2696,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	    skb_checksum_help(skb)) {
 
 		netdev_err(netdev, "tx: failed to checksum packet\n");
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 
@@ -2472,6 +2708,8 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 
 		desc_flags |= (IBMVETH_BUF_NO_CSUM | IBMVETH_BUF_CSUM_GOOD);
 
+		adapter->tx_qstats[queue_num].checksum_offload++;
+
 		/* Need to zero out the checksum */
 		buf[0] = 0;
 		buf[1] = 0;
@@ -2483,7 +2721,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_is_gso(skb)) {
 		if (adapter->fw_large_send_support) {
 			mss = (unsigned long)skb_shinfo(skb)->gso_size;
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		} else if (!skb_is_gso_v6(skb)) {
 			/* Put -1 in the IP checksum to tell phyp it
 			 * is a largesend packet. Put the mss in
@@ -2492,7 +2730,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 			ip_hdr(skb)->check = 0xffff;
 			tcp_hdr(skb)->check =
 				cpu_to_be16(skb_shinfo(skb)->gso_size);
-			adapter->tx_large_packets++;
+			adapter->tx_qstats[queue_num].large_packets++;
 		}
 	}
 
@@ -2500,7 +2738,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
 		netdev_err(adapter->netdev, "tx: packet size (%u) exceeds ltb (%u)\n",
 			   skb->len, adapter->tx_ltb_size);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
@@ -2517,7 +2755,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	if (unlikely(total_bytes != skb->len)) {
 		netdev_err(adapter->netdev, "tx: incorrect packet len copied into ltb (%u != %u)\n",
 			   skb->len, total_bytes);
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 		goto out;
 	}
 	desc.fields.flags_len = desc_flags | skb->len;
@@ -2526,11 +2764,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 
 	if (ibmveth_send(adapter, desc.desc, mss)) {
-		adapter->tx_send_failed++;
-		netdev->stats.tx_dropped++;
+		adapter->tx_qstats[queue_num].send_failures++;
+		adapter->tx_qstats[queue_num].dropped_packets++;
 	} else {
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
+		adapter->tx_qstats[queue_num].packets++;
+		adapter->tx_qstats[queue_num].bytes += skb->len;
 	}
 
 out:
@@ -2659,7 +2897,7 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
 				      int queue_index)
 {
-	adapter->rx_invalid_buffer++;
+	adapter->rx_qstats[queue_index].invalid_buffers++;
 }
 
 static bool ibmveth_poll_stopping(struct net_device *netdev,
@@ -2798,7 +3036,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
 	    iph_check == 0xffff) {
 		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-		adapter->rx_large_packets++;
+		adapter->rx_qstats[queue_index].large_packets++;
 	}
 
 	if (csum_good) {
@@ -2809,8 +3047,8 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
 	skb_record_rx_queue(skb, queue_index);
 	napi_gro_receive(napi, skb);
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += length;
+	adapter->rx_qstats[queue_index].packets++;
+	adapter->rx_qstats[queue_index].bytes += length;
 
 	return 1;
 }
@@ -2837,6 +3075,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
+	adapter->rx_qstats[queue_index].polls++;
+
 restart_poll:
 	while (frames_processed < budget) {
 		if (ibmveth_poll_stopping(netdev, napi))
@@ -2925,6 +3165,8 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
 		return IRQ_NONE;
 
+	adapter->rx_qstats[qindex].interrupts++;
+
 	ibmveth_schedule_rx_queue(adapter, qindex);
 	return IRQ_HANDLED;
 }
@@ -3145,6 +3387,124 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+/**
+ * ibmveth_get_stats64 - Return aggregated per-queue statistics
+ * @dev: network device
+ * @stats: rtnl link statistics storage
+ *
+ * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
+ * Walk the full allocated arrays (not the live queue count) so shrinking
+ * channels cannot make the totals go backwards.
+ * Callers use ndo_get_stats64(); avoid updating netdev->stats on the
+ * xmit/poll paths to keep per-queue counters off the hot cache line.
+ */
+static void ibmveth_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
+		stats->rx_packets += adapter->rx_qstats[i].packets;
+		stats->rx_bytes += adapter->rx_qstats[i].bytes;
+	}
+
+	for (i = 0; i < IBMVETH_MAX_QUEUES; i++) {
+		stats->tx_packets += adapter->tx_qstats[i].packets;
+		stats->tx_bytes += adapter->tx_qstats[i].bytes;
+		stats->tx_dropped += adapter->tx_qstats[i].dropped_packets;
+	}
+}
+
+static void ibmveth_get_queue_stats_rx(struct net_device *dev, int idx,
+				       struct netdev_queue_stats_rx *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
+	stats->packets = adapter->rx_qstats[idx].packets;
+	stats->bytes = adapter->rx_qstats[idx].bytes;
+	/*
+	 * All three are frames that entered the device and never left it,
+	 * which is what rx-hw-drops is specified to cover: no_buffer_drops
+	 * is PHYP dropping for lack of buffer space on the page mapped now,
+	 * no_buffer_retired the same for pages this queue has already
+	 * released, and invalid_buffers is a processing error.
+	 */
+	stats->hw_drops = adapter->rx_qstats[idx].no_buffer_drops +
+			  adapter->rx_qstats[idx].no_buffer_retired +
+			  adapter->rx_qstats[idx].invalid_buffers;
+	stats->alloc_fail = adapter->rx_qstats[idx].replenish_no_mem;
+}
+
+static void ibmveth_get_queue_stats_tx(struct net_device *dev, int idx,
+				       struct netdev_queue_stats_tx *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
+	stats->packets = adapter->tx_qstats[idx].packets;
+	stats->bytes = adapter->tx_qstats[idx].bytes;
+	stats->hw_drops = adapter->tx_qstats[idx].dropped_packets;
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
+	tx->packets = 0;
+	tx->bytes = 0;
+	tx->hw_drops = 0;
+
+	for (i = dev->real_num_rx_queues; i < IBMVETH_MAX_RX_QUEUES; i++) {
+		rx->packets += adapter->rx_qstats[i].packets;
+		rx->bytes += adapter->rx_qstats[i].bytes;
+		rx->hw_drops += adapter->rx_qstats[i].no_buffer_drops +
+				adapter->rx_qstats[i].no_buffer_retired +
+				adapter->rx_qstats[i].invalid_buffers;
+		rx->alloc_fail += adapter->rx_qstats[i].replenish_no_mem;
+	}
+
+	for (i = dev->real_num_tx_queues; i < IBMVETH_MAX_QUEUES; i++) {
+		tx->packets += adapter->tx_qstats[i].packets;
+		tx->bytes += adapter->tx_qstats[i].bytes;
+		tx->hw_drops += adapter->tx_qstats[i].dropped_packets;
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
@@ -3157,6 +3517,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
@@ -3198,6 +3559,23 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
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
+	/* Probe failure never reaches ibmveth_remove(); clear before free so
+	 * CMO get_desired_dma() cannot see a freed netdev on rebind.
+	 */
+	dev_set_drvdata(&adapter->vdev->dev, NULL);
+	free_netdev(netdev);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len, pools_ready = 0;
@@ -3263,9 +3641,16 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
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
@@ -3350,9 +3735,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 			/* init_and_add takes a ref even on failure */
 			kobject_put(kobj);
 			wait_for_completion(&pool->released);
-			ibmveth_put_pool_kobjs(adapter, pools_ready);
-			dev_set_drvdata(&dev->dev, NULL);
-			free_netdev(netdev);
+			ibmveth_probe_cleanup(adapter, pools_ready);
 			return rc;
 		}
 
@@ -3365,9 +3748,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		dev_set_drvdata(&dev->dev, NULL);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -3382,9 +3763,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of rx queues rc=%d\n",
 			   rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		dev_set_drvdata(&dev->dev, NULL);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -3401,9 +3780,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
-		ibmveth_put_pool_kobjs(adapter, pools_ready);
-		dev_set_drvdata(&dev->dev, NULL);
-		free_netdev(netdev);
+		ibmveth_probe_cleanup(adapter, pools_ready);
 		return rc;
 	}
 
@@ -3428,6 +3805,9 @@ static void ibmveth_remove(struct vio_dev *dev)
 	unregister_netdev(netdev);
 	cancel_work_sync(&adapter->work);
 
+	ibmveth_free_tx_qstats(adapter);
+	ibmveth_free_rx_qstats(adapter);
+
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 84e703692aae..b35da8bdce5f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -279,6 +279,43 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
+/*
+ * Per-queue RX counters. No field has two concurrent writers:
+ * interrupts is written only from this queue's IRQ handler; polls,
+ * packets, bytes, large_packets and invalid_buffers only from its NAPI
+ * poll; replenish_* only under its replenish_lock; and no_buffer_drops
+ * and no_buffer_retired under that lock or from a teardown path already
+ * quiesced by napi_disable()/synchronize_irq(). Plain u64 is therefore
+ * sufficient and no atomic or u64_stats_sync is needed: the driver is
+ * PPC64-only, so 64-bit loads and stores do not tear.
+ */
+struct ibmveth_rx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 interrupts;
+	u64 polls;
+	u64 large_packets;
+	u64 invalid_buffers;
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
+	u64 checksum_offload;
+} ____cacheline_aligned_in_smp;
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -338,17 +375,17 @@ struct ibmveth_adapter {
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


