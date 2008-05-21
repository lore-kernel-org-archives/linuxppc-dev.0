Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F2F2DDFCF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 00:12:37 +1000 (EST)
Date: Wed, 21 May 2008 16:12:31 +0200
From: Nick Piggin <npiggin@suse.de>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [patch 2/2] powerpc: optimise smp_wmb
Message-ID: <20080521141231.GD8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080521141056.GC8897@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


lwsync is the recommended method of store/store ordering on caching enabled
memory. For those subarchs which have lwsync, use it rather than eieio for
smp_wmb.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h
+++ linux-2.6/include/asm-powerpc/system.h
@@ -30,8 +30,8 @@
  *
  * For wmb(), we use sync since wmb is used in drivers to order
  * stores to system memory with respect to writes to the device.
- * However, smp_wmb() can be a lighter-weight eieio barrier on
- * SMP since it is only used to order updates to system memory.
+ * However, smp_wmb() can be a lighter-weight lwsync or eieio barrier
+ * on SMP since it is only used to order updates to system memory.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
@@ -43,9 +43,16 @@
 #ifdef __KERNEL__
 #define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
 #ifdef CONFIG_SMP
+
+#ifdef __SUBARCH_HAS_LWSYNC
+#    define SMPWMB      lwsync
+#else
+#    define SMPWMB      eieio
+#endif
+
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
-#define smp_wmb()	eieio()
+#define smp_wmb()	__asm__ __volatile__ (__stringify(SMPWMB) : : :"memory")
 #define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
