Return-Path: <linuxppc-dev+bounces-22195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7246CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:01:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYscr3Zqyz3bqM;
	Mon, 08 Jun 2026 23:01:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780923708;
	cv=none; b=GyU2vMvoydULIhVEdPLc0J3fmORkynVZPjQql+d8lfJsVsUd+SeMdP5oogPS3ojPCoiGXWRB8s/b4pzsxxB03flTt5wbSfrk+BbAw5ijxJzL29key6MzUvoTCIlVfeC7HGfP1CBxgxe6WVVSnbemnzqpZYkp4aOwgmhJLK8nVz8lq9ZNl2YNracKFt0BCLskLeYmNR8dhk2Y3cMQJRe4qqw1siZizJR9vaNPkjNO7OsLBiIfS4jXlUYlXnddT/JnPMZYT9KVuw9DravR5qM/TyYlQtaDQxB+Tx8xcvrYe4OQpN4ZrBmWq9CnJIOzbcJ73HfLCu9TLzhMP33ExcHYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780923708; c=relaxed/relaxed;
	bh=2BcAH/+92BkC/9YbINYIHWA1+V6BmmATyqmiyLHv3WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBDNeTDikiVktaZk5dHBttZQOy32l9eg+yShHaldhkgpq8DSPhplDJHkjqOTLJKknYHlO1g7IUDJi1KAi9Eu7WXXIhs/9jKCBFqq8hcj/iSB9GcEbXQRllR+hIdAazkxmJuyRJ1dKL5M/q7iFD2Ijyq9Ov2Dp90DUEdYqHG55SFTdnJx8Vt55T2muhvW3Yf//48ycP2BZyEMRH+AAA29ZQ7wM1hwueoBjrnltmLiKLlr1dWqXPhTZeZv7sQdQmW87XTdlmro+ZiapWdPAfsnxhG1Jje5cBJRGj34nMAAp4orJ/fOhnOKSRrPZTneWdNmL1WyjqsTvtF57O0y+zjOQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fDPwIS9y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fDPwIS9y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYscq5BP7z2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:01:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Jo4bF439113;
	Mon, 8 Jun 2026 13:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2BcAH/+92BkC/9YbI
	NYIHWA1+V6BmmATyqmiyLHv3WM=; b=fDPwIS9ycCKZjV0+8z7RP/pRf+krGmVze
	ce+cpc8vuwpvCHPHe+hEP4HAFnI6pmlr150DQcYCYZSXZHMwzgl81w00fo2hCgos
	7XWvHoUuJZ2n4TrcdvGYFzHlz/BDQqEmhB7cE0365/syg0ROZXiSafaKpBHzExw/
	BABpF2XgzufVzPUCaYEsGlJwWD2jdwjuGz0oRsjosU4wJ3KyJ7syHJZkl8eGMRki
	4lQrij3T6yRBJ+6Aqv1YqAdj9AkUnHW23dbKc2tNsV8WwN+ul1jcxhoYAM43VLBx
	/tvU9i7/9QxhxZoMdb4xLpOx3maH28hNtC7BjnzDkRl+i8ui0a64A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydybx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:01:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658CngFa019247;
	Mon, 8 Jun 2026 13:01:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fw65t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:01:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658D1c0R17236294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 13:01:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AAB620049;
	Mon,  8 Jun 2026 13:01:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC3C20040;
	Mon,  8 Jun 2026 13:01:32 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.212.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 13:01:31 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH 4/4] perf data: Add --to-trace-dat option for converting perf.data tracepoint events into trace.dat format
Date: Mon,  8 Jun 2026 18:29:52 +0530
Message-ID: <20260608125951.90425-6-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608125951.90425-2-tshah@linux.ibm.com>
References: <20260608125951.90425-2-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfX4yK6fSyJX7B1
 0LD4VM9FX3Par4CYpepgyb+174KN4S72XQPkJuJdzWkMVOV1uj9qW/SaLDgzRN/O/0P2m/rVF1S
 NECracdR4CTkOuG7c3YnzcFZVIOw/riUrgSUj1BqsGPmmbZEyvxVsdUVJQa32V31s8QWkc7pO7R
 OQD21S84mLGwPnpfrQw3YxT81l4fFX9Ubj82Ta7HEQOoneKsjb317J+Mk0k0ZEox01OU6kTeMf9
 VB/arkDRfxKwTHL6OdVv+zw5vSy+urIPeiPC3TwZV3U8dUgQnDI4SCHV/a/ehN+NS8C2dmU8CgO
 iwV3kDxseeRvb8zzbj2p3skpvKOM7ayB5F+SiP+fyjpzFof5rYJu15Si9o0hjoFXeN6W/r2ITrH
 qOkWfjL4ugDbkHzIDOEUgH//Vjw3zDVtlr7MEO6w0GQvD9OnhmNlPlH5ct78DCBW2P/a7S2M3O/
 +SYFFbX/40FOAx3qWYw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26bd36 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=K4taSuynnpskC6VPo1wA:9
X-Proofpoint-GUID: I9pkhyCKv2z56jK8IM63q7GDAxBthAh9
X-Proofpoint-ORIG-GUID: 5k1rZz9uyoyBJhA3FirR4bMvI6Xytmin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080119

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

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/builtin-data.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 4c08ccb8c06b..96ccab77456a 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -30,6 +30,9 @@ static const char *data_usage[] = {
 
 static const char *to_json;
 static const char *to_ctf;
+#ifdef HAVE_LIBTRACEEVENT
+	static const char *trace_dat_output;
+#endif
 static struct perf_data_convert_opts opts = {
 	.force = false,
 	.all = false,
@@ -48,6 +51,10 @@ static const struct option data_options[] = {
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
 		OPT_STRING(0, "time", &opts.time_str, "str",
 			   "Time span of interest (start,stop)"),
+#ifdef HAVE_LIBTRACEEVENT
+		OPT_STRING(0, "to-trace-dat", &trace_dat_output,
+			   "file", "Convert to trace.dat format using perf.data tracepoints"),
+#endif
 		OPT_END()
 	};
 
@@ -65,16 +72,43 @@ static int cmd_data_convert(int argc, const char **argv)
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
+		return -1
+		}
+	#endif
+#endif
+
+#ifdef HAVE_LIBTRACEEVENT
+	if (trace_dat_output)
+		return trace_convert__perf2dat(input_name ? input_name : "perf.data",
+					       trace_dat_output, &opts);
 #endif
 
 	if (to_json)
-- 
2.53.0


