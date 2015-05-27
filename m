Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78AE61A0D12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:32 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 02/24] powerpc/pci: Export symbols for CXL
Date: Wed, 27 May 2015 16:06:56 +1000
Message-Id: <1432706838-20794-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Daniel Axtens <dja@axtens.net>

Export pcibios_claim_one_bus, pcibios_scan_phb and pcibios_alloc_controller.

These will be used by the CXL driver.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/pci-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0d05406..2040cd2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -89,6 +89,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 #endif
 	return phb;
 }
+EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
 
 void pcibios_free_controller(struct pci_controller *phb)
 {
@@ -1447,6 +1448,7 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 	list_for_each_entry(child_bus, &bus->children, node)
 		pcibios_claim_one_bus(child_bus);
 }
+EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
 
 
 /* pcibios_finish_adding_to_bus
@@ -1680,6 +1682,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
 			pcie_bus_configure_settings(child);
 	}
 }
+EXPORT_SYMBOL_GPL(pcibios_scan_phb);
 
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
-- 
2.1.0
