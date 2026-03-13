Return-Path: <linuxppc-dev+bounces-18178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5821E107BCCD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXVwd404Zz3cKT;
	Sat, 14 Mar 2026 03:55:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773420929;
	cv=none; b=iEzUnfZofj9TlWujYVPm+pzhAFo8WXwPg2wGnP8dJaNwXO+cN42YcyMAm8jULn5EvMyDYnStSh65AO470ymzf7vNmxYPFiUQiYCc+9sGg3E7Gyiz0GvVPiohPq/mw66ZKFbg/vz4L3DQrG8jPWLZTaIh88UO8QpbI2CEvZVt5ciIXrZ3U90tr1SvXYHcPiHmPTVg/PEu4PI+bnW9tL/Wjw3MKPAL/cug0I8SV5lJQYqdXh1yknSpwpEOHV6Vnvz5/JtWw0mTiFvGN4wDCGZ7dbfEXKFHT8pyg/H6KHbmuiJnWv3bWrY40x5Cy4Vx9/GM16QTu7H0sMeqzCt40djuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773420929; c=relaxed/relaxed;
	bh=Osw8qzdi3oIxWx7cU3T4M+DIFPXt0WJiQYWIjqr8tYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BTOnmI9swphfwNjcZX6lBWhqO2u18vWT0WkPZTfYYDq9DSolJllzeWSOpUNOdJqhvcNUuykLXrYSAAa4AXhBP+FYcezTvks3Tghu9cuQNiEc5CtTHVx6coV2efVqLsAX4/Vppj5FmEHMM48eVM0k7zDZY3EvJyL9EisXJGwEoBWkgItW5XpWHsPberOKF/+WxwD+OosFsjYhEzvpMKVhI00K5WEp4xWroTvRaq5RsONV85q7XFPg9nsx+RFAHT764Fpet1zqycDuaVtCjkxl+Q0JaGzWSaSXM64LCFuOaLetFOiRYgh85qgn8BmzSl0NxbKUto952BZraZFbnPgD0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D/rqYT7U; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D/rqYT7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXVwb5QGZz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 03:55:27 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D8340O2637637;
	Fri, 13 Mar 2026 16:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Osw8qzdi3oIxWx7cU3T4M+DIFPXt
	0WJiQYWIjqr8tYo=; b=D/rqYT7UvMPEDzk0165fS+yC2NLk1utiPf2nIiSv09w0
	DDsm+l2jqqFshJdg1BFqDyqPI1PnAOSm87+mLLFMlw3DNS2Pmi/EzmZXZh3fRzv1
	kyIXH967sMU8jox2tQOR+tVq1tf268qQTiHCBTelTEg3VceRlr7VkIcvtLlIfCWy
	bDlp8qXiArBZhobN5Pjuotq71ymO8quMvMRG0EkBL0Pxqnreb3uewkXVsJUeK8hX
	F4l/6uuSwhOu4LRKvTwj7o40hfO5t9up323ktVrvBMVPVH6g8kISG1KYRor+ADhZ
	w1a9V1L9ElQoMUc6AotRQJrGUkBAI1GBaSZ2UzUBww==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98gh5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:55:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DEiRac008821;
	Fri, 13 Mar 2026 16:55:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha77h7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:55:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DGt2xE15401320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 16:55:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C7CA20043;
	Fri, 13 Mar 2026 16:55:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CDE820040;
	Fri, 13 Mar 2026 16:55:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.24.89])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 16:55:00 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kurz <groug@kaod.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/powerpc: Suppress -Wmaybe-uninitialized with GCC 15
