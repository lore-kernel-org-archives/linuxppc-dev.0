Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyC764p6hzDr3j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 16:09:38 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S698ZO086179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 02:09:36 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bc36gy4ww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 02:09:36 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 02:09:35 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH] powerpc: Build fix for non SPARSEMEM_VMEMAP config
Date: Wed, 28 Jun 2017 11:39:28 +0530
Message-Id: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can use pfn_to_page in realmode for other configs. Hence remove the
CONFIG_FLATMEM ifdef

Fixes: 8e0861fa3c4ed (powerpc: Prepare to support kernel handling of IOMMU map/unmap)

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index ec84b31c6c86..3dd507b4f8cd 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -322,7 +322,7 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
 
-#elif defined(CONFIG_FLATMEM)
+#else
 
 struct page *realmode_pfn_to_page(unsigned long pfn)
 {
-- 
2.7.4
