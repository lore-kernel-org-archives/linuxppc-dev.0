Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD89F67A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 11:22:38 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 11:22:14 +1100
Message-Id: <1109204534.1520.16.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: Bogus definition of __cmpxchg_u32()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch fix bogus types in the definition of __cmpxchg_u32() on
ppc32, please apply.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc/system.h
===================================================================
--- linux-work.orig/include/asm-ppc/system.h	2005-01-24 17:09:50.000000000 +1100
+++ linux-work/include/asm-ppc/system.h	2005-02-24 10:55:11.000000000 +1100
@@ -152,9 +152,9 @@
 #define __HAVE_ARCH_CMPXCHG	1
 
 static __inline__ unsigned long
-__cmpxchg_u32(volatile int *p, int old, int new)
+__cmpxchg_u32(volatile unsigned int *p, unsigned int old, unsigned int new)
 {
-	int prev;
+	unsigned int prev;
 
 	__asm__ __volatile__ ("\n\
 1:	lwarx	%0,0,%2 \n\
