Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0703DDDEA
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 23:33:45 +1100 (EST)
Date: Sat, 1 Nov 2008 13:33:39 +0100
From: Nick Piggin <npiggin@suse.de>
To: paulus@samba.org, benh@kernel.crashing.org,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
Subject: [patch] powerpc: smp_wmb lwsync optimisation fix
Message-ID: <20081101123339.GA32055@wotan.suse.de>
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

A previous change removed __SUBARCH_HAS_LWSYNC define, and replaced it
with __powerpc64__. smp_wmb() seems to be the last place not updated.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-01 20:31:51.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-01 20:32:33.000000000 +1100
@@ -44,7 +44,7 @@
 #define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
 #ifdef CONFIG_SMP
 
-#ifdef __SUBARCH_HAS_LWSYNC
+#if defined(__powerpc64__)
 #    define SMPWMB      lwsync
 #else
 #    define SMPWMB      eieio
