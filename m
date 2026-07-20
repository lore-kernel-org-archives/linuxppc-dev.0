Return-Path: <linuxppc-dev+bounces-24483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16331C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:04:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3d250qNyz30DZ;
	Mon, 20 Jul 2026 21:04:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784545469;
	cv=none; b=mKqyCSDZzYMbTQlT/KvZ5h2MAs+zQ+5fB/CUOhnrSPgXZ8gJcht+xQpaFs1fXXKVnHGNwkln9GtYfqd1CZTAueFgWPURH2zcpNecGt+2a+n8PjxO/fFR7s4/r8H2JL2DaBaNRZSStmcc9XnO7DsjOnvPVcZbg6s8B1hkIee4RblZE+7150KWaKoHf68HHkHgFJmyKdJeaCgybKPQE1/7NhwwZjjoyra45dR+K3qoi2a9oUM1TyXaOcN9nCNavNhCIdtO3C7cteiaTW39+L1d52V4BrHipAE3gNFd9ocmhRX5E+3pqNKnpYu78/Tq/iaGuHcH67OSdbVPnKyx1WnawA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784545469; c=relaxed/relaxed;
	bh=J1tjrhSKc99+8OfD68LKRzdGaz1UZOgDjSTgmPi9O2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVzSz6VLnQePHTz9ar4a23iD4IfHUJAaIl7L+D1LADpvmR/GNfCPP+lyDi/CbMfAUmJuzblNQ/JDOzDwtuArpXNPujEcuOOdFPIZLSaYLdlkL3xLaHUOKRAI2V7gjzW0zDfZ22ZPRMSQGye93PyAtVYdvZmRVI2LfUKPjbztSh+EZX5kJQEBrn2aAOrIlM2w6PCiLb8+VitN6GfYhvVxpp0DCEF4ZCx7qYtZ3ud5OeMNTvjTlK7A3hdaYQnrBAI8C8w5Zh4mr+WSpd7u5NtX0PV4Tzo4uJz2ptIetcTrhNCeX5lCv+Q62WHdYeEfVO/c1hsa+maw7XFCmKGZm0mO+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fwx+Yf0J; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fwx+Yf0J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3d242xy3z2ybK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 21:04:28 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAC1xn027325;
	Mon, 20 Jul 2026 11:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J1tjrhSKc99+8OfD6
	8LKRzdGaz1UZOgDjSTgmPi9O2g=; b=fwx+Yf0JWcL842P3qU86kNt1340OBexSb
	T7CYW3ZLUgbT8XTDrrjMDXS4wF27BVkAWqBQwgTiJ4/WlIC0QoDb34MhbwVsLF40
	S8aOW2q37W3PmbAqqsgfBC5kbQbr96YrFVugUy3fkQVlQaCeeUeRfgWkh59OAnSO
	Xel672Y30QX+cMC2pZIwsUAceUbWDSO9+VXtgcY2ErnKONe2qvql5/jsqeYvtRuY
	RQ/QkOaddXELDLShGYdhYQ8JdBEsf1zNTrPudEb58OUvWJV83lS/kKusuvGKXaHH
	rp9hauSrYSsPnixo4X6zh8RxEf4ucpQquYTWfrQiV1/UZb9+srBpg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a732v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KB0oqk007479;
	Mon, 20 Jul 2026 11:04:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vwch0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB4JvZ30146920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67E3120043;
	Mon, 20 Jul 2026 11:04:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CFC22004E;
	Mon, 20 Jul 2026 11:04:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:04:15 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 5/6] tools/perf: Add powerpc HTM auxtrace event processing support
Date: Mon, 20 Jul 2026 16:22:17 +0530
Message-Id: <20260720105218.14277-6-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: jnvNk4_SIOGcBP2lne5cB3zE4KHDKQQ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX0Jmx5SSBuK3H
 9vL0LOI8qcQAxOZI7mECj7Vn8LaOHfw5YOml84xL2n+tmEAvTRJf1aljIE0MJ12uOygg4DXdQd4
 4oJE8PnPT4kfEmyY/o9OF+pRbz/O5lk=
X-Proofpoint-GUID: JLgSEY9JjIJrPuAN6bRhTRu_YESKNwqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX5UIifspsVdSr
 lmCqmViideY52wPHhSLtwv5xALEONH+Rtdopax1f6PuyDsH8pBBBFFlw2V4ihZHf3OYLloDzzhY
 ZbbcFT6sm4ToEqqShBOa+h0Jb7749afQ102ckKmKyXcyJanww7yDiA9VPWMn/aL2r7YgcpxZpyN
 eWBr/uCMaK5dJGmlcZ+DxbcfPf46ohxbCOnEPzEzVYWwwvgJuocEzH8J9CWZ1ztsmYlPS+YcNkW
 KvXT024fc3Kg2EcUvjQ2L5TEQbbJGM2NPKQMsOKF5WUxcBJOFF8aEgz7i4FebTAm0I9GwcUpS1s
 bcXbZRmv1/Y/1nzCQiN/FZeZRtw0z06+dYgkdyNB7kVoq28LAYAoZSgBPKQ+ryX0DBufHuxQhaW
 JvDL9qW8dX7YGfigtVq1hl4F1+rKyZdReGuPeYJKu5zNEcQIqErLV7dKAnsHNiq+vCqz4FZFE5Q
 5KQjq6MFAgTlfugAzwA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e00b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ofXt-N-APMp9VAbjTHMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200119

