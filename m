Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrHFs0MSpzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:53:36 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 17:23:32 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LBrU7X8847690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 17:23:30 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LHLRTm017436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 22:51:30 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/eeh: Drop unnecessary label in
 eeh_pe_change_owner()
Date: Thu, 21 Apr 2016 21:53:07 +1000
Message-Id: <1461239595-5627-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The label "reset" in eeh_pe_change_owner() is used only for once.
No need to keep it and just drop it. No logicial changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6544017..4b40d56 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1336,14 +1336,11 @@ static int eeh_pe_change_owner(struct eeh_pe *pe)
 			    id->subdevice != pdev->subsystem_device)
 				continue;
 
-			goto reset;
+			return eeh_pe_reset_and_recover(pe);
 		}
 	}
 
 	return eeh_unfreeze_pe(pe, true);
-
-reset:
-	return eeh_pe_reset_and_recover(pe);
 }
 
 /**
-- 
2.1.0
