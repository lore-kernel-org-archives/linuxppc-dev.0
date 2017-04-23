Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [65.50.211.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9lQX01QszDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 20:02:43 +1000 (AEST)
Date: Sun, 23 Apr 2017 02:36:23 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-77e5849688670280b173bb9e0544e9da7b2acc36@git.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, will.deacon@arm.com, hpa@zytor.com,
 josh@joshtriplett.org, peterz@infradead.org,
 paulmck@linux.vnet.ibm.com, benh@kernel.crashing.org, mingo@kernel.org,
 boqun.feng@linux.vnet.ibm.com, tglx@linutronix.de, paulus@samba.org,
 mpe@ellerman.id.au
Reply-To: hpa@zytor.com, josh@joshtriplett.org, peterz@infradead.org,
 paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, mingo@kernel.org,
 boqun.feng@linux.vnet.ibm.com, mpe@ellerman.id.au, paulus@samba.org,
 tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] rcu: Make arch select smp_mb__after_unlock_lock()
 strength
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  77e5849688670280b173bb9e0544e9da7b2acc36
Gitweb:     http://git.kernel.org/tip/77e5849688670280b173bb9e0544e9da7b2acc36
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Sat, 14 Jan 2017 13:32:50 -0800
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Tue, 18 Apr 2017 11:20:15 -0700

rcu: Make arch select smp_mb__after_unlock_lock() strength

The definition of smp_mb__after_unlock_lock() is currently smp_mb()
for CONFIG_PPC and a no-op otherwise.  It would be better to instead
provide an architecture-selectable Kconfig option, and select the
strength of smp_mb__after_unlock_lock() based on that option.  This
commit therefore creates ARCH_WEAK_RELEASE_ACQUIRE, has PPC select it,
and bases the definition of smp_mb__after_unlock_lock() on this new
ARCH_WEAK_RELEASE_ACQUIRE Kconfig option.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 arch/Kconfig             | 3 +++
 arch/powerpc/Kconfig     | 1 +
 include/linux/rcupdate.h | 6 +++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index cd211a1..adefaf3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -320,6 +320,9 @@ config HAVE_CMPXCHG_LOCAL
 config HAVE_CMPXCHG_DOUBLE
 	bool
 
+config ARCH_WEAK_RELEASE_ACQUIRE
+	bool
+
 config ARCH_WANT_IPC_PARSE_VERSION
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 97a8bc8..7a5c9b7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -99,6 +99,7 @@ config PPC
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index de88b33..e6146d0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1127,11 +1127,11 @@ do { \
  * if the UNLOCK and LOCK are executed by the same CPU or if the
  * UNLOCK and LOCK operate on the same lock variable.
  */
-#ifdef CONFIG_PPC
+#ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE
 #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
-#else /* #ifdef CONFIG_PPC */
+#else /* #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
 #define smp_mb__after_unlock_lock()	do { } while (0)
-#endif /* #else #ifdef CONFIG_PPC */
+#endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
 
 
 #endif /* __LINUX_RCUPDATE_H */
