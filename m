Return-Path: <linuxppc-dev+bounces-25598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748A2C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGn0s3c1jz3c4l;
	Sat, 08 Aug 2026 00:42:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113725;
	cv=none; b=Afz/knj9SxfJXBeDIG/8whwss37dSL3pampCaTQVfRDVttEfBMRMx1a5kUIK0mHgFVwvjgE4A9yKMoXHRNnGMYnU/OQ/sHwWmDYvVqO9kgkDoSPtKjwBpiUfBU0wU52QLUrvUKi6oFnlWDlODxg3rU3Ls2YxVBl/tFphPvIAkwV15OOq/OzqCMSL/3YbxzuFM0XdePrLhMVOhAJfrEQbowCYInEkX49ijx7gK/NAB3qoxrP0gmfGhJyDnMgxYJhu1/1mBwzaS8xPC4ck2UOhglR0lg7GqleB1cZgzzEpHeYTNx6Kw1+efM3qmPuB2AP6908F38dVxWqPajEJxP7I+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113725; c=relaxed/relaxed;
	bh=mg6jUIDBi4LXfr0N63s62XG+ZGsyOXqx6ANPvz2CCes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnGPJ4Ch9MOZwSu5WaIHVpctHGyluOgAi5L6lvxwyufz05xP6HhKO+XILIZyYGzd4bcmjcDS/godkDKluwvyky4HY7NHJxuvX28RlkjMG6AMnbQJ4UJET2s49h6ekUMJ1e5Kq07KrYqfzVF7cftJK2C/w6uqy2wunHheGQmrD/Lb7qrstyTZRBWwn+EjJSwq20/soRudBhL5z0+gcjraHztxKCfvSBKNNq6jw6ocoESIarpW1h08iLawtvTHMFbpkyT7FWTLVZBDQ2X+1z18EMQL1SbYON0541a3yS+sAyMkFyw047NjNyHt7OldCDxA8vNOVMNYryN51BbXiQC0ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d/wdTEDP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d/wdTEDP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGn0r4tXYz3cPH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:42:04 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClgZ61513825;
	Fri, 7 Aug 2026 14:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mg6jUIDBi4LXfr0N6
	3s62XG+ZGsyOXqx6ANPvz2CCes=; b=d/wdTEDPIY+8brbna06hDaiuQlzz5AitT
	KBtQ/Kbmn5NBGMf3NKEH6ljPsK989m9oIxyZA3mVCe+PiRu9lYaob2ljjkMsikNw
	BRV6Hr0Hc4kOv/K4VUhDPpI8X/4K4kpj11cXT1QSyR/8HcXbg1V2vsegDTeVf8JL
	8AwovHCQ6VR94wi0GF35BJi+rjctqPwD5WSQ6Kw7p3yA5/Pb0nbsmhxz+vBqIILA
	Ur7gy9C+bwhT9yLhtmjRyZ58fKUOCFh3o2eMvbEl273JJjRqDhxXJ51U/GrUw/f7
	4kJ5G0uxe0se9vvDZRXDLcAr+/oxSdx3cF/SmGMrME+iBEHcFB7Lw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyvc2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfI5M010704;
	Fri, 7 Aug 2026 14:41:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhr016-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Eftts44106110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:41:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AE4F20043;
	Fri,  7 Aug 2026 14:41:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F08320040;
	Fri,  7 Aug 2026 14:41:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:41:52 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V5 3/6] tools/perf: Add arch hook to drain remaining data before event close
Date: Fri,  7 Aug 2026 20:11:32 +0530
Message-Id: <20260807144135.2607-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807144135.2607-1-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75eeb9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=87GMixV78Mb6ydp6ANcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX3iXptWno3Pu7
 UPy7eGShsLEjESNhU1gCVpaam6gAp/nNHFs6b4ML03A/s+73jycxOie1ywlA7I4cTUp/2pw793H
 HItKtR8pDNQvjdDjOvy2DfuXHDGCQug=
X-Proofpoint-ORIG-GUID: -oGUoQUk2RqvmYzqMoUuBMi9qU-bVtAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX4xfvwrw80foZ
 m2+jzqJ/CaE0zDwstkOfc23cCGcM0GaAHvZIp31fervKr/qLhNaLvWphRFM2J+LGSUIsNWETVZ/
 gDgQts0urEh0zamxLWLBA9QlgkG/YJl4OhlcvhgxKTsm1OOUoYTpovwyRPfrucDeZvyzvwi/k8F
 CXIPI/q88dE2aOycnPX+fBsqyDzCUfZKIEcAKRht94Gfj+Fq8Op0CEw1qXiW8ukz3xGHUoPrJA9
 QdwBeczgldebmWRPVoH9tQNxXsYhbze9PpxvrCW1cF4HONNARBD9Vr8vTp4yZWVjyVkVPGneDA9
 LEGF0ecouveje9dtfuveTatMJkZYvWp2CAiwwJ58Gh5dM+7Ri53tpnlvnmAPUQPz8DvgBLNaVhY
 UX817Tj1d7C8gMx7JdAORX5k9wkiuYPrux/v+Zvg3oAsCNE24H4/N2Kcn99o6fYn9e+AaWrB7zF
 6wVS9UaJm602JItJR5A==
