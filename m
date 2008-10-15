Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A9EADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 01:18:04 +1100 (EST)
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.8/8.13.8/Recconet-2008030801) with ESMTP id
	m9FCxW9q009138
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 14:59:32 +0200
Received: from [172.16.135.104] (galileo.recco.de [172.16.135.104])
	(authenticated bits=0)
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-2005061101) with ESMTP id
	m9FD0lwD017750
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 15:00:47 +0200
Subject: [PATCH] powerpc: SPI: specify chip select active high
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 15 Oct 2008 15:00:47 +0200
Message-Id: <1224075647.4022.33.camel@galileo.recco.de>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch allows to specify that an SPI device needs an active high chip
select.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

--- linux-2.6.27-rc7/drivers/of/of_spi.c.of_spi_cshigh	2008-09-22 00:29:55.000000000 +0200
+++ linux-2.6.27-rc7/drivers/of/of_spi.c	2008-09-29 13:43:06.000000000 +0200
@@ -61,6 +61,8 @@
 			spi->mode |= SPI_CPHA;
 		if (of_find_property(nc, "spi-cpol", NULL))
 			spi->mode |= SPI_CPOL;
+		if (of_find_property(nc, "spi-cs-high", NULL))
+			spi->mode |= SPI_CS_HIGH;
 
 		/* Device speed */
 		prop = of_get_property(nc, "spi-max-frequency", &len);
--- linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt.of_spi_cshigh	2008-09-29 14:14:08.000000000 +0200
+++ linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt	2008-09-29 14:24:26.000000000 +0200
@@ -1917,6 +1917,8 @@
 			inverse clock polarity (CPOL) mode
     - spi-cpha        - (optional) Empty property indicating device requires
 			shifted clock phase (CPHA) mode
+    - spi-cs-high     - (optional) Empty property indicating device requires
+			chip select active high
 
     SPI example for an MPC5200 SPI bus:
 		spi@f00 {
