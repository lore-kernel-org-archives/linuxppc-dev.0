Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99971DE692
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 03:39:32 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m77HaVj4020073
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 10:36:31 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5121 pci 3/3] powerpc: pci: 5121: Hide pci bridge.
Date: Thu,  7 Aug 2008 11:36:27 -0600
Message-Id: <1218130587-31176-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1218130587-31176-2-git-send-email-jrigby@freescale.com>
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<1218130587-31176-2-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
while other freescale host bridges have class set to
PCI_CLASS_PROCESSOR_POWERPC.

This patch makes fixup_hide_host_resource_fsl match
PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/kernel/pci_32.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 88db4ff..162c3a8 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -54,11 +54,12 @@ LIST_HEAD(hose_list);
 static int pci_bus_count;
 
 static void
-fixup_hide_host_resource_fsl(struct pci_dev* dev)
+fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
 	int i, class = dev->class >> 8;
 
-	if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
+	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
+	     class == PCI_CLASS_BRIDGE_OTHER) &&
 		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
 		(dev->bus->parent == NULL)) {
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-- 
