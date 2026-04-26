Return-Path: <linuxppc-dev+bounces-20104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97BFFF885E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3K010W9Gz2yhP;
	Sun, 26 Apr 2026 18:01:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777190481;
	cv=none; b=kz+bnJF2PSD4uQqWiSVhdO0v4b6r7TLysgpPTXNlWYpLhOdV5UDp12fa9Y93dhKAbmrfxraMbaV6j8VhOTYzazd2t3Mc0E2dTJFZ5zpviV+45ykImZ4ZJARUAmxxE4+ONge9lx0JScB1CiPct+KwuiGHG1RdWeCvDWQPCYWUFhSMsfoOZ7v9JiqblzUQjEqh0qDyqSTSDqi4iElT2AHkH67sQFpVD5W/gkygAN+Q3SnltjUGPewnBOPuzIe3+EcZakv9xF9ES/Tg6Hn6R64/7Ii4BXKz8nTELK9fDEONOX/NdiTi/KXe0qJ/mAXkAI//r2i7LJLjiBVsPeX+5P5T9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777190481; c=relaxed/relaxed;
	bh=JuVyF6PxycQPFwSUxIOPDTHyHWo+BkLkQpJUxESNAIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjPajQDZrDmtF0iF7d1T5WlLadXjpZQZau20igLLiaS+ASa3dX1n320YhDdW4Uk7nQRoM0KhgVfMgbPTd69kIkp7rKCs4X5MUzugsltbRa4ovQ/z95bWsu/v7xccfFdW6aIeumcynxhMl1I9fCk52WJq6D2IOkhuvej/NWZRVtA+rNNIRNLOu3GDTLIGpFAQHL+y9vFEwXkELCHR03F0Nc90eRSLp6atMs/fmZfxIZadn9RFYGBwKg2WWly6zwktz5XEgNfTYD6vlFyXxtbeSVaadgoXgWVKJkTXm3StAO+zYl92R7eQ2714LMMurzOsXKp1WshxcGo87MEDOiBm2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DmQWFcdv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DmQWFcdv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Jzw3Q0pz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:01:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q2NWT6410288;
	Sun, 26 Apr 2026 08:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JuVyF6PxycQPFwSUxIOPDTHyHWo+BkLkQpJUxESNA
	Io=; b=DmQWFcdvBmAx8pZAfxyb9aS+l4BNV66dScdZhHaMU2P3izI4BMaPHpUOS
	Kn3t650uWzXimQT9/cKAKRG7FtHphcVQQIIJVicX9OlIzhvJhONqP/KM1goUCxAa
	+GXxtENhyL3wEd3t2dGzaN53AAZIaUk286yrhpe4f3bgSHKyKEiX7tZ27cPaiT/1
	oFub1cIafn7AQQ3Nk4EznIZu7+NMpNQqC9StQjeZaUaAr13A9fu7gh5blPm+Evrk
	4KDbzKWIF0WlKM4KgVI524Hd7TcB6N+3Jr06jpeHYSSxl2Y6hZOI2PEppuSGisWw
	xEQCyLRghTrr/E423pvWAMwYn2RtQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v3e1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 08:01:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63Q7s1b6028239;
	Sun, 26 Apr 2026 08:01:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xjrtg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 08:01:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63Q815oD46989810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Apr 2026 08:01:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E37692004B;
	Sun, 26 Apr 2026 08:01:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A880A20043;
	Sun, 26 Apr 2026 08:00:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.109])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Apr 2026 08:00:59 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH V3] tools/perf: Fix the check for parameterized field in event term
