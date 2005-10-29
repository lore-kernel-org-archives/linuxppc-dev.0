Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0l1qU030041@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:31 -0700
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org, det.nicolas@free.fr, jgarzik@pobox.com
Subject: [patch 18/43] mv643xx_eth_pcidev: implement hotplug for the marvell
	gige functionality by probing the northbridge pci id
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Sven Luther <sl@bplan-gmbh.de>

Add Marvell gigabit ethernet hotplug through the northbridge pci id support
for the Pegasos machines.

This patch is not optimal, as the proper way to handling this is to bring
full hotplug support to the platform drivers, but this would be much more
invasive and far reaching a project.  This approach matches the marvell
discovery northbridge pci id to load the driver for the builtin gigabit
ethernet function, and is similar of what is done already using the
discover module loading technique.  With more and more distributions moving
to using hotplug only to probe for modules to load, this patch becomes
necessary.

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/mv643xx_eth.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -puN drivers/net/mv643xx_eth.c~mv643xx_eth_pcidev-implements-hotplug-for-the-marvell-gige-functionality-by-probing-the-northbridge-pci-id drivers/net/mv643xx_eth.c
--- devel/drivers/net/mv643xx_eth.c~mv643xx_eth_pcidev-implements-hotplug-for-the-marvell-gige-functionality-by-probing-the-northbridge-pci-id	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/mv643xx_eth.c	2005-10-28 17:44:03.000000000 -0700
@@ -36,6 +36,10 @@
 #include <linux/udp.h>
 #include <linux/etherdevice.h>
 
+#ifdef CONFIG_PPC_MULTIPLATFORM
+#include <linux/pci.h>
+#endif
+
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
@@ -1643,6 +1647,16 @@ MODULE_AUTHOR(	"Rabeeh Khoury, Assaf Hof
 		" and Dale Farnsworth");
 MODULE_DESCRIPTION("Ethernet driver for Marvell MV643XX");
 
+#ifdef CONFIG_PPC_MULTIPLATFORM
+static struct pci_device_id pci_marvell_mv64360[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, pci_marvell_mv64360);
+#endif
+
+
 /*
  * The second part is the low level driver of the gigE ethernet ports.
  */
_
