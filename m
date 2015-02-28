Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 051E41A000C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 13:24:59 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 27 Feb 2015 19:24:58 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id AC6043E40041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:24:56 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1S2NNPp24576112
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:23:23 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1S2Otbo025384
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:24:56 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/pseries: Expose post-migration in kernel device
 tree update to drmgr
Date: Fri, 27 Feb 2015 18:24:43 -0800
Message-Id: <1425090283-27694-4-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, cyrilbur@gmail.com,
 nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Traditionally after a migration operation drmgr has coordinated the device tree
update with the kernel in userspace via the ugly /proc/ppc64/ofdt interface. This
can be better done fully in the kernel where support already exists. Currently,
drmgr makes a faux ibm,suspend-me RTAS call which we intercept in the kernel so
that we can check VASI state for suspendability. After the LPAR resumes and
returns to drmgr that is followed by the necessary update-nodes and
update-properties RTAS calls which are parsed and communitated back to the kernel
through /proc/ppc64/ofdt for the device tree update. The drmgr tool should
instead initiate the migration using the already existing
/sysfs/kernel/mobility/migration entry that performs all this work in the kernel.

This patch adds a show function to the sysfs "migration" attribute that returns
1 to indicate the kernel will perform the device tree update after a migration
operation and that drmgr should initiated the migration through the sysfs
"migration" attribute.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 0b1f70e..a689f74 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -40,6 +40,9 @@ struct update_props_workarea {
 
 #define MIGRATION_SCOPE	(1)
 
+#define USER_DT_UPDATE  0
+#define KERN_DT_UPDATE  1
+
 static int mobility_rtas_call(int token, char *buf, s32 scope)
 {
 	int rc;
@@ -339,7 +342,13 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
 	return count;
 }
 
-static CLASS_ATTR(migration, S_IWUSR, NULL, migrate_store);
+static ssize_t migrate_show(struct class *class, struct class_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "%d\n", KERN_DT_UPDATE);
+}
+
+static CLASS_ATTR(migration, S_IWUSR | S_IRUGO, migrate_show, migrate_store);
 
 static int __init mobility_sysfs_init(void)
 {
-- 
1.7.12.2
