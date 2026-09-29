Return-Path: <linuxppc-dev+bounces-28472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E706CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:37:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBQG042yz2yvy;
	Tue, 29 Sep 2026 18:37:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790671077;
	cv=none; b=JvYuda73qcGGb6wkVozIiQyuuMYkb6PAaGZpKNJnG90DB7TJJTJvjL8Ph7R6gCusOnyg3+uX6HxaeYkkI3zs95CtWBgQg4KMUK3GjvpKMsZGReGlj6TdsciLNb4Ur7cDM3Is08hbBdJwnW/QChn3JRtzHwXPxh3Nmv5IbjoVkGhYoC02gmr6asYzPXymMBlBY0nucTQNcie6tjqnEMpgkS9yiscB+1ecejwgWUi4u5GBJJDCI6mXRtTOgMV7dqOsfDQUcIoKcLpWlAugCi4JcsvxnPZivfveHxzHpyaW36rDze6jhmO1kDeUDtMyRf9ktwmcQhRaRj+F0VKAlsHjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790671077; c=relaxed/relaxed;
	bh=75/pKo6xYand7SeynGQjnmFZ8M/+z0gL9jIZwS9w8o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiZKyRsQuWq5tuc02kUKfJ1TIbnRUvzpvpC4k9bDnk+wANyGQegsR4ciOMjuClSW2sqEZYbGKBs8EIiRmVZ348rst8T5F5ZeeXzlKlJm3mxBKPI11L7/Qlj7oUNZJReOZ7tuwM6lLlz0WNK1nzNrX6CShVrgNc4AR59KFmkapXDDuIF10JQM27J7yVc5AxsrdifdqfjoG7oa9x2GeU3XX/vedWuXo4V+bseTRdfGKFgWu5uMZVL+9E3Kfj3GByFM23aPkxw4VCiAlj7q5IDoRwxMN6z2cCc5ma61AiA8Q09yOdmVAjqsLmdqJnFy4aMWxuK35/0x8Jl8UqUjf9Y72w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DAe2g2LO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DAe2g2LO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBQF1y3bz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:37:57 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46JRZ3076694;
	Tue, 29 Sep 2026 05:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=75/pKo6xYand7Seyn
	GQjnmFZ8M/+z0gL9jIZwS9w8o8=; b=DAe2g2LO90O3EfSwuElNr5l5AG0ODu0bu
	yYoOn1Wc4bTJDHslwYvHX80MdTIJ35jDUphl1exKHRcF3ng8gFxbAPOluz5w38/p
	Z3293JDRIOgqzJGSfrjtwi2vkXAL2pdOr1rSnB00ruNn5/wDXBatXFQQLlRZgft3
	33Biwk0syjN4ItRuf8mtnh31sipjh00wRlal1LRkLoVngC5if71G+gyBrSHQ985X
	VvQ4FH9ADPJ9LEJFR7c96dmD778zsP3gEAF+hkOI3F3busBUUitZrI7R7Yw1v0Pp
	9O6tTPc8iYCtEetmp1KDlf3K91HImVw2raMV9HvZxN2zwkeWRDEvg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j55gtn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HoqG1184427;
	Tue, 29 Sep 2026 05:52:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcprk6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5qIux41615632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:52:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E75020040;
	Tue, 29 Sep 2026 05:52:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E6820043;
	Tue, 29 Sep 2026 05:52:11 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 05:52:11 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: sv@linux.ibm.com, alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
        aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
        chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
        jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
        lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
        mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
        nsc@kernel.org, ojeda@kernel.org, peterz@infradead.org,
        pmladek@suse.com, rostedt@goodmis.org, tamird@kernel.org,
        thomas.weissschuh@linutronix.de, thuth@redhat.com,
        yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v2 4/6] objtool/powerpc: Skip jump destination analysis and unnanotated intra-function call warnings for --ftr-fixup
Date: Tue, 29 Sep 2026 11:21:35 +0530
Message-ID: <20260929055138.43489-5-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929055138.43489-1-shivangu@linux.ibm.com>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX1/gILb/diiHy
 4SXRGQ+R9QRVjbToFt0ENApXt/JpQrtBu3UxXRzLUbQM/4XqqFlec5Rn8ILBnycQz2uWr8ueGEV
 zdtyWJa7WGfGl5lj8ToR3Ugrulq/CNs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfXw+J1BT69sSku
 aHNn+FeZNzu7Yoxt98IpOMXGhYzmH/n/EExFns7TLSvlKLR7Tnf8QauWrU8Pl7PVMzqftom1EGT
 xPuyE8JAQq5M4KF/QQpL/PlraCMJA+c+51HWsjmN8/3MYA3ns08HjL1/AmkWHfI8n2VZk5v6N1u
 VIqKgzwv3OxcjjT8d9saaTPSehonXuAnxUAMKB1fQJj+4da/etR6q5qTMeuzV9SFNmjrjev4/21
 jnbsmPpaYZEBL0WsFB4u1qCqjpHGT66yfXJOrDaWB4zMu+bAqdQh99oNl1i6ONcTyo19/9B0f+Q
 MHQ4hUiG8ceaLynrieczKaYtqpi+3rnuO5IuIUmCxx0Y0vBz4bzniI78WuSe5DPOqEGfjAxrrLr
 rC3e6e3wP7hfhiMzNuCUIY96rvXNS+0g0Bt5L4JeuEEAYHlhj2Dn9wlT2K51X3EVM5ldjnakOHW
 t8Qri/NWMzj77ns6uEQ==
X-Proofpoint-GUID: f1cjXlibpTbm55jfupOj5MUhYrtiTmk7
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abb521b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=8-sZ6GPjQPUUxCpKAYwA:9
X-Proofpoint-ORIG-GUID: W7a1XGeK9CrjaXn8w6flBKb0MLY1UYtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290022

From: Sathvika Vasireddy <sv@linux.ibm.com>

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
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tools/objtool/check.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7662e990cb13..907dbc8f9b71 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1693,8 +1693,11 @@ static int add_call_destinations(struct objtool_file *file)
 				continue;
 
 			if (!insn_call_dest(insn)) {
-				ERROR_INSN(insn, "unannotated intra-function call");
-				return -1;
+				if (!opts.ftr_fixup) {
+					ERROR_INSN(insn, "unannotated intra-function call");
+					return -1;
+				}
+				continue;
 			}
 
 			if (func && !is_func_sym(insn_call_dest(insn))) {
@@ -2661,8 +2664,10 @@ int decode_file(struct objtool_file *file)
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
2.54.0


