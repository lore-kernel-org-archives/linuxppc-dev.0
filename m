Return-Path: <linuxppc-dev+bounces-22710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B177FCD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:48:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmy14MTpz3c7R;
	Tue, 16 Jun 2026 22:48:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781614121;
	cv=none; b=C1XPS/SEsaGp+wp+nRSVvIBWibMdXjBe4el30CjsMtWOx0RQAMEQWYurwGuDY50L3SeyZ8NSoikjq1TCMwy97/HuW6EotNA8keDNJe0KqkCPoBLBFym8SlLhedZ6zHWlg7Gl5dgftMd6l59+hgmcAc5W1znGwm963QN2h1HRXSwiedmRt1peiLNy0Qm7DsDupF65/M55wo5goULWZcRSrMF+oUsUzevekTnMCuwqFrA1sx29QOZ7JrK64XSUBld9QBcVsQcJ72hbvrmMh3JPnWi/S9+C0FeY/yG9OXKWv5ZlG4UeACi6n0e5pzLV7hSlGpZehusheYB/yZQqQacX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781614121; c=relaxed/relaxed;
	bh=esOXrnEBsqa8PD/S6CVyx6Z8nYspUwbFrydWFgxBBEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4L1Wd0HnHS5ffAFR8jmg4vgVoaVOtMI1m1L99c9JiVE1kojOoHI29dE7Q2vGTEwdtQ/bQfgFdpOjyAkCVfwvPus3eGgpMVoGZn0KTjDvULiOswO2gQK+GtYqnFz4hbhxyt3Lfj53GjfJA4A8py1/Xk0qjfpTMXCd/2tujYiY6wz7hJCXAOuo9r2WKh96lX8NCxri1Nst7JwqtH6SLN70431In+SoAHOcqCGu/0i9wLV7+paYrUXrSuVXJp7h/gyn1XpbLcU+kNf6NlikFJYltbe9jbO4n+oTKoFBmwHQXZfNSwM4NT4JiWQnR2nDqA/KrumWECQP9jo6al8U9JR5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QGIUaptN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QGIUaptN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmy06Wqnz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:48:40 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIGGh1395952;
	Tue, 16 Jun 2026 12:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=esOXrnEBsqa8PD/S6
	CVyx6Z8nYspUwbFrydWFgxBBEs=; b=QGIUaptNIXigQRWblQzbMUFoeEc1fuLm5
	YF1dNatwMDxwUAVPP7/z42v8rvbda82KU8cwF43neSDZzaeiZ5EFTRNVy0792+fa
	lQETGEt0kSbtCg/iquqPe9xm45e1VVQdHlP6MzMHjC9doVTqMDC5V2JeLJ+CAmcm
	hBNsiARWPsniuNgJ6Qd+OlgaN4exMyayKBQhdRuTCfClZNu+JnHRNQsxtGkE1z7y
	uwg+EObAlk8aDmIElPKVSS3Y8vQTeARwTRmYqyp8QTzACsm9M4NVet+iB2k8u+QJ
	2Q4VX2Tr34+RuRg13S7ge4jnRUdz8GgLR77xywVpWHqnPLPp3gIyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h85r5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYdXK010178;
	Tue, 16 Jun 2026 12:48:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk3b4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCmMYc47120700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:48:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC032004B;
	Tue, 16 Jun 2026 12:48:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C2DA20043;
	Tue, 16 Jun 2026 12:48:20 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:48:20 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [bpf v8 3/7] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 16 Jun 2026 12:47:37 -0400
Message-ID: <20260616164741.32252-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260616164741.32252-1-adubey@linux.ibm.com>
References: <20260616164741.32252-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX0vWYvEVy0G4l
 Mrwo/zS13ainnrcSEH4lY/lvy/EpfbQEZkwqp6y+Q2Oxehx/rtmGQ82x4sOb+JyYKfq5cJGPNco
 x6YAe/q3GlfWeRBIm0fiV2FBiu++1Hs=
X-Proofpoint-ORIG-GUID: MRwJw2wvY_mFukhhzbwldUWmlQxskinq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX3ToHH+lbSBAD
 z8xRJ1A8StE+QjfqMaPnFtCebaz9EQsvA1q950MBSdcAzdr+fZfM7E/Tz+zp2OO8hZrgg+2BCJt
 wQSxNZy2npT1a0wfgA36QW0ZBrZjahwBRVSY39X37u2rhV2Ic4pcBkreECA6RpsttKmhsLydUSM
 +5d6ahcoCHCbtxQYvMmmsrDijHsgegVWzULzDjCI78nORi1gYvx6LudR4uAUtSuHz3/CdrZeaVL
 nkIbz/NdlqUDdTCqgupoJzPrziVzOAJ/twPsiWsmfRIhMexL9tcmGnmzehklzIU9OIY65DE2oKz
 9GRt2rRbjJP555TyE2Hm1A/+d/iSY89JZzzPlD1O1yHQKXiHGSu4Tg7ckpv0OoUO8Spd+xv1S0I
 fF2xA515EJhgMPggFRwl3Pp07r9rwZtl9AKk9x1d7AkYQ3cIt1x8AmPFeDyK70EF/LuGmUSF6/E
 r+s86ifX2yq+cQK66GQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a31461b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jFlzs3kxbzYMnpdfaSYA:9
X-Proofpoint-GUID: MRwJw2wvY_mFukhhzbwldUWmlQxskinq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160130

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
---
 .../selftests/bpf/jit_disasm_helpers.c        | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e28c..11428cad5b2d 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -178,10 +178,12 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 {
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
-	__u32 jited_funcs, len, pc;
+	__u32 jited_funcs, len, pc, disasm_len;
+	__u32 trunc_len = 0;
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
+
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
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
2.52.0


