Return-Path: <linuxppc-dev+bounces-24816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86844C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6bYX4hTMz2ygX;
	Sat, 25 Jul 2026 17:08:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784963312;
	cv=none; b=GfzZCnPh+bO95vivA0aJrpL4v1Cz2pp4nkHG1177Y0xRzacM/LNegVq2OHppvnTBC7LZzjXE5US/PfeOmGFx4Fh1pDy7eJanF7xgwpXL08ZtfyC39SBb1N9xP7qUf9ROO758alFbKg/4ZryowKLGQtnt3AZ1Sd+05Xkxm0GwV53IxPgXlYFgDfVFoQbvSbgK7y8h8wJ4zB6n0kL7JbbiRLumvKjReDuVDT2LNcfnl11ehNvOP0+EhvQWPn8NcWUNjj6pFejlJNN8Fud6rcjkGdjIvHuJrpUayR5oKlTazn1aV9uqL6g+mW0UWfbNHc5EJ6iCN6M99UAnze6iC/ETZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784963312; c=relaxed/relaxed;
	bh=n8PvvNHQ2N2FrwgDnYwGkXW/pZ1RjDZydhjVuMiELfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+T1RBYq3qNvQ+zwCfvcH0NKkW1j9er1yQSBRay/hR6oYCL0wc89hdusKDfYtrI4eNOnrwYKcXk7YZJXM4yd4OQF3OYe3AmLzxLl/CBqozm0UVr+3KI6Z8YqcDCMUMeMPkiuCT6Wqc8c4dIAabx8t3gn+TdiNoLtrro/DRwgCIKoIYvd4+gTKEXyj0I2DKtr22KDr72bCqDpc6hejvfInAeEix93AQyUCrWpDOAk3NtnB0MnwSLaVyPfY2oeJ4oPW0SdtMaTiPqanxEH13VcZnELaoSzE3EMu4l30JqJtHt2RFrzRJDmVLKTulMqIcsJc23TNw7daqrY7ESddxdrOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=spcPP+H5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=spcPP+H5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6bYW32stz2ygg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 17:08:31 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5BqRl3848997;
	Sat, 25 Jul 2026 07:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n8PvvNHQ2N2FrwgDn
	YwGkXW/pZ1RjDZydhjVuMiELfM=; b=spcPP+H5VzX3UiZ9K/aeMqdYeHX/SE4vw
	h81vpjtk04L3gocn2IBum1YTTEjN/vUnycN2oXTDI8WknM2oE39qOJUkQmckVISl
	m4QuVTpz+lCv4lTQBDh2ScK2e0hA49AG0CKVwPbtfacLrVMHhCa7tsEE4/B6O/51
	ikzkbvAUw5i9o2jn/NFtMe5wig4H0WW5ETkB7kLZKE0pK0KukNJM5DcrPmptrmWp
	Ed+UWFlu2EEF1GMShCf9hrrgNBiLEQl6uaXtzfD2goYg57WRRwwm3C1qSS8lqkTH
	F2MeiADG30AuN0TrE6fRXd3G45Z0VuuLvSEVxNwVW+2O+8njmXNrQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmkje8qqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:08:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P6uN0j006560;
	Sat, 25 Jul 2026 07:08:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h8gkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:08:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P78LQw33489252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:08:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 609FB20165;
	Sat, 25 Jul 2026 07:08:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C161420168;
	Sat, 25 Jul 2026 07:08:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 07:08:16 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V3 5/6] tools/perf: Add powerpc HTM auxtrace event processing support
Date: Sat, 25 Jul 2026 12:37:46 +0530
Message-Id: <20260725070747.81435-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260725070747.81435-1-atrajeev@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=YvY/gYYX c=1 sm=1 tr=0 ts=6a6460ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SOduUkfoBtTWgvstiHsA:9
X-Proofpoint-GUID: xxdsHiyrVKAL4fJMJAef2ZpNas922XSR
X-Proofpoint-ORIG-GUID: UV7lSONKTuFRbzbB7_kOHqhrG4ybCGpf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX7gU1qsQ6+hRG
 K5RdBAnA5GpMnQ+MzGJC7unBx0BXUKfShWlAFFufvlITdCYk+a8tZYVwwYG/CxRV7iAFUh53V9E
 r2yWWbO61Q14XoOAlq7+nJg00i1U8tvpkrf9i2sAtlTXKhzyibcEy5vo4WquafiQvoacdiF8E2V
 056mkaLixZZiqyBUsjh2tg6FxuPaiPpLEXr5Tdu4X+N+unZ6Y5x8HpENPb4W/qVu5H7QqLI+0mt
 VVKRYEaXLbL752QrOABiXaMiEJafgU2kX0I81oLzBPZaOYX08NGqUzWLlr0dBas+g+Qv8b1tL/A
 QGi3tDVaCPVWHAHX8O8OdL9MOZOso3qM8MSUi4sRV07cX2mK48Nvm1Opi9A7YqY7l4EpFx6BgY+
 zDwU8aOJfIo8Bi3G4sieHoYGbWPs+fZNvTqs3K4Idy8IpIVrXAXAZVdzIuf3w/2GNfvEheMf680
 S8mjgmvir/Ccy8jn9yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX31R+rh6hgoGj
 osLbCAypr4M0ykcy1RlUh5kyr++kIeGALHTrS+SBHn2mGwzpX8b7AsIbnpjvTze6CPHothIQlAC
 gQozn/6ZLWGuWLtiGyiJG0QDQ4BaM8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250061

Add the powerpc-htm.c decode stub and wire the dispatch in
perf_event__process_auxtrace_info() to call
powerpc_htm_process_auxtrace_info().

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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
 tools/perf/util/powerpc-htm.c | 116 ++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
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
index 000000000000..952ed32997d9
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <endian.h>
+#include "util/evsel.h"
+#include "util/evlist.h"
+#include "util/session.h"
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


