Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 380062C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 07:59:20 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 15:59:17 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 84D0CC90046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:59:13 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JKxGlG5636532
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 20:59:16 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JKv9ee015791
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:57:10 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v3 3/3] powerpc/pseries: Report in kernel device tree update
 to drmgr
Date: Wed, 19 Feb 2014 12:56:55 -0800
Message-Id: <1392843415-17153-5-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
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
