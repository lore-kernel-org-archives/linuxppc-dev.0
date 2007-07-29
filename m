Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep20-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 39E97DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jul 2007 02:24:10 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compilation for non CONFIG_HOTPLUG case
Date: Sun, 29 Jul 2007 18:07:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707291807.52042.niklaus.giger@member.fsf.org>
Cc: linuxppc-embedded@ozlabs.org., kristen.c.accardi@intel.com
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes compilation issues for embedded boards which do not support HOTPLUG

Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 drivers/base/core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3599ab2..a09bfc8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -24,7 +24,9 @@
 #include "base.h"
 #include "power/power.h"

+#ifdef CONFIG_HOTPLUG
 extern const char *kobject_actions[];
+#endif

 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
@@ -306,11 +308,13 @@ static ssize_t store_uevent(struct device *dev, struct 
device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	size_t len = count;
+#ifdef CONFIG_HOTPLUG
 	enum kobject_action action;
-
+#endif
 	if (len && buf[len-1] == '\n')
 		len--;

+#ifdef CONFIG_HOTPLUG
 	for (action = 0; action < KOBJ_MAX; action++) {
 		if (strncmp(kobject_actions[action], buf, len) != 0)
 			continue;
@@ -319,11 +323,14 @@ static ssize_t store_uevent(struct device *dev, struct 
device_attribute *attr,
 		kobject_uevent(&dev->kobj, action);
 		goto out;
 	}
+#endif

 	dev_err(dev, "uevent: unsupported action-string; this will "
 		     "be ignored in a future kernel version\n");
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
+#ifdef CONFIG_HOTPLUG
 out:
+#endif
 	return count;
 }

--
1.5.2.4
