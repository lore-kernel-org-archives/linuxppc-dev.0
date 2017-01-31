Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCBw95GtHzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 14:44:41 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0V3dDQk006768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 22:44:39 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28a69dxfc2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 22:44:39 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 13:44:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D2AE62CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 14:44:34 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0V3iQAA35455074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 14:44:34 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0V3i2Dt013979
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 14:44:02 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
Date: Tue, 31 Jan 2017 14:43:36 +1100
Message-Id: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following error message was observed. It's complaining M32
memory window is missed on virtual PHB, which is a bit confusing.
The problem is the memory windows are never updated from its
device-tree node.

   PCI: Memory resource 0 not set for host bridge \
   /pciex@3fffe40000000/pci@0/device@0

This avoids the unnecessary error message by updating the PHB's
memory windows with pci_process_bridge_OF_ranges(). The function
is exported as well.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 1 +
 drivers/misc/cxl/vphb.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 74bec54..b5ffd8a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -824,6 +824,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(pci_process_bridge_OF_ranges);
 
 /* Decide whether to display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 3519ace..8382761 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -215,6 +215,15 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	if (!phb)
 		return -ENODEV;
 
+	/* Parse IO and memory ranges */
+	if (dev_is_pci(parent)) {
+		struct pci_dev *pdev;
+
+		pdev = to_pci_dev(parent);
+		vphb_dn = pnv_pci_get_phb_node(pdev);
+		pci_process_bridge_OF_ranges(phb, vphb_dn, false);
+	}
+
 	/* Setup parent in sysfs */
 	phb->parent = parent;
 
-- 
2.7.4
