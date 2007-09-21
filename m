Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BF03DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 00:45:44 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8LEicQW004263
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 18:44:38 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8LEicSU004260
	for linuxppc-dev@ozlabs.org; Fri, 21 Sep 2007 18:44:38 +0400
Date: Fri, 21 Sep 2007 18:44:38 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] PowerPC: Introduce cpu_setup functionality to 44x platform
Message-ID: <20070921144438.GA4242@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070921144149.GA4150@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds cpu_setup functionality for ppc44x platform.
Low level cpu-spefic initialization routines should be 
placed in cpu_setup_44x.S and a callback should be
added to cputable. The cpu_setup is invoked 
by identify_cpu() function at early init.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/Makefile        |    1 +
 arch/powerpc/kernel/cpu_setup_44x.S |   19 +++++++++++++++++++
 arch/powerpc/kernel/cputable.c      |   13 +++++++------
 3 files changed, 27 insertions(+), 6 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S	2007-09-21 17:04:20.000000000 +0400
@@ -0,0 +1,19 @@
+/*
+ * This file contains low level CPU setup functions.
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ * MontaVista Software, Inc (c) 2007
+ *
+ * Based on cpu_setup_6xx code by 
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+
diff -ruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-09-21 14:56:40.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-09-21 17:04:50.000000000 +0400
@@ -1319,17 +1319,18 @@
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
 		if ((pvr & s->pvr_mask) == s->pvr_value) {
 			*cur = cpu_specs + i;
-#ifdef CONFIG_PPC64
-			/* ppc64 expects identify_cpu to also call setup_cpu
-			 * for that processor. I will consolidate that at a
-			 * later time, for now, just use our friend #ifdef.
+#if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
+			/* ppc64 and booke expect identify_cpu to also call 
+			 * setup_cpu for that processor. I will consolidate
+			 * that at a later time, for now, just use #ifdef.
 			 * we also don't need to PTRRELOC the function pointer
-			 * on ppc64 as we are running at 0 in real mode.
+			 * on ppc64 and booke as we are running at 0 in real
+			 * mode on ppc64 and reloc_offset is always 0 on booke.
 			 */
 			if (s->cpu_setup) {
 				s->cpu_setup(offset, s);
 			}
-#endif /* CONFIG_PPC64 */
+#endif /* CONFIG_PPC64 || CONFIG_BOOKE */
 			return s;
 		}
 	BUG();
diff -ruN linux-2.6.orig/arch/powerpc/kernel/Makefile linux-2.6/arch/powerpc/kernel/Makefile
--- linux-2.6.orig/arch/powerpc/kernel/Makefile	2007-09-21 14:56:40.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/Makefile	2007-09-21 17:04:20.000000000 +0400
@@ -56,6 +56,7 @@
 				   udbg.o misc.o io.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
+obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
