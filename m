Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHkwM64BwzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:00:02 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M6wNCr022256
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 03:00:00 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24xy4wbujs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 03:00:00 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 12:29:57 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8E01E1258083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 12:33:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7M6vnbi24707432
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 12:27:49 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7M6uger000317
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 12:29:51 +0530
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
To: hegdevasant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] powerpc/powernv : Drop reference added by kset_find_obj()
Date: Mon, 22 Aug 2016 12:17:44 +0530
Message-Id: <1471848464-5735-1-git-send-email-mukesh02@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a situation, where Linux kernel gets notified about duplicate error log
from OPAL, it is been observed that kernel fails to remove sysfs entries
(/sys/firmware/opal/elog/0xXXXXXXXX) of such error logs. This is because,
we currently search the error log/dump kobject in the kset list via
'kset_find_obj()' routine. Which eventually increment the reference count
by one, once it founds the kobject. 

So, unless we decrement the reference count by one after it found the kobject,
we would not be able to release the kobject properly later.

This patch adds the 'kobject_put()' which was missing earlier.

Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/powernv/opal-dump.c | 7 ++++++-
 arch/powerpc/platforms/powernv/opal-elog.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 2ee9643..4c82782 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -370,6 +370,7 @@ static irqreturn_t process_dump(int irq, void *data)
 	uint32_t dump_id, dump_size, dump_type;
 	struct dump_obj *dump;
 	char name[22];
+	struct kobject *kobj;
 
 	rc = dump_read_info(&dump_id, &dump_size, &dump_type);
 	if (rc != OPAL_SUCCESS)
@@ -381,8 +382,12 @@ static irqreturn_t process_dump(int irq, void *data)
 	 * that gracefully and not create two conflicting
 	 * entries.
 	 */
-	if (kset_find_obj(dump_kset, name))
+	kobj = kset_find_obj(dump_kset, name);
+	if (kobj) {
+		/* Drop reference added by kset_find_obj() */
+		kobject_put(kobj);
 		return 0;
+	}
 
 	dump = create_dump_obj(dump_id, dump_size, dump_type);
 	if (!dump)
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 37f959b..f2344cb 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -247,6 +247,7 @@ static irqreturn_t elog_event(int irq, void *data)
 	uint64_t elog_type;
 	int rc;
 	char name[2+16+1];
+	struct kobject *kobj;
 
 	rc = opal_get_elog_size(&id, &size, &type);
 	if (rc != OPAL_SUCCESS) {
@@ -269,8 +270,12 @@ static irqreturn_t elog_event(int irq, void *data)
 	 * that gracefully and not create two conflicting
 	 * entries.
 	 */
-	if (kset_find_obj(elog_kset, name))
+	kobj = kset_find_obj(elog_kset, name);
+	if (kobj) {
+		/* Drop reference added by kset_find_obj() */
+		kobject_put(kobj);
 		return IRQ_HANDLED;
+	}
 
 	create_elog_obj(log_id, elog_size, elog_type);
 
-- 
2.7.4
