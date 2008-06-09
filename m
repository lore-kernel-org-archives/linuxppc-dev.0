Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D280DE732
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 01:45:46 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m59FjdYe027712
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 11:45:39 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m59Fjdev068890
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 09:45:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m59FjR5V023263
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 09:45:38 -0600
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>,
	general@lists.openfabrics.org, LKML <linux-kernel@vger.kernel.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
Date: Mon, 9 Jun 2008 17:45:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806091745.19147.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, fenkes@de.ibm.com, raisch@de.ibm.com, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    1 +
 drivers/infiniband/hw/ehca/ehca_eq.c      |    6 ++++--
 drivers/infiniband/hw/ehca/ehca_main.c    |   12 ++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 1e9e99a..4de363d 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -86,6 +86,7 @@ struct ehca_eq {
 	u32 ist;
 	spinlock_t irq_spinlock;
 	struct ehca_eqe_cache_entry eqe_cache[EHCA_EQE_CACHE_SIZE];
+	int irq_number;
 };
 
 struct ehca_sma_attr {
diff --git a/drivers/infiniband/hw/ehca/ehca_eq.c b/drivers/infiniband/hw/ehca/ehca_eq.c
index 5bc494f..b70e5e5 100644
--- a/drivers/infiniband/hw/ehca/ehca_eq.c
+++ b/drivers/infiniband/hw/ehca/ehca_eq.c
@@ -122,7 +122,8 @@ int ehca_create_eq(struct ehca_shca *shca,
 
 	/* register interrupt handlers and initialize work queues */
 	if (type == EHCA_EQ) {
-		ret = ibmebus_request_irq(eq->ist, NULL, ehca_interrupt_eq,
+		ret = ibmebus_request_irq(eq->ist, &eq->irq_number,
+					  ehca_interrupt_eq,
 					  IRQF_DISABLED, "ehca_eq",
 					  (void *)shca);
 		if (ret < 0)
@@ -130,7 +131,8 @@ int ehca_create_eq(struct ehca_shca *shca,
 
 		tasklet_init(&eq->interrupt_task, ehca_tasklet_eq, (long)shca);
 	} else if (type == EHCA_NEQ) {
-		ret = ibmebus_request_irq(eq->ist, NULL, ehca_interrupt_neq,
+		ret = ibmebus_request_irq(eq->ist, &eq->irq_number,
+					  ehca_interrupt_neq,
 					  IRQF_DISABLED, "ehca_neq",
 					  (void *)shca);
 		if (ret < 0)
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 482103e..d713317 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #endif
 
+#include <linux/irq.h>
 #include "ehca_classes.h"
 #include "ehca_iverbs.h"
 #include "ehca_mrmw.h"
@@ -937,6 +938,8 @@ static struct of_platform_driver ehca_driver = {
 void ehca_poll_eqs(unsigned long data)
 {
 	struct ehca_shca *shca;
+	int irq;
+	irq_desc_t *desc;
 
 	spin_lock(&shca_list_lock);
 	list_for_each_entry(shca, &shca_list, shca_list) {
@@ -955,8 +958,13 @@ void ehca_poll_eqs(unsigned long data)
 				spin_unlock_irqrestore(&eq->spinlock, flags);
 				max--;
 			} while (q_ofs == q_ofs2 && max > 0);
-			if (q_ofs == q_ofs2)
-				ehca_process_eq(shca, 0);
+			if (q_ofs == q_ofs2) {
+				irq =  shca->eq.irq_number;
+				desc = get_irq_desc(irq);
+				if (desc->chip && desc->chip->eoi)
+					desc->chip->eoi(irq);
+				tasklet_hi_schedule(&shca->eq.interrupt_task);
+			}
 		}
 	}
 	mod_timer(&poll_eqs_timer, round_jiffies(jiffies + HZ));
-- 
1.5.5
