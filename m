Return-Path: <linuxppc-dev+bounces-25600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08619C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGn125cpGz3cZS;
	Sat, 08 Aug 2026 00:42:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113734;
	cv=none; b=VxrMBIwbm3VBpZzonyDq1lvVdQzJbgiFzampZyFymkqB0jkrV4+H4ZsCL0uzP0JJc8n/nE/7ndiDGwcSSHUQpYZCnTPn80wQC/fBkJabwNr6IQUbT/gR3I6+17S3jy3YQGadc8S2tUy05n2UUPrKgklX8Fpt/CMwrrIwa/Zndy/HI+6bNbmj8TpJYJmhkrxd07UbyLbd3SZ+C13rw9/VwzgIwYuxm61zSJUDi+heMkYAcGBlVdAxdMac0+nu+aFAMWjqLn5gsfeublBa9h23ALAOe1JCEFhxlMc2ZQATni8IUNMApfto8WYsQ1kKIGV4q1aGTtKkt/g0E+YS6tIb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113734; c=relaxed/relaxed;
	bh=JMOoV7XNgH64sazpdKg4G+LKJuSGlLgNakd0OLEu9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWMQe4D88hsvVPDsQXdDplkbjgaDrWCG9WfszcYWY1ljqjzB3vceG9WRMKqM4v2dQI/VBWXRjoCPLnJXRzhjGhL+ZoU12PfSvbPXFcJ30WA4n+zeF7v6j1zvEHEv23meVFP+15BVSkcQmKdv66Pp+4QgxjSKRISZ3uA2tss+S7ry2kIUel+ujFbyFwU5KhTj2mMiDFH9qB1qhsh+fhm4PUYAdLfiXGpJvdyUJYODk9fxfum5FwFer+TGuWNDCU/IdsiVe0WCQFKshcV6dJ513yii6x52SXW00/aX8RN0Dr9f/CA6wO7s3RTw+ZnbniHWct8RWVu0P7kxrR/tdqEJEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EMuS2sbK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EMuS2sbK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGn116h1Yz3cY7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:42:13 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CmArT1413546;
	Fri, 7 Aug 2026 14:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JMOoV7XNgH64sazpd
	Kg4G+LKJuSGlLgNakd0OLEu9Y8=; b=EMuS2sbKA0pPGRNoj99jtxNxB57DFDmXr
	EuD1Ow8sB2SgWqg54vQjjl6qM/A+bUPrzFAEihRfYvIXKhm40XH2BtCJMEa3n+z2
	KwbMYc4ShPM7qLpj+Bulh/WNc30Jy5bJftWI+cUKnSDPw42r/p7Oc1B5QAWcSYtd
	ApNnD81R1kI+qgrxRXrMkeZBJ5C1kw4/omwl6PAkpZRRYvrGE9rNvRepAV+s9xnK
	+4YSUQn7vRn2wLzwk575M75+qNJ1V7Q6rhoPB102zFNQCWlc7wdnKXuiZm/VU4UT
	JZVPWKnXV6MCUZdb/z+7ZAavzPyqH+FjZyusoPKjXl2mUsaXzjTjg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02c7yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfFjF020138;
	Fri, 7 Aug 2026 14:42:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgqv52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Eg3aR29884856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:42:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 211DE20043;
	Fri,  7 Aug 2026 14:42:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C299020040;
	Fri,  7 Aug 2026 14:41:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:41:59 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V5 5/6] tools/perf: Add powerpc HTM auxtrace event processing support
Date: Fri,  7 Aug 2026 20:11:34 +0530
Message-Id: <20260807144135.2607-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807144135.2607-1-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75eec0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SOduUkfoBtTWgvstiHsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX2l4v3FfSZUNO
 IkSNLM/D5pXo75zJIPkG578bbSTXqJm8ZAcRjoTScOX9Fuk9gcp3+8KwR4VXUvj/j0BB2g9G1qp
 BN6IAjzSMqfrX6Ja+Hr8hd5oDM570Y0iUlKQcg54/l+8DwCAgeo++FgdUSn393wlKQ1A6L0XZ1D
 4wqKqqzuHQqRlExUV5Vs5p0kewDdDhZ7uvUwQP1Qif3P0uGghAhptov8oI47qo4kt85iNA2O1z6
 EPvViVC+HdOb95IZzKo2ryyvo6xBcWspQSyRp9Uwvyd5xy9+f6GDovcifhVptQuq71AQX4YCghQ
 NUuEkkconOjxyfljbVDbTNVuy+dhK3w5Sa2IAHvCaxVBbitc3mYz6meaApMQ/btqHVBVWDoiDu6
 OhneIz8xJqSllzGNZBWtoH5vR0yG0r2J1p2xrdZ8dTGLNQ/3lX34NhEUG+DiO13iP4+t2rqwM57
 Z/0qm36xCixHbVLRzug==
X-Proofpoint-ORIG-GUID: 9C7Dt5z4yG7uHqUnYcN1vm76os-GbuOy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXzJ5YtB8SKK4k
 JzuTWbrWt+MftDzdIMVnpK+fRzjHJ5yoRuE49ZA/VGWXDqMl2cDekmOl2/S53YhRWM2N8W6CHBv
 jft9uRDOPh76nOjEivOVD8lZq9Arx/s=
X-Proofpoint-GUID: _BoVtGR5Al9IMO7EC0T_5KHYSMIp3DnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

