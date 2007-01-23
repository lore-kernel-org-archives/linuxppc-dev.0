Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7892DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 10:14:21 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0NNEGuK200834
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 23:14:16 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0NNEGgL1790098
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 23:14:16 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0NNEFMT000785
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 23:14:15 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
Subject: [PATCH 2.6.21 1/4] ehca: fix improper use of yield with spinlock held
Date: Wed, 24 Jan 2007 00:10:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701240010.37540.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch for ehca_cq.c that fixes improper use of yield
with spinlock held.
Thanks
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_cq.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c	2007-01-19 19:40:32.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c	2007-01-20 00:15:34.000000000 +0100
@@ -344,8 +344,11 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	while (my_cq->nr_callbacks)
+	while (my_cq->nr_callbacks) {
+		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		yield();
+		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+	}
 
 	idr_remove(&ehca_cq_idr, my_cq->token);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
