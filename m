Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Pyt2RCZzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 09:45:41 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HNhtEs069649
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 19:45:39 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29w2e9axb7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 19:45:39 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 19:45:38 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
 akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
 josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
 rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
 fweisbec@gmail.com, oleg@redhat.com, bobby.prani@gmail.com,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 tip/core/rcu 02/39] rcu: Make arch select
 smp_mb__after_unlock_lock() strength
Date: Mon, 17 Apr 2017 16:44:49 -0700
In-Reply-To: <20170417234452.GB19013@linux.vnet.ibm.com>
References: <20170417234452.GB19013@linux.vnet.ibm.com>
Message-Id: <1492472726-3841-2-git-send-email-paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
 arch/Kconfig             | 3 +++
 arch/powerpc/Kconfig     | 1 +
 include/linux/rcupdate.h | 6 +++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index cd211a14a88f..adefaf344239 100644
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
index 97a8bc8a095c..7a5c9b764cd2 100644
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
index de88b33c0974..e6146d0074f8 100644
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
-- 
2.5.2
