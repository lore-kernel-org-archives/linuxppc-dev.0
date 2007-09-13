Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69E83DE0DA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:35 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/22] [POWERPC] 83xx: Removed PCI exclude of PHB
Date: Thu, 13 Sep 2007 16:07:51 -0500
Message-Id: <11897177013875-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897176992010-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that the generic code doesn't assign resources for Freescale
PHBs we dont have to explicitly exclude it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |    2 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 --
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    2 --
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    2 --
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 -
 arch/powerpc/platforms/83xx/mpc83xx.h     |    2 --
 arch/powerpc/platforms/83xx/pci.c         |    7 -------
 8 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 3edfe17..140b46f 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -45,8 +45,6 @@ static void __init mpc8313_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 	mpc831x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 61e3f1c..d494bc4 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -75,7 +75,6 @@ static void __init mpc832x_sys_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 0909061..e6c1760 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -49,8 +49,6 @@ static void __init mpc832x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 6d06645..870fd20 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -54,8 +54,6 @@ static void __init mpc834x_itx_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
 	mpc834x_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index f8aba9a..a9140b6 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -85,8 +85,6 @@ static void __init mpc834x_mds_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
 	mpc834xemds_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 69970b9..db69576 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -81,7 +81,6 @@ static void __init mpc836x_mds_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 589ee55..b778cb4 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -49,8 +49,6 @@
  */
 
 extern int mpc83xx_add_bridge(struct device_node *dev);
-extern int mpc83xx_exclude_device(struct pci_controller *hose,
-				  u_char bus, u_char devfn);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 extern int mpc834x_usb_cfg(void);
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 9206946..80425d7 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -33,13 +33,6 @@
 #define DBG(x...)
 #endif
 
-int mpc83xx_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
-{
-	if ((bus == hose->first_busno) && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	return PCIBIOS_SUCCESSFUL;
-}
-
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
 	int len;
-- 
1.5.2.4
