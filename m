Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E5AC1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:00:26 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C690140D87
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:00:24 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 76A2D2CE8059
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9840E3m55115874
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:00:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t983xnnc028237
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 7/8] powerpc/powernv: Remove pnv_eeh_cap_start()
Date: Thu,  8 Oct 2015 14:58:58 +1100
Message-Id: <1444276739-20372-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the logic of pnv_eeh_cap_start() to pnv_eeh_find_cap()
as the function is only called by pnv_eeh_find_cap(). The logic
of both functions are pretty simple. No need to have separate
functions.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 2032936..2b5c70b 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -281,29 +281,20 @@ static int pnv_eeh_post_init(void)
 	return ret;
 }
 
-static int pnv_eeh_cap_start(struct pci_dn *pdn)
+static int pnv_eeh_find_cap(struct pci_dn *pdn, int cap)
 {
-	u32 status;
+	int pos = PCI_CAPABILITY_LIST;
+	int cnt = 48;   /* Maximal number of capabilities */
+	u32 status, id;
 
 	if (!pdn)
 		return 0;
 
+	/* Check if the device supports capabilities */
 	pnv_pci_cfg_read(pdn, PCI_STATUS, 2, &status);
 	if (!(status & PCI_STATUS_CAP_LIST))
 		return 0;
 
-	return PCI_CAPABILITY_LIST;
-}
-
-static int pnv_eeh_find_cap(struct pci_dn *pdn, int cap)
-{
-	int pos = pnv_eeh_cap_start(pdn);
-	int cnt = 48;   /* Maximal number of capabilities */
-	u32 id;
-
-	if (!pos)
-		return 0;
-
 	while (cnt--) {
 		pnv_pci_cfg_read(pdn, pos, 1, &pos);
 		if (pos < 0x40)
-- 
2.1.0
