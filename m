Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N726RtmzDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248qQv115892
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:25 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gqhkeg4b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:24 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:11:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D71C33578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:20 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724BKPA29098146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:11:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724BKAE002302
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:11:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/9] powerpc/powernv: Use CPU-endian hub diag-data type in
 pnv_eeh_get_and_dump_hub_diag()
Date: Tue,  2 Aug 2016 14:10:30 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hub diag-data type is filled with big-endian data by OPAL call
opal_pci_get_hub_diag_data(). We need convert it to CPU-endian value
before using it. The issue is reported by sparse as pointed by Michael
Ellerman:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                        arch/powerpc/platforms/powernv/eeh-powernv.o
       :
  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
  warning: restricted __be16 degrades to integer
  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
  warning: restricted __be16 degrades to integer
  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
  warning: restricted __be16 degrades to integer
  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
  warning: restricted __be16 degrades to integer
  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
  warning: restricted __be16 degrades to integer

This converts hub diag-data type to CPU-endian before using it in
pnv_eeh_get_and_dump_hub_diag().

Fixes: 2a485ad7c88d ("powerpc/powernv: Drop PHB operation next_error()")
Cc: stable@vger.kernel.org # v4.1+
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 75363d9..8fec7a3 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1306,7 +1306,7 @@ static void pnv_eeh_get_and_dump_hub_diag(struct pci_controller *hose)
 		return;
 	}
 
-	switch (data->type) {
+	switch (be16_to_cpu(data->type)) {
 	case OPAL_P7IOC_DIAG_TYPE_RGC:
 		pr_info("P7IOC diag-data for RGC\n\n");
 		pnv_eeh_dump_hub_diag_common(data);
-- 
2.1.0
