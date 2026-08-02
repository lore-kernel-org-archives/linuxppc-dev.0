Return-Path: <linuxppc-dev+bounces-25213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F38AC55162
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:08:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCnqb2VJWz2yjN;
	Mon, 03 Aug 2026 04:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785694123;
	cv=none; b=CaPBdGpW55dVgnv44MWfPqvoyai2+szuPEla5ODWWyiKUSgsTatJJbbzyTpPCBP2lA8fHO9R3L9g+xUlvDYLgDIas06lIOS3+qR+Dqe8h0tzwfFPZe921Gf/DBZRmfDn8Un6HUtTITnE8uzaXROux8UJaNW7feeKLnz8hmST5qoKvJeAGGE/3dXFVbOuWCF68vIaCa4ip79pK0+G3fm+tzDJXzgDkv+Xrn95t7ZhyVtn/LCvKSzkoLE0Y/3fBVnOV6kWn8NBr2awuiU+TQddnGb1Wenr33MkgJhSexgzhiui96NnoE9esrI6U+Cr9GPZ80hv+sU0Uit/sriR4dQbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785694123; c=relaxed/relaxed;
	bh=Y8dfKr1dog/wZ0jN6Tpv3fU/GGUD6OOMRBinUthQLXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T57NBMt0b4tE4+ktKBa2lABuTOju4D/RE6M+jTgK+G3uyOv6/TNCwICm7ZYaNC/xBl1Bl5mRlKU4LgQsR6CxgW6lGH1nagIZQitsVAUyOmuDddIatPbMguJSCJtZ5aUV+gwT7V/3Nu+sf9KXUV0O7Mo1C0JsZ72B4DscK3Cfxlo7DOlCrF6JupoKW8K91i+1K4aadVulPAlQdgdB9AvTuvqTEn9u0PHGPeTP9Sv+PIJ08wZ+JWwdrIBSiX/agfPIuI93vCTt7wp9NR4gMLBVa5rVHclnMwUBjAZ9B+aLGfM1BPj21ChESoRLfvosNS/m0oI6zs7BXgvAq7971jh4tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h1E4Bc66; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h1E4Bc66;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCnqZ4l1Cz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:08:42 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Eln7r3625206;
	Sun, 2 Aug 2026 18:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y8dfKr1dog/wZ0jN6
	Tpv3fU/GGUD6OOMRBinUthQLXo=; b=h1E4Bc66UqKwQh9sJH6GK5Wshjr54qtTS
	qgmeYspXeu6x9Re6BGC3MlFyNtSM8HiDz/FKSQDwcmW1maZM31G30fu/dB7545B/
	9NZkL5SxS8OvTBXMJczgKXE4woGoOqx3CIO+1Ecc0hoNu4FCayNu9fCfZtqnpZON
	VwrGt5QxjEmf2BMQUUo/OsXg1px/5IkWFZKZnuRQDpyUZWtQR94apGV7Un8ZTtxQ
	GEpyc0+wVWzynUpNc+I4FFuuFiVevEMU2r3VT3oAlS8pgtCNkCN7g62poMz9uTEK
	H92oS0mV5OQ9C1rJ3EgF3PeuRYPBbUrfCcuUtTOmEdANltBAxm4QA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4n6j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 18:08:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 672HuIKh018330;
	Sun, 2 Aug 2026 18:08:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg20ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 18:08:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 672I8Wvp35586384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Aug 2026 18:08:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 679C320043;
	Sun,  2 Aug 2026 18:08:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6487920040;
	Sun,  2 Aug 2026 18:08:27 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.211.158])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Aug 2026 18:08:27 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v2 4/5] perf data: Add --to-trace-dat option for converting perf.data tracepoint events into trace.dat format
