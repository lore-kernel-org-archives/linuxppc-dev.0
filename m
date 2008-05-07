Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44663DDE16
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 21:19:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m47BLp61010469
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 07:21:51 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m47BJgF0259262
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 07:19:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m47BJgMI032638
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 07:19:42 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, LKML <linux-kernel@vger.kernel.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Protect QP against destroying until all async events
	for it are handled.
Date: Wed, 7 May 2008 13:19:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805071319.37164.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is necessary because, in a multicore environment, a race between
uverbs async handler and destroy QP could occur.

Signed-off-by: Stefan Roscher <stefan.roscher at de.ibm.com>
---

We are not sure if this should be fixed in the driver or in uverbs itself.
Roland, what's your opinion about this?

 drivers/infiniband/hw/ehca/ehca_classes.h |    2 ++
 drivers/infiniband/hw/ehca/ehca_irq.c     |    4 ++++
 drivers/infiniband/hw/ehca/ehca_qp.c      |    5 +++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 00bab60..1e9e99a 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -192,6 +192,8 @@ struct ehca_qp {
 	int mtu_shift;
 	u32 message_count;
 	u32 packet_count;
+	atomic_t nr_events; /* events seen */
+	wait_queue_head_t wait_completion;
 };
 
 #define IS_SRQ(qp) (qp->ext_type == EQPT_SRQ)
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index ca5eb0c..ce1ab05 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -204,6 +204,8 @@ static void qp_event_callback(struct ehca_shca *shca, u64 eqe,
 
 	read_lock(&ehca_qp_idr_lock);
 	qp = idr_find(&ehca_qp_idr, token);
+	if (qp)
+		atomic_inc(&qp->nr_events);
 	read_unlock(&ehca_qp_idr_lock);
 
 	if (!qp)
@@ -223,6 +225,8 @@ static void qp_event_callback(struct ehca_shca *shca, u64 eqe,
 	if (fatal && qp->ext_type == EQPT_SRQBASE)
 		dispatch_qp_event(shca, qp, IB_EVENT_QP_LAST_WQE_REACHED);
 
+	if (atomic_dec_and_test(&qp->nr_events))
+		wake_up(&qp->wait_completion);
 	return;
 }
 
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 18fba92..d550200 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -566,6 +566,8 @@ static struct ehca_qp *internal_create_qp(
 		return ERR_PTR(-ENOMEM);
 	}
 
+	atomic_set(&my_qp->nr_events, 0);
+	init_waitqueue_head(&my_qp->wait_completion);
 	spin_lock_init(&my_qp->spinlock_s);
 	spin_lock_init(&my_qp->spinlock_r);
 	my_qp->qp_type = qp_type;
@@ -1934,6 +1936,9 @@ static int internal_destroy_qp(struct ib_device *dev, struct ehca_qp *my_qp,
 	idr_remove(&ehca_qp_idr, my_qp->token);
 	write_unlock_irqrestore(&ehca_qp_idr_lock, flags);
 
+        /* now wait until all pending events have completed */
+	wait_event(my_qp->wait_completion, !atomic_read(&my_qp->nr_events));
+
 	h_ret = hipz_h_destroy_qp(shca->ipz_hca_handle, my_qp);
 	if (h_ret != H_SUCCESS) {
 		ehca_err(dev, "hipz_h_destroy_qp() failed h_ret=%li "
-- 
1.5.5
