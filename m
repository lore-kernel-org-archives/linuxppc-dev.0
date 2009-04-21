Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EF61DDFC9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:16:56 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3LFCG4a031374
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 11:12:16 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3LFGkCm186400
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 11:16:47 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3LFGkSK007213
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 11:16:46 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, "OF-EWG" <ewg@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
Date: Tue, 21 Apr 2009 17:16:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
Cc: alexschm@de.ibm.com, fenkes@de.ibm.com, stefan.roscher@de.ibm.com,
	raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Blanchard <antonb at au1.ibm.com>

To improve performance of driver ressource allocation,
replace the vmalloc() call with kmalloc().

Signed-off-by: Stefan Roscher <stefan.roscher at de.ibm.com>
---
 drivers/infiniband/hw/ehca/ipz_pt_fn.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
index c3a3284..a260559 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -220,7 +220,7 @@ int ipz_queue_ctor(struct ehca_pd *pd, struct ipz_queue *queue,
 	queue->small_page = NULL;
 
 	/* allocate queue page pointers */
-	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
+	queue->queue_pages = kmalloc(nr_of_pages * sizeof(void *), GFP_KERNEL);
 	if (!queue->queue_pages) {
 		ehca_gen_err("Couldn't allocate queue page list");
 		return 0;
@@ -240,7 +240,7 @@ int ipz_queue_ctor(struct ehca_pd *pd, struct ipz_queue *queue,
 ipz_queue_ctor_exit0:
 	ehca_gen_err("Couldn't alloc pages queue=%p "
 		 "nr_of_pages=%x",  queue, nr_of_pages);
-	vfree(queue->queue_pages);
+	kfree(queue->queue_pages);
 
 	return 0;
 }
@@ -262,7 +262,7 @@ int ipz_queue_dtor(struct ehca_pd *pd, struct ipz_queue *queue)
 			free_page((unsigned long)queue->queue_pages[i]);
 	}
 
-	vfree(queue->queue_pages);
+	kfree(queue->queue_pages);
 
 	return 1;
 }
-- 
1.5.5
