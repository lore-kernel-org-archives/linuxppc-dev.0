Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id AAD48DDDF5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 06:33:59 +1100 (EST)
Date: Sat, 17 Nov 2007 11:33:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
In-Reply-To: <20071117100507.912c5e5c.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0711171128530.7986@schroedinger.engr.sgi.com>
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<20071117100507.912c5e5c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
	LKML <linux-kernel@vger.kernel.org>,
	Torsten Kaiser <just.for.lkml@googlemail.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Jan Blunck <jblunck@suse.de>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 17 Nov 2007, Andrew Morton wrote:

> > Don't know who to bug about that.
> 
> That's slub.  It appears that list_lock is being taken from process context
> in one place and from softirq in another.

I kicked out some weird interrupt disable code in mm that was only run during
NUMA bootstrap.

This should fix it but isnt there some mechanism to convince lockdep that 
it is okay to do these things during bootstrap?

---
 mm/slub.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/mm/slub.c
===================================================================
--- linux-2.6.orig/mm/slub.c	2007-11-17 11:31:21.044136631 -0800
+++ linux-2.6/mm/slub.c	2007-11-17 11:32:17.364386560 -0800
@@ -2044,7 +2044,9 @@ static struct kmem_cache_node *early_kme
 #endif
 	init_kmem_cache_node(n);
 	atomic_long_inc(&n->nr_slabs);
+	local_irq_disable();
 	add_partial(kmalloc_caches, page, 0);
+	local_irq_enable();
 	return n;
 }
 
