Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 240B21A1036
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 11:27:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3456A2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:39 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R1RUBI33423556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R1R5AY008400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:27:05 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH V2 3/4] powerpc/eeh: fix powernv_eeh_wait_state delay logic
Date: Mon, 27 Apr 2015 09:25:11 +0800
Message-Id: <1430097912-6207-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1430097912-6207-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1430097912-6207-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As the comment indicates, powernv_eeh_get_state() will inform EEH core to
delay 1 second. This means the delay doesn't happen when
powernv_eeh_get_state() returns.

This patch moves the delay subtraction just before msleep(), which is the
same logic in pseries_eeh_wait_state().

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index d025471..622f08c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1000,13 +1000,13 @@ static int pnv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 		if (ret != EEH_STATE_UNAVAILABLE)
 			return ret;
 
-		max_wait -= mwait;
 		if (max_wait <= 0) {
 			pr_warn("%s: Timeout getting PE#%x's state (%d)\n",
 				__func__, pe->addr, max_wait);
 			return EEH_STATE_NOT_SUPPORT;
 		}
 
+		max_wait -= mwait;
 		msleep(mwait);
 	}
 
-- 
1.7.9.5
