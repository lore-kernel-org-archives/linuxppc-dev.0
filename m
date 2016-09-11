Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sX8pK4vYjzDsFG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 22:07:53 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id pp5so6354917pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 05:07:52 -0700 (PDT)
Date: Sun, 11 Sep 2016 20:07:44 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
Message-ID: <20160911120743.GA22669@simonLocalRHEL7.x64>
References: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
 <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
 <20160824073826.GA16442@simonLocalRHEL7.x64>
 <871t1dr716.fsf@possimpible.ozlabs.ibm.com>
 <871t0tl4zf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871t0tl4zf.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 09, 2016 at 08:52:52PM +1000, Michael Ellerman wrote:
> I do - Sorry Simon but your patch just adds too many #ifdefs.
> 
> Any time you have to do something like:
> 
> 	+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> 		}
> 	+#endif
> 
> It should be a sign that something has gone wrong :)
> 
> Does Cyril's series to rework the TM structures help at all with this
> warning?
Hi Michael,

What cppchecker complains is only concerned with GPR:
gpr32_get/set_common() which is used by tm_cgpr32_get()/gpr32_get().

Cyril's patch changes TM FPR/VR/VSX state saving location to be consistent with 
GPR's.  It doesn't actually modify TM GPR behavior. 

So Cyril's work doesn't relate with this cppchecker complaining issue.


Thanks for the feedback regarding too many ifdefs.  Is following implemention 
better for this issue?

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index bf91658..cf48e98 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2065,34 +2065,14 @@ static const struct user_regset_view user_ppc_native_view = {
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
 	int i;
 
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
-
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
 
@@ -2133,29 +2113,13 @@ static int gpr32_get_common(struct task_struct *target,
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
 
@@ -2220,7 +2184,7 @@ static int tm_cgpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
-	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 1);
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, &target->thread.ckpt_regs.gpr[0]);
 }
 
 static int tm_cgpr32_set(struct task_struct *target,
@@ -2228,7 +2192,7 @@ static int tm_cgpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
-	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 1);
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, &target->thread.ckpt_regs.gpr[0]);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
@@ -2237,7 +2201,18 @@ static int gpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
-	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 0);
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
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, &target->thread.regs->gpr[0]);
 }
 
 static int gpr32_set(struct task_struct *target,
@@ -2245,7 +2220,11 @@ static int gpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
-	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 0);
+	if (target->thread.regs == NULL)
+		return -EIO;
+
+	CHECK_FULL_REGS(target->thread.regs);
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, &target->thread.regs->gpr[0]);
 }
 
 /*


Thanks,
- Simon