X-Proofpoint-GUID: qFWwL9-6pIbY50H-ySMWimFbkVaTE3v7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070112

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
Changes in V5:
- Rename record__final_data() to record__final_aux_data() to make the
  AUX-specific purpose explicit.
- Guard both call sites with if (rec->opts.full_auxtrace) so the
  function is only entered when AUX tracing is actually active.
- Remove the per-thread TLS redirect loop and 'int t' variable from
  record__final_aux_data().  The existing record__init_thread_masks()
  path already rejects --threads combined with full_auxtrace, so
  rec->nr_threads > 1 and rec->opts.full_auxtrace cannot both be true
  at runtime; the check was redundant dead code.  A single
  record__mmap_read_all(rec, true) call on the main thread is sufficient
  and race-free.

Changes in V4:
- Fix drain_interrupted to not trigger on SIGCHLD: change the condition
  in sig_handler() from "if (done)" to "if (done && sig != SIGCHLD)".
  V3 set drain_interrupted on a SIGCHLD that arrived while done was
  already set, aborting the drain loop on normal child workload
  completion even though no second Ctrl+C was pressed.
- Drain all thread mmaps in record__final_data(): iterate over all
  rec->nr_threads slots and temporarily switch the TLS 'thread' pointer
  to each thread_data[t] before calling record__mmap_read_all(), then
  reset it to thread_data[0] afterwards.  V3 called
  record__mmap_read_all() once with whatever 'thread' pointed to,
  leaving the mmaps of worker threads un-drained when --threads is in
  use.  Adds local variable 'int t' for the loop counter.
- Fix the post-loop fallback condition from "if (!disabled)" to
  "if (target__none(&opts->target) || !disabled)" so that the final
  drain is always executed for child workloads.  In the child-workload
  path (target__none == true) the in-loop disable block is never
  entered, so disabled stays false, but the old "!disabled" test
  happened to be true there only by accident; making the intent
  explicit also handles any future path where disabled could be set
  early.  Remove the now-redundant evlist__disable() call that V3
  placed inside the post-loop block, since the disable is handled by
  the existing code below.

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

 tools/perf/builtin-record.c | 65 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/record.h    |  4 +++
 2 files changed, 69 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..c3eb0af31142 100644
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
 
+	if (done && sig != SIGCHLD)
+		drain_interrupted = 1;
 	done = 1;
 #ifdef HAVE_EVENTFD_SUPPORT
 	if (done_fd >= 0) {
@@ -2437,6 +2440,57 @@ static unsigned long record__waking(struct record *rec)
 	return waking;
 }
 
+/*
+ * Weak arch hook called by record__final_data().
+ * Returns 1 if the arch PMU driver still has records pending (the caller
+ * will call record__mmap_read_all() and retry), 0 when done.
+ * Implementations use perf_evsel__read() so this must be called while
+ * events are still ACTIVE (before evlist__disable()).
+ */
+__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unused)
+{
+	return 0;
+}
+
+static void record__final_aux_data(struct record *rec)
+{
+	u64 last_bytes_written = 0;
+	int retries = 0;
+#define FINAL_DATA_MAX_RETRIES 20  /* 20 * 1 ms = 20 ms max wait */
+
+	/*
+	 * Drain any remaining AUX data.  Called only when full_auxtrace is
+	 * set; --threads is mutually exclusive with full_auxtrace and is
+	 * rejected at open time, so the main thread's thread_data[0] covers
+	 * all CPUs here.
+	 * arch_perf_record__need_read() calls perf_evsel__read() and
+	 * therefore requires events to still be ACTIVE (before
+	 * evlist__disable()).
+	 * A second SIGINT/SIGTERM sets drain_interrupted to abort immediately.
+	 */
+	while (arch_perf_record__need_read(rec->evlist)) {
+		if (drain_interrupted)
+			break;
+
+		last_bytes_written = record__bytes_written(rec);
+
+		if (record__mmap_read_all(rec, true) < 0)
+			return;
+
+		if (record__bytes_written(rec) == last_bytes_written) {
+			if (++retries >= FINAL_DATA_MAX_RETRIES) {
+				pr_warning("Final AUX data drain made no forward progress after %d retries.\n",
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
@@ -2864,11 +2918,22 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
+			if (rec->opts.full_auxtrace)
+				record__final_aux_data(rec);
 			evlist__disable(rec->evlist);
 			disabled = true;
 		}
 	}
 
+	/*
+	 * If the loop exited without entering the in-loop disable block
+	 * (early break, or child workload where target__none is true and
+	 * the block is never reached), drain any remaining AUX data now.
+	 * Events are still live at this point.
+	 */
+	if ((target__none(&opts->target) || !disabled) && rec->opts.full_auxtrace)
+		record__final_aux_data(rec);
+
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..73bc3de97b2a 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -95,4 +95,8 @@ static inline bool record_opts__no_switch_events(const struct record_opts *opts)
 	return opts->record_switch_events_set && !opts->record_switch_events;
 }
 
+struct evlist;
+struct record;
+int arch_perf_record__need_read(struct evlist *evlist);
+
 #endif // _PERF_RECORD_H
-- 
2.53.0


