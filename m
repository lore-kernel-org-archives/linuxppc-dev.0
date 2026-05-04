Return-Path: <linuxppc-dev+bounces-20425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E19CD3430
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 15:42:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8QrQ2Kf9z30DX;
	Tue, 05 May 2026 01:42:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777909350;
	cv=none; b=oQLGmFtgtfzzbs9pHULEs2tuG+pECjMFjZ6PGPYYdt8JVBLSMp2ijPS+0T6kDp0yJmGQi402IVeBnuejlWEzkBSC4Xuy8NhG8xakdmG+pK6bu7Fk5arP8xRzR/OWa2CSvkvyuEqEHQo84RDEVvJW0AYiXQ0sA7voE7eyOYsCXDMlkWRYaj3PGW7BNsBkU4fBT8skF7K8/xTd5Do96Wx+diNSEXdasWTEzQyPM/5GCbmGJSV6wkPempEYcNfhfGPF5QJSFz6TLOU7nRxG5T4VT+Uj/H74EXaVYtD/mbIjf41NBy0TkDHoaPbKYPo5WxVZW9fsdIbX8Nckpmz6+J8hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777909350; c=relaxed/relaxed;
	bh=Ydg775CRvfNHlgMYRYXLzfw4p/+tFci3I6hsY/NxtD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kN4uyPH90FObMYGlNwakgSKl2YPkk4Bj1Nb7bl3CfZ0lcRORBiRzy4s9YDXfwjufW6oA4YAsWe7Q4o17Ef6900PYypxvxGuAAkvoiHhPJXm+xB6dTGXokJO88VNIuJynR52nUSS9OKh71fHnQt37FYzByJWme+jAYb60W2DRLhVGavINKhpbrXXA9IgDvgZZfWixMta1woUUYg+9Befqrs9NjfoHbGOB4kPjYHpDoWt3T81JdCGPiIV1oI61KTG/EOHgrnc6znqP6JdgHvuXJBFKTUv1diJpnItQnlwq7XS3XwtMQzXq1SuP8pJ2y8GVzBqk7j9k0Mt8FRO4949urA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nTsvT9Kc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nTsvT9Kc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8QrP1N69z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 01:42:29 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644ALuIj1421455;
	Mon, 4 May 2026 15:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ydg775CRvfNHlgMYR
	YXLzfw4p/+tFci3I6hsY/NxtD4=; b=nTsvT9KceTmbeDFbmv7nGVBbQf1Ae+3+F
	jFAqv+ZvKCvOS0lsFcJagUaaqgBlSQRlnGCRpsBGiUzAeJ6or9jr0ME2elRg/ohx
	OZ3beH4Lb9+WVy+bsAlRn/HGnM+xvEGkw1FbnbqCMzDNiIbjkd3onBFOn0lC2ONw
	dblMJoiMsiwvcofJfS6KgGZaX+h+/hoJZi2yvufmXGRKGDeDW1EjAHDZCMiVCTbJ
	ktTbWxWgW2gi5jUKPdCKWuScX3U7EcREoiZtDgzqpvYmH5RKagJAcg/wIHiQOE7T
	fPaIhOH8dvu/g6cP1eQc95I+ht91/Jsy1Wujt6NR7kK6/pal38rVg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4frb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:42:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsS7T011223;
	Mon, 4 May 2026 15:42:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3gwpqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:42:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FgKZk38601190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:42:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78032004F;
	Mon,  4 May 2026 15:42:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C0E20040;
	Mon,  4 May 2026 15:42:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.208.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:42:14 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V4 2/2] tools/perf: Use scnprintf in buffer offset calculations
Date: Mon,  4 May 2026 21:12:05 +0530
Message-Id: <20260504154205.21394-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260504154205.21394-1-atrajeev@linux.ibm.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NCBTYWx0ZWRfX7X2MAVQGn3EM
 vwg7DRVpu0kWdIYtVr0obnRwG6xAJheelAULAqg9Mn8zQ9TGDjO3mnMfde356FPlL4s2YolQBAI
 sr3c3P2AsNJ9Gee+xfT2pgXDS+1amCcXxMPClCXmpVEZM3Sd/eVwu/DP/F2boJcA8ZojfX6xY0u
 yupVoZhHJRMZRfF4fcs7EcW0sz+VBEqEJaujMCU0/gaRL+6IGlar3gcnsv4HErsaR87caY3+Dp+
 2JrOwGDIfZkhopeeukGNaNgEYDRZPRnSKz7vJ3ZJ2r0VFbhZ5X2CzgkHvcqCGL/hV96FX6UeA51
 mRrTdsJN4lY0KJ7XNjaMG22/k84wdiJAmpX3PfqR7hMyy3wijTQ39X1IE/WvSYYLY2A9AFu1qrG
 RF5nkcp42Co52/CUjBwwjaVzMn1907cgVJRIOPAc3Ku4p1y5uM407ipTDbC2i7y0+cvYm3gNex6
 tykoyWsZMmc7ufth0HA==
X-Proofpoint-ORIG-GUID: LrEMLjhEJ8Rbbaqxm_TS1Vs3Z385R8Bj
X-Proofpoint-GUID: hxumpWhJKi39i5Cyen7QDRApmXZE3Wlj
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f8be61 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1gu-19CejoU7_tioJ5wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040154

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


