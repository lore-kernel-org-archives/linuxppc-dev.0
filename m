Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 999F1B752F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:55:02 +1000 (EST)
Received: by mail-ey0-f177.google.com with SMTP id 6so2714299eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:55:02 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 10/14] 85xx/mpc85xx_rdb: merge p1020_rdb and p2020_rdb machine
	entries
Date: Tue, 19 Jul 2011 12:53:47 +0400
Message-Id: <1311065631-3429-11-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

p1020_rdb and p2020_rdb machine entries bear no in-kernel differencies
other than dt compatible strings. Merge them into single machine entry
named mpc85xx_rdb

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   40 ++++++----------------------
 1 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 088f30b..7a3a37b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -120,47 +120,25 @@ static int __init mpc85xxrdb_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
 }
-machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
-machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
+machine_device_initcall(mpc85xx_rdb, mpc85xxrdb_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
  */
-static int __init p2020_rdb_probe(void)
+static int __init mpc85xx_rdb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB"))
+	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB") ||
+	    of_flat_dt_is_compatible(root, "fsl,P2020RDB")) {
 		return 1;
-	return 0;
+	} else
+		return 0;
 }
 
-static int __init p1020_rdb_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB"))
-		return 1;
-	return 0;
-}
-
-define_machine(p2020_rdb) {
-	.name			= "P2020 RDB",
-	.probe			= p2020_rdb_probe,
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-
-define_machine(p1020_rdb) {
-	.name			= "P1020 RDB",
-	.probe			= p1020_rdb_probe,
+define_machine(mpc85xx_rdb) {
+	.name			= "MPC85xx RDB",
+	.probe			= mpc85xx_rdb_probe,
 	.setup_arch		= mpc85xx_rdb_setup_arch,
 	.init_IRQ		= mpc85xx_rdb_pic_init,
 #ifdef CONFIG_PCI
-- 
1.7.2.5
