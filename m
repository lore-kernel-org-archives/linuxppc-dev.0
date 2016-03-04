Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 396191A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 16:02:06 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 10:32:02 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2451v3u47906838
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:31:57 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24AUxkX021318
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:01:02 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] Fix misleading comment in early_setup_secondary
Date: Fri,  4 Mar 2016 10:31:48 +0530
Message-Id: <1457067709-15720-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current comment in the early_setup_secondary() for
paca->soft_enabled update is misleading. Comment should say to
Mark interrupts "disabled" insteads of "enable".
Patch to fix the typo.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5c03a6a9b054..c2b2e72042cf 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -323,7 +323,7 @@ void __init early_setup(unsigned long dt_ptr)
 #ifdef CONFIG_SMP
 void early_setup_secondary(void)
 {
-	/* Mark interrupts enabled in PACA */
+	/* Mark interrupts disabled in PACA */
 	get_paca()->soft_enabled = 0;
 
 	/* Initialize the hash table or TLB handling */
-- 
1.9.1
