Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxghG6h92zDrgg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 02:33:34 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBDFTK9C038915
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:32 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eu65caka2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:31 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 10:33:31 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 5/7] powerpc/kernel: Add EEH notify resume sysfs
Date: Wed, 13 Dec 2017 09:32:40 -0600
In-Reply-To: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171213153242.98015-6-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a method for notify resume to be
called from sysfs. In this patch one can
now call notify resume from sysfs when
is supported by platform.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 797549289798..344e7607f2e0 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -90,6 +90,38 @@ static ssize_t eeh_pe_state_store(struct device *dev,
 
 static DEVICE_ATTR_RW(eeh_pe_state);
 
+#ifdef CONFIG_PCI_IOV
+static ssize_t eeh_notify_resume_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	pdn = pci_get_pdn(pdev);
+	return sprintf(buf, "%d\n", pdn->last_allow_rc);
+}
+
+static ssize_t eeh_notify_resume_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	if (eeh_ops->notify_resume(pci_get_pdn(pdev)))
+		return -EIO;
+	return count;
+}
+static DEVICE_ATTR_RW(eeh_notify_resume);
+#endif
+
 void eeh_sysfs_add_device(struct pci_dev *pdev)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
@@ -104,7 +136,13 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_state);
-
+#ifdef CONFIG_PCI_IOV
+	if (of_get_property(pci_device_to_OF_node
+			    ((pdev->is_physfn ? pdev : pdev->physfn)),
+			    "ibm,is-open-sriov-pf", NULL))
+		rc += device_create_file(&pdev->dev,
+					 &dev_attr_eeh_notify_resume);
+#endif
 	if (rc)
 		pr_warn("EEH: Unable to create sysfs entries\n");
 	else if (edev)
@@ -128,6 +166,12 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_state);
+#ifdef CONFIG_PCI_IOV
+	if (of_get_property(pci_device_to_OF_node
+			    ((pdev->is_physfn ? pdev : pdev->physfn)),
+			    "ibm,is-open-sriov-pf", NULL))
+		device_remove_file(&pdev->dev, &dev_attr_eeh_notify_resume);
+#endif
 
 	if (edev)
 		edev->mode &= ~EEH_DEV_SYSFS;
-- 
2.14.3 (Apple Git-98)
