Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39CC51A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:59:03 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 26 Jun 2014 12:28:58 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3C658394005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 12:28:54 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5Q7062T42664130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 12:30:06 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q6wpRj022895
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 12:28:51 +0530
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: sysfs entries lost
Date: Thu, 26 Jun 2014 02:58:47 -0400
Message-Id: <1403765927-8638-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sysfs entries are lost because of commit 2213fb1 ("powerpc/eeh:
Skip eeh sysfs when eeh is disabled"). That commit added condition
to create sysfs entries with EEH_ENABLED, which isn't populated
when trying to create sysfs entries on PowerNV platform during system
boot time. The patch fixes the issue by:

   * Reoder EEH initialization functions so that they're same on
     PowerNV/pSeries.
   * Cache PE's primary bus by PowerNV platform instead of EEH core
     to avoid kernel crash caused by the function reorder. Another
     benefit with this is to avoid one eeh_probe_mode_dev() in EEH
     core.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c                 | 11 -----------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 17 ++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c    |  2 +-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fbd01eb..1dce071a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -351,17 +351,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	pe->config_addr	= edev->config_addr;
 
 	/*
-	 * While doing PE reset, we probably hot-reset the
-	 * upstream bridge. However, the PCI devices including
-	 * the associated EEH devices might be removed when EEH
-	 * core is doing recovery. So that won't safe to retrieve
-	 * the bridge through downstream EEH device. We have to
-	 * trace the parent PCI bus, then the upstream bridge.
-	 */
-	if (eeh_probe_mode_dev())
-		pe->bus = eeh_dev_to_pci_dev(edev)->bus;
-
-	/*
 	 * Put the new EEH PE into hierarchy tree. If the parent
 	 * can't be found, the newly created PE will be attached
 	 * to PHB directly. Otherwise, we have to associate the
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 56a206f..48eb223 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -107,6 +107,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	struct pnv_phb *phb = hose->private_data;
 	struct device_node *dn = pci_device_to_OF_node(dev);
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	int ret;
 
 	/*
 	 * When probing the root bridge, which doesn't have any
@@ -143,7 +144,21 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	edev->pe_config_addr	= phb->bdfn_to_pe(phb, dev->bus, dev->devfn & 0xff);
 
 	/* Create PE */
-	eeh_add_to_parent_pe(edev);
+	ret = eeh_add_to_parent_pe(edev);
+	if (ret) {
+		pr_warn("%s: Can't add PCI dev %s to parent PE (%d)\n",
+			__func__, pci_name(dev), ret);
+		return ret;
+	}
+
+	/*
+	 * Cache the PE primary bus, which can't be fetched when
+	 * full hotplug is in progress. In that case, all child
+	 * PCI devices of the PE are expected to be removed prior
+	 * to PE reset.
+	 */
+	if (!edev->pe->bus)
+		edev->pe->bus = dev->bus;
 
 	/*
 	 * Enable EEH explicitly so that we will do EEH check
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index de19ede..81f2d3a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1142,8 +1142,8 @@ static void pnv_pci_ioda_fixup(void)
 
 #ifdef CONFIG_EEH
 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
-	eeh_addr_cache_build();
 	eeh_init();
+	eeh_addr_cache_build();
 #endif
 }
 
-- 
1.8.1.4
