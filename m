Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D1C82C01BB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 17:35:22 +1000 (EST)
Received: by dajt11 with SMTP id t11so6142776daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:35:19 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH -v5 5/6] powerpc: pSeries reconfig notifier error injection
 module
Date: Sat, 30 Jun 2012 14:59:29 +0900
Message-Id: <1341035970-20490-6-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
References: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides the ability to inject artifical errors to pSeries reconfig
notifier chain callbacks.  It is controlled through debugfs interface
under /sys/kernel/debug/notifier-error-inject/pSeries-reconfig

If the notifier call chain should be failed with some events
notified, write the error code to "actions/<notifier event>/error".

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
No changes since v4

 lib/Kconfig.debug                            |   17 +++++++++
 lib/Makefile                                 |    2 +
 lib/pSeries-reconfig-notifier-error-inject.c |   51 ++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 lib/pSeries-reconfig-notifier-error-inject.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7cceddc..8f8e226 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1166,6 +1166,23 @@ config MEMORY_NOTIFIER_ERROR_INJECT
 
 	  If unsure, say N.
 
+config PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT
+	tristate "pSeries reconfig notifier error injection module"
+	depends on PPC_PSERIES && NOTIFIER_ERROR_INJECTION
+	help
+	  This option provides the ability to inject artifical errors to
+	  pSeries reconfig notifier chain callbacks.  It is controlled
+	  through debugfs interface under
+	  /sys/kernel/debug/notifier-error-inject/pSeries-reconfig/
+
+	  If the notifier call chain should be failed with some events
+	  notified, write the error code to "actions/<notifier event>/error".
+
+	  To compile this code as a module, choose M here: the module will
+	  be called memory-notifier-error-inject.
+
+	  If unsure, say N.
+
 config FAULT_INJECTION
 	bool "Fault-injection framework"
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index a867aa5..d055cb1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -94,6 +94,8 @@ obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
 obj-$(CONFIG_PM_NOTIFIER_ERROR_INJECT) += pm-notifier-error-inject.o
 obj-$(CONFIG_MEMORY_NOTIFIER_ERROR_INJECT) += memory-notifier-error-inject.o
+obj-$(CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT) += \
+	pSeries-reconfig-notifier-error-inject.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
diff --git a/lib/pSeries-reconfig-notifier-error-inject.c b/lib/pSeries-reconfig-notifier-error-inject.c
new file mode 100644
index 0000000..7f7c98d
--- /dev/null
+++ b/lib/pSeries-reconfig-notifier-error-inject.c
@@ -0,0 +1,51 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/pSeries_reconfig.h>
+
+#include "notifier-error-inject.h"
+
+static int priority;
+module_param(priority, int, 0);
+MODULE_PARM_DESC(priority, "specify pSeries reconfig notifier priority");
+
+static struct notifier_err_inject reconfig_err_inject = {
+	.actions = {
+		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_RECONFIG_ADD) },
+		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_RECONFIG_REMOVE) },
+		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_DRCONF_MEM_ADD) },
+		{ NOTIFIER_ERR_INJECT_ACTION(PSERIES_DRCONF_MEM_REMOVE) },
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
+	dir = notifier_err_inject_init("pSeries-reconfig",
+		notifier_err_inject_dir, &reconfig_err_inject, priority);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	err = pSeries_reconfig_notifier_register(&reconfig_err_inject.nb);
+	if (err)
+		debugfs_remove_recursive(dir);
+
+	return err;
+}
+
+static void err_inject_exit(void)
+{
+	pSeries_reconfig_notifier_unregister(&reconfig_err_inject.nb);
+	debugfs_remove_recursive(dir);
+}
+
+module_init(err_inject_init);
+module_exit(err_inject_exit);
+
+MODULE_DESCRIPTION("pSeries reconfig notifier error injection module");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
-- 
1.7.10.4
