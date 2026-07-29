Return-Path: <linuxppc-dev+bounces-25012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B69C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:44:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BqV6dZSz2yvy;
	Wed, 29 Jul 2026 22:44:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785329078;
	cv=none; b=noa3b07tkEAgf6HmRUlkP26jCFsBp4J3FAE1KUpmZemy2VXOBK/y7ekb6ruhwdW4AvfkBVvpToEhUSxgVfy5mc/8y+Z5AU8AWLGKxAQ6b/HmWNLan7rppNY08oB9IF8dbmSQgzh7gSoljO9dqTIwzmJtRQxVBMN4Df5Wbx12k3rbbcxBzmhI4HC0JqmGBlb4+sToVpHvrBnUnwn/D1J16AClNB1DbEZD7w23hG7pHuskY97PYy8e1z6qlJqdVUNCt67UmedZV6Acidun7C89zmx8+h1moigs48Z9jB5Lsgf8Fkzxz8odqEGwrvW66G0cFUKBhXBXbBtZ6Wrp8Wj5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785329078; c=relaxed/relaxed;
	bh=zBESC7tQe1Tg0osuFJyYgLyWDrqUy8HHeLtFIqXDdZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6ErDRoU0qwapD8ry4SGNP+eaEp1FQIQYNaqQTekqN4qUuCgr24P/qnLwY5/BxnAly0Dglb2tkcqvqGcSt3RvXR230+ssWq4dV8AF8N+rmy8uVzkQgzsMFqW93yK6bVZXe7oH2DolopSJx8SAURLv3+x49iO0BdQq/Y0+TypN7GNdKf0QDIJLMkLrZBEGh2GkakHV9ej6KvfPBH3p8j77BdsuDAybEB6M0vyYdvjozlGG+TZLnhwqOiYvx6oAtth1EM88doDmabz+SjCwOnw/3G4ftvOS7V95weg6mJtOetmTYd/n+vTWqxEVAhJW/wunGcWh8ureKeouvtwd/hrMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KSTfV+Ll; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KSTfV+Ll;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BqT5zMKz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:44:37 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHZL64029915;
	Wed, 29 Jul 2026 12:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zBESC7tQe1Tg0osuF
	JyYgLyWDrqUy8HHeLtFIqXDdZg=; b=KSTfV+Ll7JTAbCgwK4FNhhuPXCmlLOUJq
	naiZoyhfcaF17i0NIZ4yhyQU7nUsB13mkMeEt7BDBSAVyqVisTw9HCS38fN06mes
	ju7qmNYbu+Y9LJOsN/5s16U3he8EK0LRIJTSRPkCP25sLI95e4Jqy9+JfwZhlult
	siBmGaaaDyh6TXjVomQrffmTtj6kQoRO5dM3SCfSW/rTjXjYL1ZsF53JkP7wQ49/
	GNrylSWxwT4qXO1xy5URcJDfbcryRlCjqBj5jGu9544U1AmcJh+pFXSqcjmhuLBi
	OfrqMJ1XqbfUnwUbiBij7hAzhlidfRZ7sjLnC8mNxaJYsnax4dyYg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7jp4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCfIpK004621;
	Wed, 29 Jul 2026 12:44:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgeh4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCiS4930409130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:44:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6099C20043;
	Wed, 29 Jul 2026 12:44:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 154DF20040;
	Wed, 29 Jul 2026 12:44:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:44:24 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V4 6/6] tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE records
