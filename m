Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 004E3DDF34
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 11:22:17 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so145133nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:22:15 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Thu, 14 Feb 2008 01:36:42 +0100
Message-Id: <20080214003642.12879.73252.sendpatchset@localhost.localdomain>
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Subject: [PATCH 03/11] ppc/ppc4xx: remove ppc_ide_md hooks
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are no "default" IDE ports on PPC4xx so ppc4xx_ide_init_hwif_ports() is
unnecessary, remove it.  Also remove no longer needed <linux/ide.h> include.

There should be no functional changes caused by this patch.

Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/ppc/syslib/ppc4xx_setup.c |   23 -----------------------
 1 file changed, 23 deletions(-)

Index: b/arch/ppc/syslib/ppc4xx_setup.c
===================================================================
--- a/arch/ppc/syslib/ppc4xx_setup.c
+++ b/arch/ppc/syslib/ppc4xx_setup.c
@@ -24,7 +24,6 @@
 #include <linux/pci.h>
 #include <linux/rtc.h>
 #include <linux/console.h>
-#include <linux/ide.h>
 #include <linux/serial_reg.h>
 #include <linux/seq_file.h>
 
@@ -189,24 +188,6 @@ ppc4xx_calibrate_decr(void)
 	mtspr(SPRN_PIT, tb_ticks_per_jiffy);
 }
 
-/*
- * IDE stuff.
- * should be generic for every IDE PCI chipset
- */
-#if defined(CONFIG_PCI) && defined(CONFIG_IDE)
-static void
-ppc4xx_ide_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
-			   unsigned long ctrl_port, int *irq)
-{
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
-		hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
-
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-}
-#endif /* defined(CONFIG_PCI) && defined(CONFIG_IDE) */
-
 TODC_ALLOC();
 
 /*
@@ -271,10 +252,6 @@ ppc4xx_init(unsigned long r3, unsigned l
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
-
-#if defined(CONFIG_PCI) && defined(CONFIG_IDE)
-	ppc_ide_md.ide_init_hwif = ppc4xx_ide_init_hwif_ports;
-#endif /* defined(CONFIG_PCI) && defined(CONFIG_IDE) */
 }
 
 /* Called from machine_check_exception */
