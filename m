Return-Path: <tpearson@raptorengineering.com>
Received: from mail.rptsys.com (mail.rptsys.com [192.119.205.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Csvx4wRHzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 10:03:25 +1000 (AEST)
Date: Sat, 23 Jun 2018 18:54:36 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <1298010887.2569253.1529798076885.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 6/7] powerpc/powernv/pci: Invalidate TCE cache after DMA map
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 setup

Per the IODA2, TCEs must be invalidated after their settings
have been changed.  Invalidate the cache after the address
is changed during TCE allocation when using pseudo DMA.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/platforms/powernv/pci-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-dma.c b/arch/powerpc/platforms/powernv/pci-dma.c
index 237940a2a052..060dbc168401 100644
--- a/arch/powerpc/platforms/powernv/pci-dma.c
+++ b/arch/powerpc/platforms/powernv/pci-dma.c
@@ -42,8 +42,7 @@ static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr
 	new = cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
 	pe->tces[tce] = new;
 	mb();
-	pe_info(pe, "allocating TCE %i 0x%016llx (old 0x%016llx)\n",
-		tce, new, old);
+	pnv_pci_ioda2_tce_invalidate_pe(pe);
 	spin_unlock_irqrestore(&pe->tce_alloc_lock, flags);
 
 	return tce;
-- 
2.17.1
