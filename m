Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGfWg2klgzDrJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:39:43 +1100 (AEDT)
Subject: [PATCH 2/3] powernv/pci: Use common code in pnv_ioda_pick_m64_pe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Russell Currey <ruscur@russell.cc>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <549d0b6b-f875-c524-d867-742745117c1e@users.sourceforge.net>
Message-ID: <84df26ea-74a3-14e5-9f13-a35486e9a95d@users.sourceforge.net>
Date: Tue, 17 Oct 2017 17:39:12 +0200
MIME-Version: 1.0
In-Reply-To: <549d0b6b-f875-c524-d867-742745117c1e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Oct 2017 17:07:54 +0200

Add a jump target so that a bit of code can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 17c0330bb059..98d9435240f4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -364,21 +364,20 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	/* Figure out reserved PE numbers by the PE */
 	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
 
+	master_pe = NULL;
+
 	/*
 	 * the current bus might not own M64 window and that's all
 	 * contributed by its child buses. For the case, we needn't
 	 * pick M64 dependent PE#.
 	 */
-	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
-		kfree(pe_alloc);
-		return NULL;
-	}
+	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num))
+		goto free_pe;
 
 	/*
 	 * Figure out the master PE and put all slave PEs to master
 	 * PE's list to form compound PE.
 	 */
-	master_pe = NULL;
 	i = -1;
 	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe_num, i + 1)) <
 		phb->ioda.total_pe_num) {
@@ -416,6 +415,7 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 		}
 	}
 
+free_pe:
 	kfree(pe_alloc);
 	return master_pe;
 }
-- 
2.14.2
