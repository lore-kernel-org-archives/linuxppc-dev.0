Return-Path: <linuxppc-dev+bounces-26048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0024C5B572
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2026 06:28:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRnL15hqzz2yfR;
	Sat, 22 Aug 2026 16:28:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787380089;
	cv=none; b=cvvxpO3m9Kdcmiz2ip1xA10YMLs6QykCaQcmrs5leYk3Ed5IZlc5smGxcyWZ5R6Xk2QDgPWRyPcMYOwV/2JIzgkqJp3ZruZ0tKnJrTMHwE+uuj5Bbbzps5XGNkMtJnFRyBVaDPxGY2bx+2LAIE03I0c3RiSHKJ8xXz6cbAjDz9w/rYS3DMGpPznXR6+98k//O51PN3leNFZ2OEWRDF0jCM0F/+vEdFXtsjQvLdasaSpProRRp+F38B66BH35AdjTVnzszI2DEtW2jQLQQ6n8Nfa0zjPZ2PvlmXSGtmtJWF8EohhDr+DyR+TSnvu/r+FhQngeOYiUdRLWT582it67bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787380089; c=relaxed/relaxed;
	bh=punT/1a5taGn9SsyeCdUWbuboMdbXGyOPX1mR98oUoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4raNd+jigo6N+i53hh3RfhLbLO5h9I0dmzj5Hvs8U0q8WJuudKkAzWCbv8Ju8ygHp7BJnTWm4/uJIfIPMQrie0mfaL2gcR2NJSZYg6HHnVkJvQ2Iznetawy4IcxPL7hjbwtZZEgcYRsAfh7QFTKddQ/RjYSlTNCpON5Dzof2IsX4URDc7kEWitH8liC2KV0K2iZHGTYMfpoIrRuAe0UVUembU8HRYZbAX3CjD5fLtDRrkgsm/pa0zQxaaqaqtb45aiiO0aesa4Mb19vN3mDQROdGbr0a4n9SqhavE3lpI8jI6Myygt5UruW967pJDJT+Cf1gzQKnsq//EtJd34TAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CKXwywXJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CKXwywXJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRnL06Vb0z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 16:28:08 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67M51jgn3694701;
	Sat, 22 Aug 2026 06:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=punT/1a5taGn9Ssye
	CdUWbuboMdbXGyOPX1mR98oUoQ=; b=CKXwywXJZz04Z1CgOxLEF+Fnl0Obojg0P
	Lc9KRtgr/saJClkjxLFDAvj8KIyTs69Nhw6ysbjiT1AwMEyPkIvRvDbIu0hhExRg
	9+6FXkQgf1ZjR9LoQkV/1051GqEl6A7eEK+5OBVbNWceA3UZM29AiygJwqCoTl84
	aKGhRvhlb8+s992r1gZ5yEkRfFwR51wVPomC9r0ENJXSz/zA+pGscAgMv/13CIRq
	AuPeOqTaywpNXStZF9g2ld6gsjrFymk9O54gXupiWuDlInWVBet6F/hoYZ8ywNtT
	gMUDbtwnnjDkwVjfnEpk5P9YTqiirW41up2DQQ7VP7Hz4k1tptf+A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwrhgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 06:28:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67M6QOTZ003264;
	Sat, 22 Aug 2026 06:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqrt2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 06:28:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67M6RvHw40108466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Aug 2026 06:27:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81BE220040;
	Sat, 22 Aug 2026 06:27:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BFD020043;
	Sat, 22 Aug 2026 06:27:53 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bbrouter (unknown [9.124.214.68])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Aug 2026 06:27:53 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v4 4/5] perf data: Add --to-trace-dat option for converting perf.data tracepoint events into trace.dat format
Date: Sat, 22 Aug 2026 11:57:23 +0530
Message-ID: <20260822062729.882005-5-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822062729.882005-1-tshah@linux.ibm.com>
References: <20260822062729.882005-1-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA0NiBTYWx0ZWRfX2JXSrU6GiDau
 qf/jBr9G+dCQqIuerPVlNcKnSIQrqHSi0mVlnrz7VKWnwIDIUXXPYYL8O8sUI0nBcb+dUVVnsG3
 ib8DivsTPfIeJLsTWWJ9/8kJG1EjqnE=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a894172 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SNQ_ApuptzHqR8-R338A:9
