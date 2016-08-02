Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6f1BMgzDrF4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:06 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248tpv130681
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:04 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gn49j71p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:04 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:11:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 245092BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724Axqa28049502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724Awbb009919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 7/9] powerpc/powernv: Fix data type for @r in
 pnv_ioda_parse_m64_window()
Date: Tue,  2 Aug 2016 14:10:35 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-8-git-send-email-gwshan@linux.vnet.ibm.com>
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
  arch/powerpc/platforms/powernv/pci-ioda.c:451:49: \
  warning: incorrect type in argument 2 (different base types)
  arch/powerpc/platforms/powernv/pci-ioda.c:451:49: \
  expected restricted __be32 const [usertype] *addr
  arch/powerpc/platforms/powernv/pci-ioda.c:451:49: \
  got unsigned int const [usertype] *
  arch/powerpc/platforms/powernv/pci-ioda.c:452:50: \
  warning: incorrect type in argument 1 (different base types)
  arch/powerpc/platforms/powernv/pci-ioda.c:452:50: \
  expected restricted __be32 const [usertype] *cell
  arch/powerpc/platforms/powernv/pci-ioda.c:452:50: \
  got unsigned int const [usertype] *
  arch/powerpc/platforms/powernv/pci-ioda.c:454:35: \
  warning: incorrect type in argument 1 (different base types)
  arch/powerpc/platforms/powernv/pci-ioda.c:454:35: \
  expected restricted __be32 const [usertype] *cell
  arch/powerpc/platforms/powernv/pci-ioda.c:454:35: \
  got unsigned int const [usertype] *[assigned] r

Fixes: 262af557dd75 ("powerpc/powernv: Enable M64 aperatus for PHB3")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 891fc4a..ac60190 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -402,7 +402,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	struct device_node *dn = hose->dn;
 	struct resource *res;
 	u32 m64_range[2], i;
-	const u32 *r;
+	const __be32 *r;
 	u64 pci_addr;
 
 	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2) {
-- 
2.1.0
