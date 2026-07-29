Return-Path: <linuxppc-dev+bounces-25011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EBC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:44:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BqS48Bnz2ygW;
	Wed, 29 Jul 2026 22:44:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785329076;
	cv=none; b=XE7vovWiGaAWfUbthrcYXCuznzAduS5/RguoRuKTcAg0wdFXlVX+vATlLeYuRaq4LLdr53Iw0WeEcgxxhtEsdC5oRptLVpXbKCGuI6Q9e6Urxh3PnLibm1zRWTMBw7oMOY6v3cr2btSCGu3eJc61D5W06jnBF/B+MFkWncvY5LbifIsUAM6dd9TciryUTQEzk26SmoQCLcuBIH1pot9x2sYqPEYWj+F/Lxd00WWtLyX8aidStwH2cJqYxjjhTzCQRd1PIJg+pRJSFpMZ5ADR44uQ1bxbkwDuU5qFsfMuNiDf/zpx9H32JgIBBq/cJgB7v7czJXvMwDa1vIiRZYNeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785329076; c=relaxed/relaxed;
	bh=51DYeo38LQ44EjAI4zjnH8kRffvjZCJdDFOdArofh/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmeHpBpd05TF419Mm/4NqQ1OZJy9clqQwVd4Cjz2zebGNjM96G6YN+VXd0nRqbwgvYMY+MRNqosflWncHDmEHswCic5WPsQ2iYFv/N5Xp1L12a825Tfqb/B2iG2AyqLDq3rokGUhqMyhaJrMFkhqHmydkmdfxYRQT6od1wCiXkD0nUGObpmnidZtfbSV1vYRShP7ZwHl1bzcw45OBUYDL/97yr3SBAzrPFJ/mhfm2J1geJotUSqwQt6kl1gnsPasvZzrsUWiibO0ODc27pw5aCb9eKCQMDCupjTxM1B9QkXDFu2qp6/d+4r5tGmIitmIs5/I4K2NjrS34rpU9piBPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8mF0Re5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8mF0Re5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BqR22Rrz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:44:35 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHvQL3955489;
	Wed, 29 Jul 2026 12:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=51DYeo38LQ44EjAI4
	zjnH8kRffvjZCJdDFOdArofh/k=; b=f8mF0Re5AmotKjANeIRPijd0wOZFD+nZa
	VJOJGxUHYLHfAcuo1ob6pkLITCPLhho40nmzcisJcEE6oJm2my+KPK6KkNNBC927
	MHQcHOWVepLU2u8GnpxDvNKK6XYEbMHnvgrlkoG2Q+o3ZDmkHKPFTWy0cNQ00Dv8
	fBAN6SqOunllNhdnxB9golBQoVhmHFI9DAmWGwj8El3wgL1GVl5CTG1wWuXvoeOP
	6UOHcMKCzDnnmTgnr/U98U0sVtBq8MSDb8mOK8y79SiaD1cMiIzLE4XsqPxc1aKs
	4nK2iu3L2sm+jIVtVMOD2B0l92Wbe0x7pv2HdgiEqKt+FNQA0Vybw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nsvtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCfE2s004588;
	Wed, 29 Jul 2026 12:44:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgeh47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCiOes30540100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:44:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4C402004D;
	Wed, 29 Jul 2026 12:44:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CEA320040;
	Wed, 29 Jul 2026 12:44:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:44:21 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V4 5/6] tools/perf: Add powerpc HTM auxtrace event processing support
Date: Wed, 29 Jul 2026 18:13:59 +0530
Message-Id: <20260729124400.65009-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729124400.65009-1-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfXwnrCTNLV2dCi
 e6tDwRK7onM6YH3kH4P0O6Xzq/tdgxMRGQPzJCODBlhz98wvsqKraS4Fi8kn+M50ApPV5mC7VH0
 PE66cArQ2EcLr/W+eVLbCtjlTqPEHHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX1XKeNL6KxO7R
 Gpld16SABh65OAD7MlGuIIHS7Mli0YSBuhqNpB8X1AB6GsjtbQoMwRKA1wj2ERCDNNYwK2lj7bU
 6u5Z85wQY5JsflRUOPU+rwVH7mhwALFYezdDcY7ZVRYO/i9HTmbO7rlvsxAEaYQsW6xWG9gOBFe
 +rAicUL75Z2HjzdDL4qzYP5zW7LcKKv2FlMGUMjR/Pst9mmgaymIXnsnPe+eOzRhWxx4KKSVw+N
 cHJRNcPRJNRql5mX8JHeOGvREhE3BvhEEjbIJtBNVxCdbNpYq5kiAEfunAN629nkxT7b9GIRf1+
 auRGxkNb4zrVAcZyLgVmWVvxWCrNBY07VeX9ce3quDlD6+fi1c3csH71rMaD8T4dbkw/nbexeov
 mDAoecWskXRTJ32TLQSsEJOO2H2MB8zAPcugTpt5USS3eMiRnSTP+8wOpU4VCTKAA4C4f9yc8ln
 FcZponRI6dg1GS6ARzQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69f5ad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SOduUkfoBtTWgvstiHsA:9
X-Proofpoint-GUID: oXm5h-tFRrPW98Q9IdmVN18FjB-h63HM
X-Proofpoint-ORIG-GUID: QOpaVIOtbq_OOAOxVB5CdXm_z5ko2NtW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

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
index 31c0db933f61..9f32f54fad43 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1429,6 +1429,8 @@ int perf_event__process_auxtrace_info(const struct perf_tool *tool __maybe_unuse
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
2.43.0


