Return-Path: <linuxppc-dev+bounces-19235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9185D6AB10
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 20:40:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmtzL2HPhz2ypw;
	Fri, 03 Apr 2026 07:40:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775162446;
	cv=none; b=cjkhPSNny0pouABD2U4NuoLbi2NCbDrIDfT/whHfJIyhcwXxD0g5LM9Hu4bRV3UgHZHm2sov2mhyJ6palHjW9o8lhDdqldkiwGXCO7ahGv5zHO4WP+x2C6sjDFCaDMy4R1iSpw+34fj1fnohJtkUttBl6tUJZCkjkfBY3S0wRKtysYo+hwGW0QJyZ2rPemXycqKuIUXFQ7oW7//eLIvbW3E1MXaJfxdKsgTsyjIobL6hE2zdQzkeA9H9OGJegUVSdllOCBb2OkGjelEAe2bzmA/ZH3XdNd8lyt5pyf6dBVyLk9jxodr9m0YFkQQTohxkgHsCoSQNZi84+PlusKFZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775162446; c=relaxed/relaxed;
	bh=0yx8o1vLrB65vCCuGPvOK4QUoLEyCAyYVHQNpTUGhjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvwTHqBrD0de5SX0KKFax7PuoliDoKkZSPrGFn5UWqRRbS0MLkBLoFmUBZyebdnl5s8pnXMu9/+aKYJTIn89mmO9LM30j6oFCY8CVIiwAl8OCfGEcfpNhjhvFSubAYQ6zMo3G1Hk6daKif2hNOvPokqY3qzf7SKhGauCxgdTTsOF0HnGTc80AQ51y4r19n4wS2FaIY40BeNkcUaeJppPoViAMvSlIMnnA/mkyy9yFWUcS27h/Xxnp6RYNvEpvhuE3tqa2VyXUedkLSJUavO6a8ey061s133pX/D/G2F1aU1h06dwx+Djo4ibg7GIE3HbE09y3n9qrcuK9K78mCglBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VE3The7E; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VE3The7E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmtzK38Zbz2yhG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:40:45 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632ARD133226794;
	Thu, 2 Apr 2026 20:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0yx8o1vLrB65vCCuG
	PvOK4QUoLEyCAyYVHQNpTUGhjI=; b=VE3The7ETh/fSES5LmrBKWFadIYoreMUx
	mvW6SVV2nFKkcC0ZmRZV9KJHL/VxXNJbHBuUXhU4v8iTC05386YQah4QRhebngr4
	WxAK9C3n+EbTD6PTWmNQQINeohupVUoXzN+8o0jvBUoXgWW79qdAyRABt7rLlMZD
	PWh1paxkP8vf89CLlav9Bi9damjP0AB5mEHBx/GVSyXvtFLcAnttKbFAIXP6mlek
	aYVb3syCs4Eeuf5HzNvzujjwfmW38IlS3spo6k0UvXGDXAReGJSCdxgLWDKz+KdF
	t4ensHa62GmYFe/jwlHfOGvuxata7GpIEDo+l7Iyok1ux9f/diSuA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcnmg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632HABtr022217;
	Thu, 2 Apr 2026 20:40:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanbmbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KeQMX46531006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:40:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC982004B;
	Thu,  2 Apr 2026 20:40:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0777820040;
	Thu,  2 Apr 2026 20:40:24 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:40:23 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 3/5] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Thu,  2 Apr 2026 20:40:09 -0400
Message-ID: <20260403004011.44417-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403004011.44417-1-adubey@linux.ibm.com>
References: <20260403004011.44417-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ced43e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=kVjrMc9Is9WrAmO39HcA:9
X-Proofpoint-GUID: Br0a184axX6Mksfpt2sT_lg-_KkNxH8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX5G2bVXTxaIot
 StYMSgL2l/u0gWZwj/b1kjMADuXL9GWDodpnuDsTJZgQk9CN/jN7Tm0B4bYhvDAtnTbqEPx8vTg
 E5pmHLsJLkREVKqXMaxqeokOGqdwUA2CLvKAWd/KDrL2fBiXzMfk4Nc9iqV/jyhQZUkeHwxaa1X
 VTeqL1tU/nZzxOQ3ifwA/S8LEY4T/TIN1cyfZn3WS3Ga9i7NEuvrpJHebcT6pe9l9wc6OQSGMUv
 YkJ9HQNaGBqQpuHB/Ln4tcPI2WLmoPNM5EZrcxxJX0qAyNQKVwAK8O8u8JCqPKMhPaL7EKmRw8U
 A0kaQG9E14Zk00guguqLDFxc27MbZ25lt/DVhKeZ80mOf2ifA8z6L585gXdcPPGQVmYnJjF7fPO
 2a2rD1LrYVN/L/BvupW0x55Eg62sEJIbpzrGUB5dw15OdXhPCvfL/ff+3wkmpj3abgYsPR8Volb
 v736/xeq85DP4ao9N3w==
X-Proofpoint-ORIG-GUID: Br0a184axX6Mksfpt2sT_lg-_KkNxH8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020181

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


