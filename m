Return-Path: <linuxppc-dev+bounces-24573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B8C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 03:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h435d0Qscz2yT0;
	Tue, 21 Jul 2026 13:39:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784605140;
	cv=none; b=I8vZp9Bc/TpUNZd9e7YwuXwPtAU10VnCUUy1zltsIAqAIQ+s7zBTLWnXANvSomko0EqbA0ltllgWmAnAaT3xQ/IHEBw6YzOFrYJdbrpYLN0j9iBDCXW9QjwxMxOdkJELhzqofdq5PT7zf8QMSMq5xCmUzp21mclvL9RiKlYoeeBn3Bm6zwEqFBo+UyO3x45Pkt8OX/KH47PGXiuaLiYUmKYKi+fxupEQpXNqZ0VMLZTLLCDT+nfiPUyo2wuL4TqNiKKO/RczddEKu25V5yLQaTJvHUHL5AZYvG+D/86439NtheeUzY6kKsF7WuBHrATvd3ugKnRZRVSgyEYFmwrXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784605140; c=relaxed/relaxed;
	bh=NM/7R99hkOluMddz+HFQVasX/1zpzgZC8rf6KtJXGeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4KYJmtCaIUvNUEit6IUV09tezGRHqIQYznjcRVWjypqxpj0x98FYYkdQuHG1nSEvdGuBrH6S7Jd4BYw63fV/myIAsQzxd+ZVgvJ1UUtEGHGiLruCXdj8ZJsmX5repW35THCOsJXJ9vZ555t0EGkIYDkHqQ7qSek1+1wByyAF2mRweXcjE6K8DdSr2JA3PFVR7P/ncX2y+Ihvn9l4KjFBufpbu7hQ1ebsT6ufabKgMpi+u91mEAj7gcWDNi65uQIWpb0rsPSkhz9sxLUtLO2O087gn3Umtd3T8NHeJJ6kv5PGSqPwEiDfJajk4v9QMN+gXpFkzlq5Jvk58kxLV9Lrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OJa8KDUr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OJa8KDUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h435b3N2qz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 13:38:58 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCu0t1675724;
	Tue, 21 Jul 2026 03:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NM/7R9
	9hkOluMddz+HFQVasX/1zpzgZC8rf6KtJXGeQ=; b=OJa8KDUrYaoDJ8ZpyXOguS
	cvs0hfC6Pi3/x0hiAszDPsqQpdtwAXgK7XO1BPKI+fZt1T5FIOhKY7NVQNakPea/
	/MssD8BhKFUuyMIXtDAjnjAoGCECWDxEaXDY4SaynHGW3Lmpd7YiXgymsE1AmylH
	nKXDmrhQ5QRJIjQMZayGAvtZnYMdFc984pS7h8E8xsHtkh1ji5JUSDdF6FgZ1bOO
	WM9DhCWrIOnm3CtjfoQlf8FtXv2oeXQa9AKH+a4h/8UDUe20wVm2MF1n7Gxmerv9
	Zr0tYi0q9I04+//VrrrvN3zxQLxxVp/8VvCaUIe+aU88uCa5Ho8gXbCgS8/9zDhA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aap24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L3YicS017703;
	Tue, 21 Jul 2026 03:38:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w0nxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L3ccaF28377356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 03:38:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C352004B;
	Tue, 21 Jul 2026 03:38:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20D220040;
	Tue, 21 Jul 2026 03:38:33 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.218.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 03:38:33 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v3 1/5] powerpc/rtas: Handle ibm,open-errinjct return format
Date: Tue, 21 Jul 2026 09:08:01 +0530
Message-ID: <20260721033815.5300-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: l2RZP_Wj_IAkMOHLbthyawBsN66VeM8N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfX7srmq1mRnfIm
 nPdcwRr8RMNAXzp8E450L6LB3mll0AfaPXov2+7N+lYsuZ6Q/eJ/F7j0tB1jAwIeY/rwGx4WhHm
 ZdesS1mh5GTD4OdQj3VkM2DiBymIVgY=
