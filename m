Return-Path: <linuxppc-dev+bounces-23284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B083C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:41:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtlz6Gtqz2yfs;
	Wed, 01 Jul 2026 18:41:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895295;
	cv=none; b=No8Lup3biYfgzoVMd0v4bZPrkxXZc9AnP90r+usWX2oAAjO9NFfGUiAzJn9zB5wwjFXcd+SpF7TEgzJvzvp1PJT4OB38Ke2HsVwF7g44HEoLBlKg/INun0Zf9nUTlEZmZ7RcFmkml8JABNxR2sWWdPTVZa/4Do+n4AUNTNkr1XiMPDx1kf4K2SIkYaLrmSEoGSIxFTGje/K845PZcP6hPFCcub61Yr1fEpCbwQRzUBOFumXjAnaqCTDRE/d0hgBv8mdoC5jN6QiK0Fzf0vO7SroesTWsqq4g5uhVI7SsmajOfJ3lVQBLopIiv8DKrxHFPA+ubUlQO2qZpmFcQfJksA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895295; c=relaxed/relaxed;
	bh=+OOaee/aQ/FoLhb2V5mf5S1G4QC4q/6JzL9iEEYuvRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUriuOE3tST7UMimAQF6C+VtgStlmmzz7S6A6B4X7RHBVQLne1wtML5D0i9XHtl7dMhwPNmJ1wgH4IiNEaZtt0QDXVzPuwpxMIcI+tRqWHY1aoHPdO6kv86kyn+dxwBvcH5puoBeCtGcY3wPKQRQ/wGR6u2oTDD8YHQLkUTpBUnp/quNVWcZO0obUE5MNbFhBeQ3iKuNMDSGsbttWjDVPKpw3aW+3u22lpDhMKBLMJz5hVgEJLClPKuTj7uJK1bQVHYoQ2aY1XMgpx8kO9DCWrxf5Sbhci/jm/W1mUYADUnNSZGRf+GqjdZwSlTOQD2D2uLyKaNpwYFkDDYygOIK1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pw6HEKHQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pw6HEKHQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtly4R9wz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:34 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IWwE357095;
	Wed, 1 Jul 2026 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+OOaee/aQ/FoLhb2V
	5mf5S1G4QC4q/6JzL9iEEYuvRY=; b=pw6HEKHQJdaZEIKBKS/DUr7Utfmofyhi+
	gPuZoBS1rMA6+98j1mF9McOyOjIHa/2KBQKhGB8XuWtbHrXliI8Zu2xJwyqV3Qd0
	V0gTtiwOg+CEIy6Ba52LDc/lBCtXimlrWw1SMx7mDyFo9hA+cpIhNmPS+39GiRjG
	XcDR2d3xDLWT0gW5/BSI2cQhse00BLRhUvKLyZSkEalFQYfgnTAhf1jmf3e5bJ0E
	eI0TLGIWluOXGboql3S8MavYd0x2YNS/ZCeQEHwGUTIi0yemlYI34xT56HwHSEM6
	fxSxTezuM/1ZHFKHfcNdXrKONr+HqGQLWUFTCrLi6P2yhWU5+1piA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3gf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Yaoi000654;
	Wed, 1 Jul 2026 08:41:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhye6wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fQDW21627326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB0E62004D;
	Wed,  1 Jul 2026 08:41:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C287E20040;
	Wed,  1 Jul 2026 08:41:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:22 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 1/9] tool/perf: Move auxtrace_record__init for powerpc-vpadtl as separate utility
