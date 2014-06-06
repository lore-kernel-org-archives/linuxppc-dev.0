Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F0681A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:21 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 6 Jun 2014 18:44:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7D7FD2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s568MH1J47513624
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:22:18 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s568iBJ2014015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:44:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/powernv: use it_page_shift in TCE build
Date: Fri,  6 Jun 2014 18:44:02 +1000
Message-Id: <1402044246-13650-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
References: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
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
index 8518817..9f7c556 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -527,10 +527,11 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
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
