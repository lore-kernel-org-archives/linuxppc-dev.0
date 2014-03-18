Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5553C2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 08:10:43 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c-cpm: Fix build by adding of_address.h and of_irq.h
Date: Tue, 18 Mar 2014 16:10:24 -0500
Message-ID: <1395177024-5178-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Richard Weinberger <richard@nod.at>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes a build break due to the undeclared use of irq_of_parse_and_map()
and of_iomap().  This build break was apparently introduced while the
driver was unbuildable due to the bug fixed by
62c19c9d29e65086e5ae76df371ed2e6b23f00cd ("i2c: Remove usage of
orphaned symbol OF_I2C").  When 62c19c was added in v3.14-rc7,
the driver was enabled again, breaking the powerpc mpc85xx_defconfig
and mpc85xx_smp_defconfig.

62c19c is marked for stable, so this should go there as well.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: stable@kernel.org
---
There are still warnings in this driver that suggest it is broken with
CONFIG_PHYS_64BIT, but that part does not appear to be a regression.

 drivers/i2c/busses/i2c-cpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index be7f0a2..f3b89a4 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -39,7 +39,9 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <asm/cpm.h>
-- 
1.8.3.2