Date: Fri, 13 Mar 2026 22:24:26 +0530
Message-ID: <20260313165426.43259-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b4416b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=TLf-jbbItdWWZ-izWCQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ph5O97qYnNsSG2xrLzOHrPDv9SbUgh2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMiBTYWx0ZWRfX/30V970w70ud
 ekESKMhDkqQ2hnbhwACmn2Ki9Crg9Gg0l0sPoX9pzwk739enz2w8jUBlwUPwKes7+0AjeCHmYO1
 o6dtGtxTYCjnadOwjuBjXpKtrUmKT6N/IoM6hT+d+bMoQYiNaUtixucvVBbRWptxbul3MkahH7w
 WpHtevZUokc+DF6gHmYTWQjUn/NRDJe8ndR2zOnir2HttiiX6Mf3dZxt4ML27uIqiauSx/69ciH
 2Ib43Boc4+YBkm0H2QaEqgbl9FeoBOVAEO50Lahp3XVm8FMymgYoBozjGZmiqj+B7f0uSr7X/jF
 sAoRgHOwo2QmH+f23mIvBn41UIGb5iHepsvtD0uhOxqnpQlP8cY6zcu3V+xqbibQDusZFk/phW2
 M1Iye9vkfFeONZeBh29M+IWFC+xli1K5fKbTLiBd8cA5l0HnXnVPZcIMnDgUMjN1ihlP5hQ5hZA
 2uEAPKWuhpS3L5DIG2w==
X-Proofpoint-ORIG-GUID: tGlATHp8agIkc-A19ZM_5v3xuUCjM45t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130132

GCC 15 reports the below false positive '-Wmaybe-uninitialized' warning
in vphn_unpack_associativity() when building the powerpc selftests.

  # make -C tools/testing/selftests TARGETS="powerpc"
  [...]
    CC       test-vphn
  In file included from test-vphn.c:3:
  In function ‘vphn_unpack_associativity’,
      inlined from ‘test_one’ at test-vphn.c:371:2,
      inlined from ‘test_vphn’ at test-vphn.c:399:9:
  test-vphn.c:10:33: error: ‘be_packed’ may be used uninitialized [-Werror=maybe-uninitialized]
     10 | #define be16_to_cpup(x)         bswap_16(*x)
        |                                 ^~~~~~~~
  vphn.c:42:27: note: in expansion of macro ‘be16_to_cpup’
     42 |                 u16 new = be16_to_cpup(field++);
        |                           ^~~~~~~~~~~~
  In file included from test-vphn.c:19:
  vphn.c: In function ‘test_vphn’:
  vphn.c:27:16: note: ‘be_packed’ declared here
     27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
        |                ^~~~~~~~~
  cc1: all warnings being treated as errors

When vphn_unpack_associativity() is called from hcall_vphn() in kernel
the error is not seen while building vphn.c during kernel compilation.
This is because the top level Makefile includes '-fno-strict-aliasing'
flag always.

The issue here is that GCC 15 emits '-Wmaybe-uninitialized' due to type
punning between __be64[] and __b16* when accessing the buffer via
be16_to_cpup(). The underlying object is fully initialized but GCC 15
fails to track the aliasing due to the strict aliasing violation here.
Please refer [1] and [2]. This results in a false positive warning which
is promoted to an error under '-Werror'. This problem is not seen when
the compilation is performed with GCC 13 and 14. An issue [1] has also
been created on GCC bugzilla.

The selftest compiles fine with '-fno-strict-aliasing'. Since this GCC
flag is used to compile vphn.c in kernel too, the same flag should be
used to build vphn tests when compiling vphn.c in the selftest as well.

Fix this by including '-fno-strict-aliasing' during vphn.c compilation
in the selftest. This keeps the build working while limiting the scope
of the suppression to building vphn tests.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124427
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99768

Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes since v2:
  * Compile vphn test with '-fno-strict-aliasing' as per the indications in the
    [1] instead of locally suppressing the '-Wmaybe-uninitialized' warning with
    diagnostic pragma
  * v1: https://lore.kernel.org/all/20260310101519.67157-1-amachhiw@linux.ibm.com/
---
 tools/testing/selftests/powerpc/vphn/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/vphn/Makefile b/tools/testing/selftests/powerpc/vphn/Makefile
index 61d519a076c6..778fc396340d 100644
--- a/tools/testing/selftests/powerpc/vphn/Makefile
+++ b/tools/testing/selftests/powerpc/vphn/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 include ../../lib.mk
 include ../flags.mk
 
-CFLAGS += -m64 -I$(CURDIR)
+CFLAGS += -m64 -I$(CURDIR) -fno-strict-aliasing
 
 $(TEST_GEN_PROGS): ../harness.c
 

base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
-- 
2.50.1 


