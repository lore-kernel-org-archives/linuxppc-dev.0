Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 071191A1D08
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:49:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/cell: Fix iommu breakage caused by controller_ops
 change
Date: Tue, 14 Apr 2015 16:49:06 +1000
Message-Id: <1428994146-23180-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1428994146-23180-1-git-send-email-mpe@ellerman.id.au>
References: <1428994146-23180-1-git-send-email-mpe@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent patch to convert cell to use pci_controller_ops had a small
bug which broke machines using an iommu.

The set of phb->controller_ops was added after the check for name !=
"pci", meaning pcix/pcie PHBs weren't getting their ops set correctly.

Fixes: 9c1368fc50e7 ("powerpc/cell: Move controller ops from ppc_md to controller_ops")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/cell/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index d1be268b1e6e..36cff28d0293 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -127,13 +127,13 @@ static int cell_setup_phb(struct pci_controller *phb)
 	if (rc)
 		return rc;
 
+	phb->controller_ops = cell_pci_controller_ops;
+
 	np = phb->dn;
 	model = of_get_property(np, "model", NULL);
 	if (model == NULL || strcmp(np->name, "pci"))
 		return 0;
 
-	phb->controller_ops = cell_pci_controller_ops;
-
 	/* Setup workarounds for spider */
 	if (strcmp(model, "Spider"))
 		return 0;
-- 
2.1.0
