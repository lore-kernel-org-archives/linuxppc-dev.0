Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxghL6HvPzDrcy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 02:33:38 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBDFVsBA140460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:37 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eu5k5mjw3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:35 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 10:33:34 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 7/7] pseries/setup: Add Initialization of VF Bars
Date: Wed, 13 Dec 2017 09:32:42 -0600
In-Reply-To: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171213153242.98015-8-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When enabling SR-IOV in pseries platform,
the VF bar properties for a PF are reported on
the device node in the device tree.

This patch adds the IOV Bar resources to Linux
structures from the device tree for later use
when configuring SR-IOV by PF driver.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci.h         |   2 +
 arch/powerpc/kernel/pci_of_scan.c      |   2 +-
 arch/powerpc/platforms/pseries/setup.c | 183 +++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 8dc32eacc97c..d82802ff5088 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -121,6 +121,8 @@ extern int remove_phb_dynamic(struct pci_controller *phb);
 extern struct pci_dev *of_create_pci_dev(struct device_node *node,
 					struct pci_bus *bus, int devfn);
 
+extern unsigned int pci_parse_of_flags(u32 addr0, int bridge);
+
 extern void of_scan_pci_bridge(struct pci_dev *dev);
 
 extern void of_scan_bus(struct device_node *node, struct pci_bus *bus);
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 0d790f8432d2..20ceec4a5f5e 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -38,7 +38,7 @@ static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
  * @addr0: value of 1st cell of a device tree PCI address.
  * @bridge: Set this flag if the address is from a bridge 'ranges' property
  */
