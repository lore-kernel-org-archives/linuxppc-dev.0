Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 580691A0B7D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 14:19:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 9 Mar 2015 13:19:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 16EE93578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 14:19:31 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t293JLgX49020960
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 14:19:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t293Iu7W029902
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 14:18:56 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH 3/4] powerpc/eeh: fix powernv_eeh_wait_state delay logic
Date: Mon,  9 Mar 2015 11:17:31 +0800
Message-Id: <1425871052-13118-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 5abb4c2..af1be8f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -334,13 +334,13 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
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
