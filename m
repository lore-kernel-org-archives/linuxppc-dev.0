Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id DB8D6DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 00:12:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix pci domain detection
Date: Wed, 26 Sep 2007 16:02:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261602.06214.arnd@arndb.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The /proc/bus/pci/* files list PCI domain numbers only for
devices that claim to be on a multi-domain system. The check
for this is broken on powerpc, because the buid value is
truncated to 32 bits.

There is at least one machine (IBM QS21) that only uses
the high-order bits of the buid, so the return value
of pci_proc_domain() ends up being always zero, which
makes /proc/bus/pci useless.

Change the logic to always return '1' for a nonzero
buid value.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 291ffbc..9f63bdc 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -588,7 +588,7 @@ int pci_proc_domain(struct pci_bus *bus)
 		return 0;
 	else {
 		struct pci_controller *hose = pci_bus_to_host(bus);
-		return hose->buid;
+		return hose->buid != 0;
 	}
 }
 
