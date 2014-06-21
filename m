Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB8BB1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 11:02:26 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/8xx: Remove empty asm/mpc8xx.h
Date: Fri, 20 Jun 2014 20:02:07 -0500
Message-ID: <1403312527-4453-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1403312527-4453-1-git-send-email-scottwood@freescale.com>
References: <1403312527-4453-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

m8xx_pcmcia_ops was the only thing in this file (other than a comment
that describes a usage that doesn't match the file's contents); now
that m8xx_pcmcia_ops is gone, remove the empty file.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: netdev@vger.kernel.org
---
 arch/powerpc/include/asm/fs_pd.h                 |  1 -
 arch/powerpc/include/asm/mpc8xx.h                | 10 ----------
 arch/powerpc/platforms/8xx/m8xx_setup.c          |  1 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c     |  1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c        |  1 -
 arch/powerpc/sysdev/micropatch.c                 |  1 -
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c |  1 -
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c |  1 -
 8 files changed, 17 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/mpc8xx.h

diff --git a/arch/powerpc/include/asm/fs_pd.h b/arch/powerpc/include/asm/fs_pd.h
index 9361cd5..f79d6c7 100644
--- a/arch/powerpc/include/asm/fs_pd.h
+++ b/arch/powerpc/include/asm/fs_pd.h
@@ -28,7 +28,6 @@
 
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
-#include <asm/mpc8xx.h>
 
 extern immap_t __iomem *mpc8xx_immr;
 
diff --git a/arch/powerpc/include/asm/mpc8xx.h b/arch/powerpc/include/asm/mpc8xx.h
deleted file mode 100644
index 8ab22e8..0000000
--- a/arch/powerpc/include/asm/mpc8xx.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* This is the single file included by all MPC8xx build options.
- * Since there are many different boards and no standard configuration,
- * we have a unique include file for each.  Rather than change every
- * file that has to include MPC8xx configuration, they all include
- * this one and the configuration switching is done here.
- */
-#ifndef __CONFIG_8xx_DEFS
-#define __CONFIG_8xx_DEFS
-
-#endif /* __CONFIG_8xx_DEFS */
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 623bb43..d303774 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -18,7 +18,6 @@
 #include <linux/fsl_devices.h>
 
 #include <asm/io.h>
-#include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/prom.h>
 #include <asm/fs_pd.h>
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 3d5e4e1..5921dcb 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -35,7 +35,6 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/time.h>
-#include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/cpm1.h>
 #include <asm/fs_pd.h>
diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 251aba8..dda6078 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -37,7 +37,6 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/time.h>
-#include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/cpm1.h>
 #include <asm/fs_pd.h>
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/sysdev/micropatch.c
index c0bb76e..6727dc5 100644
--- a/arch/powerpc/sysdev/micropatch.c
+++ b/arch/powerpc/sysdev/micropatch.c
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <asm/irq.h>
-#include <asm/mpc8xx.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index fc54134..1eedfba 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -41,7 +41,6 @@
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
-#include <asm/mpc8xx.h>
 #include <asm/cpm1.h>
 #endif
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index b4bf02f..90b3b19 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -40,7 +40,6 @@
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
-#include <asm/mpc8xx.h>
 #include <asm/cpm1.h>
 #endif
 
-- 
1.9.1
