Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C05A2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 11:17:08 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 24 Jan 2014 19:17:05 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D8EDD6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 19:16:59 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0P0H32R3146114
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 00:17:03 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0P0H1iS028077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 19:17:03 -0500
Date: Fri, 24 Jan 2014 16:16:43 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140125001643.GA25344@linux.vnet.ibm.com>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
 <52e1d960.2715420a.3569.1013SMTPIN_ADDED_BROKEN@mx.google.com>
 <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401240946530.12886@nuc>
 <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
 <20140124232902.GB30361@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
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

On 24.01.2014 [15:49:33 -0800], David Rientjes wrote:
> On Fri, 24 Jan 2014, Nishanth Aravamudan wrote:
> 
> > > I think the problem is a memoryless node being used for kmalloc_node() so 
> > > we need to decide where to enforce node_present_pages().  __slab_alloc() 
> > > seems like the best candidate when !node_match().
> > 
> > Actually, this is effectively what Anton's patch does, except with
> > Wanpeng's adjustment to use node_present_pages(). Does that seem
> > sufficient to you?
> > 
> 
> I don't see that as being the effect of Anton's patch.  We need to use 
> numa_mem_id() as Christoph mentioned when a memoryless node is passed for 
> the best NUMA locality.  Something like this:

Thank you for clarifying and providing  a test patch. I ran with this on
the system showing the original problem, configured to have 15GB of
memory.

With your patch after boot:

MemTotal:       15604736 kB
MemFree:         8768192 kB
Slab:            3882560 kB
SReclaimable:     105408 kB
SUnreclaim:      3777152 kB

With Anton's patch after boot:

MemTotal:       15604736 kB
MemFree:        11195008 kB
Slab:            1427968 kB
SReclaimable:     109184 kB
SUnreclaim:      1318784 kB


I know that's fairly unscientific, but the numbers are reproducible. 

For what it's worth, a sample of the unmodified numbers:

MemTotal:       15317632 kB
MemFree:         5023424 kB
Slab:            7176064 kB
SReclaimable:     106816 kB
SUnreclaim:      7069248 kB

So it's an improvement, but something is still causing us to (it seems)
be pretty inefficient with the slabs.


> diff --git a/mm/slub.c b/mm/slub.c
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2278,10 +2278,14 @@ redo:
> 
>  	if (unlikely(!node_match(page, node))) {
>  		stat(s, ALLOC_NODE_MISMATCH);
> -		deactivate_slab(s, page, c->freelist);
> -		c->page = NULL;
> -		c->freelist = NULL;
> -		goto new_slab;
> +		if (unlikely(!node_present_pages(node)))
> +			node = numa_mem_id();
> +		if (!node_match(page, node)) {
> +			deactivate_slab(s, page, c->freelist);
> +			c->page = NULL;
> +			c->freelist = NULL;
> +			goto new_slab;
> +		}

Semantically, and please correct me if I'm wrong, this patch is saying
if we have a memoryless node, we expect the page's locality to be that
of numa_mem_id(), and we still deactivate the slab if that isn't true.
Just wanting to make sure I understand the intent.

What I find odd is that there are only 2 nodes on this system, node 0
(empty) and node 1. So won't numa_mem_id() always be 1? And every page
should be coming from node 1 (thus node_match() should always be true?)

Thanks,
Nish
