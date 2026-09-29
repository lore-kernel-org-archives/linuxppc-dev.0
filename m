Return-Path: <linuxppc-dev+bounces-28455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4402CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv8vS13mTz30Pp;
	Tue, 29 Sep 2026 17:29:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790666980;
	cv=none; b=dCMfse4KCK0LMGwk/cxM+HdS5atth5P0sMzIOSNHicpSkP3NzWgfcFoAmJIpkzjt6+MuDmBTq93XRIAJ9pnsfH/5aO3e49SqWA856FttQsl9nSKk+GOKzSVdsnOodyeKKhwwt62FIXBDvE7ikClIwVBWWqjSHdf4Vs4Q3T9pMVpfYiXWt/u5Wx3EaRMnwhLUbjjFwjZsjC+qQgeCdmrSXcBjb5yXZL3yg9ODspDrRvq++gIXd23rG2udZZKgqaTZbN241vNNfFOFIJryA0AUzKP1shJCHOKs1AZsor53vk5jxn5AvKehXEtIf4ji/62pv3VpEdITs11db+rq4KSn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790666980; c=relaxed/relaxed;
	bh=FEIe9Tfk/moEt3vfkZMqPWqchFf7zn8NPFhWo/n4c90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNvJ6hrns808+FBIdClbgDwnV85jNm/oMlnt8ed7cKr9ZT5XXSyyCB+yEuBCLSBd/Us3+4A6ozyvc5q+SknwfV29LaM8bfF4nxUkFmhrex7yO7yvMgFmvhse7DiQQ0mpetATZ5AcYRFTb+TXbntU4AZOb0iRIrCYqgUIv6r6PFsMUMdR57E5guapMBoKkmC/1G1tQNVUteFX0y/IdlrGza3bLKX2WD4kEqhsEHYWIvPQTPTmwBOjj/H7zUo7BhLkmPEDFbFc5f54tK8VMueyV8cTB7BYKNLJqNmYjN7t16iayTqs7w9sJzsLIXs3mTL7LkT5EaL1EPeaa2JVtR49/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FeQMqGwi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FeQMqGwi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv8vR0wRMz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:29:38 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46GdY3047357;
	Tue, 29 Sep 2026 05:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FEIe9Tfk/moEt3vfk
	ZMqPWqchFf7zn8NPFhWo/n4c90=; b=FeQMqGwiUp+g0RbOMlXsJhbRYnZ04bHvP
	fmEoKcn8DntRuN2HNpEF+Y+vMYCzFvauBmG3yvfWfwETmXoUYGQTS64J9KqVQxZO
	SSL2jBwigyRGV0wiExmWm62x8uLx8ZFCzjm2nVML4WYtQ47XEk8VchXLiC7mkUZF
	p0xwQv+6bbRh5lga8xXKzHPpmK5jBdDD2XUt/dT+33f/peYejbL17KOcQ/8EdOz5
	Mcgc/HihQLw9V8Pgn+B50IO6yIDYNYxIAzl3ayIGDcvlRga1MZnOma1h3ojNXG67
	qUu4J8xwB2VGuyDjhXxszJ+iYkAjvoAbg9uZt+YKuPLJC2IXxN1Zw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s55d3a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HTNO1184297;
	Tue, 29 Sep 2026 05:52:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcprk5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5puhe15073770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:51:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B84720043;
	Tue, 29 Sep 2026 05:51:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48FDE20040;
	Tue, 29 Sep 2026 05:51:49 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 05:51:49 +0000 (GMT)
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
Subject: [PATCH v2 1/6] objtool/powerpc: Add build-time fixup of alternate feature branch targets
Date: Tue, 29 Sep 2026 11:21:32 +0530
Message-ID: <20260929055138.43489-2-shivangu@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX/uXiklNipcqY
 Dyivw4ijAA2LdR1Zi+MvagtshaYVbXtOhbEgTVzsn3nk9MbRakDr3ACCfrkyFcKfiZoDiar9zZe
 UnV0yKiSFtgAFTDEBPx79Y1eGGOKArU=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abb5203 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=5klgpdlFSnDGvnxfnF4A:9
