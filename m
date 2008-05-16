Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 58DB5DDFE4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 02:50:56 +1000 (EST)
Date: Fri, 16 May 2008 20:50:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: [PATCH 1/4] [SPI] [POWERPC] spi_mpc83xx: handles Freescale MPC8610
	as well
Message-ID: <20080516165052.GA24196@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With this patch we'll able to select spi_mpc83xx driver on the MPC86xx
processors.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This patch is on top of Jochen's patch (
http://patchwork.ozlabs.org/linuxppc/patch?id=18261)
that fixes SPI on MPC8610.

 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 66ec5d8..094c237 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -125,7 +125,7 @@ config SPI_MPC52xx_PSC
 
 config SPI_MPC83xx
 	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
-	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
+	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE || PPC_86xx) && EXPERIMENTAL
 	help
 	  This enables using the Freescale MPC83xx and QUICC Engine SPI
 	  controllers in master mode.
-- 
1.5.5.1
