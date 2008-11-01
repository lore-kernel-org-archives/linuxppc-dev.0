Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6B55DDDE0
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2008 00:05:41 +1100 (EST)
Date: Sat, 1 Nov 2008 14:05:35 +0100
From: Nick Piggin <npiggin@suse.de>
To: paulus@samba.org, benh@kernel.crashing.org,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
Subject: [patch] powerpc: rmp_wmb lwsync optimisation
Message-ID: <20081101130534.GB32055@wotan.suse.de>
References: <20081101123339.GA32055@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081101123339.GA32055@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

smp_rmb can be lwsync if possible. Clarify the comment.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-01 23:56:39.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-02 00:02:46.000000000 +1100
@@ -23,15 +23,17 @@
  * read_barrier_depends() prevents data-dependent loads being reordered
  *	across this point (nop on PPC).
  *
- * We have to use the sync instructions for mb(), since lwsync doesn't
- * order loads with respect to previous stores.  Lwsync is fine for
- * rmb(), though. Note that rmb() actually uses a sync on 32-bit
- * architectures.
+ * *mb() variants without smp_ prefix must order all types of memory
+ * operations with one another. sync is the only instruction sufficient
+ * to do this.
  *
- * For wmb(), we use sync since wmb is used in drivers to order
- * stores to system memory with respect to writes to the device.
- * However, smp_wmb() can be a lighter-weight lwsync or eieio barrier
- * on SMP since it is only used to order updates to system memory.
+ * For the smp_ barriers, ordering is for cacheable memory operations
+ * only. We have to use the sync instruction for smp_mb(), since lwsync
+ * doesn't order loads with respect to previous stores.  Lwsync can be
+ * used for smp_rmb() and smp_wmb().
+ *
+ * However, on 32-bit, lwsync is actually just a sync, in which case smp_wmb()
+ * can be a lighter-weight eieio barrier.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
@@ -51,7 +53,7 @@
 #endif
 
 #define smp_mb()	mb()
-#define smp_rmb()	rmb()
+#define smp_rmb()	__asm__ __volatile__(LWSYNC_ON_SMP : : : "memory")
 #define smp_wmb()	__asm__ __volatile__ (__stringify(SMPWMB) : : :"memory")
 #define smp_read_barrier_depends()	read_barrier_depends()
 #else
