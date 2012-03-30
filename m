Return-Path: <kenth.eriksson@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5D6F4B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 02:15:14 +1100 (EST)
From: Kenth Eriksson <kenth.eriksson@transmode.com>
To: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 joakim.tjernlund@transmode.com
Subject: [PATCH] Bug fix in commit 178db7d3 triggered a bug in the SPI driver
 for MPC83XX (pdata is NULL).
Date: Fri, 30 Mar 2012 17:05:30 +0200
Message-Id: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
Cc: Kenth Eriksson <kenth.eriksson@transmode.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After commit 178db7d3 devices are initialized as children of the bus master, not children of the bus masters parent device. The pdata pointer used in fsl_spi_chipselect must updated to reflect the changed initialization.

Signed-off-by: Kenth Eriksson <kenth.eriksson@transmode.com>
---
 drivers/spi/spi-fsl-spi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 7d6ca68..dc747a0 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -139,10 +139,12 @@ static void fsl_spi_change_mode(struct spi_device *spi)
 static void fsl_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	struct fsl_spi_platform_data *pdata = spi->dev.parent->platform_data;
+	struct fsl_spi_platform_data *pdata;
 	bool pol = spi->mode & SPI_CS_HIGH;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
 
+	pdata = spi->dev.parent->parent->platform_data;
+
 	if (value == BITBANG_CS_INACTIVE) {
 		if (pdata->cs_control)
 			pdata->cs_control(spi, !pol);
-- 
1.7.3.4
