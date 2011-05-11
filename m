Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 35512100A35
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:41 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <ce0f6375a67a226a8d7a0b0c3906bef56bf84efb.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:28 -0500
Subject: [PATCH 16/37] powerpc: remove stubbed beat smp support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have no idea if the beat hypervisor supports multiple cpus in
a partition, but the code has not been touched since these stubs
were added in February of 2007 except to move them in April of 2008.
These are stubs: start_cpu always returns fail (which is dropped),
the message passing and reciving are empty functions, and the top
of file comment says "Incomplete".

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/platforms/cell/Makefile         |    1 -
 arch/powerpc/platforms/cell/beat_interrupt.c |   16 ----
 arch/powerpc/platforms/cell/beat_interrupt.h |    3 -
 arch/powerpc/platforms/cell/beat_smp.c       |  107 --------------------------
 arch/powerpc/platforms/cell/celleb_setup.c   |    4 -
 5 files changed, 0 insertions(+), 131 deletions(-)
 delete mode 100644 arch/powerpc/platforms/cell/beat_smp.c

diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 8839ef6..a4a8935 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -43,7 +43,6 @@ obj-y					+= celleb_setup.o \
 					   beat_hvCall.o beat_interrupt.o \
 					   beat_iommu.o
 
-obj-$(CONFIG_SMP)			+= beat_smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)		+= beat_udbg.o
 obj-$(CONFIG_SERIAL_TXX9)		+= celleb_scc_sio.o
 obj-$(CONFIG_SPU_BASE)			+= beat_spu_priv1.o
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index 4cb9e14..d46f7e4 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -257,22 +257,6 @@ void __init beatic_init_IRQ(void)
 	irq_set_default_host(beatic_host);
 }
 
-#ifdef CONFIG_SMP
-
-/* Nullified to compile with SMP mode */
-void beatic_setup_cpu(int cpu)
-{
-}
-
-void beatic_cause_IPI(int cpu, int mesg)
-{
-}
-
-void beatic_request_IPIs(void)
-{
-}
-#endif /* CONFIG_SMP */
-
 void beatic_deinit_IRQ(void)
 {
 	int	i;
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.h b/arch/powerpc/platforms/cell/beat_interrupt.h
index b470fd0..a7e52f9 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.h
+++ b/arch/powerpc/platforms/cell/beat_interrupt.h
@@ -24,9 +24,6 @@
 
 extern void beatic_init_IRQ(void);
 extern unsigned int beatic_get_irq(void);
-extern void beatic_cause_IPI(int cpu, int mesg);
-extern void beatic_request_IPIs(void);
-extern void beatic_setup_cpu(int);
 extern void beatic_deinit_IRQ(void);
 
 #endif
diff --git a/arch/powerpc/platforms/cell/beat_smp.c b/arch/powerpc/platforms/cell/beat_smp.c
deleted file mode 100644
index 23bbe6e..0000000
--- a/arch/powerpc/platforms/cell/beat_smp.c
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- * SMP support for Celleb platform. (Incomplete)
- *
- * (C) Copyright 2006 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/platforms/cell/smp.c:
- * Dave Engebretsen, Peter Bergner, and
- * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
- * Plus various changes from other IBM teams...
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/threads.h>
-#include <linux/cpu.h>
-
-#include <asm/irq.h>
-#include <asm/smp.h>
-#include <asm/machdep.h>
-#include <asm/udbg.h>
-
-#include "beat_interrupt.h"
-
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-/*
- * The primary thread of each non-boot processor is recorded here before
- * smp init.
- */
-/* static cpumask_t of_spin_map; */
-
-/**
- * smp_startup_cpu() - start the given cpu
- *
- * At boot time, there is nothing to do for primary threads which were
- * started from Open Firmware.  For anything else, call RTAS with the
- * appropriate start location.
- *
- * Returns:
- *	0	- failure
- *	1	- success
- */
-static inline int __devinit smp_startup_cpu(unsigned int lcpu)
-{
-	return 0;
-}
-
-static int __init smp_beatic_probe(void)
-{
-	return cpumask_weight(cpu_possible_mask);
-}
-
-static void __devinit smp_beatic_setup_cpu(int cpu)
-{
-	beatic_setup_cpu(cpu);
-}
-
-static int __devinit smp_celleb_kick_cpu(int nr)
-{
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
-
-	return smp_startup_cpu(nr);
-}
-
-static int smp_celleb_cpu_bootable(unsigned int nr)
-{
-	return 1;
-}
-static struct smp_ops_t bpa_beatic_smp_ops = {
-	.message_pass	= beatic_cause_IPI,
-	.probe		= smp_beatic_probe,
-	.kick_cpu	= smp_celleb_kick_cpu,
-	.setup_cpu	= smp_beatic_setup_cpu,
-	.cpu_bootable	= smp_celleb_cpu_bootable,
-};
-
-/* This is called very early */
-void __init smp_init_celleb(void)
-{
-	DBG(" -> smp_init_celleb()\n");
-
-	smp_ops = &bpa_beatic_smp_ops;
-
-	DBG(" <- smp_init_celleb()\n");
-}
diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index e538455..d58d9ba 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -128,10 +128,6 @@ static void __init celleb_setup_arch_beat(void)
 	spu_management_ops	= &spu_management_of_ops;
 #endif
 
-#ifdef CONFIG_SMP
-	smp_init_celleb();
-#endif
-
 	celleb_setup_arch_common();
 }
 
-- 
1.7.0.4
