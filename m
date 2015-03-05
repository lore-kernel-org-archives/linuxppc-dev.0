Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 084DA1A03B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 13:25:50 +1100 (AEDT)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 21:25:47 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A0F32C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 21:16:54 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t252PhOj25296998
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 02:25:43 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t252Pg5x018066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 21:25:42 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Introduce api_version to migration sysfs
 interface
Date: Wed,  4 Mar 2015 18:25:38 -0800
Message-Id: <1425522338-14271-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The /sys/kernel/mobility/migration interface was added all the way back
in 2.6.37. However, the drmgr userspace tool was never augmented to use
this interface to perfrom migrations. Instead it has continued using a
faux rtas call coupled with performing the device tree update processing
in userspace and communicating it back to the kernel via the ugly
/proc/ppc64/ofdt interface.

Up until 3.12 the device tree update code in the kernel was badly broken
and bit rotting. This code was fixed in 3.12 and is now utilized by the
kernel suspend code as of 3.15. The kernel is now better suited to
handle the post-mobility fixup of the device tree and drmgr should be
transitioned to using the sysfs migration interface.

This patch introduces the api_version sysfs file to /sys/kernel/mobility
as a means for drmgr to query the current implementation level of the
kernel migration code. This initial versioning indicates it is capable
of perfroming all current PAPR requirements for migration including the
post-mobility firmware activation and device tree update.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index bdf62c1..ceb18d3 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -338,7 +338,16 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
 	return count;
 }
 
+/*
+ * Used by drmgr to determine the kernel behavior of the migration interface.
+ *
+ * Version 1: Performs all PAPR requirements for migration including
+ *	firmware activation and device tree update.
+ */
+#define MIGRATION_API_VERSION	1
+
 static CLASS_ATTR(migration, S_IWUSR, NULL, migrate_store);
+static CLASS_ATTR_STRING(api_version, S_IRUGO, __stringify(MIGRATION_API_VERSION));
 
 static int __init mobility_sysfs_init(void)
 {
@@ -349,7 +358,13 @@ static int __init mobility_sysfs_init(void)
 		return -ENOMEM;
 
 	rc = sysfs_create_file(mobility_kobj, &class_attr_migration.attr);
+	if (rc)
+		pr_err("mobility: unable to create migration sysfs file (%d)\n", rc);
 
-	return rc;
+	rc = sysfs_create_file(mobility_kobj, &class_attr_api_version.attr.attr);
+	if (rc)
+		pr_err("mobility: unable to create api_version sysfs file (%d)\n", rc);
+
+	return 0;
 }
 machine_device_initcall(pseries, mobility_sysfs_init);
-- 
1.7.12.2
