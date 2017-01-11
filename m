Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyvFT56kHzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 14:17:01 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B3EYYA063047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 22:16:59 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27w8j4rp6b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 22:16:59 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 13:16:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 887F42BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 14:16:52 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0B3GqZN54198446
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 14:16:52 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0B3Gp4B003362
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 14:16:52 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, ruscur@russell.cc,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org,
 #3.18+@gwshan.ozlabs.ibm.com
Subject: [PATCH] powerpc/eeh: Fix wrong flag passed to eeh_unfreeze_pe()
Date: Wed, 11 Jan 2017 14:16:49 +1100
Message-Id: <1484104609-22129-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __eeh_clear_pe_frozen_state(), we should pass the flag's value
instead of its address to eeh_unfreeze_pe(). This doesn't introduce
any problems, but the code is just wrong.

This fixes the code by passing flag's value to eeh_unfreeze_pe().

Cc: stable@vger.kernel.org #3.18+
Fixes: 5cfb20b96f6 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index d88573b..fa15fa6 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -549,7 +549,7 @@ static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
 	int i, rc = 1;
 
 	for (i = 0; rc && i < 3; i++)
-		rc = eeh_unfreeze_pe(pe, clear_sw_state);
+		rc = eeh_unfreeze_pe(pe, *clear_sw_state);
 
 	/* Stop immediately on any errors */
 	if (rc) {
-- 
2.7.4
