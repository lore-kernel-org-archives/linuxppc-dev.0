Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rX5GQ0sMPzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jun 2016 04:28:12 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5IIOBfw091100
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 14:28:10 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mc5bs8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 14:28:10 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 18 Jun 2016 12:28:09 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH V2] powerpc/mm: Don't do debug print before we do feature fixup
Date: Sat, 18 Jun 2016 23:57:59 +0530
Message-Id: <1466274479-5650-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use feature fixup in segment and page fault path and hence we should
not call any function that can cause either of these before we finish
feature fixup.

Calling into early debug routine can result in segment fault as updated
in https://lkml.kernel.org/r/CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com

Avoid the segment fault by removing the debug print. Also remove the
matching closing debug print at the end of the function.

Even though the problem existed for a long time, this became more apparent
after commit caca285e5ab4 ("powerpc/mm/radix: Use STD_MMU_64 to properly
isolate hash related code"). Before that commit we used to use feature
fixup to finalize code path related to 1T and 256MB segment.

Cc: Denis Kirjanov <kda@linux-powerpc.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* update commit message
* update Cc: list with correct email address

 arch/powerpc/kernel/setup_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8222950f820f..da98f532d160 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -466,7 +466,6 @@ static void __init initialize_cache_info(void)
  */
 void __init setup_system(void)
 {
-	DBG(" -> setup_system()\n");
 
 	/* Apply the CPUs-specific and firmware specific fixups to kernel
 	 * text (nop out sections not relevant to this CPU or this firmware)
@@ -584,7 +583,6 @@ void __init setup_system(void)
 		       (unsigned long long)PHYSICAL_START);
 	pr_info("-----------------------------------------------------\n");
 
-	DBG(" <- setup_system()\n");
 }
 
 /* This returns the limit below which memory accesses to the linear
-- 
2.7.4
