Return-Path: <linuxppc-dev+bounces-26049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFFBC5DF8C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2026 06:28:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRnL62v3jz2yFl;
	Sat, 22 Aug 2026 16:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787380094;
	cv=none; b=B/UOsfnv5Rh7RhDRB8WUCiv4c1ouxJwrNMlAd0yruDcvyjwPXezcWZpAgKVtBojT7gdEnuLC+YiDo5PL5zKsKJftn19d85USq3pq8pbBMPlnmRmovc6dW80U5cTWrZqDYkavdLag7mg3JZK1U9qEGKbYyYP/Cu0GVAD8KC7NCKfLIoo6vD0UZE4FsLGU9jlR9fjdSxpQ/UzDKxrb1/ZL1lIgWSJhCOEDqfPxZtv73gJoXtXpVoova4hFPWuizMGvDwY6LQlVIb7wc9RUX4aMFyqWkkI1ratnWIf+IzKssK27vB3y8Ff8Ycgi8cjDO5oYYRlx2FgSOKCgjkykZfDfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787380094; c=relaxed/relaxed;
	bh=ZTt8bJ0P0AcYadmraAXGYu+91ACJ2YG09StxEkoon04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSFzt15z99ghk/XgthgEBC4XlnA2HebFD2jpXwFkC59lat2pkT3fE5skFT1Sz4AEbJE5U3MRMflERrAUCpdyKaULv64nRjl6qSE7WVaoRkMb6Rw2y47/4FZ6NSSI11JTWw1ASdFdGQyN87NsVgJxXK2uwAWL0oSw2NozNvLnfuC/2ByBYLDtRCtNSn/8MFefUIF7MihI7nw/VgEWrLHM56/0CcwcJeQjCOiYq/aPd7EdEkZ/2wUwtZ+S/0GQMEP7sMSB+FH1j3uWClXZ6vogI4NIpBra6RvB8KvyD9AI41Xg+Jh0fGsY23V0A3KktcrocnOh28LjPNOSQU7+7lkPIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ACC/sjQq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ACC/sjQq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRnL540hFz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 16:28:13 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67M51lKA2541338;
	Sat, 22 Aug 2026 06:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZTt8bJ0P0AcYadmra
	AXGYu+91ACJ2YG09StxEkoon04=; b=ACC/sjQqamwzOmr7ASBaSyH+rqs0zpB86
	hsH2nW3r2fdsqgevun8jUA34V1nP8c9/p9vaZhSD9WeGb+mUe4Kqgq2ZKCazpUTh
	jMrW1Ey93ugJLbt3oag4cmAWXROwnLgaofXAuYiFFlQqGEFmZydRSbBRaP/UBA5f
	QnAknioOG10lAhRNGQLppgb3eiX8tbQ62vunqV83Mr7vgfwTsJ/WPmCLqBliEKdC
	Kv3GLJ+wcr8jnEcYWrNckVjRsYrsLEVK/1Fz2GGuxYttJSKesyD2k7Ru+paAcxsa
	eC01w7FVDPaLaUstL6wB7D6MA+dtqmBv3ySnvcrNq9bH2xFYa/gHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e0r2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 06:28:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67M6QQOn019363;
	Sat, 22 Aug 2026 06:28:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g35500c4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 06:28:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67M6S2TD39125308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Aug 2026 06:28:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8007B20040;
	Sat, 22 Aug 2026 06:28:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8644B20043;
	Sat, 22 Aug 2026 06:27:58 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bbrouter (unknown [9.124.214.68])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Aug 2026 06:27:58 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v4 5/5] perf test: Add test validating trace.dat generated by 'perf data convert --to-trace-dat'
Date: Sat, 22 Aug 2026 11:57:24 +0530
Message-ID: <20260822062729.882005-6-tshah@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a894177 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GLAY7-ROXw80mAfer5IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA0NiBTYWx0ZWRfX1CPgF7OW/ipK
 hcgIkhBxR+UxWusFy9TTgs2QSeG+SDOclJdWgeqHQDnrj2xcC4QmZFr+oWm87vk39mMv081K1a+
 95xrOCRZO6oslOp6Ps3eetbc8bJala8=
X-Proofpoint-GUID: uUVq4UtdTTCWKJ4nCGLrGik1zNHrW9Gv
X-Proofpoint-ORIG-GUID: MpyZyrS6YGF7Ch8BFKDr41nN0ccnslbe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA0NiBTYWx0ZWRfXz04OkqudkUwl
 JUh8nFMoPNNCASiobASRKO9QM5rstJ8LkwscAeOd9kQ8adR8NaLEAX8l1vSpc9WPhd33NLefBMk
 8qD6OA/uwVhEv8yqMXQYH7geJ8NsCoAdYwejfMG3aBF5/Hii57vjPshphBWmX4cf+txkT2KnzBP
 r3VmU3KdGFOXwZqVRCb/IUa/AbtAYyToX51wwf5V1QOyIB3oX0vKQCB3DIMXhUD/5ybr6OVZVHi
 7kUWs8wPdVGuF67cAawfMNZOQojzrRpdJUNIJq3wrMfJXJNzGQsBPuZhRTZrzG8fjnVJM8OyuAp
 mL2AiKIRKKgIFnTmJWjEJ8DNbqHIrq1A/QLDbc9ZBMhFVML8SRVF2bvpe0aMH8fn9z0dHXxcs8U
 FyOawbpK5FuBrkcsfSqf2Y3yfIoB/8APFWXb2eIJHHIqH/Qgu2EGHYLFzAGT7fi14tn1BqqYx/g
 E8vTVxqLm5OqcTO6ZnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220046

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
 ...rf_data_converter_tracepoints_trace_dat.sh | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh

diff --git a/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh b/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
new file mode 100755
index 000000000000..1c0bce270c38
--- /dev/null
+++ b/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
@@ -0,0 +1,173 @@
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
+	local exit_code=$?
+	if [ $exit_code -ne 0 ] && [ $exit_code -ne 2 ]; then
+		echo "Unexpected signal in ${FUNCNAME[1]}"
+		cleanup
+		exit 1
+	fi
+	cleanup
+	exit $exit_code
+}
+trap trap_cleanup exit term int
+
+result=$(mktemp /tmp/__perf_test.output.trace.dat.XXXXX)
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
+	if ! perf record -e sched:sched_switch -a -o "$perfdata" -- sleep 0.1
+	then
+		echo "Failed to record perf data"
+		err=1
+		return
+	fi
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
+	if ! perf record -e sched:sched_switch -a -o - -- sleep 0.1 | \
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
+	rm -f "$result"
+
+	# Record both tracepoint and non-tracepoint events
+	if ! perf record -e sched:sched_switch,cpu-clock -a -o "$perfdata" -- sleep 0.1
+	then
+		echo "Failed to record perf data (mixed events)"
+		err=1
+		return
+	fi
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


