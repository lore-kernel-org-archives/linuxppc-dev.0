Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Dec 2007 15:56:06 +1100
Subject: [PATCH 5/15] [POWERPC] pci32: Remove obsolete PowerMac bus number hack
In-Reply-To: <1197608163.200976.87755569596.qpush@grosgo>
Message-Id: <20071214045613.45FC8DE602@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32 bits PCI code carries an old hack that was only useful for G5
machines. Nowdays, the 32 bits kernel doesn't support any of those
machines anymore so the hack is basically never used, remove it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |   11 -----------
 1 file changed, 11 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:29.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:29.000000000 +1100
@@ -922,17 +922,6 @@ long sys_pciconfig_iobase(long which, un
 	struct pci_controller* hose;
 	long result = -EOPNOTSUPP;
 
-	/* Argh ! Please forgive me for that hack, but that's the
-	 * simplest way to get existing XFree to not lockup on some
-	 * G5 machines... So when something asks for bus 0 io base
-	 * (bus 0 is HT root), we return the AGP one instead.
-	 */
-#ifdef CONFIG_PPC_PMAC
-	if (machine_is(powermac) && machine_is_compatible("MacRISC4"))
-		if (bus == 0)
-			bus = 0xf0;
-#endif /* CONFIG_PPC_PMAC */
-
 	hose = pci_bus_to_hose(bus);
 	if (!hose)
 		return -ENODEV;
