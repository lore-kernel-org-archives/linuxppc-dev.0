Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A9BBDDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 13:47:59 +1000 (EST)
Date: Wed, 25 Jul 2007 22:47:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2][POWERPC] Don't try to allocate resources for a POWERPC PHB
Message-ID: <Pine.LNX.4.64.0707252245310.11707@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From e314b31e4650c789829bf870f83ee7ae4be46426 Mon Sep 17 00:00:00 2001
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 25 Jul 2007 00:44:11 -0500
Subject: [PATCH] [POWERPC] Don't try to allocate resources for a POWERPC PHB

The Freescale PCI PHBs actual report back values in the BAR registers
this causes issues in that we try to allocate resources for them
and will get error messages like the following on MPC8544 DS:

PCI: Failed to allocate mem resource #1:80000000@0 for 0000:00:00.0

To address this if we are class PCI_CLASS_PROCESSOR_POWERPC, a normal
header type, and the PHB we clear out all the resources.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Ben suggested to do this by a quirk and blow away the resources which I
like better.

- k

 arch/powerpc/kernel/pci_32.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 721a694..ec80779 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -60,6 +60,24 @@ LIST_HEAD(hose_list);
 static int pci_bus_count;

 static void
+fixup_broken_fsl(struct pci_dev* dev)
+{
+	int i, class = dev->class >> 8;
+
+	if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
+		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
+		(dev->bus->parent == NULL)) {
+		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			dev->resource[i].start = 0;
+			dev->resource[i].end = 0;
+			dev->resource[i].flags = 0;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_broken_fsl);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_broken_fsl);
+
+static void
 fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
-- 
1.5.2.2
