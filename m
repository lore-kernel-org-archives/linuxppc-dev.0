Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71E6E1A05C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 22:05:40 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 16:35:32 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NB5Sai5439766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:35:28 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NB5ITK005155
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:35:25 +0530
Message-ID: <56CC3C30.2020706@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 19:02:08 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V2] arch/powerpc: use BUILD_BUG_ON_MSG() when detect unfit
 {cmp}xchg size
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
To fix such a kind of issues easily, we use BUILD_BUG_ON_MSG() here.

Signed-off-by: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
---
change from V1:
	use BUILD_BUG_ON_MSG to provide more build error messages.
---
 arch/powerpc/include/asm/cmpxchg.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index d1a8d93..730028b 100644
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
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg");
 	return x;
 }
 
@@ -124,7 +119,7 @@ __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 		return __xchg_u64_local(ptr, x);
 #endif
 	}
-	__xchg_called_with_bad_pointer();
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_local");
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
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg");
 	return old;
 }
 
@@ -267,7 +258,7 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 		return __cmpxchg_u64_local(ptr, old, new);
 #endif
 	}
-	__cmpxchg_called_with_bad_pointer();
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_local");
 	return old;
 }
 
-- 
2.5.0
