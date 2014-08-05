Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AA901A021A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:30:03 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 5 Aug 2014 22:30:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 564ED2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:29:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75CUSie11534556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:30:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75CTt5D019952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:29:56 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/eeh: Export eeh_iommu_group_to_pe()
Date: Tue,  5 Aug 2014 22:29:42 +1000
Message-Id: <1407241785-30111-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
References: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

The function is used by VFIO driver, which might be built as a
dynamic module.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6043879..59a64f8 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1254,6 +1254,7 @@ struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group)
 
 	return edev->pe;
 }
+EXPORT_SYMBOL_GPL(eeh_iommu_group_to_pe);
 
 #endif /* CONFIG_IOMMU_API */
 
-- 
2.0.0
