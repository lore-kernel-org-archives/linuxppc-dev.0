Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 577831A0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:01:56 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D06921409B7
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:55 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:01:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 34710357805A
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G91hOa62128376
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91GXw018188
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:18 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V10 06/28] powerpc, ptrace: Adapt gpr32_get,
 gpr32_set functions for transaction
Date: Tue, 16 Feb 2016 14:29:36 +0530
Message-Id: <1455613198-5113-7-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch splits gpr32_get, gpr32_set functions to accommodate
in transaction ptrace requests implemented in patches later in
the series.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 64 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 255b598..6e0e035 100644
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
2.1.0
