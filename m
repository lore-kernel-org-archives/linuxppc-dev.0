Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 35FD5DDE41
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 06:38:08 +1000 (EST)
Message-ID: <46686CAF.4030407@mvista.com>
Date: Thu, 07 Jun 2007 13:38:07 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH] 85xxCDS: Make sure restart resets the PCI bus.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current 85xxCDS restart code fails to reset the PCI bus which can
lead to odd behavior after the restart. This patch uses the VIA Super
Southbridge to perform a PCI reset which will reset the entire system.
NOTE: Since the VIA chip is behind a PCI-to-PCI bridge which can be
disabled with a switch setting, it may not be possible to perform the
PCI bus reset. In this case, the code defaults to the previous restart
mechanism.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 431aaa2..f1eaf07 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -62,6 +62,28 @@ static volatile u8 *cadmus;
 
 extern int mpc85xx_pci2_busno;
 
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
+		pci_dev_put(dev);
+	}
+
+	/*
+	 *  We should only get here if the P2P bridge is disabled. In that
+	 *  case, just use the default reset.
+	 */
+	mpc85xx_restart(NULL);
+}
+
 static int mpc85xx_exclude_device(u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
@@ -327,7 +349,11 @@ define_machine(mpc85xx_cds) {
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
1.5.0.GIT
