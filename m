Return-Path: <brking@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D2A02C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 08:58:22 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 4 Apr 2013 15:58:20 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 250553E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 15:58:05 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r34LwFpo069544
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 15:58:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r34LwEee010547
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 15:58:14 -0600
Message-Id: <201304042158.r34LwDHx010466@d03av02.boulder.ibm.com>
Subject: [PATCH 1/3] pci: Export pci_dev_type
To: linux-pci@vger.kernel.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 04 Apr 2013 16:58:13 -0500
Cc: klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 lucaskt@linux.vnet.ibm.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Export pci_dev_type so that arch specific PCI probing code can
initialize a new PCI device struct.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/pci/pci.h   |    1 -
 include/linux/pci.h |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pci/pci.h~pci_export_pci_dev_type drivers/pci/pci.h
--- linux/drivers/pci/pci.h~pci_export_pci_dev_type	2013-04-02 17:01:25.000000000 -0500
+++ linux-bjking1/drivers/pci/pci.h	2013-04-02 17:02:31.000000000 -0500
@@ -153,7 +153,6 @@ static inline int pci_no_d1d2(struct pci
 }
 extern struct device_attribute pci_dev_attrs[];
 extern struct device_attribute pcibus_dev_attrs[];
-extern struct device_type pci_dev_type;
 extern struct bus_attribute pci_bus_attrs[];
 
 
diff -puN include/linux/pci.h~pci_export_pci_dev_type include/linux/pci.h
--- linux/include/linux/pci.h~pci_export_pci_dev_type	2013-04-02 17:01:59.000000000 -0500
+++ linux-bjking1/include/linux/pci.h	2013-04-02 17:02:29.000000000 -0500
@@ -670,6 +670,7 @@ enum pcie_bus_config_types {
 extern enum pcie_bus_config_types pcie_bus_config;
 
 extern struct bus_type pci_bus_type;
+extern struct device_type pci_dev_type;
 
 /* Do NOT directly access these two variables, unless you are arch specific pci
  * code, or pci core code. */
_
