Return-Path: <linuxppc-dev+bounces-21555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD906CD5BDE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLl83ByJz2xLs;
	Wed, 27 May 2026 17:26:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779866772;
	cv=none; b=FnLLiT3Dma5fbBfTvhE2LVajhALR3f01iVL+X4Cod5iXmyKfh2rcNufhbPQZbmFv+0hhcvDD2w/agq+BLrzELuxnNUnNualw90T1a9m3Q2V8c18xB3mS3ceuXuG7i28nYOgRKEXu83ju8zNyIAkcNhxcTKsdKJJX29FFam3b03pXfZPdjAwtcqaEMEjZaVoQWT9ESdSORIFJwdOyXbxQMsa91Qv8JvYuE+PUcjQiKfSbja671ecvlNE4pzX2IXuPS5zmELVkKqzlHncIBt6ofkUoVnvzvGvRmg/Snj3KqBabMjcLVm4EudUvRGEzEmGdVmEMZdEqzxTWtSkEaaED/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779866772; c=relaxed/relaxed;
	bh=BY3j5Q7wTORXDWkZGCK/DHrsyRO2DBSmbFv85zy5Xnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I599dlNv4C3y86UICjkTPQIpY1DragEXd457EfGoTfVtI+j72q1ADiiItBbq6/LnjoWGfCTAXsP1Xg5pplaFR/Q6CjnCfLGsNp5rDSfly42v9rpfokVbLzStW0CnC500XS++LDP/IxTBnQ5MCCQ/qY6WmJaXntc2jdlJaP+sPR785DpVpIT8tk8qnbwPYXPEH+memPSW4SfxBRV6VzK3XxXieBKYIotNuGt6j1Q4h5A9QyR6Xf2X66NdGLf42SAce6i0ZxgAG5c0s9/HpYl29VeMbhguTMw23fQ+JlZ5etRoBKjAmnufxzL+XaK1BGfixpOfPOe9+EWEzZNQ0qu1Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q4zNuRDb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q4zNuRDb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLl65qsLz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:26:10 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4c3u3810959;
	Wed, 27 May 2026 07:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BY3j5Q7wTORXDWkZG
	CK/DHrsyRO2DBSmbFv85zy5Xnk=; b=q4zNuRDbvORcW35lfBK1TBlexxZCgXKu7
	ISu3qCiyUOzwZgVYyElzTHB7ANzWmO8GXD5aFpp0SvNhrYxPAyYHcJkWLUbVW1Xu
	AIggKkC+PD52HihekIwaU30xY96hlSaNsKKzKBQZFD02wBBb/7ytJwcbR0ECJDmn
	G5g+v2cjaEPtaAKoeOg7w2+OycG8BYnx4FegaebCpvETukMIlt5mb4PuwYexIfUo
	RztB1AqD73UzjG5IW1X6n0mBRxnsWNu1up3D+VlK1ZExKNhO+AP9sf6J2HtUv52V
	2FMclq39e/DvxhqAv3zFU0y+rJ19/YgQ/MXwFlJRDs6qs28e+pzNA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc03gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:25:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R7O8fx014805;
	Wed, 27 May 2026 07:25:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbhwvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:25:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R7PsZp13435390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:25:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC0DB2004F;
	Wed, 27 May 2026 07:25:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DD6220043;
	Wed, 27 May 2026 07:25:51 +0000 (GMT)
