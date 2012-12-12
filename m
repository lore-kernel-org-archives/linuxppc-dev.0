Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 128FE2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 11:17:11 +1100 (EST)
Message-ID: <1355353492.19932.59.camel@pasglop>
Subject: [PATCH] powerpc+of: Rename and fix OF reconfig notifier error
 inject module
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 13 Dec 2012 10:04:52 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This module used to inject errors in the pSeries specific dynamic
reconfiguration notifiers. Those are gone however, replaced by
generic notifiers for changes to the device-tree. So let's update
the module to deal with these instead and rename it along the way.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 lib/Kconfig.debug                            |   10 ++---
 lib/Makefile                                 |    4 +-
 lib/of-reconfig-notifier-error-inject.c      |   51 ++++++++++++++++++++++++++
 lib/pSeries-reconfig-notifier-error-inject.c |   51 --------------------------
 4 files changed, 58 insertions(+), 58 deletions(-)
 create mode 100644 lib/of-reconfig-notifier-error-inject.c
 delete mode 100644 lib/pSeries-reconfig-notifier-error-inject.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 28e9d6c9..c2d89f3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1192,14 +1192,14 @@ config MEMORY_NOTIFIER_ERROR_INJECT
 
 	  If unsure, say N.
 
-config PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT
-	tristate "pSeries reconfig notifier error injection module"
-	depends on PPC_PSERIES && NOTIFIER_ERROR_INJECTION
+config OF_RECONFIG_NOTIFIER_ERROR_INJECT
+	tristate "OF reconfig notifier error injection module"
+	depends on OF_DYNAMIC && NOTIFIER_ERROR_INJECTION
 	help
 	  This option provides the ability to inject artifical errors to
-	  pSeries reconfig notifier chain callbacks.  It is controlled
+	  OF reconfig notifier chain callbacks.  It is controlled
 	  through debugfs interface under
-	  /sys/kernel/debug/notifier-error-inject/pSeries-reconfig/
+	  /sys/kernel/debug/notifier-error-inject/OF-reconfig/
 
 	  If the notifier call chain should be failed with some events
 	  notified, write the error code to "actions/<notifier event>/error".
diff --git a/lib/Makefile b/lib/Makefile
index 821a162..7c00908 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -94,8 +94,8 @@ obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
 obj-$(CONFIG_PM_NOTIFIER_ERROR_INJECT) += pm-notifier-error-inject.o
 obj-$(CONFIG_MEMORY_NOTIFIER_ERROR_INJECT) += memory-notifier-error-inject.o
-obj-$(CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT) += \
-	pSeries-reconfig-notifier-error-inject.o
+obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
+	of-reconfig-notifier-error-inject.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
diff --git a/lib/of-reconfig-notifier-error-inject.c b/lib/of-reconfig-notifier-error-inject.c
new file mode 100644
index 0000000..8dc7986
--- /dev/null
+++ b/lib/of-reconfig-notifier-error-inject.c
@@ -0,0 +1,51 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "notifier-error-inject.h"
+
+static int priority;
+module_param(priority, int, 0);
+MODULE_PARM_DESC(priority, "specify OF reconfig notifier priority");
+
+static struct notifier_err_inject reconfig_err_inject = {
+	.actions = {
+		{ NOTIFIER_ERR_INJECT_ACTION(OF_RECONFIG_ATTACH_NODE) },
+		{ NOTIFIER_ERR_INJECT_ACTION(OF_RECONFIG_DETACH_NODE) },
+		{ NOTIFIER_ERR_INJECT_ACTION(OF_RECONFIG_ADD_PROPERTY) },
+		{ NOTIFIER_ERR_INJECT_ACTION(OF_RECONFIG_REMOVE_PROPERTY) },
+		{ NOTIFIER_ERR_INJECT_ACTION(OF_RECONFIG_UPDATE_PROPERTY) },
+		{}
+	}
+};
+
+static struct dentry *dir;
+
+static int err_inject_init(void)
+{
+	int err;
+
+	dir = notifier_err_inject_init("OF-reconfig",
+		notifier_err_inject_dir, &reconfig_err_inject, priority);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	err = of_reconfig_notifier_register(&reconfig_err_inject.nb);
+	if (err)
+		debugfs_remove_recursive(dir);
+
+	return err;
+}
+
+static void err_inject_exit(void)
+{
+	of_reconfig_notifier_unregister(&reconfig_err_inject.nb);
+	debugfs_remove_recursive(dir);
+}
+
+module_init(err_inject_init);
+module_exit(err_inject_exit);
+
+MODULE_DESCRIPTION("OF reconfig notifier error injection module");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
diff --git a/lib/pSeries-reconfig-notifier-error-inject.c b/lib/pSeries-reconfig-notifier-error-inject.c
deleted file mode 100644
index 7f7c98d..0000000
--- a/lib/pSeries-reconfig-notifier-error-inject.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include <asm/pSeries_reconfig.h>
-
-#include "notifier-error-inject.h"
-
-static int priority;
-module_param(priority, int, 0);
-MODULE_PARM_DESC(priority, "specify pSeries reconfig notifier priority");
-
-static struct notifier_err_inject reconfig_err_inject = {
-	.actions = {
-		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_RECONFIG_ADD) },
-		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_RECONFIG_REMOVE) },
-		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_DRCONF_MEM_ADD) },
-		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_DRCONF_MEM_REMOVE) },
-		{}
-	}
-};
-
-static struct dentry *dir;
-
-static int err_inject_init(void)
-{
-	int err;
-
-	dir = notifier_err_inject_init("pSeries-reconfig",
-		notifier_err_inject_dir, &reconfig_err_inject, priority);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
-
-	err = pSeries_reconfig_notifier_register(&reconfig_err_inject.nb);
-	if (err)
-		debugfs_remove_recursive(dir);
-
-	return err;
-}
-
-static void err_inject_exit(void)
-{
-	pSeries_reconfig_notifier_unregister(&reconfig_err_inject.nb);
-	debugfs_remove_recursive(dir);
-}
-
-module_init(err_inject_init);
-module_exit(err_inject_exit);
-
-MODULE_DESCRIPTION("pSeries reconfig notifier error injection module");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
