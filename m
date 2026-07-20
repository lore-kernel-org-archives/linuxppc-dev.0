Return-Path: <linuxppc-dev+bounces-24484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF27C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:04:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3d290v7Tz2yfD;
	Mon, 20 Jul 2026 21:04:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784545473;
	cv=none; b=XZDMQDn1LSz2kRCud/dGfna17IPyFiWP4yW/fcn1BMPRfgC46XcdYdVCjFY95iGi+JeNpdCFkD5kkTzhqSrvXug2y4bCPUXqoNH5PXabTOap4o3T99sAHK7BsplIPMpkqDxeU3iBH8+x5XL4LW57t0P51+ISIjdAhHstqL9jR5zxrqhxQbs/lnZGVaAuwp8wuOn8obNG/vo1uj3sMepyOq11tmp5Vo+uuSMfO5zJ4xZmhunwX/WP27/hC334a+b/+IqgQ3ZL6IO9a5TD06f7EQz+D7w1BBWH9OxlUlP9SbEFxOvGaXJ0bMfrGoj3o7jw9i6hhPXufjAQ2tRUI/UT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784545473; c=relaxed/relaxed;
	bh=lZtxfpAcYiqPsISyoTuLwH8X29i+VHxZGe/2hBkUYlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRt03MgdZVaYI4chZw2hgEMOYSIzhaekgAg8W53UYnjPc4Z5Tn/lxPwFkC813L5m1WVY6Quc4yx42PtcVtNeojig4B0GtRDbPO8X8uX5yIjEdfzBF3ktLxbuKOyEndEVjVwJagYjibQbVtOIvPWNzthUXWTt3UKHXWafgx/4TDwQKDcb/UP2tn9N34QXadMzhOCH0NnVJRCvugvNKUf26ju9K8rTuc1Sc6ipOWq5V0lKexpShYHjIYwc19qfaZ3V2XzucRFu7ahvigPbwNNlvf6V2RH7MqZVcXMRqMCct6p7865DRA/5XzckhalyAeppoNq8k+qnhIH3OtsNx91Zyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eZtq82uG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eZtq82uG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3d280S7pz2ybK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 21:04:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABqhh026970;
	Mon, 20 Jul 2026 11:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lZtxfpAcYiqPsISyo
	TuLwH8X29i+VHxZGe/2hBkUYlg=; b=eZtq82uGaVgYQvMnIx0rmjsWxp4PTadTF
	NXeSkM57FT6b9iTkf4nJya96wzZlKaVIC6UpPgf5CR/Eyj+AUa0LE2oxP5w3Tv7I
	PmlTydFW3BAL5U/t3ycnqIPe25eUqIhSYIn9sHwK0JYBKeNu53e+ttjVjA3GVgvE
	d+QQpiroNzuf9Ma+3VT6DkfZccg+/o9B96R8q1zT+7BeKnax/jblvEIZEo53dMTA
	9MxWB0DKWzvJAMCu1ydhL1vA6Lide8q9654I9TGUjK4WbmDGf9BrB1kugZJV61Fr
	+ng0RUZJG7HEk7hioZGFt26jBUqJlh+tK0IUESrwy4dpNdqgxIssQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a7335-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAniRR010451;
	Mon, 20 Jul 2026 11:04:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagw7gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB4Nlg23069294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E32A420043;
	Mon, 20 Jul 2026 11:04:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB8182004E;
	Mon, 20 Jul 2026 11:04:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:04:19 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 6/6] tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE records
Date: Mon, 20 Jul 2026 16:22:18 +0530
Message-Id: <20260720105218.14277-7-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720105218.14277-1-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CF25LzcCOPqCCVqHMx8SPg6XxYX07wBM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXz1OKtNvlP8fM
 7bER24yvHqmRcZ04FWMbF7m2SJEeAjm35hdrR6t77SUNJkyp/pJVW7yRGxHUozgD7HGn7LXRgRt
 4YiwNjBgSbsqAwKbPaZxae+l50igHM4=
X-Proofpoint-GUID: pvHIlNrVNjxZ8viHaglI0tNg5Mx6v2l7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX5nGCtjZLu4RT
 vh7D1q5NGH6bzjjy9Qvv9QOKLzhQMe/0DudUuMvymXkXNrsvI3ktUBjiyT5Z9txdC0AE4UAyUrj
 ORUOX7IrmsSchSCa04VQPvkJtLgIH+FuyIui88Ji3jOSywRaxVGf5ZqdiNGs33J60i6P9DUjaky
 H0oBhxK4hJd5S1aeV1Da6f4BT5FtSkodDPZVSaD/sknru1OkWlcamnfUtLeW28HPgVB7RtWgSDA
 CofYTpBj7oTGqVmadwErKOgeQ/ROhbsv9UxHzBjqpDsc3bATtW6AlKotFa4lHJauv1+4ou2IuSO
 t91OkpCzhboQ3mdTp432yAHjyCaznxeYKH/4nPjTkNWJK3K8zq6HRwTv0Ue50q8l6C+Nn8cHcTb
 zAzfcrGIeI0met9r9ELHEji7hbseZzwtVAFOoWrOVhjc3LC669mqLBloIPd/qKdkEzwwAYbpE1I
 z9+fk2zsLeY341aWioA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e00bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=j1nykWx-6ZKelpTWdAoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200119

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

 tools/perf/util/powerpc-htm.c | 312 +++++++++++++++++++++++++++++++++-
 1 file changed, 306 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 8d28d02031d6..409ab563a0a7 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -11,9 +11,12 @@
 #include "util/session.h"
 #include "color.h"
 #include "powerpc-htm.h"
