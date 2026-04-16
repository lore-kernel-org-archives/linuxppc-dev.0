Return-Path: <linuxppc-dev+bounces-19784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F2FF8A149
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 09:17:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxC8n0LS9z2yhP;
	Thu, 16 Apr 2026 19:17:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776331064;
	cv=none; b=PlyTKmYCKyQhkiqf3ND5yelJ6iiwmpWdrZeBwLF9viWUOwgU8nSLFIkpR9aOPPZQdI771OuCJSjP7pcU5sXAxOgA1fTPL6eoTf6Y53801RLAEnaCBpgqSdDVtRHM20cFcqCiHuKDauLyExZlQavUdn+Xlw3NwlJCVM8iTiqz81yJ8zh+uVL4gyP6VSkrYvPhTPdhE2Ietdirh8l8dIwQzGu+OjT1P8U8djIXMK+hvRxqPqoEdBEFIYtjK2FYPyId5OU9E7tq48RaI6epOER6dpRr07bonskJXUuoHIrWY7pUlUvDijP18TPbGdjtTY5NzFz+tiWSB9To5vA7IWIE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776331064; c=relaxed/relaxed;
	bh=iiV5yqTbaPN6Xrrcd1k3uK+twUyapf5QAUCtATSoeNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGiCyCo0Gg0jKsRh2aDneJllNuxPlGV5L8V91bk9ffzV28oQRmsfem2Y6xqKHVbZIFKqQqxH6lHMqcnz/OL1grcDDm90KUrpeexRGUMmBuEcSOciiClCYYV5XlmajXOShZ5hOiA6QUpMDUd3Y93dvSJNQc4v1jgSk2Xi2di2SQA8TwvcRjjCeB5baxdKuL+m8EA3EouJM1svC9zLST7fWR7XuOaPH5JLw7Mor7TVg6iLbbbAV1pZQq7QkN6wUMefyPlNK1xozJ7U2GHlzx2rkCrhmFqHOtRGH08QjVZdZBhPZqCltj95N6CkG8YwYcjGkEJs2r5tOapdMrCNC9ju6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iP5+PhAh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iP5+PhAh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxC8l2jYxz2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 19:17:42 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6dSHT1842719;
	Thu, 16 Apr 2026 09:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iiV5yqTbaPN6Xrrcd1k3uK+twUyapf5QAUCtATSoe
	Ns=; b=iP5+PhAhiaOnhl+10GOJK8lqxlk9F+m37aTCgjQFcyNfTGhj/PZSUJZZ2
	IPO731ab/A2gX93IkzQXFhyjPitv2C3pDA5o3bDhQnY5FlLT2Iqn0hDFNz8xAPhH
	QTalre9/rbna93zXp1T/n77RzaM65jQZdgChvrgi1vgkS2ZBMjVqjtrU+RgxsSia
	p2gYBfooeFznRR/Q/eN49SCiirbKVGCrfcYrP0411vizYKC4lsm5ZylxdO12rnO7
	aMQzqMkn/9Kuwl0osl0Y8/RgFkQk/Ucg+8y+VoZl/Sga6mQci3mBzg1XmKrSgYad
	mPXgWIlCBlZf5JBcURIMmiGh3eThQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mvmd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 09:17:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G8RcRJ025837;
	Thu, 16 Apr 2026 09:17:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujt129-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 09:17:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G9HWc155247318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 09:17:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E5F32004B;
	Thu, 16 Apr 2026 09:17:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38D0520040;
	Thu, 16 Apr 2026 09:17:28 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.216.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 09:17:28 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v2] perf dso: Fix kallsyms DSO detection with fallback logic
Date: Thu, 16 Apr 2026 14:46:58 +0530
Message-ID: <20260416091657.578429-2-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4NyBTYWx0ZWRfX1DAW9Hwf7yvG
 SIFF9yrBiEMaUypcnR52JMZG8ap5aeB6HV0rOj1b8eneOURx9xLP3X11nh0ab2bEEWckG/u7sJ6
 cMTuCj1B1B52wh3Y75+QueerT5Ot0FB4IBFmVonTw5224cJeFe4Mg3A1d6WjTP9dGxaXq4Rayod
 HyF1tpWACbvYGMpyjC6KtO2bNjv36W3JzsuVXDYmEC918m5RvSsSPFsKG+l4IFrgTfsRwVRfy3g
 o1C30H4cE9Go1HqGEHbVHHym04Miuuu0aM9zydG6MuJ6JYlbrgOxju+D6bPar7VZ3RH/MRTMzsI
 i152WRkKKXQ/e5S991hCRLGCnfI2d90MkVlUYHSJw4mLfDg5nkX4YNpwshttUQQLzdffJ98kVda
 yEzJon31lFBCc3eCOOUR+O1gZd2BYm1xMrcmsSLya+DlnBU0nyF1fngxqW8x42FSkpDQW1Rq9pf
 TZo+PJEyGPneY90jg6g==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e0a931 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yWhZYjjtwySg7tuK4IQA:9
X-Proofpoint-GUID: BJ_PeVf6LebR_Vj1Y3sDRvBw_obQjQ_v
X-Proofpoint-ORIG-GUID: PTzdm8LB_4viEV5p2L_A9KqUZlXQpvka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160087

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
v1 -> v2: Rename DSO__NAME_GUEST_KALLSYMS to DSO__PREFIX_GUEST_KALLSYMS
          to reflect that it is a prefix, not a full name.

v1: https://lore.kernel.org/all/20260410071225.708005-2-tshah@linux.ibm.com/

 tools/perf/util/dso.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ede691e9a249..515ab6e95b0e 100644
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
+#define DSO__PREFIX_GUEST_KALLSYMS	"[guest.kernel.kallsyms"
 
 /**
  * enum dso_binary_type - The kind of DSO generally associated with a memory
@@ -915,6 +917,14 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 {
 	enum dso_binary_type bt = dso__binary_type(dso);
 
+	if (bt == DSO_BINARY_TYPE__NOT_FOUND) {
+		return RC_CHK_ACCESS(dso)->kernel &&
+			((strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_KALLSYMS,
+				strlen(DSO__NAME_KALLSYMS)) == 0) ||
+			(strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__PREFIX_GUEST_KALLSYMS,
+				strlen(DSO__PREFIX_GUEST_KALLSYMS)) == 0));
+	}
+
 	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
 }
 
-- 
2.47.3


