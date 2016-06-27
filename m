Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpf5PjKzDqyB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:26:18 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpf0YDkz9t1d
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:26:17 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/17] powerpc/powernv/pci: Check status of a PHB before using
 it
Date: Mon, 27 Jun 2016 22:25:30 +1000
Message-Id: <1467030333-31435-15-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the firmware encounters an error (internal or HW) during initialization
of a PHB, it might leave the device-node in the tree but mark it disabled
using the "status" property. We should check it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b674a38..9d59eeb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3442,6 +3442,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	void *aux;
 	long rc;
 
+	if (!of_device_is_available(np))
+		return;
+
 	pr_info("Initializing IODA%d OPAL PHB %s\n", ioda_type, np->full_name);
 
 	prop64 = of_get_property(np, "ibm,opal-phbid", NULL);
-- 
2.7.4
