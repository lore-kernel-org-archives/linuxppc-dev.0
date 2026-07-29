Return-Path: <linuxppc-dev+bounces-25000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC9AC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:38:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BhC3pFxz2xwP;
	Wed, 29 Jul 2026 22:38:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785328699;
	cv=none; b=le+ke7xp8oF+yh7Fvs4aiklAO/8iASHRjPN/FCYtpkOUZryG/eV6ny915K3ggqCGheQ4K+NTY4Q6pa59w/m4BQIdYMNga7If4kIHAr9YJsLkIv+OBsSZGsgKVNi7MHukqBt1ddVaFI92NfV9S6nSvQEL14V+m15FbM2rV7UA8LwXERb1n8bKyIRya74rhnF5yxcVm1rQf4Om9rrPNEMMi+1E3hI3D35SCtNAFu+x6YRyWpYfWPPQXCR5ZBvXKvwTiAoPXHG5zd/CQNbq62RCehZ63uckrxyq4UVZ5OnzAzl4ZPAQmqsPlvoQPBAv34RSbgDTIpq1tUugyp9AOYvOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785328699; c=relaxed/relaxed;
	bh=zLCFPbjXhfquO7ifmbIfMD3c+sNQMn55mOoyAIFxAkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQJgeRD88P2hUfPRDLyvNR8TV53ls8SlboGqhIwuQHY54CJgp1EuVMyGamDZJN+7vRBfJTyWGeAXngfqHkLLf2u/mUVJTv8IZjU0LpncWFG27ISZFfkm/dlCg/SC6KRA4ixT8LqpareMkZAnErCDzc6x7RXH3fV+0/fzm8DDC/RFcnSUJfkoPwvSBJgpsUQgSJXwAzF2IYbD02BBSYEyNTEwu4Er6QD35SlwVNwmGRC8YuPqjIQqSgVoOJQK0fRmtg2BLPvO3pvX+MmAQY9y5Itn9x85adhJe6wLD4wzU6Wztak0ZnBasTxbBw14/bWPFOikJtdFYVi5mUre++BvBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NfyZTiBe; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NfyZTiBe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BhB3XHcz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:38:18 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBI0Dh3955592;
	Wed, 29 Jul 2026 12:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zLCFPbjXhfquO7ifm
	bIfMD3c+sNQMn55mOoyAIFxAkc=; b=NfyZTiBeii6HD+b0lT0gqu8RMRmZNdeHc
	vOzDsvMoGQkRFjIxfim5gaWqcyHrTJV9lPz8P6x6Lg5nKLTwEQTxB5SGWiwbyE27
	TIydfm4rcc4XgbFrhe16cc1KxK0wFFuiY7yGQ12cvMVo3jRawS/88OE+1B78uyO7
	U6loEEMJgt8v0hf5AZnnemDEsvq8SCCtY2mjrWnZ72eeIRvyi4XPLcZ85nHAwSv2
	28JwtCrn1uSuGMbHHJPV0rfnEShsYCuPfvJDuHoU8sUijIeNeCkrlh1Mm9V03EtW
	8ZaqKY6Kbj3UHUUvm43efP0aaB/2wN8BfJN+IiRccnZaAqOhuLuag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nsued-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCQKiQ018797;
	Wed, 29 Jul 2026 12:38:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgeg8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCc9iO47448462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:38:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F26D620043;
	Wed, 29 Jul 2026 12:38:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87D8820040;
	Wed, 29 Jul 2026 12:38:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:38:06 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V4 2/6] powerpc/perf: Reject duplicate HTM target reservations
