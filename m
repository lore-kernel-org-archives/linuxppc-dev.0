Return-Path: <linuxppc-dev+bounces-25601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBA7C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGn1947jKz3cY7;
	Sat, 08 Aug 2026 00:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113741;
	cv=none; b=CQbwUqZykgz5dKsbr9fAoKuJlm6D9+NiMlS1zIay4GPcYBy5TGK1zKreGwr7QSmDeMCHsiH1Lvoufu4hQFSha1zTTFMskURI09NLSPzGeOQZEbY/sjSMfrWrL+/cv3x/ilaWC5nzpCljUOvPOAuBhhMdBUImapvnYMr+LlmviwvPOt0lO9cuD67SIRlUkdXxsJI+d6bJab1wsJs89pbxlKgtuG+6bXkaTBP6hi3RImcMrniYqW0TMYd110EbTfscs4L4HI4doYuQO2wLjZwlDtNGwOlvAYHSJadFWvbZBORnaoyxUBADXxdVN7H7OTkTY6nF14HDglx+SzeYEIaAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113741; c=relaxed/relaxed;
	bh=DhjSPH9SYK3m4tVDD5q+4hbVEH1dZ2sT1bMSPmeaWK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSQjjsyXYAua1JEwyoPcCiYmrv8bxL6IG8Ocahhg+RvGWUPXSlRQbzMz7s5lQv8oJSUj7W6fpZnANyoq5D7BKHgmyD9f/ghQiKuli5rm5BRnb5rHACKERYq8J9y9EkkK5FHaFPx9g4Vd2D2U+sX8jNmUPXgJnjA+hzo5etJ+PBiwLQnW+Ij9ZAnRD0ZEPv1CxfMi9Ypivt3ovm19I+4Kse5HkHugzb1pkhTop3KkaCjTPd8kBVeAf0o4BOedGnE1ekG/BWerMePKhUh7uezDdBIqZd5HDYQo0/KxbS+m8v93T1DTK3rR/b26O6ErhgbFCr++C9BhFepx3HGVBmG8EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lqIYbn4i; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lqIYbn4i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGn1566m1z3c5q
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:42:17 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClsL01412170;
	Fri, 7 Aug 2026 14:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DhjSPH9SYK3m4tVDD
	5q+4hbVEH1dZ2sT1bMSPmeaWK0=; b=lqIYbn4iKRRMSS8NHE+bMf0UVQFYlgWXX
	hk6zTyxDL6f/APyEegOnyn/u8iVg30IhIFGWepkYVBecqORIbTnT2CD5XbnZnlqv
	7IRX/LhzeDqyNEidQKLnbdfic3VmDZgyQGYNa6W3wVP0aW4uxAXUjMxmB3IQ0APj
	n/1/+bm1JAJWPnuJSa1puNloZs+KyhkntUFQTt+cLR3ww63HVSd9D9WRX8j+TsHs
	axjj7YylAeKdZSDFFIpCN7QdBWDd7UJ7aLOyunCXKcytM2EGAy66TeJgTfFhzA8C
	XrYCDqYG/BgizpqJtMSQrzBzTi0861tpcVF1/Y0p/hQsR2V6/WxTw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02c807-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfHQW001803;
	Fri, 7 Aug 2026 14:42:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwg5sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Eg6EK27787734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:42:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40282004D;
	Fri,  7 Aug 2026 14:42:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84FFB20040;
	Fri,  7 Aug 2026 14:42:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:42:03 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V5 6/6] tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE records
Date: Fri,  7 Aug 2026 20:11:35 +0530
Message-Id: <20260807144135.2607-7-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75eec4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=TuMjLJInko8KB4HEWCUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX51suysTuEkMl
 aRl+wTOMB84pn6XV4/jbBcnYyMDEszFVxX9TG4pMjj8S+2PxeZNSZ8TUdacMUjC8eoexw0R+Mqd
 hd/66o0de/tLgui0YyGfC2LdHmj1SFfj+XwwO1KdC2lgt8im6cYjJf98dshOHU+bJ/rwT25iyOc
 HFpF5gOI60sqTRehgJijhZzlQNgbItzWNBmMNO8k9vjHQX3QcX7TzyyOMfHfszJT4DG35TZGpao
 xC0TKR89yunhoR9AFi3YNembRiu9pVpuhn80UXObqk2Da2u+LxZ+aD3a3OK1cEfFm9yDuTGT31b
 RcN1t1JrlH+xu8rrc2TSFv1nO4FMxneSWcSThBHddyRCrINejCgMLykMn92UtvAH+4iysbrHZid
 dw6psP6BTTjWFaXLaRXaNEyl98AdmeKMRNWU1iVGl2F8q9vNoBrtPswts8dtuwsPFJ49Xhelm4v
 FBVo1YJl7vwYD+9/OtQ==
