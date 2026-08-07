Return-Path: <linuxppc-dev+bounces-25596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2978C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:41:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGn0k0hXcz3c91;
	Sat, 08 Aug 2026 00:41:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113718;
	cv=none; b=Tyhr0bdJg8fcS3g4ts72HDq5fWqZtWseRIyJUKcXuBePTNySpb/3ZATvX+HMEO631wMrAjhFZoDpibcIdw4xuNlctnsw/0gWG9m+fuFLFqLSSMfaTTt5mznTxVvIO+mTaOu4wAvLinyNYgmUeWMslH2/WCuSrke3WOsX8eBbQf8wXP151AdFLi9riv11p4BZHOjrE8Ol4ZcYZrFeXhPCAgIyDLqG4ngwFnSr85kppnP2+m7oevWBOIAQf8Vu9TFwJPV1MBIZ1CdUb9X1wj9BI84nuCTMmOktt/4cios/2+n1pJaB3Dd7B2FsfAW2qnWhh0lWrWyCx7v5VjfuQPjVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113718; c=relaxed/relaxed;
	bh=WK6uPA+MfUYGajs7aYNzhCBJolUbePVS+u/0E8TeFeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QshNni8miBtao9NgSpFTo7ebrUalGiwUDsPLBVEa2vWCUKKSWl7dbTOTh7Yzbc+ieOpBHbIRULg2ac95KK5RxrN5n/xzTkqc2ymPC/L/kAJwaDHtzmJSltA0HK5klG1lV6KTzyPqkpwyYsPOLvTzVRH4h91nslvhNve4ubtguxjcthuFwrZU+a+udhTwjnGd/mMAJ+dmE6MzlwCeTgLvJU/SlgRfC9ALo30YmaFklvV6mRDFrmnqC1+mKUFCCmAcKXluRPwc7wldO7iVbuyagkMrDpKW0vEGDt6vjTMfmG8OR2VLGuYkAR8ImNfbAu41Uf6Lw+u3uTFCy5p8OIaIIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dNv6i+s7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dNv6i+s7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGn0j2GNmz3c4l
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:41:57 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClbkT1513743;
	Fri, 7 Aug 2026 14:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WK6uPA+MfUYGajs7a
	YNzhCBJolUbePVS+u/0E8TeFeo=; b=dNv6i+s7tUu/ZibaRM+krjrZTK3mhcc84
	hVTgWSbTwP1+0DvARCCwZWxdcI2CY+r5vuZ6KuWtbXD1MVjfh8n5Nj4a2UWBFsx8
	/MDzpit+clt/156faGRlDRYhXBkJEFvA6I8B0wdUP/xQkAznyECD4iLLGlm+LAlY
	a69MhF7hJrbBb9AlDFtFZS4SoZ0BXmbk8Nx9HI2USJ9/fJWIC945gOlKw+JZ2JDd
	wMLslUAivKNwT90uEzyH9WUB0PdcVyHJFUOVfgSUn1lKntgt0dQU8Ra8UXpVoeVV
	9UN4YazYQasJ/FqFHGYUNBm1yvtQv/7jVmLr7Vcn2w1491GzO20Vg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyvc2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:41:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfKll001836;
	Fri, 7 Aug 2026 14:41:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwg5rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:41:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677EfmVp44106106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:41:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2105F20043;
	Fri,  7 Aug 2026 14:41:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47D520040;
	Fri,  7 Aug 2026 14:41:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:41:44 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V5 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
Date: Fri,  7 Aug 2026 20:11:30 +0530
Message-Id: <20260807144135.2607-2-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75eeb1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fb_F93YjGL9XOfOOxY0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX4/Rkwzxfciws
 rXkTXzLaEvZbRd5ifj9p7TGbwA53WP4Aa9be1rDMk17k7P9oHqwxWeRU6CPWcrPfLImmdfVQtpU
 cyUe7ZHjixkvax8PWqMzQAk3GfJs/gw=
X-Proofpoint-ORIG-GUID: Pw2HGB4Yeuzy8RNlwsy_99tGSaqHVudC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXy2J2Alqg9wAO
 CRAMrTOxjohc4g5HaXEyIO9UqE7M2/IcobLZMjgY+YmxR7Q+ylEwE5k7sRjbXAgBvq9nMC+lTyX
 Z6zOKm/cOnvKkZ11Of/WD4gRHgaEsM/zCDKu4HEauF9CD4B9sXNm6/76wNUeHVdDM99UFNVKMhs
 HRrBU565G2KFswNeePRUflQFXfiulVQkuOTVW/ZYA1SDQIl8YxxX81cp3TSO+JK8ylBwgz7RG97
 VHgt86B6CcoVOohyGS6cplGY5KzZgOiKLK2+RDzwDrAx9Fwg7fyDhu9I4S7bXobscQMCfSn/5b2
 lWOaonOP6ytuGf3TI1Tk4Ie5XaU6uFQpiKjs88VUBrf6u1KQQyNcD7zm2PfUdjkx137KxqglRTP
 QuTMOZRe4aHL9j6pIN8Lr3Qey+IiVUwxLRz8f5WAS+R2+uC8MfJB3Fb938dVmtGfPYswNTWfb6i
 /oKust5V34MfjCv2qtw==
