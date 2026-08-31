Return-Path: <linuxppc-dev+bounces-26226-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0564BC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 06:55:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYKWT4NxTz2yqf;
	Mon, 31 Aug 2026 16:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788159333;
	cv=none; b=XJYDyGAApWAj7rxziJ8tw8MF1UcT0WjzWRl1zaOsFbziOCuTe+wKEhZC1ML7e4RJe40mTiu09zSEgQ41u/OoaMrc7BE6jEy10ZcQGssXhUZ2mNkMBPe3SNEqdbGuSkVIPKU8TWYLTjUlY9hnbL6S9KHwPd5aZT0OScczPQE4avzCsYKgKWxJhW0tO1a7U+I214xoOwAMZUCTV4V5X1NIQ5Fnnx/UeSgU1NsQo3RaRS+9jxTtIOOltnpjerxMcxMsY71HCPpNOLERQziEVpLbaAexf+o3Z2KgRXsmSk/n+vmlyUQR3a4Zeve7cYxwcxNa/3w8aVUMsZK3EgDQgpHCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788159333; c=relaxed/relaxed;
	bh=6Bcwu2sE3RF+vQreHuxH36Trzx43aQ1GxpbDCc2O/1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz5jH/axhGI+FPq7MD9/dHBQfjo7QJs0y13mTN4b1tMPOwjtv/GL59bl2elzyRUMDDbduSWGLWV1GD5HqviJqwJZujT+7s7wMrmx6/AymBF4uTb+O0t/Qy2Vc2l3Wfht9GTFNJ+tRSOJ4coJjxcGEKCxdchZXd4ovPqzpsyQqym60hJwz+XmigWnqNxID04YD4OLcj0D4DPIpcpjMO6V9lcU9U33PEyZo/UQxhoVhPM99+IwgHwy8ZNt0wfCoiWMPKOZ1grLdIRzZ+yifKGsTeX7h18fimgPRvNj2BIVrf+9EPFMW+udeu4fn3OUwjey7FRPqETB+ym48MkgMHAvdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sAZsc86R; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sAZsc86R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYKWS1QQXz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 16:55:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52YQa3591415;
	Mon, 31 Aug 2026 06:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6Bcwu2sE3RF+vQreH
	uxH36Trzx43aQ1GxpbDCc2O/1U=; b=sAZsc86RjvYw3Mmnyf7NEA7OejYDDcee1
	pOC5+k4DaqKW9Vh9noKIP7zxg1ztbTWRxCywAoybg7RFgecu/qBU/NCgTvR8IROw
	73n8usn0GfhVCFnA90OzxvJCR9Vf8Wp2lZJAXs9qmAR1k5EKWhTZjIqMiSNMOFDN
	j6WKwFwPN5bxlV4QRInCgVr1cT6rtuq+KfMcsLVieebKZUHSY+9vWAAbmCipTEpo
	AIfP88Z9bhQhaFRj7G7tpGevy66bRUj532nZdk+69oL+s7N+lls+l7Btr6ZeRIj7
	NezwbtKJHT4nWEDNvOyyOtPypy2JQIklCHDrqcBSSRXMgiz6jvxwA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3qym2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:55:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V6fN1m006012;
	Mon, 31 Aug 2026 06:55:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjvek6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:55:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V6t8r749086972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 06:55:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2388F2004D;
	Mon, 31 Aug 2026 06:55:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7AF720040;
	Mon, 31 Aug 2026 06:55:05 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 06:55:05 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, oohall@gmail.com, npiggin@gmail.com,
        tpearson@raptorengineering.com, alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, sourabhjain@linux.ibm.com, harshpb@linux.ibm.com
Subject: [PATCH v4 1/5] powerpc/rtas: Handle ibm,open-errinjct return format
Date: Mon, 31 Aug 2026 12:24:37 +0530
Message-ID: <20260831065441.48654-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a952552 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8
 a=dEMuusSb2ODMKMaWGMMA:9 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NCBTYWx0ZWRfXyG5u7+Xtwtl5
 lItclE/ZOv3slvBGoBQ31loqPqDoCimUOia2oFZsEEk8Mh2oZOY2peXn23327ZGxKa2GEv0sD/R
 bPPi15HyOROg7UCRqZQtkvhLmuE3XEfGZrtw5wTP6W4tyfsd9uXAZhR+UYoDDZADCQAKSiE637u
 9ZkXIhz1/YutoPmaLvrYc91m1HJkd9upzzhHdftutJW6+baOlFPju03tZBiaS/Ff01VCdZvTloM
 Xa/ML7MaEIHA1s16Y+VZ9J/QI36WH9O4N1iVMGBSqBbCPVAEgZH0E0GJLAX0upOQtENcnwyK1Ix
 sUlq8klBpzb6q2Agt7iCQGb143szVNECMXMY97mi+fkVzFor+HOv2NtQhHL7lmyxuEXtgbW4SSW
 H3JE25INDkP/wgwbEUmMQEpQqhw4CXnE4Ud2YTDb+ujowRwQ6Sdspv07TYlhf37jK7DSZTusCJg
 oiYb8JW23tMIRBAc1Fg==
