Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LPzF4LKxzF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 01:28:57 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w64FSjIV036672
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 11:28:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k0wb5sf1q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 11:28:54 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Wed, 4 Jul 2018 16:28:52 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] cxl: Fix wrong comparison in cxl_adapter_context_get()
Date: Wed,  4 Jul 2018 20:58:33 +0530
Message-Id: <20180704152833.2288-1-vaibhav@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function atomic_inc_unless_negative() returns a bool to indicate
success/failure. However cxl_adapter_context_get() wrongly compares
the return value against '>=0' which will always be true. The patch
fixes this comparison to '==0' there by also fixing this compile time
warning:

	drivers/misc/cxl/main.c:290 cxl_adapter_context_get()
	warn: 'atomic_inc_unless_negative(&adapter->contexts_num)' is unsigned

Cc: stable@vger.kernel.org
Fixes: 70b565bbdb91 ("cxl: Prevent adapter reset if an active context exists")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/misc/cxl/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index c1ba0d42cbc8..e0f29b8a872d 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -287,7 +287,7 @@ int cxl_adapter_context_get(struct cxl *adapter)
 	int rc;
 
 	rc = atomic_inc_unless_negative(&adapter->contexts_num);
-	return rc >= 0 ? 0 : -EBUSY;
+	return rc ? 0 : -EBUSY;
 }
 
 void cxl_adapter_context_put(struct cxl *adapter)
-- 
2.17.1
