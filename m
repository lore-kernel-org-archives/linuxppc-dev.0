Return-Path: <linuxppc-dev+bounces-20381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD56CD13DA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2026 14:13:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g78yp3h71z30HQ;
	Sun, 03 May 2026 00:13:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777731218;
	cv=none; b=RARGHgdt/8hE9qz3SfGoItrSKjKgILe9AqvCKmjznqWD32EBEp4FgcTdZ8eoQ7K3nYSxpKNBCjTA/0HwpwuV3CkEYXitr7v/9bcAwjGLpwSGZdvO4VVJ9FhKqJ7M/RIS8sxgktYnTCjcP0smDDnmRmyKIKDYNVMUZhI2NF84lPf04drXQO3au1/CsQuQOdEQqVSK92snB8CDPUbdymC6PQ2ANa9pgFe9Ep+zNC7rFt7Skr7d0XxfuOGbFzErvBo9sC9jMwJYD3F/HsHe3IvF3EouP8dWZXUb+0M3oNqRT2BGtRxDssOEdtR+BpGNZG2eXEZ0l0rvkngQ6OHGOvzHng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777731218; c=relaxed/relaxed;
	bh=Ydg775CRvfNHlgMYRYXLzfw4p/+tFci3I6hsY/NxtD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iq1k02tXVRX7mpgGarOOdyp9E/t4quIDSrfIWDdIVSCRhk7DuXUb25VXdcAv/C9+GbfEI2a91qZXKw5kpEfVNY5UNjOkqBO9wdCzW58IQQjI+vZmCNLeAUBX9hLeeuhxAdcxw0HVX4JajkE0e1eZn1acQzxW8P2aGb0mzy5sLAVTonYA2/8i50f+w440j493sYY7MjOktUszw1U3HP6+Ysteo0ZXtZu890Emp4sVOVNDG3oXAcc62oa07qVMbm0Zx18effeH0vdi04kgN8Ga8+lcYQAouH/C7UYkTlgW/S4mbgFSqe82W5REuI1KEUQnC5nK87z2UjrWYafz+Dlpxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mjND4II5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mjND4II5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g78ym6YR7z2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 00:13:36 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6424566H1990705;
	Sat, 2 May 2026 14:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ydg775CRvfNHlgMYR
	YXLzfw4p/+tFci3I6hsY/NxtD4=; b=mjND4II5B9nRXhKcGHb2yjx+8b3PriXx3
	KmlZEHqPsdSBnhkSARQtagZ2YnTqBT8uo34CrLBoVbWc8T8w3aRf3A5+peEBpVKt
	zemhaNcfiZXnrfRcajqXxBV/1T9SZFd22d2Ob/+4OE1C+Ehphh6iluoh6VS3CfDd
	UxVYebdu98JLE7yO/x5zugjrnyMxMc8ZbTm06+eqGpNuDrwAJuB1KOn8r8CRWyNO
	8gGgFdPm9K/NK5ZIGpSciB1dEoGeMAcnIT5Kh2ksZP81Xspk5Ar0rhr17etOeeMA
	8QRTIA+4TCvn87BVMcQizxYGWDJudJpgeFnPFaMzkSaypSql1VFrQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x495rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:13:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642E9gqu010896;
	Sat, 2 May 2026 14:13:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dw9jy9bum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:13:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642EDL8117236244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 14:13:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7E6320040;
	Sat,  2 May 2026 14:13:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66432004B;
	Sat,  2 May 2026 14:13:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.37])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 14:13:16 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V3 2/2] tools/perf: Use scnprintf in buffer offset calculations
Date: Sat,  2 May 2026 19:42:58 +0530
Message-Id: <20260502141258.17128-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260502141258.17128-1-atrajeev@linux.ibm.com>
References: <20260502141258.17128-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDE0MSBTYWx0ZWRfX0Ru1a0ga3SNJ
 dBeHR7dNkSVPP7yXyONN/vi6ZlcNJgpVkMwKaJYKByzwi6lkPbWqxaBH3Aju7T7/5LTNVlyZOlh
 4X1USjaNtKousDsFDsV2E1aT7+Dvfs+jJ8tW7/0nLp6NdchzGEmAwJFHxbVvbjcmSSGWk/n3u/m
 76/odiGD469ByG4OFEtUJT5SoQe9drkYEhilVjd66/ePV/pZ+fG4k3eATyYSR6SCg/wifxqJw8W
 v38A2tdnq0y0GRFP16MlIucayPlUi1b6A6uPU4VKULkOl7pJG3+omLZqX5L9eXYX5m3V0M5rbI9
 b5rhh1l/9Rky9T7t5ji2bT91SieZ9xgNvs1z7PunWte2aXMH8IDSMTgzNrNI32i5ZnXrt1+1vut
 XCtamtQvUUtOhrdqSraPW25TjmN5K/8nWVvHQZLNX7a7V6D18Nh6AOE8H1D0dm4E4zGJ3T6SZUj
 1xknzi1Dm+rWvEX14pQ==
