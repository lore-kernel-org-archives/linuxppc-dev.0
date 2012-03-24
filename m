Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA258B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 21:29:39 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id j10so3226350bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:29:39 -0700 (PDT)
Date: Sat, 24 Mar 2012 14:28:31 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 03/10] powerpc: Use clear_tasks_mm_cpumask()
Message-ID: <20120324102831.GC29067@lizard>
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
 arch/powerpc/mm/mmu_context_nohash.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 5b63bd3..e779642 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -333,9 +333,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 					    unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned int)(long)hcpu;
-#ifdef CONFIG_HOTPLUG_CPU
-	struct task_struct *p;
-#endif
+
 	/* We don't touch CPU 0 map, it's allocated at aboot and kept
 	 * around forever
 	 */
@@ -358,12 +356,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 		stale_map[cpu] = NULL;
 
 		/* We also clear the cpu_vm_mask bits of CPUs going away */
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->mm)
-				cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
-		}
-		read_unlock(&tasklist_lock);
+		clear_tasks_mm_cpumask(cpu);
 	break;
 #endif /* CONFIG_HOTPLUG_CPU */
 	}
-- 
1.7.9.2
