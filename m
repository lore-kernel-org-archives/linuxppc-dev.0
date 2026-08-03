Return-Path: <linuxppc-dev+bounces-25274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4A7C5518F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:00:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKcM2SV5z30F0;
	Tue, 04 Aug 2026 01:00:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785769251;
	cv=none; b=ZQQY/m/AQJ8rB12/wq1IumN1DbQcnHeUx6ZjMJn766efuTr2JwI7j4Agy0kQ5d6kj3hgtrjNrlvr6nluG4nJbrQU5g5oNYvPXl8DWrgEWaHlsvLEebIzHaXCSG10G0czbvkoivpCbb8XlLoCIBzvoa9pr50Zd1nM3CJMZ4HWZkgSMjvicwhE9Hq+yM83zyCbPXT1e/bEXUtVNOuRE1RTPSemsx+fqZhnCns9HXaz52/jVUxb0KjtO2HmGXsET5yiFjvGLg+vEsinRDVtJpwD9aO3QcuwGGpiVALo8jkJrIOO5CXHAOgtMgkJzNxzySN/Eqcd5KdZDmD1K1WNnTZQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785769251; c=relaxed/relaxed;
	bh=tZySNfVsexbOCTzyELxJGogQhhqEAvRoUORkUvNvRgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrjQb8aUwpwyPDbpJsirA1qD6MAOZuPY5CiZUKSi/WZ70iAgUAeBfqMArWlVzwgjyNd9L18ThOYimMAejHjZvlTSrt/govR8TSvHi6hn/n0/9zX6QXu3IrbEvDz3y0NzYyDik5lfLj30CZUXIz08IH6pa0Fz33Vg8ljfHN7YOwuSpoppwol9IEDYKds6b/MjQXO3i1By62Wo+F2vtiRs56ZJW/RQfMtJTQobFXcbzOtrXdBJGYcG2m4ZkutRheTHD131bYbV+O8yMbD5fjvYHqUj7GS8O2Gk/sAJ1bOhv5eWn40Yfi7qar94VdhCfU30YrUbUSaUdZk/IF1rpRomww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IXZUaovk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IXZUaovk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKcK344Zz3bww
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:00:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHg2t2201771;
	Mon, 3 Aug 2026 15:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tZySNfVsexbOCTzyE
	LxJGogQhhqEAvRoUORkUvNvRgE=; b=IXZUaovkxjIILQjk0jJFv21sJPPVVbcdV
	frNOoAAf90DeXTGw58AhVgisVMlDQkQa/fuBFKi+Zio2Wyy7TiZ5QjQeAdNqKnJa
	/qFYiMHowK8dcJGxLPeIDSDzItq5Av9kkJxbuaqK1846UXT1XkPk/EYzLs3R5D/N
	xhOUHj1Qh+nsQvx46twaiUQrMaem/C+bT78CTEIJLKB0r9N/+rY3hJkuWKlsNToP
	X3nFbYoZgkJTe5xDUJrsh1EFTpamnv35LfcDkjnCMW2iR3ym1J9hho1kcSaGhGws
	nK3ivpE4CLW8oZkWDyPd22jWQplwvUKjUFFian+9pig2IrmLoQtrg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhc95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuKDv017279;
	Mon, 3 Aug 2026 15:00:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jww67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F0b4E31588808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:00:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4B520040;
	Mon,  3 Aug 2026 15:00:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55FBB2004D;
	Mon,  3 Aug 2026 15:00:33 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.27.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:00:33 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v3 3/5] perf data-convert: Add perf.data to trace.dat conversion backend
