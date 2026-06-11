Return-Path: <linuxppc-dev+bounces-22490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6698ECD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 11:40:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbgg73vJnz3c2v;
	Thu, 11 Jun 2026 21:40:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781178003;
	cv=none; b=h1CwfMn0TiOjbyZabnpawC1WqypE9i3nvAZCBZkBk1y+FuRv+Oyi988W7Unk9anXQue67TerbB8nMyrxygT3gT343ewBLu8yfmPthW6OxYe8xIF/cFN5LYgu12pox824kRsocNEvUDpC4OmoTx5+q+GDw/WyVjxFB+xgABd3JWrDASJ6+fxmnDMtVu/LoNCSKi+8A/mtlRFkIekHUcdNouhrMUu/ortjZ+RtriVIPn5md1talY64mlq5DIvba5HpMqmhRs1jscdXcYnYbqEZrFsSubLbBlR9DFiwc0H/aHjuEEWkO97dk+mO0fIoESt/6oEpzBTXXr0IcyU44es5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781178003; c=relaxed/relaxed;
	bh=G6y18mncZIgt5K/wZ7XyJ9yInKvsEdVikmQT6EfaYy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvlfEwU8Xcry8vII912hlcOZT6NLtmNT4kaneSQmYrPz8bWnnnvine5ZylQglm8VwKx05/yIJzY+8T0AqG+LjzPUGQNFbxXO1rVHtQaBGWx0pJK4NDcn+eFCnTiLD/3V98SL65s+zauLX0JEi9UKEQb7dK0aUb4Duc+GhgAPYcQIMPWldHZXRXK0V88FMd3oFQfjDhOy/mIinbBv2XU4+Zv46X7PBrpxx+4R4pIpeCyxyNEnXrB6+W9WPyCXVJ8KvUHJN7lj/YQu88UBjbHStHW8VIJs4fgSGLY+uk55qmAJs8e/a5k+aMBdRwQyNqIZoX16ygjzM2I+2D5vpbAUtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KFAaqtNJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KFAaqtNJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbgg65D3pz3brD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:40:02 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3Q33872812;
	Thu, 11 Jun 2026 11:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G6y18mncZIgt5K/wZ
	7XyJ9yInKvsEdVikmQT6EfaYy0=; b=KFAaqtNJJS9M53b0X4bSGlYFtbSDjpKyo
	4D49uBZOHQbPNvm2Pi0FcvDqOES0tOAL40Uqdg3OzuBpRAJD9pfgtWjkRIA3EKJ3
	bkPmYs2QLIUEe79Urr25TUQ0XQagjHqT/OwCZokplwoCS/nB2FaIN9Hu3wn3npuK
	zQc+Tjv0K/KyylAqeZYAuC59KTHCEj/PDFxGtFEb//dWr+LSy66Tk66EQff6Oyoz
	nuMcMYVanhH+b/RIS3DCRmpTKW2JMN2cTOJCIRJhopxyUGz8qmDD/bvZr4q4thls
	rVbmX0aiILp1AAEoh3zbQQQMX/uUrxPV+r4JyfZY+t40NA4nVs+zA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8eu5tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BBYgnF004679;
	Thu, 11 Jun 2026 11:39:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a2yc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBdiJf32833844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:39:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E02120049;
	Thu, 11 Jun 2026 11:39:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E95BE20040;
	Thu, 11 Jun 2026 11:39:41 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 11:39:41 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [PATCH v7 7/7] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
Date: Thu, 11 Jun 2026 11:38:26 -0400
Message-ID: <20260611153826.31187-8-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611153826.31187-1-adubey@linux.ibm.com>
References: <20260611153826.31187-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX/lrTLMYd8nPA
 ZPexYj5ezPrwrn3RcbZulW7v2DyXnrJ6L7jAZtjjVRaK+83Mu1Elh2LqmAwTjMz6ii81NIEzTgo
 xNeqYDAueZosA2Lxe/3IvCsNuL7buC7C4wIlHQgdFRBTXGFph4fCJlFwWQFA94wz8JJKPunsnww
 Db/dW1X3ngsuRmFpXACDeeTn8k49zaZ9QFKh4tiAZ7GAmE3DDqk808mCIxHqQxwaBxhQ6ISe2ft
 fEzVpRN5lJfYlIdJRmG2dNV+IDMugU+vA/xsOWylZJ9TSJEKyT4dPVgx48lLDri8/aJutZhe66C
 wxAbxAbbNWvrs+ViHhmbH7xi+4sROYIzCJn0A5mU352/nclyYTOoGqsFgrL4mkn9vC671UwAixV
 EOeWIkii54nzdXcwlVs5w8H9TicLGHo2yWXVu1U20M5vtQMV7Wgl4JI5ABTGdAYLQTI4NygTefJ
 S4mlZlbHtTHYDcpOBUw==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2a9e85 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wpy86o5_7BG6Z5BpgyoA:9
X-Proofpoint-ORIG-GUID: _p0xeLb9uORoUEICqLbX58bd51zhV88K
X-Proofpoint-GUID: _p0xeLb9uORoUEICqLbX58bd51zhV88K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX4jRI4J3YheYE
 Vhn1l9EgcpgVYNK64rI7cLyJ8MVSC9bEHUGoi0LLPrq+DcMkUKXwZHC7ew78L2nSm7tMrBkdVM/
 joB9KxS7I5iawMVUpu8kClnBhZcTI9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116

From: Abhishek Dubey <adubey@linux.ibm.com>

During pass 0 (size calculation), exit_addr is 0 since addrs[fp->len]
is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
epilogue instructions are not counted in alloclen.

In later passes, if the real exit_addr falls outside the 32MB branch
range, the full inline epilogue is emitted into the already-allocated
buffer, writing past its end and corrupting adjacent memory.

Fix by ensuring exit_addr is non-zero before treating it as in-range,
so pass 0 always falls through to bpf_jit_build_epilogue() and
conservatively accounts for all epilogue instructions in alloclen.
Also conditionally range check alt_exit_addr directly.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index b36b55f12a8b..470a359b7807 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
 							int tmp_reg, long exit_addr)
 {
-	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
+	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
 		PPC_JMP(exit_addr);
-	} else if (ctx->alt_exit_addr) {
-		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
-			return -1;
+	} else if (ctx->alt_exit_addr &&
+		is_offset_in_branch_range(ctx->alt_exit_addr - (long)(ctx->idx * 4))) {
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
-- 
2.52.0


