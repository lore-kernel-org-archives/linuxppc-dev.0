Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CE2E1A0232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 16:03:00 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/2] Revert "powerpc/pci: Remove unused struct pci_dn.pcidev
 field"
Date: Wed, 28 Oct 2015 16:00:01 +1100
Message-Id: <1446008402-24892-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1446008402-24892-1-git-send-email-alistair@popple.id.au>
References: <1446008402-24892-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit removed the pcidev field from struct pci_dn as it was no
longer in use by the kernel. However to support finding the
association of Nvlink devices to GPU devices from the device-tree this
field is required.

This reverts commit 250c7b277c65.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/pci-bridge.h     | 1 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 37fc535..54843ca 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -205,6 +205,7 @@ struct pci_dn {
 
 	int	pci_ext_config_space;	/* for pci devices */
 
+	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
 #endif
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 414fd1a..42b4bb2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1007,6 +1007,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
+		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		pe->dma_weight += pnv_ioda_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
-- 
2.1.4
