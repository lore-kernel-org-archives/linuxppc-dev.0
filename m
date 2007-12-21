Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B377BDDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:50:13 +1100 (EST)
Date: Fri, 21 Dec 2007 15:49:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/3] [POWERPC] the pci_dn pcidev is only used by EEH
Message-Id: <20071221154911.c437013e.sfr@canb.auug.org.au>
In-Reply-To: <20071221154818.95b51c8a.sfr@canb.auug.org.au>
References: <20071221154818.95b51c8a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |    1 -
 include/asm-powerpc/pci-bridge.h     |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 30e3d99..9319410 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -438,7 +438,6 @@ void __init iSeries_pcibios_fixup_resources(struct pci_dev *pdev)
 	}
 
 	pdev->sysdata = node;
-	PCI_DN(node)->pcidev = pdev;
 	allocate_device_bars(pdev);
 	iseries_device_information(pdev, bus, *sub_bus);
 	iommu_devnode_init_iSeries(pdev, node);
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 07cdb5b..2932404 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -170,12 +170,12 @@ struct pci_dn {
 
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
-	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
 
 	int	pci_ext_config_space;	/* for pci devices */
 
 #ifdef CONFIG_EEH
+	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	int	class_code;		/* pci device class */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