Date: Mon,  3 Aug 2026 20:29:53 +0530
Message-ID: <20260803145958.299956-4-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803145958.299956-1-tshah@linux.ibm.com>
References: <20260803145958.299956-1-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX/0TM5i/b5Lcj
 6yAHWE6dIjGC80xLwlF0A8ebR5kjBbrkBuORFCxXsHb2sEWWMQULLVYiU6D19fFxNnwQCvMt+mn
 Zg9AzJDCZbp5uAXXOf0+Gk0pE4JsU6w=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70ad1a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=U0m960k0a2QOJnjO9doA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX29lG7fPR0FKR
 IscOjSKnuYOK2O53RS0c+epiY02a56N0QqVfbN/ftb9pVlPZvptr+QF0QEscWhkc99Q0tWBV5Fe
 E4w5HPdL/9Pv70SnSgLEJJdCrvInJvU/K5GUYV8b049QQbmv+pxC9ULcMyglwUaPIaW1tMYGnp9
 w/CT65BzDBaKkTYoxMM1fCWPa8KdsE5VQEhhxC8CG8aJlfIUFXqPH69C+YrV4gwpv/DSg9H4BRj
 55bRYbvh1XO2A5T2ppO33LtK+MP7AFxnB6zijq0zFt2vfwcOt8ORyRT+FGO86pFhH/X5IDio7+r
 QoxPbNE2d5713eY5eO5pbDJxHLQcPdiLHHYPPyj8DnxgmUHvI97pfz3O50Ex9EfS7A4oRLl7xdz
 hYMOJVTXgSsQM8MmJNEezxTyOvYKpMA9FBD+kbe9ysWk0SOvKA5Eegt4iYf+BJHWtGE3lAk3Z1m
 wuPOwkG842taJwNH1iQ==
X-Proofpoint-ORIG-GUID: xTlAFa_FaS6jrnw4JnqZ-w_hilGhhjAd
X-Proofpoint-GUID: ZmJWh8znOJvo2A9lwkyk-dnVfUez_Yq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

Add data-convert-trace.c implementing trace_convert__perf2dat() to
convert perf.data tracepoint events to trace.dat format.

process_sample_event() is invoked for each PERF_TYPE_TRACEPOINT sample
during perf_session__process_events(), storing raw event bytes per-cpu
via trace_dat__collect_cpu_event().

Once all samples are collected:
- trace_dat__write_options_section1() writes the OPTIONS section with
  CPUCOUNT, TRACECLOCK, HEADER_INFO, FTRACE_EVENTS, EVENT_FORMATS,
  KALLSYMS, CMDLINES and DONE options.
- trace_dat__write_options_section2() writes the OPTIONS section with
  BUFFER option holding per-cpu data offset placeholders and the DONE
  option.
- trace_dat__write_flyrecord_section() builds ring buffer pages
  per-cpu and patches BUFFER option with final offsets and sizes,

Per-cpu buffers are sized to tep_get_page_size() from the session
tep handle and released on all exit paths.

Register .attr, .feature, and .tracing_data callbacks on the tool,
delegating to the standard perf_event__process_attr(),
perf_event__process_feature(), and perf_event__process_tracing_data()
helpers, so these records are processed as they arrive in the stream
instead of being left as default no-op stubs.

Defer per-CPU buffer initialisation to the first call of the .sample
callback instead of doing it eagerly after session open. By this
point, pipe-mode ordering guarantees (record__synthesize()) that
attr, feature, and tracing_data records have already been written and
processed, so nr_cpus_online and the tep page size are guaranteed to
be populated from the recording machine's own stream data. This is
required because the converting host may differ in architecture, CPU
count, or page size from the machine that recorded the data, so these
values must never be taken from local sysconf() or similar.

The output path honours --force: without it, the destination file is
opened with O_CREAT|O_EXCL so an existing file is detected atomically
and conversion fails with -EEXIST rather than silently overwriting
prior output.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/Build                |   1 +
 tools/perf/util/data-convert-trace.c | 241 +++++++++++++++++++++++++++
 tools/perf/util/data-convert.h       |   4 +
 3 files changed, 246 insertions(+)
 create mode 100644 tools/perf/util/data-convert-trace.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 246d05ce25cd..b95191226f21 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -235,6 +235,7 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
 endif
 
 perf-util-y += data-convert-json.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += data-convert-trace.o
 
 perf-util-y += scripting-engines/
 
diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-convert-trace.c
new file mode 100644
index 000000000000..8dbdb2c9caa4
--- /dev/null
+++ b/tools/perf/util/data-convert-trace.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026, IBM Corporation
+ * Author: Tanushree Shah <tshah@linux.ibm.com>
+ *
+ * data-convert-trace.c
+ *
+ * Implements perf.data to trace.dat format conversion for tracepoint events.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+
+#include "data-convert.h"
+#include "session.h"
+#include "evsel.h"
+#include "tool.h"
+#include "debug.h"
+#include "trace-dat.h"
+#include "trace-event.h"
+#include "event.h"
+#include "sample.h"
+#include "evlist.h"
+
+struct trace_convert {
+	struct perf_tool tool;
+	u64 events_count;
+};
+
+/* Session handle and init flag used for lazy CPU buffer init in pipe mode */
+static struct perf_session *trace_dat_session;
+static bool cpu_buffers_initialized;
+
+/* Store raw tracepoint event data in per-cpu buffer for trace.dat flyrecord */
+static int process_sample_event(const struct perf_tool *tool,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct machine *machine __maybe_unused)
+{
+	struct trace_convert *tc = container_of(tool, struct trace_convert, tool);
+	struct evsel *evsel = sample->evsel;
+
+	/* Only process tracepoint events */
+	if (!trace_dat_fp || sample->raw_size == 0 ||
+		!evsel ||
+		evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+		return 0;
+
+	/*
+	 * In pipe mode, CPU count and page size arrive via feature/tracing_data
+	 * records before the first sample; initialize buffers lazily on first sample.
+	 */
+	if (!cpu_buffers_initialized) {
+		int nr_cpus = trace_dat_session->header.env.nr_cpus_online;
+
+		if (trace_dat_session->tevent.pevent)
+			trace_dat_page_size = tep_get_page_size(trace_dat_session->tevent.pevent);
+
+		/*
+		 * nr_cpus and page size MUST come from the recording
+		 * machine's own stream data (feature/tracing_data records
+		 * never from local sysconf() - the converting host may be
+		 * a different arch/cpu-count/page-size than the machine
+		 * that recorded the data. Pipe-mode ordering guarantees
+		 * (record__synthesize()) that attr -> feature ->
+		 * tracing_data are always written before the first sample,
+		 * so by the time we're in this callback, both values
+		 * should already be populated by process_feature()/
+		 * process_tracing_data().
+		 */
+		if (nr_cpus <= 0 || trace_dat_page_size == 0) {
+			pr_err("Malformed pipe stream: missing feature/tracing_data before first sample\n");
+			return -EINVAL;
+		}
+
+		if (trace_dat__init_cpu_buffers(nr_cpus) < 0) {
+			pr_err("Failed to initialize CPU buffers\n");
+			return -ENOMEM;
+		}
+		cpu_buffers_initialized = true;
+	}
+
+	if (trace_dat__collect_cpu_event(sample->cpu, sample->time,
+				sample->raw_data, sample->raw_size) < 0) {
+		pr_err("Failed to collect CPU event\n");
+		return -ENOMEM;
+	}
+	tc->events_count++;
+
+	return 0;
+}
+
+/* Process event attributes for pipe mode */
+static int process_attr(const struct perf_tool *tool __maybe_unused,
+		       union perf_event *event,
+		       struct evlist **pevlist)
+{
+	return perf_event__process_attr(tool, event, pevlist);
+}
+
+/* Process feature records for pipe mode */
+static int process_feature(const struct perf_tool *tool __maybe_unused,
+			  struct perf_session *session,
+			  union perf_event *event)
+{
+	return perf_event__process_feature(tool, session, event);
+}
+
+/* Process tracing data for pipe mode */
+static int process_tracing_data(const struct perf_tool *tool __maybe_unused,
+			       struct perf_session *session,
+			       union perf_event *event)
+{
+	return perf_event__process_tracing_data(tool, session, event);
+}
+
+/* Convert perf.data tracepoint events to trace.dat format */
+int trace_convert__perf2dat(const char *input, const char *to_trace,
+			   struct perf_data_convert_opts *opts)
+{
+	struct perf_session *session;
+	struct trace_convert tc = {
+		.events_count = 0,
+	};
+	struct perf_data data = {
+		.path = input,
+		.mode = PERF_DATA_MODE_READ,
+		.force = opts->force,
+	};
+	int ret = -EINVAL;
+
+	cpu_buffers_initialized = false;
+
+	/* Initialize tool with all required callbacks */
+	perf_tool__init(&tc.tool, /*ordered_events=*/true);
+	tc.tool.sample = process_sample_event;
+	tc.tool.attr = process_attr;
+	tc.tool.feature = process_feature;
+	tc.tool.tracing_data = process_tracing_data;
+
+	if (!opts->force) {
+		int fd = open(to_trace, O_WRONLY | O_CREAT | O_EXCL, 0644);
+
+		if (fd < 0) {
+			if (errno == EEXIST)
+				pr_err("Output file '%s' already exists. Use --force to overwrite.\n",
+				       to_trace);
+			else
+				pr_err("Failed to open output file '%s': %s\n",
+				       to_trace, strerror(errno));
+			return -errno;
+		}
+		trace_dat_fp = fdopen(fd, "wb");
+		if (!trace_dat_fp) {
+			int err = errno;
+
+			close(fd);
+			pr_err("Failed to open output file '%s': %s\n",
+			       to_trace, strerror(err));
+			return -err;
+		}
+	} else {
+		trace_dat_fp = fopen(to_trace, "wb");
+		if (!trace_dat_fp) {
+			pr_err("Failed to open output file: %s\n", to_trace);
+			return -EINVAL;
+		}
+	}
+
+	/* Open perf.data session - this writes trace.dat metadata sections */
+	session = perf_session__new(&data, &tc.tool);
+	if (IS_ERR(session)) {
+		pr_err("Failed to open perf.data file\n");
+		ret = PTR_ERR(session);
+		goto out_close;
+	}
+
+	/* Stash session for lazy CPU buffer init on first sample (pipe and normal mode) */
+	trace_dat_session = session;
+
+	/* Process all events - collects raw data per-cpu */
+	ret = perf_session__process_events(session);
+	if (ret < 0) {
+		pr_err("Failed to process events\n");
+		goto out_delete;
+	}
+
+	/* Skip file creation if no tracepoint events found */
+	if (tc.events_count == 0) {
+		pr_warning("No tracepoint events found in '%s', skipping trace.dat creation\n",
+			input);
+		ret = -EINVAL;
+		goto out_delete;
+	}
+
+	/* Write trace.dat options and flyrecord sections */
+	if (trace_dat__write_options_section1(session->tevent.pevent) < 0 ||
+			trace_dat_write_failed) {
+		pr_err("Failed to write options section1\n");
+		ret = -EIO;
+		goto out_delete;
+	}
+	if (trace_dat__write_options_section2(session->tevent.pevent) < 0 ||
+			trace_dat_write_failed) {
+		pr_err("Failed to write options section2\n");
+		ret = -EIO;
+		goto out_delete;
+	}
+	if (trace_dat__write_flyrecord_section(session->tevent.pevent) < 0 ||
+			trace_dat_write_failed) {
+		pr_err("Failed to write flyrecord section\n");
+		ret = -EIO;
+		goto out_delete;
+	}
+
+	pr_info("[ perf data convert: Converted '%s' into trace.dat format '%s' ]\n",
+		input, to_trace);
+	pr_info("[ perf data convert: Converted %llu events ]\n",
+		(unsigned long long)tc.events_count);
+
+	ret = 0;
+
+out_delete:
+	if (cpu_buffers_initialized)
+		trace_dat__free_cpu_buffers();
+	perf_session__delete(session);
+	trace_dat_session = NULL;
+out_close:
+	if (trace_dat_fp) {
+		fclose(trace_dat_fp);
+		trace_dat_fp = NULL;
+	}
+	if (ret != 0)
+		unlink(to_trace);
+	return ret;
+}
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index a96240f15671..f041c2325226 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -19,4 +19,8 @@ int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
 int bt_convert__perf2json(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
 
+#ifdef HAVE_LIBTRACEEVENT
+int trace_convert__perf2dat(const char *input, const char *to_trace,
+			   struct perf_data_convert_opts *opts);
+#endif /* HAVE_LIBTRACEEVENT */
 #endif /* __DATA_CONVERT_H */
-- 
2.47.1


