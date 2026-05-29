Return-Path: <linuxppc-dev+bounces-21673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D93ECD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 21:59:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRL4M1Dk1z2yng;
	Fri, 29 May 2026 07:59:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780005571;
	cv=none; b=hjzOnVzv1WIiGnCAGJrFPIdkhWpS8jK8qUCztMBKtPjzOtHqVRkG3rrgzYf5HrxalmwkxVzrX1oto8TDDWtyLZadYR6LEAASf3Wz01wSvwB10fKwp+VaRiWzzuHP8pKKvktSh6l6aN5l5epD4av0nVRZDQ8eSH5D6WcCVrTT5F1yPq1ROV/1KX47qU0RL4UJH/fhzOTgj9m84HmrEenQJ5EJoGEfTfZzCIdppSdd2eITVzuqJRgZBg4uwriUVP95aaSW8J23TStj6vmCczt5K4qgy80ynYSwkIKjPKFqbxrKecMWKs3xeM5Gycg4QqKfZpDUkzcCrVUkqNG8DLkKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780005571; c=relaxed/relaxed;
	bh=aRkv0/9e2kWLsVhdMfNOIshRfd2IX26TAh1fcz+E4Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2VKVQI9DFPjvqRz/4PDlLDwTRnoEIX8okz6l0oWKifZe/SmPyI5+EU4XxEe3uRMap9qpp1ok5Nh9JUscNBCiX1hFEaJboDy1N2KYfGw8qz8TBrjOaePwzy+yHmxT83rIjkVxYKiYoc/aL4dJXUZM96mSmL+VoJdg5HrgSBAgfK6K3lTGE2lDz04L/CVvV49B/OWfI3luXjBg+mXUkPob++gbxF8uYeOTrh9+t0bUzOX9+W723W79nFAyJ4S50FBC+IQvw9fO+dXOPALD6y7pGVYScqnv1/k4JQareTntLOz6jX2PrHgfZOIcpBQOhXJUcQXmHpAym6vAHs0z30IbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LC1Nap+r; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LC1Nap+r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRL4L3S6xz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 07:59:30 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhkq1684644;
	Thu, 28 May 2026 21:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aRkv0/9e2kWLsVhdM
	fNOIshRfd2IX26TAh1fcz+E4Cc=; b=LC1Nap+rIdpsP24bN1rU4jnIRJyXJI+W+
	HRIprMuJfyv6JFGfR+Y7NBQwQD/LsgnPXRx3AV67ZyNdNLzOp8FNbhWbWiPWl/ZA
	7vQ6DafB5IcsDRiKa44td+f43ZdOiiboJ5AqocPhbK1nn/48dAnyHniGJlbKmSN0
	Dz/LRVVOyAa7a6RfHMFaYpTDXXMkH65kQlnsTj3oIGcjtN+bIrWLWV9UtLpoHsTx
	Uo2PTOXsur2pA6L9qwhaqg1ZFVLP8GJJEYsa1Ud49KGPfWZEsxp0KjdaVq7TMsH6
	Er4sCk4FX73g7+yyTRoUef+IuRM5whjTjwuiaZ7t9784ujwoPIsBA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884deed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SLs67t019591;
	Thu, 28 May 2026 21:59:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbt8ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SLxB1Q52363674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 21:59:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6233A20043;
	Thu, 28 May 2026 21:59:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3171B20040;
	Thu, 28 May 2026 21:59:09 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 21:59:09 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [PATCH v6 5/6] powerpc64/bpf: fix compare instruction emitted for tailcall
Date: Thu, 28 May 2026 21:58:54 -0400
Message-ID: <20260529015855.364704-6-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a18bab4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ChPpPKTfPU_lHkPiKQA:9
X-Proofpoint-ORIG-GUID: RKFHZhfZ9yVJ3y9HGRpjKep5jzcge7uv
X-Proofpoint-GUID: RKFHZhfZ9yVJ3y9HGRpjKep5jzcge7uv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIxOCBTYWx0ZWRfXw1RZX0ZfC5H9
 A+6nSQnT0E+lViYN0E/KkA1AVpoN2mfHHmqADgl42n95qNAYNVJPqVGhMuxQVizvisXLRhrEmMk
 LuRtnmoVXjRvJqJA1oep1WE1QdExLsDLiITTssQ7AIp8nJbBHKIc2bGGKU/v5Ytw4+IHWSG6U98
 503YYkOcxTCRObbQHVcfjJL9wI0oLaDrv/14KnDN7rPaiCbT3+6gJPa7MDCnV1IEveX7XglliDC
 0hWDLthb1+GcAngL+ffaiKuqw1xLbzZH4k0mks/nSTd39leNjkazNI35s7PpGmtf+H+E2JeXyLU
 j+SNNpR7ufU6wmVYfhB7L261Ao1cNleijOC0GD0VUaM4fYdUwNSDXRO/QLWKb1HNKjUvdgQx5Ag
 JoGCkNNw+4yDHeSuYXP5wfQp3gFx5tRi1wV1NbePYyVuNrE9s6AkjgvaOgnQiEzi5QEpVHH1VhC
 ZETYDg2LTkjl/pB0kPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280218

From: Abhishek Dubey <adubey@linux.ibm.com>

The tail_call_info field can contain either a scalar counter
value or a 64-bit pointer to the counter, using a 32-bit
compare (cmplwi) only checks the lower 32 bits, which can lead
to incorrect comparisions when location of counter is near 4GB
boundary. Use instruction cmpldi for accurate comparision in
all cases.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 9885a68f64f4..0844024845ae 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -762,7 +762,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 * Setting the tail_call_info in trampoline's frame
 		 * depending on if previous frame had value or reference.
 		 */
-		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLDI(_R3, MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 885dc8cf55a2..74fce3cf6c5e 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -276,7 +276,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		 */
 		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
 		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
-		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2),
 								-(BPF_PPC_TAILCALL)));
@@ -651,7 +651,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	PPC_BCC_SHORT(COND_GE, out);
 
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_LE, 8);
 
 	/* dereference TMP_REG_1 */
@@ -661,7 +661,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/*
@@ -696,7 +696,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_info.
 	 */
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_GT, 8);
 
 	/* First get address of tail_call_info */
-- 
2.52.0


