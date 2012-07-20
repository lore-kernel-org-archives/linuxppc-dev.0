Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 962362C03AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 22:41:12 +1000 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <galak@kernel.crashing.org>
Subject: [PATCH v8 1/7] powerpc/smp: use a struct epapr_spin_table to replace
 macros
Date: Fri, 20 Jul 2012 20:42:33 +0800
Message-ID: <1342788159-27529-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |   46 ++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index ff42490..4827709 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -2,7 +2,7 @@
  * Author: Andy Fleming <afleming@freescale.com>
  * 	   Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2006-2008, 2011 Freescale Semiconductor Inc.
+ * Copyright 2006-2008, 2011-2012 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/kexec.h>
 #include <linux/highmem.h>
+#include <linux/cpu.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -31,23 +32,21 @@
 
 extern void __early_start(void);
 
-#define BOOT_ENTRY_ADDR_UPPER	0
-#define BOOT_ENTRY_ADDR_LOWER	1
-#define BOOT_ENTRY_R3_UPPER	2
-#define BOOT_ENTRY_R3_LOWER	3
-#define BOOT_ENTRY_RESV		4
-#define BOOT_ENTRY_PIR		5
-#define BOOT_ENTRY_R6_UPPER	6
-#define BOOT_ENTRY_R6_LOWER	7
-#define NUM_BOOT_ENTRY		8
-#define SIZE_BOOT_ENTRY		(NUM_BOOT_ENTRY * sizeof(u32))
+struct epapr_spin_table {
+	u32	addr_h;
+	u32	addr_l;
+	u32	r3_h;
+	u32	r3_l;
+	u32	reserved;
+	u32	pir;
+};
 
 static int __init
 smp_85xx_kick_cpu(int nr)
 {
 	unsigned long flags;
 	const u64 *cpu_rel_addr;
-	__iomem u32 *bptr_vaddr;
+	__iomem struct epapr_spin_table *spin_table;
 	struct device_node *np;
 	int n = 0, hw_cpu = get_hard_smp_processor_id(nr);
 	int ioremappable;
@@ -75,19 +74,20 @@ smp_85xx_kick_cpu(int nr)
 
 	/* Map the spin table */
 	if (ioremappable)
-		bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
+		spin_table = ioremap(*cpu_rel_addr,
+				sizeof(struct epapr_spin_table));
 	else
-		bptr_vaddr = phys_to_virt(*cpu_rel_addr);
+		spin_table = phys_to_virt(*cpu_rel_addr);
 
 	local_irq_save(flags);
 
-	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, hw_cpu);
+	out_be32(&spin_table->pir, hw_cpu);
 #ifdef CONFIG_PPC32
-	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
+	out_be32(&spin_table->addr_l, __pa(__early_start));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)spin_table,
+			(ulong)spin_table + sizeof(struct epapr_spin_table));
 
 	/* Wait a bit for the CPU to ack. */
 	while ((__secondary_hold_acknowledge != hw_cpu) && (++n < 1000))
@@ -95,18 +95,18 @@ smp_85xx_kick_cpu(int nr)
 #else
 	smp_generic_kick_cpu(nr);
 
-	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
-		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
+	out_be64((u64 *)(&spin_table->addr_h),
+	  __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)spin_table,
+			(ulong)spin_table + sizeof(struct epapr_spin_table));
 #endif
 
 	local_irq_restore(flags);
 
 	if (ioremappable)
-		iounmap(bptr_vaddr);
+		iounmap(spin_table);
 
 	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
 
-- 
1.6.4.1
