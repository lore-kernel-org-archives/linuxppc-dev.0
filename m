Return-Path: <linuxppc-dev+bounces-18188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A459F105F7B0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 08:33:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXvl26K0mz2xjb;
	Sat, 14 Mar 2026 19:33:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773477214;
	cv=none; b=WoocNkS0b4CJ2naQrw1NZrZhMHSF6Odu0o91stQZo36cTyxYCfXgHoUhguwOxhxEKRw3KWlaesmCM8WC05SWkjG3t//R/2ZI0xSX6OeXRUMqS7rgOeh0e9/Z+3T63TzIvzWZl75zolG2eGs3nULVRsnLfyrtuDP4qHW8/MnQ5X21AUcsWdR02zaw/ZY5+M9cvLDUDEwqD0ctv9IGTZmUzhQMPGGw/QcD8oyrHoMaLVelbNMN+LGAHGRR7I16dyWBjm/8GmmoFcDnur3a//3jgzkZe3fq5dyrOHsEyuhvDXgdHrOESScmG2vfaJpIjfEhY0WdYJirvUzrOnuT+Y75wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773477214; c=relaxed/relaxed;
	bh=nF1PE8AgQGnQnDvAsWFJ4sv6siulTysshFQpxdqbfcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YD2bTNscAj8DkcLfAFo42dECChaVptSFrHh7BLDzLcpAtd4E7J89Z8r13xN7ntXv7+7JaGKWMf0KM2ZcfwryT77QCEIcWaWOiBoTATnQ/4DbwD+tUB4uDdqjxSt8zBAVHzIWfqZqJrQGdQGHjEWuHtRFxld2AEqiyetmXCLdPrs7kkVz6SOFu6kn+WQYvHzE2a3pbZfqpKxvdQ+Fjkl3GaxzG7NZQtmiSSQ9506Y1lIsi+SHY/FHgnut3N1GHuRCAJ/YiLvBenGfY+4p9gPf3jfrGLfyLacni6Ey4xpAGiZVPTo/fLROBuj/RynWQDWzN7UmGQCG4diK3leUoZvQ9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N6geLIhp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N6geLIhp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXvl15Ms3z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 19:33:33 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E7iseA754979;
	Sat, 14 Mar 2026 08:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nF1PE8AgQGnQnDvAsWFJ4sv6siulTysshFQpxdqbf
	cc=; b=N6geLIhpnp6yKLKaAzNfqac2z59/Q4Xn5Dkf3KeMkfkWptrzRjzdeabt9
	OFNFf9WSiuEN/g+gx5qfVPXhoGWGRmFEZD+TPv+OGr9njEBBzDxnAbLfoXd3e/9W
	KgjMrx8C4ybD3vXUuX5W9wOCslbBq+cphViI2lQdTYNb8pMG9ILGKHMleLBB33sm
	hHlKb6cPgv0QEGuAYc2znAJraG7LelOwtWgh/iDxGjlTEn0Ppp3TkEdqc8VnVhix
	GC8RPDAuv9sDoJConpmKVaBdA9K/SHpu7hoGCTjWv/ZTrQmD7zOCCHzcacHOQHjh
	XWyE3WUkpbiN9QLCFP7FKxLwxqa5A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyd38nvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 08:33:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8GKfA008897;
	Sat, 14 Mar 2026 08:33:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha79uku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 08:33:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62E8XMaN51577144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 08:33:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A50082004B;
	Sat, 14 Mar 2026 08:33:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 518BF20043;
	Sat, 14 Mar 2026 08:33:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Mar 2026 08:33:20 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] tools/perf: Fix the check for parameterized field in event term
Date: Sat, 14 Mar 2026 14:03:04 +0530
Message-Id: <20260314083304.75321-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PbPyRyhd c=1 sm=1 tr=0 ts=69b51d58 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=g2m9RzfYH6J901Z4KtUA:9
X-Proofpoint-ORIG-GUID: BzFO8xnVbHHI98wRi9VjKCzdZ269q4sr
X-Proofpoint-GUID: 82vhkJDgEV5cJOgMEWR7-xTeQ2QQow5O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA2MiBTYWx0ZWRfXyfsrEGIOOmiT
 KwOMXBuvY6QI5xkhRS/IN6FFXrztezFK6UxHmUKnAh8C/1i3b0KzA5bTMm/2SQVQQ3gd75B2ypf
 y1MJf/SEdviPTu6UD86CHo/yYt0THtooNVEJ556HCoaGLCdSWxtaQ0lH9jsIaxyTclbiC+8B4Lm
 vz9nlKYwMHH59Rjm3sky8iw01nUa4e/fFDZE3EAnCj0arzDbe5T93NuCyJLkISTrupU5KjTkX8y
 50/bfd7uCrhVhEoXNM3HJfHuqbp+eRR5AsSYtWvDBWO/33Di9R0Ei9eAniJey+idKNYev7rmhpU
 86xVLNtGEt9VjLJ9AKHv/VM2ggIsYAYEkv983xnMlph7aoylS0SfKgeCpsHAlCaNPVTVPhZZerP
 SMz1UYaJZyIb5PZpLBzzAKnm4H3qUiQrxDLTmw870Ie9JBFaUWqNFTEXIUTjfD1JAHF6lrALGTo
 zYqvCY8o16fimzFz2SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140062

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

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..0b8d58543f17 100644
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
-- 
2.47.3


