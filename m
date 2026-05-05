Return-Path: <linuxppc-dev+bounces-20452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5BBFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:47:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8sbT3m1fz2xGc;
	Tue, 05 May 2026 18:47:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777970869;
	cv=none; b=Y5uXUoUtJ11oNT2+ahAputmHoY+ZrBa3xcAm4WeL9Kd2LJWQN7m6vmRUoWuWd6riTelC+vmd+NmOEScPsy32aCmPstR1FQbDyBvLnOrbbLQoTSuUWDWBPUU4Xh1jc/f34iA4imqgrRieMdI/cfhfjcPjiSEgTb9Gdy77Jge5Ky9EnZhAb5xT/9Ss4Gj2zMiMuJ2nuY86iiBQq/wuthBwGmrApK6Db5hc2gYtIqRPqkTOaOGSh8v+mbgVpLOQu1lWomKs06dxqv7SLJMiENEKXyZLbbVsf0gGLUH2QhiUFYzRUtNzWOWLR+Dfr5CAuAIGuMKsNj3iZ2Uu4Y3Pj1AkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777970869; c=relaxed/relaxed;
	bh=e5ifK/It/v+dYOWMpDHgwdUgvz/hsigtd85AqACBUto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtNGirqpl36loBn2nNbwFjkw7ZjjaLPgUJO1R9xPb93uCD8NO3cnVV8pyR2qdLXH4euefYEkk1nfhF43IMIVHbe8kjbfBB6voo3evXS5BkWkpyoAufz+v0ansLUALcmscd3ACjQdJXQYY/23DySzYWka+1o5cZASIhI//sQkHjjy6hYGQZatT3PeETqaZ3Ash4tHtjUoCLeobjmSXIfs4RJO7HYPJjzGx/YVyLTz6Wi37U7Dr4+67m247np708zzuU1f3eh8vfqty+arU2fUHgAPSUYz0j+/TUeClPqQh73glszBo4PxmgI1aE7rUHHTM7o0D8XB3e7r8mDeoML1rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mOjQRGVk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mOjQRGVk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8sbS0CZ0z3bQl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:47:47 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6450eohI2062528;
	Tue, 5 May 2026 08:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e5ifK/It/v+dYOWMp
	DHgwdUgvz/hsigtd85AqACBUto=; b=mOjQRGVkLc/5AbA34NliUi38SQpjCHW0z
	tL5vC9aHszMe1R/OlSpPEw+vZ5JH/8sYLVuBLRLmCgU49uaEttd4gqzGW/tc5pr+
	BG4DfIAEHRLsNdI66Kw7j4telybVpcv7m1awENPQLHcPQ0lp9LrNxRv1KkTEgche
	UAOAl2piaAChj655RY79R22OY32kk6qv1XwsKRyl61wChVA70aYoeZ8Q86B7l1zf
	Pa3OHiZfY39GTQxk5haEuM3wGsl7XwL0MgqlGILCa0sYnI5Dk9RMGdEXsyfJUbKI
	qCnHXaMByc8MBDpkD4GAVNA++Op2JxAYG7fCtA3NUM02DBR0GLUsA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6af7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:47:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6458dSZL001389;
	Tue, 5 May 2026 08:47:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq8xuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:47:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6458lLGe52625714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 08:47:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B34320043;
	Tue,  5 May 2026 08:47:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A6A92004E;
	Tue,  5 May 2026 08:47:15 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 08:47:15 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: nathan@kernel.org, nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, ojeda@kernel.org, masahiroy@kernel.org,
        lossin@kernel.org, tamird@kernel.org, thomas.weissschuh@linutronix.de,
        rostedt@goodmis.org, ihor.solodrai@linux.dev, thuth@redhat.com,
        pmladek@suse.com, aliceryhl@google.com, elver@google.com,
        kees@kernel.org, legion@kernel.org, ardb@kernel.org,
        yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
        alexandre.chartre@oracle.com, bp@alien8.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com
Subject: [PATCH v1 6/6] powerpc: Enable build-time feature fixup processing by default
Date: Tue,  5 May 2026 14:16:28 +0530
Message-ID: <20260505084628.17940-7-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260505084628.17940-1-sv@linux.ibm.com>
References: <20260505084628.17940-1-sv@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9ae9e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=CCpqsmhAAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=-G-hYi3DffSlC2uomIIA:9 a=O8hF6Hzn-FEA:10 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-ORIG-GUID: DlNH4ux-SCL4XmeyOW_AaBaIfUfhvfa-
X-Proofpoint-GUID: yfRL53VgHSJeULy5jQR2p1q42CQHfQSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3OSBTYWx0ZWRfX24wF2iXUa6nD
 wd1MYPRLKPFTFTYBKhinAzT9rWpFDQhfZkPcLZSnefk6s1DcWxOKuN/jkLbIP/FoOg/9V9/Jf//
 sVy5TsZq1P+jxkAiLjl3YZdqk6DUH2dtKD47xPjVKikzD6u5RQd+khEUnAgcXgHPBsvuRereWZf
 b+a3dGUUXmopM+XUJ5Z+QyyALrG7goT2hJXQhfaksnoe3uXwZyxrLkfBedciIlH4dwLcUby4XZ3
 YT2bHmGM5hLntvdRvtx9AntyVkvG5SBz+Iv8ghHKHFIEzjAC1cxN/W5JCNijEhmmp48Gw8nYXHS
 iNxoM8OGc+ErGa0Bsujv29h/MfknodupT0YjVz68UuG2VmtH+PVzf/BjWDFOvEn5q8R0OMG0puV
 FHfGvdNOcCIUgzpUrFUuLK7YXFualnOCLy4i/un7rdJTbKcMwAheFqjKP3hjpdk1mgw9HAlR2xV
 h6NtaYoLy3ULpjeHOJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050079

