Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNKl51qXHzDvmk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:23:13 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM9Ikem136496
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 04:23:10 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vhbx98vy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 04:23:10 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 22 Nov 2016 19:23:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 55DAD3578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:23:05 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAM9N5I260620890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:23:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAM9N4hC022544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:23:05 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, benh@kernel.crashing.org
Subject: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
Date: Tue, 22 Nov 2016 20:22:58 +1100
Message-Id: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

skiboot now supports "fast reboot", a reboot procedure where skiboot
reinitialises hardware and loads a new kernel without re-IPLing the
machine. At present, fast reboot support is still experimental and is not
enabled by default, however it is intended that it will be enabled by
default in a near-future release.

There may be some circumstances where the user wants to force a full IPL
reboot rather than using fast reboot. Add support for the
OPAL_REBOOT_FULL_IPL reboot type, enabled by writing 1 to
/sys/firmware/opal/force_full_ipl_reboot. On versions of skiboot that
implement the OPAL_REBOOT_FULL_IPL reboot type, this will force an IPL. On
versions that do not, print an error message on reboot and proceed with a
regular reboot (which could be a full IPL or a fast reboot).

Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Corresponding skiboot patch: http://patchwork.ozlabs.org/patch/697601/

This seemed like a good idea at the time. A sysfs-based flag was the best 
option that came to mind; other suggestions are welcome. Is "full IPL" a 
reasonable term to use or should I try to think of something a bit less 
IBM-ese?

---
 arch/powerpc/include/asm/opal-api.h    |  1 +
 arch/powerpc/include/asm/opal.h        |  1 +
 arch/powerpc/platforms/powernv/opal.c  |  2 ++
 arch/powerpc/platforms/powernv/setup.c | 63 +++++++++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..4de1f63 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -918,6 +918,7 @@ enum OpalSysCooling {
 enum {
 	OPAL_REBOOT_NORMAL		= 0,
 	OPAL_REBOOT_PLATFORM_ERROR	= 1,
+	OPAL_REBOOT_FULL_IPL		= 2,
 };
 
 /* Argument to OPAL_PCI_TCE_KILL */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e958b70..a5e4065 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -270,6 +270,7 @@ extern void opal_platform_dump_init(void);
 extern void opal_sys_param_init(void);
 extern void opal_msglog_init(void);
 extern void opal_msglog_sysfs_init(void);
+extern void opal_reboot_sysfs_init(void);
 extern int opal_async_comp_init(void);
 extern int opal_sensor_init(void);
 extern int opal_hmi_handler_init(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 6c9a65b..c619d8d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -750,6 +750,8 @@ static int __init opal_init(void)
 		opal_sys_param_init();
 		/* Setup message log sysfs interface. */
 		opal_msglog_sysfs_init();
+		/* Setup reboot sysfs interface. */
+		opal_reboot_sysfs_init();
 	}
 
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index efe8b6b..d2460fc 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/pci.h>
 #include <linux/cpufreq.h>
+#include <linux/sysfs.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -118,6 +119,53 @@ static void pnv_prepare_going_down(void)
 	opal_flash_term_callback();
 }
 
+static bool force_full_ipl_reboot = false;
+
+static ssize_t force_full_ipl_reboot_show(struct kobject *k,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%d\n", (int) force_full_ipl_reboot);
+}
+
+static ssize_t force_full_ipl_reboot_store(struct kobject *k,
+					   struct kobj_attribute *attr,
+					   const char *buf,
+					   size_t count)
+{
+	if (count != 2)  /* including trailing NUL */
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case '0':
+		force_full_ipl_reboot = false;
+		return count;
+	case '1':
+		force_full_ipl_reboot = true;
+		return count;
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct kobj_attribute opal_force_full_ipl_reboot_attr =
+	__ATTR(force_full_ipl_reboot, 0644, force_full_ipl_reboot_show,
+	       force_full_ipl_reboot_store);
+
+void opal_reboot_sysfs_init(void) {
+	int rc = 0;
+
+	if (!opal_kobj) {
+		pr_warn("setup: opal kobject is not available");
+		return;
+	}
+
+	rc = sysfs_create_file(opal_kobj, &opal_force_full_ipl_reboot_attr.attr);
+	if (rc)
+		pr_err("setup: unable to create sysfs file "
+		       "force_full_ipl_reboot (%d)", rc);
+}
+
 static void  __noreturn pnv_restart(char *cmd)
 {
 	long rc = OPAL_BUSY;
@@ -125,7 +173,20 @@ static void  __noreturn pnv_restart(char *cmd)
 	pnv_prepare_going_down();
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		rc = opal_cec_reboot();
+		if (force_full_ipl_reboot && opal_check_token(OPAL_CEC_REBOOT2)) {
+			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL,
+					      "Full IPL reboot requested");
+
+			if (rc == OPAL_UNSUPPORTED) {
+				pr_err("Firmware doesn't support forcing full "
+				       "IPL reboot");
+				force_full_ipl_reboot = false;
+				rc = opal_cec_reboot();
+			}
+		} else {
+			rc = opal_cec_reboot();
+		}
+
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 		else
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
