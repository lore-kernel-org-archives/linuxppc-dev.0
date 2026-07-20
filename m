Return-Path: <linuxppc-dev+bounces-24480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84753C4452B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:04:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3d1t0xBnz304x;
	Mon, 20 Jul 2026 21:04:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784545458;
	cv=none; b=lCpdosMSeVcBt1oVKmB8Gypikc2T3MZSSmyfHJOsVsQI5Xm894rL0y2OBMtzHPTLc22DvyRsFJKgnMXM97FEYZtBz85wwxWYa04+xAcfH5ze89iNVKxOLyNvlyvqryl2qdNRuSoSpa/pESSouTRPdXLMulhDrKtzZLno3XLzEzDYxTgYj74Au5XuGimXOEui0Cj3y6Ylgv5j9yzzij5f2eFJVIMHYzb2GDC2enzQZhfCT5m1OQrDTQX+V4PM/jjHV7PtUicp3Kc34r5v5MbVwvmR1hj5/erAdWh5/0/SI9iFtolUbBwj7lrPXUVsy/4fPJDPskTNMG2gIjL3/iefGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784545458; c=relaxed/relaxed;
	bh=/jvuSEglPRWl41mWdOu60pRUhexpGZylulP57jAOcdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8ko+6o4yLyK/yErETjY0tp6WXL1kTzAsOe2OkJza/qBEUPFflHGILZBqmBtxQIzNwrHpkHMdMfvN24OpinHP08FimXjP3szUnctdyBZ2MoQPmu4I8CQVJegiiHQAKGbrelpzUXieLVm9aOn4Y4NShtZWQGLQb34uo4foDzqxkPHBadlVhwFKya/JnHKhTWfiF/N34xgICyU4B/TTUnwuioNPiHX6644cg+vaHQtGjrzQArI50um/kIaAjHBRFj1fG8Vsq5l8dFmJI2kPcQtJskWzRneSRqBLyJEqQ77WuTqHQc2zUGXGfGJ6xec15pY5AOnr47knlIziLRJ7FlXTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ejoofnyk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ejoofnyk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3d1s0SD3z2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 21:04:16 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABgiH1905501;
	Mon, 20 Jul 2026 11:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/jvuSEglPRWl41mWd
	Ou60pRUhexpGZylulP57jAOcdk=; b=ejoofnykL7Kzxny7ciJi+krRyGFLVaUWg
	vySpvwQRG1RMTj/xSz28v8+j2XkGpeTtD5NY7SXGXMiCILLKZrik1Ezhgp9ZeRkZ
	L3JIlSYz718HNuRTkv1oGA5qMYEVesoDkJIx6gwQ4a5U3NjYjWX0gC6Sq8382/h2
	E0DFDj400LU3OeMJAZJWIp+1EaK1xg+atIAp98ll5lW5Jdg6L5uhwwWvCHeZu2kL
	2JX7sANUv2ngCk8x+CFe1dipO6F7ugWLPclCMu/nsOvORHtx0EebM/lh5GqWkTKd
	Os5F+/rTfb4JGfHBJGnjfIhnIBuA9JL3PvGeOdcmWJh8AylPd3Fag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab73d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAnmQC009652;
	Mon, 20 Jul 2026 11:04:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpwef4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB483n51118504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BCD22004E;
	Mon, 20 Jul 2026 11:04:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC26820040;
	Mon, 20 Jul 2026 11:04:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:04:04 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 2/6] tools/perf: Add AUXTRACE recording support for powerpc HTM
