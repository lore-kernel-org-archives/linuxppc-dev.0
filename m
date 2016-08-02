Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6h4PQkzDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:08 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248t0v031395
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:06 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24jh30p0tf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:05 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:11:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A75EE2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724AxS322806740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724AxPA009963
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 9/9] powerpc/powernv: Fix data type in
 pnv_pci_ioda2_table_do_free_pages()
Date: Tue,  2 Aug 2016 14:10:37 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-10-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes warning reported from sparse:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                             arch/powerpc/platforms/powernv/pci-ioda.o
        :
  arch/powerpc/platforms/powernv/pci-ioda.c:2647:45: \
  warning: cast to restricted __be64

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: bbb845c4bac8 ("powerpc/powernv: Implement multilevel TCE tables")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3d367ba..cc2d28c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2644,7 +2644,8 @@ static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
 		u64 *tmp = (u64 *) addr_ul;
 
 		for (i = 0; i < size; ++i) {
-			unsigned long hpa = be64_to_cpu(tmp[i]);
+			unsigned long hpa =
+				be64_to_cpu((__force __be64)(tmp[i]));
 
 			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
 				continue;
-- 
2.1.0
