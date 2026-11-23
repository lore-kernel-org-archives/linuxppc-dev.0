Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34747606A6A8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PW8O3Glp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY29C2ZVdz2yKn;
	Mon, 23 Nov 2026 21:23:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795429439;
	cv=none; b=KRQG/DImMqcHZuBAX3wTEq1sFvI7Gd3EG6FO6LacryY1BgpqqzvAddfc9AsvoMyEVTyat/y4XxFEeDjZH0MAJuzB4qjBvPHIAqSmhUH8Ho2s8smCzF1z8e+Py/B0HD46UFxXanRhnm8E6i9JY+n33MyJSZ9jS7UDXUV4m6sEFwor5dspmjSwC33bUrEka8gYxYEd+MtSwPlrN17DAs0VQXdGWMFoFaVp3WsWPx2oqVWArbWoe6ajAijpqNL1xeUDpVBrxkxFM51huXNnxcoe5EaI7exbiX8j1C/qeTLdbDuhIVHrK/LYmyzljT/QYRnqCehYQ9FHVMvDMRdE0/lyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795429439; c=relaxed/relaxed;
	bh=fk4Xq849+8+EE6qHawhUwxyOI8ZUR4PXXj7Hb0IUYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ5L+7oEX2NJXsVko8cHC32XIxNkmAiKg0BtnGCg9RfW7gKOwXJ8bybwkQD2RbzFZpSsf2Ovdj4KnfM9JssbkxhHYaoVWMPE646Mz+n8tNppbhrE0pJ/npREWHKvqe6YQOcwtWvivKC9EeAuBhKATfQPYExZB78OElhRrL+s/kKJsS3MGP37p3Zk8/jOHmPzduB3mZd9qxnMIQPrKyM6kBXUsB+b94CYAPQ/C4r6RW4D+XOqbDi3SrFpqNoaxe7EHdIH+7teJ2/98AiNMCsXm34L/BQCUEsDQbEhwGR23hag7cUQfdqS0XL1dJ9pBRXZQU0Or7av0L0+W3RE4QM9sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PW8O3Glp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PW8O3Glp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY2996Fr7z2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:23:57 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9YxXu3252521;
	Mon, 23 Nov 2026 10:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fk4Xq849+8+EE6qHa
	whUwxyOI8ZUR4PXXj7Hb0IUYXo=; b=PW8O3GlpmHlDC36trtq3iOiWXRlTDhYF8
	fHbyogscwdK4wT563+EpCiHKwJi+3eVV7MtsuINFNhG6Hm/XhuSNhlL7KuNfCFxI
	xTeqN7HUfrV9gjaFdQc+A69UH5cRhDZs4XDPTaYEWf9yGD8c/EpL/wfi6vDndozv
	1bBNNgU28o1HZ3mAZa2mzS9Ga5XKhLOLcilVoIgpAc/b3Kxtom/SL4UiDBzK1Man
	99MOK+ByiYuN74qlvy3gyRpGuAu/iaBr7z6ztp8awAgrGeeTPuG/oRMM6PDQPpgh
	W9vMCughTvkiWpUGoufFXUzwXwBQNHiK1ejqCODz/et6Y7GFdGcXA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g12a6e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JJbt956227;
	Mon, 23 Nov 2026 10:23:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vee7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANANPKR51249620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:23:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F5A32004F;
	Mon, 23 Nov 2026 10:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A763820043;
	Mon, 23 Nov 2026 10:23:22 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:23:22 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>, sourabhjain@linux.ibm.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v7 1/4] powerpc/rtas: Handle ibm,open-errinjct return format
Date: Mon, 23 Nov 2026 15:52:39 +0530
Message-ID: <20261123102237.95860-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123102237.95860-6-nnmlinux@linux.ibm.com>
References: <20261123102237.95860-6-nnmlinux@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Z-lwtN-HP5xEnbe_S1LqRvx6Q_M_pG0D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX6/UHFCmS/NOx
 iSJsTbLBFZJ4ltH2ixnEyvfvk/x2g0FwM7fIDKnQZA1qK0keYhOD9PpP0ZqE8ZrQ97iq7JMJZH+
 pg9HMjkQ3rLMF7/9gZFB79nrartMBAE=
