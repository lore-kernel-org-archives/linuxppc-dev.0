Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84CCC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:30:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E2120857
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 20:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wVLz2rP6zDqDx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:30:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wSXJ0P5BzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 06:08:48 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3794281138;
 Thu,  7 Feb 2019 19:08:45 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF6061146;
 Thu,  7 Feb 2019 19:08:43 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 02/22] locking/lock_events: Make lock_events available for
 all archs & other locks
Date: Thu,  7 Feb 2019 14:07:06 -0500
Message-Id: <1549566446-27967-3-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 07 Feb 2019 19:08:46 +0000 (UTC)
X-Mailman-Approved-At: Fri, 08 Feb 2019 07:26:12 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The QUEUED_LOCK_STAT option to report queued spinlocks event counts
was previously allowed only on x86 architecture. To make the locking
event counting code more useful, it is now renamed to a more generic
LOCK_EVENT_COUNTS config option. This new option will be available to
all the architectures that use qspinlock at the moment.

Other locking code can now start to use the generic locking event
counting code by including lock_events.h and put the new locking event
names into the lock_events_list.h header file.

My experience with lock event counting is that it gives valuable insight
on how the locking code works and what can be done to make it better. I
would like to extend this benefit to other locking code like mutex and
rwsem in the near future.

The PV qspinlock specific code will stay in qspinlock_stat.h. The
locking event counters will now reside in the <debugfs>/lock_event_counts
directory.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/Kconfig                    |  10 +++
 arch/x86/Kconfig                |   8 ---
 kernel/locking/Makefile         |   1 +
 kernel/locking/lock_events.c    | 153 ++++++++++++++++++++++++++++++++++++++++
 kernel/locking/lock_events.h    |   6 +-
 kernel/locking/qspinlock_stat.h | 141 ++++--------------------------------
 6 files changed, 179 insertions(+), 140 deletions(-)
 create mode 100644 kernel/locking/lock_events.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f02132..af147c2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -888,6 +888,16 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 config ARCH_USE_MEMREMAP_PROT
 	bool
 
+config LOCK_EVENT_COUNTS
+	bool "Locking event counts collection"
+	depends on DEBUG_FS
+	depends on QUEUED_SPINLOCKS
+	---help---
+	  Enable light-weight counting of various locking related events
+	  in the system with minimal performance impact. This reduces
+	  the chance of application behavior change because of timing
+	  differences. The counts are reported via debugfs.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a7e7a60..e4f620f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -784,14 +784,6 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
-config QUEUED_LOCK_STAT
-	bool "Paravirt queued spinlock statistics"
-	depends on PARAVIRT_SPINLOCKS && DEBUG_FS
-	---help---
-	  Enable the collection of statistical data on the slowpath
-	  behavior of paravirtualized queued spinlocks and report
-	  them on debugfs.
-
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 392c7f2..f2257d7 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem-xadd.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
 obj-$(CONFIG_LOCK_TORTURE_TEST) += locktorture.o
 obj-$(CONFIG_WW_MUTEX_SELFTEST) += test-ww_mutex.o
