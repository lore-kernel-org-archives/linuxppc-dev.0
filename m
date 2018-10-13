Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9912CC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 10:58:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03BB20645
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 10:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03BB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XMC11YbbzDsGm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:58:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XM8y0WRVzF368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 21:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XM8x6nmrz9s89; Sat, 13 Oct 2018 21:57:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XM8x6PDLz9s9J; Sat, 13 Oct 2018 21:57:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Split user/kernel definitions of struct pt_regs
Date: Sat, 13 Oct 2018 21:56:44 +1100
Message-Id: <20181013105646.5147-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
That means the layout of the structure is ABI, ie. we can't change it.

That would be fine if it was only used to describe the user-visible
register state of a process, but it's also the struct we use in the
kernel to describe the registers saved in an interrupt frame.

We'd like more flexibility in the content (and possibly layout) of the
kernel version of the struct, but currently that's not possible.

So split the definition into a user-visible definition which remains
unchanged, and a kernel internal one.

At the moment they're still identical, and we check that at build
time. That's because we have code (in ptrace etc.) that assumes that
they are the same. We will fix that code in future patches, and then
we can break the strict symmetry between the two structs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ptrace.h      | 27 ++++++++++++++++++
 arch/powerpc/include/uapi/asm/ptrace.h |  7 ++++-
 arch/powerpc/kernel/ptrace.c           | 39 ++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 447cbd1bee99..3dd15024db93 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -26,6 +26,33 @@
 #include <uapi/asm/ptrace.h>
 #include <asm/asm-const.h>
 
+#ifndef __ASSEMBLY__
+struct pt_regs
+{
+	union {
+		struct user_pt_regs user_regs;
+		struct {
+			unsigned long gpr[32];
+			unsigned long nip;
+			unsigned long msr;
+			unsigned long orig_gpr3;
+			unsigned long ctr;
+			unsigned long link;
+			unsigned long xer;
+			unsigned long ccr;
+#ifdef CONFIG_PPC64
+			unsigned long softe;
+#else
+			unsigned long mq;
+#endif
+			unsigned long trap;
+			unsigned long dar;
+			unsigned long dsisr;
+			unsigned long result;
+		};
+	};
+};
+#endif
 
 #ifdef __powerpc64__
 
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 55c7a131d2ab..f5f1ccc740fc 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -29,7 +29,12 @@
 
 #ifndef __ASSEMBLY__
 
-struct pt_regs {
+#ifdef __KERNEL__
+struct user_pt_regs
+#else
+struct pt_regs
+#endif
+{
 	unsigned long gpr[32];
 	unsigned long nip;
 	unsigned long msr;
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4e372f54088f..939d7f81bbbe 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3335,3 +3335,42 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 
 	user_enter();
 }
+
+void __init pt_regs_check(void)
+{
+	BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
+		     offsetof(struct user_pt_regs, gpr));
+	BUILD_BUG_ON(offsetof(struct pt_regs, nip) !=
+		     offsetof(struct user_pt_regs, nip));
+	BUILD_BUG_ON(offsetof(struct pt_regs, msr) !=
+		     offsetof(struct user_pt_regs, msr));
+	BUILD_BUG_ON(offsetof(struct pt_regs, msr) !=
+		     offsetof(struct user_pt_regs, msr));
+	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
+		     offsetof(struct user_pt_regs, orig_gpr3));
+	BUILD_BUG_ON(offsetof(struct pt_regs, ctr) !=
+		     offsetof(struct user_pt_regs, ctr));
+	BUILD_BUG_ON(offsetof(struct pt_regs, link) !=
+		     offsetof(struct user_pt_regs, link));
+	BUILD_BUG_ON(offsetof(struct pt_regs, xer) !=
+		     offsetof(struct user_pt_regs, xer));
+	BUILD_BUG_ON(offsetof(struct pt_regs, ccr) !=
+		     offsetof(struct user_pt_regs, ccr));
+#ifdef __powerpc64__
+	BUILD_BUG_ON(offsetof(struct pt_regs, softe) !=
+		     offsetof(struct user_pt_regs, softe));
+#else
+	BUILD_BUG_ON(offsetof(struct pt_regs, mq) !=
+		     offsetof(struct user_pt_regs, mq));
+#endif
+	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
+		     offsetof(struct user_pt_regs, trap));
+	BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=
+		     offsetof(struct user_pt_regs, dar));
+	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
+		     offsetof(struct user_pt_regs, dsisr));
+	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
+		     offsetof(struct user_pt_regs, result));
+
+	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
+}
-- 
2.17.1