Date: Wed,  1 Jul 2026 14:11:07 +0530
Message-Id: <20260701084115.80383-2-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: zHzsa-80kYeFzUFgd7n30eB34aC6RHCW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfXyBeADUqdVEvM
 F641v1ZPyms5iXGVVaPQBZSwTSnaAsbD6OddqRiXXuBhrR5DI1/EupFG7CfXMbPxExHqgWHUI9g
 CeTAw+z33QEIScXf1cP0xNCXnfEqZ8U=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44d2bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ie1hbA1ekTl6Xy7aErYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX6k0ACecyRMUG
 gK4MKilmFym+8hn2I1/uQhddNi9QMrMX6MAI4ofWRwOOguorSM4iR+NTmYYqiNIfxcRXSaJb4JC
 QeKdXTTNJBN/H7DHYv6EUhqXvWrpJIzBP3CPlrvh5gDUI4uXXNEM1l6d8pPLMFgCevYce2TsvMV
 FL/Ucc/nnVMJNzm1Wu3GO0pJa0sOswvcq9O7E4hufpfJgj/zMIYGTnOialchhiqN63ifB1x0KNx
 bA0Zh+lU94jjMDj8IIteD8JNG7yoevwcgwfHjGgLaOhjsr8XulggLcSENKVG9oN7rhi52xe8vma
 9JXd5n/tqJ+kGj7gCQI+E5si/O0OgPI2B/Wc4F3EYBtx+2H4u+J6Jkrjzk9jHKvDfZbn5Astpov
 ITIy7nLr1yY4xI7w6iLHzdK0lvqP+f0itRSgDEOM7/GMTtTKDP8JF2LUVqGQefX253ER9CwSF7c
 P84cEkS+KaemEMqsp8A==
X-Proofpoint-ORIG-GUID: QxsYWQ_dQwlift7jx-U-3NyVdltyszLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

The powerpc PMU collecting Dispatch Trace Log (DTL) entries makes use of
AUX support in perf infrastructure. To enable the creation of
PERF_RECORD_AUXTRACE, auxtrace_record__init() to initialize auxtrace
record is part of arch/powerpc/util/auxtrace.c

To enable other PMU's to use auxtrace, move the auxtrace_record__init
for powerpc-vpadtl to another file: arch/powerpc/util/vpa-dtl.c
In auxtrace_record__init, based on pmu used, call vpa_dtl_recording_init
to initialize recording options for DTL

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/Build      |  1 +
 tools/perf/arch/powerpc/util/auxtrace.c | 79 ++------------------
 tools/perf/arch/powerpc/util/vpa-dtl.c  | 96 +++++++++++++++++++++++++
 tools/perf/util/powerpc-vpadtl.h        |  1 +
 4 files changed, 104 insertions(+), 73 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index ae928050e07a..7819c8f5af2d 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -7,3 +7,4 @@ perf-util-y += evsel.o
 perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-y += auxtrace.o
+perf-util-y += vpa-dtl.o
diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index 4600a1661b4f..0053526329e0 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -13,63 +13,12 @@
 #include "../../util/auxtrace.h"
 #include "../../util/powerpc-vpadtl.h"
 #include "../../util/record.h"