X-Proofpoint-GUID: UAlmyl2Ze1XhfzXsMZtJfV2mOdK6A0V3
X-Proofpoint-ORIG-GUID: c8saDculayjoKc5cageEtm0Cqqoor40m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NCBTYWx0ZWRfXxz2m0V1rK5ae
 HHdRQxd/jaho+JmckFvWa5lsJ2yFXUTZWlE3gRTiSVJ54bQlySAuISXDNn7+22rKH7uH17W/lgi
 UCdc0K+jaV9or3zVaGNWrnauQ+lrop0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310054

ibm,open-errinjct uses a non-standard RTAS return layout:

  rets[0] = session token  (output parameter)
  rets[1] = status code

Unlike all other RTAS functions which use:

  rets[0] = status code
  rets[1..] = output parameters

Add rtas_token_is_open_errinjct() to identify this call, and
rtas_status_from_args() to extract status from the correct position.

Add an early guard in rtas_call() that rejects ibm,open-errinjct
invocations where nret < 2, since reading rets[1] would be out of
bounds:

  if (rtas_token_is_open_errinjct(token) && nret < 2) {
          WARN_ON_ONCE(1);
          return RTAS_INVALID_PARAMETER;
  }

Adjust the output-copy loop so that for ibm,open-errinjct:

  return value = rets[1]   (status)
  outputs[0]   = rets[0]   (session token)

For all other functions the existing convention is preserved:

  return value = rets[0]   (status)
  outputs[0..] = rets[1..] (non-status outputs)

Move the "/* A -1 return code... */" comment immediately before the
ret == -1 check so it documents the check it guards.

Also fix sys_rtas() last-error status detection: ibm,open-errinjct
places status at rets[1], so the -1 sentinel check must use rets[1]
for that function rather than always using rets[0].

Reference: OpenPOWER PAPR documentation
           https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 78 +++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..7131870655c6 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1117,6 +1117,28 @@ static bool token_is_restricted_errinjct(s32 token)
 	       token == rtas_function_token(RTAS_FN_IBM_ERRINJCT);
 }
 
+/*
+ * ibm,open-errinjct uses a non-standard return layout:
+ *   rets[0] = session token  (output parameter)
+ *   rets[1] = status code
+ *
+ * All other RTAS functions use the standard layout:
+ *   rets[0] = status code
+ *   rets[1..] = output parameters
+ */
+static inline bool rtas_token_is_open_errinjct(int token)
+{
+	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+}
+
+static int rtas_status_from_args(int token, struct rtas_args *args, int nret)
+{
+	if (rtas_token_is_open_errinjct(token))
+		return be32_to_cpu(args->rets[1]);
+
+	return nret > 0 ? be32_to_cpu(args->rets[0]) : 0;
+}
+
 /**
  * rtas_call() - Invoke an RTAS firmware function.
  * @token: Identifies the function being invoked.
@@ -1198,6 +1220,16 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 			return -1;
 	}
 
+	/*
+	 * ibm,open-errinjct returns rets[0]=session_token, rets[1]=status.
+	 * We need nret >= 2 to read status from rets[1].  Reject early if
+	 * the caller forgot to account for the extra return cell.
+	 */
+	if (rtas_token_is_open_errinjct(token) && nret < 2) {
+		WARN_ON_ONCE(1);
+		return RTAS_INVALID_PARAMETER;
+	}
+
 	if ((mfmsr() & (MSR_IR|MSR_DR)) != (MSR_IR|MSR_DR)) {
 		WARN_ON_ONCE(1);
 		return -1;
@@ -1213,15 +1245,33 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	va_rtas_call_unlocked(args, token, nargs, nret, list);
 	va_end(list);
 
+	ret = rtas_status_from_args(token, args, nret);
+
 	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args->rets[0]) == -1)
+	 * be completed due to a hardware error.
+	 */
+	if (ret == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
-	if (nret > 1 && outputs != NULL)
-		for (i = 0; i < nret-1; ++i)
-			outputs[i] = be32_to_cpu(args->rets[i + 1]);
-	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	/*
+	 * Copy non-status outputs to the caller's buffer.
+	 *
+	 * For ibm,open-errinjct the layout is:
+	 *   rets[0] = session token  -> outputs[0]
+	 *   rets[1] = status         (returned, not copied)
+	 *
+	 * For all other RTAS functions:
+	 *   rets[0] = status         (returned, not copied)
+	 *   rets[1..nret-1] -> outputs[0..nret-2]
+	 */
+	if (outputs != NULL) {
+		if (rtas_token_is_open_errinjct(token)) {
+			outputs[0] = be32_to_cpu(args->rets[0]);
+		} else if (nret > 1) {
+			for (i = 0; i < nret - 1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		}
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
@@ -1942,10 +1992,18 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	do_enter_rtas(&rtas_args);
 	args = rtas_args;
 
-	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args.rets[0]) == -1)
-		errbuf = __fetch_rtas_last_error(buff_copy);
+	/*
+	 * A -1 return code indicates that the last command couldn't
+	 * be completed due to a hardware error.  ibm,open-errinjct
+	 * places status at rets[1] rather than rets[0]; check the
+	 * correct position for the -1 sentinel.
+	 */
+	{
+		__be32 status_cell = (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT) &&
+				      nret >= 2) ? args.rets[1] : args.rets[0];
+		if (be32_to_cpu(status_cell) == -1)
+			errbuf = __fetch_rtas_last_error(buff_copy);
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
-- 
2.51.1


