Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 334C1DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 23:13:38 +1000 (EST)
Date: Wed, 26 Sep 2007 17:15:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx: allow use on any
	processors with QUICC Engine
Message-ID: <20070926131521.GA4034@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
	<20070925151819.GA6757@localhost.localdomain>
	<20070925165845.40B0E2397FB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<7881139C-EEF1-41DC-AB0F-115632E892B8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <7881139C-EEF1-41DC-AB0F-115632E892B8@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 11:00:38PM -0500, Kumar Gala wrote:
> I'm still in favor of making it PPC_83xx || QUICC_ENGINE.

Submitting... ;-)

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC][SPI] spi_mpc83xx: allow use on any processors with QUICC Engine

Currently, all QE SPI controllers are almost the same comparing to
MPC83xx's, thus let's use that driver for them.

Tested to work on MPC85xx in loopback mode.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/Kconfig |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b915711..a77ede5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -124,16 +124,17 @@ config SPI_MPC52xx_PSC
 	  Controller in master SPI mode.
 
 config SPI_MPC83xx
-	tristate "Freescale MPC83xx SPI controller"
-	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
+	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
+	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
-	  This enables using the Freescale MPC83xx SPI controller in master
-	  mode.
+	  This enables using the Freescale MPC83xx and QUICC Engine SPI
+	  controllers in master mode.
 
 	  Note, this driver uniquely supports the SPI controller on the MPC83xx
-	  family of PowerPC processors.  The MPC83xx uses a simple set of shift
-	  registers for data (opposed to the CPM based descriptor model).
+	  family of PowerPC processors, plus processors with QUICC Engine
+	  technology. This driver uses a simple set of shift registers for data
+	  (opposed to the CPM based descriptor model).
 
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-- 
1.5.0.6
