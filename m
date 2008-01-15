Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 198A7DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:47:20 +1100 (EST)
Date: Mon, 14 Jan 2008 20:44:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Ensure we only handle PowerMac PCI bus fixup for
	memory resources
Message-ID: <Pine.LNX.4.64.0801142044280.32246@blarg.am.freescale.net>
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

The fixup code that handles the case for PowerMac's that leave bridge
windows open over an inaccessible region should only be applied to
memory resources (IORESOURCE_MEM).  If not we can get it trying to fixup
IORESOURCE_IO on some systems since the other conditions that are used to
detect the case can easily match for IORESOURCE_IO.

---

in my git tree.

 arch/powerpc/kernel/pci-common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d394d41..7d0afd4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -806,7 +806,8 @@ static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
 			 * equal to the pci_mem_offset of the host bridge and
 			 * their size is smaller than 1M.
 			 */
-			if (res->start == hose->pci_mem_offset &&
+			if (res->flags & IORESOURCE_MEM &&
+			    res->start == hose->pci_mem_offset &&
 			    res->end < 0x100000) {
 				printk(KERN_INFO
 				       "PCI: Closing bogus Apple Firmware"
-- 
1.5.3.7
