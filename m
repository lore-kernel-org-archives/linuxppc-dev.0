Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEDC91A09E1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:59 +1100 (AEDT)
Received: by pdbcz9 with SMTP id cz9so17000953pdb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:57 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/27] powerpc/powernv: Move controller ops from ppc_md to
 controller_ops
Date: Wed, 25 Mar 2015 16:35:50 +1100
Message-Id: <1427261761-22952-17-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the PowerNV platform to use the pci_controller_ops
structure rather than ppc_md for PCI controller operations.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   | 7 ++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 1 +
 arch/powerpc/platforms/powernv/pci.c        | 5 ++++-
 arch/powerpc/platforms/powernv/powernv.h    | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c18e191..b4e46bf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1988,6 +1988,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		hose->last_busno = 0xff;
 	}
 	hose->private_data = phb;
+	hose->controller_ops = pnv_pci_controller_ops;
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = ioda_type;
@@ -2104,9 +2105,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * the child P2P bridges) can form individual PE.
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
-	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
-	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
-	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
+	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
+	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
+	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 6ef6d4d..4729ca7 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -133,6 +133,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	phb->hose->first_busno = 0;
 	phb->hose->last_busno = 0xff;
 	phb->hose->private_data = phb;
+	phb->hose->controller_ops = pnv_pci_controller_ops;
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_P5IOC2;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c8939ad..63518b3 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -761,7 +761,6 @@ void __init pnv_pci_init(void)
 	pci_devs_phb_init();
 
 	/* Configure IOMMU DMA hooks */
-	ppc_md.pci_dma_dev_setup = pnv_pci_dma_dev_setup;
 	ppc_md.tce_build = pnv_tce_build_vm;
 	ppc_md.tce_free = pnv_tce_free_vm;
 	ppc_md.tce_build_rm = pnv_tce_build_rm;
@@ -777,3 +776,7 @@ void __init pnv_pci_init(void)
 }
 
 machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
+
+struct pci_controller_ops pnv_pci_controller_ops = {
+	.dma_dev_setup = pnv_pci_dma_dev_setup,
+};
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 604c48e..826d2c9 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -29,6 +29,8 @@ static inline u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
 }
 #endif
 
+extern struct pci_controller_ops pnv_pci_controller_ops;
+
 extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
-- 
2.1.4
