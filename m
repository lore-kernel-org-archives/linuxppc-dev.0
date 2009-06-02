Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 393B3DDDE1
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 10:53:54 +1000 (EST)
Date: Tue, 2 Jun 2009 10:53:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix annotation of pcibios_claim_one_bus
Message-Id: <20090602105353.b4a7e93d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It was __devinit, but it is also within a CONFIG_HOTPLUG guarded section
of code, so the __devinit does nothing but cause the following warning:

WARNING: vmlinux.o(.text+0x107a8): Section mismatch in reference from the function pcibios_finish_adding_to_bus() to the function .devinit.text:pcibios_claim_one_bus()
The function pcibios_finish_adding_to_bus() references
the function __devinit pcibios_claim_one_bus().
This is often because pcibios_finish_adding_to_bus lacks a __devinit
annotation or the annotation of pcibios_claim_one_bus is wrong.

It is also only (externally) used in arch/powerpc/kernel/of_platform.c
which cannot be built as a module so don't export it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 4fee63c..5a56e97 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1505,7 +1505,7 @@ void __init pcibios_resource_survey(void)
  * rest of the code later, for now, keep it as-is as our main
  * resource allocation function doesn't deal with sub-trees yet.
  */
-void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
+void pcibios_claim_one_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	struct pci_bus *child_bus;
@@ -1533,7 +1533,6 @@ void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
 	list_for_each_entry(child_bus, &bus->children, node)
 		pcibios_claim_one_bus(child_bus);
 }
-EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
 
 
 /* pcibios_finish_adding_to_bus
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
