Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEF981A0B75
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:10:58 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F070140B0E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:10:57 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:40:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 11BAAE0054
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:43:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JFAKPL64356396
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:40:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8Qh8027860
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 06/28] powerpc, ptrace: Adapt gpr32_get,
 gpr32_set functions for transaction
Date: Tue, 19 May 2015 20:38:02 +0530
Message-Id: <1432048104-4695-7-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
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
index 015f284..a8e4d19 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -906,24 +906,35 @@ static const struct user_regset_view user_ppc_native_view = {
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
@@ -963,20 +974,31 @@ static int gpr32_get(struct task_struct *target,
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
@@ -1036,6 +1058,22 @@ static int gpr32_set(struct task_struct *target,
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