Date: Wed, 29 Jul 2026 18:14:00 +0530
Message-Id: <20260729124400.65009-7-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729124400.65009-1-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: hlSWgt7FeFXhWW0OJJhz9mrEFPFb3sos
X-Proofpoint-ORIG-GUID: RT4Hb2_hhz1_adxBpWLxM3NrDrBNPRT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX7k7iBzVr09po
 m13gfVpW2ya34BUw1dKaBncOXl2EgmPF4oiF6MaShg7VNyXpv0vZD0NBNjvQdiED5cerEjiNn8X
 C85kV9LVQ1cAfO0PdrKx1kjl2miniRXFvsgo0nyBiXW8BoJI6Vb5jv9oRxy1apFfheXdYQ7u3Xy
 mjN4H1hnjvs6weagvWl7Ko3hhU+bOMklXMwvvKmcxcju4uPF9TGOGq/HpM73EBT0Db+RrxKUAf5
 NQ3SChrTtG+CTrqzr0SqOHhezMEHEONwK1VRoQRu0C7lqIB4RCvG1Yu2ZQP1kDPJ6msDBZoF+0N
 BI2fIrQZio6kO2/XPD8e9GzTOn5B/M8q7+0TeCQTBOif/4Hgo/nh1Tb3hszLeThJRO/6VodnW/X
 pLtkWqoHfdqf+ZpRRIZTyEMElFtEdShnYgA0gIXhpPpSnRg03apWxq9baG8Vj0icZVzcCEihhSt
 uJpu8olBDizLk8owDdA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a69f5b1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=kFYPTTaGYRG73XwYeukA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX2lkesun2fuU1
 kawWpHexC3Xiom/DGd2dRMaOwq5JsuTi/yhjcJH03oBifoq9rvCnFLH0Yk6MyYSej36qltIMml6
 Wf0hGcW6JrR2FxFiqh3upFEmSzmAzT4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290102

powerpc_htm_process_auxtrace_info() reads the (cpu, attr.config) pairs
stored by htm_info_fill() at record time and builds a cpu_configs[]
table.  This lets process_auxtrace_event() map each AUX buffer, which
carries event->auxtrace.cpu, to the correct (node, chip, core) target
and write the raw trace data to htm.bin.nX.pX.cX immediately.

PERF_RECORD_SAMPLE events carrying PERF_SAMPLE_RAW data are handled by
process_event(), which extracts memory configuration records and writes
them to translation.nX.pX.cX.

Per-run first-write tracking (htm_target_seen()) ensures each output
file is opened with O_TRUNC on the first write and O_APPEND on
subsequent writes, correctly handling multiple AUX chunks from the same
target and stale files from prior runs.

For perf report -D the AUX buffer size is printed.

Example:
  # perf record -C 9 -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ sleep 3
  # perf report
  # ls htm.bin.* translation.*
  htm.bin.n0.p2.c0  translation.n0.p2.c0

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V4:
- Change htm_config_for_cpu() from returning u64 (using 0 as a "not
  found" sentinel) to returning bool with a u64 *config output
  parameter.  V3's 0-return sentinel is ambiguous because 0 is a
  theoretically valid attr.config value; a CPU pinned to the default
  chip with default field values could legitimately produce config=0,
  causing htm_config_for_cpu() to silently report "not found" and
  skip writing the AUX buffer.  The bool+output-param API removes the
  ambiguity entirely.  Update the call site in
  powerpc_htm_process_auxtrace_event() to use the new signature:
  replace "ev_config = htm_config_for_cpu(htm, cpu); if (!ev_config)"
  with "if (!htm_config_for_cpu(htm, cpu, &ev_config))".
- Fix the type of the written local variable in write_htm() from
  size_t to ssize_t, matching the return type of write(2).  V3 stored
  the signed write() return value in an unsigned size_t, so a write
  error (-1) would silently wrap to SIZE_MAX and the mismatch check
  "written != size" would fire with a misleading byte count in the
  error message rather than surfacing the underlying errno.  Update
  both pr_err format specifiers from %zu to %zd and both comparisons
  to cast written: (size_t)written != payload and (size_t)written !=
  size.
- Drop the HTM_MAX_SAFE_TARGETS (1024) cap on num_events that V3
  introduced.  The num_events value is already bounded by the
  auxtrace_info header size validation added in V3, making the
  separate cap redundant; removing it simplifies the code without
  weakening the safety guarantee.

Changes in V3:
- Add #include <linux/unaligned.h> (placed after the perf "..."
headers so <linux/compiler.h> is already in scope) and use
get_unaligned_be64(byte_ptr + 0x10) instead of be64_to_cpu(*(__be64 *)(byte_ptr + 0x10))
to avoid SIGBUS on strict-alignment architectures.
- Add raw_size underflow guard: skip silently if sample->raw_size <=
sizeof(uint32_t) before subtracting the 4-byte alignment padding.
- Reject duplicate PERF_RECORD_AUXTRACE_INFO:
check session->auxtrace != NULL before allocation to prevent
overwriting the pointer and leaking the first allocation.
- Validate num_events against the actual auxtrace_info->header.size
before using it to index priv[] or allocate arrays, preventing
out-of-bounds reads from a malformed record.
- Cap num_events at HTM_MAX_SAFE_TARGETS (1024) to prevent size_t
truncation on 32-bit platforms when passed to calloc().
- Fix htm_target_seen(): return true (use O_APPEND) when capacity is
exceeded, matching the warning message that already claimed append
behaviour. V2 returned false (would have used O_TRUNC), discarding
previously written data.
- Cast calloc() arguments to (size_t)num_events now that num_events
has been validated and capped.

