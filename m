Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXlF80KkwzDrRN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 01:00:59 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA9E0EoA067917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 09:00:57 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e4n77tj0q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 09:00:56 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Thu, 9 Nov 2017 07:00:51 -0700
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: [PATCH v5 2/3] pseries: Add PSeries SR-IOV Machine dependent calls
Date: Thu,  9 Nov 2017 08:00:34 -0600
In-Reply-To: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171109140035.64975-3-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add calls for PSeries platform to configure/deconfigure
SR-IOV.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 24 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci.c         | 29 ++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 6b812ad990e4..2295f117e2d3 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -55,6 +55,27 @@ static int ibm_get_config_addr_info;
 static int ibm_get_config_addr_info2;
 static int ibm_configure_pe;
 
+void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!pdev->is_virtfn)
+		return;
+
+	pdn->device_id  =  pdev->device;
+	pdn->vendor_id  =  pdev->vendor;
+	pdn->class_code =  pdev->class;
+
+	/*
+	 * The following operations will fail if VF's sysfs files
+	 * aren't created or its resources aren't finalized.
+	 */
+	eeh_add_device_early(pdn);
+	eeh_add_device_late(pdev);
+	eeh_sysfs_add_device(pdev);
+
+}
+
 /*
  * Buffer for reporting slot-error-detail rtas calls. Its here
  * in BSS, and not dynamically alloced, so that it ends up in
@@ -120,6 +141,9 @@ static int pseries_eeh_init(void)
 	/* Set EEH probe mode */
 	eeh_add_flag(EEH_PROBE_MODE_DEVTREE | EEH_ENABLE_IO_FOR_LOG);
 
+	/* Set EEH machine dependent code */
+	ppc_md.pcibios_bus_add_device = pseries_pcibios_bus_add_device;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 09eba5a9929a..14a90cf471cc 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -3,17 +3,17 @@
  * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
  *
  * pSeries specific routines for PCI.
- * 
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *    
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -54,10 +54,26 @@ void pcibios_name_device(struct pci_dev *dev)
 			}
 		}
 	}
-}   
+}
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_name_device);
 #endif
 
+#ifdef CONFIG_PCI_IOV
+int pseries_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
+{
+	/* Allocate PCI data */
+	add_dev_pci_data(pdev);
+	return 0;
+}
+
+int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
+{
+	/* Release PCI data */
+	remove_dev_pci_data(pdev);
+	return 0;
+}
+#endif
+
 static void __init pSeries_request_regions(void)
 {
 	if (!isa_io_base)
@@ -76,6 +92,11 @@ void __init pSeries_final_fixup(void)
 	pSeries_request_regions();
 
 	eeh_addr_cache_build();
+
+#ifdef CONFIG_PCI_IOV
+	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
+	ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
+#endif
 }
 
 /*
-- 
2.13.6 (Apple Git-96)
