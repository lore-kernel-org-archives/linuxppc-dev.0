Return-Path: <roland@redhat.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id 2FEA5DDF62
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 00:02:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 11/43] powerpc user_regset altivec
Message-Id: <20071220115739.4978126F98A@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:57:39 -0800 (PST)
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

This implements user_regset-style accessors for the powerpc Altivec data,
and rewrites the existing ptrace code in terms of those calls.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |  112 +++++++++++++++++++++++++++++-------------
 1 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f1ce646..7cdf35a 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/regset.h>
+#include <linux/elf.h>
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/signal.h>
@@ -163,30 +164,87 @@ static int set_fpregs(void __user *data, struct task_struct *task,
  * (combined (32- and 64-bit) gdb.
  */
 
+static int vr_active(struct task_struct *target,
+		     const struct user_regset *regset)
+{
+	flush_altivec_to_thread(target);
+	return target->thread.used_vr ? regset->n : 0;
+}
+
+static int vr_get(struct task_struct *target, const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	flush_altivec_to_thread(target);
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, vscr) !=
+		     offsetof(struct thread_struct, vr[32]));
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.vr, 0,
+				  33 * sizeof(vector128));
+	if (!ret) {
+		/*
+		 * Copy out only the low-order word of vrsave.
+		 */
+		union {
+			elf_vrreg_t reg;
+			u32 word;
+		} vrsave;
+		memset(&vrsave, 0, sizeof(vrsave));
+		vrsave.word = target->thread.vrsave;
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
+					  33 * sizeof(vector128), -1);
+	}
+
+	return ret;
+}
+
+static int vr_set(struct task_struct *target, const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	flush_altivec_to_thread(target);
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, vscr) !=
+		     offsetof(struct thread_struct, vr[32]));
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &target->thread.vr, 0, 33 * sizeof(vector128));
+	if (!ret && count > 0) {
+		/*
+		 * We use only the first word of vrsave.
+		 */
+		union {
+			elf_vrreg_t reg;
+			u32 word;
+		} vrsave;
+		memset(&vrsave, 0, sizeof(vrsave));
+		vrsave.word = target->thread.vrsave;
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
+					 33 * sizeof(vector128), -1);
+		if (!ret)
+			target->thread.vrsave = vrsave.word;
+	}
+
+	return ret;
+}
+
 /*
  * Get contents of AltiVec register state in task TASK
  */
 static int get_vrregs(unsigned long __user *data, struct task_struct *task)
 {
-	unsigned long regsize;
-
-	/* copy AltiVec registers VR[0] .. VR[31] */
-	regsize = 32 * sizeof(vector128);
-	if (copy_to_user(data, task->thread.vr, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VSCR */
-	regsize = 1 * sizeof(vector128);
-	if (copy_to_user(data, &task->thread.vscr, regsize))
+	if (!access_ok(VERIFY_WRITE, data,
+		       33 * sizeof(vector128) + sizeof(u32)))
 		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
 
-	/* copy VRSAVE */
-	if (put_user(task->thread.vrsave, (u32 __user *)data))
-		return -EFAULT;
-
-	return 0;
+	return vr_get(task, NULL, 0, 33 * sizeof(vector128) + sizeof(u32),
+		      NULL, data);
 }
 
 /*
@@ -194,25 +252,11 @@ static int get_vrregs(unsigned long __user *data, struct task_struct *task)
  */
 static int set_vrregs(struct task_struct *task, unsigned long __user *data)
 {
-	unsigned long regsize;
-
-	/* copy AltiVec registers VR[0] .. VR[31] */
-	regsize = 32 * sizeof(vector128);
-	if (copy_from_user(task->thread.vr, data, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VSCR */
-	regsize = 1 * sizeof(vector128);
-	if (copy_from_user(&task->thread.vscr, data, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VRSAVE */
-	if (get_user(task->thread.vrsave, (u32 __user *)data))
+	if (!access_ok(VERIFY_READ, data, 33 * sizeof(vector128) + sizeof(u32)))
 		return -EFAULT;
 
-	return 0;
+	return vr_set(task, NULL, 0, 33 * sizeof(vector128) + sizeof(u32),
+		      NULL, data);
 }
 #endif /* CONFIG_ALTIVEC */
 
-- 
1.5.3.6
