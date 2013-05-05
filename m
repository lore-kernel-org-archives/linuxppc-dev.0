Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E69BA2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 May 2013 10:24:40 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r450OWIp009820
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 19:24:33 -0500
Message-ID: <1367713472.11982.26.camel@pasglop>
Subject: [PATCH] powerpc/pnv: Fix "compatible" property for P8 PHB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Sun, 05 May 2013 10:24:32 +1000
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

The property should be "ibm,power8-pciex", not "ibm,p8-pciex". The latter
was changed in FW because it was inconsistent with the rest of the nodes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8c6c9cf..97b08fc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1089,7 +1089,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	/* Detect specific models for error handling */
 	if (of_device_is_compatible(np, "ibm,p7ioc-pciex"))
 		phb->model = PNV_PHB_MODEL_P7IOC;
-	else if (of_device_is_compatible(np, "ibm,p8-pciex"))
+	else if (of_device_is_compatible(np, "ibm,power8-pciex"))
 		phb->model = PNV_PHB_MODEL_PHB3;
 	else
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
