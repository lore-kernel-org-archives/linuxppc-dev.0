Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7937DDD06
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 12:11:48 +1000 (EST)
Date: Tue, 21 Aug 2007 04:11:43 +0200
From: Nick Piggin <npiggin@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/2] powerpc: rmb fix
Message-ID: <20070821021143.GB2909@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the interest of completeness, I'll split these patches up and submit to
the powerpc dev list. Any discussion or ack/nack would be appreciated.

---
lwsync is defined to only order memory operations on cacheable memory.
A full sync appears to be the only barrier that will order all memory
loads including device memory.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h
+++ linux-2.6/include/asm-powerpc/system.h
@@ -33,7 +33,7 @@
  * SMP since it is only used to order updates to system memory.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
+#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
 
@@ -42,7 +42,7 @@
 #ifdef __KERNEL__
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
-#define smp_rmb()	rmb()
+#define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
 #define smp_wmb()	eieio()
 #define smp_read_barrier_depends()	read_barrier_depends()
 #else
