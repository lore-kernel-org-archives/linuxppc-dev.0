Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AE761A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:38:56 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CFDC140170
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:38:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0FB0D2BB005A
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMcreq6291592
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMcqCs015272
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/powernv: Avoid do complete reset for twice
Date: Tue, 25 Nov 2014 09:38:45 +1100
Message-Id: <1416868727-5814-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PHB complete reset case, EEH_RESET_DEACTIVATE followed by
EEH_RESET_{HOT,FUNDAMENTAL} requests are issued by EEH core.
All of them are translated to raising complete reset wrongly
and we did complete reset for twice unnecessarily for each
transaction.

The patch fixes above issue by translating the request properly.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 3b82384..d02a696 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -697,8 +697,13 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	 * reset. The side effect is that EEH core has to clear the frozen
 	 * state explicitly after BAR restore.
 	 */
-	if (pe->type & EEH_PE_PHB)
-		return ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
+	if (pe->type & EEH_PE_PHB) {
+		if (option == EEH_RESET_HOT ||
+		    option == EEH_RESET_FUNDAMENTAL)
+			return ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
+
+		return ioda_eeh_phb_reset(hose, option);
+	}
 
 	/*
 	 * The frozen PE might be caused by PAPR error injection
-- 
1.8.3.2
