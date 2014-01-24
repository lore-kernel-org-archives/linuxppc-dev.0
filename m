Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C8B62C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 09:20:08 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 24 Jan 2014 15:20:04 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4424E19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 15:19:52 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0OMK1qH11010362
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 23:20:01 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0OMK0go023080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 15:20:01 -0700
Date: Fri, 24 Jan 2014 14:19:42 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140124221942.GA30361@linux.vnet.ibm.com>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
 <52e1d960.2715420a.3569.1013SMTPIN_ADDED_BROKEN@mx.google.com>
 <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401240946530.12886@nuc>
 <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
Cc: penberg@kernel.org, linux-mm@kvack.org,
 Han Pingtian <hanpt@linux.vnet.ibm.com>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24.01.2014 [13:03:13 -0800], David Rientjes wrote:
> On Fri, 24 Jan 2014, Christoph Lameter wrote:
> 
> > On Fri, 24 Jan 2014, Wanpeng Li wrote:
> > 
> > > >
> > > >diff --git a/mm/slub.c b/mm/slub.c
> > > >index 545a170..a1c6040 100644
> > > >--- a/mm/slub.c
> > > >+++ b/mm/slub.c
> > > >@@ -1700,6 +1700,9 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> > > > 	void *object;
> > > >	int searchnode = (node == NUMA_NO_NODE) ? numa_node_id() : node;
> > 
> > This needs to be numa_mem_id() and numa_mem_id would need to be
> > consistently used.
> > 
> > > >
> > > >+	if (!node_present_pages(searchnode))
> > > >+		searchnode = numa_mem_id();
> > 
> > Probably wont need that?
> > 
> 
> I think the problem is a memoryless node being used for kmalloc_node() so 
> we need to decide where to enforce node_present_pages().  __slab_alloc() 
> seems like the best candidate when !node_match().
> 

Yep, I'm looking through callers and such right now and came to a
similar conclusion. I should have a patch soon.

Thanks,
Nish
