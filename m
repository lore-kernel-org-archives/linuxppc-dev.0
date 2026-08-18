Return-Path: <linuxppc-dev+bounces-25949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10DEC5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:45:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPHDy0ybNz2yFP;
	Tue, 18 Aug 2026 14:45:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787028306;
	cv=none; b=ojLJFz52kxTCdAcRbr3cibFAf7PUEP8gKFyS+lKXlN250AMzMn4wU659XQcRmghKDAujpjUsolTQm9InxZNuiLRLlIIVlFkQJ5SrIvEijBcIps9wFIMtoQ+poh2On92m0jfdKseAUM/l62YBTfVTyuwqYxkb12oK5HL1BeJBjvzMRl40gzJMQnoX89R3BaGf5PkqWsJvhm4gm8JqZgu6kgY/ada1uCnLN4sYWjjYO9CVy5kw55LMsNvBwVCLsiMO/QvYZ3JqQYsYfGARXUedWHG+mNHLiP4/x+u0mzUhmKJNBHuqLkW4Lz0dOchFpq6TalVU4jHnHYPnee8MlZULlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787028306; c=relaxed/relaxed;
	bh=6wEsgL8K9KN+G5AWnQ96mL1pVrLWlkU/qw9KAPMbtqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVEwkluUcMq/Mz6iF93F1k7ACtpf3oBCzrbZu691LV/j+PkanIbScLC6+z5WGX0pITnSw2Y4DG4QLZCcwXezkQwQeFaHdWuI9VVZEDnfpv7NZctXllgW0YVWGxe414PerX21Jn/lntAdqFr8R3G7N7Ex0q5QUlKEbqpOK3ZCvRsNzL/XB8k20btLoWjbwOtv940/KYQ1C3sXpb6Xt1D3SpB8OxXVyf1PM/so9FiorknWjWBt4DNqfQ6bDzxxJtFe9MIPLzYtlbHybRKWKVNYEfRPLVx5pYoRGBT+UsQoxgDyW2t1j8vbf9Bj5ZMHFm2YN7e80V2ACH5twp08GxfyzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eGb+lGpi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eGb+lGpi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPHDx1HBHz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:45:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1gs32575103;
	Tue, 18 Aug 2026 04:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6wEsgL8K9KN+G5AWn
	Q96mL1pVrLWlkU/qw9KAPMbtqU=; b=eGb+lGpidhu9mAWf85HEtOnZHf2jvT29V
	9gTu504EBD6QeJvPF3L+6Vwt1zrwVTBvYN+8eJPZEB2j8aEgzYLzkXclhAohuxcr
	05YhTTQX5nU9bx9Qdu35RHnRggU+uZ3NqPul4y/dD/f9yE3lHXRa4wWiTwzllDTr
	rXIyKcyr2Pgk8MnwxF5g/JmH3CJ2oLXagWdhqlL3s6CN55S/50pdTFFMkzB4DPhZ
	rUI0sM4gpc2q+P1Ws6ljtlR/X6kUdeJIkMsvuXOMFL544r/lglCIJUwY2XW3Ftwe
	lz+8mBdHjL1LPPibBVoJlamSrYBuk/uE4zYgRX7ecwXvrvpxP82rg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3p1kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fTIM023690;
	Tue, 18 Aug 2026 04:44:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y940p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4igGq43319744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:44:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D202004B;
	Tue, 18 Aug 2026 04:44:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F7E20049;
	Tue, 18 Aug 2026 04:44:36 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:36 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 5/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Tue, 18 Aug 2026 10:13:38 +0530
Message-ID: <97a39fe69332e2db95f2e653445c5b8c9adc205b.1787027080.git.skb99@linux.ibm.com>
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
X-Proofpoint-GUID: plkH1UaF8RCXxZMrpvXChUlEQqeXPHgP
X-Proofpoint-ORIG-GUID: plkH1UaF8RCXxZMrpvXChUlEQqeXPHgP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX9p+YbsyDb5RF
 06WXvieIQ47bc1T9XXvI71cXVR6JifQVySJbAlq10ip2wgmTrWkvIyChHQ8mgrJWYzAg8SGdj6f
 WQ0inBzJTdqN42u5iNmtePnSd3X1zXU=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a83e33f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXwdwtC2Pkf1qt
 lYRaDi1xAW4PmrL1DJoE6tc0Y7bIb0oPiHdYcBx2V/IWt/wxGbcRcXWxoFoZMYW3vP+IBWA7Rj+
 LsBoJWY7wc26KHmL3z/G8U14NQoKvBEuUOVsaiOq5sJEgJHfeCCZmZaoFpSr9++KADbOQukp37I
 RzRui6GEm4tvvPILVK3P6hqwV1QnpHTdpn5UF3hdn4dgKh0t/BdlJ+Zo1kg5dVHLDpkiLSL8E9y
 CSHKy5d58ne05Nj38sv4Ch9kne0sPfoXm4Vnc3EGZnqoUCkd118TcELTElVkBtmqXcy1XgYXOkD
 h/RwaTyi7rfAysotRGRAHt5mUYfHzILAzSoAejnn49+b6sT0BnRiVJp1+Uxe8ju3zGXrIqqEAOn
 kCNkr6HOFXF1T6q0hA98vPWzq12p3moGtIsXyJ1k7mijf9qodSiWEAYmUYnc2ojyAj9sXPEy2Up
 U1AWT4htKglyzFZx7gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180031

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
index 38acef44c097..b45fa8027106 100644
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
2.55.0


