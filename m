Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com
 [IPv6:2607:f8b0:4002:c01::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16D581A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 21:56:18 +1100 (AEDT)
Received: by yhaf73 with SMTP id f73so7793023yha.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 03:56:13 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
Date: Thu, 12 Mar 2015 18:55:23 +0800
Message-Id: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I know Torsten Duwe has tried to add the ticket spinlock for powerpc
one year ago [1]. But it make no progress due to the conflict between
PPC_SPLPAR and lockref. We still don't find a better way to handle
this. But instead of waiting forever for a perfect solution, can't we
just use the ticket spinlock for the !CONFIG_PPC_SPLPAR?

This is a very rough patch based on arm64 codes. I want to make sure
that this is acceptable before going step further. This just passed
build and boot test on a fsl t4240rdb board. I have done a simple
performance benchmark by running the following command ten times before
and after applying this patch:
	./perf bench sched messaging

                                Before        After
    Averaged total time [sec]:  0.403         0.367

So we can see a ~9% performance enhancing. This patch depends on this
one [2].

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-February/115195.html
[2] http://patchwork.ozlabs.org/patch/447563/

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/spinlock.h       | 79 ++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/spinlock_types.h | 16 +++++++
 arch/powerpc/lib/locks.c                  |  2 +-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index d303cdad2519..3faf2507abe9 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -54,6 +54,7 @@
 #define SYNC_IO
 #endif
 
+#ifdef CONFIG_PPC_SPLPAR
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
@@ -89,6 +90,40 @@ static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
 	return tmp;
 }
 
+#else
+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.owner == lock.next;
+}
+
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	return !arch_spin_value_unlocked(READ_ONCE(*lock));
+}
+
+static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
+{
+	unsigned int tmp;
+	arch_spinlock_t lockval;
+
+	__asm__ __volatile__ (
+"1:	" PPC_LWARX(%0,0,%2,1) "\n\
+	rotlwi		%1,%0,16\n\
+	xor.		%1,%1,%0\n\
+	bne-		2f\n\
+	add		%0,%0,%3\n\
+	stwcx.		%0,0,%2\n\
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"
+	: "=&r" (lockval), "=&r" (tmp)
+	: "r" (lock), "r" (1 << TICKET_SHIFT)
+	: "cr0", "memory");
+
+	return tmp;
+}
+#endif
+
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
@@ -120,6 +155,7 @@ extern void __rw_yield(arch_rwlock_t *lock);
 #define SHARED_PROCESSOR	0
 #endif
 
+#ifdef CONFIG_PPC_SPLPAR
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
@@ -155,16 +191,57 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 		local_irq_restore(flags_dis);
 	}
 }
+#else
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+
+static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	arch_spinlock_t lockval = READ_ONCE(*lock);
+	return (lockval.next - lockval.owner) > 1;
+}
+#define arch_spin_is_contended	arch_spin_is_contended
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	unsigned int tmp;
+	arch_spinlock_t lockval;
+
+	CLEAR_IO_SYNC;
+	__asm__ __volatile__ (
+"1:	" PPC_LWARX(%0,0,%2,1) "\n\
+	add		%1,%0,%4\n\
+	stwcx.		%1,0,%2\n\
+	bne-		1b\n\
+	rotlwi		%1,%0,16\n\
+	cmpw		%1,%0\n\
+	beq		3f\n\
+	rlwinm		%0,%0,16,16,31\n\
+2:	or		1,1,1\n\
+	lhz		%1,0(%3)\n\
+	cmpw		%1,%0\n\
+	bne		2b\n\
+	or		2,2,2\n\
+3:"
+	PPC_ACQUIRE_BARRIER
+	: "=&r" (lockval), "=&r" (tmp)
+	: "r"(lock), "r" (&lock->owner), "r" (1 << TICKET_SHIFT)
+	: "cr0", "memory");
+}
+#endif
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	SYNC_IO;
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
 				PPC_RELEASE_BARRIER: : :"memory");
+#ifdef CONFIG_PPC_SPLPAR
 	lock->slock = 0;
+#else
+	lock->owner++;
+#endif
 }
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_SPLPAR
 extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 #else
 #define arch_spin_unlock_wait(lock) \
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 2351adc4fdc4..1af94f290363 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -5,11 +5,27 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_PPC_SPLPAR
 typedef struct {
 	volatile unsigned int slock;
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#else
+#define TICKET_SHIFT	16
+
+typedef struct {
+#ifdef __BIG_ENDIAN__
+	u16 next;
+	u16 owner;
+#else
+	u16 owner;
+	u16 next;
+#endif
+} __aligned(4) arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
+#endif /*CONFIG_PPC_SPLPAR*/
 
 typedef struct {
 	volatile signed int lock;
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 170a0346f756..fe3d21eeb10d 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -66,7 +66,6 @@ void __rw_yield(arch_rwlock_t *rw)
 	plpar_hcall_norets(H_CONFER,
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
-#endif
 
 void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
@@ -83,3 +82,4 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
 }
 
 EXPORT_SYMBOL(arch_spin_unlock_wait);
+#endif
-- 
2.1.0
