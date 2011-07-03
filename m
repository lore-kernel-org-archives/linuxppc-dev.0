Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5FEBB6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 00:15:07 +1000 (EST)
Received: by mail-pz0-f51.google.com with SMTP id 26so1133592pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 03 Jul 2011 07:15:07 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 7/7] powerpc: pSeries reconfig notifier error injection
Date: Sun,  3 Jul 2011 23:16:21 +0900
Message-Id: <1309702581-16863-8-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides the ability to inject artifical errors to pSeries reconfig
notifier chain callbacks.  It is controlled through debugfs interface
under /sys/kernel/debug/pSeries-reconfig-notifier-error-inject/

Each of the files in the directory represents an event which can be
failed and contains the error code.  If the notifier call chain should
be failed with some events notified, write the error code to the files.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/reconfig.c |   31 +++++++++++++++++++++++++++++
 lib/Kconfig.debug                         |    9 ++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 168651a..31d9b0f 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -117,6 +117,37 @@ int pSeries_reconfig_notify(unsigned long action, void *p)
 	return notifier_to_errno(err);
 }
 
+#ifdef CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECTION
+
+static struct err_inject_notifier_block err_inject_reconfig_nb = {
+	.actions = {
+		{ ERR_INJECT_NOTIFIER_ACTION(PSERIES_RECONFIG_ADD) },
+		{ ERR_INJECT_NOTIFIER_ACTION(PSERIES_RECONFIG_REMOVE) },
+		{ ERR_INJECT_NOTIFIER_ACTION(PSERIES_DRCONF_MEM_ADD) },
+		{ ERR_INJECT_NOTIFIER_ACTION(PSERIES_DRCONF_MEM_REMOVE) },
+		{}
+	}
+};
+
+static int __init err_inject_reconfig_notifier_init(void)
+{
+	int err;
+
+	err = err_inject_notifier_block_init(&err_inject_reconfig_nb,
+			"pSeries-reconfig-notifier-error-inject", -1);
+	if (err)
+		return err;
+
+	err = pSeries_reconfig_notifier_register(&err_inject_reconfig_nb.nb);
+	if (err)
+		err_inject_notifier_block_cleanup(&err_inject_reconfig_nb);
+
+	return err;
+}
+late_initcall(err_inject_reconfig_notifier_init);
+
+#endif /* CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECTION */
+
 static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
 {
 	struct device_node *np;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 52f0b0e..2becf8c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1059,6 +1059,15 @@ config MEMORY_NOTIFIER_ERROR_INJECTION
 	  memory hotplug notifier chain callbacks.  It is controlled through
 	  debugfs interface under /sys/kernel/debug/memory-notifier-error-inject/
 
+config PSERIES_RECONFIG_NOTIFIER_ERROR_INJECTION
+	bool "pSeries reconfig notifier error injection"
+	depends on PPC_PSERIES && NOTIFIER_ERROR_INJECTION
+	help
+	  This option provides the ability to inject artifical errors to
+	  pSeries reconfig notifier chain callbacks.  It is controlled
+	  through debugfs interface under
+	  /sys/kernel/debug/pSeries-reconfig-notifier-error-inject/
+
 config CPU_NOTIFIER_ERROR_INJECT
 	tristate "CPU notifier error injection module"
 	depends on HOTPLUG_CPU && DEBUG_KERNEL
-- 
1.7.4.4
