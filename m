Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A0651A01C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:15 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:12 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D63122BB0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2nFKZ63635584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:49:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36A6T014636
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/18] powerpc/powernv: Use it_page_shift in TCE build
Date: Wed, 23 Jul 2014 13:05:52 +1000
Message-Id: <1406084764-24685-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
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

This makes use of iommu_table::it_page_shift instead of TCE_SHIFT and
TCE_RPN_SHIFT hardcoded values.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f91a4e5..b6cb996 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -564,10 +564,11 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		proto_tce |= TCE_PCI_WRITE;
 
 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
-	rpn = __pa(uaddr) >> TCE_SHIFT;
+	rpn = __pa(uaddr) >> tbl->it_page_shift;
 
 	while (npages--)
-		*(tcep++) = cpu_to_be64(proto_tce | (rpn++ << TCE_RPN_SHIFT));
+		*(tcep++) = cpu_to_be64(proto_tce |
+				(rpn++ << tbl->it_page_shift));
 
 	/* Some implementations won't cache invalid TCEs and thus may not
 	 * need that flush. We'll probably turn it_type into a bit mask
-- 
2.0.0
