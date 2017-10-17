Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGfXv049hzDrKf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:40:46 +1100 (AEDT)
Subject: [PATCH 3/3] powernv/pci: Improve a size determination in
 pnv_pci_init_ioda_phb()
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
Message-ID: <03b68902-629e-65ab-a5e8-d90a3613f596@users.sourceforge.net>
Date: Tue, 17 Oct 2017 17:40:17 +0200
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
Date: Tue, 17 Oct 2017 17:18:10 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 98d9435240f4..2febdf06a237 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3802,7 +3802,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb_id = be64_to_cpup(prop64);
 	pr_debug("  PHB-ID  : 0x%016llx\n", phb_id);
 
-	phb = memblock_virt_alloc(sizeof(struct pnv_phb), 0);
+	phb = memblock_virt_alloc(sizeof(*phb), 0);
 
 	/* Allocate PCI controller */
 	phb->hose = hose = pcibios_alloc_controller(np);
-- 
2.14.2
