Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF829DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 23:48:39 +1100 (EST)
Subject: [PATCH v2] PMU: replace information ioctls and schedule for removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 20:11:48 +0100
Message-Id: <1194981108.6695.11.camel@johannes.berg>
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
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
v2 adds the firmware version to sysfs.

 Documentation/feature-removal-schedule.txt |    8 ++++
 drivers/macintosh/Kconfig                  |   11 ++++++
 drivers/macintosh/via-pmu.c                |   48 +++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-11-13 19:32:37.618723850 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-11-13 19:35:43.718712837 +0100
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
@@ -2680,6 +2682,51 @@ static int pmu_sys_resume(struct sys_dev
 
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
+static ssize_t show_pmu_version(struct sys_device *sysdev, char *buf)
+{
+	return sprintf(buf, "%d\n", pmu_version);
+}
+
+static SYSDEV_ATTR(kind, 0444, show_kind, NULL);
+static SYSDEV_ATTR(has_adb, 0444, show_has_adb, NULL);
+static SYSDEV_ATTR(firmware_version, 0444, show_pmu_version, NULL);
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
+	err = sysdev_create_file(sysdev, &attr_firmware_version);
+	if (err)
+		goto out_remove_adb;
+
+	return 0;
+
+ out_remove_adb:
+	sysdev_remove_file(sysdev, &attr_has_adb);
+ out_remove_kind:
+	sysdev_remove_file(sysdev, &attr_kind);
+ out:
+	return err;
+}
+
 static struct sysdev_class pmu_sysclass = {
 	set_kset_name("pmu"),
 };
@@ -2693,6 +2740,7 @@ static struct sysdev_driver driver_pmu =
 	.suspend	= &pmu_sys_suspend,
 	.resume		= &pmu_sys_resume,
 #endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
+	.add		= &pmu_sys_add,
 };
 
 static int __init init_pmu_sysfs(void)
--- everything.orig/Documentation/feature-removal-schedule.txt	2007-11-13 19:31:42.458723687 +0100
+++ everything/Documentation/feature-removal-schedule.txt	2007-11-13 19:32:40.728716851 +0100
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
--- everything.orig/drivers/macintosh/Kconfig	2007-11-13 19:31:42.388718641 +0100
+++ everything/drivers/macintosh/Kconfig	2007-11-13 19:32:40.728716851 +0100
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
