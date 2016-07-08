Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4Yb2crxzDrGW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:55 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YZ3MrMz9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:54 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/14] powerpc/pci: Don't try to allocate resources that will
 be reassigned
Date: Fri,  8 Jul 2016 16:37:18 +1000
Message-Id: <1467959838-6900-14-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
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
---
 arch/powerpc/kernel/pci-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d1f91e1..fb32db4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1370,8 +1370,10 @@ void __init pcibios_resource_survey(void)
 	/* Allocate and assign resources */
 	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_allocate_bus_resources(b);
-	pcibios_allocate_resources(0);
-	pcibios_allocate_resources(1);
+	if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
+		pcibios_allocate_resources(0);
+		pcibios_allocate_resources(1);
+	}
 
 	/* Before we start assigning unassigned resource, we try to reserve
 	 * the low IO area and the VGA memory area if they intersect the
-- 
2.7.4
