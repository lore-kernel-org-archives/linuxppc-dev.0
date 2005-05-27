Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7B18E679F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 08:09:45 +1000 (EST)
Date: Fri, 27 May 2005 17:09:19 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505271708380.25368@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Add soft reset to MPC834x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This change allows mpc83xx_restart to issue a software reset.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1a0a26adb3ef9323ac3e17e14af6c2b138f1656a
tree ec5c9971711cdd5ce074c2798a16cc12d35318ee
parent 2c6dd281d28694239de9e453541ed3b937d11e25
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 27 May 2005 09:35:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 27 May 2005 09:35:28 -0500

 ppc/platforms/83xx/mpc834x_sys.h |    6 ++++++
 ppc/syslib/ppc83xx_setup.c       |   28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ ec5c9971711cdd5ce074c2798a16cc12d35318ee/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -28,6 +28,12 @@
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
+#define BCSR_MISC_REG2_OFF	0x07
+#define BCSR_MISC_REG2_PORESET	0x01
+
+#define BCSR_MISC_REG3_OFF	0x08
+#define BCSR_MISC_REG3_CNFLOCK	0x80
+
 #ifdef CONFIG_PCI
 /* PCI interrupt controller */
 #define PIRQA        MPC83xx_IRQ_IRQ4
Index: arch/ppc/syslib/ppc83xx_setup.c
===================================================================
--- 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
+++ ec5c9971711cdd5ce074c2798a16cc12d35318ee/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
@@ -29,6 +29,7 @@
 #include <asm/mmu.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
+#include <asm/delay.h>
 
 #include <syslib/ppc83xx_setup.h>
 
@@ -117,7 +118,34 @@
 void
 mpc83xx_restart(char *cmd)
 {
+	volatile unsigned char __iomem *reg;
+	unsigned char tmp;
+
+	reg = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+
 	local_irq_disable();
+
+	/*
+	 * Unlock the BCSR bits so a PRST will update the contents.
+	 * Otherwise the reset asserts but doesn't clear.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG3_OFF);
+	tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
+	out_8(reg + BCSR_MISC_REG3_OFF, tmp);
+
+	/*
+	 * Trigger a reset via a low->high transition of the
+	 * PORESET bit.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG2_OFF);
+	tmp &= ~BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
+	udelay(1);
+
+	tmp |= BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
 	for(;;);
 }
 
