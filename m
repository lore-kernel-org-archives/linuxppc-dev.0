Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99ED71A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:27:43 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 17 Feb 2016 17:27:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4D9BE2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:27:38 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H7ROB641812000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:27:38 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H7R0s0019937
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:27:00 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, stable@vger.kernel.org.#.4.2+,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH kernel v2] powerpc/ioda: Set "read" permission when "write" is
 set
Date: Wed, 17 Feb 2016 18:26:31 +1100
Message-Id: <1455693991-31405-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quite often drivers set only "write" permission assuming that this
includes "read" permission as well and this works on plenty platforms.
However IODA2 is strict about this and produces an EEH when "read"
permission is not and reading happens.

This adds a workaround in IODA code to always add the "read" bit when
the "write" bit is set.

This fixes breakage introduced in
10b35b2b74 powerpc/powernv: Do not set "read" flag if direction==DMA_NONE

Cc: stable@vger.kernel.org # 4.2+
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Tested-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2f55c86..6a97ba4 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -599,6 +599,9 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
 	long i;
 
+	if (proto_tce & TCE_PCI_WRITE)
+		proto_tce |= TCE_PCI_READ;
+
 	for (i = 0; i < npages; i++) {
 		unsigned long newtce = proto_tce |
 			((rpn + i) << tbl->it_page_shift);
@@ -620,6 +623,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
 
 	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
 
+	if (newtce & TCE_PCI_WRITE)
+		newtce |= TCE_PCI_READ;
+
 	oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
 	*hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	*direction = iommu_tce_direction(oldtce);
-- 
2.5.0.rc3
