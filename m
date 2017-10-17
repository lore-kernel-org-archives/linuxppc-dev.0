Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGfTp4c9tzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:38:06 +1100 (AEDT)
Subject: [PATCH 1/3] powernv/pci: Delete an error message for a failed memory
 allocation in pnv_ioda_pick_m64_pe()
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
Message-ID: <c77ce664-09a6-1ddc-5794-43227f63d01f@users.sourceforge.net>
Date: Tue, 17 Oct 2017 17:37:41 +0200
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
Date: Tue, 17 Oct 2017 16:52:43 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fb5cd7511189..17c0330bb059 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -358,11 +358,8 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	/* Allocate bitmap */
 	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
 	pe_alloc = kzalloc(size, GFP_KERNEL);
-	if (!pe_alloc) {
-		pr_warn("%s: Out of memory !\n",
-			__func__);
+	if (!pe_alloc)
 		return NULL;
-	}
 
 	/* Figure out reserved PE numbers by the PE */
 	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
-- 
2.14.2
