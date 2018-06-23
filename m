Return-Path: <tpearson@raptorengineering.com>
Received: from mail.rptsys.com (mail.rptsys.com [192.119.205.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Csw063kYzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 10:03:28 +1000 (AEST)
Date: Sat, 23 Jun 2018 18:53:54 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <955790001.2569251.1529798034743.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 4/7] powerpc/powernv/pci: Safety fixes for pseudobypass TCE
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

 allocation

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-dma.c b/arch/powerpc/platforms/powernv/pci-dma.c
index 1d5409be343e..237940a2a052 100644
--- a/arch/powerpc/platforms/powernv/pci-dma.c
+++ b/arch/powerpc/platforms/powernv/pci-dma.c
@@ -29,8 +29,9 @@ static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr
 {
 	int tce;
 	__be64 old, new;
+	unsigned long flags;
 
-	spin_lock(&pe->tce_alloc_lock);
+	spin_lock_irqsave(&pe->tce_alloc_lock, flags);
 	tce = bitmap_find_next_zero_area(pe->tce_bitmap,
 					 pe->tce_count,
 					 0,
@@ -40,9 +41,10 @@ static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr
 	old = pe->tces[tce];
 	new = cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
 	pe->tces[tce] = new;
+	mb();
 	pe_info(pe, "allocating TCE %i 0x%016llx (old 0x%016llx)\n",
 		tce, new, old);
-	spin_unlock(&pe->tce_alloc_lock);
+	spin_unlock_irqrestore(&pe->tce_alloc_lock, flags);
 
 	return tce;
 }
-- 
2.17.1
