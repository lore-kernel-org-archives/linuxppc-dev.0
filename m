Return-Path: <linuxppc-dev+bounces-22939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA5CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 19:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glFBV07gXz2yYy;
	Wed, 24 Jun 2026 05:14:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782242097;
	cv=none; b=ZtLWxYlHta9sw7HLUDdBzDnPM0TJxOx4lQdNCYf+Ewp4FMXg45nta0kteyq7op94E5Brh4WBfA/wQxvrsNHG3jWxw5yzdz7O/h2z0gYWG8EEuMocS6n+/CE+vcEDT7bOHd35HrCSyg2TnfTv1HuKa1MF0awOAqXrGMbRnDV1AqSR5ki9OXr/TGynzT0vQA2UV/wakDnvwGexuS6qLaIsoJHW9yD/LEMyyzQE8ZOqqB9kDvlR8T+eqXeGo8o9/5Bv5Lk6ZxxH6DpGK5BJS9XseRvtwOgvB9jPm3+c+6z6ouuUC5le3+UtRN2prvGd61Ifz5D8bFQ0/1xk8rqUOvCw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782242097; c=relaxed/relaxed;
	bh=esOXrnEBsqa8PD/S6CVyx6Z8nYspUwbFrydWFgxBBEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDttE7UZQZCyWBxi9mcgjh+pqtJn5fcoNqtNHKOd+IjgvFUs1VCYian+X987d6nqccnFJYN5mZIs6goxIYIj1NwmENvWlNa1qZ8yzRD1XbLO3jSULEB1CphnpVKM2l9J3Sjt8Cyb9lwlSTJ5KPNTDaorNIMc610+IxugjP8JlKcuWPjvDpbtp3dyT+v7kd0Fu7SLVbRGE/j7U8RphvRoaAwONFxdr6JyqT9y2F5dwnhjG/aZ6E1CHx+7A6idJI8lALJS3HmmdKaKJxWGDD1v9gMOJkFyk/aSy8Uj+BYLsxJUxBaF8uEEigsQut4hSwMICm5Q1NjFtC16IDospa/sXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pSTEIqbX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pSTEIqbX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glFBT0np2z2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 05:14:56 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmmeo1858095;
	Tue, 23 Jun 2026 19:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=esOXrnEBsqa8PD/S6
	CVyx6Z8nYspUwbFrydWFgxBBEs=; b=pSTEIqbXIEL2ThTdlBImqXo1NX9z6j2MN
	EbIXiORBQ0HqCiz0AQltSOPeoyIkHbbppBqWkhbAhBRcbT4OqdaeJOGJDtg59iDu
	ix+3e9JDFhS8Qj3zeBvY/fZnzk49ai9MJFzokGAoQWwuvZJ5jmkD8tqXqlYZc9Bm
	w8ZzrUoJxdU9DfAwnQ+pazpdGQprFHGc+k43hQrdJS7XmVf0PJkOAeZ1sM+867Df
	DIQ7Nqb9RJx6RBMjv9s22PTftIFcZLA98z32XotCkm96ylnKa5Hl4xzuVHooLzrq
	Cz4PV7lY3su/C7k5rlVcwcnsljt72Nd3EzkIQz0badPF/+66vQ74A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hrnax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4hnF002112;
	Tue, 23 Jun 2026 19:14:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phcw4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJEbMU49479966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:14:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710052004D;
	Tue, 23 Jun 2026 19:14:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D4682005A;
	Tue, 23 Jun 2026 19:14:35 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:14:35 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH bpf v9 3/8] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 23 Jun 2026 19:14:06 -0400
Message-ID: <20260623231411.6216-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623231411.6216-1-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: k8mZkOqQ2k92PrneOyfGX7KP7hpk1iqf
X-Proofpoint-GUID: k8mZkOqQ2k92PrneOyfGX7KP7hpk1iqf
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3adb22 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jFlzs3kxbzYMnpdfaSYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfXzAEikBVaj89/
 dhvJKFsshOBaRsyTj6AQbqA8klrBZ6rzVexdo+MhBlCvrAJY5teE5Aoqs0hdk4CkINEtphcbUMw
 OlvqE19tByYAaeSilrXld7bj7zmGZQ2/CKcDIsTIrDWLGlbQ4TgmlnNfOlFWD+IRk5yUe9/cLRO
 ALIx8ulR7bxmkBZSuH2EEECOOUctZ4mbhy0BCSvn6cv9PX6FGUWNrAUWUuQbLWnG/+vxH5JCkHs
 ZauiK+TfrqhF754tIYHsmH6Y2K56MeAK25GXq/VcBNWi9xtBWAt+mT1adtEj4P0KK5d+/Ri21oa
 g/Y5pByfaL+MW+R51BiWxXhE5f2awdbRTgH4jHgtlTDlsgszXmgR/ULOhw9rjWbszabcycyQq83
 RP3Si2XREChznW40SoQJls69WVDVcqtaUD6NY3v6BNDlqUVOx4yVGOIn4BxM0/Yd53lz2T1eMkD
 02OUOjlyXhm+Kwhu4ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX5Nsn/o58vfhD
 mzd6qF8THcke7Jda+ls1sB7XhEKJr9G59NnLYqkmnQ/VYt6CZc8rAsqX4P6WMsKijxM0KDxwuXl
 i4mccm3xUUtermZHmwIx7BDN+5a2kes=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230155

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


