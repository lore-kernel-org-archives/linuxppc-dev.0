Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DCE11A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:53:30 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 21:53:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5866E2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:53:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1TBrE573211746
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:53:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1TBqoK2028167
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:52:50 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH] powerpc/lpar: Don't crash on H_PROTECT errors
Date: Mon, 29 Feb 2016 17:22:32 +0530
Message-Id: <1456746752-9298-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are certain condition in which H_PROTECT can return error code
other than H_NOT_FOUND and H_SUCCESS. One such being an attempt to
update an hpte owned by adjunct partition. Return 0 in that case so
that user space will retry the access. In adjunct case this mean we
will not make much progress in the user space. But atleast we get a
chance to kill the task and avoid taking down the entire box.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 477290a..31bcdaf 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -310,7 +310,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 
 	pr_devel("ok\n");
 
-	BUG_ON(lpar_rc != H_SUCCESS);
+	WARN_RATELIMIT(lpar_rc != H_SUCCESS, "H_PROTECT returned %lu\n", lpar_rc);
 
 	return 0;
 }
-- 
2.1.0
