Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4591C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:10:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D841205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjkBGwOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D841205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CvNd3KSQzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 18:10:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjkBGwOD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out1-smtp.messagingengine.com (client-ip=66.111.4.25;
 helo=out1-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="SjkBGwOD"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cv9K1VqZzDqsQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:00:36 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 817E221CF3;
 Mon, 10 Dec 2018 02:00:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 10 Dec 2018 02:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=73sbAKTf02ya4avlHYPn17fRJV8GVDmSDzOrPjc9Y3A=; b=SjkBGwOD
 P0MRR3NztDZB7ajatvLMaLKVMoKdhI7rvngyATGabMRJrY0bwRye24nH+nSYhS3h
 dsKxzvuKaf5p/CnB3s209XKX8W4trqFRSpHYyFtvySiHfevv6vQD7ebK+CKAsFxP
 /POuH+K+eUgNrimVHDMoENS09j2PxJ7XFfJ4wcW0O857oT4TAjFi5McX6Pv2PL+u
 XBSKHV3WqQ+Mq7ioJBBs3Wpsec7QVIZH5EyE5FAqKYg6g73iBJIbhxMBpE+fpQIH
 5idOoMf1e3WwXrcaj52bMxhT+bofKYNyKnDau7n3A/Z9D2K+b5KcKcihjPazUYfu
 Rci4wvH4RVLQYw==
X-ME-Sender: <xms:Eg8OXFatI3Pq5Rc9To4JIh9mZnJIRtJFOYrRCpp4_jC7q4_evDJZNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeggedguddtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
 fedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvffufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhr
 sehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrg
 hmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushht
 vghrufhiiigvpedu
X-ME-Proxy: <xmx:Eg8OXEiD0otx0Hxm6cIk48A1dUMhAVXPvRw32b0Bsyfzwoi6XpVDww>
 <xmx:Eg8OXOj-xWpHMB3tOvYKK3iT0Pg49uv8265AKBibKltBHtRLFE4YFA>
 <xmx:Eg8OXApYQcuecnwz8a7FjFRQCJBzGFSQnI_C1QmkHKeAxJ9KWJloKw>
 <xmx:Eg8OXEwiFbl9dtXEh7p7S7xNYSr9d2Ah51xeLXonFI8HxCAC3b38DA>
 <xmx:Eg8OXPw51wjGJe154Noj2un-n-4WdJCxIUrXg_84akh40-xP6UyArA>
 <xmx:Eg8OXHVOrrI4qW0Ei99x1SA-h2InNFx-U1GhEpIfIOE62bQjnRDCQA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6FEADE4445;
 Mon, 10 Dec 2018 02:00:31 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] powerpc/64s: Implement KUAP for Radix MMU
Date: Mon, 10 Dec 2018 18:00:44 +1100
Message-Id: <20181210070044.27503-4-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210070044.27503-1-ruscur@russell.cc>
References: <20181210070044.27503-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, kernel-hardening@lists.openwall.com,
 Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kernel Userspace Access Prevention utilises a feature of
the Radix MMU which disallows read and write access to userspace
addresses.  By utilising this, the kernel is prevented from accessing
user data from outside of trusted paths that perform proper safety
checks, such as copy_{to/from}_user() and friends.

Userspace access is disabled from early boot and is only enabled when:

        - exiting the kernel and entering userspace
        - performing an operation like copy_{to/from}_user()
        - context switching to a process that has access enabled

and similarly, access is disabled again when exiting userspace and
entering the kernel.

This feature has a slight performance impact which I roughly measured
to be
3% slower in the worst case (performing 1GB of 1 byte read()/write()
syscalls), and is gated behind the CONFIG_PPC_KUAP option for
performance-critical builds.

This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=y)
and performing the following:

        echo ACCESS_USERSPACE > [debugfs]/provoke-crash/DIRECT

if enabled, this should send SIGSEGV to the thread.

The KUAP state is tracked in the PACA because reading the register
that manages these accesses is costly. This Has the unfortunate
downside of another layer of abstraction for platforms that implement
the locks and unlocks, but this could be useful in future for other
things too, like counters for benchmarking or smartly handling lots
of small accesses at once.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 .../powerpc/include/asm/book3s/64/kup-radix.h | 36 +++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h      | 15 ++++++--
 arch/powerpc/include/asm/kup.h                |  3 ++
 arch/powerpc/include/asm/mmu.h                |  9 ++++-
 arch/powerpc/include/asm/reg.h                |  1 +
 arch/powerpc/mm/pgtable-radix.c               | 14 ++++++++
 arch/powerpc/mm/pkeys.c                       |  7 ++--
 arch/powerpc/platforms/Kconfig.cputype        |  1 +
 8 files changed, 81 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
