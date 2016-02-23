Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2F3B1A06D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 19:47:25 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 18:47:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BF8EA357803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 19:47:11 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N8l3fv4063638
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 19:47:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N8kcRb014525
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 19:46:39 +1100
Message-ID: <56CC1C1C.6030405@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 16:45:16 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, open list <"linux-kernel"@vger.kernel.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>,
 "'Peter Zijlstra (Intel)\"" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] arch/powerpc: use BUILD_BUG() when detect unfit {cmp}xchg,
 size
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>

__xchg_called_with_bad_pointer() can't tell us what codes use {cmp}xchg
in incorrect way.  And no error will be reported until the link stage.
To fix such kinds of issues in a easy way, we use BUILD_BUG() here.

Signed-off-by: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cmpxchg.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index d1a8d93..20c0a30 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -5,6 +5,7 @@
 #include <linux/compiler.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
+#include <linux/bug.h>
 
 /*
  * Atomic exchange
@@ -92,12 +93,6 @@ __xchg_u64_local(volatile void *p, unsigned long val)
 }
 #endif
 
-/*
- * This function doesn't exist, so you'll get a linker error
- * if something tries to do an invalid xchg().
- */
-extern void __xchg_called_with_bad_pointer(void);
-
 static __always_inline unsigned long
 __xchg(volatile void *ptr, unsigned long x, unsigned int size)
 {
@@ -109,7 +104,7 @@ __xchg(volatile void *ptr, unsigned long x, unsigned int size)
 		return __xchg_u64(ptr, x);
 #endif
 	}
-	__xchg_called_with_bad_pointer();
+	BUILD_BUG();
 	return x;
 }
 
@@ -124,7 +119,7 @@ __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 		return __xchg_u64_local(ptr, x);
 #endif
 	}
-	__xchg_called_with_bad_pointer();
+	BUILD_BUG();
 	return x;
 }
 #define xchg(ptr,x)							     \
@@ -235,10 +230,6 @@ __cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
 }
 #endif
 
-/* This function doesn't exist, so you'll get a linker error
-   if something tries to do an invalid cmpxchg().  */
-extern void __cmpxchg_called_with_bad_pointer(void);
-
 static __always_inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
@@ -251,7 +242,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 		return __cmpxchg_u64(ptr, old, new);
 #endif
 	}
-	__cmpxchg_called_with_bad_pointer();
+	BUILD_BUG();
 	return old;
 }
 
@@ -267,7 +258,7 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 		return __cmpxchg_u64_local(ptr, old, new);
 #endif
 	}
-	__cmpxchg_called_with_bad_pointer();
+	BUILD_BUG();
 	return old;
 }
 
-- 
2.5.0
