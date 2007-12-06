Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A0F9CDDF69
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:02 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 7BC0B368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:02 +1100 (EST)
Date: Fri, 7 Dec 2007 02:03:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 17/19] [POWERPC] remove some iSeries platform checks from
	the PCI code
Message-Id: <20071207020323.8d06e4f1.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c         |   23 ++++++++---------------
 arch/powerpc/platforms/iseries/pci.c |    2 ++
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 42ff9c9..acf1219 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -31,7 +31,6 @@
 #include <asm/byteorder.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
-#include <asm/firmware.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -197,9 +196,6 @@ static void __init pcibios_claim_of_setup(void)
 {
 	struct pci_bus *b;
 
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return;
-
 	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_claim_one_bus(b);
 }
@@ -477,8 +473,7 @@ void __devinit scan_phb(struct pci_controller *hose)
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
-	if (!firmware_has_feature(FW_FEATURE_ISERIES))
-		pcibios_map_io_space(bus);
+	pcibios_map_io_space(bus);
 
 	bus->resource[0] = res = &hose->io_resource;
 	if (res->flags && request_resource(&ioport_resource, res)) {
@@ -527,15 +522,13 @@ static int __init pcibios_init(void)
 		pci_bus_add_devices(hose->bus);
 	}
 
-	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (pci_probe_only)
-			pcibios_claim_of_setup();
-		else
-			/* FIXME: `else' will be removed when
-			   pci_assign_unassigned_resources() is able to work
-			   correctly with [partially] allocated PCI tree. */
-			pci_assign_unassigned_resources();
-	}
+	if (pci_probe_only)
+		pcibios_claim_of_setup();
+	else
+		/* FIXME: `else' will be removed when
+		   pci_assign_unassigned_resources() is able to work
+		   correctly with [partially] allocated PCI tree. */
+		pci_assign_unassigned_resources();
 
 	/* Call machine dependent final fixup */
 	if (ppc_md.pcibios_fixup)
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 4bcf446..db0a17e 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -646,6 +646,8 @@ void __init iSeries_pcibios_init(void)
 	/* Install IO hooks */
 	ppc_pci_io = iseries_pci_io;
 
+	pci_probe_only = 1;
+
 	/* iSeries has no IO space in the common sense, it needs to set
 	 * the IO base to 0
 	 */
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
