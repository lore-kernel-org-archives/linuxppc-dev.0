Return-Path: <fenkes@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80384DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 03:18:24 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id mALGIJQ4229126
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 16:18:19 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mALGIJ021278058
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 16:18:19 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mALGII2S008266
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 16:18:19 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, OF-EWG <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Fix locking for shca_list_lock
Date: Fri, 21 Nov 2008 17:18:16 +0100
References: <200806061835.43802.fenkes@de.ibm.com>
	<200811211637.15300.fenkes@de.ibm.com>
	<1227283347.3599.8.camel@johannes.berg>
In-Reply-To: <1227283347.3599.8.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811211718.17489.fenkes@de.ibm.com>
Cc: Alexander Schmidt <alexschm@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

shca_list_lock is taken from softirq context in ehca_poll_eqs, so we need to
lock IRQ safe elsewhere.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

On Friday 21 November 2008 17:02, Johannes Berg wrote:
> On Fri, 2008-11-21 at 16:37 +0100, Joachim Fenkes wrote:
> 
> > +	u64 flags;
> 
> > -	spin_lock(&shca_list_lock);
> > +	spin_lock_irqsave(&shca_list_lock, flags);
> 
> That's wrong and I think will give a warning on all machines where
> u64 != unsigned long. Might not particularly matter in this case.

Doesn't matter for a ppc64 only driver, but you're right nonetheless. Thanks.
 
> Also, generally it seems wrong to say "fix lockdep failure" when the
> patch really fixes a bug that lockdep happened to find.

Whatever -- changed.

Here's the updated patch.

Regards,
  Joachim


 drivers/infiniband/hw/ehca/ehca_main.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index bb02a86..169aa1a 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -717,6 +717,7 @@ static int __devinit ehca_probe(struct of_device *dev,
 	const u64 *handle;
 	struct ib_pd *ibpd;
 	int ret, i, eq_size;
+	unsigned long flags;
 
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
+	unsigned long flags;
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
