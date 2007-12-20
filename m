Return-Path: <roland@redhat.com>
Received: from QMTA08.emeryville.ca.mail.comcast.net
	(qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
	by ozlabs.org (Postfix) with ESMTP id 1D719DDF62
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 00:02:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 12/43] powerpc user_regset spe
Message-Id: <20071220115748.484E626F98A@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:57:48 -0800 (PST)
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

This implements user_regset-style accessors for the powerpc SPE data,
and rewrites the existing ptrace code in terms of those calls.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |   90 ++++++++++++++++++++++++++---------------
 1 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7cdf35a..8c25b00 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -272,55 +272,79 @@ static int set_vrregs(struct task_struct *task, unsigned long __user *data)
  * }
  */
 
-/*
- * Get contents of SPE register state in task TASK.
- */
-static int get_evrregs(unsigned long *data, struct task_struct *task)
+static int evr_active(struct task_struct *target,
+		      const struct user_regset *regset)
 {
-	int i;
+	flush_spe_to_thread(target);
+	return target->thread.used_spe ? regset->n : 0;
+}
 
-	if (!access_ok(VERIFY_WRITE, data, 35 * sizeof(unsigned long)))
-		return -EFAULT;
+static int evr_get(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	int ret;
 
-	/* copy SPEFSCR */
-	if (__put_user(task->thread.spefscr, &data[34]))
-		return -EFAULT;
+	flush_spe_to_thread(target);
 
-	/* copy SPE registers EVR[0] .. EVR[31] */
-	for (i = 0; i < 32; i++, data++)
-		if (__put_user(task->thread.evr[i], data))
-			return -EFAULT;
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.evr,
+				  0, sizeof(target->thread.evr));
 
-	/* copy ACC */
-	if (__put_user64(task->thread.acc, (unsigned long long *)data))
-		return -EFAULT;
+	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
+		     offsetof(struct thread_struct, spefscr));
 
-	return 0;
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.acc,
+					  sizeof(target->thread.evr), -1);
+
+	return ret;
+}
+
+static int evr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	flush_spe_to_thread(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &target->thread.evr,
+				 0, sizeof(target->thread.evr));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
+		     offsetof(struct thread_struct, spefscr));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &target->thread.acc,
+					 sizeof(target->thread.evr), -1);
+
+	return ret;
 }
 
 /*
- * Write contents of SPE register state into task TASK.
+ * Get contents of SPE register state in task TASK.
  */
-static int set_evrregs(struct task_struct *task, unsigned long *data)
+static int get_evrregs(unsigned long __user *data, struct task_struct *task)
 {
-	int i;
-
-	if (!access_ok(VERIFY_READ, data, 35 * sizeof(unsigned long)))
+	if (!access_ok(VERIFY_WRITE, data, 35 * sizeof(u32)))
 		return -EFAULT;
 
-	/* copy SPEFSCR */
-	if (__get_user(task->thread.spefscr, &data[34]))
-		return -EFAULT;
+	return evr_get(task, NULL, 0, 35 * sizeof(u32), NULL, data);
+}
 
-	/* copy SPE registers EVR[0] .. EVR[31] */
-	for (i = 0; i < 32; i++, data++)
-		if (__get_user(task->thread.evr[i], data))
-			return -EFAULT;
-	/* copy ACC */
-	if (__get_user64(task->thread.acc, (unsigned long long*)data))
+/*
+ * Write contents of SPE register state into task TASK.
+ */
+static int set_evrregs(struct task_struct *task, unsigned long *data)
+{
+	if (!access_ok(VERIFY_READ, data, 35 * sizeof(u32)))
 		return -EFAULT;
 
-	return 0;
+	return evr_set(task, NULL, 0, 35 * sizeof(u32), NULL, data);
 }
 #endif /* CONFIG_SPE */
 
-- 
1.5.3.6
