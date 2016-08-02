Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6f1d66zDrF7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:06 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248tfG091731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:03 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gr47vq36-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:03 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:10:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0B8C3357805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724AwWC31326452
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724Avew009850
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 6/9] powerpc/powernv: Pass CPU-endian argument to xchg() in
 pnv_tce_xchg()
Date: Tue,  2 Aug 2016 14:10:34 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-7-git-send-email-gwshan@linux.vnet.ibm.com>
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
                             arch/powerpc/platforms/powernv/pci.o
  arch/powerpc/platforms/powernv/pci.c:740:18: \
  warning: cast from restricted __be64
  arch/powerpc/platforms/powernv/pci.c:740:18: \
  warning: cast to restricted __be64
  arch/powerpc/platforms/powernv/pci.c:740:18: \
  warning: cast from restricted __be64
  arch/powerpc/platforms/powernv/pci.c:740:18: \
  warning: cast to restricted __be64

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: 802a345183c0 ("powerpc/powernv/ioda: Fix endianness when reading TCEs")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 9a26a57..4e385f9 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -737,7 +737,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
 	if (newtce & TCE_PCI_WRITE)
 		newtce |= TCE_PCI_READ;
 
-	oldtce = be64_to_cpu(xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce)));
+	oldtce = be64_to_cpu((__force __be64)xchg(
+			(unsigned long *)pnv_tce(tbl, idx),
+			(__force unsigned long)cpu_to_be64(newtce)));
 	*hpa = oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	*direction = iommu_tce_direction(oldtce);
 
-- 
2.1.0