+obj-$(CONFIG_LOCK_EVENT_COUNTS) += lock_events.o
diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
new file mode 100644
index 0000000..71c36d1
--- /dev/null
+++ b/kernel/locking/lock_events.c
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors: Waiman Long <waiman.long@hpe.com>
+ */
+
+/*
+ * Collect locking event counts
+ */
+#include <linux/debugfs.h>
+#include <linux/sched.h>
+#include <linux/sched/clock.h>
+#include <linux/fs.h>
+
+#include "lock_events.h"
+
+#undef  LOCK_EVENT
+#define LOCK_EVENT(name)	[LOCKEVENT_ ## name] = #name,
+
+#define LOCK_EVENTS_DIR		"lock_event_counts"
+
+/*
+ * When CONFIG_LOCK_EVENT_COUNTS is enabled, event counts of different
+ * types of locks will be reported under the <debugfs>/lock_event_counts/
+ * directory. See lock_events_list.h for the list of available locking
+ * events.
+ *
+ * Writing to the special ".reset_counts" file will reset all the above
+ * locking event counts. This is a very slow operation and so should not
+ * be done frequently.
+ *
+ * These event counts are implemented as per-cpu variables which are
+ * summed and computed whenever the corresponding debugfs files are read. This
+ * minimizes added overhead making the counts usable even in a production
+ * environment.
+ */
+static const char * const lockevent_names[lockevent_num + 1] = {
+
+#include "lock_events_list.h"
+
+	[LOCKEVENT_reset_cnts] = ".reset_counts",
+};
+
+/*
+ * Per-cpu counts
+ */
+DEFINE_PER_CPU(unsigned long, lockevents[lockevent_num]);
+
+/*
+ * The lockevent_read() function can be overridden.
+ */
+ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	char buf[64];
+	int cpu, id, len;
+	u64 sum = 0;
+
+	/*
+	 * Get the counter ID stored in file->f_inode->i_private
+	 */
+	id = (long)file_inode(file)->i_private;
+
+	if (id >= lockevent_num)
+		return -EBADF;
+
+	for_each_possible_cpu(cpu)
+		sum += per_cpu(lockevents[id], cpu);
+	len = snprintf(buf, sizeof(buf) - 1, "%llu\n", sum);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+/*
+ * Function to handle write request
+ *
+ * When idx = reset_cnts, reset all the counts.
+ */
+static ssize_t lockevent_write(struct file *file, const char __user *user_buf,
+			   size_t count, loff_t *ppos)
+{
+	int cpu;
+
+	/*
+	 * Get the counter ID stored in file->f_inode->i_private
+	 */
+	if ((long)file_inode(file)->i_private != LOCKEVENT_reset_cnts)
+		return count;
+
+	for_each_possible_cpu(cpu) {
+		int i;
+		unsigned long *ptr = per_cpu_ptr(lockevents, cpu);
+
+		for (i = 0 ; i < lockevent_num; i++)
+			WRITE_ONCE(ptr[i], 0);
+	}
+	return count;
+}
+
+/*
+ * Debugfs data structures
+ */
+static const struct file_operations fops_lockevent = {
+	.read = lockevent_read,
+	.write = lockevent_write,
+	.llseek = default_llseek,
+};
+
+/*
+ * Initialize debugfs for the locking event counts.
+ */
+static int __init init_lockevent_counts(void)
+{
+	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
+	int i;
+
+	if (!d_counts)
+		goto out;
+
+	/*
+	 * Create the debugfs files
+	 *
+	 * As reading from and writing to the stat files can be slow, only
+	 * root is allowed to do the read/write to limit impact to system
+	 * performance.
+	 */
+	for (i = 0; i < lockevent_num; i++)
+		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
+					 (void *)(long)i, &fops_lockevent))
+			goto fail_undo;
+
+	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
+				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
+				 &fops_lockevent))
+		goto fail_undo;
+
+	return 0;
+fail_undo:
+	debugfs_remove_recursive(d_counts);
+out:
+	pr_warn("Could not create '%s' debugfs entries\n", LOCK_EVENTS_DIR);
+	return -ENOMEM;
+}
+fs_initcall(init_lockevent_counts);
diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index 4009e07..d965470 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -21,7 +21,7 @@ enum lock_events {
 	LOCKEVENT_reset_cnts = lockevent_num,
 };
 
-#ifdef CONFIG_QUEUED_LOCK_STAT
+#ifdef CONFIG_LOCK_EVENT_COUNTS
 /*
  * Per-cpu counters
  */
@@ -46,10 +46,10 @@ static inline void __lockevent_add(enum lock_events event, int inc)
 
 #define lockevent_add(ev, c)	__lockevent_add(LOCKEVENT_ ##ev, c)
 
-#else  /* CONFIG_QUEUED_LOCK_STAT */
+#else  /* CONFIG_LOCK_EVENT_COUNTS */
 
 #define lockevent_inc(ev)
 #define lockevent_add(ev, c)
 #define lockevent_cond_inc(ev, c)
 
-#endif /* CONFIG_QUEUED_LOCK_STAT */
+#endif /* CONFIG_LOCK_EVENT_COUNTS */
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 1db5b37..5415267 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -9,76 +9,29 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * Authors: Waiman Long <waiman.long@hpe.com>
+ * Authors: Waiman Long <longman@redhat.com>
  */
 
-/*
- * When queued spinlock statistical counters are enabled, the following
- * debugfs files will be created for reporting the counter values:
- *
- * <debugfs>/qlockstat/
- *   pv_hash_hops	- average # of hops per hashing operation
- *   pv_kick_unlock	- # of vCPU kicks issued at unlock time
- *   pv_kick_wake	- # of vCPU kicks used for computing pv_latency_wake
- *   pv_latency_kick	- average latency (ns) of vCPU kick operation
- *   pv_latency_wake	- average latency (ns) from vCPU kick to wakeup
- *   pv_lock_stealing	- # of lock stealing operations
- *   pv_spurious_wakeup	- # of spurious wakeups in non-head vCPUs
- *   pv_wait_again	- # of wait's after a queue head vCPU kick
- *   pv_wait_early	- # of early vCPU wait's
- *   pv_wait_head	- # of vCPU wait's at the queue head
- *   pv_wait_node	- # of vCPU wait's at a non-head queue node
- *   lock_pending	- # of locking operations via pending code
- *   lock_slowpath	- # of locking operations via MCS lock queue
- *   lock_use_node2	- # of locking operations that use 2nd per-CPU node
- *   lock_use_node3	- # of locking operations that use 3rd per-CPU node
- *   lock_use_node4	- # of locking operations that use 4th per-CPU node
- *   lock_no_node	- # of locking operations without using per-CPU node
- *
- * Subtracting lock_use_node[234] from lock_slowpath will give you
- * lock_use_node1.
- *
- * Writing to the special ".reset_counts" file will reset all the above
- * counter values.
- *
- * These statistical counters are implemented as per-cpu variables which are
- * summed and computed whenever the corresponding debugfs files are read. This
- * minimizes added overhead making the counters usable even in a production
- * environment.
- *
- * There may be slight difference between pv_kick_wake and pv_kick_unlock.
- */
 #include "lock_events.h"
 
