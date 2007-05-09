Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 96769DDFEA
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 21:48:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l49BmX9W164532
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 11:48:33 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l49BmXts2625682
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 13:48:33 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l49BmMH7001141
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 13:48:23 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 4/6] IB/ehca: remove _irqsave, move #ifdef
MIME-Version: 1.0
Date: Wed, 9 May 2007 13:48:20 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705091348.20808.fenkes@de.ibm.com>
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

- In ehca_process_eq(), we're IRQ safe throughout the whole function, so we
  don't need another _irqsave in the middle of flight.

- take_over_work() is only called by comp_pool_callback(), so it can move
  into the same #ifdef block.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_irq.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index f284be1..f172013 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -517,12 +517,11 @@ void ehca_process_eq(struct ehca_shca *s
 			else {
 				struct ehca_cq *cq = eq->eqe_cache[i].cq;
 				comp_event_callback(cq);
-				spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+				spin_lock(&ehca_cq_idr_lock);
 				cq->nr_events--;
 				if (!cq->nr_events)
 					wake_up(&cq->wait_completion);
-				spin_unlock_irqrestore(&ehca_cq_idr_lock,
-						       flags);
+				spin_unlock(&ehca_cq_idr_lock);
 			}
 		} else {
 			ehca_dbg(&shca->ib_device, "Got non completion event");
@@ -711,6 +710,7 @@ static void destroy_comp_task(struct ehc
 		kthread_stop(task);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static void take_over_work(struct ehca_comp_pool *pool,
 			   int cpu)
 {
@@ -735,7 +735,6 @@ static void take_over_work(struct ehca_c
 
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int comp_pool_callback(struct notifier_block *nfb,
 			      unsigned long action,
 			      void *hcpu)
-- 
1.4.2.1
