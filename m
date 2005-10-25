Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp12.wanadoo.fr (smtp12.wanadoo.fr [193.252.22.20])
	by ozlabs.org (Postfix) with ESMTP id 1E4BB685D0
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 17:53:14 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1203.wanadoo.fr (SMTP Server) with ESMTP id EFC071C000B8
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 09:53:10 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-59-200.w82-126.abo.wanadoo.fr
	[82.126.135.200])
	by mwinf1203.wanadoo.fr (SMTP Server) with ESMTP id 8B8181C000C5
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 09:53:09 +0200 (CEST)
Date: Tue, 25 Oct 2005 09:51:59 +0200
From: Sven Luther <sl@bplan-gmbh.de>
To: Sven Luther <sl@bplan-gmbh.de>, Andrew Morton <akpm@osdl.org>,
	Nicolas DET <nd@bplan-gmbh.de>, linuxppc-dev@ozlabs.org
Message-ID: <20051025075159.GA10316@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Cc: sl@bplan-gmbh.de
Subject: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements hotplug
	for the marvell gige functionality by probing the northbridge
	pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add Marvell gigabit ethernet hotplug through the northbridge pci id support
for the Pegasos machines.

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Sven Luther <sl@bplan-gmbh.de>

---
This patch is not optimal, as the proper way to handling this is to bring full
hotplug support to the platform drivers, but this would be much more invasive
and far reaching a project. This approach matches the marvell discovery
northbridge pci id to load the driver for the builtin gigabit ethernet
function, and is similar of what is done already using the discover module
loading technique. With more and more distributions moving to using hotplug
only to probe for modules to load, this patch becomes necessary.

Friendly,

Sven Luther

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mv643xx_eth_pcidev_2.6.14-rc5.diff"

diff -Naur a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
--- a/drivers/net/mv643xx_eth.c	2005-10-25 09:20:50.604386000 +0200
+++ b/drivers/net/mv643xx_eth.c	2005-10-25 09:20:14.596386000 +0200
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
@@ -1640,6 +1644,16 @@
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

--sm4nu43k4a2Rpi4c--
