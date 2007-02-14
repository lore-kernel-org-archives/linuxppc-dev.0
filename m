Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8377DDE090
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 03:45:06 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1EGj2PE115978
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:45:02 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1EGj1P0675932
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:45:01 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1EGj1XW013457
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:45:01 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org, hch@infradead.org
Subject: [PATCH 2.6.21-rc1 4/5] ehca: replace yield() by wait_for_completion()
Date: Wed, 14 Feb 2007 17:41:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702141741.35444.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, h.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
this patch removes yield() and uses wait_for_completion() in order
to wait for running completion handlers finished before destroying
associated completion queue.
Thanks
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_classes.h |    3 +++
 ehca_cq.c      |    3 ++-
 ehca_irq.c     |    6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_classes.h infiniband_work/drivers/infiniband/hw/ehca/ehca_classes.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_classes.h   2007-02-14 13:52:49.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_classes.h   2007-02-14 13:52:06.000000000 +0100
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
+       struct completion zero_callbacks;
        spinlock_t task_lock;
        u32 ownpid;
        /* mmap counter for resources mapped into user space */
diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c        2007-02-14 13:52:49.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c        2007-02-14 13:52:06.000000000 +0100
@@ -147,6 +147,7 @@ struct ib_cq *ehca_create_cq(struct ib_d
        spin_lock_init(&my_cq->spinlock);
        spin_lock_init(&my_cq->cb_lock);
        spin_lock_init(&my_cq->task_lock);
+       init_completion(&my_cq->zero_callbacks);
        my_cq->ownpid = current->tgid;

        cq = &my_cq->ib_cq;
@@ -332,7 +333,7 @@ int ehca_destroy_cq(struct ib_cq *cq)
        spin_lock_irqsave(&ehca_cq_idr_lock, flags);
        while (my_cq->nr_callbacks) {
                spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
-               yield();
+               wait_for_completion(&my_cq->zero_callbacks);
                spin_lock_irqsave(&ehca_cq_idr_lock, flags);
        }

diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c       2007-02-14 13:52:49.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c       2007-02-14 13:52:06.000000000 +0100
@@ -605,6 +605,7 @@ static void run_comp_task(struct ehca_cp
        spin_lock_irqsave(&cct->task_lock, flags);

        while (!list_empty(&cct->cq_list)) {
+               int is_complete = 0;
                cq = list_entry(cct->cq_list.next, struct ehca_cq, entry);
                spin_unlock_irqrestore(&cct->task_lock, flags);
                comp_event_callback(cq);
@@ -612,11 +613,14 @@ static void run_comp_task(struct ehca_cp

                spin_lock(&cq->task_lock);
                cq->nr_callbacks--;
-               if (cq->nr_callbacks == 0) {
+               is_complete = (cq->nr_callbacks == 0);
+               if (is_complete) {
                        list_del_init(cct->cq_list.next);
                        cct->cq_jobs--;
                }
                spin_unlock(&cq->task_lock);
+               if (is_complete) /* wake up waiting destroy_cq() */
+                       complete(&cq->zero_callbacks);
        }

        spin_unlock_irqrestore(&cct->task_lock, flags);
