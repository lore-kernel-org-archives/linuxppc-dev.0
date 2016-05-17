Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88bk2H8YzDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:49:06 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g132so1068436pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 00:49:06 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: sbauer@plzdonthack.me
Subject: [PATCH 1/2] powerpc/SROP Mitigation: Architecture independent SROP
 mitigation code
Date: Tue, 17 May 2016 17:47:50 +1000
Message-Id: <1463471271-26788-2-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1463471271-26788-1-git-send-email-rashmicy@gmail.com>
References: <1463471271-26788-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is based off Scotty's patch: https://lkml.org/lkml/2016/3/29/792.
The only difference being that the sig_cookie is apart of the struct
sighand_struct instead of task_struct so the the sig_cookie is shared
between threads.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 fs/exec.c              |  4 ++++
 include/linux/sched.h  |  1 +
 include/linux/signal.h |  2 ++
 kernel/signal.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index c4010b8207a1..487f3b20b8d8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -57,6 +57,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1231,6 +1232,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	/* This is the point of no return */
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
+	get_random_bytes(&current->sighand->sig_cookie,
+			sizeof(current->sighand->sig_cookie));
+
 	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
 		set_dumpable(current->mm, SUID_DUMP_USER);
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 52c4847b05e2..aa0f2cd2f46b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -519,6 +519,7 @@ struct sighand_struct {
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
 	wait_queue_head_t	signalfd_wqh;
+	unsigned long		sig_cookie;
 };
 
 struct pacct_struct {
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 92557bbce7e7..fae0618b436f 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -280,6 +280,8 @@ extern int get_signal(struct ksignal *ksig);
 extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
+extern int set_sigcookie(unsigned long __user *location);
+extern int verify_clear_sigcookie(unsigned long __user *sig_cookie_ptr);
 
 static inline void allow_signal(int sig)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index aa9bf00749c1..6db671ebf44b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2430,6 +2430,47 @@ out:
 	}
 }
 
+static unsigned long gen_sigcookie(unsigned long __user *location)
+{
+
+	unsigned long sig_cookie;
+
+	sig_cookie = (unsigned long) location ^ current->sighand->sig_cookie;
+
+	return sig_cookie;
+}
+
+int set_sigcookie(unsigned long __user *location)
+{
+
+	unsigned long sig_cookie = gen_sigcookie(location);
+
+	return put_user(sig_cookie, location);
+}
+
+int verify_clear_sigcookie(unsigned long __user *sig_cookie_ptr)
+{
+	unsigned long user_cookie;
+	unsigned long calculated_cookie;
+
+	if (get_user(user_cookie, sig_cookie_ptr))
+		return 1;
+
+	calculated_cookie = gen_sigcookie(sig_cookie_ptr);
+
+	if (user_cookie != calculated_cookie) {
+		pr_warn("Signal protector does not match what kernel set it to"\
+			". Possible exploit attempt or buggy program!\n");
+		return 1;
+
+	}
+
+	user_cookie = 0;
+	return put_user(user_cookie, sig_cookie_ptr);
+}
+
+EXPORT_SYMBOL(verify_clear_sigcookie);
+EXPORT_SYMBOL(set_sigcookie);
 EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL_GPL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
-- 
2.5.0