Add the PERF_AUXTRACE_POWERPC_HTM enum value to auxtrace.h and wire
the dispatch in perf_event__process_auxtrace_info() to call
powerpc_htm_process_auxtrace_info().

This patch sets auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM in
htm_info_fill() (introduced in the previous patch) now that the
constant is defined, completing the record-side setup.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Scope narrowed: this patch now only adds the PERF_AUXTRACE_POWERPC_HTM
  enum constant to auxtrace.h and wires the dispatch in
  perf_event__process_auxtrace_info() to call
  powerpc_htm_process_auxtrace_info().  It also amends htm_info_fill()
  (from patch 2) to set auxtrace_info->type now that the constant is
  defined.
- All file-writing and decoding logic is moved to patch 6.
- Patch is now 5/6 instead of 5/9.

 tools/perf/arch/powerpc/util/htm.c |   2 +-
 tools/perf/util/Build              |   1 +
 tools/perf/util/auxtrace.c         |   4 +
 tools/perf/util/auxtrace.h         |   1 +
 tools/perf/util/powerpc-htm.c      | 115 +++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/powerpc-htm.c

diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc/util/htm.c
index 07b496e4be2f..9555cf356617 100644
--- a/tools/perf/arch/powerpc/util/htm.c
+++ b/tools/perf/arch/powerpc/util/htm.c
@@ -99,7 +99,7 @@ htm_info_fill(struct auxtrace_record *itr,
 	if (priv_size != HTM_AUXTRACE_PRIV_SIZE(expected_n))
 		return -EINVAL;
 
-	// To set: auxtrace_info->type
+	auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM;
 	auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] = htm_r->evsel->core.attr.type;
 	auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] = expected_n;
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 330311cac550..7fa354853d2a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -141,6 +141,7 @@ perf-util-y += hisi-ptt.o
 perf-util-y += hisi-ptt-decoder/
 perf-util-y += s390-cpumsf.o
 perf-util-y += powerpc-vpadtl.o
+perf-util-y += powerpc-htm.o
 
 ifdef CONFIG_LIBOPENCSD
 perf-util-y += cs-etm.o
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
new file mode 100644
index 000000000000..8d28d02031d6
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <endian.h>
+#include "util/evsel.h"
+#include "util/evlist.h"
+#include "util/session.h"
+#include "color.h"
+#include "powerpc-htm.h"
+#include "debug.h"
+#include "sample.h"
+
+struct powerpc_htm {
+	struct auxtrace		auxtrace;
+	struct auxtrace_queues	queues;
+	struct auxtrace_heap	heap;
+	u32			auxtrace_type;
+	struct perf_session	*session;
+	struct machine		*machine;
+};
+
+static void powerpc_htm_dump_event(size_t len)
+{
+	const char *color = PERF_COLOR_BLUE;
+
+	if (dump_trace) {
+		color_fprintf(stdout, color,
+			". ... HTM PMU data: size %zu bytes\n", len);
+	}
+}
+
+static int powerpc_htm_process_event(struct perf_session *session __maybe_unused,
+				     union perf_event *event __maybe_unused,
+				     struct perf_sample *sample __maybe_unused,
+				     const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int powerpc_htm_process_auxtrace_event(struct perf_session *session __maybe_unused,
+					      union perf_event *event,
+					      const struct perf_tool *tool __maybe_unused)
+{
+	if (dump_trace)
+		powerpc_htm_dump_event(event->auxtrace.size);
+
+	return 0;
+}
+
+static int powerpc_htm_flush(struct perf_session *session __maybe_unused,
+			     const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void powerpc_htm_free_events(struct perf_session *session)
+{
+	struct powerpc_htm *htm;
+
+	if (!session || !session->auxtrace)
+		return;
+
+	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
+	auxtrace_queues__free(&htm->queues);
+}
+
+static void powerpc_htm_free(struct perf_session *session)
+{
+	struct powerpc_htm *htm;
+
+	if (!session || !session->auxtrace)
+		return;
+
+	htm = container_of(session->auxtrace, struct powerpc_htm, auxtrace);
+	powerpc_htm_free_events(session);
+	session->auxtrace = NULL;
+	free(htm);
+}
+
+int powerpc_htm_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct powerpc_htm *htm;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
+					 HTM_AUXTRACE_PRIV_FIXED)
+		return -EINVAL;
+
+	htm = zalloc(sizeof(struct powerpc_htm));
+	if (!htm)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&htm->queues);
+	if (err) {
+		free(htm);
+		return err;
+	}
+
+	htm->session = session;
+	htm->machine = &session->machines.host;
+	htm->auxtrace.process_event = powerpc_htm_process_event;
+	htm->auxtrace.process_auxtrace_event = powerpc_htm_process_auxtrace_event;
+	htm->auxtrace.flush_events = powerpc_htm_flush;
+	htm->auxtrace.free_events = powerpc_htm_free_events;
+	htm->auxtrace.free = powerpc_htm_free;
+	session->auxtrace = &htm->auxtrace;
+
+	return 0;
+}
-- 
2.43.0


