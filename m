Return-Path: <linuxppc-dev+bounces-21187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03675CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 19:38:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlMj02dMz3br2;
	Wed, 20 May 2026 05:38:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779219504;
	cv=none; b=jeGFlvqikK5Y3rxidgW1vX2hWyT/H6/pYFtm6CP+pN2qThXUwwnONSF2BmV5ipvM3FAr79XRO2HX+JMeDW5umzt04cKJ5q2P/fL1ywpZyIEG5vWmTXAN63ec6t95zBPXEDi1zQcY5Irp1S3dSlsuKzngdxszC0mZ4A+vaWPSEFdm2zT62tiZCWg9pkuBduMhmvAybsbVdKBI1cHamQmWcIm9uzBG1iXMv2tVugVIr6ydJQbCTXbdV1Cd6I66W6+8AIYNHMcDbsaxB3YHNmJGG6GtESb3X7Mo0KTCTpI90s1KGFuh4L7Jxef8O+IbwGxudZMiFQ+GYtrmKrDYXkDuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779219504; c=relaxed/relaxed;
	bh=3AJGiF3jSZFKcO2dswxqWQz67N42vxEawnsA+LUOjTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei3NqLiqkBTYieU1sY7hVXMcPTM2H4t5FxagVk75SuueWLS3Uc86B81YF53qZHb09PW8vP4Cbx81qIA4IrU5iYgODfAWOyGPSEP5fsGAnegorLMCQv7zJu2dyiAXJgrt96KUN8f9uJfDtGhbmXZkqMSPjlNlnmQiLJUA9eyFR2aHSgJGtX5KwWr7Yr+UAwk+a2itAVsvwbyGHD2jd4j4wZFo91RmrC/mxkMLmn9CWDoKPb3fTh5D006dTwGU3nM4hnAF+6wsjlCAID2qLr32Uw/gDFVokf+PdcGK4LF2t9ZKrfsJTR/jqR1awlF+m+7qsmw+enKIzLw2Z3WuGLkzJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qabgLt4v; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qabgLt4v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlMf6M70z2yD6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 05:38:22 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JGHnLg1522114;
	Tue, 19 May 2026 19:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3AJGiF3jSZFKcO2ds
	wxqWQz67N42vxEawnsA+LUOjTQ=; b=qabgLt4v1NB8Bl4ARaogPNQkson7hPhoc
	aFGfPEq1BTnOEwavWAtwL8qYuCecKX+oYD7hYCsau77/m6No5Ry4Md/1aayV9M5L
	6zIMJolr3TTQDP2RDYd4jI86m2DJQ7uWURNcUtMuy9/rEO844ERTz1ICQ84Ozdq2
	l8ktplqKFxte8jrShxzVsrCFlNmkGQxdpeMwfNq/RFiX7iqOm3rYd+/QdB1auwoB
	NetorDnY2LU11n8wSFshgZGF6lTF5Uql/S/pniCq6/W8BCKzJZlSwqV6q4CG7Iu2
	9dWCYAA9rq5d6/aM3Xvm6muoyLM6dlUI27uxrXWL34VtXm/R12H+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xxvh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JJO5lQ028476;
	Tue, 19 May 2026 19:38:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gc0k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JJc4kk53477796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 19:38:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9DD320043;
	Tue, 19 May 2026 19:38:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9EE420040;
	Tue, 19 May 2026 19:38:02 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 19:38:02 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 3/6] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 19 May 2026 19:38:09 -0400
Message-ID: <20260519233812.18787-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519233812.18787-1-adubey@linux.ibm.com>
References: <20260519233812.18787-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NiBTYWx0ZWRfX711ppvCoXq3D
 oJgDze0wsRV8Wff1v6HvZbTnpDLjo9GdMGZwZYCccatqwknir0MrHoK8SIyemo/Q1UAe7N6PEaQ
 SFbImLnNU9NvHr2rkKRR21a/3WSr35x8nZ1OmM+wJkhe6zR6k7GbDp6Ye5vSaNYo2lliWoR91A6
 A1LoWXQk8iHrOFygsey0rJiWtoC4itY7Pj3bokInynhsGUVkoDyeYbEWA9peGdtpIkdxlGgmbYq
 PvJKEbYah9rqvJYqrUGWY1cjPSC0NxLybapLuxmg8G/5QLWGD8QT4njxCtajA73EHBQW/AFXXAr
 5V6YAnjNQnRWQZ3+cTF84HVZ2ZUFe8RgX8zPmC1xEwObscDAg16MBPEpbI60ijR01endoG045RW
 sQAPvtWq86D38W2B7hwxPTKyO3Iv/SVBGrsXcRC3Y0OCmvG9AXVEksq7o9Th+JOBb1g/P2wTWDz
 bmWvLVgNu3AYc0tpFjA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0cbc21 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=BG0PCUMEzKLNx9Y0HWgA:9
X-Proofpoint-ORIG-GUID: LBk5Xahk3sYHmNoZdWc95XdJPjecHAnj
X-Proofpoint-GUID: LBk5Xahk3sYHmNoZdWc95XdJPjecHAnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190196

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address stored
in the last 8 bytes (for both 64-bit and 32-bit PowerPC)
to the disassembly flow. Prevent the disassembler from
ingesting this memory address, as it may occasionally decode
into a seemingly valid but incorrect instruction. Fix this
issue by truncating the last 8 bytes from JITed buffers
before supplying them for disassembly.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/jit_disasm_helpers.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 364c557c5115..9e6613479145 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -170,9 +170,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 jited_funcs, len, pc;
+	__u32 trunc_len = 0;
 	__u32 *func_lens = NULL;
 	FILE *text_out = NULL;
 	uint8_t *image = NULL;
+	char *triple = NULL;
 	int i, err = 0;
 
 	if (!llvm_initialized) {
@@ -216,9 +218,21 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output for 64-bit and 32-bit powerpc, which can't
+	 * disassemble a to valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (triple) {
+		if (strstr(triple, "powerpc"))
+			trunc_len = 8;
+		LLVMDisposeMessage(triple);
+	}
+
 	for (pc = 0, i = 0; i < jited_funcs; ++i) {
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.52.0


