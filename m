Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87381C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 10:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FC52081C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434bnl1zclzDq6N
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 21:03:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434bLw2L7WzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 20:43:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 434bLr3Mpcz9vBmL;
 Wed, 28 Nov 2018 10:43:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id mrRgXMFq3uZz; Wed, 28 Nov 2018 10:43:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 434bLr2nFsz9vBmJ;
 Wed, 28 Nov 2018 10:43:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 470A98B85D;
 Wed, 28 Nov 2018 10:43:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3WcheBbXgibA; Wed, 28 Nov 2018 10:43:33 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 222A68B853;
 Wed, 28 Nov 2018 10:43:33 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 1953669B05; Wed, 28 Nov 2018 09:43:33 +0000 (UTC)
Message-Id:
 <6f365601e65798aee72f149f1e086a9c3afc6be2.1543356926.git.christophe.leroy@c-s.fr>
In-Reply-To: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 08/11] powerpc/64s: Implement KUAP for Radix MMU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Wed, 28 Nov 2018 09:43:33 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20181128094333.qMmnrvAmcSGN4_JhLkLKryhOEt43CXjzuwo_ctb4kcQ@z>

From: Russell Currey <ruscur@russell.cc>

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
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/kup-radix.h | 36 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h       | 14 ++++++++--
 arch/powerpc/include/asm/kup.h                 |  3 +++
 arch/powerpc/include/asm/mmu.h                 |  9 ++++++-
 arch/powerpc/include/asm/reg.h                 |  1 +
 arch/powerpc/mm/pgtable-radix.c                | 12 +++++++++
 arch/powerpc/mm/pkeys.c                        |  7 +++--
 arch/powerpc/platforms/Kconfig.cputype         |  1 +
 8 files changed, 78 insertions(+), 5 deletions(-)
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
index 4d971ca1e69b..d92614c66d87 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -264,8 +264,18 @@ BEGIN_FTR_SECTION_NESTED(943)						\
 	std	ra,offset(r13);						\
 END_FTR_SECTION_NESTED(ftr,ftr,943)
 
-#define LOCK_USER_ACCESS(reg)
-#define UNLOCK_USER_ACCESS(reg)
+#define LOCK_USER_ACCESS(reg)							\
+BEGIN_MMU_FTR_SECTION_NESTED(944)					\
+	LOAD_REG_IMMEDIATE(reg,AMR_LOCKED);				\
+	mtspr	SPRN_AMR,reg;						\
+END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KUAP,MMU_FTR_RADIX_KUAP,944)
+
+#define UNLOCK_USER_ACCESS(reg)							\
+BEGIN_MMU_FTR_SECTION_NESTED(945)					\
+	li	reg,0;							\
+	mtspr	SPRN_AMR,reg;						\
+	isync;								\
+END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KUAP,MMU_FTR_RADIX_KUAP,945)
 
 #define EXCEPTION_PROLOG_0(area)					\
 	GET_PACA(r13);							\
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index f7262f4c427e..d4dd242251bd 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -5,6 +5,9 @@
 #ifdef CONFIG_PPC_8xx
 #include <asm/nohash/32/kup-8xx.h>
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
index de52c3166ba4..d9598e6790d8 100644
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
index 45aa9e501e76..6490067952a0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -550,6 +551,17 @@ void setup_kuep(bool disabled)
 	mtspr(SPRN_IAMR, (1ul << 62));
 }
 
+void __init setup_kuap(bool disabled)
+{
+	if (disabled)
+		return;
+
+	pr_info("Activating Kernel Userspace Access Prevention\n");
+
+	cur_cpu_spec->mmu_features |= MMU_FTR_RADIX_KUAP;
+	mtspr(SPRN_AMR, AMR_LOCKED);
+}
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
index e6831d0ec159..5fbfa041194d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -335,6 +335,7 @@ config PPC_RADIX_MMU
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.13.3

