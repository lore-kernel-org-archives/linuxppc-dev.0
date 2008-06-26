Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4ECADEA56
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:39:05 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 41/60] microblaze_v4: atomic.h bitops.h byteorder.h
Date: Thu, 26 Jun 2008 14:30:10 +0200
Message-Id: <1214483429-32360-42-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-41-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
	<1214483429-32360-33-git-send-email-monstr@seznam.cz>
	<1214483429-32360-34-git-send-email-monstr@seznam.cz>
	<1214483429-32360-35-git-send-email-monstr@seznam.cz>
	<1214483429-32360-36-git-send-email-monstr@seznam.cz>
	<1214483429-32360-37-git-send-email-monstr@seznam.cz>
	<1214483429-32360-38-git-send-email-monstr@seznam.cz>
	<1214483429-32360-39-git-send-email-monstr@seznam.cz>
	<1214483429-32360-40-git-send-email-monstr@seznam.cz>
	<1214483429-32360-41-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 include/asm-microblaze/atomic.h    |  106 ++++++++++++++++++++++++++++++++++++
 include/asm-microblaze/bitops.h    |   27 +++++++++
 include/asm-microblaze/byteorder.h |   21 +++++++
 3 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/atomic.h
 create mode 100644 include/asm-microblaze/bitops.h
 create mode 100644 include/asm-microblaze/byteorder.h

diff --git a/include/asm-microblaze/atomic.h b/include/asm-microblaze/atomic.h
new file mode 100644
index 0000000..754688a
--- /dev/null
+++ b/include/asm-microblaze/atomic.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_ATOMIC_H
+#define _ASM_MICROBLAZE_ATOMIC_H
+
+#include <linux/compiler.h> /* likely */
+#include <asm/system.h> /* local_irq_XXX and friends */
+
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)		{ (i) }
+#define atomic_read(v)		((v)->counter)
+#define atomic_set(v, i)	(((v)->counter) = (i))
+
+#define atomic_inc(v)		(atomic_add_return(1, (v)))
+#define atomic_dec(v)		(atomic_sub_return(1, (v)))
+
+#define atomic_add(i, v)	(atomic_add_return(i, (v)))
+#define atomic_sub(i, v)	(atomic_sub_return(i, (v)))
+
+#define atomic_inc_return(v)	(atomic_add_return(1, (v)))
+#define atomic_dec_return(v)	(atomic_sub_return(1, (v)))
+
+#define atomic_inc_and_test(v)	(atomic_add_return(1, (v)) == 0)
+#define atomic_dec_and_test(v)	(atomic_sub_return(1, (v)) == 0)
+
+#define atomic_inc_not_zero(v)	(atomic_add_unless((v), 1, 0))
+
+#define atomic_sub_and_test(i, v) (atomic_sub_return((i), (v)) == 0)
+
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline int atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int c, old;
+
+	c = atomic_read(v);
+	while (c != u && (old = atomic_cmpxchg((v), c, c + a)) != c)
+		c = old;
+	return c != u;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	*addr &= ~mask;
+	local_irq_restore(flags);
+}
+
+/**
+ * atomic_add_return - add and return
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	unsigned long flags;
+	int val;
+
+	local_irq_save(flags);
+	val = v->counter;
+	v->counter = val += i;
+	local_irq_restore(flags);
+
+	return val;
+}
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_add_return(-i, v);
+}
+
+#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
+/* Atomic operations are already serializing */
+#define smp_mb__before_atomic_dec()	barrier()
+#define smp_mb__after_atomic_dec()	barrier()
+#define smp_mb__before_atomic_inc()	barrier()
+#define smp_mb__after_atomic_inc()	barrier()
+
+#include <asm-generic/atomic.h>
+
+#endif /* _ASM_MICROBLAZE_ATOMIC_H */
diff --git a/include/asm-microblaze/bitops.h b/include/asm-microblaze/bitops.h
new file mode 100644
index 0000000..98ffb61
--- /dev/null
+++ b/include/asm-microblaze/bitops.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_BITOPS_H
+#define _ASM_MICROBLAZE_BITOPS_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ */
+
+#include <linux/autoconf.h>
+#include <asm/byteorder.h> /* swab32 */
+#include <asm/system.h> /* save_flags */
+
+/*
+ * clear_bit() doesn't provide any barrier for the compiler.
+ */
+#define smp_mb__before_clear_bit()	barrier()
+#define smp_mb__after_clear_bit()	barrier()
+#include <asm-generic/bitops.h>
+
+#endif /* _ASM_MICROBLAZE_BITOPS_H */
diff --git a/include/asm-microblaze/byteorder.h b/include/asm-microblaze/byteorder.h
new file mode 100644
index 0000000..dad9204
--- /dev/null
+++ b/include/asm-microblaze/byteorder.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_BYTEORDER_H
+#define _ASM_MICROBLAZE_BYTEORDER_H
+
+#include <asm/types.h>
+
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__) || defined(__KERNEL__)
+#define __BYTEORDER_HAS_U64__
+#define __SWAB_64_THRU_32__
+#endif
+
+#include <linux/byteorder/big_endian.h>
+
+#endif /* _ASM_MICROBLAZE_BYTEORDER_H */
-- 
1.5.4.GIT
