Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFA44DDF3E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 03:06:34 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1FG6DVI156442
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 16:06:13 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1FG6C5e1269830
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 16:06:12 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1FG6Bm4018132
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 16:06:12 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org, hch@infradead.org,
	raisch@de.ibm.com, bos@patchscale.com
Subject: [PATCH 2.6.21-rc1 4/5] ehca: replace yield() by wait_for_completion()
Date: Thu, 15 Feb 2007 17:09:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702151709.45323.hnguyen@linux.vnet.ibm.com>
Cc: heiko.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

remove yield() and use wait_for_completion() in order to wait for running
completion handlers finished before destroying associated completion queue


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_classes.h |    3 +++
 ehca_cq.c      |    5 +++--
 ehca_irq.c     |    6 +++++-
 3 files changed, 11 insertions(+), 3 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 40404c9..d8ce0c8 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -52,6 +52,8 @@ struct ehca_mw;
 struct ehca_pd;
 struct ehca_av;
 
+#include <linux/completion.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 
@@ -154,6 +156,7 @@ struct ehca_cq {
 	struct hlist_head qp_hashtab[QP_HASHTAB_LEN];
 	struct list_head entry;
 	u32 nr_callbacks;
+	struct completion zero_callbacks;
 	spinlock_t task_lock;
 	u32 ownpid;
 	/* mmap counter for resources mapped into user space */
diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 9291a86..906bd5b 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -147,6 +147,7 @@ struct ib_cq *ehca_create_cq(struct ib_d
 	spin_lock_init(&my_cq->spinlock);
 	spin_lock_init(&my_cq->cb_lock);
 	spin_lock_init(&my_cq->task_lock);
+	init_completion(&my_cq->zero_callbacks);
 	my_cq->ownpid = current->tgid;
 
 	cq = &my_cq->ib_cq;
@@ -330,9 +331,9 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	}
 
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	while (my_cq->nr_callbacks) {
+	if (my_cq->nr_callbacks) {
 		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
-		yield();
+		wait_for_completion(&my_cq->zero_callbacks);
 		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
 	}
 
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 3ec53c6..7db39b7 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -605,6 +605,7 @@ static void run_comp_task(struct ehca_cp
 	spin_lock_irqsave(&cct->task_lock, flags);
 
 	while (!list_empty(&cct->cq_list)) {
+		int is_complete = 0;
 		cq = list_entry(cct->cq_list.next, struct ehca_cq, entry);
 		spin_unlock_irqrestore(&cct->task_lock, flags);
 		comp_event_callback(cq);
@@ -612,11 +613,14 @@ static void run_comp_task(struct ehca_cp
 
 		spin_lock(&cq->task_lock);
 		cq->nr_callbacks--;
-		if (cq->nr_callbacks == 0) {
+		is_complete = (cq->nr_callbacks == 0);
+		if (is_complete) {
 			list_del_init(cct->cq_list.next);
 			cct->cq_jobs--;
 		}
 		spin_unlock(&cq->task_lock);
+		if (is_complete) /* wake up waiting destroy_cq() */
+			complete(&cq->zero_callbacks);
 	}
 
 	spin_unlock_irqrestore(&cct->task_lock, flags);
