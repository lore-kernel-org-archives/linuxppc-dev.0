Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38E721A0725
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 09:22:52 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 1 Sep 2015 04:52:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5724D125801A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 04:52:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7VNMkuk41353254
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2015 04:52:46 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7VNMk6r032441
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2015 04:52:46 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH] asm/opal-api: Assign numbers to OPAL_MSG macros of enum
 opal_msg_type
Date: Tue,  1 Sep 2015 04:52:43 +0530
Message-Id: <1441063363-24107-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch assigns numbers to OPAL_MSG macros of enum opal_msg_type
to prevent accidental insertion of any new value in between and thus
break OPAL API. This is also helpful while backporting mainline kernel
changes to distros which run downlevel kernel and thus don't have all
OPAL messages defined, avoiding unnecessary bugs due to enum values
order mismatch.

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e9e4c52..b53f9b3 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -352,15 +352,15 @@ enum OpalLPCAddressType {
 };
 
 enum opal_msg_type {
-	OPAL_MSG_ASYNC_COMP = 0,	/* params[0] = token, params[1] = rc,
+	OPAL_MSG_ASYNC_COMP	= 0,	/* params[0] = token, params[1] = rc,
 					 * additional params function-specific
 					 */
-	OPAL_MSG_MEM_ERR,
-	OPAL_MSG_EPOW,
-	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
-	OPAL_MSG_HMI_EVT,
-	OPAL_MSG_DPO,
-	OPAL_MSG_PRD,
+	OPAL_MSG_MEM_ERR	= 1,
+	OPAL_MSG_EPOW		= 2,
+	OPAL_MSG_SHUTDOWN	= 3,	/* params[0] = 1 reboot, 0 shutdown */
+	OPAL_MSG_HMI_EVT	= 4,
+	OPAL_MSG_DPO		= 5,
+	OPAL_MSG_PRD		= 6,
 	OPAL_MSG_TYPE_MAX,
 };
 
-- 
1.9.3
