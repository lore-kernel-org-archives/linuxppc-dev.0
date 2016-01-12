Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E44681A06BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 15:41:24 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 Jan 2016 14:41:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 079502CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 15:41:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C4enQO28770554
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 15:40:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C4ek3D021320
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 15:40:46 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when "write"
 is set
Date: Tue, 12 Jan 2016 15:40:20 +1100
Message-Id: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---


Ben, what was the driver which did not set "read" and caused EEH?


---
 arch/powerpc/platforms/powernv/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f2dd772..c7dcae5 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
 	long i;
 
+	if (proto_tce & TCE_PCI_WRITE)
+		proto_tce |= TCE_PCI_READ;
+
 	for (i = 0; i < npages; i++) {
 		unsigned long newtce = proto_tce |
 			((rpn + i) << tbl->it_page_shift);
@@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
 
 	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
 
+	if (newtce & TCE_PCI_WRITE)
+		newtce |= TCE_PCI_READ;
+
 	oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
 	*hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	*direction = iommu_tce_direction(oldtce);
-- 
2.5.0.rc3
