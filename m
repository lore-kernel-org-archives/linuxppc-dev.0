Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRkpZ5vhNzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:23:18 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KDJBe7140444
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:23:16 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28qvmckr3u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:23:16 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 23:23:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3EEBB2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:23:11 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KDN3XF51839216
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:23:11 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KDMd6n000760
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:22:39 +1100
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, jk@ozlabs.org, hegdevasant@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: [PATCH V2 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead of
 numbers in interrupt handler
Date: Mon, 20 Feb 2017 18:52:11 +0530
In-Reply-To: <1487596931-26975-1-git-send-email-mukesh02@linux.vnet.ibm.com>
References: <1487596931-26975-1-git-send-email-mukesh02@linux.vnet.ibm.com>
Message-Id: <1487596931-26975-2-git-send-email-mukesh02@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes: 8034f715f ("powernv/opal-dump: Convert to irq domain")

Converts all the return explicit number to a more proper IRQ_HANDLED,
which looks proper incase of interrupt handler returning case.

Here, It also removes error message like "nobody cared" which was
getting unveiled while returning -1 or 0 from handler.

Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index ae32212..71cf907 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -371,13 +371,12 @@ static irqreturn_t process_dump(int irq, void *data)
 {
 	int rc;
 	uint32_t dump_id, dump_size, dump_type;
-	struct dump_obj *dump;
 	char name[22];
 	struct kobject *kobj;
 
 	rc = dump_read_info(&dump_id, &dump_size, &dump_type);
 	if (rc != OPAL_SUCCESS)
-		return rc;
+		return IRQ_HANDLED;
 
 	sprintf(name, "0x%x-0x%x", dump_type, dump_id);
 
@@ -389,12 +388,10 @@ static irqreturn_t process_dump(int irq, void *data)
 	if (kobj) {
 		/* Drop reference added by kset_find_obj() */
 		kobject_put(kobj);
-		return 0;
+		return IRQ_HANDLED;
 	}
 
-	dump = create_dump_obj(dump_id, dump_size, dump_type);
-	if (!dump)
-		return -1;
+	create_dump_obj(dump_id, dump_size, dump_type);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4
