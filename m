Return-Path: <linuxppc-dev+bounces-19651-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224DBF3ED5D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 18:14:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftMJQ1HPnz2ytv;
	Sun, 12 Apr 2026 04:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775931270;
	cv=none; b=dvWxtkj/RK0S46fEQ1WLeGtJ3LBOwcL7mFHWfsy9NxyA1IDChbF9I8kI6QT6Ha4zJXePLvSYAXQM/Sm0dApOJwBcyJquMWupIjGco5EK0Lbw9XJvcmpj6UzVLmcjVzEfQcebqqf58LeHiM5cXS+OcaeYMIsAyh3j3ZcAskgt80oBb2isKbqpLRgbCAoUuskUw9xbbZ/EWQ2qtNj9iMB53Bu/sGd23NvgOof4lXbucEBkbcgbcdYkBa+GYJH0iHzfC4TS2gLdeyMfKbe4hgp0sqZ5BDaotIqPdf0xhH51+ssGxLz48AmYb1ntJHHgo3hC8gPFtTTnk9l4YYyY3eGy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775931270; c=relaxed/relaxed;
	bh=0yx8o1vLrB65vCCuGPvOK4QUoLEyCAyYVHQNpTUGhjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZziy17VcT3VdHuTMy5mHduYKLVS77aFvwqPn+L5U2QR5mD2izrD2SyJYoCAsI4Fic1nfBB1wqA6hphGYsR2QVpIVDPDlJcs0ZfhXQJv26GNCPJcX3l4+QUQtOSO5lBabK4OVS+O5UoI07HS/0+0P0S3BwKKbxNFzEB/EAM6Y1Zrrag58nx9ozhFu18rGtPz+Qlf7wf3zYYbL+J///iVa9kDTMQBlrScwJI5WFUzVQfDOAJ/chAt45gjg2j/ilDnIdNUV3XrECsAA7W/CP19c7kjNj2mIc4F81zSR6FzHM9mP3j359htLpjBVkr2stAx6QCTEz9FsnbVhv6BikfKTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bPL5bTHt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bPL5bTHt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftMJP3Bb8z2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 04:14:29 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B8vFKu3210167;
	Sat, 11 Apr 2026 18:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0yx8o1vLrB65vCCuG
	PvOK4QUoLEyCAyYVHQNpTUGhjI=; b=bPL5bTHtTh8lbKs5xq4sIQB5crjCE5x3d
	Rv9/fBeVK1upZX81kwGfsdKpb7al8CzUP4FEDNveUZ4jaCfatPTiTCHUZNpVA1hv
	DCFEV7Mct7D0gFUuoFZoIzxSdbZWboHtZ+4y6woVLC3Bnfed7QaUz3t/OjkX1wwm
	44PMegzS3lKMTf8jitmhcMsiPp/DJ41A9Y+aGz7LT5Nj9mEBOvcLO6+Ek8LmlJUT
	EXTrlQwdUaduBUu7DJJNRAbwMubkvEa9voGcFcipUsx1BjWuYyUuESb1rgipxT70
	g3MVwB3/qR/CyFEJDFLj7aDsk3g/oic4rquTcuPcAH+87ZsOXAdtQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17hvg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63BDcPcC030063;
	Sat, 11 Apr 2026 18:14:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7w6yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63BIE87q50790878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 18:14:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D95A20043;
	Sat, 11 Apr 2026 18:14:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8558A20040;
	Sat, 11 Apr 2026 18:14:06 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Apr 2026 18:14:06 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 3/5] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Sat, 11 Apr 2026 18:14:11 -0400
Message-ID: <20260411221413.44304-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411221413.44304-1-adubey@linux.ibm.com>
References: <20260411221413.44304-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NyBTYWx0ZWRfX71U3zQvHDeO4
 ETkCi2MaBSLZ7nDxFiJXo5MWLdqJzW7NUxnPlFvB4/urJiSt6U2YdnFYxfIw9UFG0eASRhpH1if
 KtbwiFdCqcf0jE6KjYRVg4o03KvF87DBXEOjTfN9xYlw5EjUrDC/dzf4fP/2HOc2VjesNKMLXlW
 XOu5WYQZamq8uGPgwbXlOZ9hbmKAhkUT5JC16vthvdyByR/BpS/ZDIyRKWq2lI0297ihMsoh+dE
 mH/jM2DoX39L0zg3tt9yUAANltK2e3TnwkwyWWyMz008YSAJiXIT1RIZPOMw9p13Xp7hrI9mFAh
 ZxDHo5dOkpWdrvYqtELB6xYuABaXKe/EksAbhctJFf/K7Tp+fgE6aiOtVSZNToCJ35zaaHrytks
 k9f9Lu9/45iecfxw7nXmgSs+1kfHkRrtvOEB/dAas3PPleMxxMycakY8W/B8PRdcakTM1rYBcc4
 zbZ6bX7Dq+pwmwy/6nA==
X-Proofpoint-ORIG-GUID: hdXLEyBOUXob7JwhirEYz5OFkb9Apfbd
X-Proofpoint-GUID: hdXLEyBOUXob7JwhirEYz5OFkb9Apfbd
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69da8f75 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=kVjrMc9Is9WrAmO39HcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110157

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
 tools/testing/selftests/bpf/jit_disasm_helpers.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 364c557c5115..4c6bcbe08491 100644
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
@@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output for 64-bit and 32-bit powerpc, which can't
+	 * disassemble a to valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (strstr(triple, "powerpc"))
+		trunc_len = 8;
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


