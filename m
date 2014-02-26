Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 349C62C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 15:02:27 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 23:02:25 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3FA1138C8027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 23:02:23 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1Q42Nja6947186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 04:02:23 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q42M1F007236
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 23:02:22 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [prefix=PATCH v5 2/3] powerpc/pseries: Update dynamic cache nodes for
 suspend/resume operation
Date: Tue, 25 Feb 2014 20:02:18 -0800
Message-Id: <1393387338-1800-1-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1392843415-17153-3-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1392843415-17153-3-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Haren Myneni <hbabu@us.ibm.com>

pHyp can change cache nodes for suspend/resume operation. Currently the
device tree is updated by drmgr in userspace after all non boot CPUs are
enabled. Hence, we do not modify the cache list based on the latest cache
nodes. Also we do not remove cache entries for the primary CPU.

This patch removes the cache list for the boot CPU, updates the device tree
before enabling nonboot CPUs and adds cache list for the boot cpu.

This patch also has the side effect that older versions of drmgr will
perform a second device tree update from userspace. While this is a
redundant waste of a couple cycles it is harmless since firmware returns the
same data for the subsequent update-nodes/properties rtas calls.

Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---

Changes from v4:
- fixes build break for !SMP configs.
 

 arch/powerpc/include/asm/rtas.h          |  1 +
 arch/powerpc/kernel/cacheinfo.c          |  7 +++++--
 arch/powerpc/platforms/pseries/suspend.c | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 2912b87..40198d5 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -756,7 +756,10 @@ void cacheinfo_cpu_online(unsigned int cpu_id)
 	cacheinfo_sysfs_populate(cpu_id, cache);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU /* functions needed for cpu offline */
+/* functions needed to remove cache entry for cpu offline or suspend/resume */
+
+#if (defined(CONFIG_PPC_PSERIES) && defined(CONFIG_SUSPEND)) || \
+    defined(CONFIG_HOTPLUG_CPU)
 
 static struct cache *cache_lookup_by_cpu(unsigned int cpu_id)
 {
@@ -843,4 +846,4 @@ void cacheinfo_cpu_offline(unsigned int cpu_id)
 	if (cache)
 		cache_cpu_clear(cache, cpu_id);
 }
-#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* (CONFIG_PPC_PSERIES && CONFIG_SUSPEND) || CONFIG_HOTPLUG_CPU */
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