Changes in V2:
- Consolidated: the file-writing, memory-configuration processing, and
  address-mapping logic that was spread across old patches 5 to 9 is
  rationalised into a single, focused implementation in
  tools/perf/util/powerpc-htm.c.
- Synthetic sample generation (old patch 8: PERF_TYPE_SYNTH "htm" event
  with logical addresses) and the separate logical-address mapping output
  file (old patch 9: .out.l file) are not included in V2.  These features
  require further discussion on the appropriate abstraction and will be
  posted as a follow-on series.
- Physical-to-logical address mapping (old patch 7) is not included in
  V2 for the same reason.
- Memory configuration records are now written via process_event()
  handling PERF_RECORD_SAMPLE with PERF_SAMPLE_RAW, keyed on the "htm"
  PMU name from evsel__pmu_name().  V1 used PERF_SAMPLE_RAW boundary
  markers inside the AUX buffer to locate the configuration data.
- AUX buffer processing uses htm_config_for_cpu() to map
  event->auxtrace.cpu to the correct (node, chip, core) target using
  the (cpu, attr.config) table populated from AUXTRACE_INFO priv[] in
  powerpc_htm_process_auxtrace_info().  V1 iterated the evlist at
  report time.
- Per-run first-write tracking (htm_target_seen()) uses O_TRUNC on the
  first write and O_APPEND on subsequent writes for both htm.bin.* and
  translation.* files, correctly handling multiple AUX chunks per target
  and stale files from prior runs.  V1 always opened with O_TRUNC.
- HTM_MAX_TARGETS compile-time constant is replaced by dynamic allocation
  sized to num_events read from AUXTRACE_INFO priv[POWERPC_HTM_NUM_EVENTS].
- Patch is now 6/6 instead of spanning patches 5 to 9.

 tools/perf/util/powerpc-htm.c | 340 +++++++++++++++++++++++++++++++++-
 1 file changed, 334 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 0ef7ecd18c6f..268cba1e81c9 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -14,9 +14,14 @@
 #include "auxtrace.h"
 #include "color.h"
 #include "powerpc-htm.h"
+#include <errno.h>
 #include "debug.h"
 #include "sample.h"
 
+#include <linux/unaligned.h>
+
+struct perf_session;
+
 struct powerpc_htm {
 	struct auxtrace		auxtrace;
 	struct auxtrace_queues	queues;
@@ -24,8 +29,56 @@ struct powerpc_htm {
 	u32			auxtrace_type;
 	struct perf_session	*session;
 	struct machine		*machine;
+
+	/*
+	 * Capacity: number of distinct HTM targets (node/chip/core tuples)
+	 * recorded, read from auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] at
+	 * init time.  All three arrays below are allocated to this size.
+	 */
+	int	nr_targets;
+
+	/*
+	 * Per-run first-write tracking for htm.bin.* and translation.* files.
+	 * Each entry is a packed u32: node<<16 | chip<<8 | core.
+	 * First write for a given key -> O_TRUNC; subsequent writes -> O_APPEND.
+	 */
+	u32	*htm_bin_targets;
+	int	nr_htm_bin_targets;
+	u32	*translation_targets;
+	int	nr_translation_targets;
+
+	/*
+	 * CPU -> attr.config table, populated from auxtrace_info->priv[] at
+	 * init time.  htm_info_fill() (record side) stores the CPU and config
+	 * for each htm evsel; we read them back here to map each
+	 * event->auxtrace.cpu to the correct (node, chip, core) config.
+	 */
+	struct {
+		int	cpu;
+		u64	config;
+	} *cpu_configs;
+	int	nr_cpu_configs;
 };
 
+/*
+ * Look up attr.config by the CPU number carried in event->auxtrace.cpu.
+ * Returns true and sets *config if found, false if not found.
+ * Using a bool+output-param avoids the ambiguity of returning 0 as both
+ * a sentinel (not found) and a theoretically valid config value.
+ */
+static bool htm_config_for_cpu(struct powerpc_htm *htm, int cpu, u64 *config)
+{
+	int i;
+
+	for (i = 0; i < htm->nr_cpu_configs; i++) {
+		if (htm->cpu_configs[i].cpu == cpu) {
+			*config = htm->cpu_configs[i].config;
+			return true;
+		}
+	}
+	return false;
+}
+
 static void powerpc_htm_dump_event(u64 len)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -36,22 +89,236 @@ static void powerpc_htm_dump_event(u64 len)
 	}
 }
 
