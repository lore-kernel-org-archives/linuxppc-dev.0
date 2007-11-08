Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6810FDDF66
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:36:42 +1100 (EST)
Subject: [RFC] PMU: replace information ioctls and schedule for removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 08 Nov 2007 13:02:31 +0100
Message-Id: <1194523351.6294.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds sysfs attributes to the PMU to allow getting
the information on the PMU type and whether adb is present from
there instead of via the ioctl. The ioctl is made optional and
scheduled for removal.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++
 drivers/macintosh/Kconfig                  |   11 ++++++++
 drivers/macintosh/via-pmu.c                |   36 +++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-11-08 11:48:48.292846681 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-11-08 11:48:53.112861818 +0100
@@ -2533,10 +2533,12 @@ pmu_ioctl(struct inode * inode, struct f
 #endif /* CONFIG_INPUT_ADBHID */
 #endif /* CONFIG_PMAC_BACKLIGHT_LEGACY */
 
+#ifdef CONFIG_DEPRECATED_PMU_INFO_IOCTLS
 	case PMU_IOC_GET_MODEL:
 	    	return put_user(pmu_kind, argp);
 	case PMU_IOC_HAS_ADB:
 		return put_user(pmu_has_adb, argp);
+#endif
 	}
 	return error;
 }
@@ -2680,6 +2682,39 @@ static int pmu_sys_resume(struct sys_dev
 
 #endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
 
+static ssize_t show_kind(struct sys_device *sysdev, char *buf)
+{
+	return sprintf(buf, "%d\n", pmu_kind);
+}
+
+static ssize_t show_has_adb(struct sys_device *sysdev, char *buf)
+{
+	return sprintf(buf, "%d\n", pmu_has_adb);
+}
+
+static SYSDEV_ATTR(kind, 0444, show_kind, NULL);
+static SYSDEV_ATTR(has_adb, 0444, show_has_adb, NULL);
+
+int pmu_sys_add(struct sys_device *sysdev)
+{
+	int err;
+
+	err = sysdev_create_file(sysdev, &attr_kind);
+	if (err)
+		goto out;
+
+	err = sysdev_create_file(sysdev, &attr_has_adb);
+	if (err)
+		goto out_remove_kind;
+
+	return 0;
+
+ out_remove_kind:
+	sysdev_remove_file(sysdev, &attr_kind);
+ out:
+	return err;
+}
+
 static struct sysdev_class pmu_sysclass = {
 	set_kset_name("pmu"),
 };
@@ -2693,6 +2728,7 @@ static struct sysdev_driver driver_pmu =
 	.suspend	= &pmu_sys_suspend,
 	.resume		= &pmu_sys_resume,
 #endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
+	.add		= &pmu_sys_add,
 };
 
 static int __init init_pmu_sysfs(void)
--- everything.orig/Documentation/feature-removal-schedule.txt	2007-11-08 11:47:39.502844564 +0100
+++ everything/Documentation/feature-removal-schedule.txt	2007-11-08 11:48:53.122870607 +0100
@@ -342,3 +342,11 @@ Why:	This driver has been marked obsolet
 Who:	Stephen Hemminger <shemminger@linux-foundation.org>
 
 ---------------------------
+
+What:	/dev/pmu information ioctls
+When:	January 2010
+Files:	drivers/macintosh/via-pmu.c
+Why:	The PMU information can be obtained from sysfs now.
+Who:	Johannes Berg <johannes@sipsolutions.net>
+
+---------------------------
--- everything.orig/drivers/macintosh/Kconfig	2007-11-08 11:47:39.422844727 +0100
+++ everything/drivers/macintosh/Kconfig	2007-11-08 11:48:53.122870607 +0100
@@ -87,6 +87,17 @@ config ADB_PMU
 	  this device; you should do so if your machine is one of those
 	  mentioned above.
 
+config DEPRECATED_PMU_INFO_IOCTLS
+	bool "Support deprecated PMU information ioctl"
+	depends on ADB_PMU
+	default y
+	help
+	  The PMU ioctl supports getting information on the type of PMU and
+	  whether an ADB is present. This information is also available in
+	  sysfs so this ioctl is no longer needed.
+
+	  If in doubt, say Y even if you will not use the ioctl.
+
 config ADB_PMU_LED
 	bool "Support for the Power/iBook front LED"
 	depends on ADB_PMU
