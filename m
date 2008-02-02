Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (87-194-8-8.bethere.co.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94A5DDDE2C
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 03:35:02 +1100 (EST)
Message-Id: <20080202162232.212855590@fluff.org.uk>
References: <20080202162133.678366209@fluff.org.uk>
Date: Sat, 02 Feb 2008 16:21:36 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: linux-ide@vger.kernel.org,
 jeff@garzik.org,
 htejun@gmail.com
Subject: [PATCH 3/3 2.6.24-git] PPC/LIBATA: Select HAVE_PATA_PLATFORM for
	ARCH_PPC
Cc: linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the new HAVE_PATA_PLATFORM to select PATA_PLATFORM
driver.

CC: linuxppc-dev@ozlabs.org
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.24-git12-pata2/arch/ppc/Kconfig
===================================================================
--- linux-2.6.24-git12-pata2.orig/arch/ppc/Kconfig
+++ linux-2.6.24-git12-pata2/arch/ppc/Kconfig
@@ -41,6 +41,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config PPC
 	bool
+	select HAVE_PATA_PLATFORM
 	default y
 
 config PPC32
Index: linux-2.6.24-git12-pata2/drivers/ata/Kconfig
===================================================================
--- linux-2.6.24-git12-pata2.orig/drivers/ata/Kconfig
+++ linux-2.6.24-git12-pata2/drivers/ata/Kconfig
@@ -624,7 +624,7 @@ config HAVE_PATA_PLATFORM
 
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
+	depends on EMBEDDED || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
