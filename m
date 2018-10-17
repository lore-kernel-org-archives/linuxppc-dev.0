Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66A6ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:55:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D50214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJQ7luwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D50214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zjbq55KtzF3HQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 17:55:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJQ7luwD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="zJQ7luwD"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZjY12GybzF3HQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 17:52:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id ADF11C2B;
 Wed, 17 Oct 2018 02:44:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 02:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lFndIUG4GvPCzkvA6
 GfwFmCSYPZjRlFsH/85KZ6jQFI=; b=zJQ7luwDWWjL62kKUOmHhDXr6NV+rYv6H
 2dm4t4AS6pzG334DS4/bdxPs1qbUQzlIGCnVeJhBaSqcpxKvkMKMULQ19PBFDbmz
 FmTP5Tywz4ZfQhX6/+tlbn5kEmDRmHOICdTdlYuXyN8jYjz/6dq0ZxilJ8y1mJr7
 yUBJxze/4JowuMUFOqyahPtUU0KEr8fnld3/a0WVg1kyxs2a33Jm0l5/fzwuxV7q
 EfsmWU61oOXACmYiqXuy/X6E5C0oJasLWjGuu0O2qnlAwuVapbFVSlfasLxDXd3q
 bVdP/wknpG0BN5y3OeMs7OR0ZOarCYKoVhSwWrXuYB4D2el1GdT3Q==
X-ME-Sender: <xms:XNrGWzBHS3ansWdOegCxr2kKsQTx8TDed-RNH_fkmP6drxp6Z3wXVQ>
X-ME-Proxy: <xmx:XNrGWxVAJyEJe442WreUI7yrHO9Q-rAwhqhCk5exJ2093fJHahdLmg>
 <xmx:XNrGWxwd7t78qiGcj0xTPtUS4F8rotNaTwXje7D7N7-dkRLMJjTU8A>
 <xmx:XNrGW_PVMx-WAh5UZuUIRL-d5dk-75sjM9EIJ4xwdWKgPyIvZ9_Kuw>
 <xmx:XNrGWy7oFLsSG6bwng3ONnK2OvuKYNcy__ZOzxopB__JS5y5y55THg>
 <xmx:XNrGWwMbgPwHGRxdytlXtpAE0e18uwxkbrg1fUHuDoauGbJP6PG8DQ>
 <xmx:X9rGW_KLakITZBUNktgK5L_Mt7A55_VMaW9xNWsDE6cMVTeIqvsJPg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 58FE0102E9;
 Wed, 17 Oct 2018 02:44:42 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/64s: Kernel Hypervisor Restricted Access
 Prevention
Date: Wed, 17 Oct 2018 17:44:19 +1100
Message-Id: <20181017064422.26119-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
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
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kernel Hypervisor Restricted Access Prevention (KHRAP) utilises a feature
of the Radix MMU which disallows read and write access to userspace
addresses.  By utilising this, the kernel is prevented from accessing
user data from outside of trusted paths that perform proper safety checks,
such as copy_{to/from}_user() and friends.

Userspace access is disabled from early boot and is only enabled when:

	- exiting the kernel and entering userspace
	- performing an operation like copy_{to/from}_user()
	- context switching to a process that has access enabled

and similarly, access is disabled again when exiting userspace and entering
the kernel.

This feature has a slight performance impact which I roughly measured to be
4% slower (performing 1GB of 1 byte read()/write() syscalls), and is gated
behind the CONFIG_PPC_RADIX_KHRAP option for performance-critical builds.

This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=y) and
performing the following:

	echo ACCESS_USERSPACE > [debugfs]/provoke-crash/DIRECT

if enabled, this should send SIGSEGV to the thread.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
More detailed benchmarks soon, there's more optimisations here as well.

 arch/powerpc/include/asm/exception-64s.h | 17 +++++++
 arch/powerpc/include/asm/mmu.h           |  7 +++
 arch/powerpc/include/asm/reg.h           |  1 +
 arch/powerpc/include/asm/uaccess.h       | 63 +++++++++++++++++++++---
 arch/powerpc/kernel/dt_cpu_ftrs.c        |  4 ++
 arch/powerpc/kernel/entry_64.S           |  7 +++
 arch/powerpc/mm/fault.c                  |  9 ++++
 arch/powerpc/mm/pgtable-radix.c          |  2 +
 arch/powerpc/mm/pkeys.c                  |  7 ++-
 arch/powerpc/platforms/Kconfig.cputype   | 15 ++++++
 10 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..3b84a8050bae 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -240,6 +240,22 @@ BEGIN_FTR_SECTION_NESTED(941)						\
 	mtspr	SPRN_PPR,ra;						\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
 
