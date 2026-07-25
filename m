Return-Path: <linuxppc-dev+bounces-24814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388DAC531F9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:08:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6bYL3jJkz2ygG;
	Sat, 25 Jul 2026 17:08:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784963302;
	cv=none; b=XUw1I3GmUY/KGmN1hqREoTQ84bJXBE3vFzDCkM+aP9BCXIzKAU6J+gxkBpGeQopnw9zeAbD0vjxH75DZKzlC5oNVuFWKv7jAyYNmBFRyNilJSYbO+A2Ncz8279gH92KVxRvYt9okIhcERBE7LQ3nYA0d0sDzcCXxfCaybxyz5dL3YTbFfhBbbdgOItu4kroaD25soZ+I9jjf2wh5A8VChbBUGqZCxLLHBiD6t1HsZNbASa+xTgb/rv/GsmXBN6OUiXF4xMCyKYte13eiiWp4i5kdn0pJzOlEwySu/F6+1xpfdO1s5ljP/rryIF1KHsAL7v9r5/l3ZDy7ULJ7M0szmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784963302; c=relaxed/relaxed;
	bh=pZFf1tFWI6exsBW2GBf9dWsQHdbrimhMKE9dDFPzgwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YvIu0qxHDgMD8tv9TSYhCRgrmUayieizWi95433FpoM5JN6zV4I/lY3z318MKVI4YlfzR8OkrITgJceDZzC22IRSqwglhCXmW0aMpF2/56Q8378u3kcNuGPyO2rRRMtD9ybGu7+QTsJfnWD7eTZGse/nKAJ2I4IWBqzFFphcIbSqn6HAAPyWuci0r8B4oUHHEgdjgNIKwpZpnaLQl4y6EyIJk4oIMGZ1wuSwedC1G2My6cnnD5kjGeTNyiaPPTHmHZJCNk2byQCFp1p26zNmRrt5GKzv1OnD8kpfZKv4gMWkEv9iVdLuRYy4BKKwFJKqMfdbkYGG8HZLGfOUx0eaFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gwXB8nm3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gwXB8nm3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6bYK5bkCz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 17:08:21 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5BmAC3952102;
	Sat, 25 Jul 2026 07:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pZFf1tFWI6exsBW2G
	Bf9dWsQHdbrimhMKE9dDFPzgwc=; b=gwXB8nm3s/8gkoTIgo8OAAWVLPCDPOwlI
	AA57BZ7wUhF/6LqBzlFRbQoZJLc/mfyocKbZjzV5O3mv4a9eE4dBWZJxuTzWW0qJ
	JPcCDZ+Wt0gqG/jUGVly4QcWb6sDTuZNdVd4tCtnheX9Z44v8BlVza3dGxdb0gjv
	rIs1z2MntHx3n2pXrLH/PjNtQAbleuO8zr4hPaBnnWMemYXfWEBKNLEb9yV5QmNC
	lTWAkpkxgRurdfT5q1jDwenmZ4ZkPoc70GOBw+bMd/yF6iCqsE57KxXWgHAhpfoW
	pl/TrJCxt5ztF/h/xeBTWd3NAVfcDzSULrdE2ztb1Q2/PoDpggpKw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmn30k6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:08:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P6ubFM011336;
	Sat, 25 Jul 2026 07:08:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn330h47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:08:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P78CFp52691446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:08:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D1920169;
	Sat, 25 Jul 2026 07:08:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE9320168;
	Sat, 25 Jul 2026 07:08:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 07:08:08 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V3 3/6] tools/perf: Add arch hook to drain remaining data before event close
Date: Sat, 25 Jul 2026 12:37:44 +0530
Message-Id: <20260725070747.81435-4-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX1V9GlF9yuFRB
 LfCVe85mvpOKRQWXc9jlAWXCBjDItiuDEmToBHKY4tqL0L6W2cdtFGpLwtvV9LJCeIHcO2MddEF
 m4bmcy0uyEgCYdPZo0f7Pia/JNE9YEI=
X-Authority-Analysis: v=2.4 cv=dIuWXuZb c=1 sm=1 tr=0 ts=6a6460e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UU0qMfV013_QG3kVnbEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX2II9vEwdxkCQ
 hwzLNzG0QqGtEtnywO+u6GaLiDnxDZqzRiHjRtSm+LyrMc/Rzm2F9idEf67Coewwa65L4AhVVBN
 MLw6D7ZaraI1QVIBgWMioqEKQ1cKmYnhqkw8j2xl1esaOyuNfHWtQiGsiM5NEhE2+hoqPTKSPEs
 c9gLD1IlfAzpKojmH4YXzYzEPUimXsFWEJLbNcKdICxSeXeujzGWq1DlDNKyVItmlSsW8KV9jR9
 bFdktfcVf181kk34YH+NytkQbWVMNW/JkZTlue8Yui5HBu/phC+B9BPUYbAAH4xpFzooNualYx/
 ObZVaRj1jlvXqnTXg3oGIrCwfuLwgmFpEAAz1kidSqqmmPn4jesN4oB06TsDPh2r38Ec+BLfip3
 2SN1ik020Tvqu7hEzG4X6u6zPLWGSrlsGJ/V5B3Ymx+2hydfLriJgyzXgCRiV3Htgi2bot7Y0/r
 WaNfMqkHVlEgTOw2xAg==
X-Proofpoint-ORIG-GUID: vUeKtebMG7JSx8wtZpzjGPLeNi_-xRyb
X-Proofpoint-GUID: YLxxqWiqCwjntIGgL-Wwgva8aie2nSv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250061

