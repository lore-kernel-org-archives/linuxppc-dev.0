Return-Path: <linuxppc-dev+bounces-17126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9F7F4BB7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 20:10:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL83D2vTWz3dHj;
	Wed, 25 Feb 2026 07:10:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771963816;
	cv=none; b=HnLx1C16BYG6oDVSsP7en4+Xb9rVU4oJ6Panq+fArIg4zfQR6Fo1ubfazMbTNCaYkIDZAXJUkzKaOyJpZuRhk9XUnfMhiuwOJwyEHPtitK9hhqewbKb5PSbYF77rtlHgw1mLICdHQCvjfg43GTJ4JPGQimOGqTIHNbsWEMkB/ai0xynrHB5eqJ54zJnqtb4e8cGHdAZ5OR9YuVm23xAfHeD8ZLVg9/1F9iYgO5D7Y0ZjbfUz/IRigauN/BVQvrdW5tqBPV8nQ47OTApkDXSnogVglFfRbVSZjVsSl9xd5H0r+iEFZIYDaPc41x5csDUcASVr+YSa17acpHHgP8jbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771963816; c=relaxed/relaxed;
	bh=MjWESjX04CAWD4zzLRb+rT+HtdG6O8zDobj6zNRKaJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHWcv/TtcT3bda2uadjWenavPqy1diV4wzF5v5Hm/4FMMdCh1iYEPZa4VBIbDVsKRKfAA6IDXWWNiNFbbCIqCNMKPU9ebbn66T20MMDaGCacByf2UnJsfDbnDLgGij/zN5ucfl1QgtugrAGym73i1Ib/JGBnGu/9zD5vxwQnhJ/uTos9uq687FiTlGZ0WPOI4EiVlybvTOFV96pz1HxzrtccjqUdjavKxKI+mmMAgtXANpni+VndbtMMcg8F6fcdUw2TbGouu1anjk8NR4427ReL0HOJqwItVf50faU1BcxqPQX/ObGFuclT5ce6MLsR/JUMBb0pkM9YT1PjLh0H2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pbftFmji; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pbftFmji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL83C4V7Kz3cbQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 07:10:15 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OFQjmS1361599;
	Tue, 24 Feb 2026 20:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MjWESj
	X04CAWD4zzLRb+rT+HtdG6O8zDobj6zNRKaJI=; b=pbftFmjiN8JIN+Z9Ec8GIx
	ZKIS5jUpDuak7+WreLciVwyyyOm2Rlkq71/SsBrFQTG36XDxJ71UF9N7qZLlwJRE
	R7MobKQ/yggeCGN3C/7/oQyGyjg1Ux3lHCrHwF/7LLJm6lZ1jyH06neqkFYwzTln
	ZwuV3g7wCwOH1gsOushRNCuCbUAXtJiw/wxKyLhKTotk8ejMfUdlv9/Y0k/C7VwM
	pzvkImr+FjFKIKrv8LlXhv10nOuBHhBtjHyDFN7k/z/1nCr0X1L1HREGNtKSGKLB
	nrDAq8PPu75OTJMHoHsfpZDccRZOkFtqVYDaG7NCB5z3glbmYASwMlXB4iQKoo7w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c4t77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OGcddP013448;
	Tue, 24 Feb 2026 20:10:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy2jdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OK9vgZ40698280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:09:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3614D20043;
	Tue, 24 Feb 2026 20:09:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD4120040;
	Tue, 24 Feb 2026 20:09:55 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:09:55 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 3/4] powerpc64/bpf: Add support for indirect jump
Date: Tue, 24 Feb 2026 20:09:31 -0500
Message-ID: <20260225010950.20218-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225010950.20218-1-adubey@linux.ibm.com>
References: <20260225010950.20218-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX1/etIOebPwcR
 zu9M4gGVaNRinBUYJEtnJTRbYR7zF+N31ZnO00v/qeLmQ1EFb6hFa+MXcWkt/tljWcGg2bEl0bJ
 R6tsmlIAeRXmJiUR9Eb+z4xTn10VoaStjqNo8bU8tWWTc3hsVs2UCLW6h4jylUkaDPvLtpoc8uH
 7k4cT21E7lvKY7NxSOePLcXAR+bjPN6G2lI64lGH9lZ1QaEekeMKvqs4ttK7m6K0pl3hzzjkAgc
 6JdrMoL91clMzFIs6bp+THt4pEpNYCfcddtzvAk3fKjYzgsHYsdBTZDU9qL24NeUd2olmOle1po
 aj0GJxdGOBqHbMMPRJpLcxQggK3qZ7WCSY0IBNvo4HUBwpvAjPKlrHfX22TfMVbGG5PDVf+NZSR
 8nFuSVKz7EZhxi8Qwan+RC9cHvLLrMx8mm6VQ0U6w9w3OGelbCenhTCZTeN9m9MssVLlL7WmvEA
 m2gtjvS5vpG94i4VT4w==
X-Proofpoint-ORIG-GUID: C0KSaXJz-qQXWGq1EZpiS4RFAp4zN0lg
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699e0599 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=_W6WOvRXMcVY7OADHKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C0KSaXJz-qQXWGq1EZpiS4RFAp4zN0lg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240173

From: Abhishek Dubey <adubey@linux.ibm.com>

Add support for a new instruction

	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0

which does an indirect jump to a location stored in Rx. The
register Rx should have type PTR_TO_INSN. This new type ensures
that the Rx register contains a value (or a range of values)
loaded from a correct jump table – map of type instruction array.

Support indirect jump to all registers in powerpc64 JIT using
the ctr register. Move Rx content to ctr register, then invoke
bctr instruction to branch to address stored in ctr register.
Skip save and restore of TOC as the jump is always within the
program context.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 33ea07660ebc..8771c9f23c98 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1604,6 +1604,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			addrs[++i] = ctx->idx * 4;
 			break;
 
+		/*
+		 * JUMP reg
+		 */
+		case BPF_JMP | BPF_JA | BPF_X:
+			EMIT(PPC_RAW_MTCTR(dst_reg));
+			EMIT(PPC_RAW_BCTR());
+			break;
+
 		/*
 		 * Return/Exit
 		 */
-- 
2.52.0


