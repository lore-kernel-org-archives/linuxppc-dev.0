Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8394C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EEB2073F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EEB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fzwl3gcrzDqGQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:55:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzl02FJDzDqQv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzl0031Cz9s4V; Thu, 11 Apr 2019 21:46:36 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzkz5lSSz9sBr; Thu, 11 Apr 2019 21:46:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 03/35] powerpc/64s: Add support for ori
 barrier_nospec patching
Date: Thu, 11 Apr 2019 21:45:58 +1000
Message-Id: <20190411114630.4042-4-mpe@ellerman.id.au>
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

From: Michal Suchanek <msuchanek@suse.de>

commit 2eea7f067f495e33b8b116b35b5988ab2b8aec55 upstream.

Based on the RFI patching. This is required to be able to disable the
speculation barrier.

Only one barrier type is supported and it does nothing when the
firmware does not enable it. Also re-patching modules is not supported
So the only meaningful thing that can be done is patching out the
speculation barrier at boot when the user says it is not wanted.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/barrier.h        |  2 +-
 arch/powerpc/include/asm/feature-fixups.h |  9 ++++++++
 arch/powerpc/include/asm/setup.h          |  1 +
 arch/powerpc/kernel/security.c            |  9 ++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 ++++++
 arch/powerpc/lib/feature-fixups.c         | 27 +++++++++++++++++++++++
 6 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 352ea3e3cc05..a8131162104f 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -82,7 +82,7 @@ do {									\
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
  */
-#define barrier_nospec_asm ori 31,31,0
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop
 
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 0bf8202feca6..afd3efd38938 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -213,6 +213,14 @@ void setup_feature_keys(void);
 	FTR_ENTRY_OFFSET 951b-952b;			\
 	.popsection;
 
+#define NOSPEC_BARRIER_FIXUP_SECTION			\
+953:							\
+	.pushsection __barrier_nospec_fixup,"a";	\
+	.align 2;					\
+954:							\
+	FTR_ENTRY_OFFSET 953b-954b;			\
+	.popsection;
+
 
 #ifndef __ASSEMBLY__
 
@@ -220,6 +228,7 @@ extern long stf_barrier_fallback;
 extern long __start___stf_entry_barrier_fixup, __stop___stf_entry_barrier_fixup;
 extern long __start___stf_exit_barrier_fixup, __stop___stf_exit_barrier_fixup;
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
+extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
 
 #endif
 
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 3f160cd20107..703ddf752516 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -50,6 +50,7 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void do_barrier_nospec_fixups(bool enable);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 2277df84ef6e..8b1cf9c81b82 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -10,10 +10,19 @@
 #include <linux/seq_buf.h>
 
 #include <asm/security_features.h>
+#include <asm/setup.h>
 
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
+static bool barrier_nospec_enabled;
+
+static void enable_barrier_nospec(bool enable)
+{
+	barrier_nospec_enabled = enable;
+	do_barrier_nospec_fixups(enable);
+}
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c16fddbb6ab8..61def0be6914 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -153,6 +153,13 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+
+	. = ALIGN(8);
+	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
+		__start___barrier_nospec_fixup = .;
+		*(__barrier_nospec_fixup)
+		__stop___barrier_nospec_fixup = .;
+	}
 #endif
 
 	EXCEPTION_TABLE(0)
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index cf1398e3c2e0..f82ae6bb2365 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -277,6 +277,33 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
 						: "unknown");
 }
+
+void do_barrier_nospec_fixups(bool enable)
+{
+	unsigned int instr, *dest;
+	long *start, *end;
+	int i;
+
+	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+
+	instr = 0x60000000; /* nop */
+
+	if (enable) {
+		pr_info("barrier-nospec: using ORI speculation barrier\n");
+		instr = 0x63ff0000; /* ori 31,31,0 speculation barrier */
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.20.1

