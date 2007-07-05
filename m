Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ECDF2DDF5F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170243.003467000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:08 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 35/35] Work around errata 5652
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Due to errata 5652 we might sometimes end up with duplicate SLB entries.

This causes a machine check, so detect it (and print debug info), but
recover instead of killing the process and/or crashing the machine.


Index: 2.6.21/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/setup.c
+++ 2.6.21/arch/powerpc/platforms/pasemi/setup.c
@@ -36,6 +36,7 @@
 #include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/of_platform.h>
+#include <asm/mmu-hash64.h>
 
 #include "pasemi.h"
 
@@ -176,7 +177,7 @@ static int pas_machine_check_handler(str
 {
 	int cpu = smp_processor_id();
 	unsigned long srr0, srr1, dsisr;
-	int dump_slb = 0;
+	int dump_slb = 0, flush_slb = 0;
 	int dump_memsta = 0;
 
 	srr0 = regs->nip;
@@ -200,6 +201,7 @@ static int pas_machine_check_handler(str
 		if (dsisr & 0x2000) {
 			printk(KERN_ERR "MMU SLB multi-hit or invalid B field\n");
 			dump_slb = 1;
+			flush_slb = 1;
 		}
 		if (dsisr & 0x1000)
 			printk(KERN_ERR "Recoverable Duptags\n");
@@ -215,6 +217,7 @@ static int pas_machine_check_handler(str
 	if (srr1 & 0x40000) {
 		printk(KERN_ERR "I-side SLB multiple hit\n");
 		dump_slb = 1;
+		flush_slb = 1;
 	}
 	if (srr1 & 0x20000) {
 		printk(KERN_ERR "I-cache parity error hit\n");
@@ -243,6 +246,10 @@ static int pas_machine_check_handler(str
 		}
 	}
 
+	if (flush_slb)
+		/* We really can recover from this. flush, rebolt and go. */
+		slb_flush_and_rebolt();
+
 	/* SRR1[62] is from MSR[62] if recoverable, so pass that back */
 	return !!(srr1 & 0x2);
 }

--
