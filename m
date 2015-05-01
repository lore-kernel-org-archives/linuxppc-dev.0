Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 544E41A0FE3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 16:04:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AA48F2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4164Pha38862850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4163xci005989
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:00 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 11/21] powerpc/pci: Don't scan empty slot
Date: Fri,  1 May 2015 16:02:58 +1000
Message-Id: <1430460188-31343-12-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

In hotplug case, function pcibios_add_pci_devices() is called to
rescan the specified PCI bus, which might not have any child devices.
Access to the PCI bus's child device node will cause kernel crash
without exception. The patch adds condition of skipping scanning
PCI bus without child devices, in order to avoid kernel crash.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 0040343..651a866a 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -92,7 +92,8 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
 		of_rescan_bus(dn, bus);
-	} else if (mode == PCI_PROBE_NORMAL) {
+	} else if (mode == PCI_PROBE_NORMAL &&
+		   dn->child && PCI_DN(dn->child)) {
 		/*
 		 * Use legacy probe. In the partial hotplug case, we
 		 * probably have grandchildren devices unplugged. So
-- 
2.1.0
