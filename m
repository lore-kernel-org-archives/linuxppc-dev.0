Return-Path: <linuxppc-dev+bounces-28469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF66ACA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:36:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBNh2hTjz2yvy;
	Tue, 29 Sep 2026 18:36:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790670996;
	cv=none; b=KHOIxlco/4lsVo4HOVkBmjMuYyqsYBJKWVz6xyGvLYMLlJH5QLM1Nx53YPZydHnN/C/Qbb/+8kN4YH+3tc4HIFGoUYyCVSVfUKVHqkDHSjTAdXtCJPLxbysDzXcXeshdY/fOVNpmZYZECQShwk5OFDuZ+k0xe7CgriVBnFrRA5U3a7WkcGkdyixYnm5QNPTpEWGkCs99W08F0p2fvVI3B7yBOQLCtVBk8rGYDuqpd3N7CkFkCT5kw0mc6p6l94SED1MLyFqqitr5+unB1qdz+/stPrXR23ceLd3dTxxLKidLpqss0WEWOfJEDRPerH0UBrrhkIW9219YsFhr7pGk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790670996; c=relaxed/relaxed;
	bh=vXAEujULcXSrso+Mmqr4Sti2CkmXH7iL9ksjqXQ56Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMCoHLta7rAbbWCZ+N9R22J+TX9FtVmyqIyWlT5wFD20VSQARTSkbhXGPgECTuV8rLnUHFPpeEA4w3/9BtBKsNluhxLgeYfYPQlOE6ExTTCK/hgAmKoU7M9NgpU0wxflNFa/oNl8oqlBrMQCw8GXFkVyNWbeWjZ+/MYrcJH/I6iNBzE3ZzXRN9ecqZ3SMSHZ8RY8ixdveBeuqCrbPQ6mPlYCg2JHpK9nTezeWisCiRatEthZH/aof/QnDmwApJ1qVHhWdb7KcmbNJCwX3pczyaipSKAqeDAY7xv4AAFvvO74LslmvFYPTf/hXmtvCVMjJ6LI89S/ZhaweIRLB9vDrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Cn7GVd3Y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Cn7GVd3Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBNd1Bz1z2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:36:32 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46XTv2858633;
	Tue, 29 Sep 2026 05:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vXAEujULcXSrso+Mm
	qr4Sti2CkmXH7iL9ksjqXQ56Kg=; b=Cn7GVd3YlOhgbhL3eS/QXv89k1ar+uf1P
	F9smv/hT+jnsJODfX0r+Xatwkg8fXjjVtm4t+pcqaczvG5oyg40u/wLB/CrlYf6r
	sE9BfQAvdzgbIaJRDDSuvC/yip8NXAL6vgLgW74c3Gy0yRb0wnDh+8LNeeSdxe2V
	e/rPsIEKgEPZFqAS0J28M3/PFjYxpOU98RVYts4WlGFP2TglmuCy7mCBVi+BLD+p
	/VAgaSZJOOklSiFsCBAtMIaz71Pby00UtiaM4W8qk7F2rn9TkeTdrdYwanKha0+4
	f0LUruKvDv7jRiCxmtWs0SMYVNSS9INJQatQGd/6kTSLKemyenHEA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk534b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4Hpwd1134506;
	Tue, 29 Sep 2026 05:52:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck8d97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5qXFj37290384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:52:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3D420043;
	Tue, 29 Sep 2026 05:52:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F18020040;
	Tue, 29 Sep 2026 05:52:26 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 05:52:26 +0000 (GMT)
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
Subject: [PATCH v2 6/6] powerpc: Enable build-time feature fixup processing by default
Date: Tue, 29 Sep 2026 11:21:37 +0530
Message-ID: <20260929055138.43489-7-shivangu@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nEdsJhTlIB48tk-3kiMd4GaLuc0rbpqt
X-Proofpoint-GUID: x171eeEOn6-s6QQxNcfTfv_00wBiAbfN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfXzwU9cXW/GPyR
 jQao1HxUtv5wgAkM1BPLscYo9M0nSmTmOy/OJOGTZm9jWdsiZ6D6HRlPODV9y4DmIOGUpJJTCpP
 GaS3tuQkEJxarUuoHV9HFOKJCkyyzrg=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abb5228 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=CCpqsmhAAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=J1YRHh2PESAzyqZr0scA:9 a=O8hF6Hzn-FEA:10 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfXyWjmhUJtffwV
 Z9n79v5K0DvC16YQ3GldMAf45+lVtexlBCu1LVyDPCzDfOmoay8FZ86tKzVGWIEf9T+jmKSv7Gy
 Drd1CYaSQwfFlPef/hQMFtOCofdWMDvuKlTg2LndfEnbfnL53dCWcjeZE9ACbBSXZF4oodKvGuw
 UbXmVZbp3L0eSeWPDUq2SRd0Q6c9bUteMaT4X7jlidvtibZp7L6DRht85/kA4r/IeCWwH6+Ug6y
 NVPDg5aPLFFo/AAcvHAWNi2+aUXKwxLI+xG0wFYSbU90fdEu09GyRrOtAm8cbq4tTyK0yJBIaCX
 H7u/DZ/keFObI61IDNp5zxtYewdT59mIjjQV4DDbGlPrOfd06OUS/NBGh7HCizuVOe5VTPARiuz
 N3bh3WQDwWw1xOQq3o9DKSW7O/DMENhQ2aIl8ZRo7b8s4cUaJGU3nQMZMHu7Y4WQfxmjmzqC9Yo
 qr1ftPP2PVaRFYK/dYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290022

From: Sathvika Vasireddy <sv@linux.ibm.com>

Enable HAVE_OBJTOOL_FTR_FIXUP by default on PowerPC architecture.

- Remove runtime branch translation logic from patch_alt_instruction()
- Add --emit-relocs linker flags for post-link fixup processing
- Update ftr_alt section attributes to include executable flag
- Strip the --emit-relocs relocation sections (.rel*) from the final
  vmlinux after processing

Co-developed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 arch/powerpc/Kconfig                      |  3 +++
 arch/powerpc/Makefile                     |  5 +++++
 arch/powerpc/include/asm/feature-fixups.h |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S         |  8 ++++++--
 arch/powerpc/lib/feature-fixups.c         | 12 ------------
 scripts/Makefile.vmlinux                  |  8 ++++++--
 6 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..d9056f35da9f 100644
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
index 9385db478c59..269ed76a40c6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -112,6 +112,11 @@ LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie --no-dynamic-linker
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
2.54.0


