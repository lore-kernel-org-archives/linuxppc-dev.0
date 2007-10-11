Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A7810DDFB0
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:19:07 +1000 (EST)
Date: Thu, 11 Oct 2007 15:19:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] move of_platform_driver initialisations:
	arch/powerpc
Message-Id: <20071011151903.efa8fdb8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Maxim Shchetynin <maxim@de.ibm.com>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We no longer initialise the name and owner fields of the
of_platform_driver, but use the fields of the embedded device_driver's
name field instead.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pasemi/gpio_mdio.c |    4 +++-
 arch/powerpc/sysdev/axonram.c             |    8 +++++---
 arch/powerpc/sysdev/pmi.c                 |    6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

This patch depends on my "Prepare to remove of_platform_driver name"
patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index c91a335..dae9f65 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -320,10 +320,12 @@ static struct of_device_id gpio_mdio_match[] =
 
 static struct of_platform_driver gpio_mdio_driver =
 {
-	.name		= "gpio-mdio-bitbang",
 	.match_table	= gpio_mdio_match,
 	.probe		= gpio_mdio_probe,
 	.remove		= gpio_mdio_remove,
+	.driver		= {
+		.name	= "gpio-mdio-bitbang",
+	},
 };
 
 int gpio_mdio_init(void)
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index ab037a3..4d3ba63 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -324,11 +324,13 @@ static struct of_device_id axon_ram_device_id[] = {
 };
 
 static struct of_platform_driver axon_ram_driver = {
-	.owner		= THIS_MODULE,
-	.name		= AXON_RAM_MODULE_NAME,
 	.match_table	= axon_ram_device_id,
 	.probe		= axon_ram_probe,
-	.remove		= axon_ram_remove
+	.remove		= axon_ram_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= AXON_RAM_MODULE_NAME,
+	},
 };
 
 /**
diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index 2f91b55..20edd1e 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -205,10 +205,12 @@ static int pmi_of_remove(struct of_device *dev)
 }
 
 static struct of_platform_driver pmi_of_platform_driver = {
-	.name		= "pmi",
 	.match_table	= pmi_match,
 	.probe		= pmi_of_probe,
-	.remove		= pmi_of_remove
+	.remove		= pmi_of_remove,
+	.driver		= {
+		.name	= "pmi",
+	},
 };
 
 static int __init pmi_module_init(void)
-- 
1.5.3.4
