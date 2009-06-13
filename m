Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1778BB71FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 17:13:50 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE020DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 17:13:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
Date: Sat, 13 Jun 2009 17:10:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib: Provide generic atomic64_t implementation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many processor architectures have no 64-bit atomic instructions, but
we need atomic64_t in order to support the perf_counter subsystem.

This adds an implementation of 64-bit atomic operations using hashed
spinlocks to provide atomicity.  For each atomic operation, the address=

of the atomic64_t variable is hashed to an index into an array of 16
spinlocks.  That spinlock is taken (with interrupts disabled) around th=
e
operation, which can then be coded non-atomically within the lock.

On UP, all the spinlock manipulation goes away and we simply disable
interrupts around each operation.  In fact gcc eliminates the whole
atomic64_lock variable as well.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus, Andrew: OK if this goes in via the powerpc tree?

 include/asm-generic/atomic64.h |   42 ++++++++++
 lib/Kconfig                    |    6 ++
 lib/Makefile                   |    2 +
 lib/atomic64.c                 |  175 ++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 225 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-generic/atomic64.h
 create mode 100644 lib/atomic64.c

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomi=
c64.h
new file mode 100644
index 0000000..b18ce4f
--- /dev/null
+++ b/include/asm-generic/atomic64.h
@@ -0,0 +1,42 @@
+/*
+ * Generic implementation of 64-bit atomics using spinlocks,
+ * useful on processors that don't have 64-bit atomic instructions.
+ *
+ * Copyright =A9 2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_GENERIC_ATOMIC64_H
+#define _ASM_GENERIC_ATOMIC64_H
+
+typedef struct {
+=09long long counter;
+} atomic64_t;
+
+#define ATOMIC64_INIT(i)=09{ (i) }
+
+extern long long atomic64_read(const atomic64_t *v);
+extern void=09 atomic64_set(atomic64_t *v, long long i);
+extern void=09 atomic64_add(long long a, atomic64_t *v);
+extern long long atomic64_add_return(long long a, atomic64_t *v);
+extern void=09 atomic64_sub(long long a, atomic64_t *v);
+extern long long atomic64_sub_return(long long a, atomic64_t *v);
+extern long long atomic64_dec_if_positive(atomic64_t *v);
+extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long lon=
g n);
+extern long long atomic64_xchg(atomic64_t *v, long long new);
+extern int=09 atomic64_add_unless(atomic64_t *v, long long a, long lon=
g u);
+
+#define atomic64_add_negative(a, v)=09(atomic64_add_return((a), (v)) <=
 0)
+#define atomic64_inc(v)=09=09=09atomic64_add(1LL, (v))
+#define atomic64_inc_return(v)=09=09atomic64_add_return(1LL, (v))
+#define atomic64_inc_and_test(v) =09(atomic64_inc_return(v) =3D=3D 0)
+#define atomic64_sub_and_test(a, v)=09(atomic64_sub_return((a), (v)) =3D=
=3D 0)
+#define atomic64_dec(v)=09=09=09atomic64_sub(1LL, (v))
+#define atomic64_dec_return(v)=09=09atomic64_sub_return(1LL, (v))
+#define atomic64_dec_and_test(v)=09(atomic64_dec_return((v)) =3D=3D 0)=

+#define atomic64_inc_not_zero(v) =09atomic64_add_unless((v), 1LL, 0LL)=

+
+#endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/lib/Kconfig b/lib/Kconfig
index 9960be0..bb1326d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -194,4 +194,10 @@ config DISABLE_OBSOLETE_CPUMASK_FUNCTIONS
 config NLATTR
 =09bool
=20
+#
+# Generic 64-bit atomic support is selected if needed
+#
+config GENERIC_ATOMIC64
+       bool
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index 34c5c0e..8e9bcf9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -95,6 +95,8 @@ obj-$(CONFIG_DMA_API_DEBUG) +=3D dma-debug.o
=20
 obj-$(CONFIG_GENERIC_CSUM) +=3D checksum.o
=20
+obj-$(CONFIG_GENERIC_ATOMIC64) +=3D atomic64.o
+
 hostprogs-y=09:=3D gen_crc32table
 clean-files=09:=3D crc32table.h
=20
diff --git a/lib/atomic64.c b/lib/atomic64.c
new file mode 100644
index 0000000..c5e7255
--- /dev/null
+++ b/lib/atomic64.c
@@ -0,0 +1,175 @@
+/*
+ * Generic implementation of 64-bit atomics using spinlocks,
+ * useful on processors that don't have 64-bit atomic instructions.
+ *
+ * Copyright =A9 2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+
+/*
+ * We use a hashed array of spinlocks to provide exclusive access
+ * to each atomic64_t variable.  Since this is expected to used on
+ * systems with small numbers of CPUs (<=3D 4 or so), we use a
+ * relatively small array of 16 spinlocks to avoid wasting too much
+ * memory on the spinlock array.
+ */
+#define NR_LOCKS=0916
+
+/*
+ * Ensure each lock is in a separate cacheline.
+ */
+static union {
+=09spinlock_t lock;
+=09char pad[L1_CACHE_BYTES];
+} atomic64_lock[NR_LOCKS] __cacheline_aligned_in_smp;
+
+static inline spinlock_t *lock_addr(const atomic64_t *v)
+{
+=09unsigned long addr =3D (unsigned long) v;
+
+=09addr >>=3D L1_CACHE_SHIFT;
+=09addr ^=3D (addr >> 8) ^ (addr >> 16);
+=09return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
+}
+
+long long atomic64_read(const atomic64_t *v)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09long long val;
+
+=09spin_lock_irqsave(lock, flags);
+=09val =3D v->counter;
+=09spin_unlock_irqrestore(lock, flags);
+=09return val;
+}
+
+void atomic64_set(atomic64_t *v, long long i)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+
+=09spin_lock_irqsave(lock, flags);
+=09v->counter =3D i;
+=09spin_unlock_irqrestore(lock, flags);
+}
+
+void atomic64_add(long long a, atomic64_t *v)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+
+=09spin_lock_irqsave(lock, flags);
+=09v->counter +=3D a;
+=09spin_unlock_irqrestore(lock, flags);
+}
+
+long long atomic64_add_return(long long a, atomic64_t *v)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09long long val;
+
+=09spin_lock_irqsave(lock, flags);
+=09val =3D v->counter +=3D a;
+=09spin_unlock_irqrestore(lock, flags);
+=09return val;
+}
+
+void atomic64_sub(long long a, atomic64_t *v)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+
+=09spin_lock_irqsave(lock, flags);
+=09v->counter -=3D a;
+=09spin_unlock_irqrestore(lock, flags);
+}
+
+long long atomic64_sub_return(long long a, atomic64_t *v)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09long long val;
+
+=09spin_lock_irqsave(lock, flags);
+=09val =3D v->counter -=3D a;
+=09spin_unlock_irqrestore(lock, flags);
+=09return val;
+}
+
+long long atomic64_dec_if_positive(atomic64_t *v)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09long long val;
+
+=09spin_lock_irqsave(lock, flags);
+=09val =3D v->counter - 1;
+=09if (val >=3D 0)
+=09=09v->counter =3D val;
+=09spin_unlock_irqrestore(lock, flags);
+=09return val;
+}
+
+long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09long long val;
+
+=09spin_lock_irqsave(lock, flags);
+=09val =3D v->counter;
+=09if (val =3D=3D o)
+=09=09v->counter =3D n;
+=09spin_unlock_irqrestore(lock, flags);
+=09return val;
+}
+
+long long atomic64_xchg(atomic64_t *v, long long new)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09long long val;
+
+=09spin_lock_irqsave(lock, flags);
+=09val =3D v->counter;
+=09v->counter =3D new;
+=09spin_unlock_irqrestore(lock, flags);
+=09return val;
+}
+
+int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+{
+=09unsigned long flags;
+=09spinlock_t *lock =3D lock_addr(v);
+=09int ret =3D 1;
+
+=09spin_lock_irqsave(lock, flags);
+=09if (v->counter !=3D u) {
+=09=09v->counter +=3D a;
+=09=09ret =3D 0;
+=09}
+=09spin_unlock_irqrestore(lock, flags);
+=09return ret;
+}
+
+static int init_atomic64_lock(void)
+{
+=09int i;
+
+=09for (i =3D 0; i < NR_LOCKS; ++i)
+=09=09spin_lock_init(&atomic64_lock[i].lock);
+=09return 0;
+}
+
+pure_initcall(init_atomic64_lock);
--=20
1.6.0.4
