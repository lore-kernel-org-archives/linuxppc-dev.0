Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 29 Feb 2008 14:58:03 +1100
Subject: [PATCH] [POWERPC] pci: fix bogus test for unassigned resources
Message-Id: <20080229035839.DADE0DDE03@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A bogus test for unassigned resources that came from our 32 bits
PCI code ended up being "merged" by my previous patch series,
breaking some 64 bits setups where devices have legal resources
ending at 0xffffffff.

This fixes it by completely changing the test. We now test for
res->start == 0, as the generic code expects, and we also only
do so on platforms that don't have the PPC_PCI_PROBE_ONLY flag
set, as there are cases of pSeries and iSeries where it could
be a valid value and those can't reassign devices.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 
 arch/powerpc/kernel/pci-common.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-02-29 13:37:51.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-02-29 14:39:28.000000000 +1100
@@ -748,7 +748,13 @@ static void __devinit pcibios_fixup_reso
 		struct resource *res = dev->resource + i;
 		if (!res->flags)
 			continue;
-		if (res->end == 0xffffffff) {
+		/* On platforms that have PPC_PCI_PROBE_ONLY set, we don't
+		 * consider 0 as an unassigned BAR value. It's technically
+		 * a valid value, but linux doesn't like it... so when we can
+		 * re-assign things, we do so, but if we can't, we keep it
+		 * around and hope for the best...
+		 */
+		if (res->start == 0 && !(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
 			pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] is unassigned\n",
 				 pci_name(dev), i,
 				 (unsigned long long)res->start,
