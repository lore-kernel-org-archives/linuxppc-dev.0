Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C86F1A05F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 12:08:42 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 18:08:39 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BDE721FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 17:56:47 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tBB18akK31260794
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:08:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB18agP013371
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:08:36 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?q?=E8=92=B2=E6=96=87?= <wen.pu@powercore.com.cn>
Subject: [PATCH] powerpc/powernv: pr_warn_once on unsupported OPAL_MSG type
Date: Fri, 11 Dec 2015 12:08:23 +1100
Message-Id: <1449796103-7700-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running on newer OPAL firmware that supports sending extra
OPAL_MSG types, we would print a warning on *every* message received.

This could be a problem for kernels that don't support OPAL_MSG_OCC
on machines that are running real close to thermal limits and the
OCC is throttling the chip. For a kernel that is paying attention to
the message queue, we could get these notifications quite often.

Conceivably, future message types could also come fairly often,
and printing that we didn't understand them 10,000 times provides
no further information than printing them once.

Cc: stable@vger.kernel.org
Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 4296d55e88f3..57cffb80bc36 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -278,7 +278,7 @@ static void opal_handle_message(void)
 
 	/* Sanity check */
 	if (type >= OPAL_MSG_TYPE_MAX) {
-		pr_warning("%s: Unknown message type: %u\n", __func__, type);
+		pr_warn_once("%s: Unknown message type: %u\n", __func__, type);
 		return;
 	}
 	opal_message_do_notify(type, (void *)&msg);
-- 
2.1.4
