Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfhWM3NqpzDqy3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:17:19 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TCFUkc108536
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:17:17 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v6yd70jb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:17:17 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 29 Jun 2016 22:17:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 029472CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:17:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TCHCMo7012720
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:17:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TCHC8C020778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:17:12 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 2/2] cxl: Fix allocating a minimum of 2 pages for the SPA
Date: Wed, 29 Jun 2016 22:16:26 +1000
In-Reply-To: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
References: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467202586-13412-2-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The Scheduled Process Area is allocated dynamically with enough pages to
fit at least as many processes as the AFU descriptor indicated. Since
the calculation is non-trivial, it does this by calculating how many
processes could fit in an allocation of a given order, and increasing
that order until it can fit enough processes or hits the maximum
supported size.

Currently, it will start this search using a SPA of 2 pages instead of
1. This can waste a page of memory if the AFU's maximum number of
supported processes was small enough to fit in one page.

Fix the algorithm to start the search at 1 page.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index e80d8f7..120c468 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -189,7 +189,7 @@ int cxl_alloc_spa(struct cxl_afu *afu)
 	unsigned spa_size;
 
 	/* Work out how many pages to allocate */
-	afu->native->spa_order = 0;
+	afu->native->spa_order = -1;
 	do {
 		afu->native->spa_order++;
 		spa_size = (1 << afu->native->spa_order) * PAGE_SIZE;
-- 
2.8.1
