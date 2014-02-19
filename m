Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3B802C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 07:59:20 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 15:59:18 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5BF8638C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:59:15 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JKxFcH8651116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 20:59:15 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JKv8B2015754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:57:08 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v4 3/3] powerpc/pseries: Expose in kernel device tree update
 to drmgr
Date: Wed, 19 Feb 2014 12:56:54 -0800
Message-Id: <1392843415-17153-4-git-send-email-tyreld@linux.vnet.ibm.com>
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
This patchset however has modified suspend/resume ops to preform an update
entirely in the kernel during the resume. Therefore, a mechanism is required
to expose that information to drmgr.

This patch adds a show function to the "hibernate" attribute that returns 1
if the kernel performs a device tree update after the resume and 0 otherwise.
This allows newer versions of drmgr to avoid doing a second unnecessary
device tree update.

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
