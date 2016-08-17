Return-Path: <a.hajda@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDlRk5K9qzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 20:13:22 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OC1009LRT9BQQ80@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 17 Aug 2016 11:03:12 +0100 (BST)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT))
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/powernv/pci: fix iterator signedness
Date: Wed, 17 Aug 2016 12:03:05 +0200
Message-id: <1471428185-23529-1-git-send-email-a.hajda@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unsigned type is always non-negative, so the loop could not end in case
condition is never true.

The problem has been detected using semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fd9444f..1321826 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -149,7 +149,7 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
 static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
-	unsigned long pe = phb->ioda.total_pe_num - 1;
+	long pe;
 
 	for (pe = phb->ioda.total_pe_num - 1; pe >= 0; pe--) {
 		if (!test_and_set_bit(pe, phb->ioda.pe_alloc))
-- 
1.9.1