X-Proofpoint-ORIG-GUID: UKA1UlRdJkrQLMPjIjxI8tweLa9BSsOZ
X-Proofpoint-GUID: H8sXf3Z08zzM0dWGTgu9tVuBoJ0Hds9k
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f60686 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1gu-19CejoU7_tioJ5wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020141

Replace snprintf with scnprintf in buffer offset calculations to
ensure the 'used' count will not exceed the "len".

The current logic in perf_pmu__for_each_event uses an unconditional
+ 1 increment to buf_used to account for null terminators. This can
cause a a stack buffer overflow in the subsequent scnprintf call.
When the local stack buffer buf (1024 bytes) is full, buf_used can
reach 1025. This causes the subsequent remaining space calculation
sizeof(buf) - buf_used to underflow.

Use sub_non_neg() to see if space actually existed, and only
increment the offset if remaning space is present.

Changes includes:
- Use sub_non_neg to check if space exists
- Replacing snprintf with scnprintf to ensure the return value
reflects the actual bytes written into the buffer.
- Only increment buf_used by 1 if space exists
- If a parameterized event uses a built-in perf keyword for its
parameter name (eg, config=?), the lexer parses it as a predefined
term token, which sets term->config to NULL. Add check to use
parse_events__term_type_str() if term->config is NULL.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v2 -> v3:
- Split the scnprintf related changes in separate patch
- Handle the overflow issues and unconditional increment
wrapped around sub_non_neg addressing review comment from Sashiko

 tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0b8d58543f17..4b9ade1a4cf9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 		pr_err("Failure to parse '%s' terms '%s': %d\n",
 			alias->name, alias->terms, ret);
 		parse_events_terms__exit(&terms);
-		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
+		scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
 	}
-	used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
+	used = scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &terms.terms, list) {
+		const char *name = term->config;
+
+		if (!name)
+			name = parse_events__term_type_str(term->type_term);
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
-			used += snprintf(buf + used, sub_non_neg(len, used),
-					",%s=%s", term->config,
+			used += scnprintf(buf + used, sub_non_neg(len, used),
+					",%s=%s", name,
 					term->val.str);
 	}
 	parse_events_terms__exit(&terms);
@@ -2201,6 +2205,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	int ret = 0;
 	struct hashmap_entry *entry;
 	size_t bkt;
+	size_t size_rem, len;
 
 	if (perf_pmu__is_tracepoint(pmu))
 		return tp_pmu__for_each_event(pmu, state, cb);
@@ -2234,17 +2239,36 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 			}
 			buf_used = strlen(buf) + 1;
 		}
+
 		info.scale_unit = NULL;
 		if (strlen(event->unit) || event->scale != 1.0) {
-			info.scale_unit = buf + buf_used;
-			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-					"%G%s", event->scale, event->unit) + 1;
+			/* Check the remaining space */
+			size_rem = sub_non_neg(sizeof(buf), buf_used);
+
+			if (size_rem > 0) {
+				info.scale_unit = buf + buf_used;
+				len = scnprintf(buf + buf_used, size_rem, "%G%s",
+						event->scale, event->unit);
+				/*
+				 * Increment buf_used by 1 only if
+				 * it fits remaining space
+				 */
+				buf_used += min(len + 1, size_rem);
+			}
 		}
 		info.desc = event->desc;
 		info.long_desc = event->long_desc;
-		info.encoding_desc = buf + buf_used;
-		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
+		info.encoding_desc = NULL;
+
+		/* Check the remaining space */
+		size_rem = sub_non_neg(sizeof(buf), buf_used);
+		if (size_rem > 0) {
+			info.encoding_desc = buf + buf_used;
+			len = scnprintf(buf + buf_used, size_rem, "%.*s/%s/",
+					(int)pmu_name_len, info.pmu_name, event->terms);
+			buf_used += min(len + 1, size_rem);
+		}
+
 		info.str = event->terms;
 		info.topic = event->topic;
 		info.deprecated = perf_pmu_alias__check_deprecated(pmu, event);
@@ -2254,7 +2278,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	}
 	if (pmu->selectable) {
 		info.name = buf;
-		snprintf(buf, sizeof(buf), "%s//", pmu->name);
+		scnprintf(buf, sizeof(buf), "%s//", pmu->name);
 		info.alias = NULL;
 		info.scale_unit = NULL;
 		info.desc = NULL;
-- 
2.47.3


