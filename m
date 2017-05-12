Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPPd94Yd0zDqc6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 19:22:21 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4C9KZ4J175745
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:22:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ad72ms4dw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:22:18 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 12 May 2017 03:22:18 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv:idle: Set NAPSTATELOST after recovering paca on P9 DD1
Date: Fri, 12 May 2017 14:52:06 +0530
Message-Id: <1494580926-17590-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

commit 17ed4c8f81da ("powerpc/powernv: Recover correct PACA on wakeup
from a stop on P9 DD1") promises to set the NAPSTATELOST bit in paca
after recovering the correct paca for the thread waking up from stop1
on DD1, so that the GPRs can be correctly restored on the stop exit
path. However, it loads the value 1 into r3, but stores the value in
r0 into NAPSTATELOST(r13).

Fix this by correctly set the NAPSTATELOST bit in paca after
recovering the paca on POWER9 DD1.

Fixes: commit 17ed4c8f81da ("powerpc/powernv: Recover correct PACA on wakeup
from a stop on P9 DD1")

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_book3s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 07d4e0a..4898d67 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -416,7 +416,7 @@ power9_dd1_recover_paca:
 	 * which needs to be restored from the stack.
 	 */
 	li	r3, 1
-	stb	r0,PACA_NAPSTATELOST(r13)
+	stb	r3,PACA_NAPSTATELOST(r13)
 	blr
 
 /*
-- 
1.9.4
