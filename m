Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/signals: Mark VSX not saved with small contexts
In-reply-to: <20131121113333.GB15913@concordia>
References: <1384924734-16722-1-git-send-email-mikey@neuling.org>
 <20131121113333.GB15913@concordia>
Date: Fri, 22 Nov 2013 13:22:59 +1100
Message-ID: <14147.1385086979@ale.ozlabs.ibm.com>
Cc: Carlos O'Donell <carlos@redhat.com>, Steve Best <sbest@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The VSX MSR bit in the user context indicates if the context contains
VSX state.  Unfortunately, if the user has not provided enough space to
save the VSX state, we can't save it but we currently still set the MSR
VSX bit.

This patch changes this to clear the MSR VSX bit when the user doesn't
provide enough space.  This indicates that there is no valid VSX state
in the user context.  We now clear MSR VSX always and only set it in the
specific case when we can (ie. when VSX used and space is provided).

This is needed to support get/set/make/swapcontext for applications that
use VSX but only provide a small context.  For example, getcontext in
glibc provides a smaller context since the VSX registers don't need to
be saved over the glibc function call.  But since the program calling
getcontext may have used VSX, the kernel currently says the VSX state is
valid when it's not.  If the returned context is then used in setcontext
(ie. a small context without VSX but with MSR VSX set), the kernel will
refuse the context.  This situation has been reported by the glibc
community.

Based on patch from Carlos O'Donell.

Tested-by: Haren Myneni <haren@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org
--
v2:
  - moved the code around a bit to make clearer what's happening
  - added 64bit version as noticed by mpe
  - updates to comments and commit messages

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 749778e..68027bf 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -445,6 +445,12 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 #endif /* CONFIG_ALTIVEC */
 	if (copy_fpr_to_user(&frame->mc_fregs, current))
 		return 1;
+
+	/*
+	 * Clear the MSR VSX bit to indicate there is no valid state attached
+	 * to this context, except in the specific case below where we set it.
+	 */
+	msr &= ~MSR_VSX;
 #ifdef CONFIG_VSX
 	/*
 	 * Copy VSR 0-31 upper half from thread_struct to local
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index b3c6157..26789ed 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -122,6 +122,12 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	flush_fp_to_thread(current);
 	/* copy fpr regs and fpscr */
 	err |= copy_fpr_to_user(&sc->fp_regs, current);
+
+	/*
+	 * Clear the MSR VSX bit to indicate there is no valid state attached
+	 * to this context, except in the specific case below where we set it.
+	 */
+	msr &= ~MSR_VSX;
 #ifdef CONFIG_VSX
 	/*
 	 * Copy VSX low doubleword to local buffer for formatting,
