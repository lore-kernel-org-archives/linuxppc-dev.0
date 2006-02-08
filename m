Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0E7768A92
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 18:10:39 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] powerpc signal __user annotations
Message-Id: <E1F6jTI-0002Wt-00@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:36 +0000
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1138789689 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/kernel/signal_32.c |   18 +++++++-----------
 arch/powerpc/kernel/signal_64.c |    4 ++--
 include/asm-powerpc/compat.h    |    5 +++++
 3 files changed, 14 insertions(+), 13 deletions(-)

29e646df7829e41a6b0db32fd50ae6376640cd13
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index c6d0595..bd837b5 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -142,11 +142,7 @@ static inline int get_old_sigaction(stru
 	return 0;
 }
 
-static inline compat_uptr_t to_user_ptr(void *kp)
-{
-	return (compat_uptr_t)(u64)kp;
-}
-
+#define to_user_ptr(p)		ptr_to_compat(p)
 #define from_user_ptr(p)	compat_ptr(p)
 
 static inline int save_general_regs(struct pt_regs *regs,
@@ -213,8 +209,8 @@ static inline int get_old_sigaction(stru
 	return 0;
 }
 
-#define to_user_ptr(p)		(p)
-#define from_user_ptr(p)	(p)
+#define to_user_ptr(p)		((unsigned long)(p))
+#define from_user_ptr(p)	((void __user *)(p))
 
 static inline int save_general_regs(struct pt_regs *regs,
 		struct mcontext __user *frame)
@@ -526,7 +522,7 @@ long compat_sys_rt_sigaction(int sig, co
 
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 	if (!ret && oact) {
-		ret = put_user((long)old_ka.sa.sa_handler, &oact->sa_handler);
+		ret = put_user(to_user_ptr(old_ka.sa.sa_handler), &oact->sa_handler);
 		ret |= put_sigset_t(&oact->sa_mask, &old_ka.sa.sa_mask);
 		ret |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 	}
@@ -675,8 +671,8 @@ long compat_sys_rt_sigqueueinfo(u32 pid,
 int compat_sys_sigaltstack(u32 __new, u32 __old, int r5,
 		      int r6, int r7, int r8, struct pt_regs *regs)
 {
-	stack_32_t __user * newstack = (stack_32_t __user *)(long) __new;
-	stack_32_t __user * oldstack = (stack_32_t __user *)(long) __old;
+	stack_32_t __user * newstack = compat_ptr(__new);
+	stack_32_t __user * oldstack = compat_ptr(__old);
 	stack_t uss, uoss;
 	int ret;
 	mm_segment_t old_fs;
@@ -708,7 +704,7 @@ int compat_sys_sigaltstack(u32 __new, u3
 	set_fs(old_fs);
 	/* Copy the stack information to the user output buffer */
 	if (!ret && oldstack  &&
-		(put_user((long)uoss.ss_sp, &oldstack->ss_sp) ||
+		(put_user(ptr_to_compat(uoss.ss_sp), &oldstack->ss_sp) ||
 		 __put_user(uoss.ss_flags, &oldstack->ss_flags) ||
 		 __put_user(uoss.ss_size, &oldstack->ss_size)))
 		return -EFAULT;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index b319311..497a5d3 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -60,8 +60,8 @@ struct rt_sigframe {
 	struct ucontext uc;
 	unsigned long _unused[2];
 	unsigned int tramp[TRAMP_SIZE];
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	struct siginfo info;
 	/* 64 bit ABI allows for 288 bytes below sp before decrementing it. */
 	char abigap[288];
diff --git a/include/asm-powerpc/compat.h b/include/asm-powerpc/compat.h
index accb80c..aacaabd 100644
--- a/include/asm-powerpc/compat.h
+++ b/include/asm-powerpc/compat.h
@@ -126,6 +126,11 @@ static inline void __user *compat_ptr(co
 	return (void __user *)(unsigned long)uptr;
 }
 
+static inline compat_uptr_t ptr_to_compat(void __user *uptr)
+{
+	return (u32)(unsigned long)uptr;
+}
+
 static inline void __user *compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = current->thread.regs;
-- 
0.99.9.GIT
