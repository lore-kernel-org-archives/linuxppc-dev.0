Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF1D51A0C47
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:20 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:39:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 037632CE8058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R6d91t45547546
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:17 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R6ch8M009479
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:38:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 09/21] powerpc/eeh: Delay probing EEH device during hotplug
Date: Mon, 27 Apr 2015 16:37:41 +1000
Message-Id: <1430116673-22500-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1c509148b ("powerpc/eeh: Do probe on pci_dn") probes EEH
devices in early stage, which is reasonable to pSeries platform.
However, it's wrong for PowerNV platform because the PE# isn't
determined until the resources (IO and MMIO) are assigned to
PE. So we have to delay probing EEH devices for PowerNV platform
until that point.

Fixes: 1c509148b ("powerpc/eeh: Do probe on pci_dn")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c63d1eb..b5847dc 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1056,6 +1056,9 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	if (!edev || !eeh_enabled())
 		return;
 
+	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
+		return;
+
 	/* USB Bus children of PCI devices will not have BUID's */
 	phb = edev->phb;
 	if (NULL == phb ||
@@ -1105,6 +1108,10 @@ void eeh_add_device_late(struct pci_dev *dev)
 
 	pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	edev = pdn_to_eeh_dev(pdn);
+	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
+		eeh_ops->probe(pdn, NULL);
+
+	/* Check if PCI device and EEH device has been bound */
 	if (edev->pdev == dev) {
 		pr_debug("EEH: Already referenced !\n");
 		return;
-- 
2.1.0
