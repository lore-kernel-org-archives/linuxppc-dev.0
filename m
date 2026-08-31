Return-Path: <linuxppc-dev+bounces-26232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5028AC61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:16:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYL021PGjz2yCt;
	Mon, 31 Aug 2026 17:16:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788160610;
	cv=none; b=Hlslf3QiaoUpcI2FJ+XcxE4SZiHRvc0jrDbZgdXBMv3hFZnM+srdbrd97lHnoO1aLKJWFdX5K7bT6Ufl9sIPsHf2Y0XxhJVF3lIDY3R4d72oU05Lj2O7TV4FWaJt//LE7/rKfirbCJp6hoCo02viufRNiTVKIFyEgF3ZNtgrNUB+3x2B1I52smWtaqw7jOJSKATW4vxbpiPJoAQl0UWw/GNxlA7N/nJHOemkuZgLtythYQtVpLfX+D3t47TK7AGL0EWkNXXhM3en9Mcd6eoeJCeM5mKufV9iTRLwU78K0Pe27qQ+2uWcqi4Wl4l8ySGePXY9gxasm4BMVr6Yc8pT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788160610; c=relaxed/relaxed;
	bh=Cj9+KI+E3RbfzXOrpIFzuxQkaC9UiINza73y+WdO+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3CkrLcWKPkBl5Ll1S5EKkWhL8JURf4G6C1IQ07g2LcuA06aaDruFnwklVMLsyFy6pqwCI8Dzp6STBf/qbjhhkWFyRjXZo0FauyCBdjfVXVJAYm2kvkigxA6kkoKL8gpFan67E7tXXsW4WX+6+3mBJeOH54ZfBTMMImGQYLlE9zt6gH6X1JROKE0uqJky7BGC1xWMGghDrV1pHGyCuOTkThwK5Ojv3HYmA4v5zhMAiB1fdf3T44Wf/A74jT9yAOIlnHQBeEcuckUA60FYhZ75Zgx8oYC1TzPsPHjQhUxqv1E8iyto/zDgTPtKzKhODCajcsjzOx9Rf7eYJ288tW0fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pkWInfRR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pkWInfRR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYL0134qdz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:16:49 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52tsp1270840;
	Mon, 31 Aug 2026 07:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cj9+KI+E3RbfzXOrp
	IFzuxQkaC9UiINza73y+WdO+D4=; b=pkWInfRRFznOjcEF7RvTyGfP6iDY3DB6v
	SuAJzaG0OheV35+kNec7Qm/y6vZ/HmS0qJbv/v9578UwckZgoii5Bdwlh2ff+agh
	AClG8omHGxkE/ZvyMFOpZdtmciZwzFVXCzggSghCE+h1ByQhTTgT6qQLTJ+vkYTx
	lVLKVFRBNmUN92t41V27IDVnPeSUgoJb6utVzSIgJR8VTsBPF/65mUtVRGgTZmbQ
	P7LIy98GIfu4/pXvVC0NbtQ3vormnxqi5c+MwYRgNynY0N93TSeEfbfwfWtlIAoE
	lK24mCEL2FfyO4O2eFyVhnjfJESrMIFPUSF0wRY0qrtsPpJpqHJZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx57s1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BQ15012955;
	Mon, 31 Aug 2026 07:16:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjvj14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V7GPkY42926494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 07:16:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1EA2004D;
	Mon, 31 Aug 2026 07:16:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515E020043;
	Mon, 31 Aug 2026 07:16:20 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.67.146.121])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 07:16:19 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v13 2/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Mon, 31 Aug 2026 12:45:59 +0530
Message-ID: <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a952a4e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-GUID: bpNNleRyP2LDYGFdTA2L1-OOup9tgf5p
X-Proofpoint-ORIG-GUID: bpNNleRyP2LDYGFdTA2L1-OOup9tgf5p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX0Efr8Sz6T94c
 WygRIcyMDff6ZL4PnvgGjmrN5WjWrVJEjDXTKWjd9AwOo3QjGAX8VOUCvK1hbTNIFxYiCCO7Mmf
 Xo5OuHviXuONWmD60VBDy1hwvOBKkXE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX0s9n7wM0EAVk
 Cqxv9h/UuvS101nsnyuU6RiZqAhyHd/jlpAO3pQJpWXKF2rd5mf+CYRH0nQlYR4ZMiH+29j+MOg
 daReQit+xwLuk2bMuFxNB4XyjxynSFKgXq8lbhFzMOt2BgHnevNFgjMxte1n1DT0ZKtU4jHeI0G
 GX1Tiy+daxN4SR970J8VSfpHGhv2Jx9ruccspxlKQhMdrwSEqnyzRJbTVQ4WtiK9XiZ7yDEL4jR
 rd0yUlGLBgxX4T9Sj7P/BhLHTE7CKRYF6aDvYtbBKAQ4Ba5fyBkgTdvu8Sf8LSMxEbGKpqh5wGm
 PNP4g9yRCrXVBtoTRVcInBOwR8joJrznYZVJUFxdIFxhDbN9pHu7ylIEpDqU6X/posRAJ2K/ynG
 rw6oyw77Lw/0FrLmEVbj7Ia1K2Y5/GmU5WNHeCqGNL7BdQ0cGF7urSvIrX5fxEa/pryyMD/Mhjb
 FCAHHcuLPHzZvbTvZfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059

From: Abhishek Dubey <adubey@linux.ibm.com>

The existing conditional statement in bpf_int_jit_compile() frees the
percpu private stack at out_addrs only when the image buffer was never
allocated.

If bpf_jit_build_body() fails during a code-generation pass, the
image buffer has already been allocated, so !image is false and the
percpu stack is not freed.

Because JIT compilation failed, fp->jited remains at 0. The subsequent
bpf_jit_free() path only frees priv_stack_ptr when fp->jited is set, so
freeing is skipped here too, leaking the percpu allocation.

Fix implements freeing the private stack whenever fp->jited was not set,
i.e. compilation did not succeed, instead of keying off !image. !fp->jited
already covers the !image case, since image is only NULL on early-failure
paths where fp->jited is likewise 0.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel.org
Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stack")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a875521ff904..8f7501954d9f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -357,7 +357,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				(void *)fimage + FUNCTION_DESCR_SIZE);
 
 out_addrs:
-		if (!image && priv_stack_ptr) {
+		if (!fp->jited && priv_stack_ptr) {
 			fp->aux->priv_stack_ptr = NULL;
 			free_percpu(priv_stack_ptr);
 		}
-- 
2.55.0


