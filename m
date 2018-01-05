Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCrFp3nlVzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 03:47:54 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w05Gkf7h021189
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jan 2018 11:46:48 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fabw9ub5q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jan 2018 11:46:48 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Fri, 5 Jan 2018 11:46:47 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v4 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
Date: Fri,  5 Jan 2018 10:45:48 -0600
In-Reply-To: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
References: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20180105164552.36371-4-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To correctly use EEH code one has to make
sure that the EEH_PE_VF is set for dynamic created
VFs. Therefore this patch allocates an eeh_pe of
eeh type EEH_PE_VF and associates PE with parent.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h        |  5 ++++-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9f66ddebb799..16d70740a76f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -211,7 +211,10 @@ struct pci_dn {
 	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
 #define IODA_INVALID_M64        (-1)
-	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
+	union {
+		int     (*m64_map)[PCI_SRIOV_NUM_BARS]; /*Only used in powernv */
+		int     last_allow_rc;	/* Only used in pSeries */
+	};
 #endif /* CONFIG_PCI_IOV */
 	int	mps;			/* Maximum Payload Size */
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a671ef4f57f5..ca6bbfd83701 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -55,9 +55,12 @@ static int ibm_get_config_addr_info;
 static int ibm_get_config_addr_info2;
 static int ibm_configure_pe;
 
+#ifdef CONFIG_PCI_IOV
 void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pci_dn *physfn_pdn;
+	struct eeh_dev *edev;
 
 	if (!pdev->is_virtfn)
 		return;
@@ -65,6 +68,14 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 	pdn->device_id  =  pdev->device;
 	pdn->vendor_id  =  pdev->vendor;
 	pdn->class_code =  pdev->class;
+	/* Last allow unfreeze return code used for retrieval
+	 * by user space in eeh-sysfs to show the last command
+	 * completion from platform
+	 */
+	pdn->last_allow_rc =  0;
+	physfn_pdn      =  pci_get_pdn(pdev->physfn);
+	pdn->pe_number  =  physfn_pdn->pe_num_map[pdn->vf_index];
+	edev = pdn_to_eeh_dev(pdn);
 
 	/*
 	 * The following operations will fail if VF's sysfs files
@@ -72,9 +83,13 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 	 */
 	eeh_add_device_early(pdn);
 	eeh_add_device_late(pdev);
+	edev->pe_config_addr =  (pdn->busno << 16) | (pdn->devfn << 8);
+	eeh_rmv_from_parent_pe(edev); /* Remove as it is adding to bus pe */
+	eeh_add_to_parent_pe(edev);   /* Add as VF PE type */
 	eeh_sysfs_add_device(pdev);
 
 }
+#endif
 
 /*
  * Buffer for reporting slot-error-detail rtas calls. Its here
@@ -141,8 +156,10 @@ static int pseries_eeh_init(void)
 	/* Set EEH probe mode */
 	eeh_add_flag(EEH_PROBE_MODE_DEVTREE | EEH_ENABLE_IO_FOR_LOG);
 
+#ifdef CONFIG_PCI_IOV
 	/* Set EEH machine dependent code */
 	ppc_md.pcibios_bus_add_device = pseries_pcibios_bus_add_device;
+#endif
 
 	return 0;
 }
-- 
2.14.3 (Apple Git-98)
