Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 709EDDE173
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 04:28:35 +1000 (EST)
Date: Fri, 23 May 2008 22:28:34 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC PATCH 1/2] mmc_spi: export probe and remove functions
Message-ID: <20080523182834.GA469@polina.dev.rtsoft.ru>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080523182754.GA26891@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

...so we'll able to write bindings for the OpenFirmware without
messing with #ifdefs in the driver itself.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/mmc_spi.c |    6 ++++--
 drivers/mmc/host/mmc_spi.h |    7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_spi.h

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 85d9853..f2c4fc2 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1184,7 +1184,7 @@ static int maybe_count_child(struct device *dev, void *c)
 	return 0;
 }
 
-static int mmc_spi_probe(struct spi_device *spi)
+int mmc_spi_probe(struct spi_device *spi)
 {
 	void			*ones;
 	struct mmc_host		*mmc;
@@ -1366,9 +1366,10 @@ nomem:
 	kfree(ones);
 	return status;
 }
+EXPORT_SYMBOL(mmc_spi_probe);
 
 
-static int __devexit mmc_spi_remove(struct spi_device *spi)
+int __devexit mmc_spi_remove(struct spi_device *spi)
 {
 	struct mmc_host		*mmc = dev_get_drvdata(&spi->dev);
 	struct mmc_spi_host	*host;
@@ -1398,6 +1399,7 @@ static int __devexit mmc_spi_remove(struct spi_device *spi)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(mmc_spi_remove);
 
 
 static struct spi_driver mmc_spi_driver = {
diff --git a/drivers/mmc/host/mmc_spi.h b/drivers/mmc/host/mmc_spi.h
new file mode 100644
index 0000000..d4fcd91
--- /dev/null
+++ b/drivers/mmc/host/mmc_spi.h
@@ -0,0 +1,7 @@
+#ifndef __DRIVERS_MMC_HOST_MMC_SPI_H
+#define __DRIVERS_MMC_HOST_MMC_SPI_H
+
+extern int mmc_spi_probe(struct spi_device *spi);
+extern int __devexit mmc_spi_remove(struct spi_device *spi);
+
+#endif
-- 
1.5.5.1
