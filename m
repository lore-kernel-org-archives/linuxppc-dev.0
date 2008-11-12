Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D885DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 14:51:27 +1100 (EST)
Date: Wed, 12 Nov 2008 04:51:18 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [patch 2/3] powerpc: optimise smp_rmb
Message-ID: <20081112035118.GG26053@wotan.suse.de>
References: <20081112035048.GF26053@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081112035048.GF26053@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After commit 598056d5af8fef1dbe8f96f5c2b641a528184e5a, rmb() becomes a sync
instruction, which is needed to order cacheable vs noncacheable loads. However
smp_rmb() is #defined to rmb(), and smp_rmb() can be an lwsync.

Restore smp_rmb() performance by using lwsync there. Update comments.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-12 12:28:57.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-12 12:35:12.000000000 +1100
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
+ * However, on CPUs that don't support lwsync, lwsync actually maps to a
+ * heavy-weight sync, so smp_wmb() can be a lighter-weight eieio.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
@@ -51,7 +53,7 @@
 #endif
 
 #define smp_mb()	mb()
-#define smp_rmb()	rmb()
+#define smp_rmb()	__asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
 #define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 #define smp_read_barrier_depends()	read_barrier_depends()
 #else
