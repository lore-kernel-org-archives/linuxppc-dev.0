Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx73B4wHqzDqfZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:01:10 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 19:01:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9F32B357816F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:58:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T8wFNH36307192
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:58:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T8voNt023026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:57:51 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 04/11] powerpc/powernv: Define TCE Kill flags
Date: Fri, 29 Apr 2016 18:55:17 +1000
Message-Id: <1461920124-21719-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces magic constants for TCE Kill IODA2 register with macros.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ca307b6..03be25d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1811,10 +1811,13 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
+#define TCE_KILL_INVAL_PE   PPC_BIT(1)
+#define TCE_KILL_INVAL_TCE  PPC_BIT(2)
+
 static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
-	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
+	unsigned long val = TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
 	struct pnv_phb *phb = pe->phb;
 	struct pnv_ioda_pe *npe;
 	int i;
@@ -1842,7 +1845,7 @@ static void pnv_pci_ioda2_do_tce_invalidate(unsigned pe_number, bool rm,
 	unsigned long start, end, inc;
 
 	/* We'll invalidate DMA address in PE scope */
-	start = 0x2ull << 60;
+	start = TCE_KILL_INVAL_TCE;
 	start |= (pe_number & 0xFF);
 	end = start;
 
-- 
2.5.0.rc3
