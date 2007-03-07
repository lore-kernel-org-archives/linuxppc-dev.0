Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6D0C0DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 05:22:45 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l27IMagJ005715
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 11:22:36 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l27IMZLd002053
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 12:22:36 -0600 (CST)
Subject: [PATCH] Fix e500 v2 core reboot bug
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173291755.23776.121.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 12:22:35 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

For e500 v2 core, a new reset control register is added.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Acked-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/85xx/misc.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/platforms/85xx/misc.c
index 3e62fcb..9fcbf56 100644
--- a/arch/powerpc/platforms/85xx/misc.c
+++ b/arch/powerpc/platforms/85xx/misc.c
@@ -13,11 +13,21 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <asm/irq.h>
+#include <asm/io.h>
+#include <sysdev/fsl_soc.h>
 
 extern void abort(void);
 
 void mpc85xx_restart(char *cmd)
 {
+	unsigned int pvr;
+
+	pvr = mfspr(SPRN_PVR);
+	if ((pvr >> 16) & 0x1){
+		u32 __iomem *rstcr;
+		rstcr = ioremap(get_immrbase() + 0xE00B0, 0x100);
+		*rstcr = 0x2;           /* HRESET_REQ */
+	}
 	local_irq_disable();
 	abort();
 }
-- 
1.5.0.1.213.g509b
