Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB7A0B70E4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 00:56:02 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: grant.likely@secretlab.ca
Subject: [PATCH] spi/fsl_spi: Fix compile errors when building on ppc64
Date: Thu, 14 Oct 2010 08:55:47 -0500
Message-Id: <1287064547-8876-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We get the following when building on ppc64 due to lack of include of
<asm/io.h>:

In file included from drivers/spi/spi_fsl_espi.c:25:0:
drivers/spi/spi_fsl_lib.h: In function 'mpc8xxx_spi_write_reg':
drivers/spi/spi_fsl_lib.h:88:2: error: implicit declaration of function 'out_be32'
drivers/spi/spi_fsl_lib.h: In function 'mpc8xxx_spi_read_reg':
drivers/spi/spi_fsl_lib.h:93:2: error: implicit declaration of function 'in_be32'
drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_remove':
drivers/spi/spi_fsl_espi.c:571:2: error: implicit declaration of function 'iounmap'
drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_probe':
drivers/spi/spi_fsl_espi.c:602:2: error: implicit declaration of function 'ioremap'
drivers/spi/spi_fsl_espi.c:602:24: warning: assignment makes pointer from integer without a cast

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/spi/spi_fsl_lib.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
index 15aa6c2..281e060 100644
--- a/drivers/spi/spi_fsl_lib.h
+++ b/drivers/spi/spi_fsl_lib.h
@@ -18,6 +18,8 @@
 #ifndef __SPI_FSL_LIB_H__
 #define __SPI_FSL_LIB_H__
 
+#include <asm/io.h>
+
 /* SPI/eSPI Controller driver's private data. */
 struct mpc8xxx_spi {
 	struct device *dev;
-- 
1.7.2.3