X-Proofpoint-GUID: zgmgGn7RseiaRubPD4gj09S4r00rpfc8
X-Proofpoint-ORIG-GUID: gz7NLti4935NIStU2O-9idFz0ASOtU56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX79U0VQu7wev/
 jezPfaJRC4jGSH6ybTDy19oen3/64kRZVWPhiZolN4RgqaYgv5YcN2P/e14c8EQRjEpPoH8C9Zf
 o79OymZJV3dXp41167pAwUKMvI/3Hbge4uQX1OQLmELfFWLb1n5yhz9EdhEK4NNzsV/45vsRMHS
 CjdsCw7O82fvB/3WSdHAEChaSHLjnneYEj/usbct5AVmIg3OoDDujfy5BSMaq1TB+XLYwqkwnSU
 GU9MjwSv9SUHwu8FbI6lXAsFtk+qIX4wsqUhM1T+2RNh+HdwLeDsv2n/IZO4aGqCvubmT3XJ4JB
 J1w5aWXXHYB5KmKJtWc2iiUK5d3jcOKEvPuCScB31NqypeZq4pwEdYKdn9W5dN/gzXBArUYeVqf
 shfLVTIgnM8sQo5mwLGHmwHy8FVXvZz4skOer1NtreVn7iWAUzQfsbcJHJMDA7n/V/Eud6vtWi5
 QgGfvccTt8pMjpZEPQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290022

From: Sathvika Vasireddy <sv@linux.ibm.com>

PowerPC __ftr_alt* sections must currently be placed near .text because
they lack the executable attribute, preventing the linker from inserting
stubs. Branches in the alternate code must reach their targets directly.
This can cause build failures as the kernel grows.

Fix this by processing alternate feature relocations at build time with
objtool. Link with --emit-relocs to preserve relocation information,
mark __ftr_alt* sections executable ("ax") so the linker can insert
stubs, then use objtool --ftr-fixup to recompute branch offsets based
on their runtime locations.

objtool already has ELF parsing and instruction patching infrastructure,
so this avoids introducing a separate tool as was originally proposed
[1].

[1]
https://lore.kernel.org/linuxppc-dev/20170521010130.13552-1-npiggin@gmail.com/

