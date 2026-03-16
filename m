Return-Path: <linuxppc-dev+bounces-18214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8B8EFCBB6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:26:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4q92VLXz2yr7;
	Mon, 16 Mar 2026 17:26:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773642373;
	cv=none; b=divYX3mzfurmDWOdH3ByDwVieWkHinke8P/nWJAxr+cJskETq9+fgO8BWbTY+kEbbPtl7UdKoIUKgvVkFQT8C22PqUo+afJy61M3o8WC7KD8JGyuOiMIjKCLUddvFOzCC2cX8gmmvKQP0PZmeq+aC9Nu/CNYAJjXTZn7AtZgr3MJXnSywP40gWG3WJ7z8pacAqLAHnuPJIDcEpdR9gIfa6A5IOTGyKlLAJB+3skzcr3wsaaorEf5gBvIAj9hIBLE2P4dCganZ7ojwNkUF8erI5HRO7cX3oxrT29hs3xQ69S9qpSepLcpxNmZLp8q+NHrVll7ZT9RQGLNW9d78qRrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773642373; c=relaxed/relaxed;
	bh=UXhjmtqVsij/LUllyHwnJ+xDPArOzo01zjKtMLmdHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5gZUFKpYxR3TE7vxmg94M4fSH/C2tIQl98FhzUWIes0YRbC82vgMTLcvGINHfPUGuoHCRZdYqWySDBwmCo5J1fBXXMkTJ9USwzpE4CLh+dckv7xxi6+XEluhGHjqqfT5cez/Z+e9/sBETXuF89WEmUy3VZ7cmD7v/RQFgzbN9Ni3O88jkPeHc2ZK04+nOCWBijwNggMeTpvNrylrNTZoOJDSGkB3avCljVtthL2ttJvrFsHIz6bd+bXUPTmyC6CPG1RQOnDFQ3/VoGYT4dPcmKBE71FDt6dzKXihGdJR6StYmBcl4gbgLY+XHP30Z6Twve2cmwEtRa0f3ADnj6y9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TmtEBPrk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TmtEBPrk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4q84qq5z2xln
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 17:26:12 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FNKPn31021429;
	Mon, 16 Mar 2026 06:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UXhjmtqVsij/LUlly
	HwnJ+xDPArOzo01zjKtMLmdHTM=; b=TmtEBPrkELM2wP5T5JWeNBxmUUEMi+MPW
	hhSdBqfaSR/7+xlm+6nPhVez+MSpuF6Cl1oYyd85broLV6rL7ULS0xsALxGMosom
	wHnDWSv6C1Wz+CAkw5g7MRydkaLNILQg1lLU98jJ9us/s+cfKu48b5qdwCFVj4N+
	yttXTGz8z7BUteccO2gi7sxCyITUTItZqBpRqT1WhQxR+7Eve8V2NUWNyrrgNQ+i
	gcJ2uqccSXOGu1bDnWpejE/ZDJg21oRP6H91/CG0dqhuTKhDnw/Pr39ejJl5Lu1U
	jzOM+sqEs0jJLza+OVHAuNJMzRHyhSZ9fyRlHsjvjc5RO80y5U/5A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hpdm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G63TxN032346;
	Mon, 16 Mar 2026 06:25:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jkhur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G6PpVx50266528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 06:25:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2670020049;
	Mon, 16 Mar 2026 06:25:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C158920040;
	Mon, 16 Mar 2026 06:25:47 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 06:25:47 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
        naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au,
        sv@linux.ibm.com, nsc@kernel.org
