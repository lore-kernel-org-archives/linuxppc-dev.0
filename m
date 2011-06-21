Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0E12B6FD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 23:34:40 +1000 (EST)
Received: by pwi18 with SMTP id 18so1024095pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 06:34:37 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: improve error code on reconfiguration notifier
	failure
Date: Tue, 21 Jun 2011 22:35:56 +0900
Message-Id: <1308663356-20957-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1308663356-20957-1-git-send-email-akinobu.mita@gmail.com>
References: <1308663356-20957-1-git-send-email-akinobu.mita@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reconfiguration notifier call for device node may fail by several reasons,
but it always assumes kmalloc failures.

This enables reconfiguration notifier call chain to get the actual error
code rather than -ENOMEM by converting all reconfiguration notifier calls
to return encapsulate error code with notifier_from_errno().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/prom.c                      |    8 +++-----
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   10 +++-------
 arch/powerpc/platforms/pseries/hotplug-memory.c |   16 +++++-----------
 arch/powerpc/platforms/pseries/reconfig.c       |    4 +---
 4 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 8c3112a..86677ba 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -862,16 +862,14 @@ static int prom_reconfig_notifier(struct notifier_block *nb,
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
 		err = of_finish_dynamic_node(node);
-		if (err < 0) {
+		if (err < 0)
 			printk(KERN_ERR "finish_node returned %d\n", err);
-			err = NOTIFY_BAD;
-		}
 		break;
 	default:
-		err = NOTIFY_DONE;
+		err = 0;
 		break;
 	}
-	return err;
+	return notifier_from_errno(err);
 }
 
 static struct notifier_block prom_reconfig_nb = {
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 46f13a3..bc02885 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -330,21 +330,17 @@ static void pseries_remove_processor(struct device_node *np)
 static int pseries_smp_notifier(struct notifier_block *nb,
 				unsigned long action, void *node)
 {
-	int err = NOTIFY_OK;
+	int err = 0;
 
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
-		if (pseries_add_processor(node))
-			err = NOTIFY_BAD;
+		err = pseries_add_processor(node);
 		break;
 	case PSERIES_RECONFIG_REMOVE:
 		pseries_remove_processor(node);
 		break;
-	default:
-		err = NOTIFY_DONE;
-		break;
 	}
-	return err;
+	return notifier_from_errno(err);
 }
 
 static struct notifier_block pseries_smp_nb = {
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 33867ec..1eaefd6 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -197,27 +197,21 @@ static int pseries_drconf_memory(unsigned long *base, unsigned int action)
 static int pseries_memory_notifier(struct notifier_block *nb,
 				unsigned long action, void *node)
 {
-	int err = NOTIFY_OK;
+	int err = 0;
 
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
-		if (pseries_add_memory(node))
-			err = NOTIFY_BAD;
+		err = pseries_add_memory(node);
 		break;
 	case PSERIES_RECONFIG_REMOVE:
-		if (pseries_remove_memory(node))
-			err = NOTIFY_BAD;
+		err = pseries_remove_memory(node);
 		break;
 	case PSERIES_DRCONF_MEM_ADD:
 	case PSERIES_DRCONF_MEM_REMOVE:
-		if (pseries_drconf_memory(node, action))
-			err = NOTIFY_BAD;
-		break;
-	default:
-		err = NOTIFY_DONE;
+		err = pseries_drconf_memory(node, action);
 		break;
 	}
-	return err;
+	return notifier_from_errno(err);
 }
 
 static struct notifier_block pseries_mem_nb = {
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 286b6af..168651a 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -114,9 +114,7 @@ int pSeries_reconfig_notify(unsigned long action, void *p)
 	int err = blocking_notifier_call_chain(&pSeries_reconfig_chain,
 						action, p);
 
-	if (err == NOTIFY_BAD)
-		return -ENOMEM; /* For now, safe to assume kmalloc failure */
-	return 0;
+	return notifier_to_errno(err);
 }
 
 static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
-- 
1.7.4.4
