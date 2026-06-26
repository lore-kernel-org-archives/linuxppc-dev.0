Return-Path: <linuxppc-dev+bounces-23032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19F4C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 16:11:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gn0zy1NFKz2yYd;
	Sat, 27 Jun 2026 02:11:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782490318;
	cv=none; b=GlYird8hjKhpTyfDytIGHWEE9lPLsKb1VRalF+Ww/uAEF5k2oppt8pZfpxMdDzbddswOnCAsnpT75kWJwb9M1MerlueHaSYce7hXS2x4LDqh0F4WGy2SEohkHWwAb2JgQqMAHjIiT8QBLbFhm7C54GC7RbM+WnlSggoxiuzCkAh/QnqD5lb7uAp5IRBA1gEnoSyXcHYbkDsQXWja3Dz9LsEIkXkoXA2TkAPxSsBp9UMY5RbQqj4Fx9tc0hmu3sR5buyaP3hCGUjTy1MBGWkRPWh/H5XrFuW+TP2ljZ8ytFj9+vbNiSf4f39mUiA+tCUT7xtmgmcc6y2Zsqa7LwIwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782490318; c=relaxed/relaxed;
	bh=EP9eH0oRE4eRM9pYXQuyyzmRq3l/3tg5EKZE6KeM81w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbN0F+2RN2rfAxyfHgenRTGQ+ClTeBOaB0NgZ0cqSh0ExpaFYcXm/yG7OSFsXo8N9a46+UBezLN7uvf5taMyakt6qNis9TXATPBUpYLTFYTc4fOYVDz3s35DNEvSaQGH4bxb5Lw9hwCqc9Nz3RQb7UqrKySDoYgagzsKhQNkJncjT6Y7fDShhY2AYPvkNmd7m+ZOGgfV36sX7VoYOC1dy1Ks2wOsZTfN8Mws19ZyskrsgWEn5WdWJvvJ+hs+KkXbr2Y7drWdWUmydi7FLQ91T5sOTTHKgdjXkGT07gdt9CIsgp7zx5nzm5kfuPGT6fogcBggjjoUCd/FOXNjfyFAcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s8QNz9qb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s8QNz9qb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gn0zw57GSz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 02:11:55 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFnnYh3312102;
	Fri, 26 Jun 2026 16:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EP9eH0oRE4eRM9pYXQuyyzmRq3l/3tg5EKZE6KeM8
	1w=; b=s8QNz9qb241scJe/ztPShoZ5Tu4Emy6yLy3/32F7VA5j62ieCMFLrBA9i
	IDszEw6U3IaTY0VC+lgpm6MGZssLbcU6/vuI0TyJAlUSlAXur8RKPBlmIC5pt2n0
	vrUxoR2R/5aTYf9/ubyw4svshPAnrkGmZswJVhmJ0KjgEuzWTzkEjQ3MTg7jJl4d
	kDQdEpeKhXcAtHMuysihKveNONNF6oBQGDpwaUnj5GLaOtP83X/X80d92fWjISTe
	5rKoitlv6PPQ7qyl33k88dfwh2fZw8RBt7dbT1hh472RcQs6n1FNLSv/8pjhgxtw
	tEN1R0aq2oO+WXJ2zZyw4zKar+d1g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt7cma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 16:11:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QG53jw019219;
	Fri, 26 Jun 2026 16:11:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w03hg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 16:11:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QGBivA27132286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 16:11:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86ADD20043;
	Fri, 26 Jun 2026 16:11:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C0AF20040;
	Fri, 26 Jun 2026 16:11:40 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.221.251])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 16:11:40 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3] perf dso: Fix kallsyms DSO detection with fallback logic
Date: Fri, 26 Jun 2026 21:40:53 +0530
Message-ID: <20260626161052.1024439-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEzMSBTYWx0ZWRfXwU3qr5gqvhsL
 0L2FBSCAsbS4OBuk9HMYrJDUuxWkfBzz2yLyDNA4vPF4ms5P6yznhQblX3DjV6vpH5cdRjvEzbH
 HOB3PPrfIOOtqmH9npKKspAmZ0s0HYqI78lR9l7wt3SvkcfzeM9H1egGW85VT66IsHxGO9E14VR
 hlkeK7VASpdpwvB0mCsHx5bHeLovCS+SVs+RBiT/teJb06s8B7jDUjOH5NGWPspcqnqzOwUBqEH
 T0BRaoRYMWQ+5cpYar1XAlB5AcyfTXUEQA3u5HctxrLxFa1fdGEsrBjLlF7em0/hFrwu4/CPVyH
 SqQxsXwAIMVrHkcNZNfxa0Q58MNeqIhWoQYkYb6NK0TFXaG9GrGwdxZGsYq2DPXWK6D5bp72KYi
 iA83kSQp41OnWxkahrnKHsFwKRC0T6d/AclH5pztNwqlhZRiwc0gCvwKHBEcLb+giYNJ2Yn01go
 NsZJZU3JRsK4iV1LrLw==