X-Proofpoint-ORIG-GUID: 2U0xSH0RBGfYdkKJtBIQhW-3IUlBn01f
X-Proofpoint-GUID: xk3LKHL2zdKj0mmNDNCMSES8cFh-UP4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA0NiBTYWx0ZWRfX0aol0iUaFQbP
 iVq/DfPS8agVY8Onu8SKRfT8X/0RDXwZ8m36eb0BqovMeErmSMkwbtCu6JN2YP1xc6OZTmWrqSs
 6nEa9DA39a0Sxqq1Z968uABHRIjCwnmsy9XVIFOZKzmSniY7N8G0IlkH6JnePkBHg2ZvXOPdoLE
 jTsXZOTfc7ia6KJlVLEBiqqhQrkQzwXQrZV8qEI063JhP3ZXzp9+15kRvYx3P6tnxytAEiQzjif
 Cf09uD6Smhe/XaZfEL4lIg9ct8JF4zUI5hnD//CkNoAI1U8rYb/okMPhyC5HjwLa/n7pyQmguQ1
 tdAk9tasbX9vFA503erPP3h3VO47hT8v9lrC6zg3+owZX/AxH9hWMbTpm7ab3A79Oxs+6lMyTbT
 33nLGzHXyrAb+Cpecv6lLND5sw+cc9k4xPYu9m+BLI9OxKfo162Gl6LigjKdfpkWaIE92fvPwot
 wCNkbuJltwDypuBEKug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220046

Add new command-line option to perf data convert for generating
trace.dat output files.

The --to-trace-dat option:
- Accepts output filename for trace.dat format
- Mutually exclusive with --to-ctf and --to-json
- Calls trace_convert__perf2dat() to perform conversion

Usage:
  $ perf record -e sched:* -a sleep 1
  $ perf data convert --to-trace-dat=trace.dat
  $ trace-cmd report trace.dat

Document the new option in Documentation/perf-data.txt alongside
the existing --to-ctf and --to-json entries.

Honor the --time filtering option in trace_convert__perf2dat() the
same way the JSON and CTF converters do, using
perf_time__parse_for_ranges() and perf_time__ranges_skip_sample()
to skip samples outside the requested time range.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/Documentation/perf-data.txt |  7 +++++
 tools/perf/builtin-data.c              | 43 ++++++++++++++++++++++++++
 tools/perf/util/data-convert-trace.c   | 21 +++++++++++++
 tools/perf/util/trace-dat.c            | 20 +++++++++---
 tools/perf/util/trace-dat.h            |  1 +
 5 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index 20f178d61ed7..578ba6357183 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -30,6 +30,13 @@ OPTIONS for 'convert'
 --to-json::
 	Triggers JSON conversion. Specify the JSON filename to output.
 
