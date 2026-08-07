Return-Path: <linuxppc-dev+bounces-25563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF98C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGj2y1BDBz3c3g;
	Fri, 07 Aug 2026 21:43:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786103018;
	cv=none; b=mNE1Y09UkiM0URtMJ+JPdhM8bLOFDf4XhY7zMoACD9U7p83NHItzU0vuWewG/e6g+Hu6UG0t98m3X/rNRKJYtNn9pUoDm0V/+iNlBdAl+6fbXYcXbAKTXZwA+zBkh8j9iC0nKkgXOPsqBq7upWVPcQeTM103nCdPahoDv/GwrO38CtKHehYjQQGe9zSgrRpfaIzsQPPwOF4QrEqdeXCJnRJS1hkXT13uDk3wx2AtemB/J75vSQ/PEM0KUc7BOH567ZUB7nsi34UKtNtgvcwAdM/cUf52qPttyIswJZcCbo93ZflN9axpGhNO0OKuZnIivioEnKKxVMIVO5/sL2zm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786103018; c=relaxed/relaxed;
	bh=K3xHIId4QioECWMhnTB8sgfTzXaWXV0CdJrDB7JR0yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+AwC5m3GII2icUL1t+EzvSILlgjDY6NMEpk7apX/Env1TBRrGYakrT7jpdHO+rCekXk17QdDWoTtbXscE2p0LMQ0BfnAwA1dc8FgijIaQyMs8pjJ2kk7w9L9FDBgoYQJ0tozsw0oMeWLa2XouZV3RPun1hq1hBSIFfw1Rn2XRK2m5LcB86cmUqo3jp7OJyqFnSDFmyBVNh74zWZKrBIquleL8qptT8ngjdnrvK5ilwot0HuA3p/d8WcKZOsUELd7ymmT38dl/MqHWy22XGEnAE/TZhZ1WTk97LNLfDfreQl3P91Ek15jfHfNqlecWR+5tWhNp7T1RorF4jBlMdTjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1abmFF+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1abmFF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGj2x15Hdz3c4D
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 21:43:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hqco4134309;
	Fri, 7 Aug 2026 11:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K3xHIId4QioECWMhn
	TB8sgfTzXaWXV0CdJrDB7JR0yY=; b=e1abmFF+zZZEeGBJMYq18GACpMMGDzLQg
	yRhUHqLzCtC+AeUC6OGv7wckM3c1A+YZQJke5MFun/Zi39uJA33jWe0IIqDeNWuL
	uT9gvuFImy1Ui6RjaYJc9qLVYLi/IBBuvkFqLv47WEWdZ1GPgy7HdAeLyHr0cvd2
	1H4Oedf39/CcYaLoqmQ+/FrQ8+JieU/MukZMvmbyGhplLUeyR24LC8e2Sqcqm4Qc
	BlwqdLZ9tXSFnhnc76zwYV2lGRUcTGrTUixiVOM36vVvAyn7d358hWAIFYU/uQVK
	Lx7Fn5Y+UmnWAuUe7eyDAtntA74la+LIOf/l45nQpD7PZt5ICYJBw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043np5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfMcv028381;
	Fri, 7 Aug 2026 11:43:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqe1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BhEXh49938922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:43:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 768E92004B;
	Fri,  7 Aug 2026 11:43:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D0B20043;
	Fri,  7 Aug 2026 11:43:10 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:43:10 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v11 6/8] selftests/bpf: Add tailcall verifier selftest for powerpc64
Date: Fri,  7 Aug 2026 17:12:41 +0530
Message-ID: <8fe0b35438a04876bee2dbcdc94e28bd919dfc40.1786099877.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX5kB2c2SXOf0D
 /wHuZoVGbagAgU+Og6Q5gm+TpXoRwo9xMhh6QZHQGyv/jXNSz8hvlHuwcuHKc01JknqIMyKwCQs
 Edx2EKyfYPNwB5O/CBA0TQ/BcPsYLO0ZWl1sQ/1PsivLUcZ65MsxtGHO+FJLjOJF+aZ3lyo82fz
 MqHbuWc2SVlXqbDtJc+QJGlVLbtxLrXxPmZOCt7HM/qH1nMYn7SHUpbdm8MTVBfdiTtZQMjU37O
 50p7fkjPkEF5gWrmXrAusu0R+oHA3fYBeaaYFeRN6JLZ94dFdvYgQjja2xcFbfI2jnpy+5ekESl
 9D/vowVUvfuY6K8XjHe2OKtIkIo7ekbnMVZd82vq0Hw5lNXlT0K4HheGwCpD6/37d7rqN6sdN/N
 uMENkGNr85HmnsbnnXWx6luePPhjgzYarZ4KbkqWBX8ZzJQOKpnXegmVb5kTb5tlJBxvT4gkB1w
 W9WiE1V5HuXhJ2dCW5A==
X-Proofpoint-ORIG-GUID: vFE6k8wYvVjZe_gBVLtJIDMGW47OOh4G
X-Proofpoint-GUID: vFE6k8wYvVjZe_gBVLtJIDMGW47OOh4G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX69IP/AqFlPsa
 cXXC1oH3NgqK9obhORPkKOSJ3D0OSXA9/PezJ2U46RPsPa/WIhaySC2lwG6pHVmomU0qrhOSM9H
 uUER3avYf1Q8KeLz0HqPyJyx1Noetqc=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75c4d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=SaLraETjdKAjPQJzA60A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070087

From: Abhishek Dubey <adubey@linux.ibm.com>

Verifier testcase result for tailcalls:

Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 .../bpf/progs/verifier_tailcall_jit.c         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 48fa34d2959f..182302ff1db0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -91,6 +91,81 @@ __jited("	popq	%rax")
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
+/* load address and call sub() via count register
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
2.54.0


