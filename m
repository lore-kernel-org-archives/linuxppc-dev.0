Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64D3CDDE20
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 16:04:03 +1000 (EST)
Date: Thu, 2 Oct 2008 01:03:54 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] powerpc: Fix boot hang regression on MPC8544DS
Message-ID: <Pine.LNX.4.64.0810020102470.4717@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 00c5372d37a78990c1530184a9c792ee60a30067 caused the MPC8544DS
board to hang at boot.  The MPC8544DS is unique in that it doesn't use
the PCI slots on the ULI (unlike the MPC8572DS or MPC8610HPCD).  So
the dummy read at the end of the address space causes us to hang.

We can detect the situation by comparing the bridge's BARs versus
the root complex.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This is a fix for 2.6.27 and is also available at:

master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.27

- k

 arch/powerpc/platforms/fsl_uli1575.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index ef74a07..8c61996 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -219,11 +219,21 @@ static void __devinit quirk_final_uli5249(struct pci_dev *dev)
 	int i;
 	u8 *dummy;
 	struct pci_bus *bus = dev->bus;
+	resource_size_t end = 0;
+
+	for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCES+3; i++) {
+		unsigned long flags = pci_resource_flags(dev, i);
+		if ((flags & (IORESOURCE_MEM|IORESOURCE_PREFETCH)) == IORESOURCE_MEM)
+			end = pci_resource_end(dev, i);
+	}

 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		if ((bus->resource[i]) &&
 			(bus->resource[i]->flags & IORESOURCE_MEM)) {
-			dummy = ioremap(bus->resource[i]->end - 3, 0x4);
+			if (bus->resource[i]->end == end)
+				dummy = ioremap(bus->resource[i]->start, 0x4);
+			else
+				dummy = ioremap(bus->resource[i]->end - 3, 0x4);
 			if (dummy) {
 				in_8(dummy);
 				iounmap(dummy);
-- 
1.5.5.1
