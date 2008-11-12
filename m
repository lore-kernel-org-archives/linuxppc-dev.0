Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 159B7DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 14:50:56 +1100 (EST)
Date: Wed, 12 Nov 2008 04:50:48 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [patch 1/3] powerpc: optimise smp_wmb
Message-ID: <20081112035048.GF26053@wotan.suse.de>
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

OK, another go at submitting these 3 memory ordering improvement patches.
I've tested on my G5, but I'd like to especially get confirmation as to
whether the __SUBARCH_HAS_LWSYNC thing works on E500MC.

--

Change 2d1b2027626d5151fff8ef7c06ca8e7876a1a510 removed __SUBARCH_HAS_LWSYNC,
causing smp_wmb to revert back to eieio for all CPUs. Restore the behaviour
intorduced in 74f0609526afddd88bef40b651da24f3167b10b2.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/include/asm/synch.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/synch.h	2008-11-12 12:26:15.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/synch.h	2008-11-12 12:33:10.000000000 +1100
@@ -5,6 +5,10 @@
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
 
+#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
+#define __SUBARCH_HAS_LWSYNC
+#endif
+
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-12 12:26:46.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-12 12:28:57.000000000 +1100
@@ -45,14 +45,14 @@
 #ifdef CONFIG_SMP
 
 #ifdef __SUBARCH_HAS_LWSYNC
-#    define SMPWMB      lwsync
+#    define SMPWMB      LWSYNC
 #else
 #    define SMPWMB      eieio
 #endif
 
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
-#define smp_wmb()	__asm__ __volatile__ (__stringify(SMPWMB) : : :"memory")
+#define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 #define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
