Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D16CA1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:49:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6B8792CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMnRQ738011068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMnRX3008707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 2/8] powerpc/pci: Don't scan empty slot
Date: Tue, 25 Nov 2014 09:49:19 +1100
Message-Id: <1416869365-7671-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In hotplug case, function pcibios_add_pci_devices() is called to
rescan the specified PCI bus, which possibly doesn't have any child
devices. Access to the PCI bus's child device node will cause kernel
crash without exception. The patch adds two more conditions to avoid
the kernel crash.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 6e2b4e3..ea5513b 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
  * is how this routine differs from other, similar pcibios
  * routines.)
  */
-void pcibios_add_pci_devices(struct pci_bus * bus)
+void pcibios_add_pci_devices(struct pci_bus *bus)
 {
 	int slotno, mode, pass, max;
 	struct pci_dev *dev;
@@ -120,7 +120,8 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
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
1.8.3.2
