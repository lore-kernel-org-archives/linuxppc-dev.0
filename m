Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A25BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:35:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE262064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tNXw2CB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE262064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HrzH3f1FzDqD8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:35:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="tNXw2CB1"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Hrs747M4zDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 19:30:33 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Hrrx0PzzzB09Zk;
 Mon, 11 Mar 2019 09:30:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=tNXw2CB1; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id W1eT8STDEETF; Mon, 11 Mar 2019 09:30:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrrw6H16zB09ZD;
 Mon, 11 Mar 2019 09:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552293024; bh=Ae91o23bEFmG8egHA/wmKZ00Ft185RcK3EPxW/eyOWw=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=tNXw2CB1iXaK1c4J4w07jwCF1lmjxHbW1jZrIayzGKJLAoe1w0R+e4X9sL3iqZT2I
 jklmXCj1Y0yG6C4uvC3IcFbUK7PiuMc0JKuOlkk0i+d50dUXJEXLbbZOzVKOr+R4tT
 Vr1qzxCOhY12krpcrgcKaj0Wj4/mjQaqui3G9NEk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 420AF8B813;
 Mon, 11 Mar 2019 09:30:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4bPRiJdJUfrF; Mon, 11 Mar 2019 09:30:29 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DEB38B7FE;
 Mon, 11 Mar 2019 09:30:29 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 044D96FA08; Mon, 11 Mar 2019 08:30:29 +0000 (UTC)
Message-Id: <0c5627a4acafc6bad85429bba11a14d9e5ea6ef3.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/10] powerpc/mm: Detect bad KUAP faults (Squash of v5
 series)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Mon, 11 Mar 2019 08:30:29 +0000 (UTC)
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

This is a squash of the v5 series, not intended to be merged.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 arch/powerpc/include/asm/book3s/64/kup-radix.h  | 119 ++++++++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h        |   2 +
 arch/powerpc/include/asm/feature-fixups.h       |   3 +
 arch/powerpc/include/asm/futex.h                |   4 +
 arch/powerpc/include/asm/kup.h                  |  46 +++++++++
 arch/powerpc/include/asm/mmu.h                  |  10 +-
 arch/powerpc/include/asm/ptrace.h               |  11 ++-
 arch/powerpc/include/asm/uaccess.h              |  38 ++++++--
 arch/powerpc/kernel/asm-offsets.c               |   4 +
 arch/powerpc/kernel/entry_64.S                  |  27 +++++-
 arch/powerpc/kernel/exceptions-64s.S            |   3 +
 arch/powerpc/kernel/idle_book3s.S               |  39 ++++++++
 arch/powerpc/kernel/setup_64.c                  |  10 ++
 arch/powerpc/lib/checksum_wrappers.c            |   4 +
 arch/powerpc/lib/code-patching.c                |   4 +-
 arch/powerpc/mm/fault.c                         |  49 ++++++++--
 arch/powerpc/mm/init-common.c                   |  26 ++++++
 arch/powerpc/mm/init_32.c                       |   3 +
 arch/powerpc/mm/pgtable-radix.c                 |  30 +++++-
 arch/powerpc/mm/pkeys.c                         |   1 +
 arch/powerpc/platforms/Kconfig.cputype          |  33 +++++++
 22 files changed, 440 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h
 create mode 100644 arch/powerpc/include/asm/kup.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a422560fbc15..c0431a25c57b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2823,11 +2823,11 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
-	nosmap		[X86]
+	nosmap		[X86,PPC]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-	nosmep		[X86]
+	nosmep		[X86,PPC]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
 
diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
new file mode 100644
index 000000000000..8d2ddc61e92e
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
+#define _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
+
+#include <linux/const.h>
+
+#define AMR_KUAP_BLOCK_READ	UL(0x4000000000000000)
+#define AMR_KUAP_BLOCK_WRITE	UL(0x8000000000000000)
+#define AMR_KUAP_BLOCKED	(AMR_KUAP_BLOCK_READ | AMR_KUAP_BLOCK_WRITE)
+#define AMR_KUAP_SHIFT		62
+
+#ifdef __ASSEMBLY__
+
+.macro kuap_restore_amr	gpr
+#ifdef CONFIG_PPC_KUAP
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	ld	\gpr, STACK_REGS_KUAP(r1)
+	mtspr	SPRN_AMR, \gpr
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+.macro kuap_check_amr gpr1 gpr2
+#ifdef CONFIG_PPC_KUAP_DEBUG
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	mfspr	\gpr1, SPRN_AMR
+	li	\gpr2, (AMR_KUAP_BLOCKED >> AMR_KUAP_SHIFT)
+	sldi	\gpr2, \gpr2, AMR_KUAP_SHIFT
+999:	tdne	\gpr1, \gpr2
+	EMIT_BUG_ENTRY 999b,__FILE__,__LINE__, \
+		(BUGFLAG_WARNING|BUGFLAG_ONCE)
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+.macro kuap_save_amr_and_lock gpr1, gpr2, use_cr, msr_pr_cr
+#ifdef CONFIG_PPC_KUAP
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	.ifnb \msr_pr_cr
+	bne	\msr_pr_cr, 99f
+	.endif
+	mfspr	\gpr1, SPRN_AMR
+	std	\gpr1, STACK_REGS_KUAP(r1)
+	li	\gpr2, (AMR_KUAP_BLOCKED >> AMR_KUAP_SHIFT)
+	sldi	\gpr2, \gpr2, AMR_KUAP_SHIFT
+	cmpd	\use_cr, \gpr1, \gpr2
+	beq	\use_cr, 99f
+	// We don't isync here because we very recently entered via rfid
+	mtspr	SPRN_AMR, \gpr2
+	isync
+99:
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+#else /* !__ASSEMBLY__ */
+
+#ifdef CONFIG_PPC_KUAP
+
+#include <asm/reg.h>
+
+/*
+ * We support individually allowing read or write, but we don't support nesting
+ * because that would require an expensive read/modify write of the AMR.
+ */
+
+static inline void set_kuap(unsigned long value)
+{
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return;
+
+	/*
+	 * ISA v3.0B says we need a CSI (Context Synchronising Instruction) both
+	 * before and after the move to AMR. See table 6 on page 1134.
+	 */
+	isync();
+	mtspr(SPRN_AMR, value);
+	isync();
+}
+
+static inline void allow_user_access(void __user *to, const void __user *from,
+				     unsigned long size)
+{
+	set_kuap(0);
+}
+
+static inline void allow_read_from_user(const void __user *from, unsigned long size)
+{
+	set_kuap(AMR_KUAP_BLOCK_WRITE);
+}
+
+static inline void allow_write_to_user(void __user *to, unsigned long size)
+{
+	set_kuap(AMR_KUAP_BLOCK_READ);
+}
+
+static inline void prevent_user_access(void __user *to, const void __user *from,
+				       unsigned long size)
+{
+	set_kuap(AMR_KUAP_BLOCKED);
+}
+
+static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write)
+{
+	if (mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
+	    ((is_write && (regs->kuap & AMR_KUAP_BLOCK_WRITE)) ||
+	     (!is_write && (regs->kuap & AMR_KUAP_BLOCK_READ))))
+	{
+		WARN(true, "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_PPC_KUAP */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H */
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 937bb630093f..bef4e05a6823 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -497,6 +497,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	RESTORE_CTR(r1, area);						   \
 	b	bad_stack;						   \
 3:	EXCEPTION_PROLOG_COMMON_1();					   \
+	kuap_save_amr_and_lock r9, r10, cr1, cr0;			   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
 	SAVE_PPR(area, r9);						   \
@@ -691,6 +692,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  */
 #define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
 	EXCEPTION_PROLOG_COMMON_1();				\
+	kuap_save_amr_and_lock r9, r10, cr1;			\
 	EXCEPTION_PROLOG_COMMON_2(area);			\
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 40a6c9261a6b..f6fc31f8baff 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -100,6 +100,9 @@ label##5:							\
 #define END_MMU_FTR_SECTION(msk, val)		\
 	END_MMU_FTR_SECTION_NESTED(msk, val, 97)
 
+#define END_MMU_FTR_SECTION_NESTED_IFSET(msk, label)	\
+	END_MMU_FTR_SECTION_NESTED((msk), (msk), label)
+
 #define END_MMU_FTR_SECTION_IFSET(msk)	END_MMU_FTR_SECTION((msk), (msk))
 #define END_MMU_FTR_SECTION_IFCLR(msk)	END_MMU_FTR_SECTION((msk), 0)
 
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 88b38b37c21b..3a6aa57b9d90 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -35,6 +35,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	allow_write_to_user(uaddr, sizeof(*uaddr));
 	pagefault_disable();
 
 	switch (op) {
@@ -62,6 +63,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	if (!ret)
 		*oval = oldval;
 
+	prevent_write_to_user(uaddr, sizeof(*uaddr));
 	return ret;
 }
 
@@ -75,6 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	allow_write_to_user(uaddr, sizeof(*uaddr));
         __asm__ __volatile__ (
         PPC_ATOMIC_ENTRY_BARRIER
 "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
@@ -95,6 +98,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
         : "cc", "memory");
 
 	*uval = prev;
+	prevent_write_to_user(uaddr, sizeof(*uaddr));
         return ret;
 }
 
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
new file mode 100644
index 000000000000..ccbd2a249575
--- /dev/null
+++ b/arch/powerpc/include/asm/kup.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_H_
+#define _ASM_POWERPC_KUP_H_
+
+#ifdef CONFIG_PPC64
+#include <asm/book3s/64/kup-radix.h>
+#endif
+
+#ifndef __ASSEMBLY__
+
+#include <asm/pgtable.h>
+
+void setup_kup(void);
+
+#ifdef CONFIG_PPC_KUEP
+void setup_kuep(bool disabled);
+#else
+static inline void setup_kuep(bool disabled) { }
+#endif /* CONFIG_PPC_KUEP */
+
+#ifdef CONFIG_PPC_KUAP
+void setup_kuap(bool disabled);
+#else
+static inline void setup_kuap(bool disabled) { }
+static inline void allow_user_access(void __user *to, const void __user *from,
+				     unsigned long size) { }
+static inline void prevent_user_access(void __user *to, const void __user *from,
+				       unsigned long size) { }
+static inline void allow_read_from_user(const void __user *from, unsigned long size) {}
+static inline void allow_write_to_user(void __user *to, unsigned long size) {}
+static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write) { return false; }
+#endif /* CONFIG_PPC_KUAP */
+
+static inline void prevent_read_from_user(const void __user *from, unsigned long size)
+{
+	prevent_user_access(NULL, from, size);
+}
+
+static inline void prevent_write_to_user(void __user *to, unsigned long size)
+{
+	prevent_user_access(to, NULL, size);
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_KUP_H_ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d34ad1657d7b..59acb4418164 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -107,6 +107,11 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
+/*
+ * Supports KUAP (key 0 controlling userspace addresses) on radix
+ */
+#define MMU_FTR_RADIX_KUAP		ASM_CONST(0x80000000)
+
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
@@ -164,7 +169,10 @@ enum {
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
 
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 64271e562fed..6f047730e642 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -52,10 +52,17 @@ struct pt_regs
 		};
 	};
 
+	union {
+		struct {
 #ifdef CONFIG_PPC64
-	unsigned long ppr;
-	unsigned long __pad;	/* Maintain 16 byte interrupt stack alignment */
+			unsigned long ppr;
+#endif
+#ifdef CONFIG_PPC_KUAP
+			unsigned long kuap;
 #endif
+		};
+		unsigned long __pad[2];	/* Maintain 16 byte interrupt stack alignment */
+	};
 };
 #endif
 
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4d6d905e9138..76f34346b642 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -6,6 +6,7 @@
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/extable.h>
+#include <asm/kup.h>
 
 /*
  * The fs value determines whether argument validity checking should be
@@ -140,6 +141,7 @@ extern long __put_user_bad(void);
 #define __put_user_size(x, ptr, size, retval)			\
 do {								\
 	retval = 0;						\
+	allow_write_to_user(ptr, size);				\
 	switch (size) {						\
 	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
 	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
@@ -147,6 +149,7 @@ do {								\
 	  case 8: __put_user_asm2(x, ptr, retval); break;	\
 	  default: __put_user_bad();				\
 	}							\
+	prevent_write_to_user(ptr, size);			\
 } while (0)
 
 #define __put_user_nocheck(x, ptr, size)			\
@@ -239,6 +242,7 @@ do {								\
 	__chk_user_ptr(ptr);					\
 	if (size > sizeof(x))					\
 		(x) = __get_user_bad();				\
+	allow_read_from_user(ptr, size);			\
 	switch (size) {						\
 	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
 	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
@@ -246,6 +250,7 @@ do {								\
 	case 8: __get_user_asm2(x, ptr, retval);  break;	\
 	default: (x) = __get_user_bad();			\
 	}							\
+	prevent_read_from_user(ptr, size);			\
 } while (0)
 
 /*
@@ -305,15 +310,21 @@ extern unsigned long __copy_tofrom_user(void __user *to,
 static inline unsigned long
 raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-	return __copy_tofrom_user(to, from, n);
+	unsigned long ret;
+
+	allow_user_access(to, from, n);
+	ret = __copy_tofrom_user(to, from, n);
+	prevent_user_access(to, from, n);
+	return ret;
 }
 #endif /* __powerpc64__ */
 
 static inline unsigned long raw_copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