-static int powerpc_htm_process_event(struct perf_session *session __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
+#define HTM_MEM_ENTRY_SIZE 32
+
+static inline u32 htm_pack_target(u32 node, u32 chip, u32 core)
+{
+	return (node << 16) | (chip << 8) | core;
+}
+
+static bool htm_target_seen(u32 *targets, int *nr, int capacity, u32 key)
+{
+	int i;
+
+	for (i = 0; i < *nr; i++) {
+		if (targets[i] == key)
+			return true;
+	}
+
+	if (*nr < capacity)
+		targets[(*nr)++] = key;
+	else {
+		pr_warning("htm: too many targets (max %d), appending to existing file\n",
+			   capacity);
+		return true;  /* treat as seen: use O_APPEND not O_TRUNC */
+	}
+
+	return false;
+}
+
+/*
+ * Write HTM data to a file.
+ *
+ * mem_maps == 0: AUX bus-trace path  -> htm.bin.nX.pX.cX
+ * mem_maps != 0: memory config path  -> translation.nX.pX.cX
+ *
+ * htm_target_seen() decides O_TRUNC (first write this run) vs O_APPEND
+ * (subsequent writes), keyed on what this process has already written --
+ * not on whether the file exists on disk.
+ */
+static int write_htm(struct powerpc_htm *htm, void *data, size_t size,
+		     u32 node, u32 chip, u32 core, int mem_maps)
+{
+	u32 target_key = htm_pack_target(node, chip, core);
+	char target_file[128];
+	ssize_t written;
+	int flags;
+	int fd;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	flags = O_CREAT | O_WRONLY | O_NOFOLLOW | O_CLOEXEC;
+
+	if (mem_maps) {
+		uint8_t *byte_ptr = (uint8_t *)data;
+		size_t entries;
+		size_t payload;
+
+		if (size < HTM_MEM_ENTRY_SIZE) {
+			pr_err("Malformed memory mapping entry trace segment\n");
+			return -EINVAL;
+		}
+
+		/* Entry count is at offset 0x10; add 1 for the 32-byte header */
+		entries = get_unaligned_be64(byte_ptr + 0x10) + 1;
+		payload = entries * HTM_MEM_ENTRY_SIZE;
+
+		if (payload != size) {
+			pr_err("Bad memory mapping data, invalid number of entries\n");
+			return -EINVAL;
+		}
+
+		snprintf(target_file, sizeof(target_file),
+			 "translation.n%d.p%d.c%d", node, chip, core);
+		flags |= htm_target_seen(htm->translation_targets,
+					 &htm->nr_translation_targets,
+					 htm->nr_targets,
+					 target_key) ? O_APPEND : O_TRUNC;
+		fd = open(target_file, flags, 0644);
+		if (fd == -1) {
+			pr_err("Failed to open %s: %s\n", target_file, strerror(errno));
+			return -errno;
+		}
+
+		written = write(fd, data, payload);
+		close(fd);
+
+		if ((size_t)written != payload) {
+			pr_err("Failed to write memory config: expected %zu bytes, wrote %zd\n",
+			       payload, written);
+			return -EIO;
+		}
+
+		return 0;
+	}
+
+	/* AUX bus-trace path */
+	snprintf(target_file, sizeof(target_file),
+		 "htm.bin.n%d.p%d.c%d", node, chip, core);
+	flags |= htm_target_seen(htm->htm_bin_targets,
+				 &htm->nr_htm_bin_targets,
+				 htm->nr_targets,
+				 target_key) ? O_APPEND : O_TRUNC;
+	fd = open(target_file, flags, 0644);
+	if (fd == -1) {
+		pr_err("Failed to open %s: %s\n", target_file, strerror(errno));
+		return -errno;
+	}
+
+	written = write(fd, data, size);
+	close(fd);
+
+	if ((size_t)written != size) {
+		pr_err("Failed to write htm trace data: expected %zu bytes, wrote %zd\n",
+		       size, written);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int powerpc_htm_process_event(struct perf_session *session,
+				     union perf_event *event,
+				     struct perf_sample *sample,
 				     const struct perf_tool *tool __maybe_unused)
 {
+	struct powerpc_htm *htm;
+	struct evsel *evsel;
+	u32 node, chip, core;
+	u64 ev_config;
+
+	if (!session || !session->auxtrace || !event || !sample)
+		return 0;
+
+	if (event->header.type != PERF_RECORD_SAMPLE || !sample->raw_data)
+		return 0;
+
+	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
+	evsel = evlist__event2evsel(session->evlist, event);
+
+	if (!evsel || strcmp(evsel__pmu_name(evsel), "htm") != 0)
+		return 0;
+
+	ev_config = evsel->core.attr.config;
+	node = (ev_config >> 4)  & 0xff;
+	chip = (ev_config >> 12) & 0xff;
+	core = (ev_config >> 20) & 0xff;
+
+	/*
+	 * raw_size includes 4 bytes of u64 alignment padding added by the
+	 * kernel.  Subtract sizeof(u32) to recover the true payload byte count.
+	 * Guard against underflow: if raw_size is too small, skip silently.
+	 */
+	if (sample->raw_size <= sizeof(uint32_t))
+		return 0;
+	if (write_htm(htm, sample->raw_data,
+		      sample->raw_size - sizeof(uint32_t),
+		      node, chip, core, 1) < 0) {
+		pr_err("Failed to write memory translation block\n");
+		return -EIO;
+	}
+
 	return 0;
 }
 
-static int powerpc_htm_process_auxtrace_event(struct perf_session *session __maybe_unused,
+static int powerpc_htm_process_auxtrace_event(struct perf_session *session,
 					      union perf_event *event,
 					      const struct perf_tool *tool __maybe_unused)
 {
+	struct powerpc_htm *htm;
+	struct auxtrace_buffer *buffer;
+	off_t data_offset;
+	u32 node, chip, core;
+	u64 ev_config;
+	int fd;
+	int err;
+
+	if (!session || !session->auxtrace)
+		return 0;
+
+	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
+	fd = perf_data__fd(session->data);
+
+	if (perf_data__is_pipe(session->data)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1)
+			return -errno;
+	}
+
+	/*
+	 * Queue the buffer and get back a pointer to it.  We immediately load
+	 * and write the data so htm.bin.* exists on disk before subsequent
+	 * patches invoke htmdecode during the same session pass.
+	 */
+	err = auxtrace_queues__add_event(&htm->queues, session, event,
+					 data_offset, &buffer);
+	if (err)
+		return err;
+
+	if (!buffer)
+		return 0;
+
+	/*
+	 * Map event->auxtrace.cpu -> attr.config using the table built from
+	 * auxtrace_info->priv[] at init time.  This is reliable because
+	 * htm_info_fill() stored the exact (cpu, config) pair for each evsel
+	 * at record time -- no CPU map or evlist iteration needed here.
+	 */
+	if (!htm_config_for_cpu(htm, (int)event->auxtrace.cpu, &ev_config)) {
+		pr_err("htm: no config found for auxtrace cpu %u\n",
+		       event->auxtrace.cpu);
+		return 0;
+	}
+
+	node = (ev_config >> 4)  & 0xff;
+	chip = (ev_config >> 12) & 0xff;
+	core = (ev_config >> 20) & 0xff;
+
+	if (!auxtrace_buffer__get_data(buffer, fd)) {
+		pr_err("Failed to read AUX buffer data\n");
+		return -ENOMEM;
+	}
+
 	if (dump_trace)
-		powerpc_htm_dump_event(event->auxtrace.size);
+		powerpc_htm_dump_event(buffer->size);
 
-	return 0;
+	err = write_htm(htm, buffer->data, buffer->size, node, chip, core, 0);
+	auxtrace_buffer__put_data(buffer);
+
+	return err < 0 ? err : 0;
 }
 
 static int powerpc_htm_flush(struct perf_session *session __maybe_unused,
@@ -81,6 +348,9 @@ static void powerpc_htm_free(struct perf_session *session)
 	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
 	powerpc_htm_free_events(session);
 	session->auxtrace = NULL;
+	free(htm->cpu_configs);
+	free(htm->htm_bin_targets);
+	free(htm->translation_targets);
 	free(htm);
 }
 
@@ -89,6 +359,8 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct powerpc_htm *htm;
+	u64 num_events;
+	u64 i;
 	int err;
 
 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
@@ -99,12 +371,68 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 	if (!htm)
 		return -ENOMEM;
 
+	/* Reject duplicate AUXTRACE_INFO: would overwrite session->auxtrace and leak */
+	if (session->auxtrace) {
+		pr_err("htm: duplicate PERF_RECORD_AUXTRACE_INFO, ignoring\n");
+		free(htm);
+		return -EINVAL;
+	}
+
+	htm->auxtrace_type = auxtrace_info->priv[POWERPC_HTM_PMU_TYPE];
+	num_events = auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS];
+
+	/*
+	 * Validate num_events against the actual header size before using it
+	 * to index priv[] or allocate arrays.  Each event contributes 2 u64
+	 * priv entries (cpu + config); reject if the header is too small.
+	 */
+	if (num_events > (auxtrace_info->header.size -
+			  sizeof(struct perf_record_auxtrace_info) -
+			  HTM_AUXTRACE_PRIV_FIXED) / (2 * sizeof(u64))) {
+		pr_err("htm: num_events %llu exceeds auxtrace_info payload\n",
+		       (unsigned long long)num_events);
+		free(htm);
+		return -EINVAL;
+	}
+
 	err = auxtrace_queues__init(&htm->queues);
 	if (err) {
 		free(htm);
 		return err;
 	}
 
+	/*
+	 * All three arrays are sized to num_events -- the exact count of HTM
+	 * targets written by htm_info_fill() at record time.  num_events has
+	 * been validated above so the cast to int and size_t are safe.
+	 */
+	htm->nr_targets   = (int)num_events;
+	htm->cpu_configs  = calloc((size_t)num_events, sizeof(*htm->cpu_configs));
+	htm->htm_bin_targets    = calloc((size_t)num_events, sizeof(*htm->htm_bin_targets));
+	htm->translation_targets = calloc((size_t)num_events, sizeof(*htm->translation_targets));
+	if (!htm->cpu_configs || !htm->htm_bin_targets || !htm->translation_targets) {
+		free(htm->cpu_configs);
+		free(htm->htm_bin_targets);
+		free(htm->translation_targets);
+		auxtrace_queues__free(&htm->queues);
+		free(htm);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Read (cpu, config) pairs from priv[].  These were written by
+	 * htm_info_fill() at record time -- one pair per htm evsel in evlist
+	 * order.  Keying by CPU lets process_auxtrace_event() look up the
+	 * correct attr.config for each AUX buffer using event->auxtrace.cpu.
+	 */
+	for (i = 0; i < num_events; i++) {
+		htm->cpu_configs[i].cpu =
+			(int)auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + i * 2];
+		htm->cpu_configs[i].config =
+			auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + i * 2 + 1];
+		htm->nr_cpu_configs++;
+	}
+
 	htm->session = session;
 	htm->machine = &session->machines.host;
 	htm->auxtrace.process_event = powerpc_htm_process_event;
-- 
2.43.0


