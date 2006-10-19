Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 77C6967B6F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 03:03:13 +1000 (EST)
Date: Thu, 19 Oct 2006 10:03:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <20061019163044.GB5819@krispykreme>
Message-ID: <Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I would expect this patch to fix your issues. This will allow fallback 
allocations to occur in the page allocator during slab bootstrap. This 
means your per node queues will be contaminated as they were before. After 
the slab allocator is fully booted then the per node queues will become 
gradually become node clean.

I think it would be better if the PPC arch would fix this issue 
by either making memory  available on node 0 or setting up node 1 as 
the boot node.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-19 11:54:24.000000000 -0500
+++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-19 11:59:24.208194796 -0500
@@ -1589,7 +1589,10 @@ static void *kmem_getpages(struct kmem_c
 	 * the needed fallback ourselves since we want to serve from our
 	 * per node object lists first for other nodes.
 	 */
-	flags |= cachep->gfpflags | GFP_THISNODE;
+	if (g_cpucache_up != FULL)
+		flags |= cachep->gfpflags;
+	else
+		flags |= cachep->gfpflags | GFP_THISNODE;
 
 	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
 	if (!page)