While collecting samples using perf record, __cmd_record() disables the
evlist once recording is complete. After that, event fds are no longer
read and any remaining PMU-specific data cannot be drained.

Add a weak arch_perf_record__need_read() hook so architecture code can
indicate that more data remains to be collected before events are
disabled and closed. When the hook reports pending data, perf record
performs another read pass via record__final_data().

A static volatile sig_atomic_t drain_interrupted flag is added.
sig_handler() sets it when a second signal (SIGINT/SIGTERM) arrives
while done is already set, allowing a second Ctrl+C during the drain
loop to abort immediately.  Without this, a user who presses Ctrl+C
twice while HTM data is being drained would have no way to interrupt
a stalled drain loop.

This allows architectures such as powerpc HTM to drain trace data and
associated metadata before the event is closed.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V3:
- Add static volatile sig_atomic_t drain_interrupted.  Set it in
  sig_handler() when a second signal arrives while done is already set.
  This lets a second Ctrl+C abort the drain loop immediately.  V2
  tested done > 1 to detect a second signal, which is unreachable
  because done is only ever set to 1.
- Replace rec->bytes_written with record__bytes_written(rec)
  (which includes rec->thread_bytes_written) so the no-progress
  check accounts for data written by the AIO/thread path.
- Add a retry counter (FINAL_DATA_MAX_RETRIES 20, 20 x 1 ms = 20 ms
  maximum) instead of aborting on the first stall.  The no-progress
  sleep of 1 ms is enough for the AUX ring buffer consumer (perf's
  ~1 ms poll interval) to advance the tail pointer.
- Move record__final_data() into the in-loop disable block
  (before evlist__disable()) as well as into a post-loop if
  (!disabled) block that covers both the early-break and
  child-workload paths.  V2 only called it inside the loop
  with a final_data_drained guard, missing the early-break
  and child-workload cases.
- Remove the now-unnecessary bool final_data_drained local variable.

Changes in V2:
-  V1's callback was responsible for driving the read loop
  including evlist__enable cycling. Removed that logic
- Use bytes written to check if session needs to be continued.
- Patch is now 3/6 instead of 3/9.

 tools/perf/builtin-record.c | 68 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/record.h    |  3 ++
 2 files changed, 71 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..370003f31e56 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -192,6 +192,7 @@ struct record {
 };
 
 static volatile int done;
+static volatile sig_atomic_t drain_interrupted;
 
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
@@ -681,6 +682,8 @@ static void sig_handler(int sig)
 	else
 		signr = sig;
 
+	if (done)
+		drain_interrupted = 1;
 	done = 1;
 #ifdef HAVE_EVENTFD_SUPPORT
 	if (done_fd >= 0) {
@@ -2437,6 +2440,54 @@ static unsigned long record__waking(struct record *rec)
 	return waking;
 }
 
+/*
+ * Weak symbol - architecture can override to indicate if more
+ * data needs to be collected before finishing output.
+ *
+ * Returns: 1 if more data exists, 0 if collection is complete
+ */
+__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unused)
+{
+	return 0;  /* Default: no arch-specific data to collect */
+}
+
+static void record__final_data(struct record *rec)
+{
+	u64 last_bytes_written = 0;
+	int retries = 0;
+#define FINAL_DATA_MAX_RETRIES 20  /* 20 * 1 ms = 20 ms max wait */
+
+	/*
+	 * Collect any remaining architecture-specific data.
+	 * The arch code checks if more data exists, and we do the actual
+	 * reading here since we have access to record__mmap_read_all().
+	 * This code performs the additional read pass while events are
+	 * still live.  A second SIGINT during drain sets drain_interrupted
+	 * and aborts the loop immediately.
+	 */
+	while (arch_perf_record__need_read(rec->evlist)) {
+		if (drain_interrupted)
+			break;
+
+		last_bytes_written = record__bytes_written(rec);
+
+		if (record__mmap_read_all(rec, true) < 0)
+			break;
+
+		if (record__bytes_written(rec) == last_bytes_written) {
+			if (++retries >= FINAL_DATA_MAX_RETRIES) {
+				pr_warning("Final data drain made no forward progress after %d retries.\n",
+					   FINAL_DATA_MAX_RETRIES);
+				break;
+			}
+			usleep(1000); /* 1 ms: let AUX ring buffer consumer advance */
+		} else {
+			retries = 0;
+			usleep(100);
+		}
+	}
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -2864,11 +2915,28 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
+			record__final_data(rec);
 			evlist__disable(rec->evlist);
 			disabled = true;
 		}
 	}
 
+	/*
+	 * If the loop exited via the early break (ring buffer empty when done
+	 * was set, so the in-loop disable block was never reached), or this is
+	 * a child workload (target__none, so the in-loop block is never entered
+	 * and disabled stays false), drain any remaining arch-specific data now.
+	 * Events are still live in both cases: for child workloads they die with
+	 * the process after this point; for non-child they are disabled below.
+	 */
+	if (!disabled) {
+		record__final_data(rec);
+		if (!target__none(&opts->target)) {
+			trigger_off(&auxtrace_snapshot_trigger);
+			evlist__disable(rec->evlist);
+		}
+	}
+
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..56de4f95a836 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -10,6 +10,7 @@
 #include "util/target.h"
 
 struct option;
+struct evlist;
 
 struct record_opts {
 	struct target target;
@@ -95,4 +96,6 @@ static inline bool record_opts__no_switch_events(const struct record_opts *opts)
 	return opts->record_switch_events_set && !opts->record_switch_events;
 }
 
+int arch_perf_record__need_read(struct evlist *evlist);
+
 #endif // _PERF_RECORD_H
-- 
2.43.0


