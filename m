Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF3FE67BED
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 04:08:23 +1000 (EST)
Message-ID: <45391061.7090900@shadowen.org>
Date: Fri, 20 Oct 2006 19:07:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
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
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	<17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	<4538DACC.5050605@shadowen.org> <4538F2A2.5040305@shadowen.org>
	<20061020100904.ed1fa0af.akpm@osdl.org>
	<Pine.LNX.4.64.0610201044570.16161@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610201044570.16161@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Lameter wrote:
> Here is the patch:
> 
> Slab: Do not fallback to nodes that have not been bootstrapped yet
> 
> The zonelist may contain zones of nodes that have not been bootstrapped 
> and we will oops if we try to allocate from those zones. So check if the 
> node information for the slab and the node have been setup before 
> attempting an allocation. If it has not been setup then skip that zone.
> 
> Usually we will not encounter this situation since the slab bootstrap
> code avoids falling back before we have setup the respective nodes but we 
> seem to have a special needs for pppc.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.19-rc2-mm1/mm/slab.c
> ===================================================================
> --- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-20 12:39:02.000000000 -0500
> +++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-20 12:41:04.137684581 -0500
> @@ -3160,12 +3160,15 @@ void *fallback_alloc(struct kmem_cache *
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

Applied this and the previous version, diff says they are identicle, so
my previous testing applies.

Acked-by: Andy Whitcroft <apw@shadowen.org>

-apw
