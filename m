Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37FFC1A0E06
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 05:41:12 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 19 Feb 2015 11:41:09 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BA0CC3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 11:41:08 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1JIdanK21954578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 11:39:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1JIf5KX020632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 11:41:05 -0700
Date: Thu, 19 Feb 2015 10:41:03 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] pseries/iommu: remove iommu device references via bus notifier
Message-ID: <20150219184103.GB13745@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
refcnt on the kobject backing the IOMMU group for a PCI device is
elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
set_iommu_table_base_and_group). When we go to dlpar a multi-function
PCI device out:

	iommu_reconfig_notifier ->
		iommu_free_table ->
			iommu_group_put
			BUG_ON(tbl->it_group)

We trip this BUG_ON, because there are still references on the table, so
it is not freed. Fix this by also adding a bus notifier identical to
PowerNV for pSeries. Tested a remove -> add -> remove cycle without
issue where it always hit the BUG_ON without the changes.

Fixes: d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier")
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: stable@kernel.org (3.13+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 1d3d52dc3ff3..f77fb02f4710 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1340,3 +1340,31 @@ static int __init disable_multitce(char *str)
 }
 
 __setup("multitce=", disable_multitce);
+
+static int tce_iommu_bus_notifier(struct notifier_block *nb,
+                unsigned long action, void *data)
+{
+        struct device *dev = data;
+
+        switch (action) {
+        case BUS_NOTIFY_ADD_DEVICE:
+                return iommu_add_device(dev);
+        case BUS_NOTIFY_DEL_DEVICE:
+                if (dev->iommu_group)
+                        iommu_del_device(dev);
+                return 0;
+        default:
+                return 0;
+        }
+}
+
+static struct notifier_block tce_iommu_bus_nb = {
+        .notifier_call = tce_iommu_bus_notifier,
+};
+
+static int __init tce_iommu_bus_notifier_init(void)
+{
+        bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
+        return 0;
+}
+machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
