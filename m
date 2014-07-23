Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F6AA1A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:23 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:19 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 92C773578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:17 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2nLjS18874392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:49:21 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36GaS031287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 15/18] powerpc/iommu: Implement put_page() if TCE had
 non-zero value
Date: Wed, 23 Jul 2014 13:06:01 +1000
Message-Id: <1406084764-24685-16-git-send-email-aik@ozlabs.ru>
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

Guests might put new TCEs without clearing them first and the PAPR spec
allows that.

This adds put_page() for TCEs which we just replaced.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ae57910..53155c4 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1054,11 +1054,11 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
 	spin_lock(&(pool->lock));
 
-	oldtce = ppc_md.tce_get(tbl, entry);
-	/* Add new entry if it is not busy */
-	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, NULL,
-				direction, NULL);
+	ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, &oldtce,
+			direction, NULL);
+
+	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
+		put_page(pfn_to_page(__pa(oldtce) >> PAGE_SHIFT));
 
 	spin_unlock(&(pool->lock));
 
-- 
2.0.0
