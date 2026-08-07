Return-Path: <linuxppc-dev+bounces-25560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172E6C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:43:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGj2h2T1Jz3c2h;
	Fri, 07 Aug 2026 21:43:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786103004;
	cv=none; b=W4MO8OS+PVfu4qOefAyG4KfjraNrCxKtSmWVX2VWdPU/OyDmiqRcs0+lT5UdI1VQZsbDw9qAz5iZdOpHPCKBPVqpMy4j3ydtTHmFMSEJyfPqi9U9CCMKB59GouuGvoYnbVCjOHDeN9iGG1SZ6hpj5I41JZsU5B6lJ3NnzbYBPhMWw3CcnpGcq9gvahNzkMaL4P9/fnjJFUPwhvMByiZyPGDhGgoDhUKADRuYd0mg8KhPL0hZSYaXKM1+kR1M4mLjzcmzQyqJpcc+vGGvNTWTk26m4sG6gvcZByaC2qe4HQO7tAyDdm1Ks+LU3B6d134nLAbH5FXPkw9orjc18eR8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786103004; c=relaxed/relaxed;
	bh=cCKloGllzigEUP5MAbIcYZ25DmYOKZWUADQmManzbcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUnf7jFV8dS9D5Sy5GUyi8d6R3HJ4hHZ6b8MsvKvXxLokdrCu8GOz5ro/pPIQqzIEeaoSvitbWHetUlL3ov0WkfIXNl+fQTkBHK7beJBHgW+KRviMuDSS89MBBfisNnd+Mfb/DdC7NCTZvATozRLiip9z/3bosDXc1cN8FH5GDEZCnEhZSdJRxI6c+qvogQwrTOFDI1CQri6JXQuzHCIwbsuJ9OCTddPm4w+ypAIQUfS9weWZxlmpHK2YyQ9v+6B4pszTlckQb2KGcCnmoBoJUeydYeDjDL2LBprmka4LJ4gN4pW7AN6WpWhGmmtHFctZCwmLssZDUiP6qZTt53sPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hiWCnBUP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hiWCnBUP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGj2g4TP0z3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 21:43:23 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Htv24161816;
	Fri, 7 Aug 2026 11:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cCKloGllzigEUP5MA
	bIcYZ25DmYOKZWUADQmManzbcY=; b=hiWCnBUP93yj01P5yhetGhS7Vsew1Ryeo
	FHhY7djbFm6AaTNd4qkcb2ivzRanxulMkLZev/MzKBm6uWB+JW0WcEnJ2IHjq38v
	sZs0HkhdmOfQDTBpQ/zW1rYDaYnPRPwxBrpIx3e98gYm0O6Q6XDlC5G8qwHT8r3l
	5kgIZk3UVf6FqZfIYpbs1kCUXut6Jf61Hx7oLv+867uCGqQyDmhq3x3omUN9XUdL
	U4yewdvwvGB4NqDnyAgfmLbi8efklQfwuufNevErxJkSkvYgQCZGDAL3BtRar0f8
	zzTs6YByIGSu2p6Exom/CRJWiC721uWNO2b2/QF1PiGS/a8tMTNnQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyunk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfHlG010576;
	Fri, 7 Aug 2026 11:43:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyy9c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Bh11c35520960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:43:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76732004D;
	Fri,  7 Aug 2026 11:43:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 170FB20040;
	Fri,  7 Aug 2026 11:42:58 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:42:57 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v11 3/8] selftests/bpf: Fixing powerpc JIT disassembly failure
Date: Fri,  7 Aug 2026 17:12:38 +0530
Message-ID: <e827cffd10c37ae7d0b1fca59523acda38db1704.1786099877.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75c4ca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jFlzs3kxbzYMnpdfaSYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX6XU04/bZS/1A
 0PqlU15Yi8pqGp9egYJS7d7udYmxlwgeruAqeMiWECQiUsoFbIKbgR0dZXt/LzLp1Bjm6vbVyqC
 6igixGw0JhHc752toMVFlTgbDhEgO3Y=
X-Proofpoint-ORIG-GUID: vwJbQSvJheQEIjtlKJDJdlCzfUAoNobb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXw2cisMKuOduc
 VqfFPc3Gvi/rMcB3wNFoXyvdhuTEINwwuC0O2p5s+xGvvm3tK9VbIj1kQGutGkEgE8FLEbQdTg6
 snzgmRyOG7bKSMdCQD/JXOUtPB6L/Y0xybhAyFdE+p34oD92aCBFBbGsv7MMlmFBgymy8bBoyN4
 7ZyRaZVHQzV9/DjZCV8IQoWpZd6sLyspWk5R4SFMjvguOiKevzae/4JGlL3Waj15ZuRVNpQAk/2
 yZiC6pQLoF6z0h1XY0PErmRXwFfQlMKMCFpRXdj7u5q3znnsFWSoVbYS3Nh5prvJu5Ko6X/ZUSF
 zqIVpPBFg9Hq4b+AVYW3V4eRtXL3UC7TLWXrSJtpZPQ43Otqqvlz4khLGlJysJ+G00BB5njHrml
 Bwu9Swd14ij1D2/LHn3xql6u2CmSPAQfZB4aivA/e5WXu1V/5AG709TxTJi+H2tUHrwDnfRplby
 343GmwoYhQj0I3JzOjA==
X-Proofpoint-GUID: vwJbQSvJheQEIjtlKJDJdlCzfUAoNobb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

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
index 3558fe10e28c..c4aa1d69d3bb 100644
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
2.54.0


