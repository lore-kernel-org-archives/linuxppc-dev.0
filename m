Return-Path: <linuxppc-dev+bounces-23287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EE2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtm64Dntz2ypW;
	Wed, 01 Jul 2026 18:41:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895302;
	cv=none; b=JOqPWG/oNvcXdIz9wlUpbP2u3nnH/u9EAHHhrvDFKslRzl0SKaaVLDVDXqwVSR3vUIXoJNvokne4jszk3dWszEP2fxKWwpUr8Pi/w0HNG76Y+vsCUz+HRNvSrAc7QByjJA5nVVHCsD8PbH/Jfrk3mL9JunKxdfZe0Z9/w7M19v5IHzD6JNnUs74NtasIryiLxuSsbOG6hlviJ9Ng+CDgBsxyIhI95NMFdr7kMgd5C8/Li6dHq4OiEYDGZEhCPgerVlVAYxs0+zmd1upF9l6z9xiyCbfP6RUJxvbIJ+T8DwDlprUKzRVokfEDwNLiLdXZmKt1psWX7HZjMyUKmeU2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895302; c=relaxed/relaxed;
	bh=kvZlMn4rZaVp36t21vzEKO1NCyWCiwC3LCFGrRln290=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BC9GTFjd+GOOHHmKz7PDypCDuspa9Ma6ux5bCfM4nziwqPQbOt3iJFz1iJ3fde8hKYH4dLS011omRycdvBsSWX9U96uJbTZ+kQGIn22iB649CdPgt5v+bv7dRAMqPIHNhavQp/PuS0BMN8qPEsq25iiWNtZcP3qk+8QsdkT9a7w7U6CJJvNW3o3D+MQLebVDx2X7P0bJSGz/B3lSnqcYfR3REHarm/TPW3eOyTf/64sSWlmdePHCk/xp8sTzVzhhYtNscXniHz2ErUiO3ndkJDqMyA9OWJ7t1FZwj7AKAWpmi/uecyYYMr0ptuN4sDuj7FHKCESDRD57mBvWkC8udw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gUDkoGhf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gUDkoGhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtm56YY5z2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:41 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IYTu494258;
	Wed, 1 Jul 2026 08:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kvZlMn4rZaVp36t21
	vzEKO1NCyWCiwC3LCFGrRln290=; b=gUDkoGhfWdhfCYPqSWnZ3ohsIpZI0bT/F
	GC9ppdhdHomRbivAM9J18yYlYJMClkmJwm0MeOOJzJAEZ+BqCZyFnwf3AufmabJd
	EbQfDCVJVEUypegzPUYu0z19PwInPsACMcJJZy2pa0MXetG2utGRHp7COR7arIp7
	zvQNFcvKx47HDF9CimQQAd6g3sHkt94eEIlcgRz26icVGpdph1zTDi4xQa2HPevE
	tZed46CwVzZLj0uKV1z0IcALp6AUq1CDx4ysz8LaHWOQr71V+qXLUCBBytFchGuu
	kqI6QBFbF2mzPmHBNtQcCQmc+NjXd3yukYWfi49ICObCrFOLQ3Gig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg3dun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Ygpp017220;
	Wed, 1 Jul 2026 08:41:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqemm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fXou17105256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A145C2004D;
	Wed,  1 Jul 2026 08:41:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3921320040;
	Wed,  1 Jul 2026 08:41:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:29 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 3/9] tools/perf: Add arch_record__collect_final_data to collect additional data before closing the event
Date: Wed,  1 Jul 2026 14:11:09 +0530
Message-Id: <20260701084115.80383-4-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44d2c2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sb3nUQvwxnNj9nUj:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=F6ByAQr1qBnV1AZuj3sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX7T3y7lzge7FL
 yfyiGmrEpPmTnGZOMLbVsPvUKQb73pZRT6rFOQVWOsrcYQghAVpmlibh6lYQsUXj3V1+jY1eh1l
 MQPKI3E/Hsn9ijsLszRK8MhTQQB8N8w=
X-Proofpoint-GUID: 7sr244_UB0tq2qH1RyDamFUPH0OTPpZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX0dakx9VTucRI
 YF+FiZbZrp2BGqfbzmGpB619HjwbRktfoOAhEqUJmppkkHlogynZtC0lIBxeTCkP/gmWmD6P8Iy
 mw06n9Igwb8JRQVJylnruCdtVDzLbQmtG8uGuo5/kQ+d/T0fwAq2Qflxv6Jxhj+gMqi1vnAsK3a
 v4iyfA+bGT4+X6z35YIQZ/5tC1VbSqNZkJgHs65y/RvJU6A9FDZkY785hxe8DOCDU6URiKflCxO
 +5QU98Fv2SGd40nJTDCf8ybmDaAZ87x691PonmjPse91D0w2RV9bRTwrfVBhSHFJrV6/s7evLq/
 Q9kptexiGqELQPhG2GU3ajwUy/6sc6taprcGLhxs7CtT9gnd5wplgR++2npolzBKxfCmLzthqPC
 +7P7hNM2UNdXVBaIhQ7OSBAAUd0YeKRajNYG7FCN5oFq0WJjsF9ATsy4cOhnYXjY2Fl2/6rpN6U
 PvLkO1PNbClr8jN0m4g==
X-Proofpoint-ORIG-GUID: CQYinWCQlfoInPmJXrDD-FkZeddi93es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

While collecting samples using "perf record", function
"__cmd_record" checks if monitoring is done. Once recording
is done, event list will be disabled using "evlist__disable".
After this, event fd won't be read and event will be removed.

Before removing the event, if any additional data needs
to be captured/written to perf.data, currently its not
possible. Introduce arch_record__collect_final_data to
collect additional data before closing the event

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/builtin-record.c | 29 +++++++++++++++++++++++++++++
 tools/perf/util/record.h    |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ebd3ed0c9b3e..1312f7223455 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2426,6 +2426,34 @@ static unsigned long record__waking(struct record *rec)
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
+	/*
+	 * Collect any remaining architecture-specific data.
+	 * The arch code checks if more data exists, and we do the actual
+	 * reading here since we have access to record__mmap_read_all().
+	 */
+	while (arch_perf_record__need_read(rec->evlist)) {
+		if (record__mmap_read_all(rec, false) < 0)
+			break;
+		/* Re-enable events for next batch */
+		evlist__enable(rec->evlist);
+	}
+
+	return;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -2853,6 +2881,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
+			record__final_data(rec);
 			evlist__disable(rec->evlist);
 			disabled = true;
 		}
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..21f51efd36fc 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -8,6 +8,8 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include "util/target.h"
+#include "util/evlist.h"
+#include "util/util.h"
 
 struct option;
 
@@ -95,4 +97,6 @@ static inline bool record_opts__no_switch_events(const struct record_opts *opts)
 	return opts->record_switch_events_set && !opts->record_switch_events;
 }
 
+int arch_perf_record__need_read(struct evlist *evlist);
+
 #endif // _PERF_RECORD_H
-- 
2.52.0


