Return-Path: <srs0=9wj8=c5=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypSC966yZzDsPR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 08:31:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ypSC956P7z8vTQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 08:31:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ypSC91nxrz9sNd
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2017 08:31:48 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1LSw5R069073
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2017 16:31:46 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ekaxck5er-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 01 Dec 2017 16:31:45 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 14:31:45 -0700
Date: Fri, 1 Dec 2017 13:31:40 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: clombard@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/1]: powerpc: block interrupts when updating TIDR
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20171201213140.GA2776@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 13:39:43 -0600
Subject: [PATCH 1/1]: powerpc: block interrupts when updating TIDR

clear_thread_tidr() is called in interrupt context as a part of delayed
put of the task structure (i.e as a part of timer interrupt). To prevent
a deadlock, block interrupts when holding vas_thread_id_lock to set/
clear TIDR for a task.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bfdd783..aa8dbb9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1509,14 +1509,15 @@ static int assign_thread_tidr(void)
 {
 	int index;
 	int err;
+	unsigned long flags;
 
 again:
 	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
 		return -ENOMEM;
 
-	spin_lock(&vas_thread_id_lock);
+	spin_lock_irqsave(&vas_thread_id_lock, flags);
 	err = ida_get_new_above(&vas_thread_ida, 1, &index);
-	spin_unlock(&vas_thread_id_lock);
+	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
 
 	if (err == -EAGAIN)
 		goto again;
@@ -1524,9 +1525,9 @@ static int assign_thread_tidr(void)
 		return err;
 
 	if (index > MAX_THREAD_CONTEXT) {
-		spin_lock(&vas_thread_id_lock);
+		spin_lock_irqsave(&vas_thread_id_lock, flags);
 		ida_remove(&vas_thread_ida, index);
-		spin_unlock(&vas_thread_id_lock);
+		spin_unlock_irqrestore(&vas_thread_id_lock, flags);
 		return -ENOMEM;
 	}
 
@@ -1535,9 +1536,11 @@ static int assign_thread_tidr(void)
 
 static void free_thread_tidr(int id)
 {
-	spin_lock(&vas_thread_id_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vas_thread_id_lock, flags);
 	ida_remove(&vas_thread_ida, id);
-	spin_unlock(&vas_thread_id_lock);
+	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
 }
 
 /*
-- 
2.7.4
