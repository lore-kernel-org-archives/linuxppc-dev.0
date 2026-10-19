Return-Path: <linuxppc-dev+bounces-29696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231CBCCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:19:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Wjp4FdXz2ygW;
	Mon, 19 Oct 2026 21:19:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405150;
	cv=none; b=g64LC2nwp+gaOZcVy+bTUOMOoBCacLUdy5QsyrelbOhuzyjgBWRXAqXjcgZhky3JmiLAXtFceItGIRK2ZeVhjlexDUuocx6aQ0jKi3D88cm48aO4+zrNPEkbWW0XhEjRTyLNztMQQooWnRhkraVOIFMd1UW1ak+BxkHTEnw1Z08CBN/2qhiMtayuTxe2eY0UFCbSRrfkbDyk0UhQRabj27WJF/7Zc07pefxI59hTSO26w26rpGFXYJpNouC/BE7veI0amy4+qUUQg7DM/WJQ0dNIPfoZVJSsadv+XYWcLnhqpLH8ILZkaKVWneVZEpn7RUu9FV9n1tVhaIe2dqCFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405150; c=relaxed/relaxed;
	bh=r4YBy/SHvgVV9nXhiYBv1r8DYq8G0AiO7fdNVfHKjfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmWV+d1sWEi1hPXVEX49JZ+LOpXt+aRVSzIlcWhkHJ1fBCSvwi0OIkzve+LD5e2LM/djNC+NYLYDNReTBjuHEVgyhpu+/JRwK0A00wGb789L3zT53vEW7j4xf4QqISueRSCMhS/3BBLgj3xZbHGt8Vp+N9aieR/kwKviP8RSbQQP+QVJHw6zyA2R81sbuHcMYjMBbgpz1+Lpycu5KckVuS7h/OqTf1pIa6GJ+W0lNaGHUivCxd4W7sizxFt4sRA4uUu5xn6aYdoDocmYur1XpJwYSp429iRVJyU4RYVX6kG6xUoYhk1MqILQgQeLjK7/ogszu62VSlu1EpufQpYP6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KtUKOrGC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KtUKOrGC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Wjn013tz2yfy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:19:08 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iDm13449410;
	Mon, 19 Oct 2026 10:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r4YBy/SHvgVV9nXhi
	YBv1r8DYq8G0AiO7fdNVfHKjfY=; b=KtUKOrGCnnRYcuPJn1iMknkgr5rH3B4Iy
	uHxbbtAnmYGso4jD8V7n52ewGonX4EdADiBlkNAXaRbtwewUj7NaYuUZHYvZTHb4
	RDsuNIIrneVRcKEq0q9J7YFAN4B8eOP4+Td2yTUFz+cmCsbARXhqF1r8vz7h9KH5
	XmPluk8Xe7tjdaEDhQ1ViBS8ywsAIoUZvHNFrVB22YTru7ol276jWyi9rEJeTEBL
	v5uKPKJFMLzUQKPJKjIXe5WDtj+nSKziFTpPQSU/aG48aiFSciySEsxc3b/jWzRq
	U+LPVdQTYOUHLMaJS8GTBPo1T/3NaT1FKkT3+oY2B4Wol9ShP0xBQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h5ajqk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:18:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8YqaQ3802387;
	Mon, 19 Oct 2026 10:18:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjw7qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:18:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAIrxm17039828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:18:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7402005A;
	Mon, 19 Oct 2026 10:18:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6162004D;
	Mon, 19 Oct 2026 10:18:49 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:18:49 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v5 1/5] powerpc/rtas: Handle ibm,open-errinjct return format
