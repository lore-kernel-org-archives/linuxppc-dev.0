Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D008DDEE8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 04:12:36 +1100 (EST)
Date: Thu, 19 Feb 2009 18:12:29 +0100
From: Nick Piggin <npiggin@suse.de>
To: benh@kernel.crashing.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: [patch 1/2] powerpc: optimise smp_mb
Message-ID: <20090219171229.GJ1747@wotan.suse.de>
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


Using lwsync, isync sequence in a microbenchmark is 5 times faster on my G5 than
using sync for smp_mb. Although it takes more instructions.

Running tbench with 4 clients on my 4 core G5 (20 times) gives the
following:

unpatched AVG=920.33 STD=2.36
  patched AVG=921.27 STD=2.77

So not a big improvement here, actually it could even be in the noise.
But other workloads or systems might see a bigger win, and the patch
maybe is interesting or could be improved, so I'll ask for comments. 

---
Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2009-02-20 01:51:24.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2009-02-20 02:09:41.000000000 +1100
@@ -52,7 +52,16 @@
 #    define SMPWMB      eieio
 #endif
 
+#ifdef __powerpc64__
+#define smp_mb()	__asm__ __volatile__ (				    \
+					"1:	lwsync			\n" \
+					"	cmpw	0,%%r0,%%r0	\n" \
+					"	bne-	1b		\n" \
+					"	isync			\n" \
+					: : : "memory")
+#else
 #define smp_mb()	mb()
+#endif
 #define smp_rmb()	__asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
 #define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 #define smp_read_barrier_depends()	read_barrier_depends()
