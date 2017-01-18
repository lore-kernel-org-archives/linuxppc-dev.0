Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3jPH4CCFzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:10:27 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0IN8cPn072951
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 18:10:24 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 282f5jwhjg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 18:10:24 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 19 Jan 2017 09:10:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 06C313578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:10:19 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0INAIhW2163138
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:10:18 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0INAIGL031672
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:10:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 stable@vger.kernel.org, #3.18+@gwshan.ozlabs.ibm.com
Subject: [PATCH v2] powerpc/eeh: Fix wrong flag passed to eeh_unfreeze_pe()
Date: Thu, 19 Jan 2017 10:10:16 +1100
Message-Id: <1484781016-13379-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __eeh_clear_pe_frozen_state(), we should pass the flag's value
instead of its address to eeh_unfreeze_pe(). The isolated flag is
cleared if no error returned from __eeh_clear_pe_frozen_state().
We never observed the error from the function. So the isolated flag
should have been always cleared, no real issue is caused because
of the misused @flag.

This fixes the code by passing the value of @flag to eeh_unfreeze_pe().

Cc: stable@vger.kernel.org #3.18+
Fixes: 5cfb20b96f6 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Improved changelog and dereference @flag for once
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index d88573b..b948871 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -545,7 +545,7 @@ static void *eeh_pe_detach_dev(void *data, void *userdata)
 static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
-	bool *clear_sw_state = flag;
+	bool clear_sw_state = *(bool *)flag;
 	int i, rc = 1;
 
 	for (i = 0; rc && i < 3; i++)
-- 
2.7.4
