Return-Path: <theidsieck@leenox.de>
Received: from mail.leenox.de (giles.leenox.de [5.9.156.120])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKJ4r3C9KzDrcX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 05:57:48 +1000 (AEST)
From: Tillmann Heidsieck <theidsieck@leenox.de>
To: Scott Wood <scottwood@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Tillmann Heidsieck <theidsieck@leenox.de>
Subject: [RFC PATCH] powerpc: fsl_pci: fix inbound ATMU entries for systems
 with >4G RAM
Date: Wed, 24 Aug 2016 21:46:14 +0200
Message-Id: <20160824194614.4014-1-theidsieck@leenox.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For systems with >4G of RAM, the current implementation adds a second
inbound PCIe window starting at 128G this leaves all memory from 4G to
128G inaccessible to inbound PCIe transactions. The according errors
can be observed by using the EDAC driver for MPC85XX.

This patch changes this behaviour by adding the second window starting
at 4G. The current implementation still leaves memory beyond 68G
unmapped as this would require yet another ATMU entry.

Tested on a T4240 with 12G of RAM and an AMD E6760 PCIe card working with
the in-tree radeon driver.

Signed-off-by: Tillmann Heidsieck <theidsieck@leenox.de>
---
 arch/powerpc/sysdev/fsl_pci.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 0ef9df49f0f2..260983037904 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -349,17 +349,13 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	}
 
 	sz = min(mem, paddr_lo);
-	mem_log = ilog2(sz);
+	mem_log = order_base_2(sz);
 
 	/* PCIe can overmap inbound & outbound since RX & TX are separated */
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		/* Size window to exact size if power-of-two or one size up */
-		if ((1ull << mem_log) != mem) {
-			mem_log++;
-			if ((1ull << mem_log) > mem)
-				pr_info("%s: Setting PCI inbound window "
-					"greater than memory size\n", name);
-		}
+		if ((1ull << mem_log) > mem)
+			pr_info("%s: Setting PCI inbound window greater than memory size\n",
+				name);
 
 		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
 
@@ -379,23 +375,27 @@ static void setup_pci_atmu(struct pci_controller *hose)
 		 * let devices that are 64-bit address capable to work w/o
 		 * SWIOTLB and access the full range of memory
 		 */
-		if (sz != mem) {
-			mem_log = ilog2(mem);
-
-			/* Size window up if we dont fit in exact power-of-2 */
-			if ((1ull << mem_log) != mem)
-				mem_log++;
-
+		if (mem > 0x100000000ULL) {
+			/* ok we mapped 4G in WIN1, now lets see how much memory
+			 * is left un-mapped and calculate the log, also
+			 * make sure we dont have a window lager then 64G
+			 */
+			mem_log = order_base_2(min(mem - sz, 1ULL << 36));
 			piwar = (piwar & ~PIWAR_SZ_MASK) | (mem_log - 1);
 
 			if (setup_inbound) {
-				/* Setup inbound memory window */
-				out_be32(&pci->piw[win_idx].pitar,  0x00000000);
+				/* Setup inbound memory window
+				 * The windows starts at 4G and spans all the
+				 * remaining memory aka (mem - 4G)
+				 */
+				out_be32(&pci->piw[win_idx].pitar,
+					 0x00000000);
 				out_be32(&pci->piw[win_idx].piwbear,
-						pci64_dma_offset >> 44);
+					 0x00000000);
 				out_be32(&pci->piw[win_idx].piwbar,
-						pci64_dma_offset >> 12);
-				out_be32(&pci->piw[win_idx].piwar,  piwar);
+					 0x100000000ULL >> 12);
+				out_be32(&pci->piw[win_idx].piwar,
+					 piwar);
 			}
 
 			/*
-- 
2.9.3
