Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4770B1A038D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5C0E72BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFeccj23658718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeDUu002031
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 05/34] powerpc/iommu: Always release iommu_table in
 iommu_free_table()
Date: Tue, 12 May 2015 01:38:54 +1000
Message-Id: <1431358763-24371-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment iommu_free_table() only releases memory if
the table was initialized for the platform code use, i.e. it had
it_map initialized (which purpose is to track DMA memory space use).

With dynamic DMA windows, we will need to be able to release
iommu_table even if it was used for VFIO in which case it_map is NULL
so does the patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 3d47eb3..2c02d4c 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -714,8 +714,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	unsigned int order;
 
 	if (!tbl || !tbl->it_map) {
-		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
-				node_name);
+		kfree(tbl);
 		return;
 	}
 
-- 
2.4.0.rc3.8.gfb3e7d5