Date: Mon, 20 Jul 2026 16:22:14 +0530
Message-Id: <20260720105218.14277-3-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX1UjwhHmTMjTU
 aU+u2TbWarmMBU/lJjhuWIJPOPmgbYncduwluyV3EngMXKknZN9bcnDMWl7WILrcjsZ1vm4ity0
 QsmEAeq/vLu65ewHTAT3VtsXdNAbPsSnuCfG9xsMl2pSxT5C/KsIwmLFiTNYVwk2qbPWIA6aSvp
 qTEe+2iVv9Mir4nj4jgpumriEU0KH2dapWFGC5i2DQ4nuEpwalaJcAwSAlPP5wUQGFdL8ZaNK/n
 k4rU8fiYYWI5VRnfjyHHwEXGt++Qik+ZYdE2qzQnVVB2nFzF3Ycn7PzX8H/2AXV4/RgDZo5AGSA
 8Bai6MUJscGC4xHHgKC/F/p/RZCrX8JiLh0q8JKIZal3cWT7YnuMO7UjCMia1Fri8ca82PnAtAh
 5GE1ga+86qLbebjEms1BI6OZAUanoqjlRMFjQS7RBFAVA2Sj++tm9D6zLjVsXmHMrA3m0d/NanX
 gEs+aI7u/h3NOEojNMQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5e00ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=cBn7WvoOLYj_7xldggkA:9
X-Proofpoint-ORIG-GUID: 3zbx_WchD-9EFu9F-m3HCnMxsY3agC-K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX1qQxayvj4NWi
 fk/+LJnBQ9SoDDncZiFoWePZ4V95LBTYq+IJ7k+gNk7QccKPD8yQ2wpqobeX4OfLh9MOgulEBvu
 1W4ZwX+FIZyhE3ywSb05O8KBQSFSUuo=
X-Proofpoint-GUID: FGg4W6g7El_Lmiy7lE1584kYI3_vGVDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

Add powerpc perf tool support for the HTM PMU AUXTRACE recording path.

Introduce htm_recording_init() and the associated auxtrace callbacks so
perf record can create PERF_RECORD_AUXTRACE records for HTM data.

htm_info_fill() stores the PMU type, number of HTM evsels, and a
(cpu, attr.config) pair for each evsel into PERF_RECORD_AUXTRACE_INFO
priv[].  The decode side reads these back to map each AUX buffer
(identified by event->auxtrace.cpu) to the correct (node, chip, core)
target when writing htm.bin.* output files.

Update auxtrace_record__init() to detect HTM events and dispatch to the
HTM-specific recording initializer.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- htm_info_fill() now stores a (cpu, attr.config) pair for every HTM
  evsel into PERF_RECORD_AUXTRACE_INFO priv[].  V1 stored only the PMU
  type and a single config value; there was no per-CPU mapping.
- The priv[] layout is formalised in util/powerpc-htm.h with enum
  constants POWERPC_HTM_PMU_TYPE, POWERPC_HTM_NUM_EVENTS, and
  POWERPC_HTM_EVENT_DATA and the helper macros HTM_AUXTRACE_PRIV_FIXED
  and HTM_AUXTRACE_PRIV_SIZE(n).  V1 used bare numeric offsets.
- PERF_SAMPLE_RAW is enabled in the recording options so that memory
  configuration records emitted by the kernel driver are captured
  alongside the AUX stream.  V1 added this in a later patch.
- PERF_AUXTRACE_POWERPC_HTM type constant is set in htm_info_fill()
  (wired up in patch 5 once the enum is defined).
- Patch is now 2/6 instead of 2/9.

 tools/perf/arch/powerpc/util/Build      |   1 +
 tools/perf/arch/powerpc/util/auxtrace.c |   9 ++
 tools/perf/arch/powerpc/util/htm.c      | 169 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  43 ++++++
 4 files changed, 222 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 7819c8f5af2d..297152591046 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -8,3 +8,4 @@ perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-y += auxtrace.o
 perf-util-y += vpa-dtl.o
+perf-util-y += htm.o
diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index e04a0bd61755..fd9215e8d3f2 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -12,6 +12,7 @@
 #include "../../util/debug.h"
 #include "../../util/auxtrace.h"
 #include "../../util/powerpc-vpadtl.h"
