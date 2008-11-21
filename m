Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1866DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 02:37:21 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id mALFbGvn004377
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 15:37:16 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mALFbGoG3420292
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 16:37:16 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mALFbFQg016315
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 16:37:16 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, OF-EWG <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Fix lockdep failures for shca_list_lock
References: <200806061835.43802.fenkes@de.ibm.com> <48499C11.7030504@gmail.com>
In-Reply-To: <48499C11.7030504@gmail.com>
MIME-Version: 1.0
Date: Fri, 21 Nov 2008 16:37:14 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811211637.15300.fenkes@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

shca_list_lock is taken from softirq context in ehca_poll_eqs, so we need to
lock IRQ safe elsewhere.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Acked-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_main.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index bb02a86..021c454 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -717,6 +717,7 @@ static int __devinit ehca_probe(struct of_device *dev,
 	const u64 *handle;
 	struct ib_pd *ibpd;
 	int ret, i, eq_size;
+	u64 flags;
 
 	handle = of_get_property(dev->node, "ibm,hca-handle", NULL);
 	if (!handle) {
@@ -830,9 +831,9 @@ static int __devinit ehca_probe(struct of_device *dev,
 		ehca_err(&shca->ib_device,
 			 "Cannot create device attributes  ret=%d", ret);
 
-	spin_lock(&shca_list_lock);
+	spin_lock_irqsave(&shca_list_lock, flags);
 	list_add(&shca->shca_list, &shca_list);
-	spin_unlock(&shca_list_lock);
+	spin_unlock_irqrestore(&shca_list_lock, flags);
 
 	return 0;
 
@@ -878,6 +879,7 @@ probe1:
 static int __devexit ehca_remove(struct of_device *dev)
 {
 	struct ehca_shca *shca = dev->dev.driver_data;
+	u64 flags;
 	int ret;
 
 	sysfs_remove_group(&dev->dev.kobj, &ehca_dev_attr_grp);
@@ -915,9 +917,9 @@ static int __devexit ehca_remove(struct of_device *dev)
 
 	ib_dealloc_device(&shca->ib_device);
 
-	spin_lock(&shca_list_lock);
+	spin_lock_irqsave(&shca_list_lock, flags);
 	list_del(&shca->shca_list);
-	spin_unlock(&shca_list_lock);
+	spin_unlock_irqrestore(&shca_list_lock, flags);
 
 	return ret;
 }
@@ -975,6 +977,7 @@ static int ehca_mem_notifier(struct notifier_block *nb,
 			     unsigned long action, void *data)
 {
 	static unsigned long ehca_dmem_warn_time;
+	unsigned long flags;
 
 	switch (action) {
 	case MEM_CANCEL_OFFLINE:
@@ -985,12 +988,12 @@ static int ehca_mem_notifier(struct notifier_block *nb,
 	case MEM_GOING_ONLINE:
 	case MEM_GOING_OFFLINE:
 		/* only ok if no hca is attached to the lpar */
-		spin_lock(&shca_list_lock);
+		spin_lock_irqsave(&shca_list_lock, flags);
 		if (list_empty(&shca_list)) {
-			spin_unlock(&shca_list_lock);
+			spin_unlock_irqrestore(&shca_list_lock, flags);
 			return NOTIFY_OK;
 		} else {
-			spin_unlock(&shca_list_lock);
+			spin_unlock_irqrestore(&shca_list_lock, flags);
 			if (printk_timed_ratelimit(&ehca_dmem_warn_time,
 						   30 * 1000))
 				ehca_gen_err("DMEM operations are not allowed"
-- 
1.5.5
