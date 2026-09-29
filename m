Return-Path: <linuxppc-dev+bounces-28451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570EBC9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:18:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv8fK0F2Xz30Pp;
	Tue, 29 Sep 2026 17:18:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790666296;
	cv=none; b=g01yCCZWpOEoXnVu7qo68XCRpdTyJMNUgOJD+X2sy/ODr7ZM0hsAcT5zVrFJVqVEvoql/7TkYOkCwVUhv3lN5mYFU3WDLPZhUR9NHREKJVVmfwRgfY4DyiopLUtRb+Zp1wRzJ2ReAHlk9GewbIhgY1qm83gmOzuomI1t2/yLJF1nmrIQvZLdMBaJ4HnAyNnYsMTIvmP30Sbt/nqnamygeB6w+SeEkbv9r1Y1LTAkjBt9f+VAbtJFNFuHUMCwDQBGTGDXoV6FomIK3GTltNLhT+E43VfAU/fT6LhZod4EhvdG+zUucxDSpNfZF2Tooq97C0U1/+syiuDJIRw3qvV+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790666296; c=relaxed/relaxed;
	bh=P987f/yZghlhn2ST0DlRSIwmMcf2TOfcVXIj1HTBByc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCTiHYiYjcYTCCJbTAB4AuvxqSZs4WQVKPpO/Az1IckbCp/bfe6r6odtDpUO2rkVUE20KNmx5KSkR7iTG1Jf4jGhQAheotf/Y0JZlOXenCgToLViB/iN3msRGmK3WVyUBFLHtkCs4x8lIy9287XaocoQO/RZlP8B6JJf0XanjNKa0S3A5jbu4PriQA219T+Mf71ajNR/gX/h81j3pJimhP5HVBjR0rjPyv2tC5n/E/l+taT+6pP21RPwsxQdsEE43ccvwN6IyQ0oNCNqjgUjvfKrHM+VeAA1J+OEMOlq6TYU1Bo14szQ63G+rVCahvBc/jNuKlwt7j/MvHVChh5baA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ftJVfGfC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ftJVfGfC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv8fJ1ZBjz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:18:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46M793038796;
	Tue, 29 Sep 2026 05:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P987f/yZghlhn2ST0
	DlRSIwmMcf2TOfcVXIj1HTBByc=; b=ftJVfGfCQso8fjBcaIjBCI2kUjuUzbauk
	S1HnpWjW949/iRN/M2k4OiH/4aAfT42W+RuYYYkjgVRzwpBsWMjhibDIa286J2hY
	gfa2/oiDmpo4WekCgPryD2GxIsshBtkqaJ5SkQcIPV0QFsbrrNITomtQNyI7K0yo
	pbJeQYbEYdaFgMqPlMDX5QZsRV0zWRdHTzZ+Pwr9v+4BDEvlcU7xUfO6cSzjfJ1e
	4LhQMVxeX1iHlTSn89R3t3JUfxXHkZnOI8U2J86XqhiC4u4qexXRlonJufUUzJsJ
	yWZgj0tCfH0S3t6wJkxBLJNY1EbBrFt0kHpth95zGdneh6gOyb2pA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt4qds-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HU0U1134104;
	Tue, 29 Sep 2026 05:52:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck8d8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5qBLA40239580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:52:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E402D20043;
	Tue, 29 Sep 2026 05:52:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D43F92004D;
	Tue, 29 Sep 2026 05:52:03 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 05:52:03 +0000 (GMT)
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
Subject: [PATCH v2 3/6] objtool: Fix "can't find starting instruction" warnings on vmlinux
Date: Tue, 29 Sep 2026 11:21:34 +0530
Message-ID: <20260929055138.43489-4-shivangu@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: dtNBs1tTRsTlifrsy0KA5NR2oD89gKo5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX0vNK6LsN4jFK
 gX0rH2gqCDP+Nb2HO/+cfDbuoZV4qzp1pdanmCAR1w/1PbNuKKnQnkTxuVseTLGRpLQdgnrxsYM
 wjcEaH3mBanO0m7G42kn+y6W4WpX9bw1PiQDtBW+2bber9ARqe1G4NHYbCAVAViyLtptqoVu236
 3DGgICdtRDCJbBwsttwgNo46SmpIeXivC2xZYjHFBulueLbJ04ER5f/aY1ktV4yF7haFIYSfTQc
 5MYMFeJbv+D33zSwHHXz5mpXqHrunK3tUP7paIapTh02h2y/NysT4lx+Bo5IFecXhCrfCrcr88Y
 pF7TEsxSgMt3Mmkoo+QEWbCLSk7gkB5JhwjRWmo/sRoR8N7GV+M9oNfbo34VDiAye7RoLOXEOjs
 lC3mfQaVOX/PMFT6U31t60/pdIb/vDRjwmId5gru6Sjg6GFA10noRoSrRYFvwvcKiFeUempMe6f
 0E2RQ27Nf6Lg7V8W3ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX/76DjdaUfFeS
 8mH3qN/2rYeo/Hoqpi0TWfs7BFh0r7UWHL3YqrL45CtRI75dXFdGgxCq00ayxF861GfrBcx1Tyi
 ccu+P7LROV7WBJnR3QYKQn7+Wt6MFKg=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abb5211 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=kT97ooqaMeLRiaEWO4oA:9
X-Proofpoint-GUID: oba_ClxiN0h4fp6kZfESTnXqWi5qydMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290022

From: Sathvika Vasireddy <sv@linux.ibm.com>

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
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tools/objtool/check.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2e875ac9175e..7662e990cb13 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -411,7 +411,7 @@ static int decode_instructions(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
-	unsigned long offset;
+	unsigned long offset, func_off;
 	struct instruction *insn;
 
 	for_each_sec(file->elf, sec) {
@@ -493,17 +493,26 @@ static int decode_instructions(struct objtool_file *file)
 			if (func->embedded_insn || is_alias_sym(func))
 				continue;
 
-			if (!find_insn(file, sec, func->offset)) {
+			if (func->len == 0 && is_notype_sym(func))
+				continue;
+
+			func_off = opts.ftr_fixup ?
+				func->offset - sec->sh.sh_addr : func->offset;
+
+			if (!find_insn(file, sec, func_off)) {
 				ERROR("%s(): can't find starting instruction", func->name);
 				return -1;
 			}
 
-			sym_for_each_insn(file, func, insn) {
+			for (insn = find_insn(file, sec, func_off);
+				insn && insn->offset < func_off + func->len;
+				insn = next_insn_same_sec(file, insn)) {
 				insn->_sym = func;
+
 				if (is_func_sym(func) &&
 				    insn->type == INSN_ENDBR &&
 				    list_empty(&insn->call_node)) {
-					if (insn->offset == func->offset) {
+					if (insn->offset == func_off) {
 						list_add_tail(&insn->call_node, &file->endbr_list);
 						file->nr_endbr++;
 					} else {
-- 
2.54.0