Date: Wed, 29 Jul 2026 18:07:48 +0530
Message-Id: <20260729123752.63010-3-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729123752.63010-1-atrajeev@linux.ibm.com>
References: <20260729123752.63010-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX6vqI4RVr4zsc
 48hdvxfE59cI9pr6jLv/W14j22Daj5LNOYOAh1Blq9HmxIyy47iIG12eyid81v6qC6zIxD9YJy4
 w/ZriaEWwpeW6SDz64ON0KTd7WihYKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX6Z0ZfII76nTq
 4rHTZ5C50R256vlIIb+smfiyDtTAUHI1yFIHZ0xan6mqnV05iDPmL8V8Xg8htyr6lwITdMlfkKq
 ZFSQXgiidWk4OKNKqrVHRhJ8lpdaR//1X9SGnj2U7XIjNfSeJuTLrxuh4qm+kL9XhcW9LAgQyHK
 115D9v60kFUnzEonQETFKdxHBD5v4H8p4Z+CNaMNoyqZf5FGkq4Jx+85ozbT64MyCaBZ8D5euDq
 e+cTvsnJ6jOHmdGKGECWDh+l2m5qGSqpVPzx/wtiTmKR6UnjNjix+4HSryzOn4ZwRk8GlO8Eofe
 7bK+WOUTtJ/6EvAMQDadE+B6I06kLtEP6YdDht3vrhYj7C7xY3QAciPQDkqM1EKE5C4TsUjf7lx
 Ro5ua3QMdSYArhHrZcfQVwyumzl0U4th8j+l8DLxeaOoKlbbbsU0yX8LQfIogielDPvWKof6IuN
 CKI8PRaLjPd96huyVSw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69f437 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=hH3QnNDdxu067rAKmRoA:9
X-Proofpoint-GUID: Z4JVtV5IYZpYD-V8G9aQJN38aS6zDHxT
X-Proofpoint-ORIG-GUID: Z4JVtV5IYZpYD-V8G9aQJN38aS6zDHxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

HTM tracing is controlled through hypervisor calls and operates on a
system-scoped target identified by HTM type, node index, chip index,
and core index.

HTM events must be opened with cpu=N to pin the AUX buffer file
descriptor to a specific CPU.  The intended usage is:

  perf record -e htm/nodeindex=0,nodalchipindex=2,htm_type=1,cpu=8/ ...

With cpu=N, the event is opened on exactly one CPU and
perf_event_open() is called once for that event.  Multiple HTM events
for different targets (node/chip/core tuples) may be opened
simultaneously on different CPUs.

However, two independent perf_event_open() calls can still target the
same (node, chip, core, type) tuple from different CPUs or processes.
Without driver-side target tracking, both opens succeed htm_event_init()
independently and both proceed to htm_event_add(), where they issue
duplicate H_HTM_OP_CONFIGURE and H_HTM_OP_START hcalls against the same
hardware resource.  This causes conflicts in the underlying H_HTM
operations.

Track reserved HTM targets globally and reject duplicate reservations
for the same target.  The reservation is created during htm_event_init()
and released through the event destroy path.  This prevents concurrent
duplicate opens of the same hardware target while still allowing
different targets to be used simultaneously on different CPUs.

Returning -EBUSY from htm_event_init() for a duplicate open is
intentional and correct.  A user who mistakenly opens the same HTM
target twice (or runs perf record without cpu=N, causing every online
CPU to attempt an open of the same target) receives a clear "PMU
counters are busy" error from the perf tool, directing them to add the
required cpu=N qualifier.  Opening the same HTM node/chip/core target
from multiple CPUs simultaneously has no meaningful purpose: HTM
hardware tracing operates on the target itself, not on the CPU that
issued the hcall.

Extend the existing per-event htm_target_id structure with a list node,
and use the stored htm_config in pmu_private for target comparison.

A cpumask-based approach was considered but not used: cpumask restricts
which CPUs an event may be opened on, but HTM operates on a hardware
target (node/chip/core) that is independent of the CPU opening the
event.  A user may open an HTM event for a specific node/chip/core
target from any CPU in the system, not just CPUs that belong to that
node.  A cpumask would therefore either over-restrict valid opens or
require a per-target mask that mirrors the target list anyway.  The
approach in this patch handles the real constraint: the same hardware
target cannot be configured twice, regardless of which CPU does the
event open.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V3:
- Commit message rewritten to clarify the intended usage model:
  HTM events must be opened with cpu=N to pin the AUX buffer fd to
  a specific CPU. V2 framed the problem as a system-wide perf record
  -a race; V3 makes the cpu=N requirement and the explicit duplicate
  open scenario the primary motivation.
