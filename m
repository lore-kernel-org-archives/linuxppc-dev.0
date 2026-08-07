Return-Path: <linuxppc-dev+bounces-25579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA4C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:02:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGknS2wGxz3c4f;
	Fri, 07 Aug 2026 23:02:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786107724;
	cv=none; b=NyJFDp9cCGjzfYv9qFg/TCcfivQ//of4TXz+s8oHn/uXWbtWTvhJLX2GpugPbcD+bnT6186BCE4D4Q8Q5V5jHcorCktV89VQz3WBbMIN5UABSTJ+0u3THLXhYHE6O73yEQZkEDge1S2WgXo3sGj8foLeXJAEHwDDyq/4wbkuyx+tdaMLLygwbcWxw10+YJGZYii8JpIQSOq7K0VkvFUKILJa/yF039N6zspULmPIKCNpglou4Y9HH4N2PAqpmnLIUkBREs5Lz/eV5ZzLWAnOMcoC2OcqEFPHEYeZ4ebHFGks6Bey2IiAp+X5C0AaDh+HoGLfltQ0OVYCuy6E548LCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786107724; c=relaxed/relaxed;
	bh=uKoaHjLhphLy+WQ1217Z6OSaogdoPojKH8VZzODaxGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPuAAiCXfxYBlqVxv6XmBsmVTK06/GknGG8JwH/z4cxxsnn+wPB86GrVBCFWkkgaU7He28iBgrzZqX/L3dT/O9bFJ6NMIuxRJKv/dyLfJl6xSVnuM+1XcQpC9STigv3igWg0EX9ka2KxZH5xKRjOmXKdoqPQHYfrOB/tdS0I7sKdRjpbiqXvliLLvWOff8UK01Rc829Ru3X2awFcfrmWg6mYJd1pbjil/ej5dEO644BZsIlOmXw+YTTCoak3IpAFA2ZVbaZOWSYdLAMHcu1sDQbF9/pIC6NOE+ZIOQHhPuscXRllC6eaj70Tv298ZDn2ZwfjWgAS3/qtVy928qoE6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rivIIHh/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rivIIHh/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGknR3D59z3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 23:02:03 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HbNe4161185;
	Fri, 7 Aug 2026 11:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uKoaHjLhphLy+WQ12
	17Z6OSaogdoPojKH8VZzODaxGg=; b=rivIIHh/0CSx9Ua0vgXZLNpo3KuUdFsqy
	n8OGUaFA0Y13DWNbKtDyXfumix2Ch7b59vghq0X2ZNSaX3ML61aacElXIWv7yoFr
	8w6OlB3iR8umOXThfBrCwhYr1Uc+NrJQ170XACG9vvJJePqnv+2sR9UZfNpUmkjy
	fFzAAYC6+mR3cUVfZnGNO6uqtfht/GRvmXWpQ9xHTfKaSloCEjmSBOQ2yNfRkeM9
	LQCp0uo1tTdWiSZ/+C3/EwscEr+n5GlPh0udDlrtp8ufHbvS/K1Aj0yX92AJvVJD
	v3gLvCcGR9uzb5qti20LB9mqvJ3JHF+jkMawjqtkB+ILHKpEq8xXA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyunm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfGYv004614;
	Fri, 7 Aug 2026 11:43:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qym9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BhMe233030572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:43:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B052004D;
	Fri,  7 Aug 2026 11:43:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E44B20040;
	Fri,  7 Aug 2026 11:43:19 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:43:18 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH  v11 8/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Fri,  7 Aug 2026 17:12:43 +0530
Message-ID: <6bbf4249e47dc14ac65d72c304bf9335cf10b206.1786099877.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75c4df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXyLqPFweh2V2I
 /NhO/2dD60al0nZZrCzO+wkrR8WhSfhrV33hxCDsC4CYJu/zPDvGeYQO7lbhVd9meqD95ptSS0a
 bFpcC3A9mTqXiSftwiK7gx/6J1Ga/rU=
X-Proofpoint-ORIG-GUID: DFefQo9uBAVa8kqhBFxRTVyHy6tmSu44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX4EjVSVUoxZAP
 eZS0zXz81NkYfj+krmCeCBBV64S/FO3jvOS/9VxUuA7IgPwDup5iyOC4Yesrk6+cm+iKko94ZqH
 njzWM7z7VByLO62GsT8T1KLU6d2sb7x8EozEByIhg006M1z77Dv231MxQbfxDCkNTYGf8/hmB9d
 ZMHrg46HqxFOFFTvlTXAdjtcYMO3c/tzQu81Cg2TFQ833tpW5h3HnzsuDf95iZ7/0o2H+Qqor+F
 9b7O8JXfmauuXfVSdD9nh3lv5ANsQv0QyrnnUzCmBgroSUhkXzKfkdb4mqunrI3EXntmCE/XaXe
 nfnaoT6TIOQSm06vRM8rdWI5cuomvoPCHvBr4vl4dv3VaVHir/8z1QP7ZT8VBqFttDNRNNJzQPz
 aDfGXHzHE7dgQy5rMknmvu+ELhk3XePTZixRhepdUge1Dge7VhwZqYLvXYskkpUK32cNMoTjV6i
 2j7wH0Zs5Q0EiIZV66g==
X-Proofpoint-GUID: DFefQo9uBAVa8kqhBFxRTVyHy6tmSu44
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
index 2cc1124ed530..395f1458db2e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -404,7 +404,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				(void *)fimage + FUNCTION_DESCR_SIZE);
 
 out_addrs:
-		if (!image && priv_stack_ptr) {
+		if (!fp->jited && priv_stack_ptr) {
 			fp->aux->priv_stack_ptr = NULL;
 			free_percpu(priv_stack_ptr);
 		}
-- 
2.54.0


