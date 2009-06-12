Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 57E3DB71B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 22:12:31 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4580ADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 22:12:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18994.17381.129339.162342@cargo.ozlabs.ibm.com>
Date: Fri, 12 Jun 2009 22:02:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH RFC] powerpc: Implement atomic64_t for 32-bit processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

32-bit powerpc processors have no 64-bit atomic instructions, but we wi=
ll
need atomic64_t in order to support the perf_counter subsystem on 32-bi=
t
processors.

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
Compile-tested only at this stage, which is why it's [RFC].

 arch/powerpc/include/asm/atomic.h |   29 ++++++
 arch/powerpc/lib/Makefile         |    2 +-
 arch/powerpc/lib/atomic64_32.c    |  173 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 203 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/lib/atomic64_32.c

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/a=
sm/atomic.h
index b401950..45356d6 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -470,6 +470,35 @@ static __inline__ int atomic64_add_unless(atomic64=
_t *v, long a, long u)
=20
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
=20
+#else /* not __powerpc64__ */
+
+typedef struct {
+=09long long counter;
+} atomic64_t;
+
+#define ATOMIC64_INIT(i)=09{ (i) }
+
+extern long long atomic64_read(const atomic64_t *v);
+extern void atomic64_set(atomic64_t *v, long long i);
+extern void atomic64_add(long long a, atomic64_t *v);
+extern long long atomic64_add_return(long long a, atomic64_t *v);
+extern void atomic64_sub(long long a, atomic64_t *v);
+extern long long atomic64_sub_return(long long a, atomic64_t *v);
+extern long long atomic64_dec_if_positive(atomic64_t *v);
+extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long lon=
g n);
+extern long long atomic64_xchg(atomic64_t *v, long long new);
+extern int atomic64_add_unless(atomic64_t *v, long long a, long long u=
);
+
+#define atomic64_add_negative(a, v)=09(atomic64_add_return((a), (v)) <=
 0)
+#define atomic64_inc(v)=09=09=09(atomic64_add(1LL, (v))
+#define atomic64_inc_return(v)=09=09(atomic64_add_return(1LL, (v))
+#define atomic64_inc_and_test(v) =09(atomic64_inc_return(v) =3D=3D 0)
+#define atomic64_sub_and_test(a, v)=09(atomic64_sub_return((a), (v)) =3D=
=3D 0)
+#define atomic64_dec(v)=09=09=09(atomic64_sub(1LL, (v))
+#define atomic64_dec_return(v)=09=09(atomic64_sub_return(1LL, (v))
+#define atomic64_dec_and_test(v)=09(atomic64_dec_return((v)) =3D=3D 0)=

+#define atomic64_inc_not_zero(v) =09atomic64_add_unless((v), 1, 0)
+
 #endif /* __powerpc64__ */
=20
 #include <asm-generic/atomic.h>
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 29b742b..1537f13 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -11,7 +11,7 @@ CFLAGS_REMOVE_feature-fixups.o =3D -pg
=20
 obj-y=09=09=09:=3D string.o alloc.o \
 =09=09=09   checksum_$(CONFIG_WORD_SIZE).o
-obj-$(CONFIG_PPC32)=09+=3D div64.o copy_32.o crtsavres.o
+obj-$(CONFIG_PPC32)=09+=3D div64.o copy_32.o crtsavres.o atomic64_32.o=

 obj-$(CONFIG_HAS_IOMEM)=09+=3D devres.o
=20
 obj-$(CONFIG_PPC64)=09+=3D copypage_64.o copyuser_64.o \
diff --git a/arch/powerpc/lib/atomic64_32.c b/arch/powerpc/lib/atomic64=
_32.c
new file mode 100644
index 0000000..4c24b8a
--- /dev/null
+++ b/arch/powerpc/lib/atomic64_32.c
@@ -0,0 +1,173 @@
+/*
+ * Implementation of 64-bit atomics on 32-bit PowerPC processors.
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
+ * systems with at most 4 processors, we use a relatively small
+ * array of 16 spinlocks.
+ */
+#define NR_LOCKS=0916
+
+/*
+ * Ensure each lock is in a separate cacheline on SMP.
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