X-Proofpoint-GUID: JLaqt-gZ6O7xzQTZsGLxBUoTLl4do0DV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfX61NHoE/IDIrb
 UUlCU7U3N9SNdM5K0jgKXOvM32p1o6rt12j8awveFq8fDlDYNt0FMo86Sg2IkVRXjtcOiCdhsjl
 Eh434N1+vQnfvapvRIhEuhr13XsCtNdLvD+VdpL43n8Tohf4VmiT76d2Q4p8W/jWaZcvBoKTzUa
 9wTE7iCNzJ56Y2u8OnF2qobcJ5ydtgljiXfpDkXDp9i0qqHLeCxYS4D4yUZBu8gOtM3Iu/mfE5z
 AcmteqLDVP73dJVF/U8QxCiChzDFJru+8AS7Ug88GkR2EPuDSRwLImBgd+YkFg7dyCTf7JZenUc
 EoDTHeMeN7ToRuBoKsNWSJfn1L3M96cjy/Qjr5TjnOf0B0DtrEQmNC2bPDthEeYPc9oFZjr1528
 zYSaZlJrafS4aEDfQ3if3lA9QAhWjZJrepQnAFHHYWNBUARte8ACAdpBadgya2wGN231ZW6O/cU
 eqgWgZt7Gy0LcPGelgw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5ee9c6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1mVJ_uiqAAAA:8
 a=VnNF1IyMAAAA:8 a=mrpyPNaNM-fztfjREsEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210030

PAPR specifies that ibm,open-errinjct has a unique return-cell layout:

  rets[0] = injection session token (output parameter)
  rets[1] = status code

This differs from every other RTAS call, where:

  rets[0] = status code
  rets[1..] = output parameters

As a result, the existing rtas_call() convention — return value is the
RTAS status, outputs[] receives the non-status output values — must be
preserved while correctly extracting status from rets[1] for this one
call.

Add rtas_token_is_open_errinjct() and rtas_status_from_args() helpers.
rtas_status_from_args() selects the correct status cell based on the
token, and the output-copy loop in rtas_call() is updated so that for
ibm,open-errinjct:

  rtas_call() return = rets[1]   (RTAS status)
  outputs[0]        = rets[0]   (session token)

For all other calls the behaviour is unchanged: return value is rets[0]
and outputs[] receives rets[1..nret-1].

The sys_rtas userspace path is not modified: copy_to_user() still
copies raw RTAS return cells (rets[0..nret-1]) to userspace.

Callers passing a single output int (nret == 2) are safe because we
write at most nret-1 values into outputs[], never all nret cells.

Also move the '/* A -1 return code...*/' comment to immediately precede
the if (ret == -1) check it describes, and remove the redundant stale
else branch that re-assigned ret.

Reference: OpenPOWER PAPR documentation
           https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 51 ++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..27d53f34494d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1117,6 +1117,29 @@ static bool token_is_restricted_errinjct(s32 token)
 	       token == rtas_function_token(RTAS_FN_IBM_ERRINJCT);
 }
 
+/**
+ * rtas_token_is_open_errinjct() - Test whether @token identifies ibm,open-errinjct.
+ */
+static bool rtas_token_is_open_errinjct(int token)
+{
+	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+}
+
+/**
+ * rtas_status_from_args() - Extract the RTAS status code from a completed
+ *                           call's return-cell array.
+ *
+ * For ibm,open-errinjct the status lives in rets[1]; for every other
+ * RTAS function it lives in rets[0].
+ */
+static int rtas_status_from_args(int token, struct rtas_args *args, int nret)
+{
+	if (rtas_token_is_open_errinjct(token) && nret > 1)
+		return be32_to_cpu(args->rets[1]);
+
+	return nret > 0 ? be32_to_cpu(args->rets[0]) : 0;
+}
+
 /**
  * rtas_call() - Invoke an RTAS firmware function.
  * @token: Identifies the function being invoked.
@@ -1213,15 +1236,29 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	va_rtas_call_unlocked(args, token, nargs, nret, list);
 	va_end(list);
 
-	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args->rets[0]) == -1)
+	ret = rtas_status_from_args(token, args, nret);
+
+	/*
+	 * A -1 return code indicates that the last command couldn't
+	 * be completed due to a hardware error.
+	 */
+	if (ret == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
-	if (nret > 1 && outputs != NULL)
-		for (i = 0; i < nret-1; ++i)
-			outputs[i] = be32_to_cpu(args->rets[i + 1]);
-	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	if (nret > 1 && outputs != NULL) {
+		if (rtas_token_is_open_errinjct(token)) {
+			/*
+			 * ibm,open-errinjct: rets[0]=session token, rets[1]=status.
+			 * Expose session token in outputs[0]; skip rets[1] (status).
+			 */
+			outputs[0] = be32_to_cpu(args->rets[0]);
+			for (i = 1; i < nret - 1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		} else {
+			for (i = 0; i < nret - 1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		}
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
-- 
2.54.0


