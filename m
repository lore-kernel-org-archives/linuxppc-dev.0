Return-Path: <linuxppc-dev+bounces-23289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80861C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:42:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtmK4qpTz2ySD;
	Wed, 01 Jul 2026 18:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895313;
	cv=none; b=iDvovHRO4XxRIxaftnijRNJ3lzvf3eD4kiJTIrxn2yf71rRATwhrXpTO/9wxcC2RQ13GAYQRtUjlwbzyNgGxM/OtruxYh6wnx1h2H3fzsNVnHwTTxnOqlTbGKxULQdxpe8WQBaUIgo6+EkCW+GFRfTNQ9fXcORl4NNbe3IYekYbAEuTS2hu2oHWBy7rTShglEYBsVvWw08HX8K8dLC5lcGScIjS01z5IGt+OvN1D+Wjd3WVNJ/HBN9SiSNXkPC/waDuxTkIYrw/RZHhByoe16RJXEUA8POjn/1vtvEZxrcb1lO0z1blbWc9blLpBWEXKomz9PXiG+02NXVrgE62ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895313; c=relaxed/relaxed;
	bh=qucareyI4D2dzk4oYNWiLc+P0+G5MGWn1pnYI/YL8g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2scpNnLhdAg67sf0hcMbo2j0WIbSEXbV+P5CeP0QYMUBRTnJvpGS0ehhbByUi2TppcuOjtS72WV6OYQhLa/QJcKFinEaLbAqCxF3D4aioPziXxeJ3FIHirxPbzgrHrMmOvrIKqLb/NQ1BEuqidkh1Wkh5Vp30Lsqn5lqCCec4darMHw27KXscKSkWaLnci+/Vz2PnSE30wgviuAK/UukYU9YmTyex76JVC1y5E38LTfPhbOL0V6wMMYcasUIA6Ro4WqsmmdqPcv1fmVnn2IUU7NuAdrd25iojhAPXgnn2OqmPs86BMloz8iQ7R3rT07BGdaln0XpR2jsPkFuB7w+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MAQIYt3y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MAQIYt3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtmJ5N9rz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:52 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618JCL9237010;
	Wed, 1 Jul 2026 08:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qucareyI4D2dzk4oY
	NWiLc+P0+G5MGWn1pnYI/YL8g4=; b=MAQIYt3yn0tO72ss1PiWSrdsSOcTBLVOn
	YdgeNSmByZDGM8feQPQzv1P0OFWey5TgnZ8CMQGrKlIKjCKKTHuW8BHU6sy/kUif
	3VBtKu8cYt77N6Df4yLoo99wfiXnV9kvlWq6JcPn8022q6bO90vvh/BhQsC4JIFz
	+7U8obUovOFwc5fYuul2UQ4Dj2CShLaPzksqBLGuhlWnyGJHgp+rGQ8A4USqBedJ
	kc1Qw30+WkZq2Ya2pbONnq9NShP1OGntqjdVNCwtKBm2ycNYtzX4awGNAucmGhR4
	oiqeZ5bdWVOWRCilbcXNnp86LAp3CQT1eJYobs7m7kKVQ90sXJZLA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa35bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YcSS001241;
	Wed, 1 Jul 2026 08:41:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhecgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fg9Z37749182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 388D220043;
	Wed,  1 Jul 2026 08:41:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51CDF20040;
	Wed,  1 Jul 2026 08:41:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:38 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 5/9] tools/perf: process htm auxtrace events and display in perf report -D
Date: Wed,  1 Jul 2026 14:11:11 +0530
Message-Id: <20260701084115.80383-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701084115.80383-1-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX6HSUm54gJI4o
 Hejd8x/lb45k5xSSZYvjEPq1iQ+gUA0Rd9+tyhnnCjrttLUNXlKp7fUM++ejDfEIjvtZScbDEx2
 xk4IJeRQgWkwZINV4C75Zh7f4ZQC7zaDWjDIBwsFOpzULGU9q3CH72XdVrjXozf/YyB1tSzM9kB
 7EYR4b1VPXmmSAVzDAbmSa4LJr7gLe2eNHBdeJAQisnZaa3XtOGM69hPjMDUFxJ4i7K5a1fKSFs
 SqNCemXpqvGD9e/OB9I3N+NPX8pZ7OExqEgUJru9PJZSN2PBbAbMLrsREeGtBNmIv8Q/OSTK7jU
 PV3jAIl8cGE6YjRSlEjtrmfG1l06Le6C62RfibevFGb87PwnBjV/5HvU9q51YEUuy0/rq6OaYzW
 l8JmUJjOisozuXGIUU/jzhuhmrikefNBG0Jfrt9DeOmFmJfim/lY7RbOUuBbeZrKDF7QuPceD/w
 8xGDofDXNgPUv3fDyHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX3SMVH0LP2DZ8
 LLLghNkz6svWtbRzhyyBM6ydleBPFtIWwoZh0f1dzK3Mv924KSnUKfgYFRAMUmNCZzYfoXPX7k1
 GGeh0WjgSqxns9wKN2haFNokNgulY4U=
