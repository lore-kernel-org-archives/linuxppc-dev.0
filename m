Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8E6A1A0260
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 11:30:06 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 789DF14012C
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:30:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 27 Mar 2015 10:30:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6CDA92CE8040
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:30:03 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2R0TtRW55640262
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:30:03 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2R0TTAP008447
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:29:29 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Don't map M64 segments using M32DT
Date: Fri, 27 Mar 2015 11:29:00 +1100
Message-Id: <1427416140-5378-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If M64 has been supported, the prefetchable 64-bits memory resources
shouldn't be mapped to the corresponding PE# via M32DT. Unfortunately,
we're doing that in pnv_ioda_setup_pe_seg() wrongly. The issue was
introduced by commit 262af55 ("powerpc/powernv: Enable M64 aperatus
for PHB3"). The patch fixes the issue by simply skipping M64 resources
when updating to M32DT.

Cc: <stable@vger.kernel.org>  # v3.17+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b1387ea..5ac7c60 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2462,7 +2462,8 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 				region.start += phb->ioda.io_segsize;
 				index++;
 			}
-		} else if (res->flags & IORESOURCE_MEM) {
+		} else if ((res->flags & IORESOURCE_MEM) &&
+			   !pnv_pci_is_mem_pref_64(res->flags)) {
 			region.start = res->start -
 				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
-- 
1.8.3.2