X-Proofpoint-GUID: nEQgdE4DsoWBelyikVkLT8oB6I3Wpz5l
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b041423 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8
 a=W6-AMay0JfweMWvUZhgA:9 a=O8hF6Hzn-FEA:10 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfXwnL2+oEh6xOM
 NM3h8wA9hsavyynpeFwaRUllX33DVKTmpBkwdAN3AudHgE+zeUC1FAz2DFPOZlb8pc1UKxSEBTb
 uXH7vpxdseAaAQdK8Fda13f9IM7rxh1/3D79Au0gFOwfGGJyPDeBPKV50waNJKo4qjOp0UAE0Ym
 q4vmyChfRxceW8vJO914r8sFzn4ndZYCiHvLA8tDNog8YIUHOZVh/YyHtT7X9O+B/ax7PcOpZZU
 0ZJYDSW6gefcEL7YzocNmdBO+lZrCp8cjF8keWR1gWzGX8GifmTvukCq8ZH36f7CFRy+hqgNrrN
 CVDhK9DYLvwHkcMbqrlUoWL96wMOt+MyxL538tskIaMkUgYFau2zDVOy03qSSeAVgXtL4FvpKoA
 0Fn7Ipg9Y7lBcM9O25EwPQcJnYIA6/4atYzx5bheIu93kCMY+mIdTbGmU1we494XaWyp9l46bMc
 cj6dYJVoT84ZdfdLIRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230040
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ibm,open-errinjct returns the session token in rets[0] and the status in
rets[1], unlike other RTAS functions, which return the status in rets[0].
rtas_call() would report the session token as the status and drop the
real status.

Take the status from rets[1] for this function and return the session
token in outputs[0].  This needs exactly two return cells, so reject any
other count from kernel callers with -EINVAL and a one-time warning, and
document the exception in the rtas_call() kernel-doc.

Give the rtas_output tracepoint the index of the status cell, so that it
reports rets[1] as the status and the session token as an additional
output for this function.  A call with no return cells reports status 0
instead of reading a cell that does not exist.

Ensure __fetch_rtas_last_error() and sys_rtas() initialize rtas_args.rets
to point into rtas_args.args[] after copying local arguments, preventing
tracepoint handlers from dereferencing uninitialized memory or reading
stale on-stack values.

sys_rtas() still copies the raw return cells to userspace.  It uses the
status from the right cell for hardware-error (-1) detection and, after
the lockdown check, rejects fewer than two return cells for this function.

Link: https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/trace.h | 26 +++++++---
 arch/powerpc/kernel/rtas.c       | 83 ++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index a7b69b25296b..d731f70aead7 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -146,25 +146,37 @@ TRACE_EVENT(rtas_input,
 	)
 );
 
