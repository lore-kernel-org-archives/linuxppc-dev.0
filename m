Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D64292C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 19:33:08 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 19 Apr 2013 03:33:05 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DA3FD1FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 03:27:50 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3J9WqDY150672
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 03:32:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3J9Wqfw022676
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 03:32:52 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/powernv: Configure IODA2 tables explicitly
Date: Fri, 19 Apr 2013 17:32:44 +0800
Message-Id: <1366363965-23281-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
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
trace the system memory address. The patch configures the addresses
of variable tables explicitly through OPAL API.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           |    5 +--
 arch/powerpc/platforms/powernv/pci-ioda.c |   32 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   25 ++++++++++++++++++++++
 3 files changed, 59 insertions(+), 3 deletions(-)

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
index 8993242..d8d5baa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -998,6 +998,38 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
+	/*
+	 * Initialize variable tables for IODA2. We might share the table
+	 * size between firmware and Linux someday. For now, we have fixed
+	 * values for them
+	 */
+	if (ioda_type == PNV_PHB_IODA2) {
+		phb->ioda.tbl_rtt = alloc_bootmem_align(PNV_PHB3_RTT_TBL_SIZE,
+						PNV_PHB3_RTT_TBL_SIZE);
+		phb->ioda.tbl_peltv = alloc_bootmem_align(PNV_PHB3_PELTV_TBL_SIZE,
+						PNV_PHB3_PELTV_TBL_SIZE);
+		phb->ioda.tbl_pest = alloc_bootmem_align(PNV_PHB3_PEST_TBL_SIZE,
+						PNV_PHB3_PEST_TBL_SIZE);
+		phb->ioda.tbl_ivt = alloc_bootmem_align(PNV_PHB3_IVT_TBL_SIZE,
+						PNV_PHB3_IVT_TBL_SIZE);
+		phb->ioda.tbl_rba = alloc_bootmem_align(PNV_PHB3_RBA_TBL_SIZE,
+						PNV_PHB3_RBA_TBL_SIZE);
+		if (!phb->ioda.tbl_rtt || !phb->ioda.tbl_peltv ||
+		    !phb->ioda.tbl_pest || !phb->ioda.tbl_ivt ||
+		    !phb->ioda.tbl_rba)
+			pr_warning("  No memory for IODA2 tables\n");
+		else {
+			rc = opal_pci_set_phb_table_memory(phb_id,
+					__pa(phb->ioda.tbl_rtt),
+					__pa(phb->ioda.tbl_peltv),
+					__pa(phb->ioda.tbl_pest),
+					__pa(phb->ioda.tbl_ivt),
+					__pa(phb->ioda.tbl_rba));
+			if (rc != OPAL_SUCCESS)
+				pr_warning("  Failed to set IODA2 tables\n");
+		}
+	}
+
 	/* Reset IODA tables to a clean state */
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
 	if (rc)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 4ce91f5..fcd5135 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -64,6 +64,24 @@ struct pnv_ioda_pe {
 	struct list_head	list;
 };
 
+/*
+ * The sizes of variable PHB3 tables. The IVT table size is variable
+ * and depends on the IVE stride (16-bytes or 128-bytes)
+ */
+#define PNV_PHB3_IVT_TBL_IVE_16B
+
+#define PNV_PHB3_RTT_TBL_SIZE		0x20000
+#define PNV_PHB3_PELTV_TBL_SIZE		0x2000
+#define PNV_PHB3_PEST_TBL_SIZE		0x1000
+#ifdef PNV_PHB3_IVT_TBL_IVE_16B
+#define PNV_PHB3_IVT_TBL_SIZE		0x8000
+#define PNV_PHB3_IVT_TBL_STRIDE		2	/* double-words */
+#else
+#define PNV_PHB3_IVT_TBL_SIZE		0x40000
+#define PNV_PHB3_IVT_TBL_STRIDE		16	/* double-words */
+#endif
+#define PNV_PHB3_RBA_TBL_SIZE		0x1000
+
 struct pnv_phb {
 	struct pci_controller	*hose;
 	enum pnv_phb_type	type;
@@ -102,6 +120,13 @@ struct pnv_phb {
 			unsigned int		io_segsize;
 			unsigned int		io_pci_base;
 
+			/* Variable tables for IODA2 */
+			void			*tbl_rtt;
+			void			*tbl_peltv;
+			void			*tbl_pest;
+			void			*tbl_ivt;
+			void			*tbl_rba;
+
 			/* PE allocation bitmap */
 			unsigned long		*pe_alloc;
 
-- 
1.7.5.4