+#define LOCK_AMR(reg)							\
+BEGIN_MMU_FTR_SECTION_NESTED(69)						\
+	LOAD_REG_IMMEDIATE(reg,AMR_LOCKED);				\
+	isync;				    				\
+	mtspr	SPRN_AMR,reg;						\
+	isync;								\
+END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KHRAP,MMU_FTR_RADIX_KHRAP,69)
+
+#define UNLOCK_AMR(reg)							\
+BEGIN_MMU_FTR_SECTION_NESTED(420)						\
+	li	reg,0;							\
+	isync;				    				\
+	mtspr	SPRN_AMR,reg;						\
+	isync;								\
+END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KHRAP,MMU_FTR_RADIX_KHRAP,420)
+
 /*
  * Get an SPR into a register if the CPU has the given feature
  */
@@ -500,6 +516,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
 	SAVE_PPR(area, r9);						   \
+	LOCK_AMR(r9);							   \
 4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
 	EXCEPTION_PROLOG_COMMON_3(n)					   \
 	ACCOUNT_STOLEN_TIME
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..504c8bfa2f9d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -107,6 +107,10 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
+/* Supports KHRAP (key 0 controlling userspace addresses) on radix
+ */
+#define MMU_FTR_RADIX_KHRAP		ASM_CONST(0x80000000)
+
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
@@ -143,6 +147,9 @@ enum {
 		MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_TYPE_RADIX |
+#endif
+#ifdef CONFIG_PPC_RADIX_KHRAP
+		MMU_FTR_RADIX_KHRAP |
 #endif
 		0,
 };
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 640a4d818772..8aa3540fbedc 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -246,6 +246,7 @@
 #define SPRN_DSCR	0x11
 #define SPRN_CFAR	0x1c	/* Come From Address Register */
 #define SPRN_AMR	0x1d	/* Authority Mask Register */
+#define   AMR_LOCKED	0xc000000000000000 /* Read & Write disabled */
 #define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
 #define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 15bea9a0f260..4a39ab000d05 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -62,6 +62,31 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 
 #endif
 