+/*
+ * @status_idx is the index in rets[] of the status cell: 1 for
+ * ibm,open-errinjct, which returns its session token in rets[0], and 0 for
+ * every other function.  The remaining cells are reported as other outputs.
+ */
 TRACE_EVENT(rtas_output,
 
-	TP_PROTO(struct rtas_args *rtas_args, const char *name),
+	TP_PROTO(struct rtas_args *rtas_args, const char *name,
+		 unsigned int status_idx),
 
-	TP_ARGS(rtas_args, name),
+	TP_ARGS(rtas_args, name, status_idx),
 
 	TP_STRUCT__entry(
 		__field(__u32, nr_other)
 		__field(__s32, status)
 		__string(name, name)
-		__dynamic_array(__u32, other_outputs, be32_to_cpu(rtas_args->nret) - 1)
+		__dynamic_array(__u32, other_outputs,
+				be32_to_cpu(rtas_args->nret) ?
+				be32_to_cpu(rtas_args->nret) - 1 : 0)
 	),
 
 	TP_fast_assign(
-		__entry->nr_other = be32_to_cpu(rtas_args->nret) - 1;
-		__entry->status = be32_to_cpu(rtas_args->rets[0]);
+		u32 nret = be32_to_cpu(rtas_args->nret);
+		u32 *other = __get_dynamic_array(other_outputs);
+		u32 i;
+
+		__entry->nr_other = nret ? nret - 1 : 0;
+		__entry->status = nret ? be32_to_cpu(rtas_args->rets[status_idx]) : 0;
 		__assign_str(name);
-		be32_to_cpu_array(__get_dynamic_array(other_outputs),
-				  &rtas_args->rets[1], __entry->nr_other);
+		for (i = 0; i < __entry->nr_other; i++)
+			other[i] = be32_to_cpu(rtas_args->rets[i < status_idx ? i : i + 1]);
 	),
 
 	TP_printk("%s status: %d, other outputs: %s", __get_str(name), __entry->status,
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..201be33d9bd3 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -693,6 +693,32 @@ static const struct rtas_function *rtas_token_to_function(s32 token)
 /* This is here deliberately so it's only used in this file */
 void enter_rtas(unsigned long);
 
+static inline bool rtas_token_is_open_errinjct(s32 token)
+{
+	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+}
+
+/*
+ * Return the index of the status cell in rets[].  ibm,open-errinjct returns
+ * the session token in rets[0] and the status in rets[1].  Every other RTAS
+ * function returns the status in rets[0].
+ */
+static unsigned int rtas_status_idx(s32 token, u32 nret)
+{
+	return (nret >= 2 && rtas_token_is_open_errinjct(token)) ? 1 : 0;
+}
+
+/* Return the status of a completed call, or 0 if it has no return cells. */
+static int rtas_status_from_args(s32 token, struct rtas_args *args)
+{
+	u32 nret = be32_to_cpu(args->nret);
+
+	if (!nret)
+		return 0;
+
+	return be32_to_cpu(args->rets[rtas_status_idx(token, nret)]);
+}
+
 static void __do_enter_rtas(struct rtas_args *args)
 {
 	enter_rtas(__pa(args));
@@ -719,7 +745,9 @@ static void __do_enter_rtas_trace(struct rtas_args *args)
 	__do_enter_rtas(args);
 
 	trace_rtas_ll_exit(args);
-	trace_rtas_output(args, func->name);
+	trace_rtas_output(args, func->name,
+			  rtas_status_idx(be32_to_cpu(args->token),
+					  be32_to_cpu(args->nret)));
 }
 
 static void do_enter_rtas(struct rtas_args *args)
@@ -1034,6 +1062,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 
 	save_args = rtas_args;
 	rtas_args = err_args;
+	rtas_args.rets = &rtas_args.args[2];
 
 	do_enter_rtas(&rtas_args);
 
@@ -1122,20 +1151,28 @@ static bool token_is_restricted_errinjct(s32 token)
  * @token: Identifies the function being invoked.
  * @nargs: Number of input parameters. Does not include token.
  * @nret: Number of output parameters, including the call status.
- * @outputs: Array of @nret output words.
+ * @outputs: Array of @nret - 1 output words, or NULL.
  * @....: List of @nargs input parameters.
  *
  * Invokes the RTAS function indicated by @token, which the caller
  * should obtain via rtas_function_token().
  *
  * The @nargs and @nret arguments must match the number of input and
- * output parameters specified for the RTAS function.
+ * output parameters specified for the RTAS function.  @nret includes the
+ * status cell, so @outputs normally receives the remaining @nret - 1
+ * return cells.
  *
- * rtas_call() returns RTAS status codes, not conventional Linux errno
- * values. Callers must translate any failure to an appropriate errno
- * in syscall context. Most callers of RTAS functions that can return
- * -2 or 990x should use rtas_busy_delay() to correctly handle those
- * statuses before calling again.
+ * ibm,open-errinjct is the exception: it returns its status in rets[1]
+ * and a session token in rets[0].  rtas_call() still returns the status,
+ * and @outputs[0] receives the session token.  @nret must be 2 for this
+ * function; any other value fails with -EINVAL, a Linux errno rather
+ * than an RTAS status, without calling RTAS.
+ *
+ * Apart from that case, rtas_call() returns RTAS status codes, not
+ * conventional Linux errno values. Callers must translate any failure to
+ * an appropriate errno in syscall context. Most callers of RTAS functions
+ * that can return -2 or 990x should use rtas_busy_delay() to correctly
+ * handle those statuses before calling again.
  *
  * The return value descriptions are adapted from 7.2.8 [RTAS] Return
  * Codes of the PAPR and CHRP specifications.
@@ -1198,6 +1235,12 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 			return -1;
 	}
 
+	if (rtas_token_is_open_errinjct(token) && nret != 2) {
+		WARN_ONCE(1, "rtas: ibm,open-errinjct requires exactly two return cells (got %d)\n",
+			  nret);
+		return -EINVAL;
+	}
+
 	if ((mfmsr() & (MSR_IR|MSR_DR)) != (MSR_IR|MSR_DR)) {
 		WARN_ON_ONCE(1);
 		return -1;
@@ -1215,13 +1258,20 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
-	if (be32_to_cpu(args->rets[0]) == -1)
+	if (rtas_status_from_args(token, args) == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
-	if (nret > 1 && outputs != NULL)
-		for (i = 0; i < nret-1; ++i)
-			outputs[i] = be32_to_cpu(args->rets[i + 1]);
-	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	if (rtas_token_is_open_errinjct(token)) {
+		/* nret is 2: rets[0] is the session token, rets[1] the status. */
+		if (outputs)
+			outputs[0] = be32_to_cpu(args->rets[0]);
+		ret = be32_to_cpu(args->rets[1]);
+	} else {
+		if (nret > 1 && outputs != NULL)
+			for (i = 0; i < nret-1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
@@ -1904,6 +1954,10 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 			return err;
 	}
 
+	/* ibm,open-errinjct needs rets[1] for its status. */
+	if (rtas_token_is_open_errinjct(token) && nret < 2)
+		return -EINVAL;
+
 	/* Need to handle ibm,suspend_me call specially */
 	if (token == rtas_function_token(RTAS_FN_IBM_SUSPEND_ME)) {
 
@@ -1939,12 +1993,13 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	cookie = lockdep_pin_lock(&rtas_lock);
 
 	rtas_args = args;
+	rtas_args.rets = &rtas_args.args[nargs];
 	do_enter_rtas(&rtas_args);
 	args = rtas_args;
 
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
-	if (be32_to_cpu(args.rets[0]) == -1)
+	if (rtas_status_from_args(token, &args) == -1)
 		errbuf = __fetch_rtas_last_error(buff_copy);
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
-- 
2.54.0