+	unsigned long ret;
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret = 1;
+		ret = 1;
 
 		switch (n) {
 		case 1:
@@ -338,14 +349,18 @@ static inline unsigned long raw_copy_from_user(void *to,
 	}
 
 	barrier_nospec();
-	return __copy_tofrom_user((__force void __user *)to, from, n);
+	allow_read_from_user(from, n);
+	ret = __copy_tofrom_user((__force void __user *)to, from, n);
+	prevent_read_from_user(from, n);
+	return ret;
 }
 
 static inline unsigned long raw_copy_to_user(void __user *to,
 		const void *from, unsigned long n)
 {
+	unsigned long ret;
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret = 1;
+		ret = 1;
 
 		switch (n) {
 		case 1:
@@ -365,17 +380,24 @@ static inline unsigned long raw_copy_to_user(void __user *to,
 			return 0;
 	}
 
-	return __copy_tofrom_user(to, (__force const void __user *)from, n);
+	allow_write_to_user(to, n);
+	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
+	prevent_write_to_user(to, n);
+	return ret;
 }
 
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
 static inline unsigned long clear_user(void __user *addr, unsigned long size)
 {
+	unsigned long ret = size;
 	might_fault();
-	if (likely(access_ok(addr, size)))
-		return __clear_user(addr, size);
-	return size;
+	if (likely(access_ok(addr, size))) {
+		allow_write_to_user(addr, size);
+		ret = __clear_user(addr, size);
+		prevent_write_to_user(addr, size);
+	}
+	return ret;
 }
 
 extern long strncpy_from_user(char *dst, const char __user *src, long count);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 86a61e5f8285..66202e02fee2 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -332,6 +332,10 @@ int main(void)
 	STACK_PT_REGS_OFFSET(_PPR, ppr);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_KUAP
+	STACK_PT_REGS_OFFSET(STACK_REGS_KUAP, kuap);
+#endif
+
 #if defined(CONFIG_PPC32)
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 15c67d2c0534..020d0ad9aa51 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -46,6 +46,7 @@
 #include <asm/exception-64e.h>
 #endif
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 /*
  * System calls.
@@ -120,6 +121,9 @@ END_BTB_FLUSH_SECTION
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+
+	kuap_check_amr r10 r11
+
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(CONFIG_PPC_SPLPAR)
 BEGIN_FW_FTR_SECTION
 	beq	33f
@@ -275,6 +279,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 
+	kuap_check_amr r10 r11
+
 #ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * Clear MSR_RI, MSR_EE is already and remains disabled. We could do
@@ -296,6 +302,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	std	r8, PACATMSCRATCH(r13)
 #endif
 
+	/*
+	 * We don't need to restore AMR on the way back to userspace for KUAP.
+	 * The value of AMR only matters while we're in the kernel.
+	 */
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -306,8 +316,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 
-	/* exit to kernel */
-1:	ld	r2,GPR2(r1)
+1:	/* exit to kernel */
+	kuap_restore_amr r2
+
+	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
@@ -594,6 +606,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	kuap_check_amr r9 r10
+
 	FLUSH_COUNT_CACHE
 
 	/*
@@ -942,6 +956,8 @@ fast_exception_return:
 	ld	r4,_XER(r1)
 	mtspr	SPRN_XER,r4
 
+	kuap_check_amr r5 r6
+
 	REST_8GPRS(5, r1)
 
 	andi.	r0,r3,MSR_RI
@@ -974,6 +990,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
 
+	/*
+	 * We don't need to restore AMR on the way back to userspace for KUAP.
+	 * The value of AMR only matters while we're in the kernel.
+	 */
 	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
@@ -1006,6 +1026,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r0,GPR0(r1)
 	ld	r2,GPR2(r1)
 	ld	r3,GPR3(r1)
+
+	kuap_restore_amr r4
+
 	ld	r4,GPR4(r1)
 	ld	r1,GPR1(r1)
 	RFI_TO_KERNEL
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a5b8fbae56a0..99b1bc4e190b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,6 +19,7 @@
 #include <asm/cpuidle.h>
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 /*
  * There are a few constraints to be concerned with.
@@ -309,6 +310,7 @@ TRAMP_REAL_BEGIN(machine_check_common_early)
 	mfspr	r11,SPRN_DSISR		/* Save DSISR */
 	std	r11,_DSISR(r1)
 	std	r9,_CCR(r1)		/* Save CR in stackframe */
+	kuap_save_amr_and_lock r9, r10, cr1
 	/* Save r9 through r13 from EXMC save area to stack frame. */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
 	mfmsr	r11			/* get MSR value */
@@ -1097,6 +1099,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
 	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
 	EXCEPTION_PROLOG_COMMON_1()
+	/* We don't touch AMR here, we never go to virtual mode */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 7f5ac2e8581b..4a860d3b9229 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -170,6 +170,12 @@ core_idle_lock_held:
 	bne-	core_idle_lock_held
 	blr
 
+/* Reuse some unused pt_regs slots for AMR/IAMR/UAMOR/UAMOR */
+#define PNV_POWERSAVE_AMR	_TRAP
+#define PNV_POWERSAVE_IAMR	_DAR
+#define PNV_POWERSAVE_UAMOR	_DSISR
+#define PNV_POWERSAVE_AMOR	RESULT
+
 /*
  * Pass requested state in r3:
  *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
@@ -200,6 +206,20 @@ pnv_powersave_common:
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
 	SAVE_NVGPRS(r1)
+
+BEGIN_FTR_SECTION
+	mfspr	r4, SPRN_AMR
+	mfspr	r5, SPRN_IAMR
+	mfspr	r6, SPRN_UAMOR
+	std	r4, PNV_POWERSAVE_AMR(r1)
+	std	r5, PNV_POWERSAVE_IAMR(r1)
+	std	r6, PNV_POWERSAVE_UAMOR(r1)
+BEGIN_FTR_SECTION_NESTED(42)
+	mfspr	r7, SPRN_AMOR
+	std	r7, PNV_POWERSAVE_AMOR(r1)
+END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	mfcr	r5
 	std	r5,_CCR(r1)
 	std	r1,PACAR1(r13)
@@ -924,6 +944,25 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
+
+BEGIN_FTR_SECTION
+	/* These regs were saved in pnv_powersave_common() */
+	ld	r4, PNV_POWERSAVE_AMR(r1)
+	ld	r5, PNV_POWERSAVE_IAMR(r1)
+	ld	r6, PNV_POWERSAVE_UAMOR(r1)
+	mtspr	SPRN_AMR, r4
+	mtspr	SPRN_IAMR, r5
+	mtspr	SPRN_UAMOR, r6
+BEGIN_FTR_SECTION_NESTED(42)
+	ld	r7, PNV_POWERSAVE_AMOR(r1)
+	mtspr	SPRN_AMOR, r7
+END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
+	/*
+	 * We don't need an isync here after restoring IAMR because the upcoming
+	 * mtmsrd is execution synchronizing.
+	 */
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	ld	r4,PACAKMSR(r13)
 	ld	r5,_LINK(r1)
 	ld	r6,_CCR(r1)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index daa361fc6a24..72358a5022fe 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/cputhreads.h>
 #include <asm/hw_irq.h>
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 #include "setup.h"
 
@@ -331,6 +332,12 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	configure_exceptions();
 
+	/*
+	 * Configure Kernel Userspace Protection. This needs to happen before
+	 * feature fixups for platforms that implement this using features.
+	 */
+	setup_kup();
+
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
 	setup_feature_keys();
@@ -383,6 +390,9 @@ void early_setup_secondary(void)
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
 
+	/* Perform any KUP setup that is per-cpu */
+	setup_kup();
+
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index 890d4ddd91d6..bb9307ce2440 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -29,6 +29,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 	unsigned int csum;
 
 	might_sleep();
+	allow_read_from_user(src, len);
 
 	*err_ptr = 0;
 
@@ -60,6 +61,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 	}
 
 out:
