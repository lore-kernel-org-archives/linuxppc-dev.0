Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 170531A0D82
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 58FF63578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9dWv59634176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dl8Z026328
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 03/12] spapr_iommu: Make spapr_tce_find_by_liobn() public
Date: Tue, 15 Jul 2014 19:39:35 +1000
Message-Id: <1405417184-14333-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
References: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_iommu.c   | 2 +-
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 36f5d27..588d442 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -40,7 +40,7 @@ enum sPAPRTCEAccess {
 
 static QLIST_HEAD(spapr_tce_tables, sPAPRTCETable) spapr_tce_tables;
 
-static sPAPRTCETable *spapr_tce_find_by_liobn(uint32_t liobn)
+sPAPRTCETable *spapr_tce_find_by_liobn(uint32_t liobn)
 {
     sPAPRTCETable *tcet;
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bbba51a..9c5686e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -467,6 +467,7 @@ struct sPAPRTCETable {
     QLIST_ENTRY(sPAPRTCETable) list;
 };
 
+sPAPRTCETable *spapr_tce_find_by_liobn(uint32_t liobn);
 void spapr_events_init(sPAPREnvironment *spapr);
 void spapr_events_fdt_skel(void *fdt, uint32_t epow_irq);
 int spapr_h_cas_compose_response(target_ulong addr, target_ulong size);
-- 
2.0.0
