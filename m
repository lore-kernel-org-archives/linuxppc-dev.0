Return-Path: <james.morse@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wz4pG13s8zDr4s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 02:28:05 +1000 (AEST)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Roland McGrath <roland@hack.frob.com>,
 linuxppc-dev@lists.ozlabs.org, Zhou Chengming <zhouchengming1@huawei.com>,
 James Morse <james.morse@arm.com>, Yury Norov <ynorov@caviumnetworks.com>,
 Andrey Vagin <avagin@openvz.org>
Subject: [PATCH] ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
Date: Thu, 29 Jun 2017 17:26:37 +0100
Message-Id: <20170629162637.10676-1-james.morse@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

compat_ptrace_request() lacks handlers for PTRACE_{G,S}ETSIGMASK,
instead using those in ptrace_request(). The compat variant should
read a compat_sigset_t from userspace instead of ptrace_request()s
sigset_t.

While compat_sigset_t is the same size as sigset_t, it is defined as
2xu32, instead of a single u64. On a big-endian CPU this means that
compat_sigset_t is passed to user-space using middle-endianness,
where the least-significant u32 is written most significant byte
first.

If ptrace_request()s code is used userspace will read the most
significant u32 where it expected the least significant.

Instead of duplicating ptrace_request()s code as a special case in
the arch code, handle it here.

CC: Yury Norov <ynorov@caviumnetworks.com>
CC: Andrey Vagin <avagin@openvz.org>
Reported-by: Zhou Chengming <zhouchengming1@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
Fixes: 29000caecbe87 ("ptrace: add ability to get/set signal-blocked mask")
---
LTP test case here:
https://lists.linux.it/pipermail/ltp/2017-June/004932.html

 kernel/ptrace.c | 52 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 8d2c10714530..a5bebb6713e8 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -843,6 +843,22 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 EXPORT_SYMBOL_GPL(task_user_regset_view);
 #endif
 
+static int ptrace_setsigmask(struct task_struct *child, sigset_t *new_set)
+{
+	sigdelsetmask(new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+	/*
+	 * Every thread does recalc_sigpending() after resume, so
+	 * retarget_shared_pending() and recalc_sigpending() are not
+	 * called here.
+	 */
+	spin_lock_irq(&child->sighand->siglock);
+	child->blocked = *new_set;
+	spin_unlock_irq(&child->sighand->siglock);
+
+	return 0;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -914,18 +930,7 @@ int ptrace_request(struct task_struct *child, long request,
 			break;
 		}
 
-		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
-
-		/*
-		 * Every thread does recalc_sigpending() after resume, so
-		 * retarget_shared_pending() and recalc_sigpending() are not
-		 * called here.
-		 */
-		spin_lock_irq(&child->sighand->siglock);
-		child->blocked = new_set;
-		spin_unlock_irq(&child->sighand->siglock);
-
-		ret = 0;
+		ret = ptrace_setsigmask(child, &new_set);
 		break;
 	}
 
@@ -1149,7 +1154,9 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 			  compat_ulong_t addr, compat_ulong_t data)
 {
 	compat_ulong_t __user *datap = compat_ptr(data);
+	compat_sigset_t set32;
 	compat_ulong_t word;
+	sigset_t new_set;
 	siginfo_t siginfo;
 	int ret;
 
@@ -1189,6 +1196,27 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		else
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
+	case PTRACE_GETSIGMASK:
+		if (addr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		sigset_to_compat(&set32, &child->blocked);
+
+		if (copy_to_user(datap, &set32, sizeof(set32)))
+			return -EFAULT;
+
+		ret = 0;
+		break;
+	case PTRACE_SETSIGMASK:
+		if (addr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		if (copy_from_user(&set32, datap, sizeof(compat_sigset_t)))
+			return -EFAULT;
+
+		sigset_from_compat(&new_set, &set32);
+		ret = ptrace_setsigmask(child, &new_set);
+		break;
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
 	case PTRACE_SETREGSET:
-- 
2.11.0
