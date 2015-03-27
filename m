Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE49A1A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8A4F42BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:33 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REuLiv46137460
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:30 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REtuo5030534
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:55:56 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 02/31] vfio: powerpc/spapr: Do cleanup when
 releasing the group
Date: Sat, 28 Mar 2015 01:54:46 +1100
Message-Id: <1427468115-2224-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This clears the TCE table when a container is being closed as this is
a good thing to leave the table clean before passing the ownership
back to the host kernel.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index cefaf05..e9b4d7d 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -132,16 +132,24 @@ static void *tce_iommu_open(unsigned long arg)
 	return container;
 }
 
+static int tce_iommu_clear(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long pages);
+
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
+	struct iommu_table *tbl = container->tbl;
 
-	WARN_ON(container->tbl && !container->tbl->it_group);
+	WARN_ON(tbl && !tbl->it_group);
 	tce_iommu_disable(container);
 
-	if (container->tbl && container->tbl->it_group)
-		tce_iommu_detach_group(iommu_data, container->tbl->it_group);
+	if (tbl) {
+		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
 
+		if (tbl->it_group)
+			tce_iommu_detach_group(iommu_data, tbl->it_group);
+	}
 	mutex_destroy(&container->lock);
 
 	kfree(container);
-- 
2.0.0
