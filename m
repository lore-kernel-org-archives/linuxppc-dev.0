Return-Path: <linuxppc-dev+bounces-25276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550B1C55179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKcf4L63z3bdq;
	Tue, 04 Aug 2026 01:01:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785769266;
	cv=none; b=XbAe4o8KuGcFevBIqkGn8C10p1n9mntsJ9+wcpLOmIlVgr7hBVDwVnhAAza3vz8x5PB98499QEWVYd93PmNDQCAdoIeLnuAX7YfuI+x23p9ORRPbQDlTzp1tevukCifMf0StJ/GLpNC5TCbNqr4vKmwTd+MArwqpXyHuomARM8Xtqi6NpjHX1jd1pAaCf/EeN77tUmiJR18nO4D9mJTrK6RXD0Q6X75EgD6N3LnnkBoKm5wqyZrZRAdjN1TozJBs8K4F7Fi6M+bBU0iVWKTfWXbUmfSy2WWcrLq3o8mQAYHjobSK2tSSvrywAqmb7BTs85VJuJ7NC/lwL6k9EElyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785769266; c=relaxed/relaxed;
	bh=tBkGHj7NLFWGec++e6fPnEStG4RmckR3SWbzz+iAVRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUumjcOfR0JIcUlevKMWex3HO3s0tKT/oyE3bTVpvLNfXgtyRo7WBo7P9QkQecntka6qlr8K87KPFDAJZG9WibNkBcG6LYlMAURUHHhrAkzZU+uJ7Ji6nYjS/SpW526jGG0T4iOh8dGHRwm+8M+1JztocNyp92lW6KVIjF+DqpUXm6uLhaDTv6ws0gnCfRF+rWALBt6nI4drv7LJUHkq1f9SsP1OCfa/Dh3mbbCYR4BU37Jx+DeSeIDIyuBMvwEMRfrYyJV5fDKhijI3Tg+6vSS85zohqZyDnVGomAjha1istW+X4CP8x+Jy5OGjtLK95KJEYHu5GdfuRXBZe+2JRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O7/nbhqx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O7/nbhqx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKcd44Xgz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:01:05 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIqPI2203944;
	Mon, 3 Aug 2026 15:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tBkGHj7NLFWGec++e
	6fPnEStG4RmckR3SWbzz+iAVRY=; b=O7/nbhqxgiUsD7VjSBBCGwgQ7VEkRhnSE
	yefaosRl2WQ777CCqAqsfCvtjPiu7oL+xDmUbY8If0LA4yweFDYWU+iQHTnjWlKg
	WrBNCxiE8uDgUXZGRStZEEUPGkE3zoOYfnt4REskE3uvOCpLNdPt7q2zVV1+fLuu
	Of45zd+3s2AHsX9s65CR4RJWTs+4a0f7q3i2Nwi/CWCq+EbsUk23uQcqx4Dap77e
	r0y61O+Mvrr/OYeLuOhGx8N47mhFEdqfS339ikW0EsOmPTuL7C4HQOJ3b3T/Atto
	XWUC3ce9FOM1qIFsGT2PzpeSCXjZrA3tK5JdMtP1+Nvf2hkgNwqqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhcak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuIWQ014645;
	Mon, 3 Aug 2026 15:00:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5pfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F0pXL27590988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:00:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2D82004B;
	Mon,  3 Aug 2026 15:00:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB8720040;
	Mon,  3 Aug 2026 15:00:47 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.27.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:00:47 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v3 5/5] perf test: Add test validating trace.dat generated by 'perf data convert --to-trace-dat'
Date: Mon,  3 Aug 2026 20:29:55 +0530
Message-ID: <20260803145958.299956-6-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX1NKYkUQMfBTW
 z13z//EVAJhJB76PXZrYPo/gEbvAn9M9NyaCsQsn4Uh2n84wN/PZgx9cxNYUsFcdmOkUYYSDlGI
 zRzLrFHJ8zda4i63yH6TH+Qng6j0MZA=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70ad28 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Yoc1fSEfpoo6qmh3DYcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfXy1MGl17H8jM9
 uLpOa3I0jpG+PBJDb1MAPLlTtoM6nx8KdFxqu/6W1HVO7SAl3Zgwc2bzmeph2BpuYvAAoOwo2bz
 UytMHE71oacBg8z90XFt2eTDpTouPtRwBl/Elzbqm+1Ez1vtbL16rzFtKjOeTR09/y2/GK9uitR
 Dze3fx6fUhVs66Sy/Awxuzl8yU+U22T/TUmmS0v0yi19zcliOVU2T029LQBckkEhkncSSaDPfE+
 qJxQ5463SSE1wcpfthUDL9Yo+ZwgEkhx00qOkg1igIh7wNJkZw6Bg/LUugj84HmMNHulTv9Xbm7
 LtkCFbmHJHYUadxMMtua78vh+YfZMziIBVuSGYOAwJgcHRIbFN0XrefDtofNI5ipgau1x2G8e7X
 QirN0Xpa39YdkVxNJwKFyuZv9sTTBIbJx/F2RWdlGAMlbJ1pAXeFxsPwW1/yomcUv0SFJEJ/QEY
 AhsqakQBe964BTsIQ8w==
X-Proofpoint-ORIG-GUID: FaSaOSby6Pi0R1RBGgx_0b4ks5uySHqR
X-Proofpoint-GUID: vJqUWWuPHPjgIJuI9PQtkh6LcehU4CSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

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
2.47.1


