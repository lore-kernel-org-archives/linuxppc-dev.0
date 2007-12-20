Return-Path: <roland@redhat.com>
Received: from QMTA07.westchester.pa.mail.comcast.net
	(qmta07.westchester.pa.mail.comcast.net [76.96.62.64])
	by ozlabs.org (Postfix) with ESMTP id 73717DDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:36:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 10/43] powerpc user_regset fpregs
Message-Id: <20071220115734.37FA126F98A@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:57:34 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This implements user_regset-style accessors for the powerpc FPU data,
and rewrites the existing ptrace code in terms of those calls.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8b056d2..f1ce646 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
+#include <linux/regset.h>
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/signal.h>
@@ -103,24 +104,48 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 }
 
 
+static int fpr_get(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	flush_fp_to_thread(target);
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
+		     offsetof(struct thread_struct, fpr[32]));
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.fpr, 0, -1);
+}
+
+static int fpr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	flush_fp_to_thread(target);
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
+		     offsetof(struct thread_struct, fpr[32]));
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpr, 0, -1);
+}
+
 static int get_fpregs(void __user *data, struct task_struct *task,
 		      int has_fpscr)
 {
 	unsigned int count = has_fpscr ? 33 : 32;
-
-	if (copy_to_user(data, task->thread.fpr, count * sizeof(double)))
+	if (!access_ok(VERIFY_WRITE, data, count * sizeof(double)))
 		return -EFAULT;
-	return 0;
+	return fpr_get(task, NULL, 0, count * sizeof(double), NULL, data);
 }
 
 static int set_fpregs(void __user *data, struct task_struct *task,
 		      int has_fpscr)
 {
 	unsigned int count = has_fpscr ? 33 : 32;
-
-	if (copy_from_user(task->thread.fpr, data, count * sizeof(double)))
+	if (!access_ok(VERIFY_READ, data, count * sizeof(double)))
 		return -EFAULT;
-	return 0;
+	return fpr_set(task, NULL, 0, count * sizeof(double), NULL, data);
 }
 
 
-- 
1.5.3.6
