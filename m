Return-Path: <rientjes@google.com>
Received: from mail-bk0-x229.google.com (mail-bk0-x229.google.com
 [IPv6:2a00:1450:4008:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BEDA32C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 10:49:46 +1100 (EST)
Received: by mail-bk0-f41.google.com with SMTP id na10so1599509bkb.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 15:49:39 -0800 (PST)
Date: Fri, 24 Jan 2014 15:49:33 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <20140124232902.GB30361@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
 <52e1d960.2715420a.3569.1013SMTPIN_ADDED_BROKEN@mx.google.com>
 <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401240946530.12886@nuc>
 <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
 <20140124232902.GB30361@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 mpm@selenic.com, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Jan 2014, Nishanth Aravamudan wrote:

> > I think the problem is a memoryless node being used for kmalloc_node() so 
> > we need to decide where to enforce node_present_pages().  __slab_alloc() 
> > seems like the best candidate when !node_match().
> 
> Actually, this is effectively what Anton's patch does, except with
> Wanpeng's adjustment to use node_present_pages(). Does that seem
> sufficient to you?
> 

I don't see that as being the effect of Anton's patch.  We need to use 
numa_mem_id() as Christoph mentioned when a memoryless node is passed for 
the best NUMA locality.  Something like this:

diff --git a/mm/slub.c b/mm/slub.c
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2278,10 +2278,14 @@ redo:
 
 	if (unlikely(!node_match(page, node))) {
 		stat(s, ALLOC_NODE_MISMATCH);
-		deactivate_slab(s, page, c->freelist);
-		c->page = NULL;
-		c->freelist = NULL;
-		goto new_slab;
+		if (unlikely(!node_present_pages(node)))
+			node = numa_mem_id();
+		if (!node_match(page, node)) {
+			deactivate_slab(s, page, c->freelist);
+			c->page = NULL;
+			c->freelist = NULL;
+			goto new_slab;
+		}
 	}
 
 	/*

> It does only cover the memoryless node case (not the exhausted node
> case), but I think that shouldn't block the fix (and it does fix the
> issue we've run across in our testing).
> 

kmalloc_node(nid) and kmem_cache_alloc_node(nid) should fallback to nodes 
other than nid when memory can't be allocated, these functions only 
indicate a preference.
