Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42442B701D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2011 00:37:30 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2GDGT4R006236
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 09:16:29 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9955F38C8039
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 09:37:22 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2GDbOFG1695780
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 09:37:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2GDbN5R019086
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 09:37:24 -0400
Subject: [PATCH v2] powerpc/ptrace: remove BUG_ON when full register set
	not available
From: Michael Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Mar 2011 08:37:22 -0500
Message-ID: <1300282642.15145.2.camel@w500>
Mime-Version: 1.0
Cc: mikey@neuling.org, anton@samba.org
Reply-To: mjw@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some cases during a threaded core dump not all 
the threads will have a full register set.  This
will cause problems when the sigkill is sent to
the thread.  To solve this problem a poison value
(0xdeadbeef) will be placed in the buffer in place 
of the actual register values.  This will affect
gpr14 to gpr31.

Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>

----------
--- linux-2.6.32-71.el6.ppc64.orig/arch/powerpc/include/asm/ptrace.h	2010-08-31 23:56:50.000000000 -0500
+++ linux-2.6.32-71.el6.ppc64/arch/powerpc/include/asm/ptrace.h	2011-03-14 11:43:33.176667099 -0500
@@ -123,8 +123,14 @@ extern int ptrace_put_reg(struct task_st
 #define TRAP(regs)		((regs)->trap & ~0xF)
 #ifdef __powerpc64__
 #define CHECK_FULL_REGS(regs)	BUG_ON(regs->trap & 1)
+#define PARTIAL_REG_FILL	0xdeadbeefdeadbeefUL
+#define PARTIAL_REG_START	14
+#define PARTIAL_REG_END		31
 #else
 #define CHECK_FULL_REGS(regs)						      \
+#define PARTIAL_REG_FILL	0xdeadbeef
+#define PARTIAL_REG_START	14
+#define PARTIAL_REG_END		31
 do {									      \
 	if ((regs)->trap & 1)						      \
 		printk(KERN_CRIT "%s: partial register set\n", __func__); \
--- linux-2.6.32-71.el6.ppc64.orig/arch/powerpc/kernel/ptrace.c	2009-12-02 21:51:21.000000000 -0600
+++ linux-2.6.32-71.el6.ppc64/arch/powerpc/kernel/ptrace.c	2011-03-14 13:01:51.955586126 -0500
@@ -125,11 +125,16 @@ static int gpr_get(struct task_struct *t
 		   void *kbuf, void __user *ubuf)
 {
 	int ret;
+	int partial_reg;
 
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
+	if (!FULL_REGS(target->thread.regs))
+	   /* We have a partial register set.  Fill 14-31 with bogus values */
+	   for(partial_reg=PARTIAL_REG_START;partial_reg <= PARTIAL_REG_END;
+		partial_reg++)
+           	target->thread.regs->gpr[partial_reg] = PARTIAL_REG_FILL; 
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  target->thread.regs,
@@ -536,11 +541,16 @@ static int gpr32_get(struct task_struct 
 	compat_ulong_t *k = kbuf;
 	compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
+	int partial_reg;
 
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
+	if (!FULL_REGS(target->thread.regs))
+	   /* We have a partial register set.  Fill 14-31 with bogus values */
+	   for(partial_reg=PARTIAL_REG_START;partial_reg <= PARTIAL_REG_END;
+		partial_reg++)
+           	target->thread.regs->gpr[partial_reg] = PARTIAL_REG_FILL; 
 
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