+#include <errno.h>
 #include "debug.h"
 #include "sample.h"
 
+struct perf_session;
+
 struct powerpc_htm {
 	struct auxtrace		auxtrace;
 	struct auxtrace_queues	queues;
@@ -21,8 +24,52 @@ struct powerpc_htm {
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
+ * Returns 0 if not found.
+ */
+static u64 htm_config_for_cpu(struct powerpc_htm *htm, int cpu)
+{
+	int i;
+
+	for (i = 0; i < htm->nr_cpu_configs; i++) {
+		if (htm->cpu_configs[i].cpu == cpu)
+			return htm->cpu_configs[i].config;
+	}
+	return 0;
+}
+
 static void powerpc_htm_dump_event(size_t len)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -33,22 +80,234 @@ static void powerpc_htm_dump_event(size_t len)
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
+	else
+		pr_warning("htm: too many targets (max %d), appending to existing file\n",
+			   capacity);
+
+	return false;
+}
+
+/*
+ * Write HTM data to a file.
+ *
+ * mem_maps == 0: AUX bus-trace path -> htm.bin.nX.pX.cX
+ * mem_maps != 0: memory config path -> translation.nX.pX.cX
+ *
+ * htm_target_seen() decides O_TRUNC (first write this run) vs O_APPEND
+ * (subsequent writes), keyed on what this process has already written,
+ * not on whether the file exists on disk.
+ */
+static int write_htm(struct powerpc_htm *htm, void *data, size_t size,
+		     u32 node, u32 chip, u32 core, int mem_maps)
+{
+	u32 target_key = htm_pack_target(node, chip, core);
+	char target_file[128];
+	size_t written;
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
+		__be64 *num_entries_ptr;
+		size_t entries;
+		size_t payload;
+
+		if (size < HTM_MEM_ENTRY_SIZE) {
+			pr_err("Malformed memory mapping entry trace segment\n");
+			return -EINVAL;
+		}
+
+		/* Entry count is at offset 0x10; add 1 for the 32-byte header */
+		num_entries_ptr = (__be64 *)(byte_ptr + 0x10);
+		entries = be64_to_cpu(*num_entries_ptr) + 1;
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
+		if (written != payload) {
+			pr_err("Failed to write memory config: expected %zu bytes, wrote %zu\n",
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
+	if (written != size) {
+		pr_err("Failed to write htm trace data: expected %zu bytes, wrote %zu\n",
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
+	 */
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
+	 * at record time, no CPU map or evlist iteration needed here.
+	 */
+	ev_config = htm_config_for_cpu(htm, (int)event->auxtrace.cpu);
+	if (!ev_config) {
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
@@ -78,6 +337,9 @@ static void powerpc_htm_free(struct perf_session *session)
 	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
 	powerpc_htm_free_events(session);
 	session->auxtrace = NULL;
+	free(htm->cpu_configs);
+	free(htm->htm_bin_targets);
+	free(htm->translation_targets);
 	free(htm);
 }
 
@@ -86,6 +348,8 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct powerpc_htm *htm;
+	u64 num_events;
+	u64 i;
 	int err;
 
 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
@@ -102,6 +366,42 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 		return err;
 	}
 
+	htm->auxtrace_type = auxtrace_info->priv[POWERPC_HTM_PMU_TYPE];
+	num_events = auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS];
+
+	/*
+	 * All three arrays are sized to num_events, the exact count of HTM
+	 * targets written by htm_info_fill() at record time.  This replaces the
+	 * old compile-time HTM_MAX_TARGETS constant so the limit is always
+	 * consistent with what was actually recorded.
+	 */
+	htm->nr_targets   = (int)num_events;
+	htm->cpu_configs  = calloc(num_events, sizeof(*htm->cpu_configs));
+	htm->htm_bin_targets    = calloc(num_events, sizeof(*htm->htm_bin_targets));
+	htm->translation_targets = calloc(num_events, sizeof(*htm->translation_targets));
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
+	 * htm_info_fill() at record time, one pair per htm evsel in evlist
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


