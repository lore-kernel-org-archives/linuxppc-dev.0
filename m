Return-Path: <rientjes@google.com>
Received: from mail-bk0-x22a.google.com (mail-bk0-x22a.google.com
 [IPv6:2a00:1450:4008:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C08162C009B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 08:03:26 +1100 (EST)
Received: by mail-bk0-f42.google.com with SMTP id 6so1502906bkj.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 13:03:19 -0800 (PST)
Date: Fri, 24 Jan 2014 13:03:13 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <alpine.DEB.2.10.1401240946530.12886@nuc>
Message-ID: <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
 <52e1d960.2715420a.3569.1013SMTPIN_ADDED_BROKEN@mx.google.com>
 <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401240946530.12886@nuc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nacc@linux.vnet.ibm.com, penberg@kernel.org, linux-mm@kvack.org,
 Han Pingtian <hanpt@linux.vnet.ibm.com>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Jan 2014, Christoph Lameter wrote:

> On Fri, 24 Jan 2014, Wanpeng Li wrote:
> 
> > >
> > >diff --git a/mm/slub.c b/mm/slub.c
> > >index 545a170..a1c6040 100644
> > >--- a/mm/slub.c
> > >+++ b/mm/slub.c
> > >@@ -1700,6 +1700,9 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> > > 	void *object;
> > >	int searchnode = (node == NUMA_NO_NODE) ? numa_node_id() : node;
> 
> This needs to be numa_mem_id() and numa_mem_id would need to be
> consistently used.
> 
> > >
> > >+	if (!node_present_pages(searchnode))
> > >+		searchnode = numa_mem_id();
> 
> Probably wont need that?
> 

I think the problem is a memoryless node being used for kmalloc_node() so 
we need to decide where to enforce node_present_pages().  __slab_alloc() 
seems like the best candidate when !node_match().
