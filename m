Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BDDB1400BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 18:59:23 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 9 Apr 2014 09:18:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 70ECF394014B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 09:17:45 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s393laUM38928580
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Apr 2014 09:17:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s393lfXn028784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Apr 2014 09:17:42 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv Adapt opal-elog and opal-dump to new
 sysfs_remove_file_self API from (removed) sysfs_schedule_callback
Date: Wed,  9 Apr 2014 13:47:37 +1000
Message-Id: <1397015257-31988-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A merge fix for powernv opal-dump and opal-elog code with driver-next

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c |    9 ++-------
 arch/powerpc/platforms/powernv/opal-elog.c |    9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 0c767c5..b9827b0 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -86,19 +86,14 @@ static int64_t dump_send_ack(uint32_t dump_id)
 	return rc;
 }
 
-static void delay_release_kobj(void *kobj)
-{
-	kobject_put((struct kobject *)kobj);
-}
-
 static ssize_t dump_ack_store(struct dump_obj *dump_obj,
 			      struct dump_attribute *attr,
 			      const char *buf,
 			      size_t count)
 {
 	dump_send_ack(dump_obj->id);
-	sysfs_schedule_callback(&dump_obj->kobj, delay_release_kobj,
-				&dump_obj->kobj, THIS_MODULE);
+	sysfs_remove_file_self(&dump_obj->kobj, &attr->attr);
+	kobject_put(&dump_obj->kobj);
 	return count;
 }
 
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 1d7355b..ef7bc2a 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -70,19 +70,14 @@ static ssize_t elog_ack_show(struct elog_obj *elog_obj,
 	return sprintf(buf, "ack - acknowledge log message\n");
 }
 
-static void delay_release_kobj(void *kobj)
-{
-	kobject_put((struct kobject *)kobj);
-}
-
 static ssize_t elog_ack_store(struct elog_obj *elog_obj,
 			      struct elog_attribute *attr,
 			      const char *buf,
 			      size_t count)
 {
 	opal_send_ack_elog(elog_obj->id);
-	sysfs_schedule_callback(&elog_obj->kobj, delay_release_kobj,
-				&elog_obj->kobj, THIS_MODULE);
+	sysfs_remove_file_self(&elog_obj->kobj, &attr->attr);
+	kobject_put(&elog_obj->kobj);
 	return count;
 }
 
-- 
1.7.10.4
