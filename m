Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 0D750DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 03:24:29 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so94059rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:24:28 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 25 Mar 2009 12:23:59 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Sanitize stack pointer in signal handling code
Message-ID: <20090325162359.GA2367@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On powerpc64 machines running 32-bit userspace, we can get garbage bits in the
stack pointer passed into the kernel.  Most places handle this correctly, but
the signal handling code uses the passed value directly for allocating signal
stack frames.

This fixes the issue by introducing a get_clean_sp function that returns a
sanitized stack pointer.  For 32-bit tasks on a 64-bit kernel, the stack
pointer is masked correctly.  In all other cases, the stack pointer is simply
returned.

Additionally, we pass an 'is_32' parameter to get_sigframe now in order to
get the properly sanitized stack.  The callers are know to be 32 or 64-bit
statically.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/include/asm/processor.h |   19 +++++++++++++++++++
 arch/powerpc/kernel/signal.c         |    4 ++--
 arch/powerpc/kernel/signal.h         |    2 +-
 arch/powerpc/kernel/signal_32.c      |    4 ++--
 arch/powerpc/kernel/signal_64.c      |    2 +-
 5 files changed, 25 insertions(+), 6 deletions(-)

--- linux-2.6.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6/arch/powerpc/kernel/signal_32.c
@@ -836,7 +836,7 @@ int handle_rt_signal32(unsigned long sig
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(ka, regs, sizeof(*rt_sf));
+	rt_sf = get_sigframe(ka, regs, sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
@@ -1182,7 +1182,7 @@ int handle_signal32(unsigned long sig, s
 	unsigned long newsp = 0;
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, regs, sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
--- linux-2.6.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6/arch/powerpc/include/asm/processor.h
@@ -313,6 +313,25 @@ static inline void prefetchw(const void 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 #endif
 
+#ifdef CONFIG_PPC64
+static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
+{
+	unsigned long sp;
+
+	if (is_32)
+		sp = regs->gpr[1] & 0x0ffffffffUL;
+	else
+		sp = regs->gpr[1];
+
+	return sp;
+}
+#else
+static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
+{
+	return regs->gpr[1];
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PROCESSOR_H */
--- linux-2.6.orig/arch/powerpc/kernel/signal.c
+++ linux-2.6/arch/powerpc/kernel/signal.c
@@ -26,12 +26,12 @@ int show_unhandled_signals = 0;
  * Allocate space for the signal frame
  */
 void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-			   size_t frame_size)
+			   size_t frame_size, int is_32)
 {
         unsigned long oldsp, newsp;
 
         /* Default to using normal stack */
-        oldsp = regs->gpr[1];
+        oldsp = get_clean_sp(regs, is_32);
 
 	/* Check for alt stack */
 	if ((ka->sa.sa_flags & SA_ONSTACK) &&
--- linux-2.6.orig/arch/powerpc/kernel/signal.h
+++ linux-2.6/arch/powerpc/kernel/signal.h
@@ -15,7 +15,7 @@
 extern void do_signal(struct pt_regs *regs, unsigned long thread_info_flags);
 
 extern void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-				  size_t frame_size);
+				  size_t frame_size, int is_32);
 extern void restore_sigmask(sigset_t *set);
 
 extern int handle_signal32(unsigned long sig, struct k_sigaction *ka,
--- linux-2.6.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6/arch/powerpc/kernel/signal_64.c
@@ -402,7 +402,7 @@ int handle_rt_signal64(int signr, struct
 	unsigned long newsp = 0;
 	long err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, regs, sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
 		goto badframe;
 
