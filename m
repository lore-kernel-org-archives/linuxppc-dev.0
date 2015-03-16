Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB8DE1A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:33:40 +1100 (AEDT)
Received: by ykcn8 with SMTP id n8so16287259ykc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 04:33:39 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: introduce PPC_HAS_LOCK_OWNER
Date: Mon, 16 Mar 2015 19:33:15 +0800
Message-Id: <1426505597-1042-2-git-send-email-haokexin@gmail.com>
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

On a system with shared processors (a physical processor is multiplexed
between several virtual processors), we encode the lock owner into the
lock token in order to avoid unnecessarily spinning on a lock if the
lock holder isn't currently scheduled on a physical processor.

In the current kernel, we unconditionally encode the lock owner into
the lock token for all the ppc64 platforms no matter it is a shared
processor or not. This introduces a new kernel option to distinguish
the platforms which need this hack.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig                   |  3 +++
 arch/powerpc/include/asm/spinlock.h    | 12 ++++++++----
 arch/powerpc/lib/locks.c               |  4 ++--
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9b780e0d2c18..6949d6099d4c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -303,6 +303,9 @@ config PGTABLE_LEVELS
 	default 3 if PPC_64K_PAGES
 	default 4
 
+config PPC_HAS_LOCK_OWNER
+	bool
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 4dbe072eecbe..38f40ea63a8c 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -30,7 +30,7 @@
 
 #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_HAS_LOCK_OWNER
 /* use 0x800000yy when locked, where yy == CPU number */
 #ifdef __BIG_ENDIAN__
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
@@ -109,7 +109,7 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
  * value.
  */
 
-#if defined(CONFIG_PPC_SPLPAR)
+#if defined(CONFIG_PPC_HAS_LOCK_OWNER)
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
 extern void __spin_yield(arch_spinlock_t *lock);
@@ -164,7 +164,7 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	lock->slock = 0;
 }
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_HAS_LOCK_OWNER
 extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 #else
 #define arch_spin_unlock_wait(lock) \
@@ -187,9 +187,13 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 
 #ifdef CONFIG_PPC64
 #define __DO_SIGN_EXTEND	"extsw	%0,%0\n"
-#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
 #else
 #define __DO_SIGN_EXTEND
+#endif
+
+#ifdef CONFIG_PPC_HAS_LOCK_OWNER
+#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
+#else
 #define WRLOCK_TOKEN		(-1)
 #endif
 
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 170a0346f756..66513b3e9b0e 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -19,7 +19,7 @@
 #include <linux/smp.h>
 
 /* waiting for a spinlock... */
-#if defined(CONFIG_PPC_SPLPAR)
+#if defined(CONFIG_PPC_HAS_LOCK_OWNER)
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
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
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a758a9c3bbba..5402fcc30c3e 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -27,6 +27,7 @@ config PPC_PSERIES
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
+	select PPC_HAS_LOCK_OWNER
 	default n
 	help
 	  Enabling this option will make the kernel run more efficiently
-- 
2.1.0
