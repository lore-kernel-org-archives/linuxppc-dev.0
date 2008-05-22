Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 907D2DDF96
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 14:26:53 +1000 (EST)
Date: Wed, 21 May 2008 23:26:08 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: dougthompson@xmission.com
Subject: [PATCH] edac: mpc85xx - Fix building as a module
Message-ID: <Pine.LNX.4.64.0805212326000.32442@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

including of <asm/mpc85xx.h> causes build problems since it doesn't exist.

Also removed warning:
drivers/edac/mpc85xx_edac.c:45: warning: 'mpc85xx_ctl_name' defined but not used

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This is a fix for 2.6.26.

- k

 drivers/edac/mpc85xx_edac.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 065732d..d49361b 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -20,7 +20,6 @@

 #include <linux/of_platform.h>
 #include <linux/of_device.h>
-#include <asm/mpc85xx.h>
 #include "edac_module.h"
 #include "edac_core.h"
 #include "mpc85xx_edac.h"
@@ -43,8 +42,6 @@ static u32 orig_pci_err_en;
 static u32 orig_l2_err_disable;
 static u32 orig_hid1;

-static const char *mpc85xx_ctl_name = "MPC85xx";
-
 /************************ MC SYSFS parts ***********************************/

 static ssize_t mpc85xx_mc_inject_data_hi_show(struct mem_ctl_info *mci,
-- 
1.5.4.5
