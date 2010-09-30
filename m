Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D68ADB70A9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 18:25:57 +1000 (EST)
Received: from mail121-tx2 (localhost.localdomain [127.0.0.1])	by
	mail121-tx2-R.bigfish.com (Postfix) with ESMTP id D56CE1990104	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:25:53 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.239])	by
	mail121-tx2.bigfish.com (Postfix) with ESMTP id EE8A4238050	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:25:52 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8U8Po50021187	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 01:25:51 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8U8fXH4017737	for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Sep 2010 03:41:34 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>,
	<linux-mtd@lists.infradead.org>
Subject: [PATCH v3 0/7] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Thu, 30 Sep 2010 16:00:39 +0800
Message-ID: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset refactor the file spi_mpc8xxx.c to abstract some common 
code as a lib used by the SPI/eSPI controller driver, move the SPI 
controller driver code to spi_fsl_spi.c, and add the eSPI controller 
support with spi_fsl_espi.c.

Tested on P4080DS and MPC8536DS board based on latest Linux tree.

v3 main changes:
 - Update to the latest kernel base.
 - Change the file spi_mpc8xxx.c to spi_fsl_fsl.c verbatim.
 - Add the SPI flash partition code to the m25p80 probe function.
 - Add a quirks for SPI master to handle the contrains of the controller.

[PATCH v3 1/7] spi/mpc8xxx: rename spi_mpc8xxx.c to spi_fsl_spi.c
[PATCH v3 2/7] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
[PATCH v3 3/7] eSPI: add eSPI controller support
[PATCH v3 4/7] powerpc/of: add eSPI controller dts bindings and DTS modification
[PATCH v3 5/7] mtd: m25p80: add support to parse the SPI flash's partitions
[PATCH v3 6/7] mtd: m25p80: add a read function to read page by page
[PATCH v3 7/7] DTS: add fsl,spi-quirk-trans-len-limit property

Thanks,
Mingkai
