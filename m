Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 994B71A0145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:14:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 12 May 2015 17:14:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 149632BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:14:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C7ETxC27131926
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:14:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C7E5jG004934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:14:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Fix wrong printed PE number
Date: Tue, 12 May 2015 17:05:22 +1000
Message-Id: <1431414322-28995-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On LE kernel, the non-existing PE number in BE format derived from
skiboot firmware isn't converted to LE format properly as following
kernel log indicates:

   EEH: Clear non-existing PHB#4-PE#200000000000000

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ce738ab..9e001e1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1396,7 +1396,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 				be64_to_cpu(frozen_pe_no), pe)) {
 				/* Try best to clear it */
 				pr_info("EEH: Clear non-existing PHB#%x-PE#%llx\n",
-					hose->global_number, frozen_pe_no);
+					hose->global_number, be64_to_cpu(frozen_pe_no));
 				pr_info("EEH: PHB location: %s\n",
 					eeh_pe_loc_get(phb_pe));
 				opal_pci_eeh_freeze_clear(phb->opal_id,
-- 
2.1.0