-#ifdef CONFIG_QUEUED_LOCK_STAT
+#ifdef CONFIG_LOCK_EVENT_COUNTS
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 /*
- * Collect pvqspinlock statistics
+ * Collect pvqspinlock locking event counts
  */
-#include <linux/debugfs.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/fs.h>
 
 #define EVENT_COUNT(ev)	lockevents[LOCKEVENT_ ## ev]
 
-#undef  LOCK_EVENT
-#define LOCK_EVENT(name)	[LOCKEVENT_ ## name] = #name,
-
-static const char * const lockevent_names[lockevent_num + 1] = {
-
-#include "lock_events_list.h"
-
-	[LOCKEVENT_reset_cnts] = ".reset_counts",
-};
-
 /*
- * Per-cpu counters
+ * PV specific per-cpu counter
  */
-DEFINE_PER_CPU(unsigned long, lockevents[lockevent_num]);
 static DEFINE_PER_CPU(u64, pv_kick_time);
 
 /*
- * Function to read and return the qlock statistical counter values
+ * Function to read and return the PV qspinlock counts.
  *
  * The following counters are handled specially:
  * 1. pv_latency_kick
@@ -88,8 +41,8 @@
  * 3. pv_hash_hops
  *    Average hops/hash = pv_hash_hops/pv_kick_unlock
  */
-static ssize_t lockevent_read(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+ssize_t lockevent_read(struct file *file, char __user *user_buf,
+		       size_t count, loff_t *ppos)
 {
 	char buf[64];
 	int cpu, id, len;
@@ -150,78 +103,6 @@ static ssize_t lockevent_read(struct file *file, char __user *user_buf,
 }
 
 /*
- * Function to handle write request
- *
- * When id = .reset_cnts, reset all the counter values.
- */
-static ssize_t lockevent_write(struct file *file, const char __user *user_buf,
-			   size_t count, loff_t *ppos)
-{
-	int cpu;
-
-	/*
-	 * Get the counter ID stored in file->f_inode->i_private
-	 */
-	if ((long)file_inode(file)->i_private != LOCKEVENT_reset_cnts)
-		return count;
-
-	for_each_possible_cpu(cpu) {
-		int i;
-		unsigned long *ptr = per_cpu_ptr(lockevents, cpu);
-
-		for (i = 0 ; i < lockevent_num; i++)
-			WRITE_ONCE(ptr[i], 0);
-	}
-	return count;
-}
-
-/*
- * Debugfs data structures
- */
-static const struct file_operations fops_lockevent = {
-	.read = lockevent_read,
-	.write = lockevent_write,
-	.llseek = default_llseek,
-};
-
-/*
- * Initialize debugfs for the qspinlock statistical counters
- */
-static int __init init_qspinlock_stat(void)
-{
-	struct dentry *d_counts = debugfs_create_dir("qlockstat", NULL);
-	int i;
-
-	if (!d_counts)
-		goto out;
-
-	/*
-	 * Create the debugfs files
-	 *
-	 * As reading from and writing to the stat files can be slow, only
-	 * root is allowed to do the read/write to limit impact to system
-	 * performance.
-	 */
-	for (i = 0; i < lockevent_num; i++)
-		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
-					 (void *)(long)i, &fops_lockevent))
-			goto fail_undo;
-
-	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
-				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
-				 &fops_lockevent))
-		goto fail_undo;
-
-	return 0;
-fail_undo:
-	debugfs_remove_recursive(d_counts);
-out:
-	pr_warn("Could not create 'qlockstat' debugfs entries\n");
-	return -ENOMEM;
-}
-fs_initcall(init_qspinlock_stat);
-
-/*
  * PV hash hop count
  */
 static inline void lockevent_pv_hop(int hopcnt)
@@ -260,8 +141,10 @@ static inline void __pv_wait(u8 *ptr, u8 val)
 #define pv_kick(c)	__pv_kick(c)
 #define pv_wait(p, v)	__pv_wait(p, v)
 
-#else /* CONFIG_QUEUED_LOCK_STAT */
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+#else /* CONFIG_LOCK_EVENT_COUNTS */
 
 static inline void lockevent_pv_hop(int hopcnt)	{ }
 
-#endif /* CONFIG_QUEUED_LOCK_STAT */
+#endif /* CONFIG_LOCK_EVENT_COUNTS */
-- 
1.8.3.1

