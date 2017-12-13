Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxghB3bwczDrgg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 02:33:30 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBDFTJic091122
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:28 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eu37rur66-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:28 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 10:33:27 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
Date: Wed, 13 Dec 2017 09:32:38 -0600
In-Reply-To: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171213153242.98015-4-bryantly@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/pci-bridge.h        | 5 ++++-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9f66ddebb799..c30c7cba4c30 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -211,7 +211,10 @@ struct pci_dn {
 	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
 #define IODA_INVALID_M64        (-1)
-	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
+	union {
+		int     (*m64_map)[PCI_SRIOV_NUM_BARS];
+		int     last_allow_rc;
+	};
 #endif /* CONFIG_PCI_IOV */
 	int	mps;			/* Maximum Payload Size */
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1a9a6fa91151..5bdd1678a9ff 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -58,6 +58,8 @@ static int ibm_configure_pe;
 void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pci_dn *physfn_pdn;
+	struct eeh_dev *edev;
 
 	if (!pdev->is_virtfn)
 		return;
@@ -65,6 +67,10 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 	pdn->device_id  =  pdev->device;
 	pdn->vendor_id  =  pdev->vendor;
 	pdn->class_code =  pdev->class;
+	pdn->last_allow_rc =  0;
+	physfn_pdn      =  pci_get_pdn(pdev->physfn);
+	pdn->pe_number  =  physfn_pdn->pe_num_map[pdn->vf_index];
+	edev = pdn_to_eeh_dev(pdn);
 
 	/*
 	 * The following operations will fail if VF's sysfs files
@@ -72,8 +78,9 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 	 */
 	eeh_add_device_early(pdn);
 	eeh_add_device_late(pdev);
+	edev->pe_config_addr =  (pdn->busno << 16) | (pdn->devfn << 8);
+	eeh_add_to_parent_pe(edev);
 	eeh_sysfs_add_device(pdev);
-
 }
 
 /*
-- 
2.14.3 (Apple Git-98)
