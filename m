Return-Path: <jslaby@suse.cz>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD5C1B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 18:06:11 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: grant.likely@secretlab.ca
Subject: [PATCH] SPI: fix build with CONFIG_SPI_FSL_ESPI=m
Date: Tue, 23 Aug 2011 09:59:05 +0200
Message-Id: <1314086345-2818-1-git-send-email-jslaby@suse.cz>
Cc: spi-devel-general@lists.sourceforge.net, Jiri Slaby <jslaby@suse.cz>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
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
struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h.

We need to add a test for CONFIG_SPI_FSL_ESPI_MODULE too.

The error looks like:
drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no member named 'len'
...

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/spi/spi-fsl-lib.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index cbe881b..97968de 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -28,7 +28,7 @@ struct mpc8xxx_spi {
 	/* rx & tx bufs from the spi_transfer */
 	const void *tx;
 	void *rx;
-#ifdef CONFIG_SPI_FSL_ESPI
+#if defined(CONFIG_SPI_FSL_ESPI) || defined(CONFIG_SPI_FSL_ESPI_MODULE)
 	int len;
 #endif
 
-- 
1.7.6
