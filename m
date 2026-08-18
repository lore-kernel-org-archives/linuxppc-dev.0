Return-Path: <linuxppc-dev+bounces-25952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25125C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPHFV5Gcnz2ySS;
	Tue, 18 Aug 2026 14:45:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787028334;
	cv=none; b=VrBFygbZRlDvGIqyIT4VOsCsRA1uEDt5lFwAVsRa6UXtw38bPvtlCKIf6GY8JdX0PbxmiwR80MzoKKijuDFSFDNw5NqG9hN4Pg7JlRaJEZlC2URAWsCWrSyi5eH3QOtcf65jeKH+O5t9+13M1xUO1isujAvpHOXpxwM0XRPnHEdkyu9LF7NzKFhB8FoOUcd8DN81Bn9qWz3uto11IWVafl2FBbvxrjwFtPVL/wzf8Rg9zWrTKqQSI+/ZefXkIk8jdZpMRmX+XxCp7SiimOlC0eDdu/pM0Lo8j536HXGhUJ3prPrt/MqaYdKxGtNeeeVVT/8tHiEPFpDpb1kjhL2L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787028334; c=relaxed/relaxed;
	bh=y5ydXHje6PqHCvFUZHFbkL4Mrbt+ZMSusvaRTitCHxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYs3H0Jg5KT+agZaUjLvYTcCXoKOH/MBth52NPgs/VFgVaUKPpAErs5lFx2HY9enGXNEcMn2cmX0i9ZV2Q71YdgyuD+UgKE7HN28mBeDDL3snO1ShKuMcTeNh1flfEAU/5gFeXNKjjmUbgLwsdUBoRQ+nD+oSQq3oeIRgSOeWxUU21nooIWRt1bQ0bCMXWCQo6lkZovWs2IQh6U0llfiDpFYr5cmZ7e8hZSdZ1olyzjg/YgKblyuX3rLs5fS8/zUmALlaKvaAp4wfLIZn6EktFjGxXIlZk6wPv9tuyXoRXwBHJGw5qJI+8h6awJG1oBMhmNCDS1qn7CA+/L2MxL9Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NXq3r9NS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NXq3r9NS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPHFV0J6hz2ySD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:45:33 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM2C6c2527979;
	Tue, 18 Aug 2026 04:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y5ydXHje6PqHCvFUZ
	HFbkL4Mrbt+ZMSusvaRTitCHxw=; b=NXq3r9NSZSfA5jmVS99n9kL7HOtz8hL2K
	TIkw1Cq8GTOXV/SsiLomEAYssrHimT6LDtlmUQ99sWJAiZzUeaGPrne6eHEBCF4O
	JIiH38R1RzyWCYlLrqKugjt16ug7tk1vIAPz6DLHCKYVBlcxL8cTFjEFtdyTPFbf
	YXvQGVPZUrNK6MwtomDIJp8vL3C4Xk4XqyxD+8H5AvtzvFq9xWgwfetHS0qpN4uQ
	08xNYK75d12spelpOjwgwN4XA7sZeh6c7jMPi7cqUnT8QYExLtGkw5qs4FLSO3mf
	fST+EGhEZ370iWemK1C2VTEltrHnNmraABFCdAec3a2lfgoxB9wMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkwx9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:45:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fI5G020824;
	Tue, 18 Aug 2026 04:45:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng95hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:45:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4jBqb49676548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:45:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B2AC20049;
	Tue, 18 Aug 2026 04:45:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A51A2004D;
	Tue, 18 Aug 2026 04:44:57 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:56 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 8/8] selftests/bpf: Add tailcall verifier selftest for powerpc64
Date: Tue, 18 Aug 2026 10:13:41 +0530
Message-ID: <0a70cdb21d953c55cd2b39a1754190d7542af165.1787027080.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX+LNFigaJ/w3d
 LFZFUnz8VckOHpKfFeDifPDQe5Q9KH070nU2b17yM9RMs6QmiRtwO6AvsfeZ/obe8Xp+AXxYWgL
 Y6xuvXHiKmiHRzhpn9qFR6VMJPk7ebzYLIhq8e5hWtC1VRKET9Z2IVDhiH3ThABiSAaSZDqwAEi
 8WBd/pUrU40R3GwTOBN0nzKI+3BcxNGxdJNedu6H1rCXv6+BKEuB87dmlUq6BTRtzGPCWpoBKtE
 +PF0nkl1tCPP1zFCNef5rY9Kh7mpRjfjrCE6sjL8gfpb2glFpXnvUAPwmqr+tYOF65nyqAGGQ0s
 kH8utaM/0hPzqz3zJ1M6cbZ93hHqJZj8bXhbTecjGqpzv2dhAk5csbOsAJicERv8H3jnrjqUZB+
 HjXDXX6zVKSMiW0cOetGPdHfxQc55FVDmegQp9C83m1qjK8MULh2g+rhrglRnYjFnvSvUy1c+iL
 c+DbeD/CZiQYrQqTnAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX8irZF6mbjsCV
 Du13Q/rQiapMkXElrwABEI4w5R0lQY1oQvGRVUStg2KUJFvis0RQH2v4z2ztu1uP6kigtlJ2+2x
 mcv1Xuv/qkkWSlErmIAPMk0wZtrFhoc=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a83e35c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YHohsJt5VkgNoF_SymIA:9
