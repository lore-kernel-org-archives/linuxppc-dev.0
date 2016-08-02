Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6n490GzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:13 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248rYW132710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:11 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24jh2xx26w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:10 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:11:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BCE923578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:04 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724B4i626738722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:11:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724B4CE007228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:11:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 8/9] powerpc/powernv: Fix data type of argument to __raw_{rm_,
 }writeq()
Date: Tue,  2 Aug 2016 14:10:36 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-9-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The value passed to __raw_rm_writeq() and __raw_writeq() should be "u64"
and "unsigned long". This fixes warning reported from sparse:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                             arch/powerpc/platforms/powernv/pci-ioda.o
  arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
  warning: incorrect type in argument 1 (different base types)
  arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
  expected unsigned long long [unsigned] [usertype] val
  arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
  got restricted __be64 [usertype] <noident>
  arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
  warning: incorrect type in argument 1 (different base types)
  arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
  expected unsigned long [unsigned] v
  arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
  got restricted __be64 [usertype] <noident>

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ac60190..3d367ba 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1791,9 +1791,11 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
         mb(); /* Ensure above stores are visible */
         while (start <= end) {
 		if (rm)
-			__raw_rm_writeq(cpu_to_be64(start), invalidate);
+			__raw_rm_writeq((__force u64)cpu_to_be64(start),
+					invalidate);
 		else
-			__raw_writeq(cpu_to_be64(start), invalidate);
+			__raw_writeq((__force unsigned long)cpu_to_be64(start),
+				     invalidate);
                 start += inc;
         }
 
@@ -1858,9 +1860,11 @@ void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
 
 	mb(); /* Ensure previous TCE table stores are visible */
 	if (rm)
-		__raw_rm_writeq(cpu_to_be64(val), invalidate);
+		__raw_rm_writeq((__force u64)cpu_to_be64(val),
+				invalidate);
 	else
-		__raw_writeq(cpu_to_be64(val), invalidate);
+		__raw_writeq((__force unsigned long)cpu_to_be64(val),
+			     invalidate);
 }
 
 static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
@@ -1870,7 +1874,7 @@ static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 	unsigned long val = PHB3_TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
 
 	mb(); /* Ensure above stores are visible */
-	__raw_writeq(cpu_to_be64(val), invalidate);
+	__raw_writeq((__force unsigned long)cpu_to_be64(val), invalidate);
 }
 
 static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
@@ -1893,9 +1897,11 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
 
 	while (start <= end) {
 		if (rm)
-			__raw_rm_writeq(cpu_to_be64(start), invalidate);
+			__raw_rm_writeq((__force u64)cpu_to_be64(start),
+					invalidate);
 		else
-			__raw_writeq(cpu_to_be64(start), invalidate);
+			__raw_writeq((__force unsigned long)cpu_to_be64(start),
+				     invalidate);
 		start += inc;
 	}
 }
-- 
2.1.0
