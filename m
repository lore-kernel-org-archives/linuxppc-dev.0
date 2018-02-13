Return-Path: <srs0=prwo=fh=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgtWl1YK1zF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 06:53:39 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zgtWj65NHz8tCv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 06:53:37 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zgtWh4B9Bz9t3R
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2018 06:53:36 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1DJoqao022380
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2018 14:53:34 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g43cmygfk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2018 14:53:34 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 14:53:33 -0500
Date: Tue, 13 Feb 2018 11:53:27 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix cleanup when VAS is not configured
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20180213195327.GA10678@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 11:49:06 -0600
Subject: [PATCH 1/1] powerpc/vas: Fix cleanup when VAS is not configured

When VAS is not configured, unregister the platform driver. Also simplify
cleanup by delaying vas debugfs init until we know VAS is configured.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v2]
	- [Michael Ellerman] Move vas_init_dbgdir() into a lower level
	  function to keep vas_init() cleaner.
---
 arch/powerpc/platforms/powernv/vas-debug.c | 11 +++++++++++
 arch/powerpc/platforms/powernv/vas.c       |  6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index b4de4c6..4f7276e 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -179,6 +179,7 @@ void vas_instance_init_dbgdir(struct vas_instance *vinst)
 {
 	struct dentry *d;
 
+	vas_init_dbgdir();
 	if (!vas_debugfs)
 		return;
 
@@ -201,8 +202,18 @@ void vas_instance_init_dbgdir(struct vas_instance *vinst)
 	vinst->dbgdir = NULL;
 }
 
+/*
+ * Set up the "root" VAS debugfs dir. Return if we already set it up
+ * (or failed to) in an earlier instance of VAS.
+ */
 void vas_init_dbgdir(void)
 {
+	static bool first_time = true;
+
+	if (!first_time)
+		return;
+
+	first_time = false;
 	vas_debugfs = debugfs_create_dir("vas", NULL);
 	if (IS_ERR(vas_debugfs))
 		vas_debugfs = NULL;
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index aebbe95..5a2b24c 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -160,8 +160,6 @@ static int __init vas_init(void)
 	int found = 0;
 	struct device_node *dn;
 
-	vas_init_dbgdir();
-
 	platform_driver_register(&vas_driver);
 
 	for_each_compatible_node(dn, NULL, "ibm,vas") {
@@ -169,8 +167,10 @@ static int __init vas_init(void)
 		found++;
 	}
 
-	if (!found)
+	if (!found) {
+		platform_driver_unregister(&vas_driver);
 		return -ENODEV;
+	}
 
 	pr_devel("Found %d instances\n", found);
 
-- 
2.7.4
