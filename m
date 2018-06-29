Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H7hh1nxwzF1dH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 17:34:55 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, alistair@popple.id.au, aik@ozlabs.ru,
 tpearson@raptorengineering.com, Russell Currey <ruscur@russell.cc>
Subject: [PATCH 1/3] powerpc/powernv/pci: Track largest available TCE order
 per PHB
Date: Fri, 29 Jun 2018 17:34:35 +1000
Message-Id: <20180629073437.4060-2-ruscur@russell.cc>
In-Reply-To: <20180629073437.4060-1-ruscur@russell.cc>
References: <20180629073437.4060-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Knowing the largest possible TCE size of a PHB is useful, so get it out
of the device tree.  This relies on the property being added in OPAL.

It is assumed that any PHB4 or later machine would be running firmware
that implemented this property, and otherwise assumed to be PHB3, which
has a maximum TCE order of 28 bits or 256MB TCEs.

This is used later in the series.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 16 ++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5bd0eb6681bc..17c590087279 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3873,11 +3873,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	struct resource r;
 	const __be64 *prop64;
 	const __be32 *prop32;
+	struct property *prop;
 	int len;
 	unsigned int segno;
 	u64 phb_id;
 	void *aux;
 	long rc;
+	u32 val;
 
 	if (!of_device_is_available(np))
 		return;
@@ -4016,6 +4018,20 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	}
 	phb->ioda.pe_array = aux + pemap_off;
 
+	phb->ioda.max_tce_order = 0;
+	/* Get TCE order from the DT.  If it's not present, assume P8 */
+	if (!of_get_property(np, "ibm,supported-tce-sizes", NULL)) {
+		phb->ioda.max_tce_order = 28; /* assume P8 256mb TCEs */
+	} else {
+		of_property_for_each_u32(np, "ibm,supported-tce-sizes", prop,
+					 prop32, val) {
+			if (val > phb->ioda.max_tce_order)
+				phb->ioda.max_tce_order = val;
+		}
+		pr_debug("PHB%llx Found max TCE order of %d bits\n",
+			 phb->opal_id, phb->ioda.max_tce_order);
+	}
+
 	/*
 	 * Choose PE number for root bus, which shouldn't have
 	 * M64 resources consumed by its child devices. To pick
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index eada4b6068cb..c9952def5e93 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -173,6 +173,9 @@ struct pnv_phb {
 		struct list_head	pe_list;
 		struct mutex            pe_list_mutex;
 
+		/* Largest supported TCE order bits */
+		uint8_t			max_tce_order;
+
 		/* Reverse map of PEs, indexed by {bus, devfn} */
 		unsigned int		pe_rmap[0x10000];
 	} ioda;
-- 
2.17.1
