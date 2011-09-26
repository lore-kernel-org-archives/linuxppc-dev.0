Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE9D9B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Sep 2011 15:02:40 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p8Q52YmO027879
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2011 00:02:35 -0500
Subject: [PATCH] powerpc/pci: Don't configure PCIe settings when
	PCI_PROBE_ONLY is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 15:02:31 +1000
Message-ID: <1317013351.2629.78.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't want to configure PCI Express Max Payload Size or
Max Read Request Size on systems that set that flag. The
firmware will have done it for us, and under hypervisors such
as pHyp we don't even see the parent switches and bridges and
thus can make no assumption on what values are safe to use.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 1bd47f3..677eccc 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1732,7 +1732,7 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
 
 	/* Configure PCI Express settings */
-	if (bus) {
+	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
 		list_for_each_entry(child, &bus->children, node) {
 			struct pci_dev *self = child->self;
