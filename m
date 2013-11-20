Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/signals: Mark VSX not saved with small contexts
Date: Wed, 20 Nov 2013 16:18:54 +1100
Message-Id: <1384924734-16722-1-git-send-email-mikey@neuling.org>
Cc: Carlos O'Donell <carlos@redhat.com>, Steve Best <sbest@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The VSX MSR bit in the user context indicates if the context contains VSX
state.  Currently we set this when the process has touched VSX at any stage.

Unfortunately, if the user has not provided enough space to save the VSX state,
we can't save it but we currently still set the MSR VSX bit.

This patch changes this to clear the MSR VSX bit when the user doesn't provide
enough space.  This indicates that there is no valid VSX state in the user
context.

This is needed to support get/set/make/swapcontext for applications that use
VSX but only provide a small context.  For example, getcontext in glibc
provides a smaller context since the VSX registers don't need to be saved over
the glibc function call.  But since the program calling getcontext may have
used VSX, the kernel currently says the VSX state is valid when it's not.  If
the returned context is then used in setcontext (ie. a small context without
VSX but with MSR VSX set), the kernel will refuse the context.  This situation
has been reported by the glibc community.

Based on patch from Carlos O'Donell.

Tested-by: Haren Myneni <haren@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/signal_32.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 749778e..1844298 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -457,7 +457,15 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
-	}
+	} else if (!ctx_has_vsx_region)
+		/*
+		 * With a small context structure we can't hold the VSX
+		 * registers, hence clear the MSR value to indicate the state
+		 * was not saved.
+		 */
+		msr &= ~MSR_VSX;
+
+
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	/* save spe registers */
-- 
1.8.3.2
