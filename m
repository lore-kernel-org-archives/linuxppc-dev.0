Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC9E11A0DC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:14:51 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 87FC414029C
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:51 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:14:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E55D43578054
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H7Edgw18415628
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H7ED0N027368
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:14 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RESEND v2 4/7] powerpc/pci: Don't scan empty slot
Date: Tue, 17 Feb 2015 18:13:20 +1100
Message-Id: <1424157203-691-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 6e2b4e3..270a26d 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
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
