Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9DAFB703E
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:45 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 05:59:34 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S5wxkh2916480
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 16:58:59 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64RMf019179
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:27 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/21] Replace pci_dn with eeh_dev for EEH sysfs
Date: Tue, 28 Feb 2012 14:04:05 +0800
Message-Id: <1330409051-8941-16-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With original EEH implementation, all EEH related statistics have
been put into struct pci_dn. We've introduced struct eeh_dev to
replace struct pci_dn in EEH core components, including EEH sysfs
component.

The patch shows EEH statistics from struct eeh_dev instead of struct
pci_dn in EEH sysfs component. Besides, it also fixed the EEH device
retrieval from PCI device, which was introduced by the previous patch
in the series of patch.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_sysfs.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_sysfs.c b/arch/powerpc/platforms/pseries/eeh_sysfs.c
index 5e4eab1..243b351 100644
--- a/arch/powerpc/platforms/pseries/eeh_sysfs.c
+++ b/arch/powerpc/platforms/pseries/eeh_sysfs.c
@@ -41,24 +41,21 @@ static ssize_t eeh_show_##_name(struct device *dev,      \
 		struct device_attribute *attr, char *buf)          \
 {                                                        \
 	struct pci_dev *pdev = to_pci_dev(dev);               \
-	struct device_node *dn = pci_device_to_OF_node(pdev); \
-	struct pci_dn *pdn;                                   \
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);      \
 	                                                      \
-	if (!dn || PCI_DN(dn) == NULL)                        \
-		return 0;                                          \
+	if (!edev)                                            \
+		return 0;                                     \
 	                                                      \
-	pdn = PCI_DN(dn);                                     \
-	return sprintf(buf, _format "\n", pdn->_memb);        \
+	return sprintf(buf, _format "\n", edev->_memb);       \
 }                                                        \
 static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
 
-
-EEH_SHOW_ATTR(eeh_mode, eeh_mode, "0x%x");
-EEH_SHOW_ATTR(eeh_config_addr, eeh_config_addr, "0x%x");
-EEH_SHOW_ATTR(eeh_pe_config_addr, eeh_pe_config_addr, "0x%x");
-EEH_SHOW_ATTR(eeh_check_count, eeh_check_count, "%d");
-EEH_SHOW_ATTR(eeh_freeze_count, eeh_freeze_count, "%d");
-EEH_SHOW_ATTR(eeh_false_positives, eeh_false_positives, "%d");
+EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
+EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
+EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
+EEH_SHOW_ATTR(eeh_check_count,     check_count,     "%d"  );
+EEH_SHOW_ATTR(eeh_freeze_count,    freeze_count,    "%d"  );
+EEH_SHOW_ATTR(eeh_false_positives, false_positives, "%d"  );
 
 void eeh_sysfs_add_device(struct pci_dev *pdev)
 {
-- 
1.7.5.4
