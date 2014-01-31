Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 77E692C0327
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 10:58:24 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 16:58:22 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4A0551FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:58:19 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s0VNw2mR9306454
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Feb 2014 00:58:02 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VNwICD013192
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:58:19 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/3] powerpc/pseries: Update dynamic cache nodes for
 suspend/resume operation
Date: Fri, 31 Jan 2014 15:58:11 -0800
Message-Id: <1391212692-16217-3-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Haren Myneni <hbabu@us.ibm.com>

pHyp can change cache nodes for suspend/resume operation. The current code
updates the device tree after all non boot CPUs are enabled. Hence, we do not
modify the cache list based on the latest cache nodes. Also we do not remove
cache entries for the primary CPU.

This patch removes the cache list for the boot CPU, updates the device tree
before enabling nonboot CPUs and adds cache list for the boot cpu.

Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h          |  1 +
 arch/powerpc/platforms/pseries/suspend.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 9bd52c6..a0e1add 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -283,6 +283,7 @@ extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
 #ifdef CONFIG_PPC_PSERIES
 extern int pseries_devicetree_update(s32 scope);
+extern void post_mobility_fixup(void);
 #endif
 
 #ifdef CONFIG_PPC_RTAS_DAEMON
diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index 16a2552..1d9c580 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -26,6 +26,7 @@
 #include <asm/mmu.h>
 #include <asm/rtas.h>
 #include <asm/topology.h>
+#include "../../kernel/cacheinfo.h"
 
 static u64 stream_id;
 static struct device suspend_dev;
@@ -79,6 +80,23 @@ static int pseries_suspend_cpu(void)
 }
 
 /**
+ * pseries_suspend_enable_irqs
+ *
+ * Post suspend configuration updates
+ *
+ **/
+static void pseries_suspend_enable_irqs(void)
+{
+	/*
+	 * Update configuration which can be modified based on device tree
+	 * changes during resume.
+	 */
+	cacheinfo_cpu_offline(smp_processor_id());
+	post_mobility_fixup();
+	cacheinfo_cpu_online(smp_processor_id());
+}
+
+/**
  * pseries_suspend_enter - Final phase of hibernation
  *
  * Return value:
@@ -235,6 +253,7 @@ static int __init pseries_suspend_init(void)
 		return rc;
 
 	ppc_md.suspend_disable_cpu = pseries_suspend_cpu;
+	ppc_md.suspend_enable_irqs = pseries_suspend_enable_irqs;
 	suspend_set_ops(&pseries_suspend_ops);
 	return 0;
 }
-- 
1.7.12.2
