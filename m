Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB9C2DE0A2
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 00:02:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3ME0JbL017827
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:00:19 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3ME2Wxx029316
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:02:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3ME2U08029908
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:02:31 -0600
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
Date: Wed, 22 Apr 2009 16:02:28 +0200
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<adaws9dvrkp.fsf@cisco.com>
In-Reply-To: <adaws9dvrkp.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904221602.29028.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In case of large queue pairs there is the possibillity of allocation failures 
due to memory fragmentationo with kmalloc().To ensure the memory is allocated even
if kmalloc() can not find chunks which are big enough, we try to allocate the memory
with vmalloc().

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---

On Tuesday 21 April 2009 07:34:30 pm Roland Dreier wrote:
>  > +	queue->queue_pages = kmalloc(nr_of_pages * sizeof(void *), GFP_KERNEL);
> 
> How big might this buffer be?  Any chance of allocation failure due to
> memory fragmentation?
> 
>  - R.
Hey Roland, 
yes you are right and here is the patch to circumvent the described problem.
It will apply on top of the patchset.
regards Stefan


 
 drivers/infiniband/hw/ehca/ipz_pt_fn.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
index a260559..1227c59 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -222,8 +222,11 @@ int ipz_queue_ctor(struct ehca_pd *pd, struct ipz_queue *queue,
 	/* allocate queue page pointers */
 	queue->queue_pages = kmalloc(nr_of_pages * sizeof(void *), GFP_KERNEL);
 	if (!queue->queue_pages) {
-		ehca_gen_err("Couldn't allocate queue page list");
-		return 0;
+		queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
+		if (!queue->queue_pages) {
+			ehca_gen_err("Couldn't allocate queue page list");
+			return 0;
+		}
 	}
 	memset(queue->queue_pages, 0, nr_of_pages * sizeof(void *));
 
@@ -240,7 +243,10 @@ int ipz_queue_ctor(struct ehca_pd *pd, struct ipz_queue *queue,
 ipz_queue_ctor_exit0:
 	ehca_gen_err("Couldn't alloc pages queue=%p "
 		 "nr_of_pages=%x",  queue, nr_of_pages);
-	kfree(queue->queue_pages);
+	if (is_vmalloc_addr(queue->queue_pages))
+		vfree(queue->queue_pages);
+	else
+		kfree(queue->queue_pages);
 
 	return 0;
 }
@@ -262,7 +268,10 @@ int ipz_queue_dtor(struct ehca_pd *pd, struct ipz_queue *queue)
 			free_page((unsigned long)queue->queue_pages[i]);
 	}
 
-	kfree(queue->queue_pages);
+	if (is_vmalloc_addr(queue->queue_pages))
+		vfree(queue->queue_pages);
+	else
+		kfree(queue->queue_pages);
 
 	return 1;
 }
-- 
1.5.5