Add the powerpc-htm.c decode stub and wire the dispatch in
perf_event__process_auxtrace_info() to call
powerpc_htm_process_auxtrace_info().

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V4:
- Add #include <linux/zalloc.h> to the powerpc-htm.c stub.  V3 omitted
it from the stub; without it the zalloc() call added in patch 6 would
require the include to be introduced there instead of alongside the
struct definition it serves.  Moving it here keeps the allocation
header co-located with the powerpc_htm struct that patch 6 expands.

Changes in V3:
- Change powerpc_htm_dump_event() parameter from size_t to u64 and
use %" PRIu64 ", matching the type of buffer->size and avoiding
truncation on 32-bit platforms.
- Add #include <inttypes.h> for PRIu64.
- Remove the htm->auxtrace_type = auxtrace_info->type assignment
that was added here in V2; this field is now set from
priv[POWERPC_HTM_PMU_TYPE] in patch 6 where the full processing
logic lives.
- Do not re-add PERF_AUXTRACE_POWERPC_HTM to auxtrace.h or the
stub case in auxtrace.c; those are now in patch 2. This patch only
adds the powerpc-htm.c decode stub and wires the dispatch to call
powerpc_htm_process_auxtrace_info().

Changes in V2:
- Scope narrowed: this patch now only adds the PERF_AUXTRACE_POWERPC_HTM
  enum constant to auxtrace.h and wires the dispatch in
  perf_event__process_auxtrace_info() to call
  powerpc_htm_process_auxtrace_info().  It also amends htm_info_fill()
  (from patch 2) to set auxtrace_info->type now that the constant is
  defined.
- All file-writing and decoding logic is moved to patch 6.
- Patch is now 5/6 instead of 5/9.

 tools/perf/util/Build         |   1 +
 tools/perf/util/auxtrace.c    |   2 +
 tools/perf/util/powerpc-htm.c | 118 ++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 tools/perf/util/powerpc-htm.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 330311cac550..7fa354853d2a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -141,6 +141,7 @@ perf-util-y += hisi-ptt.o
 perf-util-y += hisi-ptt-decoder/
 perf-util-y += s390-cpumsf.o
 perf-util-y += powerpc-vpadtl.o
+perf-util-y += powerpc-htm.o
 
 ifdef CONFIG_LIBOPENCSD
 perf-util-y += cs-etm.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index bf08f41d623f..db94e3f33f57 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1434,6 +1434,8 @@ int perf_event__process_auxtrace_info(const struct perf_tool *tool __maybe_unuse
 		err = powerpc_vpadtl_process_auxtrace_info(event, session);
 		break;
 	case PERF_AUXTRACE_POWERPC_HTM:
+		err = powerpc_htm_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
new file mode 100644
index 000000000000..0ef7ecd18c6f
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <endian.h>
+#include <linux/zalloc.h>
+#include "util/evsel.h"
+#include "util/evlist.h"
+#include "util/session.h"
+#include "auxtrace.h"
+#include "color.h"
+#include "powerpc-htm.h"
+#include "debug.h"
+#include "sample.h"
+
+struct powerpc_htm {
+	struct auxtrace		auxtrace;
+	struct auxtrace_queues	queues;
+	struct auxtrace_heap	heap;
+	u32			auxtrace_type;
+	struct perf_session	*session;
+	struct machine		*machine;
+};
+
+static void powerpc_htm_dump_event(u64 len)
+{
+	const char *color = PERF_COLOR_BLUE;
+
+	if (dump_trace) {
+		color_fprintf(stdout, color,
+			". ... HTM PMU data: size %" PRIu64 " bytes\n", len);
+	}
+}
+
+static int powerpc_htm_process_event(struct perf_session *session __maybe_unused,
+				     union perf_event *event __maybe_unused,
+				     struct perf_sample *sample __maybe_unused,
+				     const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int powerpc_htm_process_auxtrace_event(struct perf_session *session __maybe_unused,
+					      union perf_event *event,
+					      const struct perf_tool *tool __maybe_unused)
+{
+	if (dump_trace)
+		powerpc_htm_dump_event(event->auxtrace.size);
+
+	return 0;
+}
+
+static int powerpc_htm_flush(struct perf_session *session __maybe_unused,
+			     const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void powerpc_htm_free_events(struct perf_session *session)
+{
+	struct powerpc_htm *htm;
+
+	if (!session || !session->auxtrace)
+		return;
+
+	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
+	auxtrace_queues__free(&htm->queues);
+}
+
+static void powerpc_htm_free(struct perf_session *session)
+{
+	struct powerpc_htm *htm;
+
+	if (!session || !session->auxtrace)
+		return;
+
+	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
+	powerpc_htm_free_events(session);
+	session->auxtrace = NULL;
+	free(htm);
+}
+
+int powerpc_htm_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct powerpc_htm *htm;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
+					 HTM_AUXTRACE_PRIV_FIXED)
+		return -EINVAL;
+
+	htm = zalloc(sizeof(struct powerpc_htm));
+	if (!htm)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&htm->queues);
+	if (err) {
+		free(htm);
+		return err;
+	}
+
+	htm->session = session;
+	htm->machine = &session->machines.host;
+	htm->auxtrace.process_event = powerpc_htm_process_event;
+	htm->auxtrace.process_auxtrace_event = powerpc_htm_process_auxtrace_event;
+	htm->auxtrace.flush_events = powerpc_htm_flush;
+	htm->auxtrace.free_events = powerpc_htm_free_events;
+	htm->auxtrace.free = powerpc_htm_free;
+	session->auxtrace = &htm->auxtrace;
+
+	return 0;
+}
-- 
2.53.0


