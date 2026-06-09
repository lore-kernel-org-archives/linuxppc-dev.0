Return-Path: <linuxppc-dev+bounces-22343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5444ACD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:44:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVW01kbrz2ySf;
	Tue, 09 Jun 2026 23:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781012636;
	cv=none; b=ak+p2KWowLhNqdaGnXBnFCmufCeA9Uuomkj9s1UOPg3dZ8mcIEtp+oJvjQI4SGwXQpTLqeUCKk9NIShu5YcE5kg2CoIlYZ61Pl/lZcaoG0zsdLeguFm1F7ex2D7cWDwo1PGafq2o+ulSvvdzv0moX1BWMfyPm9CMwACRN7R8BVskXbHbSwOBC8GL2lSvrAqWv/b4dVbzRhKj/0A8gmYbIAABbHCpmaPHXheBLJo79Rc1ADSABRRFPuh8oK4oIxRFG3PfYzqxUCvJIIIckaCVxqgIVmoeuJUrEOP/MX3O+S9VRFP1+rMgh1mbTtFywwseEMDNBlU7nMKCQas7S0tbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781012636; c=relaxed/relaxed;
	bh=n5wdM0/zC/cVn6lHUiSP2g6mJ+f9fXS6xsLZ/DmTrgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asvBv8n9qLXaaEuQGO7trry8LjngGGU1Mh9xevVXzHETKoK7e2xhZyEQTIZIBs0EssKXsyamTcwdNViQuzq7zKMynjm42eM40fwx+znea9BMn+6PzL+GJ5m1akuDXYFjMcBOBs81aHF8m8d4Ww75wPa3JRVcw252T4muPfEv3+0aynMHVmf4rNjcB4zCIJCYEid3PuqMkwhpsS/eYP7WL4FEnoeY4Taqta6IdGcRzcZ9BdbltXtRfQ99td8PbDUCY5+6kMk1la/QMuWSjIxM3v5vZbUyfF5/eZ2XVB8WKNte/1FDJEAqyCLM76Npu+uYoC89DJaI/lmfANVUyIwucA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AfKj6YSp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AfKj6YSp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZVVz0jcZz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:43:54 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659D9Ub22767293;
	Tue, 9 Jun 2026 13:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n5wdM0/zC/cVn6lHU
	iSP2g6mJ+f9fXS6xsLZ/DmTrgo=; b=AfKj6YSp2hU2DPdIYAXNlw0szxZqRTTw8
	TBNSEjgzYO0ugtEnfwPCrOhIVpSoAbnwzv8ceA5Sc6oyq1xpwkU1odW37m8IHvFc
	FW+vLgEk6n6DohRQTrDZXbaX93EsMuN+1X4yPxMOQEmC4vKizXcVRnDll+zAdxdR
	3w1iEflgUg21wva0Yc4cdYph1W+xL1SIUMfvfO9ITKgDKGC29WEogZja2sDSugbE
	giFMVJarI959o6e3OEMG+P2bpvDhNNA8wtMIKmqNXBUExM1iByZN9o0NJbIw8/Kx
	DoDeCVq1aNtI8RFOz9ZAiKtiR0Z7smNqv8ZhgyRzFY4mdmobz/j9Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23vf12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:43:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DYcgr016085;
	Tue, 9 Jun 2026 13:43:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych24es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:43:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DhkXs18219368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:43:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF98F2004B;
	Tue,  9 Jun 2026 13:43:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F6820043;
	Tue,  9 Jun 2026 13:43:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:43:41 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        venkat88@linux.ibm.com
Subject: [PATCH V5 2/2] tools/perf: Use scnprintf in buffer offset calculations
Date: Tue,  9 Jun 2026 19:13:32 +0530
Message-Id: <20260609134332.97954-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260609134332.97954-1-atrajeev@linux.ibm.com>
References: <20260609134332.97954-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a281897 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=WyRFSl7gUU5P16mftmoA:9
X-Proofpoint-ORIG-GUID: e4xnjBYQmxAmkGcDwiyNijty783hbBsO
X-Proofpoint-GUID: ZZRcWtHt6qDAS8jksY030hSmBd92NL8k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyOSBTYWx0ZWRfX+ojTLPxOzVYL
 s9t4yJUhukOIdoM1IrISxnjBIussJTEAkHh8Ald2dU54iQB3SeKcEQ4nJkZfapI23223I6cf/pE
 IceV4YMAzoj05TPyFq5EO0Z++EqVYK8PLa802ID8G5SPOgcTF55JCVh48buHYDh7+MPUToFECXY
 b3IxuZhldsYXsv5A6ZQtJqReqTbovkxFDwfODOA6VPpGtHPVXnUV6gUClQCGF9KFIf999ldnMRV
 NA87qWwLUTaDquhXHvFOBRli4hmKSxpgIZX3xX/8DYRQu7kjtQ5ZtexnpM/aa6Ui8xipk5ogFu9
 hpmMQ9jih53xlnnDsa+7PSefvSaczzQ/rBXBnqSMMyDTPn/S3cechk8Rim6JDkuEpna5MaZq3aj
 RFYHtAmhXNT78mv6AQfdjJWh44wkvrgOkf2Qe6SReZYCSIyILcEhAqEOQ+JEyNS9VVxKXGe5dpN
 dP3XLsYkar/TO8sihVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090129

Replace snprintf with scnprintf in buffer offset calculations to
ensure the 'used' count will not exceed the "len".

The current logic in perf_pmu__for_each_event uses an unconditional
+ 1 increment to buf_used to account for null terminators. This can
cause a stack buffer overflow in the subsequent scnprintf call.
When the local stack buffer buf (1024 bytes) is full, buf_used can
reach 1025. This causes the subsequent remaining space calculation
sizeof(buf) - buf_used to underflow.

Use sub_non_neg() to see if space actually existed, and only
increment the offset if remaining space is present.

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
v4 -> v5:
Addressed review comment from Namhyung in buf_used variable
to use return from scnprintf since cannot return a number
greater than or equal to argument

v2 -> v3:
- Split the scnprintf related changes in separate patch
- Handle the overflow issues and unconditional increment
wrapped around sub_non_neg addressing review comment from Sashiko

 tools/perf/util/pmu.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e765a7ffb0d6..1539960ba23b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2146,15 +2146,19 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
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
@@ -2218,6 +2222,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	int ret = 0;
 	struct hashmap_entry *entry;
 	size_t bkt;
+	size_t size_rem;
 
 	if (perf_pmu__is_tracepoint(pmu))
 		return tp_pmu__for_each_event(pmu, state, cb);
@@ -2251,17 +2256,30 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
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
+				buf_used += scnprintf(buf + buf_used, size_rem, "%G%s",
+						event->scale, event->unit) + 1;
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
+			buf_used += scnprintf(buf + buf_used, size_rem, "%.*s/%s/",
+					(int)pmu_name_len, info.pmu_name, event->terms) + 1;
+		}
+
 		info.str = event->terms;
 		info.topic = event->topic;
 		info.deprecated = perf_pmu_alias__check_deprecated(pmu, event);
@@ -2271,7 +2289,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	}
 	if (pmu->selectable) {
 		info.name = buf;
-		snprintf(buf, sizeof(buf), "%s//", pmu->name);
+		scnprintf(buf, sizeof(buf), "%s//", pmu->name);
 		info.alias = NULL;
 		info.scale_unit = NULL;
 		info.desc = NULL;
-- 
2.52.0


