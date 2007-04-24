Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8BD36DDF8C
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 03:58:36 +1000 (EST)
Date: Tue, 24 Apr 2007 12:58:34 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: Kconfig for mdio_gpio
Message-ID: <20070424175834.GA7985@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/pasemi/gpio_mdio.c really depends on CONFIG_PHYLIB.
Add a config option for it, allow for it to be disabled if needed and fix
the dependency.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 64e5525..4b5f137 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -19,4 +19,12 @@ config PPC_PASEMI_IOMMU
 	help
 	  IOMMU support for PA6T-1682M
 
+config PPC_PASEMI_MDIO
+	depends on PPC_PASEMI
+	bool "MDIO support via GPIO"
+	default y
+	select PHYLIB
+	help
+	  Driver for MDIO via GPIO on PWRficient platforms
+
 endmenu
diff --git a/arch/powerpc/platforms/pasemi/Makefile b/arch/powerpc/platforms/pasemi/Makefile
index e90265f..7ffd43b 100644
--- a/arch/powerpc/platforms/pasemi/Makefile
+++ b/arch/powerpc/platforms/pasemi/Makefile
@@ -1,2 +1,2 @@
-obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o gpio_mdio.o
-
+obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o
+obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
