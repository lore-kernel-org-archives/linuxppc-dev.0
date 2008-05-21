Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0731DDF22
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 00:11:02 +1000 (EST)
Date: Wed, 21 May 2008 16:10:56 +0200
From: Nick Piggin <npiggin@suse.de>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [patch 1/2] powerpc: rmb fix
Message-ID: <20080521141056.GC8897@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm sure I've sent these patches before, but I can't remember why they
weren't merged. They still seem obviously correct to me.

--

lwsync is explicitly defined not to have any effect on the ordering of
accesses to device memory, so it cannot be used for rmb(). sync appears
to be the only barrier which fits the bill.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h
+++ linux-2.6/include/asm-powerpc/system.h
@@ -34,7 +34,7 @@
  * SMP since it is only used to order updates to system memory.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
+#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
 
