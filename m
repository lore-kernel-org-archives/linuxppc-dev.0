Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66462DDF69
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:30:46 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l69DUfSd306328
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:30:41 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69DUg9G1478864
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:30:42 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69DUe0W029326
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:30:41 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 09/13] IB/ehca: Refactor synchronization between completions
	and destroy_cq using atomic_t
References: <200707091502.22407.fenkes@de.ibm.com>
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 9 Jul 2007 15:30:39 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091530.40581.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- ehca_cq.nr_events is made an atomic_t, eliminating a lot of locking.
- The CQ is removed from the CQ idr first now to make sure no more
  completions are scheduled on that CQ. The "wait for all completions to
  end" code becomes much simpler this way.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    4 +-
 drivers/infiniband/hw/ehca/ehca_cq.c      |   26 +++++++-------------
 drivers/infiniband/hw/ehca/ehca_irq.c     |   36 +++++++++++++---------------
 drivers/infiniband/hw/ehca/ehca_irq.h     |    1 -
 drivers/infiniband/hw/ehca/ehca_tools.h   |    1 +
 5 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 3550047..8580f2a 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -174,8 +174,8 @@ struct ehca_cq {
 	spinlock_t cb_lock;
 	struct hlist_head qp_hashtab[QP_HASHTAB_LEN];
 	struct list_head entry;
-	u32 nr_callbacks; /* #events assigned to cpu by scaling code */
-	u32 nr_events;    /* #events seen */
+	u32 nr_callbacks;   /* #events assigned to cpu by scaling code */
+	atomic_t nr_events; /* #events seen */
 	wait_queue_head_t wait_completion;
 	spinlock_t task_lock;
 	u32 ownpid;
diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 94bad27..3729997 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -146,6 +146,7 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe, int comp_vector,
 	spin_lock_init(&my_cq->spinlock);
 	spin_lock_init(&my_cq->cb_lock);
 	spin_lock_init(&my_cq->task_lock);
+	atomic_set(&my_cq->nr_events, 0);
 	init_waitqueue_head(&my_cq->wait_completion);
 	my_cq->ownpid = current->tgid;
 
@@ -303,16 +304,6 @@ create_cq_exit1:
 	return cq;
 }
 
-static int get_cq_nr_events(struct ehca_cq *my_cq)
-{
-	int ret;
-	unsigned long flags;
-	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	ret = my_cq->nr_events;
-	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
-	return ret;
-}
-
 int ehca_destroy_cq(struct ib_cq *cq)
 {
 	u64 h_ret;
@@ -339,17 +330,18 @@ int ehca_destroy_cq(struct ib_cq *cq)
 		}
 	}
 
+	/*
+	 * remove the CQ from the idr first to make sure
+	 * no more interrupt tasklets will touch this CQ
+	 */
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	while (my_cq->nr_events) {
-		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
-		wait_event(my_cq->wait_completion, !get_cq_nr_events(my_cq));
-		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-		/* recheck nr_events to assure no cqe has just arrived */
-	}
-
 	idr_remove(&ehca_cq_idr, my_cq->token);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 