Co-developed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tools/objtool/arch/powerpc/decode.c     |  11 +
 tools/objtool/arch/powerpc/special.c    | 451 ++++++++++++++++++++++++
 tools/objtool/builtin-check.c           |   2 +
 tools/objtool/check.c                   |  25 ++
 tools/objtool/include/objtool/builtin.h |   1 +
 tools/objtool/include/objtool/special.h |  56 +++
 tools/objtool/special.c                 |  29 ++
 7 files changed, 575 insertions(+)

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index e534ac1123b3..5fdd142f0a19 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -66,6 +66,17 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	imm = 0;
 
 	switch (opcode) {
+	case 16: /* bc[l][a] : Branch Conditional */
+		if (ins & 1)
+			typ = INSN_OTHER;
+		else
+			typ = INSN_JUMP_CONDITIONAL;
+		imm = ins & 0xfffc;
+		if (imm & 0x8000)
+			imm -= 0x10000;
+		imm |= ins & 2;	/* AA flag */
+		break;
+
 	case 18: /* b[l][a] */
 		if (ins == 0x48000005)	/* bl .+4 */
 			typ = INSN_OTHER;
diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
index 8f9bf61ca089..deb248c63bca 100644
--- a/tools/objtool/arch/powerpc/special.c
+++ b/tools/objtool/arch/powerpc/special.c
@@ -3,7 +3,17 @@
 #include <stdlib.h>
 #include <objtool/special.h>
 #include <objtool/builtin.h>
+#include <objtool/warn.h>
+#include <asm/byteorder.h>
+#include <errno.h>
 
+struct section *ftr_alt;
+
+struct fixup_entry *fes;
+unsigned int nr_fes;
+
+uint64_t fe_alt_start = -1;
+uint64_t fe_alt_end;
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
@@ -23,3 +33,444 @@ const char *arch_cpu_feature_name(int feature_number)
 {
 	return NULL;
 }
+
+
+int process_alt_data(struct objtool_file *file)
+{
+	struct section *section;
+
+	section = find_section_by_name(file->elf, ".__ftr_alternates.text");
+	ftr_alt = section;
+
+	if (!ftr_alt) {
+		if (opts.link)
+			WARN(".__ftr_alternates.text section not found in vmlinux\n");
+		return opts.link ? -1 : 0;
+	}
+
+	fe_alt_start = ftr_alt->sh.sh_addr;
+	fe_alt_end = ftr_alt->sh.sh_addr + ftr_alt->sh.sh_size;
+
+	return 0;
+
+}
+
+static int is_le(struct objtool_file *file)
+{
+	return file->elf->ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
+}
+
+static int is_64bit(struct objtool_file *file)
+{
+	return file->elf->ehdr.e_ident[EI_CLASS] == ELFCLASS64;
+}
+
+static uint32_t f32_to_cpu(struct objtool_file *file, uint32_t val)
+{
+	if (is_le(file))
+		return __le32_to_cpu(val);
+	else
+		return __be32_to_cpu(val);
+}
+
+static uint64_t f64_to_cpu(struct objtool_file *file, uint64_t val)
+{
+	if (is_le(file))
+		return __le64_to_cpu(val);
+	else
+		return __be64_to_cpu(val);
+}
+
+static uint32_t cpu_to_f32(struct objtool_file *file, uint32_t val)
+{
+	if (is_le(file))
+		return __cpu_to_le32(val);
+	else
+		return __cpu_to_be32(val);
+}
+
+int process_fixup_entries(struct objtool_file *file)
+{
+	struct section *sec;
+	int i;
+
+	for_each_sec(file->elf, sec) {
+		Elf_Data *data;
+		unsigned int nr;
+
+		if (strstr(sec->name, "_ftr_fixup") == NULL)
+			continue;
+
+		if (strstr(sec->name, ".rela") != NULL)
+			continue;
+
+		data = sec->data;
+		if (!data || data->d_size == 0)
+			continue;
+
+		if (is_64bit(file))
+			nr = data->d_size / sizeof(struct fixup_entry_64);
+		else
+			nr = data->d_size / sizeof(struct fixup_entry_32);
+
+		for (i = 0; i < nr; i++) {
+			unsigned long idx;
+			unsigned long long off;
+			struct fixup_entry *dst;
+
+			if (is_64bit(file)) {
+				struct fixup_entry_64 *src;
+
+				idx = i * sizeof(struct fixup_entry_64);
+				off = sec->sh.sh_addr + data->d_off + idx;
+				src = data->d_buf + idx;
+
+				if (src->alt_start_off == src->alt_end_off)
+					continue;
+
+				struct fixup_entry *tmp = realloc(fes, (nr_fes + 1)
+					* sizeof(struct fixup_entry));
+
+				if (!tmp) {
+					free(fes);
+					fes = NULL;
+					return -1;
+				}
+				fes = tmp;
+				dst = &fes[nr_fes++];
+
+				dst->mask = f64_to_cpu(file, src->mask);
+				dst->value = f64_to_cpu(file, src->value);
+				dst->start_off = f64_to_cpu(file, src->start_off) + off;
+				dst->end_off = f64_to_cpu(file, src->end_off) + off;
+				dst->alt_start_off = f64_to_cpu(file, src->alt_start_off) + off;
+				dst->alt_end_off = f64_to_cpu(file, src->alt_end_off) + off;
+			} else {
+				struct fixup_entry_32 *src;
+
+				idx = i * sizeof(struct fixup_entry_32);
+				off = sec->sh.sh_addr + data->d_off + idx;
+				src = data->d_buf + idx;
+
+				if (src->alt_start_off == src->alt_end_off)
+					continue;
+
+				struct fixup_entry *tmp = realloc(fes, (nr_fes + 1)
+					* sizeof(struct fixup_entry));
+
+				if (!tmp) {
+					free(fes);
+					fes = NULL;
+					return -1;
+				}
+				fes = tmp;
+				dst = &fes[nr_fes++];
+
+				dst->mask = f32_to_cpu(file, src->mask);
+				dst->value = f32_to_cpu(file, src->value);
+				dst->start_off = (int32_t)f32_to_cpu(file, src->start_off) + off;
+				dst->end_off = (int32_t)f32_to_cpu(file, src->end_off) + off;
+				dst->alt_start_off = (int32_t)f32_to_cpu(file,
+								src->alt_start_off) + off;
+				dst->alt_end_off = (int32_t)f32_to_cpu(file,
+								src->alt_end_off) + off;
+			}
+		}
+	}
+	return 0;
+}
+
+struct fixup_entry *find_fe_altaddr(uint64_t addr)
+{
+	unsigned int i;
+
+	if (addr < fe_alt_start)
+		return NULL;
+	if (addr >= fe_alt_end)
+		return NULL;
+
+	for (i = 0; i < nr_fes; i++) {
+		if (addr >= fes[i].alt_start_off && addr < fes[i].alt_end_off)
+			return &fes[i];
+	}
+	return NULL;
+}
+
+int set_uncond_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target)
+{
+	uint32_t i = *insn;
+	int64_t offset;
+
+	offset = target;
+	if (!(i & BRANCH_ABSOLUTE))
+		offset = offset - addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (offset < -0x2000000 || offset > 0x1fffffc || offset & 0x3)
+		return -EOVERFLOW;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	*insn = 0x48000000 | (i & 0x3) | (offset & 0x03FFFFFC);
+
+	return 0;
+}
+
+int set_cond_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target)
+{
+	uint32_t i = *insn;
+	int64_t offset;
+
+	offset = target;
+
+	if (!(i & BRANCH_ABSOLUTE))
+		offset = offset - addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (offset < -0x8000 || offset > 0x7FFF || offset & 0x3)
+		return -EOVERFLOW;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	*insn = 0x40000000 | (i & 0x3FF0003) | (offset & 0xFFFC);
+
+	return 0;
+}
+
+void check_and_flatten_fixup_entries(void)
+{
+	static struct fixup_entry *fe;
+	unsigned int i;
+
+	for (i = 0; i < nr_fes; i++) {
+		struct fixup_entry *parent;
+		uint64_t nested_off;
+		uint64_t size;
+
+		fe = &fes[i];
+
+		parent = find_fe_altaddr(fe->start_off);
+		if (!parent)
+			continue;
+
+		size = fe->end_off - fe->start_off;
+		nested_off = fe->start_off - parent->alt_start_off;
+
+		fe->start_off = parent->start_off + nested_off;
+		fe->end_off = fe->start_off + size;
+	}
+}
+
+
+static struct symbol *find_symbol_at_address_within_section(struct section *sec,
+				unsigned long address)
+{
+	struct symbol *sym;
+
+	sec_for_each_sym(sec, sym) {
+		if (sym->sym.st_value <= address && address < sym->sym.st_value + sym->len)
+			return sym;
+	}
+
+	return NULL;
+}
+
+static int is_local_symbol(uint8_t st_other)
+{
+	/* STO_PPC64_LOCAL_MASK: bits [7:5] encode the local entry point offset */
+	return (st_other & (7 << 5)) == 0;
+}
+
+static struct symbol *find_symbol_at_address(struct objtool_file *file,
+					unsigned long address)
+{
+	struct section *sec;
+	struct symbol *sym;
+
+	list_for_each_entry(sec, &file->elf->sections, list) {
+		sym = find_symbol_at_address_within_section(sec, address);
+		if (sym)
+			return sym;
+		}
+	return NULL;
+}
+
+int process_alt_relocations(struct objtool_file *file)
+{
+	struct section *section;
+	size_t n = 0;
+	struct reloc *relocation;
+	struct symbol *sym;
+	struct fixup_entry *fe;
+	uint64_t addr;
+	uint64_t scn_delta;
+	uint64_t dst_addr;
+	const char *insn_ptr;
+	unsigned long target;
+	struct symbol *symbol;
+	int is_local;
+	int j;
+	uint32_t new_insn;
+	uint32_t file_insn;
+	struct instruction decoded_insn = {0};
+	uint32_t *insn_ptr_raw;
+	uint32_t insn;
+
+	section = find_section_by_name(file->elf, ".rela.__ftr_alternates.text");
+	if (!section) {
+		printf(".rela.__ftr_alternates.text section not found.\n");
+		return 0;
+	}
+
+	for (j = 0; j < sec_num_entries(section); j++) {
+
+		relocation = &section->relocs[j];
+		sym = relocation->sym;
+
+		addr = reloc_offset(relocation);
+		target = sym->sym.st_value + reloc_addend(relocation);
+		symbol = find_symbol_at_address(file, target);
+
+		if (symbol) {
+			is_local = is_local_symbol(symbol->sym.st_other);
+			if (!is_local)
+				target = target + 0x8;
+		}
+
+		n++;
+		fe = find_fe_altaddr(addr);
+		if (!fe)
+			continue;
+
+		if (target >= fe->alt_start_off && target < fe->alt_end_off)
+			continue;
+
+		if (target >= ftr_alt->sh.sh_addr &&
+			target < ftr_alt->sh.sh_addr + ftr_alt->sh.sh_size)
+			return -1;
+
+		scn_delta = addr - ftr_alt->sh.sh_addr;
+		dst_addr = addr - fe->alt_start_off + fe->start_off;
+
+		if (!ftr_alt->data || !ftr_alt->data->d_buf)
+			continue;
+
+		if (arch_decode_instruction(file, ftr_alt, scn_delta, 4, &decoded_insn) < 0)
+			continue;
+
+		insn_ptr_raw = (uint32_t *)(ftr_alt->data->d_buf + scn_delta);
+
+		insn = f32_to_cpu(file, *insn_ptr_raw);
+		new_insn = insn;
+
+		switch (decoded_insn.type) {
+		case INSN_JUMP_CONDITIONAL:
+			if (set_cond_branch_target(&new_insn, dst_addr, target) != 0)
+				continue;
+			break;
+
+		case INSN_JUMP_UNCONDITIONAL:
+			if (set_uncond_branch_target(&new_insn, dst_addr, target) != 0)
+				continue;
+			break;
+
+		case INSN_CALL:
+			if (set_uncond_branch_target(&new_insn, dst_addr, target) != 0)
+				continue;
+			break;
+		default:
+			continue;
+		}
+
+		if (new_insn == insn)
+			continue;
+
+		file_insn = cpu_to_f32(file, new_insn);
+		insn_ptr = (const char *)&file_insn;
+		elf_write_insn(file->elf, ftr_alt, scn_delta, sizeof(file_insn), insn_ptr);
+	}
+	return 0;
+}
+
+int process_exception_entries(struct objtool_file *file)
+{
+	struct section *section;
+	Elf_Data *data;
+	unsigned int nr, i;
+
+	section = find_section_by_name(file->elf, "__ex_table");
+	if (!section) {
+		printf("__ex_table section not found\n");
+		return 0;
+	}
+
+	data = section->data;
+	if (!data || data->d_size == 0)
+		return 0;
+
+	nr = data->d_size / sizeof(struct exception_entry);
+
+	for (i = 0; i < nr; i++) {
+		struct exception_entry *ex;
+		unsigned long idx;
+		uint64_t exaddr;
+		unsigned long long off;
+
+		idx = i * sizeof(struct exception_entry);
+		off = section->sh.sh_addr + data->d_off + idx;
+		ex = data->d_buf + idx;
+
+		exaddr = off + (int32_t)f32_to_cpu(file, ex->insn);
+
+		if (exaddr < fe_alt_start)
+			continue;
+		if (exaddr >= fe_alt_end)
+			continue;
+
+		return -1;
+	}
+	return 0;
+}
+
+int process_bug_entries(struct objtool_file *file)
+{
+	struct section *section;
+	Elf_Data *data;
+	unsigned int nr, i;
+
+	section = find_section_by_name(file->elf, "__bug_table");
+	if (!section) {
+		printf("__bug_table section not found\n");
+		return 0;
+	}
+
+	data = section->data;
+	if (!data || data->d_size == 0)
+		return 0;
+
+	if (data->d_size % sizeof(struct bug_entry) != 0)
+		return -1;
+
+	nr = data->d_size / sizeof(struct bug_entry);
+	for (i = 0; i < nr; i++) {
+		struct bug_entry *bug;
+		unsigned long idx;
+		uint64_t entry_addr;
+		uint64_t bugaddr;
+		int32_t bug_disp;
+
+		idx = i * sizeof(struct bug_entry);
+		entry_addr = section->sh.sh_addr + data->d_off + idx;
+		bug = (struct bug_entry *)(data->d_buf + idx);
+		bug_disp = f32_to_cpu(file, bug->bug_addr_disp);
+		bugaddr = entry_addr + bug_disp;
+
+		if (bugaddr < fe_alt_start)
+			continue;
+		if (bugaddr >= fe_alt_end)
+			continue;
+
+		return -1;
+	}
+	return 0;
+}
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 75b11dc85010..ed7fdd82d997 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -77,6 +77,7 @@ static const struct option check_options[] = {
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i',	 "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN(0,		 "klp-symids", &opts.klp_symids, "generate .klp.symids for duplicate symbol disambiguation"),
+	OPT_BOOLEAN('f',	 "ftr-fixup", &opts.ftr_fixup, "feature fixup"),
 	OPT_BOOLEAN('m',	 "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN(0,		 "noabs", &opts.noabs, "reject absolute references in allocatable sections"),
 	OPT_BOOLEAN('n',	 "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -183,6 +184,7 @@ static bool opts_valid(void)
 	if (opts.disas			||
 	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
+	    opts.ftr_fixup		||
 	    opts.ibt			||
 	    opts.klp_symids		||
 	    opts.mcount			||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f6c9d9ff0..2e875ac9175e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4840,6 +4840,31 @@ int check(struct objtool_file *file)
 	if (!nr_insns)
 		goto out;
 
+	if (opts.ftr_fixup) {
+		ret = process_alt_data(file);
+		if (ret < 0)
+			return ret;
+
+		ret = process_fixup_entries(file);
+		if (ret < 0)
+			return ret;
+
+		check_and_flatten_fixup_entries();
+
+		ret = process_exception_entries(file);
+		if (ret < 0)
+			return ret;
+
+		ret = process_bug_entries(file);
+		if (ret < 0)
+			return ret;
+
+		ret = process_alt_relocations(file);
+		if (ret < 0)
+			return ret;
+	}
+
+
 	if (opts.retpoline)
 		warnings += validate_retpoline(file);
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 349690bb1c50..159255cecc27 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -13,6 +13,7 @@ struct opts {
 	const char *disas;
 	bool dump_orc;
 	bool hack_jump_label;
+	bool ftr_fixup;
 	bool hack_noinstr;
 	bool hack_skylake;
 	bool ibt;
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 620dbf6cb0e5..eccf71e09fc3 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -12,6 +12,41 @@
 
 #define C_JUMP_TABLE_SECTION ".data.rel.ro.c_jump_table"
 
+#define BRANCH_SET_LINK 0x1
+#define BRANCH_ABSOLUTE 0x2
+
+struct bug_entry {
+	int32_t  bug_addr_disp;
+	int32_t  file_disp;
+	uint16_t line;
+	uint16_t flags;
+};
+
+struct exception_entry {
+	int32_t insn;
+	int32_t fixup;
+};
+
+struct fixup_entry_64 {
+	uint64_t mask;
+	uint64_t value;
+	uint64_t start_off;
+	uint64_t end_off;
+	uint64_t alt_start_off;
+	uint64_t alt_end_off;
+};
+
+#define fixup_entry fixup_entry_64
+
+struct fixup_entry_32 {
+	uint32_t mask;
+	uint32_t value;
+	uint32_t start_off;
+	uint32_t end_off;
+	uint32_t alt_start_off;
+	uint32_t alt_end_off;
+};
+
 struct special_alt {
 	struct list_head list;
 
@@ -28,6 +63,8 @@ struct special_alt {
 	unsigned int orig_len, new_len, feature; /* group only */
 };
 
+int process_alt_data(struct objtool_file *file);
+
 int special_get_alts(struct elf *elf, struct list_head *alts);
 
 void arch_handle_alternative(struct special_alt *alt);
@@ -47,4 +84,23 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     unsigned long *table_size);
 const char *arch_cpu_feature_name(int feature_number);
 
+int process_fixup_entries(struct objtool_file *file);
+
+void check_and_flatten_fixup_entries(void);
+
+int process_exception_entries(struct objtool_file *file);
+
+int process_bug_entries(struct objtool_file *file);
+
+int process_alt_relocations(struct objtool_file *file);
+
+struct fixup_entry *find_fe_altaddr(uint64_t addr);
+
+int set_uncond_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target);
+
+int set_cond_branch_target(uint32_t *insn,
+		const uint64_t addr, uint64_t target);
+
+
 #endif /* _SPECIAL_H */
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 2a533afbc69a..43b60bf789dd 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -167,3 +167,32 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 
 	return 0;
 }
+
+int __weak process_alt_data(struct objtool_file *file)
+{
+	return 0;
+}
+
+int __weak process_fixup_entries(struct objtool_file *file)
+{
+	return 0;
+}
+
+void __weak check_and_flatten_fixup_entries(void)
+{
+}
+
+int __weak process_exception_entries(struct objtool_file *file)
+{
+	return 0;
+}
+
+int __weak process_bug_entries(struct objtool_file *file)
+{
+	return 0;
+}
+
+int __weak process_alt_relocations(struct objtool_file *file)
+{
+	return 0;
+}
-- 
2.54.0


