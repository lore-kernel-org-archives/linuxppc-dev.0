Return-Path: <linuxppc-dev+bounces-25275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2618EC55179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKcW4rXsz3bww;
	Tue, 04 Aug 2026 01:00:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785769259;
	cv=none; b=QHHNLDsnsGHVbvSh6qeXZMfMgCafmhUtR3b6t1zimEARLqo8FEbUnTVlo+SLiEBUu4ZxoMkO4swWegu7xiEHxi4Ad/aMQSN6mIxRULfXZEV6sPuicMRUhnYRxzGJczjzF/NM8vDrhsz6jJVdaqn35aSYj8cumxrdQec2RR84fzNtbdJm1v9oTf9+zWjDte0sQtiaMkALnDTX/nnEcZD3UgxYoSfdT12MOVb5FcNFH4kSf8N5fAppRkDVaK6cnNuKb1exmo03zguWEjeqRq9S3W3HO8cr7bqV2C2Fz2TzemXTTHP7GgduSmZI2Gh3/5Ew0+qG1nU3LOjYXSfzgSfmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785769259; c=relaxed/relaxed;
	bh=GwhWTk0o2wOov+/ac4Z6uYx1HZwaEJTWApvxmJXZGhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfKNp2j2JFWQoA6/4NtC+h5zB6Nb1c5NZOhC+OIuEuJz2B4nGb+MX1a4M0dkc6/wGNdvKNtlN2LsGpppuSrMqa4PZUNpUlY66Evop/t/W6cmPCfubqFS8WqvBN/b+9s7sxqcrjp1mw2Xh+qsxZAUi4SqCA9jTFuHl+j/agIXDrGV+tCB6+62zi9fyZ6vSdA6KKD0phfli6sA36x27ASIcjEHnDNrrslj7/hwrqqa/+MCtcOHjhdAexiPWEVOeoo/E0aQHqtRhS+u0DjV3B0g80nhXd7nCR+UBgCRoAFR8oxR3EG0rBNq3TAfj4Xg8umboKG8WkAJSzyI7Ex8SZ4mzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HsvTEeZZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HsvTEeZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKcV5drfz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:00:58 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHeg92206057;
	Mon, 3 Aug 2026 15:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GwhWTk0o2wOov+/ac
	4Z6uYx1HZwaEJTWApvxmJXZGhk=; b=HsvTEeZZMzQeMCVxYnUUvss+bDeLTIvOI
	2tPoWQGZxY0hIS5Y/yY6UGL5c1B46HXvho6WEqU3nsTEOiihoDJU1wU8duRgQ8AV
	+zWnmg2bBujOBVTl/qScqtcyE3JOtyb2PzkJj4JHCuES77Q/0v6xt7rhq3ysjaxV
	9iNTsx797n5lsWJf6ANYBP7TItT/t+9qdLHnObaTPcnyuoNX+jIkN581RxXPsa2E
	KOiPsFhSj4NQ8Yx4NMXTxJT0tGcHhCaeBoKWrRWCOEeH0g3Wv565yNK4pFehRTG6
	CMmWVWoznQcGoOKhHVR72U9XCqzM9FPGwNxyHv9Jqw+XEto4pm2MQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g1823-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuUQC026009;
	Mon, 3 Aug 2026 15:00:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwyxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F0kYj31392042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:00:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 218212004F;
	Mon,  3 Aug 2026 15:00:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C580920040;
	Mon,  3 Aug 2026 15:00:41 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.27.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:00:41 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v3 4/5] perf data: Add --to-trace-dat option for converting perf.data tracepoint events into trace.dat format
Date: Mon,  3 Aug 2026 20:29:54 +0530
Message-ID: <20260803145958.299956-5-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX4FNFCr9r9UVp
 ptXgJVLSLKykgj7UcGfgTOt2E2kn3vTy9vddL3tL9g5OfY7MAPKj6fVhI1VknOL++ku8GxS0B3M
 5DG06JsYKIgM+VIUdekyL6zom2IZ3papwhLjvQsAp0blunSDzJ9zOQ4TSTgwQ8fG6h2vI11agRW
 8PtUeY1PdvqvkRTMxNtiLabbPNozAN3aBOfCzj4/0u1uX2ukVykux96tqbybZsrDIaUiRViikn+
 a8m2/VOPIyyHwgDNXReK6LAB2gH9Pp0aKywiXyflrujqEqrV7Px7Ku6rDN/RTx5HkUWfYOlD870
 hZTMJQZrJUI20uF5VBHV4eG5UWWRuTOxYnKQBhIHCPO6ZboB2JNL9mjleuDXJwsyeb69JEJe6p+
 fRWmh5jJ1cfXjPIOacuIE8UM2eTtX7z/HgCQkinqG8fTX3vnft3THUZ5BrLzxgSPuBJzCSBcWC+
 z7+yRzqCUZUWpmXjsHw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70ad23 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-X2ovouQhoOeBv6AmF4A:9
X-Proofpoint-GUID: ayyT-r0E1Ly_jr5_n53191UbsBCAOFZf
X-Proofpoint-ORIG-GUID: cn2ylnEYqi0SwA6IPkb5igsYcnb1fTjC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX/ISoei+JvCRB
 HeXf7phKLAe3wuvL5s11RT3dsueiYh2G28lbC2RWfeCdK6s2RTXrqhcrgz1v1R+0BX4apxBu7yn
 qY5jPvn6+UQkQ39rsQoFJ4pFJorJ4kY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

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
 tools/perf/builtin-data.c              | 43 ++++++++++++++++++++++++++
 tools/perf/util/trace-dat.c            |  3 ++
 3 files changed, 53 insertions(+)

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
2.47.1