+	/* now wait until all pending events have completed */
+	wait_event(my_cq->wait_completion, !atomic_read(&my_cq->nr_events));
+
+	/* nobody's using our CQ any longer -- we can destroy it */
 	h_ret = hipz_h_destroy_cq(adapter_handle, my_cq, 0);
 	if (h_ret == H_R_STATE) {
 		/* cq in err: read err data and destroy it forcibly */
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 100329b..3e790a3 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -5,6 +5,8 @@
  *
  *  Authors: Heiko J Schick <schickhj@de.ibm.com>
  *           Khadija Souissi <souissi@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Joachim Fenkes <fenkes@de.ibm.com>
  *
  *  Copyright (c) 2005 IBM Corporation
  *
@@ -212,6 +214,8 @@ static void cq_event_callback(struct ehca_shca *shca,
 
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
 	cq = idr_find(&ehca_cq_idr, token);
+	if (cq)
+		atomic_inc(&cq->nr_events);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 
 	if (!cq)
@@ -219,6 +223,9 @@ static void cq_event_callback(struct ehca_shca *shca,
 
 	ehca_error_data(shca, cq, cq->ipz_cq_handle.handle);
 
+	if (atomic_dec_and_test(&cq->nr_events))
+		wake_up(&cq->wait_completion);
+
 	return;
 }
 
@@ -414,25 +421,22 @@ static inline void process_eqe(struct ehca_shca *shca, struct ehca_eqe *eqe)
 		token = EHCA_BMASK_GET(EQE_CQ_TOKEN, eqe_value);
 		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
 		cq = idr_find(&ehca_cq_idr, token);
+		if (cq)
+			atomic_inc(&cq->nr_events);
+		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		if (cq == NULL) {
-			spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 			ehca_err(&shca->ib_device,
 				 "Invalid eqe for non-existing cq token=%x",
 				 token);
 			return;
 		}
 		reset_eq_pending(cq);
-		cq->nr_events++;
-		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		if (ehca_scaling_code)
 			queue_comp_task(cq);
 		else {
 			comp_event_callback(cq);
-			spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-			cq->nr_events--;
-			if (!cq->nr_events)
+			if (atomic_dec_and_test(&cq->nr_events))
 				wake_up(&cq->wait_completion);
-			spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		}
 	} else {
 		ehca_dbg(&shca->ib_device, "Got non completion event");
@@ -478,15 +482,15 @@ void ehca_process_eq(struct ehca_shca *shca, int is_irq)
 			token = EHCA_BMASK_GET(EQE_CQ_TOKEN, eqe_value);
 			spin_lock(&ehca_cq_idr_lock);
 			eqe_cache[eqe_cnt].cq = idr_find(&ehca_cq_idr, token);
+			if (eqe_cache[eqe_cnt].cq)
+				atomic_inc(&eqe_cache[eqe_cnt].cq->nr_events);
+			spin_unlock(&ehca_cq_idr_lock);
 			if (!eqe_cache[eqe_cnt].cq) {
-				spin_unlock(&ehca_cq_idr_lock);
 				ehca_err(&shca->ib_device,
 					 "Invalid eqe for non-existing cq "
 					 "token=%x", token);
 				continue;
 			}
-			eqe_cache[eqe_cnt].cq->nr_events++;
-			spin_unlock(&ehca_cq_idr_lock);
 		} else
 			eqe_cache[eqe_cnt].cq = NULL;
 		eqe_cnt++;
@@ -517,11 +521,8 @@ void ehca_process_eq(struct ehca_shca *shca, int is_irq)
 			else {
 				struct ehca_cq *cq = eq->eqe_cache[i].cq;
 				comp_event_callback(cq);
-				spin_lock(&ehca_cq_idr_lock);
-				cq->nr_events--;
-				if (!cq->nr_events)
+				if (atomic_dec_and_test(&cq->nr_events))
 					wake_up(&cq->wait_completion);
-				spin_unlock(&ehca_cq_idr_lock);
 			}
 		} else {
 			ehca_dbg(&shca->ib_device, "Got non completion event");
@@ -621,13 +622,10 @@ static void run_comp_task(struct ehca_cpu_comp_task* cct)
 	while (!list_empty(&cct->cq_list)) {
 		cq = list_entry(cct->cq_list.next, struct ehca_cq, entry);
 		spin_unlock_irqrestore(&cct->task_lock, flags);
-		comp_event_callback(cq);
 
-		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-		cq->nr_events--;
-		if (!cq->nr_events)
+		comp_event_callback(cq);
+		if (atomic_dec_and_test(&cq->nr_events))
 			wake_up(&cq->wait_completion);
-		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 
 		spin_lock_irqsave(&cct->task_lock, flags);
 		spin_lock(&cq->task_lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.h b/drivers/infiniband/hw/ehca/ehca_irq.h
index 6ed06ee..3346cb0 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.h
+++ b/drivers/infiniband/hw/ehca/ehca_irq.h
@@ -47,7 +47,6 @@ struct ehca_shca;
 
 #include <linux/interrupt.h>
 #include <linux/types.h>
-#include <asm/atomic.h>
 
 int ehca_error_data(struct ehca_shca *shca, void *data, u64 resource);
 
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 973c4b5..03b185f 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -59,6 +59,7 @@
 #include <linux/cpu.h>
 #include <linux/device.h>
 
+#include <asm/atomic.h>
 #include <asm/abs_addr.h>
 #include <asm/ibmebus.h>
 #include <asm/io.h>
-- 
1.5.2