+--to-trace-dat::
+	Triggers trace.dat conversion. Converts perf.data tracepoint events
+	to trace.dat format v7, compatible with trace-cmd and KernelShark.
+	Only PERF_TYPE_TRACEPOINT events are converted. Specify the
+	trace.dat filename to output. Requires libtraceevent support.
+	Mutually exclusive with --to-ctf and --to-json.
+
 --tod::
 	Convert time to wall clock time.
 
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 1dd73ed6bdcb..c9c863197d02 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -30,6 +30,11 @@ static const char *data_usage[] = {
 
 static const char *to_json;
 static const char *to_ctf;
+
+#ifdef HAVE_LIBTRACEEVENT
+static const char *trace_dat_output;
+#endif
+
 static struct perf_data_convert_opts opts = {
 	.force = false,
 	.all = false,
@@ -46,6 +51,10 @@ static const struct option data_options[] = {
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
 		OPT_STRING(0, "time", &opts.time_str, "str",
 			   "Time span of interest (start,stop)"),
+#ifdef HAVE_LIBTRACEEVENT
+		OPT_STRING(0, "to-trace-dat", &trace_dat_output,
+			   "file", "Convert to trace.dat format using perf.data tracepoints"),
+#endif
 		OPT_END()
 	};
 
@@ -63,10 +72,44 @@ static int cmd_data_convert(int argc, const char **argv)
 		pr_err("You cannot specify both --to-ctf and --to-json.\n");
 		return -1;
 	}
+#ifdef HAVE_LIBTRACEEVENT
+	if (trace_dat_output && (to_json || to_ctf)) {
+		pr_err("You cannot specify --to-trace-dat with --to-ctf or --to-json.\n");
+		return -1;
+	}
+#endif
+
+#ifdef HAVE_LIBBABELTRACE_SUPPORT
+	#ifdef HAVE_LIBTRACEEVENT
+	if (!to_json && !to_ctf && !trace_dat_output) {
+		pr_err("You must specify one of --to-ctf, --to-json, or --to-trace-dat.\n");
+		return -1;
+	}
+	#else
 	if (!to_json && !to_ctf) {
 		pr_err("You must specify one of --to-ctf or --to-json.\n");
 		return -1;
 	}
+	#endif
+#else
+	#ifdef HAVE_LIBTRACEEVENT
+	if (!to_json && !trace_dat_output) {
+		pr_err("You must specify --to-json or --to-trace-dat.\n");
+		return -1;
+	}
+	#else
+	if (!to_json) {
+		pr_err("You must specify --to-json.\n");
+		return -1;
+	}
+	#endif
+#endif
+
+#ifdef HAVE_LIBTRACEEVENT
+	if (trace_dat_output)
+		return trace_convert__perf2dat(input_name ? input_name : "perf.data",
+					       trace_dat_output, &opts);
+#endif
 
 	if (to_json)
 		return bt_convert__perf2json(input_name, to_json, &opts);
diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-convert-trace.c
index 445479fae888..425b3aaa3f02 100644
--- a/tools/perf/util/data-convert-trace.c
+++ b/tools/perf/util/data-convert-trace.c
@@ -22,6 +22,7 @@
 #include "evsel.h"
 #include "tool.h"
 #include "debug.h"
+#include "time-utils.h"
 #include "trace-dat.h"
 #include "trace-event.h"
 #include "event.h"
@@ -31,6 +32,10 @@
 struct trace_convert {
 	struct perf_tool tool;
 	u64 events_count;
+	struct perf_time_interval *ptime_range;
+	int range_size;
+	int range_num;
+	u64 skipped;
 };
 
 /* Session handle and init flag used for lazy CPU buffer init in pipe mode */
@@ -86,6 +91,11 @@ static int process_sample_event(const struct perf_tool *tool,
 		cpu_buffers_initialized = true;
 	}
 
+	if (perf_time__ranges_skip_sample(tc->ptime_range, tc->range_num, sample->time)) {
+		tc->skipped++;
+		return 0;
+	}
+
 	if (trace_dat__collect_cpu_event(sample->cpu, sample->time,
 				sample->raw_data, sample->raw_size) < 0) {
 		pr_err("Failed to collect CPU event\n");
@@ -185,6 +195,15 @@ int trace_convert__perf2dat(const char *input, const char *to_trace,
 	/* Stash session for lazy CPU buffer init on first sample (pipe and normal mode) */
 	trace_dat_session = session;
 
+	if (opts->time_str) {
+		ret = perf_time__parse_for_ranges(opts->time_str, session,
+				&tc.ptime_range,
+				&tc.range_size,
+				&tc.range_num);
+		if (ret < 0)
+			goto out_delete;
+	}
+
 	/* Process all events - collects raw data per-cpu */
 	ret = perf_session__process_events(session);
 	if (ret < 0) {
@@ -230,6 +249,8 @@ int trace_convert__perf2dat(const char *input, const char *to_trace,
 out_delete:
 	if (cpu_buffers_initialized)
 		trace_dat__free_cpu_buffers();
+	if (tc.ptime_range)
+		zfree(&tc.ptime_range);
 	perf_session__delete(session);
 	trace_dat_session = NULL;
 out_close:
diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
index f71e03716e27..1b236745bcac 100644
--- a/tools/perf/util/trace-dat.c
+++ b/tools/perf/util/trace-dat.c
@@ -194,6 +194,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 	int page_size_used = 0;
 	int ret = 0;
 	int i, j;
+	unsigned long long page_base_ts;
 
 	file_offset = ftell(fp);
 	*file_offset_out = file_offset;
@@ -212,6 +213,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 	}
 
 	base_ts = cpu_events->events[0].ts;
+	page_base_ts = base_ts;
 
 	for (i = 0; i < cpu_events->count; i++) {
 		struct cpu_event *event = &cpu_events->events[i];
@@ -234,8 +236,10 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 
 			extend_size = TRACE_DAT_RECORD_TIME_EXTEND_SIZE;
 			extend = calloc(1, extend_size);
-			if (!extend)
-				return -ENOMEM;
+			if (!extend) {
+				ret = -ENOMEM;
+				goto out_free;
+			}
 
 			if (tep_is_file_bigendian(pevent)) {
 				extend_hdr = (time_delta & TRACE_DAT_RECORD_TIME_MASK) |
@@ -245,7 +249,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 				extend_hdr = ((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
 					TRACE_DAT_RECORD_TIME_SHIFT) |
 					TRACE_DAT_RECORD_TYPE_TIME_EXTEND;
-				delta_upper = time_delta >> TRACE_DAT_RECORD_TIME_SHIFT;
+				delta_upper = time_delta >> 27;
 			}
 			extend_hdr  = to_file_u32(pevent, extend_hdr);   /* still needed */
 			delta_upper = to_file_u32(pevent, delta_upper);   /* still needed */
@@ -288,7 +292,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 		/* Check page fit BEFORE allocating data record */
 		if (page_size_used + needed_size >
 			trace_dat_page_size - TRACE_DAT_RECORD_HEADER_SIZE) {
-			ret = trace_dat__write_page(fp, pevent, base_ts,
+			ret = trace_dat__write_page(fp, pevent, page_base_ts,
 					page_records, page_rec_sizes,
 					nr_page_recs);
 
@@ -298,6 +302,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 			nr_page_recs = 0;
 			page_size_used = 0;
 			base_ts = event->ts;
+			page_base_ts = event->ts;
 
 			if (ret < 0) {
 				free(extend);
@@ -312,6 +317,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 			extend = NULL;
 			extend_size = 0;
 			time_delta = 0;
+			base_ts = event->ts;
 		}
 
 		if (tep_is_file_bigendian(pevent))
@@ -387,10 +393,11 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
 		page_rec_sizes[nr_page_recs] = data_rec_size;
 		nr_page_recs++;
 		page_size_used += data_rec_size;
+		base_ts = event->ts;
 	}
 
 	if (nr_page_recs > 0) {
-		ret = trace_dat__write_page(fp, pevent, base_ts,
+		ret = trace_dat__write_page(fp, pevent, page_base_ts,
 				page_records, page_rec_sizes, nr_page_recs);
 	}
 out_free:
@@ -861,6 +868,9 @@ void trace_dat__free_cpu_buffers(void)
 	for (cpu = 0; cpu < trace_dat_nr_cpus; cpu++) {
 		int i;
 
+		if (!trace_cpu_data[cpu].events)
+			continue;
+
 		for (i = 0; i < trace_cpu_data[cpu].count; i++)
 			free(trace_cpu_data[cpu].events[i].raw);
 		free(trace_cpu_data[cpu].events);
diff --git a/tools/perf/util/trace-dat.h b/tools/perf/util/trace-dat.h
index 5985083b275a..40041dac60d4 100644
--- a/tools/perf/util/trace-dat.h
+++ b/tools/perf/util/trace-dat.h
@@ -11,6 +11,7 @@
 #include <stdbool.h>
 #include <event-parse.h>
 #include <byteswap.h>
+#include <stdint.h>
 #include "util.h"
 
 /* trace.dat file format version */
-- 
2.47.1


