Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B91C01A05B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 14:30:39 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, sam.bobroff@au1.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Russell King <linux@arm.linux.org.uk>, peterz@infradead.org,
 Don Zickus <dzickus@redhat.com>
Subject: [PATCH 1/7] Add die_spin_lock_{irqsave,irqrestore}
Date: Tue, 24 Feb 2015 14:30:28 +1100
Message-Id: <1424748634-9153-2-git-send-email-anton@samba.org>
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many architectures have their own oops locking code that allows
the lock to be taken recursively. Create a common version.

Avoid creating generic locking functions, so they can't be
abused in other parts of the kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 include/linux/die_lock.h | 23 +++++++++++++++++++++++
 lib/Makefile             |  1 +
 lib/die_lock.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 include/linux/die_lock.h
 create mode 100644 lib/die_lock.c

diff --git a/include/linux/die_lock.h b/include/linux/die_lock.h
new file mode 100644
index 0000000..540d09d
--- /dev/null
+++ b/include/linux/die_lock.h
@@ -0,0 +1,23 @@
+#ifndef __LINUX_DIE_LOCK_H
+#define __LINUX_DIE_LOCK_H
+
+#include <linux/typecheck.h>
+
+/**
+ * die_spin_lock_irqsave - lock die spinlock
+ * @flags: interrupt state is saved here
+ *
+ * The die spinlock is used to serialise output during oopses, BUGs and
+ * WARNs. It can be taken recursively so that nested oopses will not
+ * lock up.
+ */
+unsigned long __die_spin_lock_irqsave(void);
+#define die_spin_lock_irqsave(flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		flags = __die_spin_lock_irqsave();	\
+	} while (0)
+
+void die_spin_unlock_irqrestore(unsigned long flags);
+
+#endif /* __LINUX_DIE_LOCK_H */
diff --git a/lib/Makefile b/lib/Makefile
index 3c3b30b..7d87a80 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,6 +28,7 @@ obj-y += bcd.o div64.o sort.o parser.o halfmd4.o debug_locks.o random32.o \
 	 bsearch.o find_last_bit.o find_next_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o
 obj-y += string_helpers.o
+obj-y += die_lock.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += kstrtox.o
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
diff --git a/lib/die_lock.c b/lib/die_lock.c
new file mode 100644
index 0000000..5d2de2e
--- /dev/null
+++ b/lib/die_lock.c
@@ -0,0 +1,43 @@
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+static int die_owner = -1;
+static unsigned int die_nest_count;
+
+unsigned long __die_spin_lock_irqsave(void)
+{
+	unsigned long flags;
+	int cpu;
+
+	/* racy, but better than risking deadlock. */
+	raw_local_irq_save(flags);
+
+	cpu = smp_processor_id();
+	if (!arch_spin_trylock(&die_lock)) {
+		if (cpu != die_owner)
+			arch_spin_lock(&die_lock);
+	}
+	die_nest_count++;
+	die_owner = cpu;
+
+	return flags;
+}
+
+/**
+ * die_spin_unlock_irqrestore - Unlock die spinlock
+ * @flags: interrupt state to restore
+ *
+ * Unlock die spinlock and restore interrupt state. This must be
+ * paired with die_spin_lock_irqsave.
+ */
+void die_spin_unlock_irqrestore(unsigned long flags)
+{
+	die_nest_count--;
+	if (!die_nest_count) {
+		die_owner = -1;
+		/* Nest count reaches zero, release the lock. */
+		arch_spin_unlock(&die_lock);
+	}
+	raw_local_irq_restore(flags);
+}
-- 
2.1.0
