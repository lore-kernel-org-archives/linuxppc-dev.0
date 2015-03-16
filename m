Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x233.google.com (mail-yh0-x233.google.com
 [IPv6:2607:f8b0:4002:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CF011A0A08
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:33:48 +1100 (AEDT)
Received: by yhct68 with SMTP id t68so16349613yhc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 04:33:46 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: add ticket spinlock
Date: Mon, 16 Mar 2015 19:33:17 +0800
Message-Id: <1426505597-1042-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1426505597-1042-1-git-send-email-haokexin@gmail.com>
References: <1426505597-1042-1-git-send-email-haokexin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the simple spinlock to ticket-based. This is based on arm64
codes and only cover the systems which doesn't support shared
processors (a physical processor is multiplexed between several
virtual processors).

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig                      |  5 ++
 arch/powerpc/include/asm/spinlock.h       | 77 ++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/spinlock_types.h | 16 +++++++
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6949d6099d4c..dff19e522b2d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -306,6 +306,11 @@ config PGTABLE_LEVELS
 config PPC_HAS_LOCK_OWNER
 	bool
 
+config PPC_TICKET_LOCK
+	bool
+	depends on !PPC_HAS_LOCK_OWNER
+	default y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index cbc9511df409..40035261d2db 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -59,7 +59,6 @@ extern void __spin_yield(arch_spinlock_t *lock);
 extern void __rw_yield(arch_rwlock_t *lock);
 extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 #else /* CONFIG_PPC_HAS_LOCK_OWNER */
-#define LOCK_TOKEN		1
 #define WRLOCK_TOKEN		(-1)
 #define SHARED_PROCESSOR	0
 #define __spin_yield(x)		barrier()
@@ -81,6 +80,77 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 #define SYNC_IO
 #endif
 
+#ifdef CONFIG_PPC_TICKET_LOCK
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+
+static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	arch_spinlock_t lockval = READ_ONCE(*lock);
+
+	return (lockval.next - lockval.owner) > 1;
+}
+#define arch_spin_is_contended	arch_spin_is_contended
+
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
+static inline unsigned long arch_spin_trylock(arch_spinlock_t *lock)
+{
+	unsigned int tmp;
+	arch_spinlock_t lockval;
+
+	CLEAR_IO_SYNC;
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
+	return !tmp;
+}
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
+2:	or		1,1,1	# HMT_low\n\
+	lhz		%1,0(%3)\n\
+	cmpw		%1,%0\n\
+	bne		2b\n\
+	or		2,2,2	# HMT_medium\n\
+3:"
+	PPC_ACQUIRE_BARRIER
+	: "=&r" (lockval), "=&r" (tmp)
+	: "r"(lock), "r" (&lock->owner), "r" (1 << TICKET_SHIFT)
+	: "cr0", "memory");
+}
+#else
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
@@ -157,13 +227,18 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 		local_irq_restore(flags_dis);
 	}
 }
+#endif
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	SYNC_IO;
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
 				PPC_RELEASE_BARRIER: : :"memory");
+#ifdef CONFIG_PPC_TICKET_LOCK
+	lock->owner++;
+#else
 	lock->slock = 0;
+#endif
 }
 
 /*
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 2351adc4fdc4..371770f906dc 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -5,11 +5,27 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_PPC_TICKET_LOCK
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
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0, 0 }
+#else
 typedef struct {
 	volatile unsigned int slock;
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#endif /* CONFIG_PPC_TICKET_LOCK */
 
 typedef struct {
 	volatile signed int lock;
-- 
2.1.0