X-Proofpoint-GUID: yOj8O2v49BSlNXzYEqRWC_b0SdG3i7L5
X-Proofpoint-ORIG-GUID: eH39_qc8ka60J1Wa2KyT0LCcJOeeGZV0
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44d2cb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yLFEEiYmyGi9tV9Y51oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010084

Add htm pmu auxtrace process function for "perf script -D".
The auxtrace event processing functions are defined in file
"util/powerpc-htm.c". Different PERF_RECORD_XXX are generated
during recording. PERF_RECORD_AUXTRACE_INFO is processed first
since it is of type perf_user_event_type and perf session event
delivers perf_session__process_user_event() first. Define function
powerpc_htm_process_auxtrace_info() to handle the processing of
PERF_RECORD_AUXTRACE_INFO records. In this function, initialize
the aux buffer queues using auxtrace_queues__init(). Setup the
required infrastructure for aux data processing.

The trace data which is part of each AUXTRACE record will be written
to a file named htm.bin.n<nodeindex>.p<nodalchipindex>.c<coreindexonchip>

Sample output:
 # perf record -C 8 -m,256 -e htm/event=0x901032/ ls
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 2048.915 MB perf.data ]

 # perf script -D -i perf.data
 . ... HTM PMU data: size <N> bytes

 # perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ -o perf_1.data ls 1>out
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 257.504 MB perf_1.data ]

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/htm.c |   3 +
 tools/perf/util/auxtrace.c         |   4 +
 tools/perf/util/auxtrace.h         |   1 +
 tools/perf/util/powerpc-htm.c      | 149 +++++++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h      |   2 +
 5 files changed, 159 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc/util/htm.c
index cc733f45ac9b..0e6638c02716 100644
--- a/tools/perf/arch/powerpc/util/htm.c
+++ b/tools/perf/arch/powerpc/util/htm.c
@@ -56,6 +56,7 @@ htm_recording_options(struct auxtrace_record *ar __maybe_unused,
 		if (strstarts(pos->name, "htm")) {
 			pos->needs_auxtrace_mmap = true;
 			pos->core.attr.aux_watermark = opts->auxtrace_mmap_pages * (size_t)page_size;
+			pos->core.attr.sample_type |= PERF_SAMPLE_RAW;
 			break;
 		}
 	}
