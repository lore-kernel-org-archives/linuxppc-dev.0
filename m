Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrxJz1XMtzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:28:35 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 18:58:30 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MDSRRa2490680
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 18:58:27 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MDSPnX014933
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 18:58:27 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc/eeh: Drop unnecessary label in
 eeh_pe_change_owner()
Date: Fri, 22 Apr 2016 23:28:04 +1000
Message-Id: <1461331687-1069-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The label "reset" in eeh_pe_change_owner() is used only for once.
No need to keep it and just drop it. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Russell Currey <ruscur@russell.cc>
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
