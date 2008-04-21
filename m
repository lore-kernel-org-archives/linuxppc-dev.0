Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 203A5DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:19:33 +1000 (EST)
Message-ID: <480CBA91.5050003@harris.com>
Date: Mon, 21 Apr 2008 12:02:25 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: RFC: Possible section mismatch problem in ibm_newemac?
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am using a recent DENX git tree.  I want to enable debugging in prom_parse.c.
When I do that, I see link warnings like:

WARNING: drivers/net/ibm_newemac/ibm_newemac.o(.data+0x6e0): Section mismatch in reference from the variable emac_of_bus_notifier to the function .devinit.text:emac_of_bus_notify()
The variable emac_of_bus_notifier references
the function __devinit emac_of_bus_notify()

WARNING: drivers/net/ibm_newemac/built-in.o(.devinit.text+0x14d4): Section mismatch in reference from the function emac_probe() to the function .devexit.text:rgmii_detach()
The function __devinit emac_probe() references
a function __devexit rgmii_detach().

I've made the following changes, which clean up the link warnings, but I'm not
sure this is the right way to fix the problem.  If it is correct, I'd like to
submit the patch.

Signed-off-by: Steve Falco <sfalco@harris.com>
---

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 5153901..d54393e 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2241,7 +2241,7 @@ static int __devinit emac_of_bus_notify(struct notifier_block *nb,
 	return 0;
 }
 
-static struct notifier_block emac_of_bus_notifier = {
+static struct notifier_block __devinitdata emac_of_bus_notifier = {
 	.notifier_call = emac_of_bus_notify
 };
 
diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
index fb9c9eb..e9dbd6b 100644
--- a/drivers/net/ibm_newemac/mal.c
+++ b/drivers/net/ibm_newemac/mal.c
@@ -61,7 +61,7 @@ int __devinit mal_register_commac(struct mal_instance	*mal,
 	return 0;
 }
 
-void __devexit mal_unregister_commac(struct mal_instance	*mal,
+void mal_unregister_commac(struct mal_instance	*mal,
 				     struct mal_commac		*commac)
 {
 	unsigned long flags;
diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
index 5757788..e32da3d 100644
--- a/drivers/net/ibm_newemac/rgmii.c
+++ b/drivers/net/ibm_newemac/rgmii.c
@@ -179,7 +179,7 @@ void rgmii_put_mdio(struct of_device *ofdev, int input)
 	mutex_unlock(&dev->lock);
 }
 
-void __devexit rgmii_detach(struct of_device *ofdev, int input)
+void rgmii_detach(struct of_device *ofdev, int input)
 {
 	struct rgmii_instance *dev = dev_get_drvdata(&ofdev->dev);
 	struct rgmii_regs __iomem *p = dev->base;
diff --git a/drivers/net/ibm_newemac/zmii.c b/drivers/net/ibm_newemac/zmii.c
index 2ea472a..17b1541 100644
--- a/drivers/net/ibm_newemac/zmii.c
+++ b/drivers/net/ibm_newemac/zmii.c
@@ -189,7 +189,7 @@ void zmii_set_speed(struct of_device *ofdev, int input, int speed)
 	mutex_unlock(&dev->lock);
 }
 
-void __devexit zmii_detach(struct of_device *ofdev, int input)
+void zmii_detach(struct of_device *ofdev, int input)
 {
 	struct zmii_instance *dev = dev_get_drvdata(&ofdev->dev);
 
