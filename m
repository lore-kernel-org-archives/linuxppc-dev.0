Return-Path: <linuxppc-dev+bounces-25214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C359C55162
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:09:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCnqh4pS8z3brM;
	Mon, 03 Aug 2026 04:08:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785694128;
	cv=none; b=JagdvCXfxBD4pA7FwHTaOVqInVazzk57VLoDwQXGO9zYmYhpZS1ZAg4HipxKGpQx4afBErhe4PrqeFnDajuJUjnCbYNQFZVNfmAzGjwwkL99kBucNctMqSwg7NsaynifSeGlec3jdTVeteb6F/S1jlPKOGjQl5Pc4/1KGcr4WQU+4FkL95JcLWamEIsBzXzk1rbHddiHYfERA489sL9cAgav6thQOOZ4Ofys9vP1knFgE6kEBJA7Cc/X43CVP61sb6sKsGQ3CV6VQMYjgzIfZn0tyeUC7Eg4Mx3xigl277A8VzRY06ZvGWi8ImM5z5aiel/Rjr5EO+IMCLB1qvWKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785694128; c=relaxed/relaxed;
	bh=Vln5VLDX8X9jWkOvs7x42OFuaI702eKkWphfNqEmY6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/HTtGtlLxtDoTk1xazMKsxNqea9iDibVDN3o6MKlifke7rO+v3eQa8nD0ysdQYevoBb7d6SF9o2a10QGHw1X7YEd3bnkAkMHSXXH5zcvgI9mUoydMQus/nK1vJupFkOcUlAiBCrDiPqtEiGvyUWTlnHkbrxVw8dYbE164j+S8B0i2TPAqZ8qi/UUn57pWBBggSON6Ez6ugQzmDXFxkX6OfuGewJHxoCxRnu260WkHdHNGatzcGvoT1ZswCbDkpkOlstOy4Wl1K4EuizF9lIzOU1eoxra+iPf/KPKFSyrV36n3l8g3ATsgX2qkeCCC53LqxoDkq9Oin3eKQbKFnt6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ewGGuNYw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ewGGuNYw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCnqh0257z2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:08:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672ElpoR3604041;
	Sun, 2 Aug 2026 18:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vln5VLDX8X9jWkOvs
	7x42OFuaI702eKkWphfNqEmY6I=; b=ewGGuNYwfYagVT1sinYtXbBQ+FSk/uEjD
	rCrNsqLNI4tszxo8PpbPYQ0QY7Pe9UDXt19y2AvJ4I9wIjrLKDrf5vtJuCGAx3Zt
	8ja92mYAlPTT5RJKxhk7qBC02JTvmU02rkr7OghCIUBgpXrMGcWgCLF/g1c/HiBd
	2WFN/jT/OwfS86KOqloq/e53X4LRhZfnCTiz9Qbt7JIviDU6sOErK0NKvNDfmz12
	NEn+GvaU9CdOyDtV1qaSXAYbpmOnWs90DDzOFW79OJhUZvZAm9SCk1vHs5o0NrYC
	qhpnfJbaPmJsoJy+90yKoP28cmyc3vkLdMob+IK5uJuhQO2GPYL7Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3n7nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 18:08:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 672HuGMh024057;
	Sun, 2 Aug 2026 18:08:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvt9t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 18:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 672I8bNM46596420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Aug 2026 18:08:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C9A20043;
	Sun,  2 Aug 2026 18:08:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC98320040;
	Sun,  2 Aug 2026 18:08:32 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.211.158])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Aug 2026 18:08:32 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v2 5/5] perf test: Add test validating trace.dat generated by 'perf data convert --to-trace-dat'
Date: Sun,  2 Aug 2026 23:38:00 +0530
Message-ID: <20260802180801.65183-6-tshah@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a6f87ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Yoc1fSEfpoo6qmh3DYcA:9
X-Proofpoint-ORIG-GUID: OSYWXYNTj3TZ7PMJO5a5eZPRfOFfRXty
X-Proofpoint-GUID: ddLOJxt4byIRTq7c63gOSruefZktAjlZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE2MiBTYWx0ZWRfX9D9qZQiVRCAK
 ghYglm5yNaJD6nxCUC7h8YN+9edEnAuwS84IiFLxL9evVp/BaesqlQSzU7D115/hZ/+dJq/iUQ4
 k/0eQxSLUNaZI5kWyshLnEVG/3p8gMo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE2MiBTYWx0ZWRfXy4uuTZkan53C
 alB9dgiRRYF39r9m0vqGMeC7F3NoQp9c8CxfcgEIiLaF5UnpgiuoOgO3jD8m6XEU+5kgX/QlqX9
 2zJkbm5VhjDZAeFiumWbS7H+aX8hyaq85+IIry0gXT1e2e71ZMLraGUW6TQYUOXqaKIPiBzOqgR
 D9cnyNUbEtQS0xVNL191ohFzon1Yjhz+7t2v+c1rOfFHcIdDPatmp0+8XnlNEpgBOqr54IM3OPZ
 35ISm0QnltX2001JsmUiR9nWWZ0ToIW1v7cxHMngttfhQ4sg1dTQiOzWW6h1pe0iIGV98dTT1yV
 MAUu11eyqgmWJm2028Avqf8rsOqppjJEdweqtdqAVyDZWX2zQ6NbsxrCO9uzXjGWJeEVKB4EPes
 F2wSr1xxyelmxR/pMr4Q8HxEEOtvoxzAQLSAxwS3E6e/e83Nw90w3REoTodW09KomJY/dKNJ/zr
 pE92oeuaJ/uJIdpeypQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020162

