Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD0BCB6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 21:30:56 +1100 (EST)
Received: by bkwj10 with SMTP id j10so3226820bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:30:53 -0700 (PDT)
Date: Sat, 24 Mar 2012 14:29:39 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 05/10] blackfin: A couple of task->mm handling fixes
Message-ID: <20120324102939.GE29067@lizard>
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

The patch fixes two problems:

1. Working with task->mm w/o getting mm or grabing the task lock is
   dangerous as ->mm might disappear (exit_mm() assigns NULL under
   task_lock(), so tasklist lock is not enough).

   We can't use get_task_mm()/mmput() pair as mmput() might sleep,
   so we have to take the task lock while handle its mm.

2. Checking for process->mm is not enough because process' main
   thread may exit or detach its mm via use_mm(), but other threads
   may still have a valid mm.

   To catch this we use find_lock_task_mm(), which walks up all
   threads and returns an appropriate task (with task lock held).

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/blackfin/kernel/trace.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
index 050db44..5102cdf 100644
--- a/arch/blackfin/kernel/trace.c
+++ b/arch/blackfin/kernel/trace.c
@@ -10,6 +10,8 @@
 #include <linux/hardirq.h>
 #include <linux/thread_info.h>
 #include <linux/mm.h>
+#include <linux/oom.h>
+#include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
@@ -27,7 +29,6 @@ void decode_address(char *buf, unsigned long address)
 	struct task_struct *p;
 	struct mm_struct *mm;
 	unsigned long flags, offset;
-	unsigned char in_atomic = (bfin_read_IPEND() & 0x10) || in_atomic();
 	struct rb_node *n;
 
 #ifdef CONFIG_KALLSYMS
@@ -113,15 +114,15 @@ void decode_address(char *buf, unsigned long address)
 	 */
 	write_lock_irqsave(&tasklist_lock, flags);
 	for_each_process(p) {
-		mm = (in_atomic ? p->mm : get_task_mm(p));
-		if (!mm)
-			continue;
+		struct task_struct *t;
 
-		if (!down_read_trylock(&mm->mmap_sem)) {
-			if (!in_atomic)
-				mmput(mm);
+		t = find_lock_task_mm(p);
+		if (!t)
 			continue;
-		}
+
+		mm = t->mm;
+		if (!down_read_trylock(&mm->mmap_sem))
+			goto __continue;
 
 		for (n = rb_first(&mm->mm_rb); n; n = rb_next(n)) {
 			struct vm_area_struct *vma;
@@ -130,7 +131,7 @@ void decode_address(char *buf, unsigned long address)
 
 			if (address >= vma->vm_start && address < vma->vm_end) {
 				char _tmpbuf[256];
-				char *name = p->comm;
+				char *name = t->comm;
 				struct file *file = vma->vm_file;
 
 				if (file) {
@@ -163,8 +164,7 @@ void decode_address(char *buf, unsigned long address)
 						name, vma->vm_start, vma->vm_end);
 
 				up_read(&mm->mmap_sem);
-				if (!in_atomic)
-					mmput(mm);
+				task_unlock(t);
 
 				if (buf[0] == '\0')
 					sprintf(buf, "[ %s ] dynamic memory", name);
@@ -174,8 +174,8 @@ void decode_address(char *buf, unsigned long address)
 		}
 
 		up_read(&mm->mmap_sem);
-		if (!in_atomic)
-			mmput(mm);
+__continue:
+		task_unlock(t);
 	}
 
 	/*
-- 
1.7.9.2
