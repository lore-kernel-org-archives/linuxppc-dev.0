Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C821DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:19 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 20/25] [POWERPC] 85xxCDS: Make sure restart resets the PCI bus.
Date: Mon, 23 Jul 2007 15:50:07 -0500
Message-Id: <11852238421611-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238411823-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.org>
	<11852238383453-git-send-email-galak@kernel.crashing.org>
	<11852238392809-git-send-email-galak@kernel.crashing.org>
	<11852238411823-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Vinson <rvinson@linuxbox.(none)>

The current 85xxCDS restart code fails to reset the PCI bus which can
lead to odd behavior after the restart. This patch uses the VIA Super
Southbridge to perform a PCI reset which will reset the entire system.
NOTE: Since the VIA chip is behind a PCI-to-PCI bridge which can be
disabled with a switch setting, it may not be possible to perform the
PCI bus reset. In this case, the code defaults to the previous restart
mechanism.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   35 +++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 81b7062..e77c869 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -69,6 +69,37 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 		return PCIBIOS_SUCCESSFUL;
 }
 
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
@@ -304,7 +335,11 @@ define_machine(mpc85xx_cds) {
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
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-- 
1.5.2.2
