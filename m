Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B68FE1A087F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:37 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 6 Aug 2014 12:49:34 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DE8A73578085
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:15 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s762Pvm21769842
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:25:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s762n56L004704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:49:05 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/4] powerpc/eeh: Export eeh_iommu_group_to_pe()
Date: Wed,  6 Aug 2014 12:48:30 +1000
Message-Id: <1407293313-24894-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
References: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
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
