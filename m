Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 633901A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:45:22 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 14:45:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8036F2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:45:18 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t414j9Ae44236952
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 14:45:18 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t414ii6Q003644
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 14:44:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/eeh: Delay probing EEH device during hotplug
Date: Fri,  1 May 2015 14:44:20 +1000
Message-Id: <1430455460-18452-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit ff57b454ddb9 ("powerpc/eeh: Do probe on pci_dn") probes EEH
devices in early stage, which is reasonable to pSeries platform.
However, it's wrong for PowerNV platform because the PE# isn't
determined until the resources (IO and MMIO) are assigned to PE in
hotplug case. So we have to delay probing EEH devices for PowerNV
platform until the PE# is assigned.

Fixes: ff57b454ddb9 ("powerpc/eeh: Do probe on pci_dn")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Corrected commit ID
---
 arch/powerpc/kernel/eeh.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index b798c86..04b5d94 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1061,6 +1061,9 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	if (!edev || !eeh_enabled())
 		return;
 
+	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
+		return;
+
 	/* USB Bus children of PCI devices will not have BUID's */
 	phb = edev->phb;
 	if (NULL == phb ||
@@ -1115,6 +1118,9 @@ void eeh_add_device_late(struct pci_dev *dev)
 		return;
 	}
 
+	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
+		eeh_ops->probe(pdn, NULL);
+
 	/*
 	 * The EEH cache might not be removed correctly because of
 	 * unbalanced kref to the device during unplug time, which
-- 
2.1.0