Add a shell test covering perf data convert --to-trace-dat,
alongside the existing --to-json and --to-ctf tests.

The test:
- skips if perf isn't linked with libtraceevent
- converts a plain sched:sched_switch recording to trace.dat
- converts a pipe-mode recording (perf record -o - | perf data
  convert -i -)
- converts a recording with both tracepoint and non-tracepoint
  events (sched:sched_switch,cycles)
- validates the resulting file with trace-cmd report if trace-cmd
  is installed, otherwise falls back to a basic non-empty-file check

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 ...rf_data_converter_tracepoints_trace_dat.sh | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh

diff --git a/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh b/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
new file mode 100755
index 000000000000..9ca6432618cb
--- /dev/null
+++ b/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
@@ -0,0 +1,169 @@
+#!/bin/bash
+# 'perf data convert --to-trace-dat' command test
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2026, IBM Corporation
+# Author: Tanushree Shah <tshah@linux.ibm.com>
+
+set -e
+
+err=0
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+result=$(mktemp /tmp/__perf_test.output.trace.dat.XXXXX)
+
+cleanup()
+{
+	rm -f "${perfdata}"
+	rm -f "${result}"
+	trap - exit term int
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup exit term int
+
+# Check if libtraceevent support is available
+if ! perf check feature libtraceevent
+then
+	echo "perf not linked with libtraceevent, skipping test"
+	exit 2
+fi
+
+# Check if trace-cmd is available for validation
+have_trace_cmd=0
+if command -v trace-cmd >/dev/null 2>&1; then
+	have_trace_cmd=1
+fi
+
+check_sched_switch()
+{
+	if ! perf list | grep -q 'sched:sched_switch'
+	then
+		echo "sched:sched_switch tracepoint not available, skipping test"
+		exit 2
+	fi
+}
+
+test_trace_converter_command()
+{
+	echo "Testing Perf Data Conversion Command to trace.dat"
+
+	if ! perf record -e sched:sched_switch -o "$perfdata" -- sleep 0.1
+	then
+		echo "Failed to record perf data"
+		err=1
+		return
+	fi
+
+	rm -f "$result"
+
+	if ! perf data convert --to-trace-dat "$result" --force -i "$perfdata"
+	then
+		echo "Perf Data Converter Command to trace.dat [FAILED]"
+		err=1
+		return
+	fi
+
+	if [ -f "$result" ] && [ -s "$result" ] ; then
+		echo "Perf Data Converter Command to trace.dat [SUCCESS]"
+	else
+		echo "Perf Data Converter Command to trace.dat [FAILED]"
+		err=1
+	fi
+}
+
+test_trace_converter_pipe()
+{
+	echo "Testing Perf Data Conversion Command to trace.dat (Pipe mode)"
+
+	rm -f "$result"
+
+	if ! perf record -e sched:sched_switch -o - -- sleep 0.1 | \
+	   perf data convert --to-trace-dat "$result" --force -i -
+	then
+		echo "Perf Data Converter Command to trace.dat (Pipe mode) [FAILED]"
+		err=1
+		return
+	fi
+
+	if [ -f "$result" ] && [ -s "$result" ]; then
+		echo "Perf Data Converter Command to trace.dat (Pipe mode) [SUCCESS]"
+	else
+		echo "Perf Data Converter Command to trace.dat (Pipe mode) [FAILED]"
+		err=1
+	fi
+}
+
+test_trace_converter_mixed_events()
+{
+	echo "Testing Perf Data Conversion with tracepoint and non-tracepoint events"
+
+	# Record both tracepoint and non-tracepoint events
+	if ! perf record -e sched:sched_switch,cycles -o "$perfdata" -- sleep 0.1
+	then
+		echo "Failed to record perf data (mixed events)"
+		err=1
+		return
+	fi
+
+	rm -f "$result"
+
+	if ! perf data convert --to-trace-dat "$result" --force -i "$perfdata"
+	then
+		echo "Perf Data Converter with mixed events [FAILED]"
+		err=1
+		return
+	fi
+
+	if [ -f "$result" ] && [ -s "$result" ] ; then
+		echo "Perf Data Converter with mixed events [SUCCESS]"
+	else
+		echo "Perf Data Converter with mixed events [FAILED]"
+		err=1
+	fi
+}
+
+validate_trace_format()
+{
+	echo "Validating Perf Data Converted trace.dat file"
+
+	if [ ! -f "$result" ] ; then
+		echo "File not found [FAILED]"
+		err=1
+		return
+	fi
+
+	# If trace-cmd is available, use it to validate the file
+	if [ "$have_trace_cmd" -eq 1 ] ; then
+		if trace-cmd report -i "$result" >/dev/null 2>&1 ; then
+			echo "trace-cmd can read the file [SUCCESS]"
+		else
+			echo "trace-cmd cannot read the file [FAILED]"
+			err=1
+		fi
+	else
+		# Without trace-cmd, just check file exists and has content
+		if [ -s "$result" ] ; then
+			echo "Output file exists and has content [SUCCESS]"
+		else
+			echo "Output file is empty [FAILED]"
+			err=1
+		fi
+	fi
+}
+
+check_sched_switch
+test_trace_converter_command
+validate_trace_format
+test_trace_converter_pipe
+validate_trace_format
+test_trace_converter_mixed_events
+validate_trace_format
+
+cleanup
+exit ${err}
-- 
2.47.3


