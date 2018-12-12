Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C822084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C822084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FJhQ0zJtzDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 01:13:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FJSV5cdZzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 01:03:32 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B39620018D;
 Wed, 12 Dec 2018 15:03:29 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EE0A200293;
 Wed, 12 Dec 2018 15:03:29 +0100 (CET)
Received: from fsr-ub1664-009.ea.freescale.net
 (fsr-ub1664-009.ea.freescale.net [10.171.71.77])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 00CDC205E5;
 Wed, 12 Dec 2018 15:03:28 +0100 (CET)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/11] powerpc/fsl: Add infrastructure to fixup branch
 predictor flush
Date: Wed, 12 Dec 2018 16:03:00 +0200
Message-Id: <1544623390-18710-2-git-send-email-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544623390-18710-1-git-send-email-diana.craciun@nxp.com>
References: <1544623390-18710-1-git-send-email-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Diana Craciun <diana.craciun@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to protect against speculation attacks (Spectre
variant 2) on NXP PowerPC platforms, the branch predictor
should be flushed when the privillege level is changed.
This patch is adding the infrastructure to fixup at runtime
the code sections that are performing the branch predictor flush
depending on a boot arg parameter which is added later in a
separate patch.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/include/asm/feature-fixups.h | 12 ++++++++++++
 arch/powerpc/include/asm/setup.h          |  2 ++
 arch/powerpc/kernel/vmlinux.lds.S         |  8 ++++++++
 arch/powerpc/lib/feature-fixups.c         | 21 +++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 33b6f9c..40a6c926 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -221,6 +221,17 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET 953b-954b;			\
 	.popsection;
 
+#define START_BTB_FLUSH_SECTION			\
+955:							\
+
+#define END_BTB_FLUSH_SECTION			\
+956:							\
+	.pushsection __btb_flush_fixup,"a";	\
+	.align 2;							\
+957:						\
+	FTR_ENTRY_OFFSET 955b-957b;			\
+	FTR_ENTRY_OFFSET 956b-957b;			\
+	.popsection;
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
@@ -230,6 +241,7 @@ extern long __start___stf_entry_barrier_fixup, __stop___stf_entry_barrier_fixup;
 extern long __start___stf_exit_barrier_fixup, __stop___stf_exit_barrier_fixup;
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
 extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
+extern long __start__btb_flush_fixup, __stop__btb_flush_fixup;
 
 void apply_feature_fixups(void);
 void setup_feature_keys(void);
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 1fffbba..c941c8c 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -67,6 +67,8 @@ void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
 #endif
 
+void do_btb_flush_fixups(void);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581b..254b757 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -170,6 +170,14 @@ SECTIONS
 	}
 #endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	. = ALIGN(8);
+	__spec_btb_flush_fixup : AT(ADDR(__spec_btb_flush_fixup) - LOAD_OFFSET) {
+		__start__btb_flush_fixup = .;
+		*(__btb_flush_fixup)
+		__stop__btb_flush_fixup = .;
+	}
+#endif
 	EXCEPTION_TABLE(0)
 
 	NOTES :kernel :notes
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index e613b02..02a213c 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -347,6 +347,27 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
+static void patch_btb_flush_section(long *curr)
+{
+	unsigned int *start, *end;
+
+	start = (void *)curr + *curr;
+	end = (void *)curr + *(curr + 1);
+	for (; start < end; start++) {
+		pr_devel("patching dest %lx\n", (unsigned long)start);
+		patch_instruction(start, PPC_INST_NOP);
+	}
+}
+void do_btb_flush_fixups(void)
+{
+	long *start, *end;
+
+	start = PTRRELOC(&__start__btb_flush_fixup);
+	end = PTRRELOC(&__stop__btb_flush_fixup);
+
+	for (; start < end; start += 2)
+		patch_btb_flush_section(start);
+}
 #endif /* CONFIG_PPC_FSL_BOOK3E */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.5.5

