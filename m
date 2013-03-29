Return-Path: <r61911@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B0B832C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 16:07:11 +1100 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/pci: fix 64 bit pci size issue
Date: Fri, 29 Mar 2013 21:06:17 +0800
Message-ID: <1364562377-7579-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The size might be 64 bit, so use ilog2() instead of __ilog2() or
__ilog2_u64().

ilog2() can select 32bit or 64bit funciton automatically.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 682084d..a0a1b76 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -106,7 +106,7 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 		flags |= 0x10000000; /* enable relaxed ordering */
 
 	for (i = 0; size > 0; i++) {
-		unsigned int bits = min(__ilog2(size),
+		unsigned int bits = min(ilog2(size),
 					__ffs(pci_addr | phys_addr));
 
 		if (index + i >= 5)
@@ -196,7 +196,7 @@ static void setup_pci_atmu(struct pci_controller *hose,
 			out_be32(&pci->pow[j].powbar, (hose->io_base_phys >> 12));
 			/* Enable, IO R/W */
 			out_be32(&pci->pow[j].powar, 0x80088000
-				| (__ilog2(hose->io_resource.end
+				| (ilog2(hose->io_resource.end
 				- hose->io_resource.start + 1) - 1));
 		}
 	}
@@ -261,7 +261,7 @@ static void setup_pci_atmu(struct pci_controller *hose,
 	}
 
 	sz = min(mem, paddr_lo);
-	mem_log = __ilog2_u64(sz);
+	mem_log = ilog2(sz);
 
 	/* PCIe can overmap inbound & outbound since RX & TX are separated */
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
@@ -290,7 +290,7 @@ static void setup_pci_atmu(struct pci_controller *hose,
 		 * SWIOTLB and access the full range of memory
 		 */
 		if (sz != mem) {
-			mem_log = __ilog2_u64(mem);
+			mem_log = ilog2(mem);
 
 			/* Size window up if we dont fit in exact power-of-2 */
 			if ((1ull << mem_log) != mem)
@@ -327,7 +327,7 @@ static void setup_pci_atmu(struct pci_controller *hose,
 		sz -= 1ull << mem_log;
 
 		if (sz) {
-			mem_log = __ilog2_u64(sz);
+			mem_log = ilog2(sz);
 			piwar |= (mem_log - 1);
 
 			out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-- 
1.7.9.5
