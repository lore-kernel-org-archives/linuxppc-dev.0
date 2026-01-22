Return-Path: <linuxppc-dev+bounces-16169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9BBD6CFA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:26:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxvHq3D9gz2xQs;
	Fri, 23 Jan 2026 08:25:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769117159;
	cv=none; b=nkePVXTbbFc57A1/YxZS6eI5h+uz1P1ZGVQlSvesK6habWly0xqJuV2rF9aju9U/meQ0WJ5mT1Ihn2tyjzj7Bo+L87wPPHwtqENMpQTe1EEvFP00ZgchwVZKmUxvGVpMm9gyaY66DDf7+aAn63RxXN2XS14ccr0Elc0/z/29fOrlIaxVO86Ek2QNQJJH8LqdMsqTh+xom4PvdNenaZtCtySWSbQWreMVJT7akkeQeLuQ8VoHRWD/mpNq5PWM/X83VsSy7j3mFUJ18ez4qB4OYCGTgO6BPpdoStw+AaZvbkzyx+IpDGy++K59zXnUy+tJE+p/bbsm3M8chb5oyE8RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769117159; c=relaxed/relaxed;
	bh=TXgmDXs4JFjAGlSMtms1ah2TwLO40IrSCwqYBvl/j9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGyDWEqqjfimCOTFsZEguq6TpT1buEIG7Jai+VNs58QcAGorNM1+5IeUxRvA1KSCueolRBlrv6SluMhO2EzmAsFlWwVnJLrRqfUWhPWTFdOFACnEaJNgKMXB8wQshCHzzwLGKqmnZKsKgnaGDOW5xnBYJAcjsiwiqC29X+zRQu5spbU2Y6cHdIinoqzZgJz+4UE7QSa2g3bRBZ2rs7bBD4z6NqFzfjjSZugLaj8nI5+RWG/zMkK7qDx1rfJQMJAa81Es5eSz/frWKVuizReqhytW8RhzokPFlDMZibxp01cMN+v7uuC6JlZIF70sKyH70coWSc3p9xhEZGG9O7JGPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i7GWayn/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i7GWayn/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxvHp3z1fz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 08:25:57 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEXF3c021316;
	Thu, 22 Jan 2026 21:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TXgmDXs4JFjAGlSMt
	ms1ah2TwLO40IrSCwqYBvl/j9w=; b=i7GWayn/QQwrubpnUNbMqu4jZdNn+nOW/
	1u/nQ4+BAjDVOFfg5rwqxGhMSttGrVVVO1tjXVAh9FjppGepgnFO2PDX3D1m6zZD
	Sze1KGVN5ZtE5/kJ/Wt54VTfnFscF/UExm7I9xgcOEFkI5uGDMWLQWLOzUdT/Cvp
	dZClv8TL3aCCvSgpGLRZjxEy32h1pbstqvDkSWbmq950ep8gqyXpGPptxt0izSav
	nvld4lqeGmcQkOyTWZTb+wPLlKbbagR4vqRF162JyCSqMOrBWuqhZLHq5fkJ+m+O
	Hyrz/q+RAhVQ31AQeY96HiJ1sKlA2OEsYq0ZlQKyBqFN0oYkq/5nQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612f1ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 21:20:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MLJPSt031579;
	Thu, 22 Jan 2026 21:20:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612f1m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 21:20:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60ML8q7c027233;
	Thu, 22 Jan 2026 21:20:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrncy3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 21:20:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MLJuLT61669880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 21:19:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 312A32004B;
	Thu, 22 Jan 2026 21:19:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6406120040;
	Thu, 22 Jan 2026 21:19:49 +0000 (GMT)
Received: from abhi.. (unknown [9.124.222.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 21:19:49 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
Subject: [PATCH v4 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF JIT
Date: Fri, 23 Jan 2026 02:48:52 +0530
Message-ID: <20260122211854.5508-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260122211854.5508-1-adubey@linux.ibm.com>
References: <20260122211854.5508-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: Bi1LIpXrrGVye6rfzAQkPQovYN59Ekfz
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=69729481 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ovcAVf-9gG4EF5hqTukA:9
X-Proofpoint-ORIG-GUID: BWYecn5M-kVPH1btpTP8sK0d8HdbdFG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE2MiBTYWx0ZWRfX2YhzRuJhLt/I
 eK5YHBqr1K76OrTkancm/KzY8JobRFCIAG2GZIZma4pigrSKQMMaRcWRIZ+ogDcc+tlH/CiRAzQ
 /J41SqKdvOQ8JgrGk/umy8YEB1Tg3RNC163EyWLw1Kj0qUrgft3ZS7wAAyvYYLPHKdn2xIcYltX
 V1/+kP6Eorgy8Frp/a3whSjC+g7Cv5u5W+Wx7ebStVxYACvwe2n9Dzud1ow45PefvmPqEykE9OA
 tVUZ0LJmrwWtlVv3KY9FLOppMDIzGfZ55RnSXuZahrhZTuuqLcXDvK1leu2oOfjchZbTTkgi/BU
 MR8N05Zuj7IKxvhwHy1I32YBt4bG4CkHs6yGNwvQ/CicRTJP6HjHoGTtFHoupd+7TIpVDdlokEr
 UHzGobbJTVv138CugPrhbk6LlCBKxz+61gap0IO1SMbxUqsLDTUbdK+U+nkECIiTGuUt0BNVyGV
 H8BGWO9eKYRmLT6PsVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_05,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220162

From: Abhishek Dubey <adubey@linux.ibm.com>

This function is used by bpf_throw() to unwind the stack
until frame of exception-boundary during BPF exception
handling.

This function is necessary to support BPF exceptions on
PowerPC.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 18da5a866447..c25ba1ad587a 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -247,6 +247,34 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	bpf_jit_build_fentry_stubs(image, ctx);
 }
 
+void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie)
+{
+	// callback processing always in current context
+	unsigned long fp = current_stack_frame();
+
+	for (;;) {
+		unsigned long *frame = (unsigned long *) fp;
+		unsigned long ip;
+
+		if (!validate_sp(fp, current))
+			return;
+
+		ip = frame[STACK_FRAME_LR_SAVE];
+		if (!ip)
+			break;
+
+		/*
+		 * consume_fn common code expects stack pointer(sp) in third
+		 * argument. There is no sp in ppc64, rather pass frame
+		 * pointer.
+		 */
+		if (ip && !consume_fn(cookie, ip, fp, fp))
+			break;
+
+		fp = frame[0];
+	}
+}
+
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-- 
2.48.1


