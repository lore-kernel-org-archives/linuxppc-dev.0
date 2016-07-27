Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzqQz4yFPzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:27:55 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so1521762pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 02:27:55 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v12 06/30] powerpc/ptrace: Adapt gpr32_get,
 gpr32_set functions for transaction
Date: Wed, 27 Jul 2016 17:26:31 +0800
Message-Id: <1469611615-2935-7-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch splits gpr32_get, gpr32_set functions to accommodate
in transaction ptrace requests implemented in patches later in
the series.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 64 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ebf3b0e..2cdb4e7 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -907,24 +907,35 @@ static const struct user_regset_view user_ppc_native_view = {
 #ifdef CONFIG_PPC64
 #include <linux/compat.h>
 
-static int gpr32_get(struct task_struct *target,
+static int gpr32_get_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+			    void *kbuf, void __user *ubuf, bool tm_active)
 {
 	const unsigned long *regs = &target->thread.regs->gpr[0];
+	const unsigned long *ckpt_regs;
 	compat_ulong_t *k = kbuf;
 	compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
 	int i;
 
-	if (target->thread.regs == NULL)
-		return -EIO;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
+#endif
+	if (tm_active) {
+		regs = ckpt_regs;
+	} else {
+		if (target->thread.regs == NULL)
+			return -EIO;
 
-	if (!FULL_REGS(target->thread.regs)) {
-		/* We have a partial register set.  Fill 14-31 with bogus values */
-		for (i = 14; i < 32; i++)
-			target->thread.regs->gpr[i] = NV_REG_POISON; 
+		if (!FULL_REGS(target->thread.regs)) {
+			/*
+			 * We have a partial register set.
+			 * Fill 14-31 with bogus values.
+			 */
+			for (i = 14; i < 32; i++)
+				target->thread.regs->gpr[i] = NV_REG_POISON;
+		}
 	}
 
 	pos /= sizeof(reg);
@@ -964,20 +975,31 @@ static int gpr32_get(struct task_struct *target,
 					PT_REGS_COUNT * sizeof(reg), -1);
 }
 
-static int gpr32_set(struct task_struct *target,
+static int gpr32_set_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
-		     const void *kbuf, const void __user *ubuf)
+		     const void *kbuf, const void __user *ubuf, bool tm_active)
 {
 	unsigned long *regs = &target->thread.regs->gpr[0];
+	unsigned long *ckpt_regs;
 	const compat_ulong_t *k = kbuf;
 	const compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
 
-	if (target->thread.regs == NULL)
-		return -EIO;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
+#endif
 
-	CHECK_FULL_REGS(target->thread.regs);
+	if (tm_active) {
+		regs = ckpt_regs;
+	} else {
+		regs = &target->thread.regs->gpr[0];
+
+		if (target->thread.regs == NULL)
+			return -EIO;
+
+		CHECK_FULL_REGS(target->thread.regs);
+	}
 
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
@@ -1037,6 +1059,22 @@ static int gpr32_set(struct task_struct *target,
 					 (PT_TRAP + 1) * sizeof(reg), -1);
 }
 
+static int gpr32_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
+{
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 0);
+}
+
+static int gpr32_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
+{
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 0);
+}
+
 /*
  * These are the regset flavors matching the CONFIG_PPC32 native set.
  */
-- 
1.8.3.1
