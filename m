Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D75481A0771
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7DAFB2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:12 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2Kro966650348
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:20:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dB0K029395
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/21] powerpc/eeh: Add eeh_pe_state sysfs entry
Date: Tue, 30 Sep 2014 12:38:51 +1000
Message-Id: <1412044750-24460-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds sysfs entry "eeh_pe_state". Reading on it returns
the PE's state while writing to it clears the frozen state. It's
used to check or clear the PE frozen state from userland for
debugging purpose.

The patch also replaces printk(KERN_WARNING ...) with pr_warn() in
eeh_sysfs.c

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Not output PE number and return error from the sysfs entry
    if necessary
---
 arch/powerpc/kernel/eeh_sysfs.c | 60 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index e2595ba..eb15be4 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -54,6 +54,62 @@ EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
 EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
 EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
 
+static ssize_t eeh_pe_state_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	int state;
+
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	state = eeh_ops->get_state(edev->pe, NULL);
+	return sprintf(buf, "%08x %08x\n",
+		       state, edev->pe->state);
+}
+
+static ssize_t eeh_pe_state_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	int ret;
+
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	/* Nothing to do if it's not frozen */
+	if (!(edev->pe->state & EEH_PE_ISOLATED))
+		return count;
+
+	/* Enable MMIO */
+	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_MMIO);
+	if (ret) {
+		pr_warn("%s: Failure %d enabling MMIO for PHB#%d-PE#%d\n",
+			__func__, ret, edev->pe->phb->global_number,
+			edev->pe->addr);
+		return -EIO;
+	}
+
+	/* Enable DMA */
+	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_DMA);
+	if (ret) {
+		pr_warn("%s: Failure %d enabling DMA for PHB#%d-PE#%d\n",
+			__func__, ret, edev->pe->phb->global_number,
+			edev->pe->addr);
+		return -EIO;
+	}
+
+	/* Clear software state */
+	eeh_pe_state_clear(edev->pe, EEH_PE_ISOLATED);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(eeh_pe_state);
+
 void eeh_sysfs_add_device(struct pci_dev *pdev)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
@@ -68,9 +124,10 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_state);
 
 	if (rc)
-		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");
+		pr_warn("EEH: Unable to create sysfs entries\n");
 	else if (edev)
 		edev->mode |= EEH_DEV_SYSFS;
 }
@@ -92,6 +149,7 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_state);
 
 	if (edev)
 		edev->mode &= ~EEH_DEV_SYSFS;
-- 
1.8.3.2
