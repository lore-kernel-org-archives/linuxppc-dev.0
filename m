Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB1AADDE9A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 01:32:35 +1100 (EST)
Date: Wed, 23 Jan 2008 16:32:30 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] Fix boot problem in situations where the boot CPU is
	running on a memoryless node
In-Reply-To: <Pine.LNX.4.64.0801231611160.20050@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0801231626320.21475@sbz-30.cs.Helsinki.FI>
References: <20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<20080122214505.GA15674@aepfle.de>
	<Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
	<20080123075821.GA17713@aepfle.de> <20080123105044.GD21455@csn.ul.ie>
	<20080123121459.GA18631@aepfle.de> <20080123125236.GA18876@aepfle.de>
	<20080123135513.GA14175@csn.ul.ie>
	<Pine.LNX.4.64.0801231611160.20050@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lee.schermerhorn@hp.com, Olaf Hering <olaf@aepfle.de>,
	Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	hanth Aravamudan <nacc@us.ibm.com>, akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jan 2008, Pekka J Enberg wrote:
> I still think Christoph's kmem_getpages() patch is correct (to fix 
> cache_grow() oops) but I overlooked the fact that none the callers of 
> ____cache_alloc_node() deal with bootstrapping (with the exception of 
> __cache_alloc_node() that even has a comment about it).

So something like this (totally untested) patch on top of current git:

---
 mm/slab.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c
+++ linux-2.6/mm/slab.c
@@ -1668,7 +1668,11 @@ static void *kmem_getpages(struct kmem_c
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		flags |= __GFP_RECLAIMABLE;
 
-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	if (nodeid == -1)
+		page = alloc_pages(flags, cachep->gfporder);
+	else
+		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+
 	if (!page)
 		return NULL;
 
@@ -2976,8 +2980,9 @@ retry:
 		batchcount = BATCHREFILL_LIMIT;
 	}
 	l3 = cachep->nodelists[node];
+	if (!l3)
+		return NULL;
 
-	BUG_ON(ac->avail > 0 || !l3);
 	spin_lock(&l3->list_lock);
 
 	/* See if we can refill from the shared array */
@@ -3317,7 +3322,8 @@ static void *____cache_alloc_node(struct
 	int x;
 
 	l3 = cachep->nodelists[nodeid];
-	BUG_ON(!l3);
+	if (!l3)
+		return fallback_alloc(cachep, flags);
 
 retry:
 	check_irq_off();
@@ -3394,12 +3400,6 @@ __cache_alloc_node(struct kmem_cache *ca
 	if (unlikely(nodeid == -1))
 		nodeid = numa_node_id();
 
-	if (unlikely(!cachep->nodelists[nodeid])) {
-		/* Node not bootstrapped yet */
-		ptr = fallback_alloc(cachep, flags);
-		goto out;
-	}
-
 	if (nodeid == numa_node_id()) {
 		/*
 		 * Use the locally cached objects if possible.
