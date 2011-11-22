Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6ACB01007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 17:20:44 +1100 (EST)
Received: from mail141-ch1 (localhost [127.0.0.1])	by
 mail141-ch1-R.bigfish.com (Postfix) with ESMTP id 7CA892201AB	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 06:21:02 +0000 (UTC)
Received: from CH1EHSMHS013.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.246])	by mail141-ch1.bigfish.com (Postfix) with ESMTP id
 453116C0240	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 06:21:00
 +0000 (UTC)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] Unify pci/pcie initialization code
Date: Tue, 22 Nov 2011 06:20:34 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1320040492-6407-2-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,
We want more comments on this series of patches ([1/2] & [2/2]) to speed up=
 the pushing-to-kernel progress.
Thanks.

-----Original Message-----
From: Jia Hongtao-B38951=20
Sent: Monday, October 31, 2011 1:55 PM
To: linuxppc-dev@lists.ozlabs.org
Cc: Li Yang-R58472; Gala Kumar-B11780; Jia Hongtao-B38951
Subject: [PATCH 1/2] Unify pci/pcie initialization code

In previous version pci/pcie initialization is in platform code which Initi=
alize PCI bridge base on EP/RC or host/agent settings.
We unified pci/pcie initialization as common APIs named fsl_pci_setup which=
 can be called by platform code.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   30 ++-----------------
 arch/powerpc/sysdev/fsl_pci.c            |   48 ++++++++++++++++++++++++++=
++++
 arch/powerpc/sysdev/fsl_pci.h            |    5 +++
 3 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platfo=
rms/85xx/mpc85xx_ds.c
index 10e7db0..7188c0b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -157,33 +157,12 @@ extern void __init mpc85xx_smp_init(void);  #endif  s=
tatic void __init mpc85xx_ds_setup_arch(void)  { -#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max =3D 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
=20
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
-		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) =3D=3D primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose =3D pci_find_hose_for_OF_device(np);
-			max =3D min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
+	fsl_pci_setup(primary_phb_addr);
=20
+#ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device =3D mpc85xx_exclude_device;  #endif
=20
@@ -192,11 +171,8 @@ static void __init mpc85xx_ds_setup_arch(void)  #endif
=20
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable =3D 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
-	}
 #endif
=20
 	printk("MPC85xx DS board from Freescale Semiconductor\n"); diff --git a/a=
rch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c index 80b8b7a.=
.4d4536f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -402,6 +402,54 @@ int __init fsl_add_bridge(struct device_node *dev, int=
 is_primary)  }  #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
=20
+static struct of_device_id pci_ids[] =3D {
+	{ .compatible =3D "fsl,mpc8540-pci", },
+	{ .compatible =3D "fsl,mpc8548-pcie", },
+	{},
+};
+
+/**
+ * fsl_pci_setup - Initialization for PCI
+ * @primary_phb_addr: primary bus address
+ *
+ * Add bridge if pci controller is a host  */ void fsl_pci_setup(int=20
+primary_phb_addr) {
+	struct device_node *np;
+	struct pci_controller *hose;
+	dma_addr_t min_dma_addr =3D 0xffffffff;
+
+	for_each_node_by_type(np, "pci") {
+		if (of_match_node(pci_ids, np)) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) =3D=3D primary_phb_addr)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+
+			hose =3D pci_find_hose_for_OF_device(np);
+			min_dma_addr =3D min(min_dma_addr,
+					hose->dma_window_base_cur
+					+ hose->dma_window_size);
+
+		}
+	}
+
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * if we couldn't map all of DRAM via the dma windows we need SWIOTLB
+	 * to handle buffers located outside of dma capable memory region
+	 */
+	if (memblock_end_of_DRAM() > min_dma_addr) {
+		ppc_swiotlb_enable =3D 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
+	}
+#endif
+}
+
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pc=
ie_header);
=20
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x) diff --git a/a=
rch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h index a39ed5c.=
.775ea21 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -89,6 +89,11 @@ struct ccsr_pci {
 };
=20
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
+#ifndef CONFIG_PCI
+#define fsl_pci_setup(p)
+#else
+extern void fsl_pci_setup(int primary_phb_addr); #endif
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);  extern int mpc83x=
x_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
--
1.7.5.1
