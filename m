Return-Path: <linuxppc-dev+bounces-24472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC9EC44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3cc60hFLz306N;
	Mon, 20 Jul 2026 20:45:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544326;
	cv=none; b=LlPS/eXYk3GEODSjIqx6VuxqkX7O8EyN48hysql/qwcZk59ygvMT7TTUmOFCgiLGD88GLudqyTTZB5e3ylC+DATE721+EmtJBtynWRBGAT920lacDmxgRjt2Eg2vybQApsp1A2nIWDpaewSgv7LayKsx4DJnfFkB0Ti7AneUJhKdrHda4w+VzFfZYw98GO/DZ9scHUrk6q0yrVbEjWFvYgLVJ1rf82bJkqDjSMRNVkH06dzzipcinKNIAXtjipN8GAF15lNGqPy1Oqen45/suEQPp79PJXVT1+Ye+wYvyvpfYEPIaxzfEySJ+fcpvIQh+jEuw3CFmGPdxdOjq/2Bsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544326; c=relaxed/relaxed;
	bh=hhx0/37FaNm9F+HZId6yHahIuW3g3TmVDTstmAbuU1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PelRIlekvUfaEH8SKvxWVkjvU7qH56vGlcYvNdcmtkd0RH78jphW+BCC5Hb947ZoF09N/JiJ9OoAysIecwMIGPzEpabR4WWgBI7HgystB1mcwTv8+QNo5fP8tp4emkQBro1PKkU9rPym/ZFNg44UlC+yFjKPpfEZ8KqEoyOhqqvyGz+CFGH0lGna67h0TXDdU3m4b7N3GoZPXekua4xp4syNpez/Z6iykcTnnRX4wH5LwwFXagjkdfm3YfE9Ea8A4gHXrhNx/9uj8t+upjLgvO/uvMr0YoA3rARg8IlYqTEdJbr0d6/H6cXwwdvAb0J8ElA9c0JmWnqV6J6qzmdVCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BVCagt3i; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BVCagt3i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3cc50rSVz2yll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:24 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABrRD1908334;
	Mon, 20 Jul 2026 10:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hhx0/37FaNm9F+HZI
	d6yHahIuW3g3TmVDTstmAbuU1k=; b=BVCagt3i2A6haxjWtm2aJ7JzbFzBLmJWe
	XZ0lRlbsjdiqeJi3dIiYxplXJOZgNNx7AnR6GVmkk/TCeYP6eOckXLpTmajrkIsu
	x9Fl/OszhKTDGE5/FnVsidkAQGrISQxW7Y9gBKquMIdHm/Sxu21+Pk4n1aWJx+bN
	u8iS1/xgxHi0GOWotk/4HQLB72mueqmrH9r+ZpUgkIgWf2v/qhecEhwU6gIBqdLp
	woCK+UjJbhX+V0VeiT+4e1jAiwcLHsz4riptvVyBibpPu6sBbhWXtugOFtCYEbzx
	RczCErBqyPZ/itWTuSY1kYuuH8GbRt8Zl5r7fw53OjKJ9l0hfKyzw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxrat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYdhq012601;
	Mon, 20 Jul 2026 10:45:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vwaj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjFB515008200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD27E2004D;
	Mon, 20 Jul 2026 10:45:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7175C2004B;
	Mon, 20 Jul 2026 10:45:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:13 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 2/6] powerpc/perf: Reject duplicate HTM target reservations
Date: Mon, 20 Jul 2026 16:14:43 +0530
Message-Id: <20260720104447.11843-3-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720104447.11843-1-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0NX0QYQMyHX0d26gpxnhFfAFv_EkaWWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX7Dz9ZXw+UsM/
 g5rA6igVLTUYyWHPLJeAq6JsaUGolNOey67uPBwIgqNcJlWH93hwkrvSPrc3CLVQ7704FwOa4ns
 72HV0/DWi3i5ebUEfiFA6p4KOxRkuDKFQqtyIZeIkJApBFMJq6l+/BSFONJcKUWNUEn7pJqLPiU
 wIhk8u4gsOjcQSeWKIvZSJZ4ap4Vx5tLnI56qPfoBc7hCTUPWaAskGnXxj/BWAdmqVBoSCfOncj
 Aq7iW46cUKrgVMszJsxGWUV4sP/uNQ/iY50w/ranb+N5L0KZUf6WjSvWI79AL0sJwRK0y2Sb2dR
 upB0N9rjwsHviPHkK9j5JALJW1JulpcCqeVw+pu4/V1y3CHaR1U2SoFmL0582ru/53EUVs6lwot
 9adJiEKdyXE+Yzj8JOQsS5z/6/EnnFLY7JSvmG+RB2qpKyRTOZ8wA2vkJp2wvkV5oB0MgY52oab
 8JbvZtUkuMFwlJezu3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX1ocRlSihEomb
 hnGfIvK1ttj7t9YzDAbn4l0JsjjRgpB4evVTHpYIC7KHjV1xjuKhBuodfahAorqr3nGii7yb0X/
 TK1Csp0x0Ehe5h+WUtRszmNLmOtb4EQ=
X-Proofpoint-GUID: 0NX0QYQMyHX0d26gpxnhFfAFv_EkaWWp
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5dfc42 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=KhUW88Fx2FSJfNT8J3cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

HTM tracing is controlled through hypervisor calls and operates on a
system-scoped target identified by HTM type, node index, chip index,
and core index. When userspace opens a system-wide event such as via
'perf record -a', perf may initialize matching events on multiple CPUs
in parallel.

Without driver-side target tracking, concurrent event initialization for
the same HTM target can race and issue duplicate configure/start flows
for an identical tracing scope. This can lead to conflicts in the
underlying H_HTM operations.

Track reserved HTM targets globally and reject duplicate reservations
for the same target. The reservation is created during
htm_event_init() and released through the event destroy path. This
prevents concurrent duplicate opens while still allowing different HTM
targets to be used simultaneously on different CPUs.

Extend the existing per-event htm_target_id structure with a list node,
and use the stored htm_config in pmu_private for target comparison.

A cpumask-based approach was considered but not used: cpumask restricts
which CPUs an event may be opened on, but HTM operates on a hardware
target (node/chip/core) that is independent of the CPU opening the
event. A user may open an HTM event for a specific node/chip/core target
from any CPU in the system, not just CPUs that belong to that node. A
cpumask would therefore either over-restrict valid opens or require a
per-target mask that mirrors the target list anyway. The approach in
this patch handles the real constraint: the same hardware target cannot
be configured twice, regardless of which CPU does the event open.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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
index abecc9bb58dc..01c6bd2104cf 100644
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
@@ -154,7 +158,17 @@ static ssize_t htm_return_check(int rc)
 
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
 
@@ -162,6 +176,7 @@ static int htm_event_init(struct perf_event *event)
 {
 	u64 config = event->attr.config;
 	struct htm_config cfg;
+	struct htm_target_id *target, *tmp;
 
 	if (event->attr.inherit)
 		return -EOPNOTSUPP;
@@ -188,11 +203,30 @@ static int htm_event_init(struct perf_event *event)
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


