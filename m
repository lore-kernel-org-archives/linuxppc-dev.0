Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7A57DDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:47:46 +1100 (EST)
Date: Mon, 14 Jan 2008 20:45:27 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fixup transparent P2P resources
Message-ID: <Pine.LNX.4.64.0801142045010.32246@blarg.am.freescale.net>
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

For transparent P2P bridges the first 3 resources may get set from based on
BAR registers and need to get fixed up. Where as the remainder come from the
parent bus and have already been fixed up.

---

in my git tree.

 arch/powerpc/kernel/pci-common.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7d0afd4..980fe32 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -792,9 +792,10 @@ static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
 		for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
 			if ((res = bus->resource[i]) == NULL)
 				continue;
-			if (!res->flags || bus->self->transparent)
+			if (!res->flags)
+				continue;
+			if (i >= 3 && bus->self->transparent)
 				continue;
-
 			/* On PowerMac, Apple leaves bridge windows open over
 			 * an inaccessible region of memory space (0...fffff)
 			 * which is somewhat bogus, but that's what they think
-- 
1.5.3.7
