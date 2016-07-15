Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrPB21pnCzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:20:58 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6F7KFN4122241
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 03:20:56 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 246kcjkxc7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 03:20:55 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 15 Jul 2016 17:20:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3D4352CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:20:50 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6F7KoOj3801278
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:20:50 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6F7Knww010381
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:20:50 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 clombard@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com
Cc: dan.carpenter@oracle.com
Subject: [PATCH] cxl: fix potential NULL dereference in free_adapter()
Date: Fri, 15 Jul 2016 17:20:36 +1000
In-Reply-To: <20160714215352.GA19749@mwanda>
References: <20160714215352.GA19749@mwanda>
Message-Id: <1468567236-5060-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If kzalloc() fails when allocating adapter->guest in
cxl_guest_init_adapter(), we call free_adapter() before erroring out.
free_adapter() in turn attempts to dereference adapter->guest, which in
this case is NULL.

In free_adapter(), skip the adapter->guest cleanup if adapter->guest is
NULL.

Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Build tested only.
---
 drivers/misc/cxl/guest.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index ee7148e..9aa58a7 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -1055,16 +1055,18 @@ static void free_adapter(struct cxl *adapter)
 	struct irq_avail *cur;
 	int i;
 
-	if (adapter->guest->irq_avail) {
-		for (i = 0; i < adapter->guest->irq_nranges; i++) {
-			cur = &adapter->guest->irq_avail[i];
-			kfree(cur->bitmap);
+	if (adapter->guest) {
+		if (adapter->guest->irq_avail) {
+			for (i = 0; i < adapter->guest->irq_nranges; i++) {
+				cur = &adapter->guest->irq_avail[i];
+				kfree(cur->bitmap);
+			}
+			kfree(adapter->guest->irq_avail);
 		}
-		kfree(adapter->guest->irq_avail);
+		kfree(adapter->guest->status);
+		kfree(adapter->guest);
 	}
-	kfree(adapter->guest->status);
 	cxl_remove_adapter_nr(adapter);
-	kfree(adapter->guest);
 	kfree(adapter);
 }
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
