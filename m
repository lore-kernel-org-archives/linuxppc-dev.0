Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E481E1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 16:00:56 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 9 Jun 2015 16:00:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4942C357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 16:00:51 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5960eog30539868
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 16:00:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5960Hn7000396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 16:00:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Lameter <cl@linux.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/pseries: Fix compile error when
 CONFIG_IOMMU_API if off
Date: Tue,  9 Jun 2015 15:59:51 +1000
Message-Id: <1433829591-3971-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes compile error introduced in
"[PATCH kernel v12 17/34]
powerpc/spapr: vfio: Switch from iommu_table to new iommu_table_group".


Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 38a372d..10510de 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -93,7 +93,9 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		const char *node_name)
 {
 	struct iommu_table *tbl;
+#ifdef CONFIG_IOMMU_API
 	struct iommu_table_group_link *tgl;
+#endif
 
 	if (!table_group)
 		return;
-- 
2.4.0.rc3.8.gfb3e7d5
