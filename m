Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 734A72C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 17:49:34 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 12 Nov 2013 01:49:29 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 768AB38C8027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:49:26 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAC6nRZS8782292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 06:49:27 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAC6nRuB011213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:49:27 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/eeh: More accurate log
Date: Tue, 12 Nov 2013 14:49:22 +0800
Message-Id: <1384238962-13170-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1384238962-13170-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1384238962-13170-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We possibly has fenced PHB except frozen PE. So the output log
doesn't cover all cases and the patch fixes it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_event.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index d27c5af..72d748b 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -74,8 +74,13 @@ static int eeh_event_handler(void * dummy)
 		pe = event->pe;
 		if (pe) {
 			eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
-			pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
-				 pe->phb->global_number, pe->addr);
+			if (pe->type & EEH_PE_PHB)
+				pr_info("EEH: Detected error on PHB#%d\n",
+					 pe->phb->global_number);
+			else
+				pr_info("EEH: Detected PCI bus error on "
+					"PHB#%d-PE#%x\n",
+					pe->phb->global_number, pe->addr);
 			eeh_handle_event(pe);
 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		} else {
-- 
1.7.9.5
