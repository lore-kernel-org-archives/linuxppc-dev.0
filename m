Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTs0034ZZzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 20:08:32 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB194J8I080729
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 04:08:30 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 272fmwc9fq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2016 04:08:29 -0500
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 14:38:25 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4C8A3E0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 14:38:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB197m4223855206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 14:37:48 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB198KjX011436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 14:38:21 +0530
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead of
 numbers in interrupt handler
Date: Thu,  1 Dec 2016 14:38:09 +0530
In-Reply-To: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
Message-Id: <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Converts all the return explicit number to a more proper IRQ_HANDLED,
which looks proper incase of interrupt handler returning case.

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
