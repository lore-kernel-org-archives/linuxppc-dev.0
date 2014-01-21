Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00A112C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 10:02:56 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 21 Jan 2014 16:02:54 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AE6D119D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:02:42 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0LL0Qx86750714
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 22:00:26 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0LN2pex012290
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:02:52 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/pseries: Update dynamic cache nodes for
 suspend/resume operation
Date: Tue, 21 Jan 2014 17:55:48 -0500
Message-Id: <1390344949-3983-3-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1390344949-3983-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1390344949-3983-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pHyp can change cache nodes for suspend/resume operation. The current code
updates the device tree after all non boot CPUs are enabled. Hence, we do not
modify the cache list based on the latest cache nodes. Also we do not remove
cache entries for the primary CPU.

This patch removes the cache list for the boot CPU, updates the device tree
before enabling nonboot CPUs and adds cache list for the boot cpu.

Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |  4 ++++
 arch/powerpc/kernel/rtas.c      | 17 +++++++++++++++++
 arch/powerpc/kernel/time.c      |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 9bd52c6..da9d733 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -283,6 +283,10 @@ extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
 #ifdef CONFIG_PPC_PSERIES
 extern int pseries_devicetree_update(s32 scope);
+extern void post_mobility_fixup(void);
+extern void update_dynamic_configuration(void);
+#else /* !CONFIG_PPC_PSERIES */
+void update_dynamic_configuration(void) { }
 #endif
 
 #ifdef CONFIG_PPC_RTAS_DAEMON
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 4cf674d..8249eb2 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -43,6 +43,7 @@
 #include <asm/time.h>
 #include <asm/mmu.h>
 #include <asm/topology.h>
+#include "cacheinfo.h"
 
 struct rtas_t rtas = {
 	.lock = __ARCH_SPIN_LOCK_UNLOCKED
@@ -972,6 +973,22 @@ out:
 	free_cpumask_var(offline_mask);
 	return atomic_read(&data.error);
 }
+
+/*
+ * The device tree cache nodes can be modified during suspend/ resume.
+ * So delete all cache entries and recreate them again after the device tree
+ * update.
+ * We already deleted cache entries for notboot CPUs before suspend. So delete
+ * entries for the primary CPU, recreate entries after the device tree update.
+ * We can create entries for nonboot CPU when enable them later.
+ */
+
+void update_dynamic_configuration(void)
+{
+	cacheinfo_cpu_offline(smp_processor_id());
+	post_mobility_fixup();
+	cacheinfo_cpu_online(smp_processor_id());
+}
 #else /* CONFIG_PPC_PSERIES */
 int rtas_ibm_suspend_me(struct rtas_args *args)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b3b1441..5f1ca28 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -69,6 +69,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/firmware.h>
 #include <asm/cputime.h>
+#include <asm/rtas.h>
 
 /* powerpc clocksource/clockevent code */
 
@@ -592,6 +593,11 @@ void arch_suspend_enable_irqs(void)
 	generic_suspend_enable_irqs();
 	if (ppc_md.suspend_enable_irqs)
 		ppc_md.suspend_enable_irqs();
+	/*
+	 * Update configuration which can be modified based on devicetree
+	 * changes during resume.
+	 */
+	update_dynamic_configuration();
 }
 #endif
 
-- 
1.7.12.4