-static unsigned int pci_parse_of_flags(u32 addr0, int bridge)
+unsigned int pci_parse_of_flags(u32 addr0, int bridge)
 {
 	unsigned int flags = 0;
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5f1beb8367ac..ce28882cbde8 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,6 +459,181 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
+#ifdef CONFIG_PCI_IOV
+enum rtas_iov_fw_value_map {
+	NUM_RES_PROPERTY  = 0, ///< Number of Resources
+	LOW_INT           = 1, ///< Lowest 32 bits of Address
+	START_OF_ENTRIES  = 2, ///< Always start of entry
+	APERTURE_PROPERTY = 2, ///< Start of entry+ to  Aperture Size
+	WDW_SIZE_PROPERTY = 4, ///< Start of entry+ to Window Size
+	NEXT_ENTRY        = 7  ///< Go to next entry on array
+};
+
+enum get_iov_fw_value_index {
+	BAR_ADDRS     = 1,    ///<  Get Bar Address
+	APERTURE_SIZE = 2,    ///<  Get Aperture Size
+	WDW_SIZE      = 3     ///<  Get Window Size
+};
+
+resource_size_t pseries_get_iov_fw_values(struct pci_dev *dev, int resno,
+					  enum get_iov_fw_value_index value)
+{
+	struct vf_bar_wdw {
+		__be64  addr;
+		__be64  aperture_size;
+		__be64  wdw_size;
+	};
+
+	struct vf_bar_wdw window_avail[PCI_SRIOV_NUM_BARS];
+	const int *indexes;
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	int i, r, num_res;
+	resource_size_t return_value;
+
+	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
+	if (!indexes)
+		return  0;
+
+	memset(window_avail,
+	       0, sizeof(struct vf_bar_wdw) * PCI_SRIOV_NUM_BARS);
+	return_value = 0;
+	/*
+	 * First element in the array is the number of Bars
+	 * returned.  Search through the list to find the matching
+	 * bar
+	 */
+	num_res = of_read_number(&indexes[NUM_RES_PROPERTY], 1);
+	for (i = START_OF_ENTRIES, r = 0; r < num_res && r < PCI_SRIOV_NUM_BARS;
+	     i += NEXT_ENTRY, r++) {
+		window_avail[r].addr = of_read_number(&indexes[i], 2);
+		window_avail[r].aperture_size =
+			of_read_number(&indexes[i + APERTURE_PROPERTY], 2);
+		window_avail[r].wdw_size =
+			of_read_number(&indexes[i + WDW_SIZE_PROPERTY], 2);
+	}
+
+	switch (value) {
+	case BAR_ADDRS:
+		return_value = window_avail[resno].addr;
+		break;
+	case APERTURE_SIZE:
+		return_value = window_avail[resno].aperture_size;
+		break;
+	case WDW_SIZE:
+		return_value = window_avail[resno].wdw_size;
+		break;
+	default:
+		break;
+	}
+	return  return_value;
+}
+
+void of_pci_parse_vf_bar_size(struct pci_dev *dev, const int *indexes)
+{
+	struct resource *res;
+	resource_size_t base, size;
+	int i, r, num_res;
+
+	num_res = of_read_number(&indexes[NUM_RES_PROPERTY], 1);
+	for (i = START_OF_ENTRIES, r = 0; r < num_res && r < PCI_SRIOV_NUM_BARS;
+	     i += NEXT_ENTRY, r++) {
+		res = &dev->resource[r + PCI_IOV_RESOURCES];
+		base = of_read_number(&indexes[i], 2);
+		size = of_read_number(&indexes[i + APERTURE_PROPERTY], 2);
+		res->flags = pci_parse_of_flags(of_read_number
+						(&indexes[i + LOW_INT], 1), 0);
+		res->flags |= (IORESOURCE_MEM_64 | IORESOURCE_PCI_FIXED);
+		res->name = pci_name(dev);
+		res->start = base;
+		res->end = base + size - 1;
+	}
+}
+
+void of_pci_parse_iov_addrs(struct pci_dev *dev, const int *indexes)
+{
+	struct resource *res, *root, *conflict;
+	resource_size_t base, size;
+	int i, r, num_res;
+
+	/*
+	 * First element in the array is the number of Bars
+	 * returned.  Search through the list to find the matching
+	 * bars assign them from firmware into resources structure.
+	 */
+	num_res = of_read_number(&indexes[NUM_RES_PROPERTY], 1);
+	for (i = START_OF_ENTRIES, r = 0; r < num_res && r < PCI_SRIOV_NUM_BARS;
+	     i += NEXT_ENTRY, r++) {
+		res = &dev->resource[r + PCI_IOV_RESOURCES];
+		base = of_read_number(&indexes[i], 2);
+		size = of_read_number(&indexes[i + WDW_SIZE_PROPERTY], 2);
+		res->name = pci_name(dev);
+		res->start = base;
+		res->end = base + size - 1;
+		root = pci_find_parent_resource(dev, res);
+
+		if (!root)
+			root = &iomem_resource;
+		dev_dbg(&dev->dev,
+			"Pseries IOV BAR %d: trying firmware assignment %pR\n",
+			 r + PCI_IOV_RESOURCES, res);
+		conflict = request_resource_conflict(root, res);
+		if (conflict) {
+			dev_info(&dev->dev,
+				 "BAR %d: %pR conflicts with %s %pR\n",
+				 r + PCI_IOV_RESOURCES, res,
+				 conflict->name, conflict);
+			res->flags |= IORESOURCE_UNSET;
+		}
+	}
+}
+
+static void pseries_pci_fixup_resources(struct pci_dev *pdev)
+{
+	const int *indexes;
+	struct device_node *dn = pci_device_to_OF_node(pdev);
+
+	/*Firmware must support open sriov otherwise dont configure*/
+	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
+	if (!indexes)
+		return;
+	/* Assign the addresses from device tree*/
+	of_pci_parse_vf_bar_size(pdev, indexes);
+}
+
+static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
+{
+	const int *indexes;
+	struct device_node *dn = pci_device_to_OF_node(pdev);
+
+	if (!pdev->is_physfn || pdev->is_added)
+		return;
+	/*Firmware must support open sriov otherwise dont configure*/
+	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
+	if (!indexes)
+		return;
+	/* Assign the addresses from device tree*/
+	of_pci_parse_iov_addrs(pdev, indexes);
+}
+
+static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
+							  int resno)
+{
+	const __be32 *reg;
+	struct device_node *dn = pci_device_to_OF_node(pdev);
+
+	/*Firmware must support open sriov otherwise report regular alignment*/
+	reg = of_get_property(dn, "ibm,is-open-sriov-pf", NULL);
+	if (!reg)
+		return pci_iov_resource_size(pdev, resno);
+
+	if (!pdev->is_physfn)
+		return 0;
+	return pseries_get_iov_fw_values(pdev,
+					 resno - PCI_IOV_RESOURCES,
+					 APERTURE_SIZE);
+}
+#endif
+
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
@@ -490,6 +665,14 @@ static void __init pSeries_setup_arch(void)
 		vpa_init(boot_cpuid);
 		ppc_md.power_save = pseries_lpar_idle;
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
+#ifdef CONFIG_PCI_IOV
+		ppc_md.pcibios_fixup_resources =
+			pseries_pci_fixup_resources;
+		ppc_md.pcibios_fixup_sriov =
+			pseries_pci_fixup_iov_resources;
+		ppc_md.pcibios_iov_resource_alignment =
+			pseries_pci_iov_resource_alignment;
+#endif
 	} else {
 		/* No special idle routine */
 		ppc_md.enable_pmcs = power4_enable_pmcs;
-- 
2.14.3 (Apple Git-98)
