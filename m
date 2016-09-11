Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXXsw6XZkzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 13:12:20 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so7412207pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 20:12:20 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common()
Date: Sun, 11 Sep 2016 21:44:13 +0800
Message-Id: <1473601453-9660-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

The ckpt_regs usage in gpr32_set_common/gpr32_get_common() will lead to
following cppcheck error at ifndef CONFIG_PPC_TRANSACTIONAL_MEM case:

[arch/powerpc/kernel/ptrace.c:2062]:
(error) Uninitialized variable: ckpt_regs
[arch/powerpc/kernel/ptrace.c:2130]:
(error) Uninitialized variable: ckpt_regs

The problem is due to gpr32_set_common() used ckpt_regs variable which
only makes sense at #ifdef CONFIG_PPC_TRANSACTIONAL_MEM.

This patch fix this issue by passing in "regs" parameter instead.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kernel/ptrace.c | 74 +++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index bf91658..74eadb4 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2065,33 +2065,12 @@ static const struct user_regset_view user_ppc_native_view = {
 static int gpr32_get_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
-			    void *kbuf, void __user *ubuf, bool tm_active)
+			    void *kbuf, void __user *ubuf,
+			    unsigned long *regs)
 {
-	const unsigned long *regs = &target->thread.regs->gpr[0];
-	const unsigned long *ckpt_regs;
 	compat_ulong_t *k = kbuf;
 	compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
-	int i;
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
-#endif
-	if (tm_active) {
-		regs = ckpt_regs;
-	} else {
-		if (target->thread.regs == NULL)
-			return -EIO;
-
-		if (!FULL_REGS(target->thread.regs)) {
-			/*
-			 * We have a partial register set.
-			 * Fill 14-31 with bogus values.
-			 */
-			for (i = 14; i < 32; i++)
-				target->thread.regs->gpr[i] = NV_REG_POISON;
-		}
-	}
 
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
@@ -2133,29 +2112,13 @@ static int gpr32_get_common(struct task_struct *target,
 static int gpr32_set_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
-		     const void *kbuf, const void __user *ubuf, bool tm_active)
+		     const void *kbuf, const void __user *ubuf,
+		     unsigned long *regs)
 {
-	unsigned long *regs = &target->thread.regs->gpr[0];
-	unsigned long *ckpt_regs;
 	const compat_ulong_t *k = kbuf;
 	const compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
-#endif
-
-	if (tm_active) {
-		regs = ckpt_regs;
-	} else {
-		regs = &target->thread.regs->gpr[0];
-
-		if (target->thread.regs == NULL)
-			return -EIO;
-
-		CHECK_FULL_REGS(target->thread.regs);
-	}
-
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
 
@@ -2220,7 +2183,8 @@ static int tm_cgpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
-	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 1);
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf,
+			&target->thread.ckpt_regs.gpr[0]);
 }
 
 static int tm_cgpr32_set(struct task_struct *target,
@@ -2228,7 +2192,8 @@ static int tm_cgpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
-	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 1);
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf,
+			&target->thread.ckpt_regs.gpr[0]);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
@@ -2237,7 +2202,21 @@ static int gpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
-	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 0);
+	int i;
+
+	if (target->thread.regs == NULL)
+		return -EIO;
+
+	if (!FULL_REGS(target->thread.regs)) {
+		/*
+		 * We have a partial register set.
+		 * Fill 14-31 with bogus values.
+		 */
+		for (i = 14; i < 32; i++)
+			target->thread.regs->gpr[i] = NV_REG_POISON;
+	}
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf,
+			&target->thread.regs->gpr[0]);
 }
 
 static int gpr32_set(struct task_struct *target,
@@ -2245,7 +2224,12 @@ static int gpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
-	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 0);
+	if (target->thread.regs == NULL)
+		return -EIO;
+
+	CHECK_FULL_REGS(target->thread.regs);
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf,
+			&target->thread.regs->gpr[0]);
 }
 
 /*
-- 
1.8.3.1
