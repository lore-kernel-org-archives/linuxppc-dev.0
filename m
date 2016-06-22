Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZGM16y8TzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 17:24:45 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u5M7OcjC013574
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 02:24:39 -0500
Message-ID: <1466580277.4089.25.camel@kernel.crashing.org>
Subject: [RFC/PATCH] powerpc/pci: Don't try to allocate resources that will
 be reassigned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 22 Jun 2016 17:24:37 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we know we will reassign all resources, trying (and failing)
to allocate them initially is fairly pointless and leads to a lot
of scary messages in the kernel log

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

This one probably needs testing on a few platforms but I think it's
correct ;-)

---
 arch/powerpc/kernel/pci-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e723a32..2a67b16 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1360,9 +1360,9 @@ void __init pcibios_resource_survey(void)
 	struct pci_bus *b;
 
 	/* Allocate and assign resources */
+	list_for_each_entry(b, &pci_root_buses, node)
+		pcibios_allocate_bus_resources(b);
 	if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
-		list_for_each_entry(b, &pci_root_buses, node)
-			pcibios_allocate_bus_resources(b);
 		pcibios_allocate_resources(0);
 		pcibios_allocate_resources(1);
 	}
