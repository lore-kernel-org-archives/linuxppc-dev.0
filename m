Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF8C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:32:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E022D2184B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E022D2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g0m14Vp0zDqMM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 22:32:33 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzlb55KXzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:47:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzlb3FZBz9sNt; Thu, 11 Apr 2019 21:47:07 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzlb1nyPz9sNs; Thu, 11 Apr 2019 21:47:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 23/35] powerpc/fsl: Add infrastructure to fixup
 branch predictor flush
Date: Thu, 11 Apr 2019 21:46:18 +1000
Message-Id: <20190411114630.4042-24-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411114630.4042-1-mpe@ellerman.id.au>
References: <20190411114630.4042-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Diana Craciun <diana.craciun@nxp.com>

commit 76a5eaa38b15dda92cd6964248c39b5a6f3a4e9d upstream.

In order to protect against speculation attacks (Spectre
variant 2) on NXP PowerPC platforms, the branch predictor
should be flushed when the privillege level is changed.
This patch is adding the infrastructure to fixup at runtime
the code sections that are performing the branch predictor flush
depending on a boot arg parameter which is added later in a
separate patch.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/feature-fixups.h | 12 ++++++++++++
 arch/powerpc/include/asm/setup.h          |  2 ++
 arch/powerpc/kernel/vmlinux.lds.S         |  8 ++++++++
 arch/powerpc/lib/feature-fixups.c         | 23 +++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index afd3efd38938..175128e19025 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -221,6 +221,17 @@ void setup_feature_keys(void);
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
 
@@ -229,6 +240,7 @@ extern long __start___stf_entry_barrier_fixup, __stop___stf_entry_barrier_fixup;
 extern long __start___stf_exit_barrier_fixup, __stop___stf_exit_barrier_fixup;
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
 extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
+extern long __start__btb_flush_fixup, __stop__btb_flush_fixup;
 
 #endif
 
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index d3e9da62d029..23ee67e279ae 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -65,6 +65,8 @@ void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
 #endif
 
+void do_btb_flush_fixups(void);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 5c6cf58943b9..50d365060855 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -164,6 +164,14 @@ SECTIONS
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
index b3e362437ec4..e6ed0ec94bc8 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -347,6 +347,29 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
+
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
+
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
2.20.1

