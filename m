Return-Path: <srs0=bna+=fe=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zddGp3ZRdzF0Zd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 14:49:38 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zddGp0WkDz8vqJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 14:49:38 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zddGn45Fwz9sQm
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2018 14:49:37 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1A3mmZv003796
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2018 22:49:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1q37tufr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 09 Feb 2018 22:49:35 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 22:49:34 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
Date: Fri,  9 Feb 2018 19:49:25 -0800
In-Reply-To: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When VAS is not configured in the system, make sure to remove
the VAS debugfs directory and unregister the platform driver.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-debug.c | 5 +++++
 arch/powerpc/platforms/powernv/vas.c       | 5 ++++-
 arch/powerpc/platforms/powernv/vas.h       | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index b4de4c6..e6e4067 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -207,3 +207,8 @@ void vas_init_dbgdir(void)
 	if (IS_ERR(vas_debugfs))
 		vas_debugfs = NULL;
 }
+
+void vas_cleanup_dbgdir(void)
+{
+	debugfs_remove_recursive(vas_debugfs);
+}
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index aebbe95..f83e27d8 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -169,8 +169,11 @@ static int __init vas_init(void)
 		found++;
 	}
 
-	if (!found)
+	if (!found) {
+		platform_driver_unregister(&vas_driver);
+		vas_cleanup_dbgdir();
 		return -ENODEV;
+	}
 
 	pr_devel("Found %d instances\n", found);
 
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index ae0100f..2645613 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -406,6 +406,7 @@ extern struct mutex vas_mutex;
 
 extern struct vas_instance *find_vas_instance(int vasid);
 extern void vas_init_dbgdir(void);
+extern void vas_cleanup_dbgdir(void);
 extern void vas_instance_init_dbgdir(struct vas_instance *vinst);
 extern void vas_window_init_dbgdir(struct vas_window *win);
 extern void vas_window_free_dbgdir(struct vas_window *win);
-- 
2.7.4
