Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22D16B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 21:32:37 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id j10so3226820bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:32:37 -0700 (PDT)
Date: Sat, 24 Mar 2012 14:31:27 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
Message-ID: <20120324103127.GJ29067@lizard>
References: <20120324102609.GA28356@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120324102609.GA28356@lizard>
Cc: Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linux-mm@kvack.org,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is needed so that callers would not get 'context imbalance'
warnings from the sparse tool.

As a side effect, this patch fixes the following sparse warnings:

  CHECK   mm/oom_kill.c
  mm/oom_kill.c:201:28: warning: context imbalance in 'oom_badness' -
  unexpected unlock
  include/linux/rcupdate.h:249:30: warning: context imbalance in
  'dump_tasks' - unexpected unlock
  mm/oom_kill.c:453:9: warning: context imbalance in 'oom_kill_task' -
  unexpected unlock
  CHECK   mm/memcontrol.c
  ...
  mm/memcontrol.c:1130:17: warning: context imbalance in
  'task_in_mem_cgroup' - unexpected unlock

p.s. I know Peter Zijlstra detest the __cond_lock() stuff, but untill
     we have anything better in sparse, let's use it. This particular
     patch helped me to detect one bug that I myself made during
     task->mm fixup series. So, it is useful.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
---
 include/linux/oom.h |   12 +++++++++++-
 mm/oom_kill.c       |    2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 552fba9..26cf628 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -21,6 +21,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/nodemask.h>
@@ -65,7 +66,16 @@ static inline void oom_killer_enable(void)
 	oom_killer_disabled = false;
 }
 
-extern struct task_struct *find_lock_task_mm(struct task_struct *p);
+extern struct task_struct *__find_lock_task_mm(struct task_struct *p);
+
+static inline struct task_struct *find_lock_task_mm(struct task_struct *p)
+{
+	struct task_struct *ret;
+
+	ret = __find_lock_task_mm(p);
+	(void)__cond_lock(&ret->alloc_lock, ret);
+	return ret;
+}
 
 /* sysctls */
 extern int sysctl_oom_dump_tasks;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 2958fd8..0ebb383 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -136,7 +136,7 @@ static bool has_intersects_mems_allowed(struct task_struct *tsk,
  * pointer.  Return p, or any of its subthreads with a valid ->mm, with
  * task_lock() held.
  */
-struct task_struct *find_lock_task_mm(struct task_struct *p)
+struct task_struct *__find_lock_task_mm(struct task_struct *p)
 {
 	struct task_struct *t = p;
 
-- 
1.7.9.2