- Added explanation that -EBUSY from htm_event_init() is intentional:
  the user receives a clear "PMU counters are busy" error directing
  them to add cpu=N.
- No functional change to the driver code in this patch.

Changes in V2:
- New patch.  V1 did not protect against concurrent duplicate opens of
  the same HTM target when 'perf record -a' initialises system-wide
  events in parallel on all CPUs.
- Adds a global reserved-targets list.  htm_event_init() rejects any
  open whose (node, chip, core, type) tuple is already reserved; the
  reservation is released through the event destroy path.
- Different targets can still be opened simultaneously on different CPUs.

 arch/powerpc/perf/htm-perf.c | 42 ++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index 189dd40a0b8d..0d1960e299e6 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -77,9 +77,13 @@ struct htm_config {
  * htm_event_start() and htm_event_stop() to make hcall decisions.
  * event->hw.state is kept in sync for the perf core only.
  */
+static LIST_HEAD(htm_active_targets_list);
+static DEFINE_MUTEX(htm_targets_lock);
+
 struct htm_target_id {
 	struct htm_config cfg;
 	int tracing_active;		/* HTM_TRACING_ACTIVE / HTM_TRACING_INACTIVE */
+	struct list_head list;
 };
 
 /* Helper to parse the 28-bit event config into distinct fields */
@@ -164,7 +168,17 @@ static ssize_t htm_return_check(int rc)
 
 static void reset_htm_active(struct perf_event *event)
 {
-	kfree(event->pmu_private);
+	struct htm_target_id *target = event->pmu_private;
+
+	if (!target)
+		return;
+
+	mutex_lock(&htm_targets_lock);
+	if (!list_empty(&target->list))
+		list_del(&target->list);
+	mutex_unlock(&htm_targets_lock);
+
+	kfree(target);
 	event->pmu_private = NULL;
 }
 
@@ -172,6 +186,7 @@ static int htm_event_init(struct perf_event *event)
 {
 	u64 config = event->attr.config;
 	struct htm_config cfg;
+	struct htm_target_id *target, *tmp;
 
 	if (event->attr.inherit)
 		return -EOPNOTSUPP;
@@ -217,11 +232,30 @@ static int htm_event_init(struct perf_event *event)
 	}
 
 	/* Allocate per-event private state; freed via event->destroy */
-	event->pmu_private = kzalloc(sizeof(struct htm_target_id), GFP_KERNEL);
-	if (!event->pmu_private)
+	target = kzalloc(sizeof(*target), GFP_KERNEL);
+	if (!target)
 		return -ENOMEM;
 
-	((struct htm_target_id *)event->pmu_private)->cfg = cfg;
+	target->cfg = cfg;
+	target->tracing_active = HTM_TRACING_INACTIVE;
+	INIT_LIST_HEAD(&target->list);
+
+	mutex_lock(&htm_targets_lock);
+	list_for_each_entry(tmp, &htm_active_targets_list, list) {
+		if (tmp->cfg.htmtype == cfg.htmtype &&
+			tmp->cfg.nodeindex == cfg.nodeindex &&
+			tmp->cfg.nodalchipindex == cfg.nodalchipindex &&
+			tmp->cfg.coreindexonchip == cfg.coreindexonchip) {
+			mutex_unlock(&htm_targets_lock);
+			kfree(target);
+			return -EBUSY;
+		}
+	}
+
+	list_add_tail(&target->list, &htm_active_targets_list);
+	mutex_unlock(&htm_targets_lock);
+
+	event->pmu_private = target;
 	event->destroy = reset_htm_active;
 	return 0;
 }
-- 
2.43.0


