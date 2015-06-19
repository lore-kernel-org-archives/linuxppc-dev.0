Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C85831A0EF5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Jun 2015 12:27:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2D5AE2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:18 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5J2R7A865077334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5J2Qig9023214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:26:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/powernv: Allow to reserve one PE for multiple
 times
Date: Fri, 19 Jun 2015 12:26:16 +1000
Message-Id: <1434680779-20194-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1434680779-20194-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1434680779-20194-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PE numbers are reserved according to root port's M64 window,
which is aligned to M64 segment finely. So one PE shouldn't be
reserved for multiple times. We will reserve PE numbers according
to the M64 BARs of PCI device in subsequent patches, which aren't
aligned to M64 segment size finely. It means one particular PE
could be reserved for multiple times.

The patch allows one PE to be reserved for multiple times and we
print the warning message at debugging level.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8424f5c..d5bfa76 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -140,11 +140,9 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 		return;
 	}
 
-	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc)) {
-		pr_warn("%s: PE %d was assigned on PHB#%x\n",
-			__func__, pe_no, phb->hose->global_number);
-		return;
-	}
+	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc))
+		pr_debug("%s: PE %d was reserved on PHB#%x\n",
+			 __func__, pe_no, phb->hose->global_number);
 
 	phb->ioda.pe_array[pe_no].phb = phb;
 	phb->ioda.pe_array[pe_no].pe_number = pe_no;
-- 
2.1.0
