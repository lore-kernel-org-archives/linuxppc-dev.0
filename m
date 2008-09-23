Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03D9FDDF95
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:47:12 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org, yorksun@freescale.com
Subject: [PATCH] powerpc: remove support for bootmem-allocated memory for the
	DIU driver
Date: Tue, 23 Sep 2008 09:47:01 -0500
Message-Id: <1222181221-13425-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Early versions of the Freescale DIU framebuffer driver depended on a bootmem
allocation of memory for the video buffer.  The need for this feature was
removed in commit 6b51d51a, so now we can remove the platform-specific code
that allocated that memory.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.28.

 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 -
 arch/powerpc/sysdev/fsl_soc.c              |   38 +---------------------------
 arch/powerpc/sysdev/fsl_soc.h              |    8 ------
 3 files changed, 1 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 5eedb71..e8d54ac 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -238,7 +238,6 @@ static void __init mpc86xx_hpcd_setup_arch(void)
         }
 #endif
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-	preallocate_diu_videomemory();
 	diu_ops.get_pixel_format	= mpc8610hpcd_get_pixel_format;
 	diu_ops.set_gamma_table		= mpc8610hpcd_set_gamma_table;
 	diu_ops.set_monitor_port	= mpc8610hpcd_set_monitor_port;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 214388e..a64a23e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -767,42 +767,6 @@ void fsl_rstcr_restart(char *cmd)
 #endif
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-struct platform_diu_data_ops diu_ops = {
-	.diu_size = 1280 * 1024 * 4,	/* default one 1280x1024 buffer */
-};
+struct platform_diu_data_ops diu_ops;
 EXPORT_SYMBOL(diu_ops);
-
-int __init preallocate_diu_videomemory(void)
-{
-	pr_debug("diu_size=%lu\n", diu_ops.diu_size);
-
-	diu_ops.diu_mem = __alloc_bootmem(diu_ops.diu_size, 8, 0);
-	if (!diu_ops.diu_mem) {
-		printk(KERN_ERR "fsl-diu: cannot allocate %lu bytes\n",
-			diu_ops.diu_size);
-		return -ENOMEM;
-	}
-
-	pr_debug("diu_mem=%p\n", diu_ops.diu_mem);
-
-	rh_init(&diu_ops.diu_rh_info, 4096, ARRAY_SIZE(diu_ops.diu_rh_block),
-		diu_ops.diu_rh_block);
-	return rh_attach_region(&diu_ops.diu_rh_info,
-				(unsigned long) diu_ops.diu_mem,
-				diu_ops.diu_size);
-}
-
-static int __init early_parse_diufb(char *p)
-{
-	if (!p)
-		return 1;
-
-	diu_ops.diu_size = _ALIGN_UP(memparse(p, &p), 8);
-
-	pr_debug("diu_size=%lu\n", diu_ops.diu_size);
-
-	return 0;
-}
-early_param("diufb", early_parse_diufb);
-
 #endif
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 0242998..60f7f22 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -20,14 +20,7 @@ extern int fsl_spi_init(struct spi_board_info *board_infos,
 extern void fsl_rstcr_restart(char *cmd);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-#include <linux/bootmem.h>
-#include <asm/rheap.h>
 struct platform_diu_data_ops {
-	rh_block_t diu_rh_block[16];
-	rh_info_t diu_rh_info;
-	unsigned long diu_size;
-	void *diu_mem;
-
 	unsigned int (*get_pixel_format) (unsigned int bits_per_pixel,
 		int monitor_port);
 	void (*set_gamma_table) (int monitor_port, char *gamma_table_base);
@@ -38,7 +31,6 @@ struct platform_diu_data_ops {
 };
 
 extern struct platform_diu_data_ops diu_ops;
-int __init preallocate_diu_videomemory(void);
 #endif
 
 #endif
-- 
1.5.5
