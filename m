Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2EDF2C032E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 19:50:39 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V2 4/6] powerpc/mpc85xx: convert to unified PCI init
Date: Wed, 25 Jul 2012 17:26:59 +0800
Message-ID: <1343208421-5552-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1343208421-5552-1-git-send-email-B38951@freescale.com>
References: <1343208421-5552-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI initialization is now done by PCI controller driver. In board setup_arch
stage we don't need PCI init any more but swiotlb should be determined at this
stage.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
We now just apply this for mpc85xx_ds and qemu

 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   38 +++++++----------------------
 arch/powerpc/platforms/85xx/qemu_e500.c  |    5 +++-
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 6d3265f..3082ee8 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -117,40 +117,16 @@ void __init mpc85xx_ds_pic_init(void)
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
-static struct device_node *pci_with_uli;
-
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	if (hose->dn == pci_with_uli)
+	if (hose->is_primary)
 		return uli_exclude_device(hose, bus, devfn);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 #endif	/* CONFIG_PCI */
 
-static void __init mpc85xx_ds_pci_init(void)
-{
-#ifdef CONFIG_PCI
-	struct device_node *node;
-
-	fsl_pci_init();
-
-	/* See if we have a ULI under the primary */
-
-	node = of_find_node_by_name(NULL, "uli1575");
-	while ((pci_with_uli = of_get_parent(node))) {
-		of_node_put(node);
-		node = pci_with_uli;
-
-		if (pci_with_uli == fsl_pci_primary) {
-			ppc_md.pci_exclude_device = mpc85xx_exclude_device;
-			break;
-		}
-	}
-#endif
-}
-
 /*
  * Setup the architecture
  */
@@ -159,7 +135,11 @@ static void __init mpc85xx_ds_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
-	mpc85xx_ds_pci_init();
+#ifdef CONFIG_PCI
+	pci_check_swiotlb();
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+#endif
+
 	mpc85xx_smp_init();
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
@@ -175,9 +155,9 @@ static int __init mpc8544_ds_probe(void)
 	return !!of_flat_dt_is_compatible(root, "MPC8544DS");
 }
 
-machine_device_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
-machine_device_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
-machine_device_initcall(p2020_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 95a2e53..025c9c2 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -41,7 +41,10 @@ static void __init qemu_e500_setup_arch(void)
 {
 	ppc_md.progress("qemu_e500_setup_arch()", 0);
 
-	fsl_pci_init();
+#ifdef CONFIG_PCI
+	pci_check_swiotlb();
+#endif
+
 	mpc85xx_smp_init();
 }
 
-- 
1.7.5.1
