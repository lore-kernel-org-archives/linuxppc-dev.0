Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: powerpc: fix swapcontext backwards compatibility due to VSX ucontext
	changes
Date: Fri, 04 Jul 2008 18:25:25 +1000
Message-ID: <31609.1215159925@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the ucontext changed to add the VSX context, this broke backwards
compatibly on swapcontext.  swapcontext only compares the ucontext
size passed in from the user to the new kernel ucontext size.

This adds a check against the old ucontext size (with VMX but without
VSX).  It also adds some sanity check for ucontexts without VSX, but
where VSX is used according the MSR.  Fixes for both 32 and 64bit
processes on 64bit kernels

Kudos to Paulus for noticing.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Benh: please apply to your 2.6.27 tree.

PS "I for one welcome our new powerpc linux maintainer overload" :-)

 arch/powerpc/kernel/signal_32.c |   36 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/signal_64.c |   35 +++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 5 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -68,6 +68,13 @@
 #define ucontext	ucontext32
 
 /*
+ * Userspace code may pass a ucontext which doesn't include VSX added
+ * at the end.  We need to check for this case.
+ */
+#define UCONTEXTSIZEWITHOUTVSX \
+		(sizeof(struct ucontext) - sizeof(elf_vsrreghalf_t32))
+
+/*
  * Returning 0 means we return to userspace via
  * ret_from_except and thus restore all user
  * registers from *regs.  This is what we need
@@ -930,12 +937,39 @@ long sys_swapcontext(struct ucontext __u
 {
 	unsigned char tmp;
 
+#ifdef CONFIG_PPC64
+	unsigned long new_msr = 0;
+
+	if (new_ctx &&
+	    __get_user(new_msr, &new_ctx->uc_mcontext.mc_gregs[PT_MSR]))
+		return -EFAULT;
+	if (/*
+	     * Check that the context is not smaller than the original
+	     * size (with VMX but without VSX)
+	     */
+		(ctx_size < UCONTEXTSIZEWITHOUTVSX) ||
+	    /*
+	     * If userspace doesn't provide enough room for VSX data,
+	     * but current thread has used VSX, we don't have anywhere
+	     * to store the full context back into.
+	     */
+		((ctx_size < sizeof(struct ucontext)) &&
+		 (regs->msr & MSR_VSX) && old_ctx) ||
+	    /*
+	     * If the new context state sets the MSR VSX bits but
+	     * it doesn't provide VSX state.
+	     */
+		((ctx_size < sizeof(struct ucontext)) &&
+		 (new_msr & MSR_VSX)))
+		/* ... computer says "noooo" */
+		return -EINVAL;
+#else
 	/* Context size is for future use. Right now, we only make sure
 	 * we are passed something we understand
 	 */
 	if (ctx_size < sizeof(struct ucontext))
 		return -EINVAL;
-
+#endif
 	if (old_ctx != NULL) {
 		struct mcontext __user *mctx;
 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -268,6 +268,13 @@ static long setup_trampoline(unsigned in
 }
 
 /*
+ * Userspace code may pass a ucontext which doesn't include VSX added
+ * at the end.  We need to check for this case.
+ */
+#define UCONTEXTSIZEWITHOUTVSX \
+		(sizeof(struct ucontext) - 32*sizeof(long))
+
+/*
  * Handle {get,set,swap}_context operations
  */
 int sys_swapcontext(struct ucontext __user *old_ctx,
@@ -277,10 +284,30 @@ int sys_swapcontext(struct ucontext __us
 	unsigned char tmp;
 	sigset_t set;
 
-	/* Context size is for future use. Right now, we only make sure
-	 * we are passed something we understand
-	 */
-	if (ctx_size < sizeof(struct ucontext))
+	unsigned long new_msr = 0;
+
+	if (new_ctx &&
+	    __get_user(new_msr, &new_ctx->uc_mcontext.gp_regs[PT_MSR]))
+		return -EFAULT;
+	if (/*
+	     * Check that the context is not smaller than the original
+	     * size (with VMX but without VSX)
+	     */
+		(ctx_size < UCONTEXTSIZEWITHOUTVSX) ||
+	    /*
+	     * If userspace doesn't provide enough room for VSX data,
+	     * but current thread has used VSX, we don't have anywhere
+	     * to store the full context back into.
+	     */
+		((ctx_size < sizeof(struct ucontext)) &&
+		 (regs->msr & MSR_VSX) && old_ctx) ||
+	    /*
+	     * If the new context state sets the MSR VSX bits but
+	     * it doesn't provide VSX state.
+	     */
+		((ctx_size < sizeof(struct ucontext)) &&
+		 (new_msr & MSR_VSX)))
+		/* ... computer says "No" */
 		return -EINVAL;
 
 	if (old_ctx != NULL) {
