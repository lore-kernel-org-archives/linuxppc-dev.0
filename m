Return-Path: <linuxppc-dev+bounces-18213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29414F3028C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4q74sjtz2ynC;
	Mon, 16 Mar 2026 17:26:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773642371;
	cv=none; b=lN5+HGWmMwPP5ambQV5nr4v5VG1aTsO8eWtapAG+7EmtYvCf3Wl5/rfngo1zNDbGScNyLy1OQdpc0cpIxwHVd7W9PeyDmYSJzdavKKStH9yzJCQhabVeymxvgpdw69mx/UvCuwIRqJHfvcfReJXJvMCQuIXlolaiTqcQZkgjwnQAaPNizHs7/JnMja+mMl7cAoWbGw02lqfwHqV6gy683aMENcPvLhGQntwFiVbTgbCIq0acHBG3+USWcWipcEMHymzsxpPEoMk2AloPDiYdES+mshWh+YVeJ9lqYWn97qS2EUfiNRxEzVerkD96eNPITXpMVQleK9ru024P9FBScg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773642371; c=relaxed/relaxed;
	bh=dlhqMPK7aYKEVPJdgPwwAnPB6R5T7newl+APg3UuQtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3cUbfdhdZ9CjZdY9OLw+FNQ1/cxSWpgiJxJ3qCmE2mZ3cg73g8bpRdBPA7/++9u/+MmR1Ts2KwVwlCOYOlNWrTElFx+ZkiePAcfJMkqA/OUnCUMLvMt43pe2CAyRhySP+3UW30So28QQp921TBmEDp4BI3jTbZSAceBF6mwqAl808Nt4NDqZvSi2UWN29KmiB5BQj+kv+qdYe2pTKrAnJZm2X1SAaEE1V3sllz9o7toD0Hs0qiJFAGubUHf74ibcIX/dXOqW1iD4ruP+jcQ2msYyiMUoqvhxIFMsfuFO7zhYQl1sAUZYVFn4AluptEUo7ScAdUdrKSgzESPNQnwQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ddV/85Is; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ddV/85Is;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4q65q9Yz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 17:26:10 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FLo1iO871453;
	Mon, 16 Mar 2026 06:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dlhqMPK7aYKEVPJdg
	PwwAnPB6R5T7newl+APg3UuQtI=; b=ddV/85IsF0EeHgRDIO5zYBDSDe+Op/aUa
	FplQR4cRznrw6k4sXxqJn9+PAMpWY0EsCf+Xr0zu/be8YfTWbT9U5JWXneld32sP
	FTpW+osUQx9XsaV6R2sMV3v5nQltpkRZ+gmumf6aKt+M1vPynhYDKArrFMS56Aom
	rlkBcBwldNygyilzt/voJfr9FyDO0OIe2ZF0NIextV/jWTL4XxNKkT6RrZ0yzVVz
	+PrjSm2QkDLV63PR6GbHfR5C5iyuJQAziQhigBeKpqnl4gpXEc6Pzes13RzqOc+j
	Xovs0PJRAKkfhNrlB2c4lJ2srnux+ldAES6CzQ0taoRMsF2tgv7JA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau65h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G0Rhgx032448;
	Mon, 16 Mar 2026 06:25:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jkhum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G6Pllj15401378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 06:25:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA83A2004B;
	Mon, 16 Mar 2026 06:25:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF06D20049;
	Mon, 16 Mar 2026 06:25:43 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 06:25:43 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
        naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au,
        sv@linux.ibm.com, nsc@kernel.org
Subject: [RFC PATCH v4 3/6] objtool: Fix "can't find starting instruction" warnings on vmlinux
Date: Mon, 16 Mar 2026 11:52:34 +0530
Message-ID: <20260316062237.30948-4-sv@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NSBTYWx0ZWRfX92OXVDeXWdkI
 Ru5THtvM6SwRJdQkYm6mXJ4vjgN4es181q9EATkRkGScFxjOHUtpeytie8tUQ30SQUjSCuYgNSy
 Ai6uPxConFeL/T5i9Gyub1YG3ujL3wf42oVw5c4Hg8xlRU9JvuyrFozofLjX8QLPcOD6F2gjnwK
 3o/hLGFI0T/CjVsSmL8lYfqeZGMDkP3G3tP/Wngl9qTXxehvx8Q/Zl64D+n0F9UmCliP2qZqgQY
 /PR7nMqKBQwkwMoNrT7nHUtbtlgCEQmiWNn56jgpFdOO/K7zmlp/6e5Vv/TLtY50HMWs0EoaAFc
 lValfXBel3+wGc4Wk71vt3STykaJs3LfN93t7SojSZjfHnyoVPZg1UUFy/Owflw0/wxIOh3p3fK
 lLH+/V1XQnxCCeVfrnS2wq/TWDwIQqb9GCyVtb/i4bj7EnhYc4cGmmU/0x9RMCXb/2s47k6j8VK
 yRR5cvM9dSIz62CYQlQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b7a270 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=7w6QjbFeSYXBFb6lQ1YA:9
X-Proofpoint-ORIG-GUID: _omZ2hr6mH-Pa4AeSg8FhFsukBCioCIN
X-Proofpoint-GUID: Xv0nLPkoBUC3XF6KcMVCt4deZm6BT6oN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160045

Objtool throws a lot of can't find starting instruction warnings
when run on vmlinux with --ftr-fixup option.

These warnings are seen because find_insn() function looks for
instructions at offsets that are relative to the start of the section.
In case of individual object files (.o), there are no can't find
starting instruction warnings seen because the actual offset
associated with an instruction is itself a relative offset since the
sections start at offset 0x0.

However, in case of vmlinux, find_insn() function fails to find
instructions at the actual offset associated with an instruction
since the sections in vmlinux do not start at offset 0x0. Due to
this, find_insn() will look for absolute offset and not the relative
offset. This is resulting in a lot of can't find starting instruction
warnings when objtool is run on vmlinux.

To fix this, pass offset that is relative to the start of the section
to find_insn().

find_insn() is also looking for symbols of size 0. But, objtool does
not store empty STT_NOTYPE symbols in the rbtree. Due to this,
for empty symbols, objtool is throwing can't find starting
instruction warnings. Fix this by ignoring symbols that are of
size 0 since objtool does not add them to the rbtree.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/check.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b8b9cb6005d7..7b95ddb0460d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -493,7 +493,11 @@ static int decode_instructions(struct objtool_file *file)
 			if (func->embedded_insn || func->alias != func)
 				continue;
 
-			if (!find_insn(file, sec, func->offset)) {
+			if (func->len == 0)
+				continue;
+
+			if (!find_insn(file, sec, opts.ftr_fixup ?
+					func->offset - sec->sym->offset : func->offset)) {
 				ERROR("%s(): can't find starting instruction", func->name);
 				return -1;
 			}
-- 
2.43.0


