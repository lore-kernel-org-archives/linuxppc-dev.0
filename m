Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1FCA2C032C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 10:58:24 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 16:58:22 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8930C1FF001A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:58:20 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s0VNwKgC5243388
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Feb 2014 00:58:20 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VNwJAP013265
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:58:20 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/3] powerpc/pseries: Report in kernel device tree update
 to drmgr
Date: Fri, 31 Jan 2014 15:58:12 -0800
Message-Id: <1391212692-16217-4-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Traditionally it has been drmgr's responsibilty to update the device tree
through the /proc/ppc64/ofdt interface after a suspend/resume operation.
This patchset however has modified suspend/resume ops to preform that update
entirely in the kernel during the resume. Therefore, a mechanism is required
for drmgr to determine who is responsible for the update. This patch adds a
show function to the "hibernate" attribute that returns 1 if the kernel
updates the device tree after the resume and 0 if drmgr is responsible.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/suspend.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index 1d9c580..b87b978 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -192,7 +192,30 @@ out:
 	return rc;
 }
 
-static DEVICE_ATTR(hibernate, S_IWUSR, NULL, store_hibernate);
+#define USER_DT_UPDATE	0
+#define KERN_DT_UPDATE	1
+
+/**
+ * show_hibernate - Report device tree update responsibilty
+ * @dev:		subsys root device
+ * @attr:		device attribute struct
+ * @buf:		buffer
+ *
+ * Report whether a device tree update is performed by the kernel after a
+ * resume, or if drmgr must coordinate the update from user space.
+ *
+ * Return value:
+ *	0 if drmgr is to initiate update, and 1 otherwise
+ **/
+static ssize_t show_hibernate(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%d\n", KERN_DT_UPDATE);
+}
+
+static DEVICE_ATTR(hibernate, S_IWUSR | S_IRUGO,
+		   show_hibernate, store_hibernate);
 
 static struct bus_type suspend_subsys = {
 	.name = "power",
-- 
1.7.12.2
