Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 39C8A1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 07:18:25 +1100 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: grant.likely@secretlab.ca
Subject: [PATCH -resend 1/1] SPI: disable CONFIG_SPI_FSL_ESPI=m build
Date: Wed,  7 Dec 2011 21:18:16 +0100
Message-Id: <1323289096-13599-1-git-send-email-jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jirislaby@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When spi_fsl_espi is chosen to be built as a module, there is a build
error because we test only CONFIG_SPI_FSL_ESPI in declaration of
struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h. Also some called
functions are not exported.

So we forbid CONFIG_SPI_FSL_ESPI to be tristate here.

The error looks like:
drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no member named 'len'
...

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
Maybe Grant is back already?

 drivers/spi/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9c90a7a..3d292be 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -198,7 +198,7 @@ config SPI_FSL_LIB
 	depends on FSL_SOC
 
 config SPI_FSL_SPI
-	tristate "Freescale SPI controller"
+	bool "Freescale SPI controller"
 	depends on FSL_SOC
 	select SPI_FSL_LIB
 	help
@@ -207,7 +207,7 @@ config SPI_FSL_SPI
 	  MPC8569 uses the controller in QE mode, MPC8610 in cpu mode.
 
 config SPI_FSL_ESPI
-	tristate "Freescale eSPI controller"
+	bool "Freescale eSPI controller"
 	depends on FSL_SOC
 	select SPI_FSL_LIB
 	help
-- 
1.7.7.3
