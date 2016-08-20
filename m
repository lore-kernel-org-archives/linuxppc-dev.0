Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJDdC1xyNzDrcG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 12:18:39 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so8972779pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:18:39 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
Date: Sat, 20 Aug 2016 20:24:23 +0800
Message-Id: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

The ckpt_regs usage in gpr32_set_common/gpr32_get_common()
will lead to cppcheck error.

[arch/powerpc/kernel/ptrace.c:2062]: (error) Uninitialized variable: ckpt_regs
[arch/powerpc/kernel/ptrace.c:2130]: (error) Uninitialized variable: ckpt_regs

A straightforward fix to clean it.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kernel/ptrace.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4f3c575..ae02377 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2046,21 +2046,23 @@ static const struct user_regset_view user_ppc_native_view = {
 static int gpr32_get_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 			    void *kbuf, void __user *ubuf, bool tm_active)
+#else
+			    void *kbuf, void __user *ubuf)
+#endif
 {
 	const unsigned long *regs = &target->thread.regs->gpr[0];
-	const unsigned long *ckpt_regs;
 	compat_ulong_t *k = kbuf;
 	compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
 	int i;
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
-#endif
 	if (tm_active) {
-		regs = ckpt_regs;
+		regs = &target->thread.ckpt_regs.gpr[0];
 	} else {
+#endif
 		if (target->thread.regs == NULL)
 			return -EIO;
 
@@ -2072,7 +2074,9 @@ static int gpr32_get_common(struct task_struct *target,
 			for (i = 14; i < 32; i++)
 				target->thread.regs->gpr[i] = NV_REG_POISON;
 		}
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	}
+#endif
 
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
@@ -2114,28 +2118,31 @@ static int gpr32_get_common(struct task_struct *target,
 static int gpr32_set_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 		     const void *kbuf, const void __user *ubuf, bool tm_active)
+#else
+		     const void *kbuf, const void __user *ubuf)
+#endif
 {
 	unsigned long *regs = &target->thread.regs->gpr[0];
-	unsigned long *ckpt_regs;
 	const compat_ulong_t *k = kbuf;
 	const compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
-#endif
-
 	if (tm_active) {
-		regs = ckpt_regs;
+		regs = &target->thread.ckpt_regs.gpr[0];
 	} else {
+#endif
 		regs = &target->thread.regs->gpr[0];
 
 		if (target->thread.regs == NULL)
 			return -EIO;
 
 		CHECK_FULL_REGS(target->thread.regs);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	}
+#endif
 
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
@@ -2218,7 +2225,11 @@ static int gpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 0);
+#else
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf);
+#endif
 }
 
 static int gpr32_set(struct task_struct *target,
@@ -2226,7 +2237,11 @@ static int gpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 0);
+#else
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf);
+#endif
 }
 
 /*
-- 
1.8.3.1
