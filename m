Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FFE3DDEE3
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 02:27:02 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0CFQwDS165094
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:26:58 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0CFQvp31413286
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:26:57 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0CFQtR6021235
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:26:57 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of
	do_mmap()
Date: Fri, 12 Jan 2007 16:23:13 +0100
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
	<20070111194054.GA11770@localdomain> <adaodp5ibh9.fsf@cisco.com>
In-Reply-To: <adaodp5ibh9.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701121623.13687.hnguyen@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland!
>  > >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
>  > >  	while (my_cq->nr_callbacks)
>  > >  		yield();
> 
>  > Isn't that code outright buggy?  Calling into the scheduler with a
>  > spinlock held and local interrupts disabled...
> 
> Yes, absolutely -- if nr_callbacks is ever nonzero then this will
> obviously crash instantly.
As Christoph R. mentioned in another thread I'm sending you a patch
to fix this bug. Thanks to all for this hint!
Purpose of the while loop is to wait until all completion entries
have been processed by a running completion handler. First then
the function continue with destroying completion queue. Thus, we do
unlock and lock around yield(), ie yield() is now called from a normal
process context without active lock. Hope that this pattern is ok.
In addition of yield issue this patch also fixes an unproper use of
spin_unlock() in ehca_irq.c.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_cq.c  |    5 ++++-
 ehca_irq.c |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c	2007-01-11 19:54:06.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c	2007-01-12 15:27:50.000000000 +0100
@@ -330,8 +330,11 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	}
 
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	while (my_cq->nr_callbacks)
+	while (my_cq->nr_callbacks) {
+		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		yield();
+		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+	}
 
 	idr_remove(&ehca_cq_idr, my_cq->token);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c	2007-01-11 19:53:33.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c	2007-01-12 15:27:50.000000000 +0100
@@ -440,7 +440,9 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(
+							&ehca_cq_idr_lock,
+							flags);
 						break;
 					}
 
