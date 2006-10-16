Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1BFFE67BDA
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 02:01:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9GG16dP031048
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 12:01:06 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9GG16GI071634
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 12:01:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9GG169X030979
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 12:01:06 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 11:00:57 -0500
Message-Id: <1161014457.31903.1.camel@farscape>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-13-10 at 15:22 -0700, Christoph Lameter wrote:
> Here is another fall back fix checking if the slab has already been setup 
> for this node. MPOL_INTERLEAVE could redirect the allocation.
> 

with this patch applied, a different error in the same area.. 

freeing bootmem node 0
freeing bootmem node 1
Memory: 530256k/557056k available (5508k kernel code, 30468k reserved,
2224k data, 543k bss, 244k init)
Kernel panic - not syncing: kmem_cache_create(): failed to create slab
`size-32'



> Index: linux-2.6.19-rc1-mm1/mm/slab.c
> ===================================================================
> --- linux-2.6.19-rc1-mm1.orig/mm/slab.c	2006-10-10 21:47:12.949563383 -0500
> +++ linux-2.6.19-rc1-mm1/mm/slab.c	2006-10-13 17:21:31.937863714 -0500
> @@ -3158,12 +3158,15 @@ void *fallback_alloc(struct kmem_cache *
>  	struct zone **z;
>  	void *obj = NULL;
> 
> -	for (z = zonelist->zones; *z && !obj; z++)
> +	for (z = zonelist->zones; *z && !obj; z++) {
> +		int nid = zone_to_nid(*z);
> +
>  		if (zone_idx(*z) <= ZONE_NORMAL &&
> -				cpuset_zone_allowed(*z, flags))
> +				cpuset_zone_allowed(*z, flags) &&
> +				cache->nodelists[nid])
>  			obj = __cache_alloc_node(cache,
> -					flags | __GFP_THISNODE,
> -					zone_to_nid(*z));
> +					flags | __GFP_THISNODE, nid);
> +	}
>  	return obj;
>  }
> 
> 