new file mode 100644
index 000000000000..93273ca99310
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_RADIX_H
+#define _ASM_POWERPC_KUP_RADIX_H
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_PPC_KUAP
+#include <asm/reg.h>
+/*
+ * We do have the ability to individually lock/unlock reads and writes rather
+ * than both at once, however it's a significant performance hit due to needing
+ * to do a read-modify-write, which adds a mfspr, which is slow.  As a result,
+ * locking/unlocking both at once is preferred.
+ */
+static inline void unlock_user_access(void __user *to, const void __user *from,
+				      unsigned long size)
+{
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return;
+
+	mtspr(SPRN_AMR, 0);
+	isync();
+	get_paca()->user_access_allowed = 1;
+}
+
+static inline void lock_user_access(void __user *to, const void __user *from,
+				    unsigned long size)
+{
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return;
+
+	mtspr(SPRN_AMR, AMR_LOCKED);
+	get_paca()->user_access_allowed = 0;
+}
+#endif /* CONFIG_PPC_KUAP */
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 4d971ca1e69b..0ed4923c1282 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -264,8 +264,19 @@ BEGIN_FTR_SECTION_NESTED(943)						\
 	std	ra,offset(r13);						\
 END_FTR_SECTION_NESTED(ftr,ftr,943)
 
-#define LOCK_USER_ACCESS(reg)
-#define UNLOCK_USER_ACCESS(reg)
+#define LOCK_USER_ACCESS(reg)						\
+BEGIN_MMU_FTR_SECTION_NESTED(944)					\
+	lis	reg,(AMR_LOCKED)@highest;				\
+	rldicr	reg,reg,32,31;						\
+	mtspr	SPRN_AMR,reg;						\
+END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KUAP,MMU_FTR_RADIX_KUAP,944)
+
+#define UNLOCK_USER_ACCESS(reg)						\
+BEGIN_MMU_FTR_SECTION_NESTED(945)					\
+	li	reg,0;							\
+	mtspr	SPRN_AMR,reg;						\
+	isync;								\
+END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KUAP,MMU_FTR_RADIX_KUAP,945)
 
 #define EXCEPTION_PROLOG_0(area)					\
 	GET_PACA(r13);							\
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 16ff3f9da29c..7813e2bcfb7c 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -8,6 +8,9 @@
 #ifdef CONFIG_PPC_BOOK3S_32
 #include <asm/book3s/32/kup.h>
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/book3s/64/kup-radix.h>
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..048df188fc10 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -107,6 +107,10 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
+/* Supports KUAP (key 0 controlling userspace addresses) on radix
+ */
+#define MMU_FTR_RADIX_KUAP		ASM_CONST(0x80000000)
+
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
@@ -143,7 +147,10 @@ enum {
 		MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_TYPE_RADIX |
-#endif
+#ifdef CONFIG_PPC_KUAP
+		MMU_FTR_RADIX_KUAP |
+#endif /* CONFIG_PPC_KUAP */
+#endif /* CONFIG_PPC_RADIX_MMU */
 		0,
 };
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c9c382e57017..6b5d2a61af5a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -246,6 +246,7 @@
 #define SPRN_DSCR	0x11
 #define SPRN_CFAR	0x1c	/* Come From Address Register */
 #define SPRN_AMR	0x1d	/* Authority Mask Register */
+#define   AMR_LOCKED	0xC000000000000000UL /* Read & Write disabled */
 #define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
 #define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 3565e266994b..e248f330d6fd 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -552,6 +553,19 @@ void __init setup_kuep(bool disabled)
 }
 #endif
 
+#ifdef CONFIG_PPC_KUAP
+void __init setup_kuap(bool disabled)
+{
+	if (disabled || !early_radix_enabled())
+		return;
+
+	pr_info("Activating Kernel Userspace Access Prevention\n");
+
+	cur_cpu_spec->mmu_features |= MMU_FTR_RADIX_KUAP;
+	mtspr(SPRN_AMR, AMR_LOCKED);
+}
+#endif
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b271b283c785..bb3cf915016f 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -7,6 +7,7 @@
 
 #include <asm/mman.h>
 #include <asm/setup.h>
+#include <asm/uaccess.h>
 #include <linux/pkeys.h>
 #include <linux/of_device.h>
 
@@ -266,7 +267,8 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 void thread_pkey_regs_save(struct thread_struct *thread)
 {
-	if (static_branch_likely(&pkey_disabled))
+	if (static_branch_likely(&pkey_disabled) &&
+	    !mmu_has_feature(MMU_FTR_RADIX_KUAP))
 		return;
 
 	/*
@@ -280,7 +282,8 @@ void thread_pkey_regs_save(struct thread_struct *thread)
 void thread_pkey_regs_restore(struct thread_struct *new_thread,
 			      struct thread_struct *old_thread)
 {
-	if (static_branch_likely(&pkey_disabled))
+	if (static_branch_likely(&pkey_disabled) &&
+	    !mmu_has_feature(MMU_FTR_RADIX_KUAP))
 		return;
 
 	if (old_thread->amr != new_thread->amr)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 48cc8df0fdd2..0b9a8eda413a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -336,6 +336,7 @@ config PPC_RADIX_MMU
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.19.2

