Return-Path: <linuxppc-dev+bounces-23816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE96AC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 11:27:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwG5z1fP3z2xpn;
	Wed, 08 Jul 2026 21:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783510039;
	cv=none; b=Oo67HkhIgwtosr1MLEVn21x6t9N09KbtCA/tlTgoEHSOHSa02PYWRey/6P8uAF/1DuHfUr/soHR50CEqW9Ktl53UF6XNTPmuvN9fUhQqfOB1ZKlfuLdFCZfBsXqjW0K/Bd03ur1pD27NRcCFQEO6mZK5GHd7QDgERF3fvAp3RxskT8OFvL9EZnOCNRF89GXRIp8u3RpjqHCb1kR8PX75WS5tBTTbIosCxDvUNGIv5gDBnG48hh9Q9mF/pUTJfIZunk2iz3CRD4AkaSvu0e3qQYT1Mm4xg/JgbRJMQSdNhYAuIHy0KgH2Jsf2qR5Uveg5rpYKWcz1Df6CVw9sZP7OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783510039; c=relaxed/relaxed;
	bh=US75nTdN+etYaSgVnzN+8fi/sOmQj+pjgKNLA3JEgVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUh5km1T9rtWyXctaCGYLy3Ep4WZqHvXuJqRy1FP0jzPjs6m13WRrpWVIhPfTDF2xJSIcvU4zceXlkxujS4MSTaV2jc9syaTQhqK2o289e4EDfnu9WUAa6afAY/krVErPMac1rkldHTuZZCpoqzVU5ir3C5+ZRqbpqi44YNYyXLleG0SoJnTtXzikRIPqakdjKAZdhwhiacuIzzLZLL/uHNe3sbEGUQgeb3+LIltmSg9K6e9bVtUFknaz+xLlZXL82NMWg2d4dUoGLcfYL2ZNOKdP5aFkbChNNIVaNoI1mpuv5hhGpqwhrRmqdT96ian/UVS5T72ArtMDM6g+lvsdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bNf8SA7O; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bNf8SA7O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwG5x6qGHz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 21:27:17 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IorC3244626;
	Wed, 8 Jul 2026 11:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=US75nTdN+etYaSgVnzN+8fi/sOmQj+pjgKNLA3JEg
	Vo=; b=bNf8SA7OXDRTHGeuIBAv2eFmwVAGNwxiBuvR0LIi7nLn1PCAroFd0Vnsu
	j4N63aM9koAQvZaJlP6kGApOQJIT2OceU8cgx7WdVGUPMUzIWAKk3miTwQFBuCmT
	QHX1e7s9Rqb2bGpW1anzysXtHAcTrsI+jhavMcLR3RnmmLsHE8A5jzGPKw9NTtVY
	yajftLb88Yu8+gm5bqqSYWhTQdqJRZ3eM+sGO+DMDFimZQTbSFEErbLtKVb3dLIN
	KUnzhPHAtvoViW5gZDcxO33x86DRW10wkdRhU8vG4BTHnrxpY52ngiU3/e+WtIDT
	KlzXeTJLPLEACU7rEaFpXcFo/p48g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suquubm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 11:27:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668BJfxw022367;
	Wed, 8 Jul 2026 11:27:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg7hwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 11:27:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668BR8M523265652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 11:27:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40022004D;
	Wed,  8 Jul 2026 11:27:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81AC820043;
	Wed,  8 Jul 2026 11:27:03 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.26.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 11:27:03 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4] perf dso: Fix kallsyms DSO detection with fallback logic
Date: Wed,  8 Jul 2026 16:56:08 +0530
Message-ID: <20260708112607.548304-2-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX1Ltt8d7T1xEp
 wML/LdDD+fsP+VCqupM4tgcX1SL4QX84k2E8dAboQGXUMMtmk5p9XW/tgVMz/LdGJHtoJwbafik
 fdg7L48xFBGBPld7s+rvxro2O0vXlQg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX9YIxbzpfCPIK
 5uryo3fMSLp4vcPveWp6KqremUE+DxyJ4AVvjykl8OGOxDjyD9HwKRnknMtAimijxLJKb9Yo+q3
 zJSuh6BSyGX5yVBFmQNQoSSN4sefmZ52ly3NY9ff5fYvXDBrT25WYD3dchuI4Cl/0yIOZZisl3T
 uus/8okm82E+BU6aMTwvJsYgH11rslFee3kUGFs8TKJ3eLuFtNgvbOXt3O4dYSlnHqzHgK+4gcy
 0Q0iihofTlL/4L589JMcyUQK6ooi9XiJO0uU1yoHYCXdt73g94tWKHV55PodMdzHKRng7Tr+PiA
 1hnG25pYwxfeBf+jI0KyQI/prxkEvFf1LUUZZeyJWE6brGU20MBoFP/MrAgdoN1C1y9cDUxjS/O
 e0Teqt1T+N6uYMYKqpmN2gh9Fk0wZTiphybq2Qf1JFQUTmgrsANIgteoD/kuwen/JtQGZG3ZJbN
 tsWR+yoyuli1Ss1E24Q==
X-Proofpoint-GUID: BwwCzI8LaqaWSt9_CyklYFvBYU7aG7v7
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e3412 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4ZgrmD5STv3GE8aCXdIA:9
X-Proofpoint-ORIG-GUID: vgyh-Kprz1pFnwzXW4hvy_kore_AjmYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080110

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
v3 -> v4: Replace direct dso field access with dso__kernel() and
          dso__long_name()
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
index ede691e9a249..c6103d3e3f6f 100644
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
+	if (!dso__kernel(dso))
+		return false;
+
+	name = dso__long_name(dso);
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


