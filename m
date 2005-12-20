Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 398F4689AD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:40:42 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKePEW030876
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:40:26 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <1.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:40:31 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/9] ppc32: Remove useless file arch/ppc/platforms/mpc5200.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Remove useless file arch/ppc/platforms/mpc5200.c

That file is a left-over of the 'old' OCP model that
should have been erased during the change to platform
model but I forgot it ...

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit 144f9d12ec7d04b38f83a131c4e544f78d2d47b2
tree 629ebc02993d06ff02b87e2d0effb257ef842328
parent 48ea753075aa15699bd5fac26faa08431aaa697b
author Sylvain Munaut <tnt@246tNt.com> Sat, 17 Dec 2005 23:03:25 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sat, 17 Dec 2005 23:03:25 +0100

 arch/ppc/platforms/mpc5200.c |   53 ------------------------------------------
 1 files changed, 0 insertions(+), 53 deletions(-)

diff --git a/arch/ppc/platforms/mpc5200.c b/arch/ppc/platforms/mpc5200.c
deleted file mode 100644
index a58db43..0000000
--- a/arch/ppc/platforms/mpc5200.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * arch/ppc/platforms/mpc5200.c
- *
- * OCP Definitions for the boards based on MPC5200 processor. Contains
- * definitions for every common peripherals. (Mostly all but PSCs)
- * 
- * Maintainer : Sylvain Munaut <tnt@246tNt.com>
- *
- * Copyright 2004 Sylvain Munaut <tnt@246tNt.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <asm/ocp.h>
-#include <asm/mpc52xx.h>
-
-
-static struct ocp_fs_i2c_data mpc5200_i2c_def = {
-        .flags  = FS_I2C_CLOCK_5200,
-};
-
-
-/* Here is the core_ocp struct.
- * With all the devices common to all board. Even if port multiplexing is
- * not setup for them (if the user don't want them, just don't select the
- * config option). The potentially conflicting devices (like PSCs) goes in
- * board specific file.
- */
-struct ocp_def core_ocp[] = {
-	{
-		.vendor         = OCP_VENDOR_FREESCALE,
-		.function       = OCP_FUNC_IIC,
-		.index          = 0,
-		.paddr          = MPC52xx_I2C1,
-		.irq            = OCP_IRQ_NA,   /* MPC52xx_IRQ_I2C1 - Buggy */
-		.pm             = OCP_CPM_NA,
-		.additions      = &mpc5200_i2c_def,
-	},
-	{
-		.vendor         = OCP_VENDOR_FREESCALE,
-		.function       = OCP_FUNC_IIC,
-		.index          = 1,
-		.paddr          = MPC52xx_I2C2,
-		.irq            = OCP_IRQ_NA,   /* MPC52xx_IRQ_I2C2 - Buggy */
-		.pm             = OCP_CPM_NA,
-		.additions      = &mpc5200_i2c_def,
-	},
-	{	/* Terminating entry */
-		.vendor		= OCP_VENDOR_INVALID
-	}
-};
