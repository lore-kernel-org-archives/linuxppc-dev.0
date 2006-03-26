Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B05167A3B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Mar 2006 22:37:49 +1100 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k2QBbfI1010202
	for <linuxppc-embedded@ozlabs.org>; Sun, 26 Mar 2006 13:37:41 +0200
	(envelope-from <tnt@246tNt.com>)
Date: Sun, 26 Mar 2006 13:37:38 +0200
Message-ID: <2.20060326_133535_93e6_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2/4] ppc32: Adds support for the LITE5200B dev board
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <0.20060326_133535_93e6_tnt@patchsend.246tNt.com>
References: <0.20060326_133535_93e6_tnt@patchsend.246tNt.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Adds support for the LITE5200B dev board

This LITE5200B devboard is the new development board for the
Freescale MPC5200 processor. It has two PCI slots and so a
different PCI IRQ routing.

Signed-off-by: John Rigby <jrigby@freescale.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
commit 37ffaaccad4fb48c8416e610aab4d3bed41dfc80
tree 3f7b1b661e3ea7c6830c020e42948c575e73d52f
parent d2c9f75189b6bd63b94cc78f8522a44c4476939a
author Sylvain Munaut <tnt@246tNt.com> 1138562427 +0100
committer Sylvain Munaut <tnt@246tNt.com> 1143311804 +0100

 Kconfig              |    7 +++++++
 platforms/lite5200.c |   33 ++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

---
37ffaaccad4fb48c8416e610aab4d3bed41dfc80
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 54a0a9b..1c12da2 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -711,6 +711,13 @@ config LITE5200
 	  much but it's only been tested on this board version. I think this
 	  board is also known as IceCube.
 
+config LITE5200B
+	bool "Freescale LITE5200B"
+	depends LITE5200
+	help
+	  Support for the LITE5200B dev board for the MPC5200 from Freescale.
+	  This is the new board with 2 PCI slots.
+
 config MPC834x_SYS
 	bool "Freescale MPC834x SYS"
 	help
diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
index 5171b53..d91efe1 100644
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -34,6 +34,7 @@
 #include <asm/mpc52xx.h>
 #include <asm/ppc_sys.h>
 #include <asm/machdep.h>
+#include <asm/pci-bridge.h>
 
 #include <syslib/mpc52xx_pci.h>
 
@@ -68,12 +69,32 @@ lite5200_show_cpuinfo(struct seq_file *m
 }
 
 #ifdef CONFIG_PCI
+#ifdef CONFIG_LITE5200B
+static int
+lite5200_map_irq(struct pci_dev *dev, unsigned char idsel,
+		    unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *      PCI IDSEL/INTPIN->INTLINE
+	 *        A             B             C             D
+	 */
+	{
+		{MPC52xx_IRQ0, MPC52xx_IRQ1, MPC52xx_IRQ2, MPC52xx_IRQ3},
+		{MPC52xx_IRQ1, MPC52xx_IRQ2, MPC52xx_IRQ3, MPC52xx_IRQ0},
+	};
+
+	const long min_idsel = 24, max_idsel = 25, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+#else /* Original Lite */
 static int
 lite5200_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
 	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
 }
 #endif
+#endif
 
 static void __init
 lite5200_setup_cpu(void)
@@ -127,11 +148,17 @@ lite5200_setup_cpu(void)
 	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
 	out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
 
-	/* IRQ[0-3] setup : IRQ0     - Level Active Low  */
-	/*                  IRQ[1-3] - Level Active High */
+	/* IRQ[0-3] setup */
 	intr_ctrl = in_be32(&intr->ctrl);
 	intr_ctrl &= ~0x00ff0000;
-	intr_ctrl |=  0x00c00000;
+#ifdef CONFIG_LITE5200B
+	/* IRQ[0-3] Level Active Low */
+	intr_ctrl |=  0x00ff0000;
+#else
+	/* IRQ0 Level Active Low
+	 * IRQ[1-3] Level Active High */
+ 	intr_ctrl |=  0x00c00000;
+#endif
 	out_be32(&intr->ctrl, intr_ctrl);
 
 	/* Unmap reg zone */
