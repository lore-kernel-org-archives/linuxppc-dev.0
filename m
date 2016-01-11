Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8A691A0C0E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:59:14 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com, ruscur@russell.cc,
 benh@kernel.crashing.org, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 2/2] powerpc/powernv: Reserve PE#0 on NPU
Date: Mon, 11 Jan 2016 16:53:50 +1100
Message-Id: <1452491630-22690-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1452491630-22690-1-git-send-email-alistair@popple.id.au>
References: <1452491630-22690-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P8+ hardware reports all errors on PE#0. This patch ensures PE#0 is
not assigned to NPU devices so that it can be used for EEH.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0b625272..573ae19 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1186,9 +1186,11 @@ static void pnv_pci_ioda_setup_PEs(void)
 		 * functions. PCI bus dependent PEs are required for the
 		 * remaining types of PHBs.
 		 */
-		if (phb->type == PNV_PHB_NPU)
+		if (phb->type == PNV_PHB_NPU) {
+			/* PE#0 is needed for error reporting */
+			pnv_ioda_reserve_pe(phb, 0);
 			pnv_ioda_setup_npu_PEs(hose->bus);
-		else
+		} else
 			pnv_ioda_setup_PEs(hose->bus);
 	}
 }
-- 
2.1.4
