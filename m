Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id 8D5A52C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 18:22:06 +1000 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc512x: add MPC5125 reset module support for system
 restart
Date: Mon, 10 Jun 2013 10:13:52 +0200
Message-Id: <1370852032-17478-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only part of MPC5125 reset module is like as MPC5121.
In detail, RCWH register doesn't contain informations about:
- PCI arbiter
- NAND flash page size
- NAND flash port size

For this reason, in device tree, this module has a different name then
MPC5121 reset module but use the same "struct mpc512x_reset_module"
register definition and the same restart procedure.

Signed-off-by: Matteo Facchinetti <engineering@sirius-es.it>
---
 arch/powerpc/platforms/512x/mpc512x.h        |  1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index fdb4303..cc97f02 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -17,6 +17,7 @@ extern void __init mpc512x_init(void);
 extern void __init mpc512x_setup_arch(void);
 extern int __init mpc5121_clk_init(void);
 extern const char *mpc512x_select_psc_compat(void);
+extern const char *mpc512x_select_reset_compat(void);
 extern void mpc512x_restart(char *cmd);
 
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index a8b5110..a82a41b 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -35,8 +35,10 @@ static struct mpc512x_reset_module __iomem *reset_module_base;
 static void __init mpc512x_restart_init(void)
 {
 	struct device_node *np;
+	const char *reset_compat;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
+	reset_compat = mpc512x_select_reset_compat();
+	np = of_find_compatible_node(NULL, NULL, reset_compat);
 	if (!np)
 		return;
 
@@ -355,6 +357,17 @@ const char *mpc512x_select_psc_compat(void)
 	return NULL;
 }
 
+const char *mpc512x_select_reset_compat(void)
+{
+	if (of_machine_is_compatible("fsl,mpc5121"))
+		return "fsl,mpc5121-reset";
+
+	if (of_machine_is_compatible("fsl,mpc5125"))
+		return "fsl,mpc5125-reset";
+
+	return NULL;
+}
+
 static unsigned int __init get_fifo_size(struct device_node *np,
 					 char *prop_name)
 {
-- 
1.8.1.2
