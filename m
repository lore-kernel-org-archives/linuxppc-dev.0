Return-Path: <linuxppc-dev+bounces-25590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33D7C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGmwJ5JW3z3c8l;
	Sat, 08 Aug 2026 00:38:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113488;
	cv=none; b=A0V/WCmqvpC3RfmEgb2OeKj2cK3kz32Z2mLvZUPtBXyFZSqQRkAbOmFWkE8w967/7r8ZWXAdD37/n19xiFODrDwGXQ8SKUBtM8BYKDKTu/k/XTTADRPLgw3fM0NWo6DOvsPATTiks+ZBB/QJxTdAsoK5PHY+qaC0bUxJSQNJUjaAJ7++t9UPhMy71opFnFGLMx0VCO7nA2JdGMWYgndVvFQnn2k842k5URCDTnD5R7nsKy5qVTphyaTsjpqENMTZG3OjoLro62ee+8IQPeqwC6xP5OChHIyE7n1F3dWm0CP3hhOpigZsiqxNYi6ND6sFXf7iMsw88BmnJRcEu+062Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113488; c=relaxed/relaxed;
	bh=mTPHHk/whi2TmnRnfDj7npfm/lubySDYfdYZlVzR6+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UapiXi0sliOAE60DRRZRNSkJKrUtBfz4GdZT4uYv8TP9dRomkz++Sz3JKRK/OXIkefvjhytk30jBhHDN44DCoj+4jg5Y1pdapE/tfu+9si+GB0C4lcMbsHFhzLw3VPrUTdFjtxen0AKiv1tzOsh2EjqranUoDaKmkXlQExFzOk/jhjchPuljd4BQHNa9wCNYPZq1C8d34Vd5SaaqzNTSkqCyHUMn0NKSdb+fMlA8/GZiaSCee3gyHbEJEq5w9jxnUUyKiInO4cVzB0nXMGKwUefSxz27x/sYYI501FUXea0xsStbRONYLT/Z/HpKMRnPTgUzNwrA3tsTgLcaJia2OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kdhP6LSY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kdhP6LSY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGmwH4msXz3c7j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:38:07 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Cm4cU1563015;
	Fri, 7 Aug 2026 14:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mTPHHk/whi2TmnRnf
	Dj7npfm/lubySDYfdYZlVzR6+I=; b=kdhP6LSYd2qbgd9zjtTZZd5oGG1NnV7Zc
	3z8vNdScaybg5Gc3/Da/djAkDGu+h37LzITsSH79tAUHSHPqIfRxYGl9M/vbvnri
	mmgBSbrfZm9MV2+Uj6wTvgdNoxQprICyJqssUmDeg3o7SgBszOpTZdDZIuT2w5Hj
	An4a66dkpX1cFZuliQv+BLane/RabceI88VoDNVpfGbmaDF7/PplA6o8hfQG6kRN
	8aMwNwtehBujbCxSoIJv2Og+b0UHQIokkKH00RsvjBZoxpaF6qReKvEFjNtlCHsx
	izZR6lWszx5MF6497h9pFWjXlqyGYgs60FRbr1ugig/n7P66Be40A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00c768-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQJSu017241;
	Fri, 7 Aug 2026 14:38:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwg5ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677EbwJ339977342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:37:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63C2D20043;
	Fri,  7 Aug 2026 14:37:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24D7820040;
	Fri,  7 Aug 2026 14:37:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:37:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 2/6] powerpc/perf: Reject duplicate HTM target reservations
Date: Fri,  7 Aug 2026 20:07:30 +0530
Message-Id: <20260807143734.1224-3-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807143734.1224-1-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXwTGuDTCVOOYF
 8iGUYgPZ3An+fcHtI4RqdfEMabxzVk6QFIz4i16gWRqEko6c6/rMo0PbvcRCxgjBHlNWg/1gqz/
 c2rBm2JiCiDvXslrGFKcWKnyANPg1Qs=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75edcc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hH3QnNDdxu067rAKmRoA:9
X-Proofpoint-ORIG-GUID: gl_ygb4zQ1dDcFLLH5B1d9NCF4vv0OJ3
X-Proofpoint-GUID: gl_ygb4zQ1dDcFLLH5B1d9NCF4vv0OJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXxujauGJPEzWJ
 b44zRhdU6uuIblrT6gFERxoZfbvEfQLYP+88Ec6A7mNIAz8XWdbZuEvZkWNxr+Y8CdEG+KyNLNN
 TfAHpkWnqQBvQd9sK2idUPRtZcWv9WuTPbyDt/fIerdfNBLJERhqa/XBxDOpiNUABFDNoaI64CR
 3GbnaQI6UpUtZyVGtFLi5Q/29jejmvTsamoIHaFi9enAjv9KfLDil1gXCVDcwWUeVGJ3ApkN+Uv
 h8dvC1GGbZ52O3v2ENT6Hc9L0UdN4KsepRv++xZGE8NY2tO0VHXAjQ2O0WpCFbvJR3+DNKZIpbF
 ctUdOPJ6Mh+ip8Q6ugR6CznvFJjGBJRxM1CrPy257CURjjzQtI4IFdqc3L7IW/g6RE4S/kCSy+P
 OqoobLQeuyXrsXsJnxXKVOjh7J7aACSrFYBRxzLXVmhM41Mle07d+cpeuR037qcQaygvGDvNbTO
 TENxOZpq+bWy9PAQigg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

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
Changes in V5: - No changes from V4.

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
index cbe4f62813ee..c1ce12605014 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -80,10 +80,14 @@ struct htm_config {
  * htm_event_start() and htm_event_stop() to make hcall decisions.
  * event->hw.state is kept in sync for the perf core only.
  */
+static LIST_HEAD(htm_active_targets_list);
+static DEFINE_MUTEX(htm_targets_lock);
+
 struct htm_target_id {
 	struct htm_config cfg;
 	int tracing_active;		/* HTM_TRACING_ACTIVE / HTM_TRACING_INACTIVE */
 	int configured;			/* 1 after H_HTM_OP_CONFIGURE succeeds; 0 otherwise */
+	struct list_head list;
 };
 
 /* Helper to parse the 28-bit event config into distinct fields */
@@ -168,7 +172,17 @@ static ssize_t htm_return_check(int rc)
 
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
 
@@ -176,6 +190,7 @@ static int htm_event_init(struct perf_event *event)
 {
 	u64 config = event->attr.config;
 	struct htm_config cfg;
+	struct htm_target_id *target, *tmp;
 
 	if (event->attr.inherit)
 		return -EOPNOTSUPP;
@@ -239,11 +254,30 @@ static int htm_event_init(struct perf_event *event)
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
2.53.0


