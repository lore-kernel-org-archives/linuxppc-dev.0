Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2893E1A02B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:38 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5CD56357805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296UR5H19267746
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296U2Pf021563
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:03 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 03/10] powerpc/powernv: Define TCE Kill flags
Date: Wed,  9 Mar 2016 17:28:59 +1100
Message-Id: <1457504946-40649-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
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
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 889eca3..33e9489 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1824,10 +1824,13 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
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
@@ -1855,7 +1858,7 @@ static void pnv_pci_ioda2_do_tce_invalidate(unsigned pe_number, bool rm,
 	unsigned long start, end, inc;
 
 	/* We'll invalidate DMA address in PE scope */
-	start = 0x2ull << 60;
+	start = TCE_KILL_INVAL_TCE;
 	start |= (pe_number & 0xFF);
 	end = start;
 
-- 
2.5.0.rc3
