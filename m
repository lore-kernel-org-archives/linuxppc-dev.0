Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2A423DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Apr 2009 05:28:04 +1000 (EST)
Date: Sat, 4 Apr 2009 23:28:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 1/3] spi_mpc83xx: Handles other Freescale processors
Message-ID: <20090404192802.GA12183@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With this patch we'll able to select spi_mpc83xx driver on the MPC86xx
platforms. Let the driver depend on FSL_SOC, so we don't have to worry
about Kconfig anymore.

Also remove the "experimental" dependency, the driver has been tested
to work on a various hardware, and surely not experimental anymore.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/Kconfig |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83a185d..3c1845c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -140,16 +140,14 @@ config SPI_MPC52xx_PSC
 	  Controller in master SPI mode.
 
 config SPI_MPC83xx
-	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
-	depends on (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
+	tristate "Freescale MPC8xxx SPI controller"
+	depends on FSL_SOC
 	help
-	  This enables using the Freescale MPC83xx and QUICC Engine SPI
-	  controllers in master mode.
+	  This enables using the Freescale MPC8xxx SPI controllers in master
+	  mode.
 
-	  Note, this driver uniquely supports the SPI controller on the MPC83xx
-	  family of PowerPC processors, plus processors with QUICC Engine
-	  technology. This driver uses a simple set of shift registers for data
-	  (opposed to the CPM based descriptor model).
+	  This driver uses a simple set of shift registers for data (opposed
+	  to the CPM based descriptor model).
 
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-- 
1.5.6.5
