Return-Path: <prvs=5540a0381=luisbg@amazon.com>
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQq0s44BczDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 00:30:05 +1100 (AEDT)
From: Luis de Bethencourt <luisbg@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Russell Currey <ruscur@russell.cc>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Popple <alistair@popple.id.au>, Rob Herring <robh@kernel.org>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH 1/2] powerpc/powernv: Fix trailing semicolon
Date: Tue, 23 Jan 2018 13:29:34 +0000
Message-Id: <20180123132935.24995-1-luisbg@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f6f0c5717e08..101981cc75ac 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1840,7 +1840,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	s64 rc;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
-		return -ENODEV;;
+		return -ENODEV;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	if (pe->tce_bypass_enabled) {
-- 
2.15.1