Received: from dhcp-9-123-0-29.bl1-in.ibm.com (unknown [9.123.0.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:25:51 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v2 1/5] powerpc/rtas: Handle special return format for RTAS_FN_IBM_OPEN_ERRINJCT
Date: Wed, 27 May 2026 12:54:29 +0530
Message-ID: <20260527072433.94510-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2NyBTYWx0ZWRfX2BI383wXo9xN
 w5iKNrIk4J+QwQgZ4n0sxBmvL3BUHJKzsM618vd8wOU8XGu9RZwUK9EGJtHd4CuifgYHVfn48WF
 vcKXVqr1m01D/pE/363BInJF5Eb70rC7dIPUjGsbJdyZYK1vgohOleCr6hvy1+TYDxbqOHxa+Zx
 X8iKF0WinwudfbYJimsFxEseeNFEaJcoBZ53MHwg5Sm2oiCESTGcEgF0QezAWKAbl2bVs07nBtj
 wOTOdxFTDDhrIhMC4l8uFOsfA5PbOO0Mi5TAE0Cq9hibCLVki+kjOD1PMtKnYvdSx+HTpehTVjy
 Cl6O8rqz+sW7z/2Xu1iX/5AFnG0Cp+nw/ASp+RY8SMRXVpgLVekDTBjRlxVbNQ7Xkm4eCZc4KvH
 kWVxXc9Ck1cXjJN0g3L40krSw+p6LjOlH7hUuG0rV7vVk9qkpeS222q3ytYJi6j0KpF98hUAOfl
 G7nbHKp9tKBILrLkBSw==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a169c88 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8
 a=UamfBOe3sCdmUmwrGAcA:9 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-ORIG-GUID: 1Nr7V_qxs0oEA1rhlIiVzEHr17Cb3hzz
X-Proofpoint-GUID: wuEcADh9AJ6EP8IA0WQyPYCLMWkG4bey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270067

RTAS_FN_IBM_OPEN_ERRINJCT returns results in special format:
  rets[0] = session token (output)
  rets[1] = status code
  rets[2..] = additional outputs (if any)

Unlike standard RTAS calls where:
  rets[0] = status code
  rets[1..] = outputs

This patch adds special handling for OPEN_ERRINJCT to:
1. Check correct status position (rets[1]) for __fetch_rtas_last_error()
2. Copy all rets[0..nret-1] to outputs[] (including token at rets[0])
3. Return status from rets[1] instead of rets[0]

Reference: OpenPOWER PAPR documentation
	   https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 47 ++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..a2dd94eed9d0 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1183,7 +1183,7 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	unsigned long flags;
 	struct rtas_args *args;
 	char *buff_copy = NULL;
-	int ret;
+	int ret = 0;
 
 	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
 		return -1;
@@ -1213,15 +1213,48 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	va_rtas_call_unlocked(args, token, nargs, nret, list);
 	va_end(list);
 
+	/*
+	 * Special handling for RTAS_FN_IBM_OPEN_ERRINJCT:
+	 * Per PAPR, ibm,open-errinjct has a unique return format:
+	 *   rets[0] = injection session token (output parameter)
+	 *   rets[1] = status code
+	 *
+	 * This differs from standard RTAS calls which return:
+	 *   rets[0] = status code
+	 *   rets[1..] = output parameters
+	 *
+	 * We must extract status from rets[1] (not rets[0]) to correctly
+	 * detect errors and trigger __fetch_rtas_last_error() when status == -1.
+	 */
 	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args->rets[0]) == -1)
+	 * be completed due to a hardware error.
+	 */
+	if (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT) && nret > 1)
+		ret = be32_to_cpu(args->rets[1]);
+	else if (nret > 0)
+		ret = be32_to_cpu(args->rets[0]);
+
+	if (ret == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
-	if (nret > 1 && outputs != NULL)
-		for (i = 0; i < nret-1; ++i)
-			outputs[i] = be32_to_cpu(args->rets[i + 1]);
-	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	/* Copy all return values to caller's outputs buffer if provided */
+	if (nret > 1 && outputs != NULL) {
+		if (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT)) {
+			/* Special case: rets[0]=token, rets[1]=status, rets[2..]=outputs */
+			for (i = 0; i < nret; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i]);
+		} else {
+			/* Normal case: rets[0]=status, rets[1..]=outputs */
+			for (i = 0; i < nret - 1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		}
+	} else {
+		/* Either no outputs to copy (nret <= 1) or caller
+		 * didn't provide output buffer ensure ret contains
+		 * the status code for standard RTAS calls.
+		 */
+		ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
-- 
2.54.0


