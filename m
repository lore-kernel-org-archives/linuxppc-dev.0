Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 5EE13DDF54
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:56:43 +1000 (EST)
Message-ID: <46A1056A.3030106@mvista.com>
Date: Fri, 20 Jul 2007 11:56:42 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/6] 85xxCDS: Make sure restart resets the PCI bus.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 5397a82c878055ead34070993acd89dd0d824a52 Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@linuxbox.(none)>
Date: Fri, 23 Mar 2007 15:43:37 -0700
Subject: [PATCH] 85xxCDS: Make sure restart resets the PCI bus.

The current 85xxCDS restart code fails to reset the PCI bus which can
lead to odd behavior after the restart. This patch uses the VIA Super
Southbridge to perform a PCI reset which will reset the entire system.
NOTE: Since the VIA chip is behind a PCI-to-PCI bridge which can be
disabled with a switch setting, it may not be possible to perform the
PCI bus reset. In this case, the code defaults to the previous restart
mechanism.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   35 +++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 1db6c81..78e5355 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -54,6 +54,37 @@ static volatile u8 *cadmus;
 
 #ifdef CONFIG_PCI
 
+static void mpc85xx_cds_restart(char *cmd)
+{
+	struct pci_dev *dev;
+	u_char tmp;
+
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
+					NULL))) {
+
+		/* Use the VIA Super Southbridge to force a PCI reset */
+		pci_read_config_byte(dev, 0x47, &tmp);
+		pci_write_config_byte(dev, 0x47, tmp | 1);
+
+		/* Flush the outbound PCI write queues */
+		pci_read_config_byte(dev, 0x47, &tmp);
+
+		/*
+		 *  At this point, the harware reset should have triggered.
+		 *  However, if it doesn't work for some mysterious reason,
+		 *  just fall through to the default reset below.
+		 */
+
+		pci_dev_put(dev);
+	}
+
+	/*
+	 *  If we can't find the VIA chip (maybe the P2P bridge is disabled)
+	 *  or the VIA chip reset didn't work, just use the default reset.
+	 */
+	mpc85xx_restart(NULL);
+}
+
 static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 {
 	u_char c;
@@ -278,7 +309,11 @@ define_machine(mpc85xx_cds) {
 	.init_IRQ	= mpc85xx_cds_pic_init,
 	.show_cpuinfo	= mpc85xx_cds_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
+#ifdef CONFIG_PCI
+	.restart	= mpc85xx_cds_restart,
+#else
 	.restart	= mpc85xx_restart,
+#endif
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
 };
-- 
1.5.2.2.549.gaeb59
