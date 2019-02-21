Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D2AC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:50:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D77720880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="nzvPb4Op";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yzey20iI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D77720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qTY41NVzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:50:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="nzvPb4Op"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="yzey20iI"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444q9q2v6jzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:36:47 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 3134F21F44;
 Thu, 21 Feb 2019 04:36:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 04:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=daTEmitcBV9Rj
 A1K67fu4m4Czn7JssgD7AXGHUGAKgQ=; b=nzvPb4OpeGUmSHHFySA9opn6wNHZa
 ZWhUV5M1Bxp4PrykW5Uomf1/ZIKWZDukjWEOOn1WHckKlnpoznSzksnB81u28deL
 i8ZKE2NU7ZnIOM+Ds6W1ZuOlE/as44nopY8Srg2y7t4FwJAeM/VNFuONs4B5cL81
 DOJbdmUK3Na8la92CXjih8tb8LB5/MK4uDB3/yCWayaqTfLnBnkJfK6RZZI2utZY
 9S94Jik90wBnofCvyOCYgjjAg+btZeRFOAxr8OLB4xXwbvus1YXFykExqttWcaiA
 EBEZTJvrfqIKApNJuXYsHOQnLgtLW3hl7UgcYdUqWiav9WzyzcVimM0TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=daTEmitcBV9RjA1K67fu4m4Czn7JssgD7AXGHUGAKgQ=; b=yzey20iI
 ct1oi0TNCREbDjfEAkP5GxloRyw6cQPNM+0Ino8ftj076K+lbSfOjTLknCcEFGHa
 NhHdbTozzK07HLUsA7dfOe9hzIt8tJBQAJDvyXoVmyh5IJ2nMHOP1U6Ky3+RiRfS
 8C0clSUKRPwbwvXJNSksgfLEfXybKAjcqzLPI1zBdYnHnW4KwJHMBlWW9OvGwxDO
 4clvIpOAYL+bRs4bNv6y9rKNSuNkegTzLDGkbSGBoxBn6UZMCdXqK5iWoKihyngH
 UDl1B2PtuMW+zNDj+unRUD746Gk6TOqIgTITnqmrBJborAJHduMABb7WEg0LhypJ
 ByI1aroKKyiY9w==
X-ME-Sender: <xms:LHFuXDLb5bWi6zuFej6SvITd29CAA1pWAzlDM5LleMH90y04Ib7RtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgddtjeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
 vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrke
 dvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhl
 rdgttgenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:LXFuXMZTwhoIPLiH9HSAS7LhQeLRKsZCrSf1qKIxOJmgCE_c91wALA>
 <xmx:LXFuXOXe1Q4wrx7DaHkUE-w4jy2aDfrHGC-EGsBwvpOlCrkT-n6DAQ>
 <xmx:LXFuXMHBNEqZ-gK74P-ta2cJjSUTJwf3V_g8-tjPAyCu3fNqVt75jA>
 <xmx:LXFuXDQY7T92EppOMG6pODMItaPQxGqwSsmrveLzGoImBDb9Y_pLWg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 789D310310;
 Thu, 21 Feb 2019 04:36:42 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/7] powerpc/64s: Implement KUAP for Radix MMU
Date: Thu, 21 Feb 2019 20:36:01 +1100
Message-Id: <20190221093601.27920-8-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221093601.27920-1-ruscur@russell.cc>
References: <20190221093601.27920-1-ruscur@russell.cc>
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
Cc: Russell Currey <ruscur@russell.cc>, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kernel Userspace Access Prevention utilises a feature of the Radix MMU
which disallows read and write access to userspace addresses. By
utilising this, the kernel is prevented from accessing user data from
outside of trusted paths that perform proper safety checks, such as
copy_{to/from}_user() and friends.

Userspace access is disabled from early boot and is only enabled when
performing an operation like copy_{to/from}_user().  The register that
controls this (AMR) does not prevent userspace from accessing other
userspace, so there is no need to save and restore when entering and
exiting userspace.

