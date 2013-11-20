Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 6/9] powerpc: ELF2 binaries signal handling
Date: Wed, 20 Nov 2013 22:15:03 +1100
Message-Id: <1384946106-18200-7-git-send-email-anton@samba.org>
In-Reply-To: <1384946106-18200-1-git-send-email-anton@samba.org>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

For the ELFv2 ABI, the hander is the entry point, not a function descriptor.
We also need to set up r12, and fortunately the fast_exception_return
exit path restores r12 for us so nothing else is required.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/signal_64.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index b3c6157..e66f67b 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -701,12 +701,6 @@ badframe:
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
@@ -766,19 +760,32 @@ int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
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