Subject: [RFC PATCH v4 4/6] objtool/powerpc: Skip jump destination analysis and unnanotated intra-function call warnings for --ftr-fixup
Date: Mon, 16 Mar 2026 11:52:35 +0530
Message-ID: <20260316062237.30948-5-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316062237.30948-1-sv@linux.ibm.com>
References: <20260316062237.30948-1-sv@linux.ibm.com>
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
X-Proofpoint-GUID: 27Zq6sbknyaviqxCBAU34fPJbi7vFMzn
X-Proofpoint-ORIG-GUID: XYuYc58Qj3sFI0SeWPiHcHaOl4PIG0UF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NSBTYWx0ZWRfX7r+UEjy4EzJp
 f6pFtZr48Ix+8ttY0vZNm36KKX/ywAi2IBTMsgRx3oWo+WOgDf+pyldzRt5BRYOwhlUXhVsEg4z
 Rev7/gv7NxWC369oIUJPqWeagB8s7l2fYPCWLG2ZNSiShFlougtfYxP2jw++rfK4xs6dZOSPXow
 HE6jg8W7CWCaxwoTT8t39d22dk9yU0UbBRxr8jn6obohmv7rqmsveHPdICSnGHpRTlCJkmR77vJ
 eAxgauVcc6dNNF9gY+KbUMag1L2TqGzAHkpV+loW+2H6aYk0cOYjfzDgV+vONnWKAGRkjEiPVgu
 3pdVE/uWeDaSIBM4JLQqNtSOucQxaaBT0uBiu43Gcn7S2kqkrxMgOXFQQbIbO7qWmL9L5ZKyPq+
 8RW0NjaCjjM77cW9fOigj6rclqscjI45aekLJFNOY5kfplu4DPMZgVB0fugJsmDSc3/3WClRb5m
 VNa8XAmiAPYjO/ZUZPQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b7a274 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=8-sZ6GPjQPUUxCpKAYwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160045

Objtool is throwing unannotated intra-function call warnings
when run on vmlinux with --ftr-fixup option.

One such example:

vmlinux: warning: objtool: .text+0x3d94:
                        unannotated intra-function call

.text + 0x3d94 = c000000000008000 + 3d94 = c0000000000081d4

c0000000000081d4: 45 24 02 48  bl c00000000002a618
<system_reset_exception+0x8>

c00000000002a610 <system_reset_exception>:
c00000000002a610:       0e 01 4c 3c     addis   r2,r12,270
                        c00000000002a610: R_PPC64_REL16_HA    .TOC.
c00000000002a614:       f0 6c 42 38     addi    r2,r2,27888
                        c00000000002a614: R_PPC64_REL16_LO    .TOC.+0x4
c00000000002a618:       a6 02 08 7c     mflr    r0

This is happening because we should be looking for destination
symbols that are at absolute offsets instead of relative offsets.
After fixing dest_off to point to absolute offset, there are still
a lot of these warnings shown.

In the above example, objtool is computing the destination
offset to be c00000000002a618, which points to a completely
different instruction. find_call_destination() is looking for this
offset and failing. Instead, we should be looking for destination
offset c00000000002a610 which points to system_reset_exception
function.

Even after fixing the way destination offset is computed, and
after looking for dest_off - 0x8 in cases where the original offset
is not found, there are still a lot of unannotated intra-function
call warnings generated. This is due to symbols that are not
properly annotated.

So, for now, as a hack to curb these warnings, do not emit
unannotated intra-function call warnings when objtool is run
with --ftr-fixup option.

Skip add_jump_destinations() and suppress intra-function call
errors in --ftr-fixup mode. The feature fixup pass only needs fixup
entry tables, relocation entries from .__ftr_alternates.text, and
elf_write_insn() to patch branch offsets.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/check.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7b95ddb0460d..ba194446df0a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1599,7 +1599,6 @@ static int add_jump_destinations(struct objtool_file *file)
 			    dest_off == func->offset + func->len)
 				continue;
 
-
 			ERROR_INSN(insn, "can't find jump dest instruction at %s",
 				offstr(dest_sec, dest_off));
 			return -1;
@@ -1681,7 +1680,7 @@ static int add_call_destinations(struct objtool_file *file)
 			if (func && func->ignore)
 				continue;
 
-			if (!insn_call_dest(insn)) {
+			if (!insn_call_dest(insn) && !opts.ftr_fixup) {
 				ERROR_INSN(insn, "unannotated intra-function call");
 				return -1;
 			}
@@ -2637,8 +2636,10 @@ static int decode_sections(struct objtool_file *file)
 			return -1;
 	}
 
-	if (add_jump_destinations(file))
-		return -1;
+	if (!opts.ftr_fixup) {
+		if (add_jump_destinations(file))
+			return -1;
+	}
 
 	/*
 	 * Must be before add_call_destination(); it changes INSN_CALL to
-- 
2.43.0