This feature has a slight performance impact which I roughly measured
to be 3% slower in the worst case (performing 1GB of 1 byte
read()/write() syscalls), and is gated behind the CONFIG_PPC_KUAP
option for performance-critical builds.

This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=y)
and performing the following:

  # (echo ACCESS_USERSPACE) > [debugfs]/provoke-crash/DIRECT

If enabled, this should send SIGSEGV to the thread.

A big limitation of the current implementation is that user access
is left unlocked if an exception is taken while user access is unlocked
(i.e. if an interrupt is taken during copy_to_user()). This should be
resolved in future, and is why the state is tracked in the PACA even
though nothing currently uses it.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 .../powerpc/include/asm/book3s/64/kup-radix.h | 36 +++++++++++++++++++
 arch/powerpc/include/asm/kup.h                |  4 +++
 arch/powerpc/include/asm/mmu.h                |  9 ++++-
 arch/powerpc/include/asm/reg.h                |  1 +
 arch/powerpc/mm/pgtable-radix.c               | 16 +++++++++
 arch/powerpc/mm/pkeys.c                       |  7 ++--
 arch/powerpc/platforms/Kconfig.cputype        |  1 +
 7 files changed, 71 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
new file mode 100644
index 000000000000..5cfdea954418
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
+	mtspr(SPRN_AMR, RADIX_AMR_LOCKED);
+	get_paca()->user_access_allowed = 0;
+}
+#endif /* CONFIG_PPC_KUAP */
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 2ac540fb488f..af583fd5a027 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_POWERPC_KUP_H_
 #define _ASM_POWERPC_KUP_H_
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/book3s/64/kup-radix.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 25607604a7a5..ea703de9be9b 100644
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
@@ -164,7 +168,10 @@ enum {
 #endif
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
index 1c98ef1f2d5b..0e789e2c5bc3 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -246,6 +246,7 @@
 #define SPRN_DSCR	0x11
 #define SPRN_CFAR	0x1c	/* Come From Address Register */
 #define SPRN_AMR	0x1d	/* Authority Mask Register */
+#define   RADIX_AMR_LOCKED	0xC000000000000000UL /* Read & Write disabled */
 #define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
 #define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 224bcd4be5ae..b621cef4825e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -553,6 +554,21 @@ void __init setup_kuep(bool disabled)
 }
 #endif
 
+#ifdef CONFIG_PPC_KUAP
+void __init setup_kuap(bool disabled)
+{
+	if (disabled || !early_radix_enabled())
+		return;
+
+	if (smp_processor_id() == boot_cpuid) {
+		pr_info("Activating Kernel Userspace Access Prevention\n");
+		cur_cpu_spec->mmu_features |= MMU_FTR_RADIX_KUAP;
+	}
+
+	mtspr(SPRN_AMR, RADIX_AMR_LOCKED);
+}
+#endif
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 587807763737..2223f4b4b1bf 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -7,6 +7,7 @@
 
 #include <asm/mman.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 #include <asm/setup.h>
 #include <linux/pkeys.h>
 #include <linux/of_device.h>
@@ -267,7 +268,8 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 void thread_pkey_regs_save(struct thread_struct *thread)
 {
-	if (static_branch_likely(&pkey_disabled))
+	if (static_branch_likely(&pkey_disabled) &&
+	    !mmu_has_feature(MMU_FTR_RADIX_KUAP))
 		return;
 
 	/*
@@ -281,7 +283,8 @@ void thread_pkey_regs_save(struct thread_struct *thread)
 void thread_pkey_regs_restore(struct thread_struct *new_thread,
 			      struct thread_struct *old_thread)
 {
-	if (static_branch_likely(&pkey_disabled))
+	if (static_branch_likely(&pkey_disabled) &&
+	    !mmu_has_feature(MMU_FTR_RADIX_KUAP))
 		return;
 
 	if (old_thread->amr != new_thread->amr)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 25cc7d36b27d..67b2ed9bb9f3 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -321,6 +321,7 @@ config PPC_RADIX_MMU
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.20.1

