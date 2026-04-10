Return-Path: <linuxppc-dev+bounces-19609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8847DF44869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:39:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsdFg1fRnz2yZ6;
	Fri, 10 Apr 2026 23:39:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775805203;
	cv=none; b=NmMGK+L9dmDurhFi1/oSgalh70Ev4KO73OO2x3/J/Iuj80YdocchzZJRao3MWVPKKvxI/1ksPx/drDuypDVyiurvyVK9s78X91/Atytl06Z0OzWcPNJgfvKzyZCEm3iI4gT6I0v/UmHFAVzZ6NMrDHlWEddUPZ7CTnS/eKVIlmrf6P3MNQALyItWWRujV9P1wFwBaMXhATOct+UslbXdzTTAEvhPKbVg2ugROS4UCi5AjcLLak7NUYLuEdvFDde5/+SBMIfjE50R9MbcmCm4HiRrs1Muu0WFRmKTHXrI9nTz0MEs2zeSEFMqLZIKr7P5R330+fhFdu5y45cd7jQTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775805203; c=relaxed/relaxed;
	bh=2fcaUim6/MoybfQ8XimqaqTgNkIBb7CrmRyV7/b6GTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/yquTe3y6a0QBzUsWevIHgCh6PG4hMApNJFnNSqe11CKhNOHPIYce8xejACEq7v6szqIAqF34GR3sW66svmlTRMgyGGj7lOoptfNAKiQvOIHII111tGtzLXl6u/SXsOJyDrH+rmNHOyXzti3op4tzoUVg6Nr1UBlH/6xEU2nJlD9wSudzMLVPWHbylBZet+7u7GFOYKqu9HzH7L67wXp2wcEc8FHIuu5CeL4rfdkGo0nxCMQyiScA+16QyNOctSqcp4OelzGTDj9xrHuEkv4rFrGSWMYgeTW5gsDCtOlcGgOehwXN7S+S8zQiEXnC2WCwPwTPhAJNiS3dOY1atamg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KVUdhQq0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KVUdhQq0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsSh16VLKz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 17:13:20 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A14A4q2301620;
	Fri, 10 Apr 2026 07:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2fcaUim6/MoybfQ8XimqaqTgNkIBb7CrmRyV7/b6G
	TQ=; b=KVUdhQq0xRNSAyXw7oJKn5V4/OBFYjs6Fekf/ElFvvJFd7uOA/Q6X4J2z
	1LQ63EiIymJd6lKK7soowsYYIDpO6gOgbvM+n3h+zv7ly6Jqh9dbl6++SUhlZk1W
	k9FDcpT7SMjBiLGF5RnPWhAsoQ5EuB//E/v1Bqi5uthne2GAXmQG0KBpUvnf00ym
	fHZDv2Cl4nFsGXWiftn1PtbvKNCwpYVGx0KUjY3gzCOejZeKO1cjUdjIlNKOE5Ko
	8OqKOCdmMgVtc512XM3IGFEHUuDo8xXzsD53xxYTYqeoAXKbbVE+RztFmOP5yG0S
	fbvWpbu8DCcsRRsaECZy3lBqsh31w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2frs19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 07:13:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2qI6I019113;
	Fri, 10 Apr 2026 07:13:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9q06j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 07:13:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A7DAoo27263366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 07:13:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873C820074;
	Fri, 10 Apr 2026 07:13:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0CC220071;
	Fri, 10 Apr 2026 07:13:04 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.24.250])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 07:13:04 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH] perf dso: Fix kallsyms DSO detection with fallback logic
Date: Fri, 10 Apr 2026 12:42:26 +0530
Message-ID: <20260410071225.708005-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2MSBTYWx0ZWRfX9t9DgVmbIq3F
 HOzFSB35kqeFrB+vBN0TrsknWRXDYjFNt1KvedIHWRozZm+LKctWLoBkYahNLoFBSa0o73l828N
 NxN0jbovjzlz004/XOw8bmADLkaJn08gLCITiXP2wllvy5ZhXJBXbSQwq8urtRms4lfxsjmp+0u
 l+Yt9QIiN7CiwG0ybrcUC5dW1vjLNa44A5LJuFop03QeVVASvVxmjzdjMqWGwJd0Amt08r31wRN
 N00Exmf6n9xjUMy2/FEjBefrOqkG83HEAjnqXKNWVAFAZ7P/BzAe/93N6Mm4joRtM/MDhFaDmjL
 19ckjdqW1KybGPCX9SO0TI4rqq0ygqBw6+haXODXGZi+JpDYKoJ93RBxue48pGWmgyZt/Phc316
 NOYF0QkioP4/e5zZGedyQ0VbupNWTGC8FAVKPZDrHeNTj9e5SnaOKCxTO/WxP5G0NaZuIaJIvPT
 02e8COshOGrc6EgsUjg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d8a30b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yWhZYjjtwySg7tuK4IQA:9
X-Proofpoint-ORIG-GUID: D_Os4Ua60O8cnm12uEr9TYfrpFZdvEsQ
X-Proofpoint-GUID: r1Kt42aomKu8hR3vRWt6m2xeZRQ1Kp3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100061

The current kallsyms detection in dso__is_kallsyms() uses the
dso_binary_type enum which fixes the issue of kallsyms being cached in
the build-id cache for out-of-tree modules.

However, during build-id injection in perf record/inject, dso_binary_type
has not been explicitly set yet,so dso__binary_type() returns
DSO_BINARY_TYPE__NOT_FOUND instead of DSO_BINARY_TYPE__KALLSYMS for the
kernel DSO. The current check then fails to identify it as kallsyms,
causing build-id symlinks to not be created in ~/.debug/.build-id/ and
perf archive to fail with "Cannot stat" errors.

Steps to reproduce the issue:
1. rm -rf ~/.debug/.build-id
2. perf record sleep 1
3. perf archive

Fix by falling back to matching long_name against the known kallsyms
strings explicitly when binary_type is not yet set
(== DSO_BINARY_TYPE__NOT_FOUND).

Fixes: ebf0b332732d ("perf dso: fix dso__is_kallsyms() check")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/dso.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ede691e9a249..e44071998c49 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <linux/bitops.h>
+#include <string.h>
 #include "build-id.h"
 #include "debuginfo.h"
 #include "mutex.h"
@@ -20,6 +21,7 @@ struct perf_env;
 
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
+#define DSO__NAME_GUEST_KALLSYMS	"[guest.kernel.kallsyms"
 
 /**
  * enum dso_binary_type - The kind of DSO generally associated with a memory
@@ -915,6 +917,14 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 {
 	enum dso_binary_type bt = dso__binary_type(dso);
 
+	if (bt == DSO_BINARY_TYPE__NOT_FOUND) {
+		return RC_CHK_ACCESS(dso)->kernel &&
+			((strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_KALLSYMS,
+				strlen(DSO__NAME_KALLSYMS)) == 0) ||
+			(strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_GUEST_KALLSYMS,
+				strlen(DSO__NAME_GUEST_KALLSYMS)) == 0));
+	}
+
 	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
 }
 
-- 
2.47.3