@@ -75,6 +76,8 @@ htm_info_fill(struct auxtrace_record *itr __maybe_unused,
 		struct perf_record_auxtrace_info *auxtrace_info __maybe_unused,
 		size_t priv_size __maybe_unused)
 {
+	auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0b851f32e98c..9f32f54fad43 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -56,6 +56,7 @@
 #include "s390-cpumsf.h"
 #include "util/mmap.h"
 #include "powerpc-vpadtl.h"
+#include "powerpc-htm.h"
 
 #include <linux/ctype.h>
 #include "symbol/kallsyms.h"
@@ -1427,6 +1428,9 @@ int perf_event__process_auxtrace_info(const struct perf_tool *tool __maybe_unuse
 	case PERF_AUXTRACE_VPA_DTL:
 		err = powerpc_vpadtl_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_POWERPC_HTM:
+		err = powerpc_htm_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6947f3f284c0..68b17802a419 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -46,6 +46,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_S390_CPUMSF,
 	PERF_AUXTRACE_HISI_PTT,
 	PERF_AUXTRACE_VPA_DTL,
+	PERF_AUXTRACE_POWERPC_HTM,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 5043ff41a609..ffddf0e59fc1 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -9,6 +9,24 @@
 #include "session.h"
 #include "debug.h"
 #include <internal/xyarray.h>
+#include <linux/string.h>
+#include "color.h"
+#include <inttypes.h>
+#include "powerpc-htm.h"
+#include <errno.h>
+
+struct perf_session;
+
+struct powerpc_htm {
+	struct auxtrace			auxtrace;
+	struct auxtrace_queues		queues;
+	struct auxtrace_heap		heap;
+	u32				auxtrace_type;
+	struct perf_session		*session;
+	struct machine			*machine;
+	u32				pmu_type;
+	char				htmbin_file[64];
+};
 
 /*
  * Check if HTM events have more data to collect.
@@ -72,3 +90,134 @@ int arch_perf_record__need_read(struct evlist *evlist)
 
 	return 1;
 }
+
+static void powerpc_htm_dump_event(size_t len)
+{
+	const char *color = PERF_COLOR_BLUE;
+
+	color_fprintf(stdout, color,
+			". ... HTM PMU data: size %zu bytes\n",
+			len);
+}
+
+static int powerpc_htm_process_event(struct perf_session *session __maybe_unused,
+				 union perf_event *event __maybe_unused,
+				 struct perf_sample *sample __maybe_unused,
+				 const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int powerpc_htm_process_auxtrace_event(struct perf_session *session __maybe_unused,
+					  union perf_event *event,
+					  const struct perf_tool *tool __maybe_unused)
+{
+	powerpc_htm_dump_event(event->auxtrace.size);
+
+	return 0;
+}
+
+static int powerpc_htm_flush(struct perf_session *session __maybe_unused,
+			 const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void powerpc_htm_free_events(struct perf_session *session)
+{
+	struct powerpc_htm *htm = container_of(session->auxtrace, struct powerpc_htm,
+					     auxtrace);
+	struct auxtrace_queues *queues = &htm->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++)
+		zfree(&queues->queue_array[i].priv);
+
+	auxtrace_queues__free(queues);
+}
+
+static void powerpc_htm_free(struct perf_session *session)
+{
+	struct powerpc_htm *htm = container_of(session->auxtrace, struct powerpc_htm,
+					     auxtrace);
+
+	powerpc_htm_free_events(session);
+	session->auxtrace = NULL;
+	free(htm);
+}
+static const char * const powerpc_htm_info_fmts[] = {
+	[POWERPC_HTM_TYPE]		= "  PMU Type           %"PRId64"\n",
+};
+
+static void powerpc_htm_print_info(__u64 *arr)
+{
+	if (!dump_trace)
+		return;
+
+	fprintf(stdout, powerpc_htm_info_fmts[POWERPC_HTM_TYPE], arr[POWERPC_HTM_TYPE]);
+}
+
+int powerpc_htm_process_auxtrace_info(union perf_event *event,
+				  struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct evsel *evsel = evlist__event2evsel(session->evlist, event);
+	u32 nodeindex, nodalchipindex, coreindexonchip;
+	int config = (evsel->core.attr.config);
+	size_t min_sz = sizeof(u64) * POWERPC_HTM_TYPE;
+	struct powerpc_htm *htm;
+	int err;
+	FILE *fp;
+
+	nodeindex = (config >> 4) & 0xff;
+	nodalchipindex = (config >> 12) & 0xff;
+	coreindexonchip = (config >> 20) & 0xff;
+
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
+					min_sz)
+		return -EINVAL;
+
+	htm = zalloc(sizeof(struct powerpc_htm));
+	if (!htm)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&htm->queues);
+	if (err)
+		goto err_free;
+
+	htm->session = session;
+	htm->machine = &session->machines.host; /* No kvm support */
+	htm->auxtrace_type = auxtrace_info->type;
+	htm->pmu_type = auxtrace_info->priv[POWERPC_HTM_TYPE];
+
+	htm->auxtrace.process_event = powerpc_htm_process_event;
+	htm->auxtrace.process_auxtrace_event = powerpc_htm_process_auxtrace_event;
+	htm->auxtrace.flush_events = powerpc_htm_flush;
+	htm->auxtrace.free_events = powerpc_htm_free_events;
+	htm->auxtrace.free = powerpc_htm_free;
+	session->auxtrace = &htm->auxtrace;
+
+	snprintf(htm->htmbin_file, sizeof(htm->htmbin_file), "htm.bin.n%d.p%d.c%d", nodeindex, nodalchipindex, coreindexonchip);
+	fp = fopen(htm->htmbin_file, "w");
+	if (!fp) {
+		pr_err("Failed to create %s: %s\n", htm->htmbin_file, strerror(errno));
+		return -errno;
+	}
+	fclose(fp);
+
+	powerpc_htm_print_info(&auxtrace_info->priv[0]);
+
+	err = auxtrace_queues__process_index(&htm->queues, session);
+	if (err)
+		goto err_free_queues;
+
+	return 0;
+
+err_free_queues:
+	auxtrace_queues__free(&htm->queues);
+	session->auxtrace = NULL;
+
+err_free:
+	free(htm);
+	return err;
+}
diff --git a/tools/perf/util/powerpc-htm.h b/tools/perf/util/powerpc-htm.h
index be7f8c03e161..0dc31fa252b4 100644
--- a/tools/perf/util/powerpc-htm.h
+++ b/tools/perf/util/powerpc-htm.h
@@ -20,4 +20,6 @@ struct perf_session;
 struct perf_pmu;
 
 struct auxtrace_record *htm_recording_init(struct evsel *pos);
+int powerpc_htm_process_auxtrace_info(union perf_event *event,
+					struct perf_session *session);
 #endif
-- 
2.52.0