X-Proofpoint-GUID: C4Bz3Kebr9zcd8jLRnx2rOx8oQz5-q1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070112

The powerpc auxtrace dispatch lives entirely in
arch/powerpc/util/auxtrace.c.  As new PMUs such as HTM are added, this
file would grow to contain the recording logic for all of them.

Factor out the VPA-DTL recording initializer into its own file,
arch/powerpc/util/vpa-dtl.c, and reduce auxtrace.c to a thin dispatch
layer.  auxtrace_record__init() now detects the PMU by name and calls
the appropriate per-PMU init function:

  - vpa_dtl_recording_init() for VPA-DTL events (unchanged behaviour)
  - Further PMU entries will follow in subsequent patches

This makes room in auxtrace_record__init() for the HTM recording path
added in the next patch without growing a single monolithic file.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- Add forward declarations for struct evsel and struct auxtrace_record
  in powerpc-vpadtl.h before the vpa_dtl_recording_init() prototype.
  Without them, a translation unit that includes the header before the
  full definitions are visible may produce implicit-declaration warnings
  on strict compilers.

Changes in V4:
- No changes from V3.

Changes in V3:
Add #include <linux/zalloc.h> to vpa-dtl.c; without it the compiler
treats zalloc() as implicitly returning int, truncating the upper
32 bits of the returned pointer on 64-bit PowerPC.

Changes in V2:
- Renamed the destination file from arch/powerpc/util/vpa-dtl.c (same
  name, unchanged) but the subject and commit message are reworded to
  clearly state that the goal is to make auxtrace_record__init() a thin
  per-PMU dispatcher, not merely to "allow multiple PMUs to use auxtrace".
- Handle failure from memory allocation
- Included stdlib and limits.h
- No functional change to the VPA-DTL path itself.
- Patch is now 1/6 instead of 1/9.

 tools/perf/arch/powerpc/util/Build      |  1 +
 tools/perf/arch/powerpc/util/auxtrace.c | 84 +++-------------------
 tools/perf/arch/powerpc/util/vpa-dtl.c  | 96 +++++++++++++++++++++++++
 tools/perf/util/powerpc-vpadtl.h        |  3 +
 4 files changed, 108 insertions(+), 76 deletions(-)
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
index 4600a1661b4f..e04a0bd61755 100644
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
+	struct evsel *vpa_dtl_evsel = NULL;
 
 	/*
 	 * Set err value to zero here. Any fail later
@@ -78,33 +27,16 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	*err = 0;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (strstarts(pos->name, "vpa_dtl")) {
-			found = 1;
+		if (pos->name && strstarts(pos->name, "vpa_dtl")) {
 			pos->needs_auxtrace_mmap = true;
-			break;
+			/* Remember the first matching VPA DTL event */
+			if (!vpa_dtl_evsel)
+				vpa_dtl_evsel = pos;
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
-		return NULL;
-	}
+	if (vpa_dtl_evsel)
+		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
 
-	aux->recording_options = powerpc_vpadtl_recording_options;
-	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
-	aux->info_fill = powerpc_vpadtl_info_fill;
-	aux->free = powerpc_vpadtl_free;
-	aux->reference = powerpc_vpadtl_reference;
-	return aux;
+	return NULL;
 }
diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c b/tools/perf/arch/powerpc/util/vpa-dtl.c
new file mode 100644
index 000000000000..2609b88f61d8
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VPA DTL AUX tracing support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <limits.h>
+#include "../../util/cpumap.h"
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/util.h"
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
+struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *err)
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
+		pr_debug("aux record allocation failed (-ENOMEM)\n");
+		*err = -ENOMEM;
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
index ca809660b9bb..68a780c63204 100644
--- a/tools/perf/util/powerpc-vpadtl.h
+++ b/tools/perf/util/powerpc-vpadtl.h
@@ -20,4 +20,7 @@ struct perf_pmu;
 int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 
+struct evsel;
+struct auxtrace_record;
+struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *err);
 #endif
-- 
2.53.0