+	prevent_read_from_user(src, len);
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
@@ -70,6 +72,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 	unsigned int csum;
 
 	might_sleep();
+	allow_write_to_user(dst, len);
 
 	*err_ptr = 0;
 
@@ -97,6 +100,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 	}
 
 out:
+	prevent_write_to_user(dst, len);
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 506413a2c25e..42fdadac6587 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -26,9 +26,9 @@
 static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 			       unsigned int *patch_addr)
 {
-	int err;
+	int err = 0;
 
-	__put_user_size(instr, patch_addr, 4, err);
+	__put_user_asm(instr, patch_addr, err, "stw");
 	if (err)
 		return err;
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 887f11bcf330..b5d3578d9f65 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -44,6 +44,7 @@
 #include <asm/mmu_context.h>
 #include <asm/siginfo.h>
 #include <asm/debug.h>
+#include <asm/kup.h>
 
 static inline bool notify_page_fault(struct pt_regs *regs)
 {
@@ -223,19 +224,46 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr,
 }
 
 /* Is this a bad kernel fault ? */
-static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
-			     unsigned long address)
+static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
+			     unsigned long address, bool is_write)
 {
+	int is_exec = TRAP(regs) == 0x400;
+
 	/* NX faults set DSISR_PROTFAULT on the 8xx, DSISR_NOEXEC_OR_G on others */
 	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT |
 				      DSISR_PROTFAULT))) {
-		printk_ratelimited(KERN_CRIT "kernel tried to execute"
-				   " exec-protected page (%lx) -"
-				   "exploit attempt? (uid: %d)\n",
-				   address, from_kuid(&init_user_ns,
-						      current_uid()));
+		pr_crit_ratelimited("kernel tried to execute %s page (%lx) - exploit attempt? (uid: %d)\n",
+				    address >= TASK_SIZE ? "exec-protected" : "user",
+				    address,
+				    from_kuid(&init_user_ns, current_uid()));
+
+		// Kernel exec fault is always bad
+		return true;
 	}
