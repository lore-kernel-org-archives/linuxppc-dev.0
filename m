Return-Path: <rusty@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0146C2C014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:32 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rusty@au1.ibm.com>;
 Thu, 7 Nov 2013 11:21:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9B28C3578055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA713lxc59441300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:03:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA71LQB0025241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:21:27 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc: ELF2 binaries signal handling
Date: Thu,  7 Nov 2013 11:46:52 +1030
Message-Id: <1383787012-16455-4-git-send-email-rusty@au1.ibm.com>
In-Reply-To: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
References: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the ELFv2 ABI, the hander is the entry point, not a function descriptor.
We also need to set up r12, and fortunately the fast_exception_return
exit path restores r12 for us so nothing else is required.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/signal_64.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index f7e61e0..af1f7ad 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -694,12 +694,6 @@ badframe:
 int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 		sigset_t *set, struct pt_regs *regs)
 {
-	/* Handler is *really* a pointer to the function descriptor for
-	 * the signal routine.  The first entry in the function
-	 * descriptor is the entry address of signal and the second
-	 * entry is the TOC value we need to use.
-	 */
-	func_descr_t __user *funct_desc_ptr;
 	struct rt_sigframe __user *frame;
 	unsigned long newsp = 0;
 	long err = 0;
@@ -759,19 +753,32 @@ int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 			goto badframe;
 		regs->link = (unsigned long) &frame->tramp[0];
 	}
-	funct_desc_ptr = (func_descr_t __user *) ka->sa.sa_handler;
 
 	/* Allocate a dummy caller frame for the signal handler. */
 	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
 	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
 
 	/* Set up "regs" so we "return" to the signal handler. */
-	err |= get_user(regs->nip, &funct_desc_ptr->entry);
+	if (is_elf2_task()) {
+		regs->nip = (unsigned long) ka->sa.sa_handler;
+		regs->gpr[12] = regs->nip;
+	} else {
+		/* Handler is *really* a pointer to the function descriptor for
+		 * the signal routine.  The first entry in the function
+		 * descriptor is the entry address of signal and the second
+		 * entry is the TOC value we need to use.
+		 */
+		func_descr_t __user *funct_desc_ptr =
+			(func_descr_t __user *) ka->sa.sa_handler;
+
+		err |= get_user(regs->nip, &funct_desc_ptr->entry);
+		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
+	}
+
 	/* enter the signal handler in native-endian mode */
 	regs->msr &= ~MSR_LE;
 	regs->msr |= (MSR_KERNEL & MSR_LE);
 	regs->gpr[1] = newsp;
-	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
 	regs->result = 0;
 	if (ka->sa.sa_flags & SA_SIGINFO) {
-- 
1.8.3.2
