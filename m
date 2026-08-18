Return-Path: <linuxppc-dev+bounces-25950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA58FC5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:45:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPHF40pfsz2yRc;
	Tue, 18 Aug 2026 14:45:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787028312;
	cv=none; b=UFEp4/QpSNGh1W4wvuQXOroVFBKlKz359njK7nSPwVjJCSjEsjqd1hzXFiSvBLYpnYcaEaTykJAkBGxTpw9K2whSc+yWIb9kDrTxxYT+r8stW7iL1TPkG2ANwh0JfWEUXNNxxMCehNPTIGb9dPqdQ70xlNFgOhJ6qyCf0ZHZoHTCg53mF6K7hWrsJASIEtKm+Wk80k7wE8EkeqMghRjeQJsJKjtd0dAJ8QYHyO5fxV6Y2IHFieV37v2BmFPhBVIfSv4+HlKPaN05wPzt8vAY5jqjRDkLkwGl3PKmRaGUq4VZ1joDM8bnZogcmT6tiWqsza3uZiSyhIwcBWu3Djdzww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787028312; c=relaxed/relaxed;
	bh=nrCNqQyRjEs2T172THhQTixW7ejk5qHSnv5UECNHcVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZTkhQlWgnh8FmtSnH9Pae5x1FEYgfkKwUz2C9Wvr09RP79oNUYdj6F8aiMwSe3gzEHh2qcdTeQUoMr6z7/fUzPqXnLpD3Pt271RTfstqrIgAPJu8HBsLz77oYwRMa3q2CORySO3WBoJ9pvyU/npbTjr+AGY1BFu8mrFwn3Sn+h/SI2+WgLyZfoAJuTJH/Hv/GPSSTRB10EG6XOvOjsUxzRSn9funE5wqT3xMgxNuwdEaUMuk8HGji9Ll4VZ/t5mNbFKR4itvkms4jw0YvWQ/9F/jcQuSnIbbM5DC6YVfGXVHpXJJre3QrfYykwUrYRSEG+52rZwlLbHpevSD4RR0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H8OZl1LL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H8OZl1LL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPHF30ymzz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:45:10 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1cbH2574941;
	Tue, 18 Aug 2026 04:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nrCNqQyRjEs2T172T
	HhQTixW7ejk5qHSnv5UECNHcVU=; b=H8OZl1LLMDgTDYlyMpFwKUhiL0212wfmQ
	WYIk2Ml0IKUACqNDuBI198M8C9M83yHFv8wNdR3M+E1IuMan3o9umY0WxRya5+HW
	iJUgpTBMOSJ7MHhDHQGNkvLiPbULHQQ37MOQ14ZHHnPk1jOLVAaBdB5fXZN6gN3V
	/9oTQ0Zbg9g2OJrHpP6AyBm3voGUcbRFJHGVBVfc2z9mXC/xDklOkXGpd4tkg31z
	bCQLiBvcaeSbySrWJV5UU+hKpGfW3I4rWRXrEo5PZxU6ipdyWu/nN2HyutxKTzQt
	6MSzex+U3Gafqr0rumbNJTzqhgLTXxSAmSw0zSLzZjyf0uTB4ia/A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3p1m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fLnc028632;
	Tue, 18 Aug 2026 04:44:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq1h1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4inlS31392150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:44:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4593A2004E;
	Tue, 18 Aug 2026 04:44:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C396620040;
	Tue, 18 Aug 2026 04:44:42 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:42 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 6/8] selftests/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 18 Aug 2026 10:13:39 +0530
Message-ID: <84fad8bf849e48ea156e3e598eed8136e42385ff.1787027080.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
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
X-Proofpoint-GUID: UZV-BZYSWtlE2Iav5EwWkKt6ZALLmyXJ
X-Proofpoint-ORIG-GUID: UZV-BZYSWtlE2Iav5EwWkKt6ZALLmyXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXw8DpJftCDsSa
 +6wYrlq1/LyBDa2EjnHrIdDi+W51p+4PmAcrJgB6dhAIrt0aebDiRdY9Gw3X9hDuCcaVSkY6v5T
 PGIdrP4Aed9cekXqnpS9TKGEH84+TkY=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a83e346 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LRkTx50ZmXYUPJyuxFYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX98WmfJJPvorX
 HQtPvcOVpoAHIEQq8xv/fn6RZiPfife7HZedfu1bqUgOejukbOzBlFB6Qc0dFa+MN6hzlaryofz
 4uck1X26ozRdn9qa5TCWB0LVBgut0EtEwrqU42aa71EHja0sfsLsx5SajO7MmoiBssbLLwyBtuk
 YK2nxoQq0skpTyuv1pSSQQ6Nyx50G71cVq4wKlUxeB6drNiBTrsp2KdqyF3DVTjeiQWexh8QwvA
 ul2taldsqYJGF5vv/CTE2k3RL36J/Dvro90vIpUI3KA2NA/1KkWTInzrDHJCsC5nhDjXZaGU0WH
 UtNLKWU1usimfcFerXqEBmbl8Pgeh2VHE5oyDK1Ztm0m29KcDn3SfO+Mn60dGLms8WJ5nPk2AAB
 NAhwItJiaSG1sHDQ2X9IWKRbHPmIaYWwE3G3IQkJ3augpRY63DpGF8+SQH48iUzBeP2VzihMdkm
 ezr2t/k/DqxiB2gE8fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180031

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address stored
in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
to the disassembly flow. Prevent the disassembler from
ingesting this memory address, as it may occasionally decode
into a seemingly valid but incorrect instruction. Fix this
issue by truncating the last 8/4 bytes from JITed buffers
before supplying them for disassembly.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
---
 .../selftests/bpf/jit_disasm_helpers.c        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e28c..b291d934dd1a 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 jited_funcs, len, pc;
+	__u32 trunc_len = 0, disasm_len;
 	__u32 *func_lens = NULL;
 	FILE *text_out = NULL;
 	uint8_t *image = NULL;
+	char *triple = NULL;
 	int i, err = 0;
 
 	if (!llvm_initialized) {
@@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
+	 * which can't disassemble to a valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (triple) {
+		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
+			trunc_len = 8;
+		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
+			trunc_len = 4;
+		LLVMDisposeMessage(triple);
+	}
+
 	for (pc = 0, i = 0; i < jited_funcs; ++i) {
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+
+		/*
+		 * Disabled JIT have zero func_lens, hence underflow
+		 */
+		disasm_len = func_lens[i] > trunc_len ?
+					func_lens[i] - trunc_len : 0;
+		disasm_one_func(text_out, image + pc, disasm_len);
+
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.55.0


