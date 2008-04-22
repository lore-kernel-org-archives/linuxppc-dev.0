Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 22 Apr 2008 10:46:43 +1000
Subject: [PATCH 3/6] ibm_newemac: Fix section mismatch warnings
Message-Id: <20080422004759.9B727DE1C1@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Josh Boyer <jwboyer@gmail.com>

This patch fixes several section mismatch warnings in the
ibm_newemac driver similar to:

WARNING: vmlinux.o(.devinit.text+0x3a04): Section mismatch in reference from the function emac_probe() to the function .devexit.text:tah_detach()
The function __devinit emac_probe() references
a function __devexit tah_detach().

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/net/ibm_newemac/core.c  |    2 +-
 drivers/net/ibm_newemac/mal.c   |    4 ++--
 drivers/net/ibm_newemac/rgmii.c |    2 +-
 drivers/net/ibm_newemac/tah.c   |    2 +-
 drivers/net/ibm_newemac/zmii.c  |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

--- linux-work.orig/drivers/net/ibm_newemac/core.c	2008-04-22 10:02:32.000000000 +1000
+++ linux-work/drivers/net/ibm_newemac/core.c	2008-04-22 10:02:53.000000000 +1000
@@ -2240,7 +2240,7 @@ static int __devinit emac_of_bus_notify(
 	return 0;
 }
 
-static struct notifier_block emac_of_bus_notifier = {
+static struct notifier_block emac_of_bus_notifier __devinitdata = {
 	.notifier_call = emac_of_bus_notify
 };
 
Index: linux-work/drivers/net/ibm_newemac/mal.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/mal.c	2008-04-22 10:02:42.000000000 +1000
+++ linux-work/drivers/net/ibm_newemac/mal.c	2008-04-22 10:02:53.000000000 +1000
@@ -61,8 +61,8 @@ int __devinit mal_register_commac(struct
 	return 0;
 }
 
-void __devexit mal_unregister_commac(struct mal_instance	*mal,
-				     struct mal_commac		*commac)
+void mal_unregister_commac(struct mal_instance	*mal,
+		struct mal_commac *commac)
 {
 	unsigned long flags;
 
Index: linux-work/drivers/net/ibm_newemac/rgmii.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/rgmii.c	2008-03-19 13:52:35.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/rgmii.c	2008-04-22 10:02:53.000000000 +1000
@@ -179,7 +179,7 @@ void rgmii_put_mdio(struct of_device *of
 	mutex_unlock(&dev->lock);
 }
 
-void __devexit rgmii_detach(struct of_device *ofdev, int input)
+void rgmii_detach(struct of_device *ofdev, int input)
 {
 	struct rgmii_instance *dev = dev_get_drvdata(&ofdev->dev);
 	struct rgmii_regs __iomem *p = dev->base;
Index: linux-work/drivers/net/ibm_newemac/tah.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/tah.c	2008-03-26 10:39:25.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/tah.c	2008-04-22 10:02:53.000000000 +1000
@@ -35,7 +35,7 @@ int __devinit tah_attach(struct of_devic
 	return 0;
 }
 
-void __devexit tah_detach(struct of_device *ofdev, int channel)
+void tah_detach(struct of_device *ofdev, int channel)
 {
 	struct tah_instance *dev = dev_get_drvdata(&ofdev->dev);
 
Index: linux-work/drivers/net/ibm_newemac/zmii.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/zmii.c	2008-03-03 11:58:49.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/zmii.c	2008-04-22 10:02:53.000000000 +1000
@@ -189,7 +189,7 @@ void zmii_set_speed(struct of_device *of
 	mutex_unlock(&dev->lock);
 }
 
-void __devexit zmii_detach(struct of_device *ofdev, int input)
+void zmii_detach(struct of_device *ofdev, int input)
 {
 	struct zmii_instance *dev = dev_get_drvdata(&ofdev->dev);
 
