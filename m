Return-Path: <B21284@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D9E0B7137
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 21:46:29 +1100 (EST)
Received: from mail36-am1 (localhost.localdomain [127.0.0.1])	by
	mail36-am1-R.bigfish.com (Postfix) with ESMTP id 8BF86558331	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 10:46:26 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.253])	by
	mail36-am1.bigfish.com (Postfix) with ESMTP id 938BE1808051	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 10:45:50 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9CAjkAg003021	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 03:45:46 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9CB0plZ021132	for <linuxppc-dev@ozlabs.org>;
	Tue, 12 Oct 2010 06:00:52 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>,
	<linux-mtd@lists.infradead.org>
Subject: [PATCH v4 0/5] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Tue, 12 Oct 2010 18:18:29 +0800
Message-ID: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: david-b@pacbell.net, kumar.gala@freescale.com
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

v4 main change:
 - Update to the latest kernel base(Linux 2.6.36-rc7).
 - Add support to the transaction that the length is grater than 0xFFFF
   in the eSPI controller's driver.
 - Some changes according to Grant and Anton's comments.

Tested on P4080DS and MPC8536DS board.

[PATCH v4 1/5] spi/mpc8xxx: rename spi_mpc8xxx.c to spi_fsl_spi.c
[PATCH v4 2/5] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
[PATCH v4 3/5] eSPI: add eSPI controller support
[PATCH v4 4/5] powerpc/of: add eSPI controller dts bindings and DTS modification
[PATCH v4 5/5] mtd: m25p80: add support to parse the partitions by OF node

Thanks,
Mingkai
