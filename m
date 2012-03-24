Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3F29B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 21:30:19 +1100 (EST)
Received: by bkwj10 with SMTP id j10so3226661bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:30:16 -0700 (PDT)
Date: Sat, 24 Mar 2012 14:28:59 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 04/10] sh: Use clear_tasks_mm_cpumask()
Message-ID: <20120324102859.GD29067@lizard>
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

Current CPU hotplug code has some task->mm handling issues:

1. Working with task->mm w/o getting mm or grabing the task lock is
   dangerous as ->mm might disappear (exit_mm() assigns NULL under
   task_lock(), so tasklist lock is not enough).

   We can't use get_task_mm()/mmput() pair as mmput() might sleep,
   so we must take the task lock while handle its mm.

2. Checking for process->mm is not enough because process' main
   thread may exit or detach its mm via use_mm(), but other threads
   may still have a valid mm.

   To fix this we would need to use find_lock_task_mm(), which would
   walk up all threads and returns an appropriate task (with task
   lock held).

clear_tasks_mm_cpumask() has all the issues fixed, so let's use it.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/sh/kernel/smp.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index f624174..2470c83 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -123,7 +123,6 @@ void native_play_dead(void)
 int __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
-	struct task_struct *p;
 	int ret;
 
 	ret = mp_ops->cpu_disable(cpu);
@@ -153,11 +152,7 @@ int __cpu_disable(void)
 	flush_cache_all();
 	local_flush_tlb_all();
 
-	read_lock(&tasklist_lock);
-	for_each_process(p)
-		if (p->mm)
-			cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
-	read_unlock(&tasklist_lock);
+	clear_tasks_mm_cpumask(cpu);
 
 	return 0;
 }
-- 
1.7.9.2
