Return-Path: <linuxppc-dev+bounces-17955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFC4EB1040
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:17:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVDf1Yvgz3bjb;
	Tue, 10 Mar 2026 21:17:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773137842;
	cv=none; b=m6vMAc4Oa5VsKMtzTGJH9sVDEbXKPZlhdyOpXOOUsQNdx9VSGMKSCyBg97/Z4ZSJRWIUNyqsAWgmpkSmwpi0lmucooNyUtdTcUv/1/4t+z9pec3i2ROzsgmGq7fAlpUZHuXmNH/3ditfIbXIfZi2/rYfe6ifnNTxrdmm3qxb6UbURaOcgriuOvjBwKFJ2JRq1rEG3Hbj42iayk82OP7zIFWxc7ehuNdcGDApY57yA9ferSBEkmZlrQHhn7CELcm0R5kP+ppTBxSHIuzCVcc0zn4dskRZhpLnK9hmDC0HFM4bRD1uBKqUCPNak0bRtmmk8qM8348aD3tRwHkC3kpLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773137842; c=relaxed/relaxed;
	bh=iesZ9SxOi2m5Xy54SPaHS4tPpuhwx5hKwA7bM2riaBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WOdSZ6YQ4Tz9RehLU8hMixhrnms507lzgrRT1MJ9QJkXueq8Y8PcJjuweSnFQR2JNlZwyymDgxtRThxtZu2V2xACkp3zdWsdm5/bpiu7idv57oUY4lovIVHgV8CxyUzikvLC3Y91Agx9DUJudHVHCtKqW+AQ+ub1/CFSc1nfVIabWVY4oLwPHqAg5ymzyK7sLjhjWDwrFo1V4gQbx7hRLXiEsGJ9Iu/i4yWYVVkq2US+lQtPEk0u2NYSTlPEyQ+Oy8fNVKPhBp/W4vxbL85kJZiNuwsh3NKAqtXfM5xPBxRLBOK6iyPds79GTxhdaW8j0Y8jFhLTMECPCmu1cbGVxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fbUZpbJe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fbUZpbJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVDc3kSnz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:17:19 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A56bJw509351;
	Tue, 10 Mar 2026 10:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=iesZ9SxOi2m5Xy54SPaHS4tPpuhw
	x5hKwA7bM2riaBk=; b=fbUZpbJeNDwKAQMTeAaCF7xreNu8EyEew4UI8JG58i+G
	a4UldEbNuKfrdXxaNjPyndu+R8eR8eMfxZZ7NFM6T5w61Gk5/EF1IZCouIjd+rGs
	pEuAhnJT6DKMYf5VujmeUoWQ54xDI1VLinA/n1y/6C9AmKqROWY57Suy5G63F4pB
	rZtVkUB4KMSuk62GtN551XjPRsa4VN4e/o12XskLdD1eckDTsVo1dUtl5FQ5nwDm
	v/xl9TnbhNQ9Vf5Qed7W3k+BAMFoYq59OEHAs/XEDVG7fQXBgszlVas39+Lv7zyf
	atSnMbj357y0+rWxOBfmKTLdfeAbZtnQH8jOBhVsBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywabqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 10:17:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A60odp021365;
	Tue, 10 Mar 2026 10:17:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsrrxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 10:17:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AAGv2949545652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 10:16:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FA9E2004D;
	Tue, 10 Mar 2026 10:16:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78DFA2004E;
	Tue, 10 Mar 2026 10:16:55 +0000 (GMT)
Received: from mac.in.ibm.com (unknown [9.98.111.16])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 10:16:55 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, Greg Kurz <groug@kaod.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: Suppress false positive -Wmaybe-uninitialized with GCC 15
Date: Tue, 10 Mar 2026 15:45:19 +0530
Message-ID: <20260310101519.67157-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4MSBTYWx0ZWRfX1NisxH/IH940
 L+2ztO8/+HyWqpgi5Ft0KC2S5cjni+JtxwHdGf4XqppgOG0EVYsmeYWUGUZgRt+Lr67v0B0eYT1
 h6SIosiM5XPhp5vNIaU7YMJ1HirksTVEEP4a6audyUNbdJa2lPbd16Jw/JhM2Se29bq9T08bL8C
 5EIjn4ZMyJ6CLXnei+n8LYoucIq9JX0tdM56+QsnYIwC50edDoUqbxMzXI6xbeMg6iQwdVTeZ8w
 AW8dspbS9+2WYIkdIbh248iKQsaB2NLKw49ngU3+lW+uhHk92zPR4Mzm/QPjwVcMCO4Us9LzbTM
 ihQ82X4mZYTCmhjWKg6vXFHizpbYbTzLyTAVLEbkT6i8/IgqIkhcP4uubM+8JcNji6x+/ivnMV/
 B+4TMQPMBFyjJqPbHAJJ33nFtAyfIgLMY2Dp39rHdxLIgiCWRLgPEiokKCg/wLQ8kRJI2caODjb
 ij7Al73dTee832YhI5A==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69afef9e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mDV3o1hIAAAA:8
 a=VnNF1IyMAAAA:8 a=TLf-jbbItdWWZ-izWCQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SVtSYDVzzIvTFT2n0xrlB1Pu1W_q6LTU
X-Proofpoint-ORIG-GUID: cl2Q4MMu8IC3_A4RcuuuAxi2u91kZuam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100081

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

When vphn_unpack_associativity() is called from hcall_vphn(), this error
is not seen during compilation because GCC 15 seems to consider 'retbuf'
always populated from the hypervisor which is eventually referred by
'be_packed'. However, GCC 15's dataflow analysis can’t prove the same
before the first dereference when vphn_unpack_associativity() is called
from test_one() with pre-initialized array of 'struct test'. This
results in a false positive warning which is promoted to an error under
'-Werror'. This problem is not seen when the compilation is performed
with GCC 13 and 14.

Suppress the warning locally around the offending statement when
building with GCC 15 using a diagnostic pragma. This keeps the build
working while limiting the scope of the suppression to the specific
statement that triggers the false positive. An issue [1] has also been
created on GCC bugzilla.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124427

Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/vphn.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/vphn.c b/arch/powerpc/platforms/pseries/vphn.c
index 3f85ece3c872..9bc891143fec 100644
--- a/arch/powerpc/platforms/pseries/vphn.c
+++ b/arch/powerpc/platforms/pseries/vphn.c
@@ -39,7 +39,22 @@ static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 		be_packed[i] = cpu_to_be64(packed[i]);
 
 	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
+/*
+ * When this function is called from hcall_vphn(), GCC 15 seems to consider
+ * 'retbuf' always populated from the hypervisor which is eventually referred by
+ * 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same before
+ * the first dereference when this function is called from test_one() with
+ * pre-initialized array of 'struct test'. This results in a false positive
+ * '-Wmaybe-uninitialized' warning which is promoted to an error under
+ * '-Werror'. This problem is not seen when the compilation is performed with
+ * older GCC versions.
+ */
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 15
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
 		u16 new = be16_to_cpup(field++);
+#pragma GCC diagnostic pop
 
 		if (is_32bit) {
 			/*

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.50.1 (Apple Git-155)