X-Proofpoint-ORIG-GUID: kMDMqPR2_o8CHYnUZZjQ3rf8HZmE-HoW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX3gSAG7wilrvu
 oUX7kHBaaBG/TzMHWfHZFH2Z0EJgqgffe5RNp7pqW9pWyXNpcZHfb0LMbARqh0EqPAjMggKXbxT
 1Yw6jZxOc9d91mM7g/73L/qxYNyiweA=
X-Proofpoint-GUID: cNmYE6ePXaMJsMoJ3ZyCvHfAJCQ--8bR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

powerpc_htm_process_auxtrace_info() reads the (cpu, attr.config) pairs
stored by htm_info_fill() at record time and builds a cpu_configs[]
table.  This lets process_auxtrace_event() map each AUX buffer, which
carries event->auxtrace.cpu, to the correct (node, chip, core) target
and write the raw trace data to htm.bin.nX.pX.cX.tX immediately.

PERF_RECORD_SAMPLE events carrying PERF_SAMPLE_RAW data are handled by
process_event(), which extracts memory configuration records and writes
them to translation.nX.pX.cX.tX

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
  htm.bin.n0.p2.c0.t1  translation.n0.p2.c0.t1

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- Include htm_type in the output filename and the first-write tracking
  key.  Previously htm_pack_target() encoded only (node, chip, core),
  so a core HTM event (htm_type=2) and a nest HTM event (htm_type=1)
  on the same node/chip/core produced the same key and collided into
  the same htm.bin.nX.pX.cX file.  The fix encodes type in bits [31:24]
  of a u64 key: key = (type<<24) | (node<<16) | (chip<<8) | core.
  Output filenames now include a .tX suffix:
    htm.bin.nX.pX.cX.tX  and  translation.nX.pX.cX.tX
  Both htm_bin_targets and translation_targets arrays are widened from
  u32 to u64, and htm_target_seen() is updated accordingly.  The type
  field is extracted from attr.config bits [3:0] at both call sites
  (powerpc_htm_process_event and powerpc_htm_process_auxtrace_event)
  and passed through write_htm().

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

 tools/perf/util/powerpc-htm.c | 341 +++++++++++++++++++++++++++++++++-
 1 file changed, 335 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 0ef7ecd18c6f..1b5c8d7adf05 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -17,6 +17,10 @@
 #include "debug.h"
 #include "sample.h"
 
+#include <linux/unaligned.h>
+
+struct perf_session;
+
 struct powerpc_htm {
 	struct auxtrace		auxtrace;
 	struct auxtrace_queues	queues;
@@ -24,8 +28,56 @@ struct powerpc_htm {
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
+	 * Each entry is a packed u64: type<<24 | node<<16 | chip<<8 | core.
+	 * First write for a given key -> O_TRUNC; subsequent writes -> O_APPEND.
+	 */
+	u64	*htm_bin_targets;
+	int	nr_htm_bin_targets;
+	u64	*translation_targets;
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
@@ -36,22 +88,238 @@ static void powerpc_htm_dump_event(u64 len)
 	}
 }
 
-static int powerpc_htm_process_event(struct perf_session *session __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
+#define HTM_MEM_ENTRY_SIZE 32
+
+static inline u64 htm_pack_target(u32 node, u32 chip, u32 core, u32 type)
+{
+	return ((u64)type << 24) | (node << 16) | (chip << 8) | core;
+}
+
+static bool htm_target_seen(u64 *targets, int *nr, int capacity, u64 key)
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
+		     u32 node, u32 chip, u32 core, u32 type, int mem_maps)
+{
+	u64 target_key = htm_pack_target(node, chip, core, type);
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
+			 "translation.n%d.p%d.c%d.t%d", node, chip, core, type);
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
+		 "htm.bin.n%d.p%d.c%d.t%d", node, chip, core, type);
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
+	u32 node, chip, core, type;
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
+	type = ev_config & 0xf;
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
+		      node, chip, core, type, 1) < 0) {
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
+	u32 node, chip, core, type;
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
+	type = ev_config & 0xf;
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
+	err = write_htm(htm, buffer->data, buffer->size, node, chip, core, type, 0);
+	auxtrace_buffer__put_data(buffer);
+
+	return err < 0 ? err : 0;
 }
 
 static int powerpc_htm_flush(struct perf_session *session __maybe_unused,
@@ -81,6 +349,9 @@ static void powerpc_htm_free(struct perf_session *session)
 	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
 	powerpc_htm_free_events(session);
 	session->auxtrace = NULL;
+	free(htm->cpu_configs);
+	free(htm->htm_bin_targets);
+	free(htm->translation_targets);
 	free(htm);
 }
 
@@ -89,6 +360,8 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct powerpc_htm *htm;
+	u64 num_events;
+	u64 i;
 	int err;
 
 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
@@ -99,12 +372,68 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
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
2.53.0