Date: Sun,  2 Aug 2026 23:37:59 +0530
Message-ID: <20260802180801.65183-5-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260802180801.65183-1-tshah@linux.ibm.com>
References: <20260802180801.65183-1-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE2MiBTYWx0ZWRfXyc2nnHf3YvN9
 LSvhVbz61Y0GmzQjAdKEg09UBa/a714R+UiPmipxfhL5HQMv7W9adFbfM7EWKqRc3PVKetadocD
 uWxNPLomZfArgXKBTOu+fYuLBM05TOA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE2MiBTYWx0ZWRfX8FgBt1HjaDQh
 PZB5ONhkunSetTBog/SDq3gNrd5AlVuTjHVNELaKKyEQhOlrZvM1mwRc+SXQktsXPezBRh9GW4T
 jiPUf3vpVFvL5hP1hUJz8JaJ/K0bi77jlqGyOuSPnQk8Duh+brm74KOxYsBpSrtCsu0YnvGU6nH
 oTvcnUbXY7WOoTsV1s/kGpvtWcaELyni2aov/3KE7FV9/jmt+9iO2NUqvttpS6B1K1TZC05BlHb
 zCNggvm/me8bsKHiRZ9qSSVypbZ485+aDmU+TIYLPsmkikirtl9vTK+SB0HDmhmO16iADa+zhmY
 0g//9DXF/LaAzOdI4P6LVEeJOjde1B1r0ec4x9wI06LVRrCykbZM/0C8XWUS4cfszQlDhnp4JO1
 rZzl8er7BZ4MoxdeqR1/ymWD3ybtxrVDCp55pHWGtcB+rtrOyOcxGPpf32ZR+8SSJdTWS/KXkLT
 H/UnhwrCtCQuCAc5YaA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a6f87a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=bBqKyimmlcDRj2OxEasA:9
X-Proofpoint-ORIG-GUID: 4rv2lrKpg_CyX089Mk5kLncyiWTW2Dzs
X-Proofpoint-GUID: s0F9CQDvn1lqAI4vrTNMtGdWkwwDPX1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020162

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

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/Documentation/perf-data.txt |  7 +++++
 tools/perf/builtin-data.c              | 40 ++++++++++++++++++++++++--
 tools/perf/util/trace-dat.c            |  3 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

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
index 4c08ccb8c06b..194537503ba9 100644
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
@@ -48,6 +53,10 @@ static const struct option data_options[] = {
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
 		OPT_STRING(0, "time", &opts.time_str, "str",
 			   "Time span of interest (start,stop)"),
+#ifdef HAVE_LIBTRACEEVENT
+		OPT_STRING(0, "to-trace-dat", &trace_dat_output,
+			   "file", "Convert to trace.dat format using perf.data tracepoints"),
+#endif
 		OPT_END()
 	};
 
@@ -65,16 +74,43 @@ static int cmd_data_convert(int argc, const char **argv)
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
 #ifdef HAVE_LIBBABELTRACE_SUPPORT
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
 #else
+	#ifdef HAVE_LIBTRACEEVENT
+	if (!to_json && !trace_dat_output) {
+		pr_err("You must specify --to-json or --to-trace-dat.\n");
+		return -1;
+	}
+	#else
 	if (!to_json) {
 		pr_err("You must specify --to-json.\n");
-	return -1;
-}
+		return -1;
+	}
+	#endif
+#endif
+
+#ifdef HAVE_LIBTRACEEVENT
+	if (trace_dat_output)
+		return trace_convert__perf2dat(input_name ? input_name : "perf.data",
+					       trace_dat_output, &opts);
 #endif
 
 	if (to_json)
diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
index f71e03716e27..5598496c9a61 100644
--- a/tools/perf/util/trace-dat.c
+++ b/tools/perf/util/trace-dat.c
@@ -861,6 +861,9 @@ void trace_dat__free_cpu_buffers(void)
 	for (cpu = 0; cpu < trace_dat_nr_cpus; cpu++) {
 		int i;
 
+		if (!trace_cpu_data[cpu].events)
+			continue;
+
 		for (i = 0; i < trace_cpu_data[cpu].count; i++)
 			free(trace_cpu_data[cpu].events[i].raw);
 		free(trace_cpu_data[cpu].events);
-- 
2.47.3