X-Proofpoint-ORIG-GUID: YXIJL93hMLRDANGdMv4CyMqJmXIBTaOx
X-Proofpoint-GUID: YXIJL93hMLRDANGdMv4CyMqJmXIBTaOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180031

From: Abhishek Dubey <adubey@linux.ibm.com>

Verifier testcase result for tailcalls:

# ./test_progs -t verifier_tailcall

#618/1   verifier_tailcall/invalid map type for tail call:OK

#618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK

#618     verifier_tailcall:OK

#619/1   verifier_tailcall_jit/main:OK

#619     verifier_tailcall_jit:OK

Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 .../bpf/progs/verifier_tailcall_jit.c         | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 48fa34d2959f..880c4636b000 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -91,6 +91,82 @@ __jited("	popq	%rax")
 __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
 __jited("L0:	leave")
 __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
+__arch_powerpc64
+/* program entry for main(), regular function prologue */
+__jited("	nop")
+__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
+__jited("	li 9, 0")
+__jited("	std 9, -8(1)")
+__jited("	mflr 0")
+__jited("	std 0, 16(1)")
+__jited("	stdu 1, {{.*}}(1)")
+/*
+ * load address and call sub() via count register
+ *
+ * Address materialization differs between PCREL and non-PCREL kernels.
+ * Skip the address generation sequence and verify only that the call
+ * target is loaded into CTR before branching.
+ */
+__jited("...")
+__jited("...")
+__jited("...")
+__jited("...")
+__jited("...")
+__jited("	mtctr 12")
+__jited("	bctrl")
+__jited("	mr	8, 3")
+__jited("	li 8, 0")
+__jited("	addi 1, 1, {{.*}}")
+__jited("	ld 0, 16(1)")
+__jited("	mtlr 0")
+__jited("	mr	3, 8")
+__jited("	blr")
+__jited("...")
+__jited("func #1")
+/* subprogram entry for sub() */
+__jited("	nop")
+__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
+/* tail call prologue for subprogram */
+__jited("	ld 10, 0(1)")
+__jited("	ld 9, -8(10)")
+__jited("	cmpldi	9, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 9, 10, -8")
+__jited("	std 9, -8(1)")
+__jited("	lis {{.*}}, {{.*}}")
+__jited("	sldi {{.*}}, {{.*}}, 32")
+__jited("	oris {{.*}}, {{.*}}, {{.*}}")
+__jited("	ori {{.*}}, {{.*}}, {{.*}}")
+__jited("	li {{.*}}, 0")
+__jited("	lwz 9, {{.*}}({{.*}})")
+__jited("	slwi {{.*}}, {{.*}}, 0")
+__jited("	cmplw	{{.*}}, 9")
+__jited("	bf	0, {{.*}}")
+/* bpf_tail_call implementation */
+__jited("	ld 9, -8(1)")
+__jited("	cmpldi	9, 33")
+__jited("	bf	{{.*}}, {{.*}}")
+__jited("	ld 9, 0(9)")
+__jited("	cmpldi	9, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 9, 9, 1")
+__jited("	mulli 10, {{.*}}, 8")
+__jited("	add 10, 10, {{.*}}")
+__jited("	ld 10, {{.*}}(10)")
+__jited("	cmpldi	10, 0")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	ld 10, {{.*}}(10)")
+__jited("	addi 10, 10, {{.*}}")    /* offset depends on CONFIG_PPC_KERNEL_PCREL */
+__jited("	mtctr 10")
+__jited("	ld 10, -8(1)")
+__jited("	cmpldi	10, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 10, 1, -8")
+__jited("	std 9, 0(10)")
+__jited("	bctr")
+__jited("	mr	3, 8")
+__jited("	blr")
+
 SEC("tc")
 __naked int main(void)
 {
-- 
2.55.0