Enable HAVE_OBJTOOL_FTR_FIXUP by default on PowerPC architecture.

- Remove runtime branch translation logic from patch_alt_instruction()
- Add --emit-relocs linker flags for post-link fixup processing
- Update ftr_alt section attributes to include executable flag
- Strip the --emit-relocs relocation sections (.rel*) from the final
  vmlinux after processing

Co-developed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/Kconfig                      |  3 +++
 arch/powerpc/Makefile                     |  5 +++++
 arch/powerpc/include/asm/feature-fixups.h |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S         |  8 ++++++--
 arch/powerpc/lib/feature-fixups.c         | 12 ------------
 scripts/Makefile.vmlinux                  |  8 ++++++--
 6 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10240cb80904..6cc10927730d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -23,6 +23,9 @@ config 64BIT
 	bool
 	default y if PPC64
 
+config HAVE_OBJTOOL_FTR_FIXUP
+        def_bool y
+
 config LIVEPATCH_64
 	def_bool PPC64
 	depends on LIVEPATCH
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..8e1dab5f3c9a 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -105,6 +105,11 @@ LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie --no-dynamic-linker
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 
+# --emit-relocs required for post-link fixup of alternate feature
+# text section relocations.
+LDFLAGS_vmlinux        += --emit-relocs
+KBUILD_LDFLAGS_MODULE += --emit-relocs
+
 ifdef CONFIG_PPC64
 ifndef CONFIG_PPC_KERNEL_PCREL
 	# -mcmodel=medium breaks modules because it uses 32bit offsets from
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 756a6c694018..d6ae92a292ec 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -32,7 +32,7 @@
 
 #define FTR_SECTION_ELSE_NESTED(label)			\
 label##2:						\
-	.pushsection __ftr_alt_##label,"a";		\
+	.pushsection __ftr_alt_##label, "ax";		\
 	.align 2;					\
 label##3:
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8fc11d6565bf..1a2d7c2d32f1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -99,8 +99,8 @@ SECTIONS
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
 #endif
-		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text.hot .text.hot.* TEXT_MAIN .text.fixup .text.unlikely .text.unlikely.* .fixup __ftr_alt_* .ref.text);
+		*(.text.hot .text.hot.* TEXT_MAIN .text.fixup .text.unlikely
+			.text.unlikely.* .fixup .ref.text);
 		*(.tramp.ftrace.text);
 		NOINSTR_TEXT
 		SCHED_TEXT
@@ -267,6 +267,10 @@ SECTIONS
 		_einittext = .;
 	} :text
 
+	.__ftr_alternates.text : AT(ADDR(.__ftr_alternates.text) - LOAD_OFFSET) {
+		*(__ftr_alt*);
+	}
+
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
 	 */
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 587c8cf1230f..269e992b1631 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -53,22 +53,10 @@ static u32 *calc_addr(struct fixup_entry *fcur, long offset)
 
 static int patch_alt_instruction(u32 *src, u32 *dest, u32 *alt_start, u32 *alt_end)
 {
-	int err;
 	ppc_inst_t instr;
 
 	instr = ppc_inst_read(src);
 
-	if (instr_is_relative_branch(ppc_inst_read(src))) {
-		u32 *target = (u32 *)branch_target(src);
-
-		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target > alt_end) {
-			err = translate_branch(&instr, dest, src);
-			if (err)
-				return 1;
-		}
-	}
-
 	raw_patch_instruction(dest, instr);
 
 	return 0;
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index a1bef0638ecb..66e5d58a6ce8 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -82,11 +82,15 @@ endif
 # vmlinux
 # ---------------------------------------------------------------------------
 
+# These configurations require vmlinux.unstripped to be linked with
+# '--emit-relocs', which need to be stripped from the final vmlinux.
+uses-emit-relocs := $(or $(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),$(CONFIG_HAVE_OBJTOOL_FTR_FIXUP))
+
 remove-section-y                                   := .modinfo
-remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '!.rel*.dyn'
+remove-section-$(uses-emit-relocs)                 += '.rel*' '!.rel*.dyn'
 # for compatibility with binutils < 2.32
 # https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7
-remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel.*'
+remove-section-$(uses-emit-relocs)                 += '.rel.*'
 
 remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
 
-- 
2.43.0


