Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87FE7DDF8B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 03:41:10 +1100 (EST)
Date: Fri, 11 Jan 2008 10:38:53 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RFC: Only deal with apple fix if res is memory
Message-ID: <Pine.LNX.4.64.0801111038380.17281@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Will this impact the apple fix?  I'm getting some _IO cases hitting this.

- k

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d394d41..42a9dab 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -807,6 +807,7 @@ static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
 			 * their size is smaller than 1M.
 			 */
 			if (res->start == hose->pci_mem_offset &&
+			    res->flags & IORESOURCE_MEM &&
 			    res->end < 0x100000) {
 				printk(KERN_INFO
 				       "PCI: Closing bogus Apple Firmware"
