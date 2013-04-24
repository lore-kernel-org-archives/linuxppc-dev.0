Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2F552C011C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:37:53 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 03:37:50 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2D6C31FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 03:32:44 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O9bklJ132836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 03:37:46 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O9bjh4030572
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 03:37:46 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/7] powerpc/powernv: Retrieve IODA2 tables explicitly
Date: Wed, 24 Apr 2013 17:37:34 +0800
Message-Id: <1366796259-29412-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PHB3, which is compatible with IODA2, have lots of tables (RTT/
PETLV/PEST/IVT/RBA) in system memory and have corresponding BARs to
trace the system memory address. The tables have been allocated in
firmware and exported through device-tree. The patch retrieves the
tables explicitly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           |    5 +--
 arch/powerpc/platforms/powernv/pci-ioda.c |   35 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   13 ++++++++++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a4b28f1..0af7ba0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -491,9 +491,8 @@ int64_t opal_pci_map_pe_mmio_window(uint64_t phb_id, uint16_t pe_number,
 				    uint16_t window_type, uint16_t window_num,
 				    uint16_t segment_num);
 int64_t opal_pci_set_phb_table_memory(uint64_t phb_id, uint64_t rtt_addr,
-				      uint64_t ivt_addr, uint64_t ivt_len,
-				      uint64_t reject_array_addr,
-				      uint64_t peltv_addr);
+				      uint64_t peltv_addr, uint64_t pest_addr,
+				      uint64_t ivt_addr, uint64_t rba_addr);
 int64_t opal_pci_set_pe(uint64_t phb_id, uint64_t pe_number, uint64_t bus_dev_func,
 			uint8_t bus_compare, uint8_t dev_compare, uint8_t func_compare,
 			uint8_t pe_action);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3d4e958..0c15870 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -852,6 +852,23 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
 }
 
+static void __init pnv_pci_get_ioda2_table(struct device_node *np,
+					   const char *name,
+					   void **table,
+					   unsigned int *len)
+{
+	const u32 *prop32;
+	u64 base;
+
+	prop32 = of_get_property(np, name, NULL);
+	if (prop32) {
+		base = be32_to_cpup(prop32);
+		base = base << 32 | be32_to_cpup(prop32 + 1);
+		*table = __va(base);
+		*len = be32_to_cpup(prop32 + 2);
+	}
+}
+
 void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 {
 	struct pci_controller *hose;
@@ -998,6 +1015,24 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
+	/* Retrieve variable IODA2 tables */
+	if (ioda_type == PNV_PHB_IODA2) {
+		pnv_pci_get_ioda2_table(np, "ibm,opal-rtt-table",
+				&phb->ioda.tbl_rtt, &phb->ioda.rtt_len);
+		pnv_pci_get_ioda2_table(np, "ibm,opal-peltv-table",
+				&phb->ioda.tbl_peltv, &phb->ioda.peltv_len);
+		pnv_pci_get_ioda2_table(np, "ibm,opal-pest-table",
+				&phb->ioda.tbl_pest, &phb->ioda.pest_len);
+		pnv_pci_get_ioda2_table(np, "ibm,opal-ivt-table",
+				&phb->ioda.tbl_ivt, &phb->ioda.ivt_len);
+		pnv_pci_get_ioda2_table(np, "ibm,opal-rba-table",
+				&phb->ioda.tbl_rba, &phb->ioda.rba_len);
+		/* Get IVE stride */
+		prop32 = of_get_property(np, "ibm,opal-ive-stride", NULL);
+		if (prop32)
+			phb->ioda.ive_stride = be32_to_cpup(prop32);
+	}
+
 	/* Reset IODA tables to a clean state */
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
 	if (rc)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f6314d6..c048c29 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -100,6 +100,19 @@ struct pnv_phb {
 			unsigned int		io_segsize;
 			unsigned int		io_pci_base;
 
+			/* Variable tables for IODA2 */
+			void			*tbl_rtt;
+			void			*tbl_peltv;
+			void			*tbl_pest;
+			void			*tbl_ivt;
+			void			*tbl_rba;
+			unsigned int		ive_stride;
+			unsigned int		rtt_len;
+			unsigned int		peltv_len;
+			unsigned int		pest_len;
+			unsigned int		ivt_len;
+			unsigned int		rba_len;
+
 			/* PE allocation bitmap */
 			unsigned long		*pe_alloc;
 
-- 
1.7.5.4
