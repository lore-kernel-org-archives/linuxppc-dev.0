Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63A0E2C0298
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:40:45 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 22:35:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BD74D3578050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:40:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICSKB13670480
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:28:21 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICea3T001430
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:40:37 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 01/46] percpu_rwlock: Introduce the global reader-writer
 lock backend
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:08:33 +0530
Message-ID: <20130218123833.26245.73434.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A straight-forward (and obvious) algorithm to implement Per-CPU Reader-Writer
locks can also lead to too many deadlock possibilities which can make it very
hard/impossible to use. This is explained in the example below, which helps
justify the need for a different algorithm to implement flexible Per-CPU
Reader-Writer locks.

We can use global rwlocks as shown below safely, without fear of deadlocks:

Readers:

         CPU 0                                CPU 1
         ------                               ------

1.    spin_lock(&random_lock);             read_lock(&my_rwlock);


2.    read_lock(&my_rwlock);               spin_lock(&random_lock);


Writer:

         CPU 2:
         ------

       write_lock(&my_rwlock);


We can observe that there is no possibility of deadlocks or circular locking
dependencies here. Its perfectly safe.

Now consider a blind/straight-forward conversion of global rwlocks to per-CPU
rwlocks like this:

The reader locks its own per-CPU rwlock for read, and proceeds.

Something like: read_lock(per-cpu rwlock of this cpu);

The writer acquires all per-CPU rwlocks for write and only then proceeds.

Something like:

  for_each_online_cpu(cpu)
	write_lock(per-cpu rwlock of 'cpu');


Now let's say that for performance reasons, the above scenario (which was
perfectly safe when using global rwlocks) was converted to use per-CPU rwlocks.


         CPU 0                                CPU 1
         ------                               ------

1.    spin_lock(&random_lock);             read_lock(my_rwlock of CPU 1);


2.    read_lock(my_rwlock of CPU 0);       spin_lock(&random_lock);


Writer:

         CPU 2:
         ------

      for_each_online_cpu(cpu)
        write_lock(my_rwlock of 'cpu');


Consider what happens if the writer begins his operation in between steps 1
and 2 at the reader side. It becomes evident that we end up in a (previously
non-existent) deadlock due to a circular locking dependency between the 3
entities, like this:


(holds              Waiting for
 random_lock) CPU 0 -------------> CPU 2  (holds my_rwlock of CPU 0
                                               for write)
               ^                   |
               |                   |
        Waiting|                   | Waiting
          for  |                   |  for
               |                   V
                ------ CPU 1 <------

                (holds my_rwlock of
                 CPU 1 for read)



So obviously this "straight-forward" way of implementing percpu rwlocks is
deadlock-prone. One simple measure for (or characteristic of) safe percpu
rwlock should be that if a user replaces global rwlocks with per-CPU rwlocks
(for performance reasons), he shouldn't suddenly end up in numerous deadlock
possibilities which never existed before. The replacement should continue to
remain safe, and perhaps improve the performance.

Observing the robustness of global rwlocks in providing a fair amount of
deadlock safety, we implement per-CPU rwlocks as nothing but global rwlocks,
as a first step.


Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/percpu-rwlock.h |   49 ++++++++++++++++++++++++++++++++
 lib/Kconfig                   |    3 ++
 lib/Makefile                  |    1 +
 lib/percpu-rwlock.c           |   63 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 include/linux/percpu-rwlock.h
 create mode 100644 lib/percpu-rwlock.c

diff --git a/include/linux/percpu-rwlock.h b/include/linux/percpu-rwlock.h
new file mode 100644
index 0000000..0caf81f
--- /dev/null
+++ b/include/linux/percpu-rwlock.h
@@ -0,0 +1,49 @@
+/*
+ * Flexible Per-CPU Reader-Writer Locks
+ * (with relaxed locking rules and reduced deadlock-possibilities)
+ *
+ * Copyright (C) IBM Corporation, 2012-2013
+ * Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
+ *
+ * With lots of invaluable suggestions from:
+ *	   Oleg Nesterov <oleg@redhat.com>
+ *	   Tejun Heo <tj@kernel.org>
+ *
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
+ */
+
+#ifndef _LINUX_PERCPU_RWLOCK_H
+#define _LINUX_PERCPU_RWLOCK_H
+
+#include <linux/percpu.h>
+#include <linux/lockdep.h>
+#include <linux/spinlock.h>
+
+struct percpu_rwlock {
+	rwlock_t			global_rwlock;
+};
+
+extern void percpu_read_lock(struct percpu_rwlock *);
+extern void percpu_read_unlock(struct percpu_rwlock *);
+
+extern void percpu_write_lock(struct percpu_rwlock *);
+extern void percpu_write_unlock(struct percpu_rwlock *);
+
+extern int __percpu_init_rwlock(struct percpu_rwlock *,
+				const char *, struct lock_class_key *);
+
+#define percpu_init_rwlock(pcpu_rwlock)					\
+({	static struct lock_class_key rwlock_key;			\
+	__percpu_init_rwlock(pcpu_rwlock, #pcpu_rwlock, &rwlock_key);	\
+})
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 75cdb77..32fb0b9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -45,6 +45,9 @@ config STMP_DEVICE
 config PERCPU_RWSEM
 	boolean
 
+config PERCPU_RWLOCK
+	boolean
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 02ed6c0..1854b5e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_PERCPU_RWSEM) += percpu-rwsem.o
+lib-$(CONFIG_PERCPU_RWLOCK) += percpu-rwlock.o
 
 CFLAGS_hweight.o = $(subst $(quote),,$(CONFIG_ARCH_HWEIGHT_CFLAGS))
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
new file mode 100644
index 0000000..111a238
--- /dev/null
+++ b/lib/percpu-rwlock.c
@@ -0,0 +1,63 @@
+/*
+ * Flexible Per-CPU Reader-Writer Locks
+ * (with relaxed locking rules and reduced deadlock-possibilities)
+ *
+ * Copyright (C) IBM Corporation, 2012-2013
+ * Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
+ *
+ * With lots of invaluable suggestions from:
+ *	   Oleg Nesterov <oleg@redhat.com>
+ *	   Tejun Heo <tj@kernel.org>
+ *
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
+ */
+
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/lockdep.h>
+#include <linux/percpu-rwlock.h>
+#include <linux/errno.h>
+
+
+int __percpu_init_rwlock(struct percpu_rwlock *pcpu_rwlock,
+			 const char *name, struct lock_class_key *rwlock_key)
+{
+	/* ->global_rwlock represents the whole percpu_rwlock for lockdep */
+#ifdef CONFIG_DEBUG_SPINLOCK
+	__rwlock_init(&pcpu_rwlock->global_rwlock, name, rwlock_key);
+#else
+	pcpu_rwlock->global_rwlock =
+			__RW_LOCK_UNLOCKED(&pcpu_rwlock->global_rwlock);
+#endif
+	return 0;
+}
+
+void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
+{
+	read_lock(&pcpu_rwlock->global_rwlock);
+}
+
+void percpu_read_unlock(struct percpu_rwlock *pcpu_rwlock)
+{
+	read_unlock(&pcpu_rwlock->global_rwlock);
+}
+
+void percpu_write_lock(struct percpu_rwlock *pcpu_rwlock)
+{
+	write_lock(&pcpu_rwlock->global_rwlock);
+}
+
+void percpu_write_unlock(struct percpu_rwlock *pcpu_rwlock)
+{
+	write_unlock(&pcpu_rwlock->global_rwlock);
+}
+