+static inline unsigned long unlock_user_access(void)
+{
+	unsigned long amr;
+
+	if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
+		amr = mfspr(SPRN_AMR);
+
+		isync();
+		mtspr(SPRN_AMR, 0);
+		isync();
+		return amr;
+	}
+
+	return 0;
+}
+
+static inline void lock_user_access(unsigned long amr)
+{
+	if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
+		isync();
+		mtspr(SPRN_AMR, AMR_LOCKED);
+		isync();
+	}
+}
+
 #define access_ok(type, addr, size)		\
 	(__chk_user_ptr(addr),			\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
@@ -140,7 +165,9 @@ extern long __put_user_bad(void);
 
 #define __put_user_size(x, ptr, size, retval)			\
 do {								\
+	unsigned long __amr;					\
 	retval = 0;						\
+	__amr = unlock_user_access();				\
 	switch (size) {						\
 	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
 	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
@@ -148,6 +175,7 @@ do {								\
 	  case 8: __put_user_asm2(x, ptr, retval); break;	\
 	  default: __put_user_bad();				\
 	}							\
+	lock_user_access(__amr);				\
 } while (0)
 
 #define __put_user_nocheck(x, ptr, size)			\
@@ -236,10 +264,12 @@ extern long __get_user_bad(void);
 
 #define __get_user_size(x, ptr, size, retval)			\
 do {								\
+	unsigned long __amr;					\
 	retval = 0;						\
 	__chk_user_ptr(ptr);					\
 	if (size > sizeof(x))					\
 		(x) = __get_user_bad();				\
+	__amr = unlock_user_access();				\
 	switch (size) {						\
 	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
 	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
@@ -247,6 +277,7 @@ do {								\
 	case 8: __get_user_asm2(x, ptr, retval);  break;	\
 	default: (x) = __get_user_bad();			\
 	}							\
+	lock_user_access(__amr);				\
 } while (0)
 
 /*
@@ -306,15 +337,20 @@ extern unsigned long __copy_tofrom_user(void __user *to,
 static inline unsigned long
 raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-	return __copy_tofrom_user(to, from, n);
+	unsigned long ret, amr;
+	amr = unlock_user_access();				\
+	ret = __copy_tofrom_user(to, from, n);			\
+	lock_user_access(amr);					\
+	return ret;						\
 }
 #endif /* __powerpc64__ */
 
 static inline unsigned long raw_copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
+	unsigned long ret, amr;
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret = 1;
+		ret = 1;
 
 		switch (n) {
 		case 1:
@@ -339,14 +375,18 @@ static inline unsigned long raw_copy_from_user(void *to,
 	}
 
 	barrier_nospec();
-	return __copy_tofrom_user((__force void __user *)to, from, n);
+	amr = unlock_user_access();
+	ret = __copy_tofrom_user((__force void __user *)to, from, n);
+	lock_user_access(amr);
+	return ret;
 }
 
 static inline unsigned long raw_copy_to_user(void __user *to,
 		const void *from, unsigned long n)
 {
+	unsigned long ret, amr;
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret = 1;
+		ret = 1;
 
 		switch (n) {
 		case 1:
@@ -366,17 +406,24 @@ static inline unsigned long raw_copy_to_user(void __user *to,
 			return 0;
 	}
 
-	return __copy_tofrom_user(to, (__force const void __user *)from, n);
+	amr = unlock_user_access();
+	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
+	lock_user_access(amr);
+	return ret;
 }
 
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
 static inline unsigned long clear_user(void __user *addr, unsigned long size)
 {
+	unsigned long amr, ret = size;
 	might_fault();
-	if (likely(access_ok(VERIFY_WRITE, addr, size)))
-		return __clear_user(addr, size);
-	return size;
+	if (likely(access_ok(VERIFY_WRITE, addr, size))) {
+		amr = unlock_user_access();
+		ret = __clear_user(addr, size);
+		lock_user_access(amr);
+	}
+	return ret;
 }
 
 extern long strncpy_from_user(char *dst, const char __user *src, long count);
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index f432054234a4..890fcb690ce7 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -337,6 +337,10 @@ static int __init feat_enable_mmu_radix(struct dt_cpu_feature *f)
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
 	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
 
+#ifdef CONFIG_PPC_RADIX_KHRAP
+	cur_cpu_spec->mmu_features |= MMU_FTR_RADIX_KHRAP;
+#endif
+
 	return 1;
 #endif
 	return 0;
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693adff2a..090f72cbb02d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -286,6 +286,9 @@ BEGIN_FTR_SECTION
 	HMT_MEDIUM_LOW
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
+	/* headed back to userspace, so unlock the AMR */
+	UNLOCK_AMR(r2)
+
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -965,6 +968,10 @@ BEGIN_FTR_SECTION
 	ld	r2,_PPR(r1)
 	mtspr	SPRN_PPR,r2
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
+
+	/* headed back to userspace, so unlock the AMR */
+	UNLOCK_AMR(r2)
+
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d51cf5f4e45e..697dee2f665b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -462,6 +462,15 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_key_fault_exception(regs, address,
 					       get_mm_addr_key(mm, address));
 
+	if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
+		if (unlikely(!is_user &&
+			     (error_code & DSISR_PROTFAULT) &&
+			     (mfspr(SPRN_AMR) & AMR_LOCKED))) {
+			printk(KERN_CRIT "Kernel attempted to access user data"
+			       " unsafely, possible security vulnerability\n");
+			return bad_area_nosemaphore(regs, address);
+		}
+	}
 	/*
 	 * We want to do this outside mmap_sem, because reading code around nip
 	 * can result in fault, which will cause a deadlock when called with
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c879979faa73..2e88851916e0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -608,6 +609,7 @@ void __init radix__early_init_mmu(void)
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
 		radix_init_amor();
+		lock_user_access(0);
 	} else {
 		radix_init_pseries();
 	}
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b271b283c785..4d58426af3e3 100644
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
+	    !mmu_has_feature(MMU_FTR_RADIX_KHRAP))
 		return;
 
 	/*
@@ -280,7 +282,8 @@ void thread_pkey_regs_save(struct thread_struct *thread)
 void thread_pkey_regs_restore(struct thread_struct *new_thread,
 			      struct thread_struct *old_thread)
 {
-	if (static_branch_likely(&pkey_disabled))
+	if (static_branch_likely(&pkey_disabled) &&
+	    !mmu_has_feature(MMU_FTR_RADIX_KHRAP))
 		return;
 
 	if (old_thread->amr != new_thread->amr)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f4e2c5729374..6cd32ce6760c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -351,6 +351,21 @@ config PPC_RADIX_MMU_DEFAULT
 
 	  If you're unsure, say Y.
 
+config PPC_RADIX_KHRAP
+	bool "Kernel Hypervisor Restricted Access Prevention on Radix"
+	depends on PPC_RADIX_MMU
+	default y
+	help
+	  Enable support for Kernel Hypervisor Restricted Access Prevention
+	  (KHRAP) when using the Radix MMU.  KHRAP is a security feature
+	  preventing the kernel from directly accessing userspace data
+	  without going through the proper checks.
+
+	  KHRAP has a minor performance impact on context switching and can be
+	  disabled at boot time using the "nosmap" kernel command line option.
+
+	  If you're unsure, say Y.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
-- 
2.19.1

