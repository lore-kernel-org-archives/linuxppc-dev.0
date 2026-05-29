Return-Path: <linuxppc-dev+bounces-21671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35B5CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 21:59:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRL4B6p2mz2yhb;
	Fri, 29 May 2026 07:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780005562;
	cv=none; b=LfbHApXbHPeRJXDWFlEsk7KrQ/AVSOyN3Gz17E47W4mUPYiEnsSPh4aKr4KL0OAW3YMZ19suc/8HbVkrUrKujbRzdcKdEFXuLhhFKoT5TiGpGNTSv4unNBhXHP1Je/1jWOSQPWerge57pK5mEtCfBL531Tjas828nsDysHy+iSt/74bvper9T6totGACFLQ/ftyLSWKYu9unR2PXnFY8Tx5mkrS5f+42kT3YYPsYmvZRGvOkp/cTrtE/L+Bf0xe8QUHaaAs41/zTT8YKamM6mNScs/kYml/WnlZ+DmZ8/PMPOvAy11VP7BO2S9xZY8C7eBs8oVNC+ivb049KUMDrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780005562; c=relaxed/relaxed;
	bh=p/ANXN7xmdoJJKSQOggUvgC7cocbNYCFrvBlQ2zIRrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEy3CH/4BiQiOShH/MM/96CGh814fDO8rRZjGmmMYgBpXtTJgJK+Oggy636QOD9e0FM6Hq8t0VlJfKTDvvl9iPhYZ4S/ujOsVE4IQC6nBYTJpDciMYjvtOeyRV/zuExLmdVM1KHvLvoiYF8dJBxeZ0dwJmOeDZjl3MCgGDmdRstM3bL8Kk2bAp8rkKnD3RmE3CbhZ9jfzFCDjpQO9JKLk3n1OkCOS4oQLt6bJC7PmfXto1WPgZclR28GUYdRQwsPN6m0alWIziRnOEo/jzUU6dSigZoL9HlbfcAMw92yBsfbGKw+mlGK7HDaE0nTbI1LT9PjOOjUrNI5ka6z5Z3W5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GLGunalO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GLGunalO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRL4B1jnHz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 07:59:22 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlnog2133405;
	Thu, 28 May 2026 21:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p/ANXN7xmdoJJKSQO
	ggUvgC7cocbNYCFrvBlQ2zIRrM=; b=GLGunalOo5A+j6wf2TXy2t5Iq/ZF+sgEZ
	DK1GnzncsZzyWswRD8o6l9q8gSZDMrBu5xptfTGHj1b6D302E89AyQJolQ86uEDU
	oc2eI8kJmwwkyU4odAzYkmM9fJD5WACr4TeZ4856Xgk9+u+LdMS0sA/v9OiLHDi6
	b9DH3Rxbfj9cz8hcYdGztv3hg45w/Jjvt8K8bSJbOElji2g22sWTB1fy3nDWt2gk
	vXTi49rTe8dCNvQaCDLkqgAtaDTi4CIwNZXTdvogpOMCZFO035JTgfowfSN8bN6i
	6keey1gkA9uhwpVnqojCHzP9PjqGvX36yyGP5PNzVEpBrcvIr9myg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887n6ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SLsCPx007651;
	Thu, 28 May 2026 21:59:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrba8wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SLx29C39846232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 21:59:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A51AE20043;
	Thu, 28 May 2026 21:59:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 988E320040;
	Thu, 28 May 2026 21:59:00 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 21:59:00 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v6 3/6] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Thu, 28 May 2026 21:58:52 -0400
Message-ID: <20260529015855.364704-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529015855.364704-1-adubey@linux.ibm.com>
References: <20260529015855.364704-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a18baab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=BG0PCUMEzKLNx9Y0HWgA:9
X-Proofpoint-GUID: Rc3DsfUURVevRQ1QSqZcHDQ1qO-gkgM8
X-Proofpoint-ORIG-GUID: Rc3DsfUURVevRQ1QSqZcHDQ1qO-gkgM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIxOCBTYWx0ZWRfX4cd2W1zLjorL
 QWY8Rytgm1v294ZWbFWxuTGFeeD113nLzSeeznpwM2c/tuIH9SZc68Ep5YfMoRna5pNZgoxbDui
 hOC+bBh51Z5AkSDJEqt/6iVghpYvNYjRzs48RtWf4lpirnPKVgiEuy57Yi6nyuNucdAouKOj/L9
 y5umBWIkKl6YsDjYZcoFppmLpiGzB7X43lzHmoenTqrifobL8RdmcBAy6Mbi0tpJCcl975UFSEB
 XHJdZrChfU/XiR76tANWAIhnT/bnkVVQ0opxEcmJmmrhEbozhtpgmrxgJgm0HxaISmC45AgDwO0
 CyhfJzSLS0VxrcOOtp4NrbLvdfwOsw+HBrpCKcfuyc/cDmym7PutQPbRI+yPzZYQdmdQkL/MzlO
 iWuV1JGfeIUKUu3kC/DXuur5tI604fU+WbZHSJ1gMxQnFobw8tvW4nXHUMLbhTFgBVyDbaFTlnJ
 1omJN52Z/5P8+DGHsoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280218

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
 .../selftests/bpf/jit_disasm_helpers.c        | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 364c557c5115..a6d10cf456a4 100644
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
@@ -216,9 +218,28 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
+	 * which can't disassemble to a valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (triple) {
+		if (strstr(triple, "powerpc")) {
+			if (IS_ENABLED(CONFIG_PPC64))
+				trunc_len = 8;
+			else
+				trunc_len = 4;
+		}
+		LLVMDisposeMessage(triple);
+	}
+
 	for (pc = 0, i = 0; i < jited_funcs; ++i) {
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+		/* Disabled JIT have zero func_lens, hence underflow */
+		__u32 disasm_len = func_lens[i] > trunc_len ?
+					func_lens[i] - trunc_len : 0;
+		disasm_one_func(text_out, image + pc, disasm_len);
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.52.0


