Return-Path: <jeff.liu@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7EBA1A02C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 00:31:23 +1000 (EST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s5HEVLYZ007927
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 14:31:21 GMT
Message-ID: <53A0512D.1090909@oracle.com>
Date: Tue, 17 Jun 2014 22:31:09 +0800
From: Jeff Liu <jeff.liu@oracle.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 04/24] powerpc: check/return actual error on sysfs functions
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jie Liu <jeff.liu@oracle.com>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Jie Liu <jeff.liu@oracle.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 2 +-
 arch/powerpc/platforms/powernv/opal-elog.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 788a197..e718baf 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -424,7 +424,7 @@ void __init opal_platform_dump_init(void)
 	int rc;
 
 	dump_kset = kset_create_and_add("dump", NULL, opal_kobj);
-	if (!dump_kset) {
+	if (IS_ERR(dump_kset)) {
 		pr_warn("%s: Failed to create dump kset\n", __func__);
 		return;
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 10268c4..09c1f6f 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -296,9 +296,9 @@ int __init opal_elog_init(void)
 	int rc = 0;
 
 	elog_kset = kset_create_and_add("elog", NULL, opal_kobj);
-	if (!elog_kset) {
+	if (IS_ERR(elog_kset)) {
 		pr_warn("%s: failed to create elog kset\n", __func__);
-		return -1;
+		return PTR_ERR(elog_kset);
 	}
 
 	rc = opal_notifier_register(&elog_nb);
-- 
1.8.3.2