-	return is_exec || (address >= TASK_SIZE);
+
+	if (!is_exec && address < TASK_SIZE && (error_code & DSISR_PROTFAULT) &&
+	    !search_exception_tables(regs->nip)) {
+		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - exploit attempt? (uid: %d)\n",
+				    address,
+				    from_kuid(&init_user_ns, current_uid()));
+	}
+
+	// Kernel fault on kernel address is bad
+	if (address >= TASK_SIZE)
+		return true;
+
+	// Fault on user outside of certain regions (eg. copy_tofrom_user()) is bad
+	if (!search_exception_tables(regs->nip))
+		return true;
+
+	// Read/write fault in a valid region (the exception table search passed
+	// above), but blocked by KUAP is bad, it can never succeed.
+	if (bad_kuap_fault(regs, is_write))
+		return true;
+
+	// What's left? Kernel fault on user in well defined regions (extable
+	// matched), and allowed by KUAP in the faulting context.
+	return false;
 }
 
 static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
@@ -455,9 +483,10 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	/*
 	 * The kernel should never take an execute fault nor should it
-	 * take a page fault to a kernel address.
+	 * take a page fault to a kernel address or a page fault to a user
+	 * address outside of dedicated places
 	 */
-	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
+	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address, is_write)))
 		return SIGSEGV;
 
 	/*
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 1e6910eb70ed..ecaedfff9992 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -24,6 +24,32 @@
 #include <linux/string.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/kup.h>
+
+static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
+static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
+
+static int __init parse_nosmep(char *p)
+{
+	disable_kuep = true;
+	pr_warn("Disabling Kernel Userspace Execution Prevention\n");
+	return 0;
+}
+early_param("nosmep", parse_nosmep);
+
+static int __init parse_nosmap(char *p)
+{
+	disable_kuap = true;
+	pr_warn("Disabling Kernel Userspace Access Protection\n");
+	return 0;
+}
+early_param("nosmap", parse_nosmap);
+
+void __init setup_kup(void)
+{
+	setup_kuep(disable_kuep);
+	setup_kuap(disable_kuap);
+}
 
 #define CTOR(shift) static void ctor_##shift(void *addr) \
 {							\
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 41a3513cadc9..80cc97cd8878 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -45,6 +45,7 @@
 #include <asm/tlb.h>
 #include <asm/sections.h>
 #include <asm/hugetlb.h>
+#include <asm/kup.h>
 
 #include "mmu_decl.h"
 
@@ -178,6 +179,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	setup_kup();
+
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index dced3cd241c2..88861fb5c9e6 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -535,8 +536,15 @@ static void radix_init_amor(void)
 	mtspr(SPRN_AMOR, (3ul << 62));
 }
 
-static void radix_init_iamr(void)
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
 {
+	if (disabled || !early_radix_enabled())
+		return;
+
+	if (smp_processor_id() == boot_cpuid)
+		pr_info("Activating Kernel Userspace Execution Prevention\n");
+
 	/*
 	 * Radix always uses key0 of the IAMR to determine if an access is
 	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
@@ -544,6 +552,24 @@ static void radix_init_iamr(void)
 	 */
 	mtspr(SPRN_IAMR, (1ul << 62));
 }
