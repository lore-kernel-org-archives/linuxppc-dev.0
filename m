Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXlSv0L2rzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 01:11:10 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA9E9CSn111485
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 09:11:09 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e4n77u811-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 09:11:07 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Thu, 9 Nov 2017 07:00:53 -0700
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v5 3/3] PCI/IOV: Add pci_vf_drivers_autoprobe() interface
Date: Thu,  9 Nov 2017 08:00:35 -0600
In-Reply-To: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171109140035.64975-4-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a pci_vf_drivers_autoprobe() interface.  Setting autoprobe to false
on the PF prevents drivers from binding to VFs when they are enabled.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/platforms/pseries/pci.c |  2 ++
 drivers/pci/iov.c                    | 11 +++++++++++
 include/linux/pci.h                  |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 14a90cf471cc..48d3af026f90 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -63,6 +63,7 @@ int pseries_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	/* Allocate PCI data */
 	add_dev_pci_data(pdev);
+	pci_vf_drivers_autoprobe(pdev, false);
 	return 0;
 }
 
@@ -70,6 +71,7 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
 {
 	/* Release PCI data */
 	remove_dev_pci_data(pdev);
+	pci_vf_drivers_autoprobe(pdev, true);
 	return 0;
 }
 #endif
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac41c8be9200..1440e48094f4 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -634,6 +634,17 @@ void pci_restore_iov_state(struct pci_dev *dev)
 }
 
 /**
+ * pci_vf_drivers_autoprobe - set PF property drivers_autoprobe for VFs
+ * @dev: the PCI device
+ * @auto_probe: set VF drivers auto probe flag
+ */
+void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
+{
+	if (dev->is_physfn)
+		dev->sriov->drivers_autoprobe = auto_probe;
+}
+
+/**
  * pci_iov_bus_range - find bus range used by Virtual Function
  * @bus: the PCI bus
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f4f8ee5a7362..17a08554baa2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1965,6 +1965,7 @@ int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
+void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -1992,6 +1993,7 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 { return 0; }
+static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
2.13.6 (Apple Git-96)
