Return-Path: <linuxppc-dev+bounces-16155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB06D3EE95
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 16:59:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxnMr2Djwz30Lv;
	Fri, 23 Jan 2026 03:59:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769101144;
	cv=none; b=PhdJ4AKA6LexvG9aOjnIRkt3zd3d2naDJ8ES4K3YhE1ytUpXzdtJ0mneDQWVZVetqQwCCNffnBxF3Fp5HympqJGOxGai3TiGUY4cqdWtd4jx+PLMCq8ERg9JCkVe9kBlsA2lraqOkcgP0cW+5MxOUy+MSDVkxN+GivgIToNR67i1eeIJ4Oh050lvqEJ3PtXDD0RUBH3js8Iy5NG8z2h2QwfXeMJ2tV7sXDbROsC5dtCEcl/r9XJqRXAhPzS+dNGMmozEeAi0XBgKQqFF02FsOA3w4XX01RwguEWgf57YjKThjWLti6H3sXcqgBZFima0kDm9XXBNxP+djQBkPpXNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769101144; c=relaxed/relaxed;
	bh=mZ1+hgG9DmPwpQi0IqcYJ6ltsZZS7qzorYTorzY2VkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9oeJ5zSndWrBF22kUBU13XvjTyXxWhUeB2lU9nKDfh7RDR13FYWedUWVmyU0aRJVpI2RSbnq1g2jeHB6tYsQbh5OliP/bh0PZyhGD1FWzklpJdkf8Kku7TCATRm6lgdWBwrD2IH1esl/X/Bz8XGCsnRxMBDyGyELssT35GPi/ibW92EkAQnb0QSuxZAw7Qw8X+F1StUz9zkoed1+geP2vDqSSDVZVxG037otvKv0SUCe/egNMQzig8gfYrlmH/KzvZW3rBxQpc/w7RiFDwUqT1DZUDK3YHeT2uLU+iBt06aeNVHYkG6vSMcYUT7qq3WhI4iozrblbEHZmZeX5FfeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GUIgc2yH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GUIgc2yH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxnMq3mLJz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 03:59:03 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MDZPX3020990;
	Thu, 22 Jan 2026 16:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mZ1+hgG9DmPwpQi0I
	qcYJ6ltsZZS7qzorYTorzY2VkM=; b=GUIgc2yHkcuzrL/KsaXRikiFrM3sYtwiR
	jQy+5L7uvyUhYPIvZVokYBUCuOB7ihL9RPRgSHP56bZcqT5Uu2yVJB8dwKF/e0aX
	MUAA8EeDkXtJIR8JbgYZdjoxvE7NLrQdJBKmD31/a9q/Fjvz/3nnenO/lmWMyCb/
	rL/JDEkdfHgRF7/jVYtceBTqjTPFsMkftk6bBndTxbjVKw0UBzyunWrEfECmbEij
	a1kCRaLOyKvk3VORietZd54VbEPToWqM+1KRf7fMlaL2sDFv1wfnHNU4ty2uatVf
	fALqY+SHv0e34wdedOEL0HsTkFOm3U7o3J95lWZduwtLlQdh5yenA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufsh2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 16:58:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MGwUDX030516;
	Thu, 22 Jan 2026 16:58:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufsh27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 16:58:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MGNqHk027285;
	Thu, 22 Jan 2026 16:58:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnbf3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 16:58:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MGwPYR50331942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:58:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 282032004D;
	Thu, 22 Jan 2026 16:58:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07EE42004B;
	Thu, 22 Jan 2026 16:58:16 +0000 (GMT)
Received: from abhi.. (unknown [9.39.26.73])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 16:58:15 +0000 (GMT)
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
        iii@linux.ibm.com, shuah@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 3/6] powerpc64/bpf: Avoid tailcall restore from trampoline
Date: Thu, 22 Jan 2026 22:27:13 +0530
Message-ID: <20260122165716.10508-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260122165716.10508-1-adubey@linux.ibm.com>
References: <20260122165716.10508-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: t4OPcj_KSlIM6V7E8PUYgG2ZL_nZEP63
X-Proofpoint-ORIG-GUID: QN6Ii6DuF_E3UNSJI3OAoqT1u_KfVhsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyOSBTYWx0ZWRfX1/DDTQchqi9a
 i+EJLlIK2yBjorfpJeqHFxnzCnZY8EAt2B4iv12mLQ0kbFpy2fy9i/7GJLpXjZVy7Xrg26rlv4W
 L2Og9qohokspZ+dUpq0lIc01YdLBb/bOw4Ud7lzIxZsb/DwN2YaEjiVB1hAQ7MG/WzNp6Wq2/HK
 aSk+w8Vb3HEnOUJoZdLxT762vJLLTK2qs29b6oT48048cVRn21shhqvup2okBx7/ZzONsU7kl/B
 bCmRfWVp836UiPapmGz8JvNVq6dtUqoAoY6apD6jWoHN5h2g+34SnV5TaDdgvGaH+JZz86Z1057
 /GelDXVJmyQwZqnxIufm6sx7qX1YFZIj0D2S4cOZl0oZ5Mnpg06zEOn65gAlxY0JabHpK0en9I/
 m+VFE9427okVIzTSWJbDk77kLi/xoqmjEkG9+TGIHYJ2FBrghyoLgm/egmN8wVhZ9l6/ObOXDtE
 AtPYuiVgkn9JFEHuxGg==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=69725736 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=HXp8xpokhkwciMovXI8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220129

From: Abhishek Dubey <adubey@linux.ibm.com>

Back propagation of tailcall count is no longer needed for
powerpc64 due to use of reference, which updates the tailcall
count in the tail_call_info field in the frame of the main
program only.

Back propagation is still required for 32-bit powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index f3ee031edc26..9a8236d161ef 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -662,16 +662,11 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 static void bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_context *ctx,
 						 int func_frame_offset, int r4_off)
 {
-	if (IS_ENABLED(CONFIG_PPC64)) {
-		/* See bpf_jit_stack_tailcallcnt() */
-		int tailcallcnt_offset = 7 * 8;
-
-		EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
-		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
-	} else {
-		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
-		EMIT(PPC_RAW_STL(_R4, _R1, r4_off));
-	}
+	/*
+	 * Restore tailcall for 32-bit ppc.
+	 * See bpf_jit_stack_offsetof() and BPF_PPC_TC
+	 */
+	EMIT(PPC_RAW_STL(_R4, _R1, r4_off));
 }
 
 static void bpf_trampoline_save_args(u32 *image, struct codegen_context *ctx, int func_frame_offset,
-- 
2.48.1


