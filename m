Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 28D47DDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 01:01:06 +1000 (EST)
Date: Tue, 25 Sep 2007 19:02:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH v2 7/7] [POWERPC][SPI] spi_mpc83xx: allow use on MPC85xx
Message-ID: <20070925150255.GA5716@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<874phiol7j.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <874phiol7j.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 04:48:00PM +0200, Peter Korsgaard wrote:
> >>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
> Hi,
>  
>  Anton>  config SPI_MPC83xx
>  Anton>  	tristate "Freescale MPC83xx SPI controller"
>  Anton> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
>  Anton> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
>  Anton>  	select SPI_BITBANG
>  Anton>  	help
>  Anton>  	  This enables using the Freescale MPC83xx SPI controller in master
> 
> Please also update the help text.

Oops. Thanks, fixed.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH v2] [POWERPC][SPI] spi_mpc83xx: allow use on MPC85xx

MPC85xx's QE SPI controller is almost the same comparing to MPC83xx.
Thus lets use that driver. Tested to work in loopback mode.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/Kconfig |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b915711..7a7a42c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -124,16 +124,17 @@ config SPI_MPC52xx_PSC
 	  Controller in master SPI mode.
 
 config SPI_MPC83xx
-	tristate "Freescale MPC83xx SPI controller"
-	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
+	tristate "Freescale MPC83xx/MPC85xx SPI controller"
+	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
-	  This enables using the Freescale MPC83xx SPI controller in master
-	  mode.
+	  This enables using the Freescale MPC83xx/MPC85xx SPI controller in
+	  master mode.
 
 	  Note, this driver uniquely supports the SPI controller on the MPC83xx
-	  family of PowerPC processors.  The MPC83xx uses a simple set of shift
-	  registers for data (opposed to the CPM based descriptor model).
+	  and MPC85xx family of PowerPC processors.  The MPC83xx/MPC85xx uses a
+	  simple set of shift registers for data (opposed to the CPM based
+	  descriptor model).
 
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-- 
1.5.0.6
