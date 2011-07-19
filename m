Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F60BB760B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:55:05 +1000 (EST)
Received: by mail-ey0-f177.google.com with SMTP id 6so2714358eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:55:05 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 12/14] 85xx/mpc85xx_ds, ads,
	cds: move .pci_exclude_device setting to machine definitions
Date: Tue, 19 Jul 2011 12:53:49 +0400
Message-Id: <1311065631-3429-13-git-send-email-dbaryshkov@gmail.com>
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

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    5 +++--
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    5 ++---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 3b2c9bb..2483929 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -200,8 +200,6 @@ static void __init mpc85xx_ads_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
 		fsl_add_bridge(np, 1);
-
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
 
@@ -254,6 +252,9 @@ define_machine(mpc85xx_ads) {
 	.probe			= mpc85xx_ads_probe,
 	.setup_arch		= mpc85xx_ads_setup_arch,
 	.init_IRQ		= mpc85xx_ads_pic_init,
+#ifdef CONFIG_PCI
+	.pci_exclude_device	= mpc85xx_exclude_device,
+#endif
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6299a2a..e209c23 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -297,9 +297,6 @@ static void __init mpc85xx_cds_setup_arch(void)
 				fsl_add_bridge(np, 0);
 		}
 	}
-
-	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
 
@@ -355,6 +352,8 @@ define_machine(mpc85xx_cds) {
 #ifdef CONFIG_PCI
 	.restart	= mpc85xx_cds_restart,
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pci_irq_fixup	= mpc85xx_cds_pci_irq_fixup,
+	.pci_exclude_device	= mpc85xx_exclude_device,
 #else
 	.restart	= fsl_rstcr_restart,
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c7b97f7..53bf07d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -182,8 +182,6 @@ static void __init mpc85xx_ds_setup_arch(void)
 					hose->dma_window_size);
 		}
 	}
-
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
 #ifdef CONFIG_SMP
@@ -279,6 +277,7 @@ define_machine(mpc8544_ds) {
 	.init_IRQ		= mpc85xx_ds_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pci_exclude_device	= mpc85xx_exclude_device,
 #endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
@@ -293,6 +292,7 @@ define_machine(mpc8572_ds) {
 	.init_IRQ		= mpc85xx_ds_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pci_exclude_device	= mpc85xx_exclude_device,
 #endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
@@ -307,6 +307,7 @@ define_machine(p2020_ds) {
 	.init_IRQ		= mpc85xx_ds_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pci_exclude_device	= mpc85xx_exclude_device,
 #endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
-- 
1.7.2.5
