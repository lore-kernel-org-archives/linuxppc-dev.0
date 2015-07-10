Return-Path: <hidehiro.kawai.ez@hitachi.com>
Received: from mailx.hitachi.co.jp (mailx.hitachi.co.jp [133.145.228.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 4EA311A0DD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 22:17:53 +1000 (AEST)
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by mailx.hitachi.co.jp (Postfix) with ESMTP id 6E2252168089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 20:39:56 +0900 (JST)
Subject: [PATCH 3/3] kexec: Change the timing of callbacks related to
 "crash_kexec_post_notifiers" boot option
To: Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.77050.stgit@softrs>
In-Reply-To: <20150710113331.4368.10495.stgit@softrs>
References: <20150710113331.4368.10495.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes problems reported by Daniel Walker
(https://lkml.org/lkml/2015/6/24/44), and also replaces the bug fix
commits 5375b70 and f45d85f.

If "crash_kexec_post_notifiers" boot option is specified,
other cpus are stopped by smp_send_stop() before entering
crash_kexec(), while usually machine_crash_shutdown() called by
crash_kexec() does that.  This behavior change leads two problems.

 Problem 1:
 Some function in the crash_kexec() path depend on other cpus being
 still online.  If other cpus have been offlined already, they
 doesn't work properly.

  Example:
   panic()
    crash_kexec()
     machine_crash_shutdown()
      octeon_generic_shutdown() // shutdown watchdog for ONLINE cpus
     machine_kexec()

 Problem 2:
 Most of architectures stop other cpus in the machine_crash_shutdown()
 path and save register information at the same time.  However, if
 smp_send_stop() is called before that, we can't save the register
 information.

To solve these problems, this patch changes the timing of calling
the callbacks instead of changing the timing of crash_kexec() if
crash_kexec_post_notifiers boot option is specified.

 Before:
  if (!crash_kexec_post_notifiers)
      crash_kexec()

  smp_send_stop()
  atomic_notifier_call_chain()
  kmsg_dump()

  if (crash_kexec_post_notifiers)
      crash_kexec()

 After:
  crash_kexec()
      machine_crash_shutdown()
      if (crash_kexec_post_notifiers) {
          atomic_notifier_call_chain()
          kmsg_dump()
      }
      machine_kexec()

  smp_send_stop()
  if (!crash_kexec_post_notifiers) {
      atomic_notifier_call_chain()
      kmsg_dump()
  }

NOTE: In current implementation, S/390 stops other cpus in
machine_kexec() but not machine_crash_shutdown().  This means
the notifiers run with other cpus being alive.  In this case,
user should use SMP-safe notifiers only.

Reported-by: Daniel Walker <dwalker@fifo99.com>
Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers)
Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 include/linux/kernel.h              |    1 +
 kernel/kexec.c                      |   39 +++++++++++++++++++++++++++++------
 kernel/panic.c                      |   21 ++++---------------
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1d6f045..1dfaf23 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2627,6 +2627,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Note that this also increases risks of kdump failure,
 			because some panic notifiers can make the crashed
 			kernel more unstable.
+			Currently, panic-notifiers and kmsg-dumpers are
+			called without stopping other cpus on S/390.  If you
+			don't know if those callbacks will work	safely in
+			that case, please don't enable this feature.
 
 	parkbd.port=	[HW] Parallel port number the keyboard adapter is
 			connected to, default is 0.
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5f0be58..718b46b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -251,6 +251,7 @@ static inline void might_fault(void) { }
 #endif
 
 extern struct atomic_notifier_head panic_notifier_list;
+extern bool crash_kexec_post_notifiers;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9c7894f..c3c4279 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -36,6 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
+#include <linux/kmsg_dump.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -85,13 +86,6 @@ struct resource crashk_low_res = {
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-	 * If crash_kexec_post_notifiers is enabled, don't run
-	 * crash_kexec() here yet, which must be run after panic
-	 * notifiers in panic().
-	 */
-	if (crash_kexec_post_notifiers)
-		return 0;
-	/*
 	 * There are 4 panic() calls in do_exit() path, each of which
 	 * corresponds to each of these 4 conditions.
 	 */
@@ -1472,6 +1466,8 @@ void __weak crash_unmap_reserved_pages(void)
 
 void crash_kexec(struct pt_regs *regs, char *msg)
 {
+	int notify_done = 0;
+
 	/* Take the kexec_mutex here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
 	 * we are using after a panic on a different cpu.
@@ -1487,10 +1483,39 @@ void crash_kexec(struct pt_regs *regs, char *msg)
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
+
+			/*
+			 * If you doubt kdump always works fine in any
+			 * situation, "crash_kexec_post_notifiers" offers
+			 * you a chance to run panic_notifiers and dumping
+			 * kmsg before kdump.
+			 *
+			 * NOTE: Since some panic_notifiers can make crashed
+			 * kernel more unstable, it can increase risks of
+			 * the kdump failure too.
+			 *
+			 * NOTE: Some notifiers assume they run in a single
+			 * cpu.  Most of architectures stop other cpus in
+			 * machine_crash_shutdown(), but S/390 does it in
+			 * machine_kexec() at this point.  Please use
+			 * "crash_kexec_post_notifiers" carefully in that
+			 * case.
+			 */
+			if (crash_kexec_post_notifiers) {
+				atomic_notifier_call_chain(
+					&panic_notifier_list, 0, msg);
+				kmsg_dump(KMSG_DUMP_PANIC);
+				notify_done = 1;
+			}
+
 			machine_kexec(kexec_crash_image);
 		}
 		mutex_unlock(&kexec_mutex);
 	}
+
+	if (notify_done == 0)
+		/* Force to call panic notifiers and kmsg dumpers */
+		crash_kexec_post_notifiers = 0;
 }
 
 void crash_kexec_on_oops(struct pt_regs *regs, struct task_struct *p)
diff --git a/kernel/panic.c b/kernel/panic.c
index 93008b6..834e349 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -114,11 +114,8 @@ void panic(const char *fmt, ...)
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
-	 * If we want to run this after calling panic_notifiers, pass
-	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 */
-	if (!crash_kexec_post_notifiers)
-		crash_kexec(NULL, buf);
+	crash_kexec(NULL, buf);
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -131,19 +128,11 @@ void panic(const char *fmt, ...)
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
 	 */
-	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
+	if (!crash_kexec_post_notifiers) {
+		atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	kmsg_dump(KMSG_DUMP_PANIC);
-
-	/*
-	 * If you doubt kdump always works fine in any situation,
-	 * "crash_kexec_post_notifiers" offers you a chance to run
-	 * panic_notifiers and dumping kmsg before kdump.
-	 * Note: since some panic_notifiers can make crashed kernel
-	 * more unstable, it can increase risks of the kdump failure too.
-	 */
-	if (crash_kexec_post_notifiers)
-		crash_kexec(NULL, buf);
+		kmsg_dump(KMSG_DUMP_PANIC);
+	}
 
 	bust_spinlocks(0);
 