X-Proofpoint-GUID: YdKosPuWuGxdbbhI_zyVdQBMCWEFQfxB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEzMSBTYWx0ZWRfXzcZokNkqYf6T
 z3sqJC9qkRAi49WIydSUhi9poWW808eLNUKHSvT/dvw+8n5nvjmPAdR2DfLBJ33yaN1pljoFatH
 8i+NZWo5kpQQem+ecw+UO5sd2/ZltoY=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3ea4c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4ZgrmD5STv3GE8aCXdIA:9
X-Proofpoint-ORIG-GUID: xaxaAKM_F0dEc8ol06I7siiMw_JIhT4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260131

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
(== DSO_BINARY_TYPE__NOT_FOUND). Use strcmp() for exact matching of
fixed names and strict validation for guest kallsyms with embedded PID
to prevent path traversal attacks.

Fixes: ebf0b332732d ("perf dso: fix dso__is_kallsyms() check")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
v2 -> v3: Replace strncmp() prefix matching with strcmp() for fixed
          kallsyms names and add is_guest_kallsyms_pid_name() to
          strictly validate guest kallsyms with PID format, preventing
          path traversal attacks.

v1 -> v2: Rename DSO__NAME_GUEST_KALLSYMS to DSO__PREFIX_GUEST_KALLSYMS
          to reflect that it is a prefix, not a full name.

v1: https://lore.kernel.org/all/20260410071225.708005-2-tshah@linux.ibm.com/

 tools/perf/util/dso.h | 57 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ede691e9a249..8763e6f65316 100644
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
@@ -20,6 +21,40 @@ struct perf_env;
 
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
+#define DSO__NAME_GUEST_KALLSYMS		"[guest.kernel.kallsyms]"
+#define DSO__NAME_GUEST_KALLSYMS_PID_PREFIX	"[guest.kernel.kallsyms."
+
+/*
+ * Validate names of the form "[guest.kernel.kallsyms.<pid>]", where
+ * <pid> is the PID of the guest VM and varies per guest, so it
+ * cannot be matched with strcmp() against a fixed string.
+ *
+ * Every character after the fixed prefix must be a decimal digit,
+ * with ']' immediately terminating the digit run and nothing
+ * following it. This rules out '/', "..", or any other character
+ * being smuggled into the name.
+ */
+static inline bool is_guest_kallsyms_pid_name(const char *name)
+{
+	const size_t prefix_len = sizeof(DSO__NAME_GUEST_KALLSYMS_PID_PREFIX) - 1;
+	size_t digits;
+
+	if (strncmp(name, DSO__NAME_GUEST_KALLSYMS_PID_PREFIX, prefix_len) != 0)
+		return false;
+
+	digits = strspn(name + prefix_len, "0123456789");
+	if (digits == 0)
+		return false;
+
+	/* ']' must terminate the digit run, with nothing trailing it */
+	if (name[prefix_len + digits] != ']')
+		return false;
+
+	if (name[prefix_len + digits + 1] != '\0')
+		return false;
+
+	return true;
+}
 
 /**
  * enum dso_binary_type - The kind of DSO generally associated with a memory
@@ -914,8 +949,28 @@ static inline bool dso__is_kcore(const struct dso *dso)
 static inline bool dso__is_kallsyms(const struct dso *dso)
 {
 	enum dso_binary_type bt = dso__binary_type(dso);
+	const char *name;
+
+	if (bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS)
+		return true;
+
+	if (bt != DSO_BINARY_TYPE__NOT_FOUND)
+		return false;
+
+	if (!RC_CHK_ACCESS(dso)->kernel)
+		return false;
+
+	name = RC_CHK_ACCESS(dso)->long_name;
+	if (!name)
+		return false;
+
+	if (!strcmp(name, DSO__NAME_KALLSYMS))
+		return true;
+
+	if (!strcmp(name, DSO__NAME_GUEST_KALLSYMS))
+		return true;
 
-	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
+	return is_guest_kallsyms_pid_name(name);
 }
 
 bool dso__is_object_file(const struct dso *dso);
-- 
2.47.3


