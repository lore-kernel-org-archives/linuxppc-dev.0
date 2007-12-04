Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 32EF8DDE18
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 15:43:51 +1100 (EST)
Date: Tue, 4 Dec 2007 15:43:51 +1100
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix hardware IRQ time accounting problem.
Message-ID: <20071204044351.GQ24243@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Frederik Himpe <fhimpe@telenet.be>, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The commit fa13a5a1f25f671d084d8884be96fc48d9b68275, unconditionally calls
update_process_tick() in system context.  In the deterministic accounting case
this is the correct thing to do.  However, in the non-deterministic accounting
case we need to not do this, and results in the time accounted as
hardware irq time being artificially elevated.

Also this patch collapses 2 consecutive '#ifdef CONFIG_VIRT_CPU_ACCOUNTING'
checks in time.h into for neatness.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
The problem was seen and reported by Johannes Berg  and Frederik Himpe.
Paul, I think this is good for 2.6.24.


 arch/powerpc/kernel/process.c |    2 +-
 include/asm-powerpc/time.h    |   12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 41e13f4..b9d8837 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -350,7 +350,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	local_irq_save(flags);
 
 	account_system_vtime(current);
-	account_process_tick(current, 0);
+	account_process_vtime(current);
 	calculate_steal_time();
 
 	last = _switch(old_thread, new_thread);
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index 780f826..8a2c8db 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -237,18 +237,14 @@ struct cpu_usage {
 
 DECLARE_PER_CPU(struct cpu_usage, cpu_usage_array);
 
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING
-extern void account_process_vtime(struct task_struct *tsk);
-#else
-#define account_process_vtime(tsk)		do { } while (0)
-#endif
-
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING)
 extern void calculate_steal_time(void);
 extern void snapshot_timebases(void);
+#define account_process_vtime(tsk)	account_process_tick(current, 0);
 #else
-#define calculate_steal_time()			do { } while (0)
-#define snapshot_timebases()			do { } while (0)
+#define calculate_steal_time()		do { } while (0)
+#define snapshot_timebases()		do { } while (0)
+#define account_process_vtime(tsk)	do { } while (0)
 #endif
 
 extern void secondary_cpu_time_init(void);
-- 
1.5.3.6


Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
