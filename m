Return-Path: <linuxppc-dev+bounces-25062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DADC531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:46:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dVn2ZDbz2yqq;
	Thu, 30 Jul 2026 15:46:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390401;
	cv=none; b=NQv28rvMaBovETKvIPe/CwVIsD8x4B0KnR8f4eKkKK1q4GL9devTy3fSeM86eOsOwBXTV++jKF+xp35BJWTyLneCH9wCmS38/vdNZ/LM8bYpwK3j9u9dp+ujb/qiiSaBtwXnNh0/mr9c+6bgc+CkfI0ckZRBUBsT7qp1SpQ5f47Gx8ILtbNRfh6n0CSwLAsd+zj+9GPp1+7fgx0a3JCjVWDgeHMAbMKu2SrG25v57BTX4/DJxnq3IwQbun7G9fQUmqRpv/xGmGTeFREXGVxtXfedE+ZUVJFrDDBuxWmI/T4OC9cz16OZnp056gfl+kgh+Z4GTGY5s2JLAETXMc8iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390401; c=relaxed/relaxed;
	bh=lYQcFjm5Tz7CZkimeWHcrXDTk81MsYoSAgGM9iHh7D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDEVG0/cpcT7DjEPiF9cfedtX9Lwh4a5s9eNToC/y+vZhcW7cqH1yHpJeAs4VXRfYh3YrscxjLSu6NyCrqYnWnQkEcJ0cq+OjAU7R+U3v5v+7SHvMjTjPIVjb0fJwzSykZ5omNGdBsKyehiCnqPPBdp8YKgw8qeUaRP9yb8Iaw9AouycJZ/SjwrBo29KKZ7kOZTWt4r7XsvlQwoRh5Du5yXVi4ltFqPG9yhyHnPWNa0KRqXtusGBPOKf8yxNCRhG0xnDqclipIt2VJPqswLlb8PkmaUmZ8NjILxtdlbdl8pBIVGqwyWrSG6HprceEysR0g67FpnJEZ2jRQTVdGWw/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E/beDa0x; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E/beDa0x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dVm50j2z2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:46:40 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mWcY1949656;
	Thu, 30 Jul 2026 05:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lYQcFjm5Tz7CZkime
	WHcrXDTk81MsYoSAgGM9iHh7D4=; b=E/beDa0xRk4usstUShlNxwoo2L7w+SE5Y
	OrgaoE9eQjvdfTLrYvH3inhPbZ0hyYGb89i5WTHRKvlvsUu3HB1mjbbYPh0sdtwH
	MueY/yHk0i+5z3RvcT0LG1zLBtMfDDyi7IioaEf4o/NLPrhg7f6b72PN47doPihV
	3EEV2xvlJhBj04RZA5onKTmqmKXpXs4osWJQwDtbPd4M+Or9LuJZy5Sl+ckKZqCM
	qBOdoUTAcVWR+4lhn3flgrbN/qMEYWpaCkj2vNtu7r1Gwk0t1nWdaqprHt3gyiRg
	mqw9f9g6JDiX80L/z50Hi/sdHwffrWW8FekkftwaGubzel3DwAzOg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd5c49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fKDn021706;
	Thu, 30 Jul 2026 05:46:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y9p33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5kCFJ29426012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:46:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F22AA20040;
	Thu, 30 Jul 2026 05:46:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD7FC20043;
	Thu, 30 Jul 2026 05:46:08 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:46:08 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH v2 1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
Date: Thu, 30 Jul 2026 11:16:02 +0530
Message-ID: <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785387718.git.skb99@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LVSvdAN3P8yvUrS_40NVsyJ4GFqp65dZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX1PVch7u1owBl
 PbxBG91M80J24+NY1JbLk/EI+awMOgZhpZl8w7hlECp+IMAAzSE/xHKEGY6nWAdsCOgoOo3CIf3
 D5ERiJRc0zbEiX6hhUUPqWeoVu7C6bI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6ae529 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1PX3H1HrtLKQNjst9QwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX/NmgTy0eoSU/
 FHcC3z5NaolrJ0sx4upmgMBgJmGvEx8tSRrgPZrLTGHE82ypUYttHF4iShvJ+GY+zuFpleREbpE
 pHPJEeNvayhXUEci0cCAP5oDcRtak2oXJq6DMXewcjdiien8zJGGa9p3NgAKP32mOpHrTXFR7Qw
 pAYz8yPkQUGVqceS9SJqn7n5d7i0oASuXSsWH9F8bkb6tWfdxt2o6MI1y7Lxaygv2tzOH1F1xUy
 4rh6rJZcOFyN2z9PFC4aR/ZtVtALdsLOKN767u4Q03ghJhSsKmFYr6MtxP8UNWDvBBKePz2Rjf6
 nEmhZqEba5T0Zv7usaE7hC2RjEzTaNcL3IWBmkIUwcH0YLIUoLvismGDH24Ye7KR9uuYr4vmkWm
 /6Mt0O0v5rMsERdlUAx9zVEc4nEbZ+GdgVRZNcPVVcrv8+Ijhx4JqCT7P9chuFRIuAdbZutM8K1
 dqxsQoInX9sLM1/PueQ==
X-Proofpoint-GUID: VNMakwWAtmfPvUBiq6yIIq116-Y2ehz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

From: Madhavan Srinivasan <maddy@linux.ibm.com>

With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:

  CC      mm/dmapool.o
  CC      fs/readdir.o
arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
  475 |         int ret;
      |             ^~~

Commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
introduced "ret" at function scope, but it is only used within its
respective conditional blocks. Same holds true for reladdr. Move both
variable declarations to the scopes where they are actually used:
"reladdr" to the CONFIG_PPC_KERNEL_PCREL block and "ret" to the non-PCREL
else block.

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index dab106cae22b..fc9db691e820 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -471,8 +471,6 @@ static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 f
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-	long __maybe_unused reladdr;
-	int ret;
 
 	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
 	if (!func) {
@@ -487,6 +485,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	}
 
 #ifdef CONFIG_PPC_KERNEL_PCREL
+	long reladdr;
+
 	reladdr = func_addr - local_paca->kernelbase;
 
 	/*
@@ -525,7 +525,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	EMIT(PPC_RAW_BCTRL());
 #else
 	if (core_kernel_text(func_addr)) {
-		ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
+		int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
 		if (ret)
 			return ret;
 	} else {
-- 
2.54.0