Date: Mon, 19 Oct 2026 15:48:09 +0530
Message-ID: <20261019101813.45085-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX+m4gXMRb9RBs
 Sfj5csr2SJQxPnSBVzIXwnCaettsf1mjmjgYg4sY7pIfhV5CbbzeJin5FwQ2f0AofhLKkWjoe5p
 PmyjcBinG2Cn9Pgiqu11ycJWGiwwuA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX12rG+6P9KBZg
 Df1XPOZc7zP/A1bML3hj7ly5mkQVnvOf5mx9fVTkqVpt78ztwC6ZCEsSY6Js2Hja7h3d9Whg5Kd
 0XKKTllYORA2JHpDyUrMrHtQf6TihURl9KLc7LGnLWWztYxiegd9jBptsPITSbcAH+rlDjCn5Ed
 7XMPevLazqPD3UKgnk0k8BteM6PhrdvEl0T/Jxh78OcEZBy1ZPRZCEo+mYNfSG+W36v2Vunubz5
 Pcmf3DLBmjq/1u0rib8g2ctfKuqc2/W6cQ1vn5AL03Mt7bdH44Dm+0uumgbDdJAIGDUrp9VzSSM
 Ntd9hTKEJdGUEgfMR0mH6HF/JHRuxmY9qmWYh7mhqdlASQsX8izMBzyPO7wVGxDDSUgNIDpJsiI
 MpotzByEzsfO+Xdfjdka374Chx1FX1kV/OSDjt6G3k/zOpZVbq8O4hqV6Y+7ftSuaqnDpA1MMeK
 g+0h57vcYVRs2xk5cyw==
X-Proofpoint-ORIG-GUID: z-RH3erF_FHn4Jg02LOi6IGMWgEl1EGY
X-Proofpoint-GUID: TGf_DjKllITPfWpLQUZASBICsgvIAqhZ
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad5ee93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8
 a=UsokGn5mh7P9jOUuuDIA:9 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190040

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
bounds.  This is a kernel-side call-convention error, so -EINVAL is
returned rather than an RTAS firmware status code:

  if (rtas_token_is_open_errinjct(token) && nret < 2) {
          WARN_ON_ONCE(1);
          return -EINVAL;
  }

Adjust the output-copy loop so that for ibm,open-errinjct:

  return value = rets[1]   (status)
  outputs[0]   = rets[0]   (session token)

For all other functions the existing convention is preserved:

  return value = rets[0]   (status)
  outputs[0..] = rets[1..] (non-status outputs)

Move the "/* A -1 return code... */" comment immediately before the
ret == -1 check so it documents the check it guards.

Also fix sys_rtas() last-error status detection: add the same early
nret < 2 validation at the syscall boundary (returning -EINVAL) to
avoid entering RTAS with an invalid ibm,open-errinjct return layout.
After that guard, use rtas_status_from_args() to obtain the RTAS
status for last-error handling.
The prominent user librtas already passes nret = 2 for this function
as required by PAPR, so well-formed callers are unaffected.

Reference: OpenPOWER PAPR documentation
           https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 78 +++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..38f3d08d4228 100644
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
+		return -EINVAL;
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
+	if (outputs) {
+		if (rtas_token_is_open_errinjct(token)) {
+			outputs[0] = be32_to_cpu(args->rets[0]);
+		} else if (nret > 1) {
+			for (i = 0; i < nret - 1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		}
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
@@ -1896,6 +1946,14 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	if (block_rtas_call(func, nargs, &args))
 		return -EINVAL;
 
+	/*
+	 * ibm,open-errinjct places status at rets[1]; reject calls with
+	 * fewer than 2 return cells before entering RTAS, since reading
+	 * rets[1] for the -1 sentinel would be out of bounds.
+	 */
+	if (rtas_token_is_open_errinjct(token) && nret < 2)
+		return -EINVAL;
+
 	if (token_is_restricted_errinjct(token)) {
 		int err;
 
@@ -1942,9 +2000,11 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	do_enter_rtas(&rtas_args);
 	args = rtas_args;
 
-	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args.rets[0]) == -1)
+	/*
+	 * A -1 return code indicates that the last command couldn't
+	 * be completed due to a hardware error.
+	 */
+	if (rtas_status_from_args(token, &args, nret) == -1)
 		errbuf = __fetch_rtas_last_error(buff_copy);
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
-- 
2.54.0


