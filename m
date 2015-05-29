Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 882A91A066D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EB0053578063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kDHT33489026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jnNZ027995
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 05/34] powerpc/iommu: Always release iommu_table in
 iommu_free_table()
Date: Fri, 29 May 2015 18:44:29 +1000
Message-Id: <1432889098-22924-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
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
Changes:
v11:
* fixed parameter checks
---
 arch/powerpc/kernel/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 3d47eb3..73eb39a 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -713,9 +713,11 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	unsigned long bitmap_sz;
 	unsigned int order;
 
-	if (!tbl || !tbl->it_map) {
-		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
-				node_name);
+	if (!tbl)
+		return;
+
+	if (!tbl->it_map) {
+		kfree(tbl);
 		return;
 	}
 
-- 
2.4.0.rc3.8.gfb3e7d5
