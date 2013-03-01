Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60DDE2C032D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:18:05 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 07:18:02 -0700
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E5BDC38C801E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:18:00 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EI0xh278262
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:18:00 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EI0J8010050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:18:00 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/22] powerpc/eeh: Enable EEH check for config access
Date: Fri,  1 Mar 2013 22:17:18 +0800
Message-Id: <1362147440-14096-21-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch enables EEH check and let EEH core to process the EEH
errors for PowerNV platform while accessing config space. Originally,
the implementation already had mechanism to check EEH errors and
tried to recover from them. However, we never let EEH core to handle
the EEH errors.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c |   42 ++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b8b8e0b..6f464dc 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -31,6 +31,8 @@
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/firmware.h>
+#include <asm/eeh_event.h>
+#include <asm/eeh.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -287,6 +289,10 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
+#ifdef CONFIG_EEH
+	struct device_node *busdn, *dn;
+	struct eeh_pe *phb_pe = NULL;
+#endif
 	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
 	s64 rc;
 
@@ -319,8 +325,35 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	cfg_dbg("pnv_pci_read_config bus: %x devfn: %x +%x/%x -> %08x\n",
 		bus->number, devfn, where, size, *val);
 
-	/* Check if the PHB got frozen due to an error (no response) */
+	/*
+	 * Check if the specified PE has been put into frozen
+	 * state. On the other hand, we needn't do that while
+	 * the PHB has been put into frozen state because of
+	 * PHB-fatal errors.
+	 */
+#ifdef CONFIG_EEH
+	phb_pe = eeh_phb_pe_get(hose);
+	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
+		return PCIBIOS_SUCCESSFUL;
+
+	if (phb->eeh_enabled) {
+		if (*val == EEH_IO_ERROR_VALUE(size)) {
+			busdn = pci_bus_to_OF_node(bus);
+			for (dn = busdn->child; dn; dn = dn->sibling) {
+				struct pci_dn *pdn = PCI_DN(dn);
+
+				if (pdn && pdn->devfn == devfn &&
+					eeh_dev_check_failure(of_node_to_eeh_dev(dn),
+							EEH_EVENT_NORMAL))
+					return PCIBIOS_DEVICE_NOT_FOUND;
+			}
+		}
+	} else {
+		pnv_pci_config_check_eeh(phb, bus, bdfn);
+	}
+#else
 	pnv_pci_config_check_eeh(phb, bus, bdfn);
+#endif
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -351,8 +384,14 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
+
 	/* Check if the PHB got frozen due to an error (no response) */
+#ifdef CONFIG_EEH
+	if (!phb->eeh_enabled)
+		pnv_pci_config_check_eeh(phb, bus, bdfn);
+#else
 	pnv_pci_config_check_eeh(phb, bus, bdfn);
+#endif
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -362,7 +401,6 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
-
 static void pnv_tce_invalidate(struct iommu_table *tbl,
 			       u64 *startp, u64 *endp)
 {
-- 
1.7.5.4
