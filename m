Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7FE6DDFCB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 23:10:38 +1000 (EST)
Date: Tue, 15 May 2007 15:10:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] viopath: use completion
Message-ID: <20070515131034.GB11544@lst.de>
References: <20070513155027.GB9218@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070513155027.GB9218@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 13, 2007 at 05:50:27PM +0200, Christoph Hellwig wrote:
> Use a completion instead of abusing a semaphore for hypervisor event
> completion in viopath.

And some more of the same sort:


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.20/arch/powerpc/platforms/iseries/viopath.c
===================================================================
--- linux-2.6.20.orig/arch/powerpc/platforms/iseries/viopath.c	2007-05-15 14:48:57.000000000 +0200
+++ linux-2.6.20/arch/powerpc/platforms/iseries/viopath.c	2007-05-15 14:51:36.000000000 +0200
@@ -81,7 +81,7 @@ static void handleMonitorEvent(struct Hv
  * if system_state is not SYSTEM_RUNNING, then wait_atomic is used ...
  */
 struct alloc_parms {
-	struct semaphore sem;
+	struct completion done;
 	int number;
 	atomic_t wait_atomic;
 	int used_wait_atomic;
@@ -464,7 +464,7 @@ static void viopath_donealloc(void *parm
 	if (parmsp->used_wait_atomic)
 		atomic_set(&parmsp->wait_atomic, 0);
 	else
-		up(&parmsp->sem);
+		complete(&parmsp->done);
 }
 
 static int allocateEvents(HvLpIndex remoteLp, int numEvents)
@@ -476,7 +476,7 @@ static int allocateEvents(HvLpIndex remo
 		atomic_set(&parms.wait_atomic, 1);
 	} else {
 		parms.used_wait_atomic = 0;
-		init_MUTEX_LOCKED(&parms.sem);
+		init_completion(&parms.done);
 	}
 	mf_allocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo, 250,	/* It would be nice to put a real number here! */
 			    numEvents, &viopath_donealloc, &parms);
@@ -484,7 +484,7 @@ static int allocateEvents(HvLpIndex remo
 		while (atomic_read(&parms.wait_atomic))
 			mb();
 	} else
-		down(&parms.sem);
+		wait_for_completion(&parms.done);
 	return parms.number;
 }
 
@@ -585,10 +585,10 @@ int viopath_close(HvLpIndex remoteLp, in
 	spin_unlock_irqrestore(&statuslock, flags);
 
 	parms.used_wait_atomic = 0;
-	init_MUTEX_LOCKED(&parms.sem);
+	init_completion(&parms.done);
 	mf_deallocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo,
 			      numReq, &viopath_donealloc, &parms);
-	down(&parms.sem);
+	wait_for_completion(&parms.done);
 
 	spin_lock_irqsave(&statuslock, flags);
 	for (i = 0, numOpen = 0; i < VIO_MAX_SUBTYPES; i++)