Date: Sun, 26 Apr 2026 13:30:56 +0530
Message-Id: <20260426080056.16558-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69edc645 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=FQl2jcZq-z-9k4ZDHbEA:9
X-Proofpoint-ORIG-GUID: lNXlQ2n2XLBM1UCil7_SNIWDM-oYPSCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDA4MSBTYWx0ZWRfX3DVSoX7Tt3JM
 wRI9khH1B446Ahxjl4vvumIkLA0IHr7bCT0xQ2eL4ql+9UmRS/DzVgv7qgmXa5YvOzxNJ+jnhhn
 S3EhTKYPKaaStfr1JudL1RiAfZT1OGNdNyoNGBFDEXw7r+hRT/F0xrdZhIoMIQujDuDxsyjr2sq
 Pl0GSM/jOYN24MfynSngbRFwAKcx9naaL4Jwq4ylr+zK2XcObk3TqkF2joytNQof361hjueJztR
 i5koha7ZKjztqZcrAVHBYs/sZQvxyGVwBn8rL0i/03BaNhJcff7T+CSuwSazdIp4j26Ta6AxVNb
 1PzwJvb+8OJwCi3JKL1gSOykOpN4rQj6PaYcaWy8eed8qfls9j2HEg6ruhILZQQ0qG3Lh6TYWv4
 7+oKBt1JPgcSvFgXbwyBTeQIK3Y0NUtewyvNXWtl5l1xKhmFfaiTmqfYjboG3+DN4vNL53c97f3
 Z5xgStA8UgRHgj1r6BA==
X-Proofpoint-GUID: ZgYgzs-vG_k9QRn0Dxo670ZD2DsynqCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604260081

The format_alias() function in util/pmu.c has a check to
detect whether the event has parameterized field ( =? ).
The string alias->terms contains the event and if the event
has user configurable parameter, there will be presence of
sub string "=?" in the alias->terms.

Snippet of code:

 /* Paramemterized events have the parameters shown. */
       if (strstr(alias->terms, "=?")) {
               /* No parameters. */
               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);

if "strstr" contains the substring, it returns a pointer
and hence enters the above check which is not the expected
check. And hence "perf list" doesn't have the parameterized
fields in the result.

Fix this check to use:

if (!strstr(alias->terms, "=?")) {

With this change, perf list shows the events correctly with
the strings showing parameters.

Other changes in this patch:
- Replace snprintf with scnprintf in buffer offset calculations to
ensure the 'used' count will not exceed the "len"
- If a parameterized event uses a built-in perf keyword for its
parameter name (eg, config=?), the lexer parses it as a predefined
term token, which sets term->config to NULL. Add check to use
parse_events__term_type_str() if term->config is NULL

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v2 -> v3:
After review from Sashiko, added below changes:
- Corrected commit message to say "strstr" which was previously
added as "str_ends_with".
- Updated snprintf with scnprintf in perf_pmu__for_each_event()
as well.
v1 -> v2:
After review from Sashiko, added below changes:
- Replace snprintf with scnprintf in buffer offset calculations to
ensure the 'used' count will not exceed the "len"
- If a parameterized event uses a built-in perf keyword for its
parameter name (eg, config=?), the lexer parses it as a predefined
term token, which sets term->config to NULL. Add check to use
parse_events__term_type_str() if term->config is NULL

 tools/perf/util/pmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..ca0ceb0623ca 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 						   skip_duplicate_pmus);
 
 	/* Paramemterized events have the parameters shown. */
-	if (strstr(alias->terms, "=?")) {
+	if (!strstr(alias->terms, "=?")) {
 		/* No parameters. */
 		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
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
@@ -2237,13 +2241,13 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.scale_unit = NULL;
 		if (strlen(event->unit) || event->scale != 1.0) {
 			info.scale_unit = buf + buf_used;
-			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
+			buf_used += scnprintf(buf + buf_used, sizeof(buf) - buf_used,
 					"%G%s", event->scale, event->unit) + 1;
 		}
 		info.desc = event->desc;
 		info.long_desc = event->long_desc;
 		info.encoding_desc = buf + buf_used;
-		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
+		buf_used += scnprintf(buf + buf_used, sizeof(buf) - buf_used,
 				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
 		info.str = event->terms;
 		info.topic = event->topic;
@@ -2254,7 +2258,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
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


