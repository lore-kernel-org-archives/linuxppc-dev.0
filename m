Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13196B6F89
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 11:14:33 +1000 (EST)
Received: by pvg18 with SMTP id 18so2987773pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 18:14:30 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v2 1/5] fault-injection: notifier error injection
Date: Mon, 18 Jul 2011 10:16:02 +0900
Message-Id: <1310951766-3840-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1310951766-3840-1-git-send-email-akinobu.mita@gmail.com>
References: <1310951766-3840-1-git-send-email-akinobu.mita@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Akinobu Mita <akinobu.mita@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mm@kvack.org,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The notifier error injection provides the ability to inject artifical
errors to specified notifier chain callbacks. It is useful to test
the error handling of notifier call chain failures.

This adds common basic functions to define which type of events can be
fail and to initialize the debugfs interface to control what error code
should be returned and which event should be failed.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-mm@kvack.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
* v2
- put a comment in err_inject_notifier_block_init()
- only allow valid errno to be injected (-MAX_ERRNO <= errno <= 0)

 include/linux/notifier.h |   25 ++++++++++++++
 kernel/notifier.c        |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |   11 ++++++
 3 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index c0688b0..51882d6 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -278,5 +278,30 @@ extern struct blocking_notifier_head reboot_notifier_list;
 #define VT_UPDATE		0x0004 /* A bigger update occurred */
 #define VT_PREWRITE		0x0005 /* A char is about to be written to the console */
 
+#ifdef CONFIG_NOTIFIER_ERROR_INJECTION
+
+struct err_inject_notifier_action {
+	unsigned long val;
+	int error;
+	const char *name;
+};
+
+#define ERR_INJECT_NOTIFIER_ACTION(action)	\
+	.name = #action, .val = (action),
+
+struct err_inject_notifier_block {
+	struct notifier_block nb;
+	struct dentry *dir;
+	struct err_inject_notifier_action actions[];
+	/* The last slot must be terminated with zero sentinel */
+};
+
+extern int err_inject_notifier_block_init(struct err_inject_notifier_block *enb,
+				const char *name, int priority);
+extern void err_inject_notifier_block_cleanup(
+				struct err_inject_notifier_block *enb);
+
+#endif /* CONFIG_NOTIFIER_ERROR_INJECTION */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2488ba7..8824ae3 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -5,6 +5,7 @@
 #include <linux/rcupdate.h>
 #include <linux/vmalloc.h>
 #include <linux/reboot.h>
+#include <linux/debugfs.h>
 
 /*
  *	Notifier list for kernel code which wants to be called
@@ -584,3 +585,83 @@ int unregister_die_notifier(struct notifier_block *nb)
 	return atomic_notifier_chain_unregister(&die_chain, nb);
 }
 EXPORT_SYMBOL_GPL(unregister_die_notifier);
+
+#ifdef CONFIG_NOTIFIER_ERROR_INJECTION
+
+static int debugfs_errno_set(void *data, u64 val)
+{
+	*(int *)data = clamp_t(int, val, -MAX_ERRNO, 0);
+	return 0;
+}
+
+static int debugfs_errno_get(void *data, u64 *val)
+{
+	*val = *(int *)data;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
+			"%lld\n");
+
+static struct dentry *debugfs_create_errno(const char *name, mode_t mode,
+				struct dentry *parent, int *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_errno);
+}
+
+static int err_inject_notifier_callback(struct notifier_block *nb,
+				unsigned long val, void *p)
+{
+	int err = 0;
+	struct err_inject_notifier_block *enb =
+		container_of(nb, struct err_inject_notifier_block, nb);
+	struct err_inject_notifier_action *action;
+
+	for (action = enb->actions; action->name; action++) {
+		if (action->val == val) {
+			err = action->error;
+			break;
+		}
+	}
+	if (err) {
+		printk(KERN_INFO "Injecting error (%d) to %s\n",
+			err, action->name);
+	}
+
+	return notifier_from_errno(err);
+}
+
+int err_inject_notifier_block_init(struct err_inject_notifier_block *enb,
+				const char *name, int priority)
+{
+	struct err_inject_notifier_action *action;
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+
+	enb->nb.notifier_call = err_inject_notifier_callback;
+	enb->nb.priority = priority;
+
+	enb->dir = debugfs_create_dir(name, NULL);
+	if (!enb->dir)
+		return -ENOMEM;
+
+	for (action = enb->actions; action->name; action++) {
+		/*
+		 * Create debugfs r/w file containing action->error. If
+		 * notifier call chain is called with action->val, it will
+		 * fail with the error code
+		 */
+		if (!debugfs_create_errno(action->name, mode, enb->dir,
+					&action->error)) {
+			debugfs_remove_recursive(enb->dir);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+void err_inject_notifier_block_cleanup(struct err_inject_notifier_block *enb)
+{
+	debugfs_remove_recursive(enb->dir);
+}
+
+#endif /* CONFIG_NOTIFIER_ERROR_INJECTION */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dd373c8..8c6ce7e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1018,6 +1018,17 @@ config LKDTM
 	Documentation on how to use the module can be found in
 	Documentation/fault-injection/provoke-crashes.txt
 
+config NOTIFIER_ERROR_INJECTION
+	bool "Notifier error injection"
+	depends on DEBUG_KERNEL
+	select DEBUG_FS
+	help
+	  This option provides the ability to inject artifical errors to
+	  specified notifier chain callbacks. It is useful to test the error
+	  handling of notifier call chain failures.
+
+	  Say N if unsure.
+
 config CPU_NOTIFIER_ERROR_INJECT
 	tristate "CPU notifier error injection module"
 	depends on HOTPLUG_CPU && DEBUG_KERNEL
-- 
1.7.4.4
