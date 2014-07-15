Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BE5C1A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:55 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:24:54 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 138272CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:52 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F929q811207094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:02:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9OpEM005031
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:51 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 12/16] powerpc/powernv: Return non-zero TCE from
 pnv_tce_build
Date: Tue, 15 Jul 2014 19:24:36 +1000
Message-Id: <1405416280-12318-13-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416280-12318-1-git-send-email-aik@ozlabs.ru>
References: <1405416280-12318-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This returns old TCE values to the caller if requested.
The caller is expectded to call put_page() for them.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index e002c66..a9165a5 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -575,6 +575,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	u64 proto_tce;
 	__be64 *tcep, *tces;
 	u64 rpn;
+	long i;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
 
@@ -584,9 +585,13 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 	rpn = __pa(uaddr) >> tbl->it_page_shift;
 
-	while (npages--)
-		*(tcep++) = cpu_to_be64(proto_tce |
-				(rpn++ << tbl->it_page_shift));
+	for (i = 0; i < npages; i++) {
+		unsigned long oldtce = xchg(tcep, cpu_to_be64(proto_tce |
+				(rpn++ << tbl->it_page_shift)));
+		if (old_tces)
+			old_tces[i] = (unsigned long) __va(oldtce);
+		tcep++;
+	}
 
 	pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
 
-- 
2.0.0