+#include "../../util/powerpc-htm.h"
 #include "../../util/record.h"
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
@@ -19,6 +20,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 {
 	struct evsel *pos;
 	struct evsel *vpa_dtl_evsel = NULL;
+	struct evsel *htm_evsel = NULL;
 
 	/*
 	 * Set err value to zero here. Any fail later
@@ -32,11 +34,18 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 			/* Remember the first matching VPA DTL event */
 			if (!vpa_dtl_evsel)
 				vpa_dtl_evsel = pos;
+		} else if (pos->name && strstarts(pos->name, "htm")) {
+			pos->needs_auxtrace_mmap = true;
+			/* Remember the first matching HTM event */
+			if (!htm_evsel)
+				htm_evsel = pos;
 		}
 	}
 
 	if (vpa_dtl_evsel)
 		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
+	else if (htm_evsel)
+		return htm_recording_init(htm_evsel, err);
 
 	return NULL;
 }
diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc/util/htm.c
new file mode 100644
index 000000000000..07b496e4be2f
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/htm.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HTM AUX tracing support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <stdlib.h>
+#include <limits.h>
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/debug.h"
+#include "../../util/auxtrace.h"
+#include "../../util/powerpc-htm.h"
+#include "../../util/record.h"
+#include <internal/lib.h> /* page_size */
+#include <errno.h>
+
+#define KiB(x) ((x) * 1024)
+
+struct htm_recording {
+	struct auxtrace_record	itr;
+	struct evsel		*evsel;
+};
+
+static int
+htm_recording_options(struct auxtrace_record *itr __maybe_unused,
+		      struct evlist *evlist,
+		      struct record_opts *opts)
+{
+	struct evsel *pos;
+
+	opts->full_auxtrace = true;
+
+	if (!opts->auxtrace_mmap_pages) {
+		opts->auxtrace_mmap_pages = KiB(128) / page_size;
+		if (opts->mmap_pages == UINT_MAX)
+			opts->mmap_pages = KiB(256) / page_size;
+	}
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!pos->name || !strstarts(pos->name, "htm"))
+			continue;
+		pos->core.attr.aux_watermark =
+			opts->auxtrace_mmap_pages * (size_t)page_size;
+		pos->core.attr.freq = 0;
+		pos->core.attr.sample_type |= PERF_SAMPLE_RAW;
+		pos->needs_auxtrace_mmap = true;
+	}
+
+	return 0;
+}
+
+/* Count htm evsels in the evlist */
+static int htm_nr_events(struct evlist *evlist)
+{
+	struct evsel *pos;
+	int n = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (pos->name && strstarts(pos->name, "htm"))
+			n++;
+	}
+	return n;
+}
+
+static size_t htm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+				 struct evlist *evlist)
+{
+	return HTM_AUXTRACE_PRIV_SIZE(htm_nr_events(evlist));
+}
+
+/*
+ * Fill the PERF_RECORD_AUXTRACE_INFO private data with:
+ *   priv[POWERPC_HTM_PMU_TYPE]   = pmu->type of the first htm evsel
+ *   priv[POWERPC_HTM_NUM_EVENTS] = number of htm evsels
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2]     = CPU for nth htm evsel
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] = attr.config for nth htm evsel
+ *
+ * The CPU is the first CPU in the evsel's cpu map; for events opened with
+ * cpu=N there is exactly one CPU.  The decode side uses event->auxtrace.cpu
+ * to look up the matching config and derive (node, chip, core) for the
+ * output file name.
+ */
+static int
+htm_info_fill(struct auxtrace_record *itr,
+	      struct perf_session *session,
+	      struct perf_record_auxtrace_info *auxtrace_info,
+	      size_t priv_size)
+{
+	struct htm_recording *htm_r = container_of(itr, struct htm_recording, itr);
+	struct evlist *evlist = session->evlist;
+	struct evsel *pos;
+	int n = 0;
+	int expected_n = htm_nr_events(evlist);
+
+	if (priv_size != HTM_AUXTRACE_PRIV_SIZE(expected_n))
+		return -EINVAL;
+
+	// To set: auxtrace_info->type
+	auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] = htm_r->evsel->core.attr.type;
+	auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] = expected_n;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct perf_cpu_map *cpus;
+		int cpu;
+
+		if (!pos->name || !strstarts(pos->name, "htm"))
+			continue;
+
+		/*
+		 * Get the CPU this evsel is pinned to.  For events opened
+		 * with cpu=N, evsel__cpus() returns a single-entry map {N}
+		 * at record time (not during replay).
+		 */
+		cpus = evsel__cpus(pos);
+		if (cpus && perf_cpu_map__nr(cpus) > 0)
+			cpu = perf_cpu_map__cpu(cpus, 0).cpu;
+		else
+			cpu = -1;
+
+		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     = cpu;
+		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =
+							pos->core.attr.config;
+		n++;
+	}
+
+	return 0;
+}
+
+static u64 htm_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return 0;
+}
+
+static void htm_free(struct auxtrace_record *itr)
+{
+	struct htm_recording *htm_r = container_of(itr, struct htm_recording, itr);
+
+	free(htm_r);
+}
+
+struct auxtrace_record *htm_recording_init(struct evsel *pos, int *err)
+{
+	struct htm_recording *htm_r;
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(pos->evlist, pos);
+
+	htm_r = zalloc(sizeof(*htm_r));
+	if (!htm_r) {
+		pr_debug("htm_recording allocation failed (-ENOMEM)\n");
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	htm_r->evsel = pos;
+	htm_r->itr.recording_options = htm_recording_options;
+	htm_r->itr.info_priv_size    = htm_info_priv_size;
+	htm_r->itr.info_fill         = htm_info_fill;
+	htm_r->itr.free              = htm_free;
+	htm_r->itr.reference         = htm_reference;
+	return &htm_r->itr;
+}
diff --git a/tools/perf/util/powerpc-htm.h b/tools/perf/util/powerpc-htm.h
new file mode 100644
index 000000000000..18e39417d556
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __POWERPC_HTM_H
+#define __POWERPC_HTM_H
+
+#include <linux/types.h>
+
+/*
+ * Layout of the private data in PERF_RECORD_AUXTRACE_INFO for HTM.
+ *
+ * priv[POWERPC_HTM_PMU_TYPE]   = htm PMU type ID (pmu->type from kernel)
+ * priv[POWERPC_HTM_NUM_EVENTS] = number of htm evsels recorded (N)
+ *
+ * Followed by N pairs (2 u64 each):
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 0] = CPU number for nth htm evsel
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] = attr.config for nth htm evsel
+ *
+ * Total priv entries: POWERPC_HTM_EVENT_DATA + N * 2
+ */
+enum {
+	POWERPC_HTM_PMU_TYPE  = 0,
+	POWERPC_HTM_NUM_EVENTS,
+	POWERPC_HTM_EVENT_DATA,	/* variable-length: 2 u64 per event */
+};
+
+/* Fixed header size (everything before the per-event data) */
+#define HTM_AUXTRACE_PRIV_FIXED  (POWERPC_HTM_EVENT_DATA * sizeof(u64))
+
+/* Total priv size for N htm evsels */
+#define HTM_AUXTRACE_PRIV_SIZE(n) \
+	(HTM_AUXTRACE_PRIV_FIXED + (n) * 2 * sizeof(u64))
+
+struct evsel;
+struct evlist;
+union perf_event;
+struct perf_session;
+struct auxtrace_record;
+
+struct auxtrace_record *htm_recording_init(struct evsel *pos, int *err);
+
+int powerpc_htm_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session);
+
+#endif /* __POWERPC_HTM_H */
-- 
2.43.0


