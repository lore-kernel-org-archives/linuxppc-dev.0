Return-Path: <linuxppc-dev+bounces-25027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C893CC53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 16:04:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9HG86ZqTz2yl0;
	Thu, 30 Jul 2026 02:04:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785341072;
	cv=none; b=AXyoZ7KC26K5LgYP7wUdWdHmpfY1D9ccZg+6lsxVuodRW6VmQqtQTAEvLsdWXBzE3ry54EbHwGx4wnHXzsnxlm7RLMd3BaXJx3C+52RaUKEX/+boPi/EysPunGHOKaRsC1SZAo6dub/9dw+TLCK/1DU/px/7+88XsH++b5tcojEgFSJeTQrt6sxh2QX80vedkJGauxxvGw5hvS622ViaTwRrvtRifXYR4pPU3ZX6Mqxs57PSFYFreZOXSpxlcWKHanhByw94bgMRC0IxDbhgWfOAfWSDtfDjLMbTEiagWXuJghFN4QBZASiy0DfxGz90XpoHRuQVrxI5z20UkIrD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785341072; c=relaxed/relaxed;
	bh=V1TZfHW8A6F/m6XoHQouA+q+2yZ9cBuD1NkbpQ5EKnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ7UckPpphu95gnUjlw2F9SGDCZkGmJApD+FwnKeDJBRJ2x1D1Jj6cK0ckORb5DOIHZDj8SuzkJs2vvke+CqwnolUQltZLafsr1ncYs9Hfh3RijKWc4iAdnFqDxeB0tW90cSLFFvttjHwBgeEG8H7HHvbgiJ7MX20v1dai816Adn7C3/JgpAO1mLap+25RifGM8SEqqv6VuRGUn3JBbQb3cLcXWA65meimWlFwQKsvlv5zheJg5zyUzSYsefgKLfyhIeI2zcLOPzjMxBCnMmvYut8e77VPlP2JocMY5hrOYZDz0vmS+AYGZ62vizbq5yNvzbW4V8HQDx4v4qyBBYkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bXR2blAM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bXR2blAM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9HG81PyFz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:04:31 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHcJd282799;
	Wed, 29 Jul 2026 16:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=V1TZfHW8A6F/m6XoH
	QouA+q+2yZ9cBuD1NkbpQ5EKnw=; b=bXR2blAMXelkyilVWjBi8p/Jvq3p2PGF1
	TKz6zeph83A97rx3LHD6FkPffPq9R7pOVmxLC3ubrTDUl18wRf5yGCfdrX2vGhHZ
	qwoArs2vWpeU9oW8g9DTjS4mPHZvCkOrOoZGgeMEqDIN2Bqi6KTqe0PhQyHuCFQb
	TUlI814Y/sWYvzKQ3/oIL1N5IvVlFbtxx9Hq5X0n1F/KYXzspLwwR7M1l8t+AflK
	RzFZfVLaU8c/Dj4rCBQq1Q5AL7SpiDF2XB4OiBR+BsCCG2Zb9ib8NJEcO3SCbRfz
	EiDtP6BqvNkhpulWHjp5cNiX0uBHmgn5e2ddRSNFzovm7UOhMzCLQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntqxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:04:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFuGM6020443;
	Wed, 29 Jul 2026 16:04:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7dh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:04:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TG40Jr34930946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:04:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D909020043;
	Wed, 29 Jul 2026 16:04:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8F9F20040;
	Wed, 29 Jul 2026 16:03:55 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.22.107])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 16:03:55 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH 1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
Date: Wed, 29 Jul 2026 21:33:49 +0530
Message-ID: <aafc721911eefc4ee376e27a0f4cebb82e3ee336.1785339155.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785339155.git.skb99@linux.ibm.com>
References: <cover.1785339155.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX2x3cdbfg77kh
 fnj81SqZL1NWm8A3wssxYADBIMJgkLcFWnIWz8jzfD2WaOZ5jntNFeAMXEl0PZ+S8P/zPCSoF8e
 dFDhXrGm1Cc8WCu5cPRfbDSO5QslLxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX62rnT5F0lT8+
 05hxCaZIAzBnPOQVeXUjVOQCH9O/xM52VaHopHJXoGNSCkVM0IIab1ih5eJL50VGzQ1SwjZ3SII
 L+urqV1Qlc+CU0MDuNlgHB2XdmsLsvQURqIa2Riw/rAkD+4LuH35q/gqoQk6pU/mGd3vSJoBS6m
 DRswIsOWTROtqr0GGAtvgtZE+iG3z7yu0fQPk31sRAhV3e8/rVKOJwY5SVXRWcq2CJNIiDuAhsY
 ec/C9rdZMA6PWWdDrUuS/dRHBYgo+7kipW+RyIXsZQ+qiZpHjQIjR+kT0kQEM8LlI4+M6CDJ9Vm
 wUgIt6oD2cPTFMw9tCg+uQG3xlWGYxpnNGg2P0a+wo0XQZl93X7OPh0FsNH7vrmgF/aTmoWpdfc
 uSsPSzu9YFNe5x2FYfv6Oo7n//8VHHGMOw2enrB/YvcrUz/xs7VaZNmyhVBLc2ocmTSS410rUxV
 pjXmlznTJtq19hsDtVw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a2476 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uSozNU3BD3bFXkPSkqIA:9
X-Proofpoint-GUID: 4F6zzaq79I7vZ0-y2aclhrSN_NXsZBVa
X-Proofpoint-ORIG-GUID: 9NV6g82HQuC-fYfs940cwa0ndCXbQIsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290126

From: Madhavan Srinivasan <maddy@linux.ibm.com>

With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:

  CC      mm/dmapool.o
  CC      fs/readdir.o
arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
  475 |         int ret;
      |             ^~~

commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
introduced "ret" variable to bpf_jit_emit_func_call_rel() and it is used only in
else block of CONFIG_PPC_KERNEL_PCREL, fix by adding a "__maybe_unused"

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index dab106cae22b..63952ef19256 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -472,7 +472,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
 	long __maybe_unused reladdr;
-	int ret;
+	int __maybe_unused ret;
 
 	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
 	if (!func) {
-- 
2.54.0