-#include <internal/lib.h> // page_size
-
-#define KiB(x) ((x) * 1024)
-
-static int
-powerpc_vpadtl_recording_options(struct auxtrace_record *ar __maybe_unused,
-			struct evlist *evlist __maybe_unused,
-			struct record_opts *opts)
-{
-	opts->full_auxtrace = true;
-
-	/*
-	 * Set auxtrace_mmap_pages to minimum
-	 * two pages
-	 */
-	if (!opts->auxtrace_mmap_pages) {
-		opts->auxtrace_mmap_pages = KiB(128) / page_size;
-		if (opts->mmap_pages == UINT_MAX)
-			opts->mmap_pages = KiB(256) / page_size;
-	}
-
-	return 0;
-}
-
-static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-					struct evlist *evlist __maybe_unused)
-{
-	return VPADTL_AUXTRACE_PRIV_SIZE;
-}
-
-static int
-powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
-		struct perf_session *session __maybe_unused,
-		struct perf_record_auxtrace_info *auxtrace_info,
-		size_t priv_size __maybe_unused)
-{
-	auxtrace_info->type = PERF_AUXTRACE_VPA_DTL;
-
-	return 0;
-}
-
-static void powerpc_vpadtl_free(struct auxtrace_record *itr)
-{
-	free(itr);
-}
-
-static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr __maybe_unused)
-{
-	return 0;
-}
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 						int *err)
 {
-	struct auxtrace_record *aux;
 	struct evsel *pos;
-	int found = 0;
+	int found_vpa_dtl = 0;
 
 	/*
 	 * Set err value to zero here. Any fail later
@@ -79,32 +28,16 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, pos) {
 		if (strstarts(pos->name, "vpa_dtl")) {
-			found = 1;
+			found_vpa_dtl = 1;
 			pos->needs_auxtrace_mmap = true;
 			break;
 		}
 	}
 
-	if (!found)
-		return NULL;
-
-	/*
-	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
-	 * must come first.
-	 */
-	evlist__to_front(pos->evlist, pos);
-
-	aux = zalloc(sizeof(*aux));
-	if (aux == NULL) {
-		pr_debug("aux record is NULL\n");
-		*err = -ENOMEM;
+	if (found_vpa_dtl)
+		return vpa_dtl_recording_init(pos);
+	else {
+		*err = -EINVAL;
 		return NULL;
 	}
-
-	aux->recording_options = powerpc_vpadtl_recording_options;
-	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
-	aux->info_fill = powerpc_vpadtl_info_fill;
-	aux->free = powerpc_vpadtl_free;
-	aux->reference = powerpc_vpadtl_reference;
-	return aux;
 }
diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c b/tools/perf/arch/powerpc/util/vpa-dtl.c
new file mode 100644
index 000000000000..ae81cbad0c38
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VPA support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+#include <linux/string.h>
+#include <time.h>
+
+#include "../../util/cpumap.h"
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/util.h"
+#include "../../util/pmu.h"
+#include "../../util/debug.h"
+#include "../../util/auxtrace.h"
+#include "../../util/powerpc-vpadtl.h"
+#include "../../util/record.h"
+#include <internal/lib.h> // page_size
+
+#define KiB(x) ((x) * 1024)
+
+static int
+powerpc_vpadtl_recording_options(struct auxtrace_record *ar __maybe_unused,
+			struct evlist *evlist __maybe_unused,
+			struct record_opts *opts)
+{
+	opts->full_auxtrace = true;
+
+	/*
+	 * Set auxtrace_mmap_pages to minimum
+	 * two pages
+	 */
+	if (!opts->auxtrace_mmap_pages) {
+		opts->auxtrace_mmap_pages = KiB(128) / page_size;
+		if (opts->mmap_pages == UINT_MAX)
+			opts->mmap_pages = KiB(256) / page_size;
+	}
+
+	return 0;
+}
+
+static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+					struct evlist *evlist __maybe_unused)
+{
+	return VPADTL_AUXTRACE_PRIV_SIZE;
+}
+
+static int
+powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
+		struct perf_session *session __maybe_unused,
+		struct perf_record_auxtrace_info *auxtrace_info,
+		size_t priv_size __maybe_unused)
+{
+	auxtrace_info->type = PERF_AUXTRACE_VPA_DTL;
+
+	return 0;
+}
+
+static void powerpc_vpadtl_free(struct auxtrace_record *itr)
+{
+	free(itr);
+}
+
+static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return 0;
+}
+
+struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos)
+{
+	struct auxtrace_record *aux;
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(pos->evlist, pos);
+
+	aux = zalloc(sizeof(*aux));
+	if (aux == NULL) {
+		pr_debug("aux record is NULL\n");
+		return NULL;
+	}
+
+	aux->recording_options = powerpc_vpadtl_recording_options;
+	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
+	aux->info_fill = powerpc_vpadtl_info_fill;
+	aux->free = powerpc_vpadtl_free;
+	aux->reference = powerpc_vpadtl_reference;
+	return aux;
+}
diff --git a/tools/perf/util/powerpc-vpadtl.h b/tools/perf/util/powerpc-vpadtl.h
index ca809660b9bb..5f17e660c562 100644
--- a/tools/perf/util/powerpc-vpadtl.h
+++ b/tools/perf/util/powerpc-vpadtl.h
@@ -20,4 +20,5 @@ struct perf_pmu;
 int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 
+struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos);
 #endif
-- 
2.52.0