+#endif
+
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
+	/* Make sure userspace can't change the AMR */
+	mtspr(SPRN_UAMOR, 0);
+	mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
+}
+#endif
 
 void __init radix__early_init_mmu(void)
 {
@@ -605,7 +631,6 @@ void __init radix__early_init_mmu(void)
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 
-	radix_init_iamr();
 	radix_init_pgtable();
 	/* Switch to the guard PID before turning on MMU */
 	radix__switch_mmu_context(NULL, &init_mm);
@@ -627,7 +652,6 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
-	radix_init_iamr();
 
 	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 587807763737..ae7fca40e5b3 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -7,6 +7,7 @@
 
 #include <asm/mman.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 #include <asm/setup.h>
 #include <linux/pkeys.h>
 #include <linux/of_device.h>
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 842b2c7e156a..5e53b9fd62aa 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -326,6 +326,8 @@ config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
@@ -345,6 +347,37 @@ config PPC_RADIX_MMU_DEFAULT
 
 	  If you're unsure, say Y.
 
+config PPC_HAVE_KUEP
+	bool
+
+config PPC_KUEP
+	bool "Kernel Userspace Execution Prevention"
+	depends on PPC_HAVE_KUEP
+	default y
+	help
+	  Enable support for Kernel Userspace Execution Prevention (KUEP)
+
+	  If you're unsure, say Y.
+
+config PPC_HAVE_KUAP
+	bool
+
+config PPC_KUAP
+	bool "Kernel Userspace Access Protection"
+	depends on PPC_HAVE_KUAP
+	default y
+	help
+	  Enable support for Kernel Userspace Access Protection (KUAP)
+
+	  If you're unsure, say Y.
+
+config PPC_KUAP_DEBUG
+	bool "Extra debugging for Kernel Userspace Access Protection"
+	depends on PPC_HAVE_KUAP && PPC_RADIX_MMU
+	help
+	  Add extra debugging for Kernel Userspace Access Protection (KUAP)
+	  If you're unsure, say N.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
-- 
2.13.3

