Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7695B67BEC
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 05:53:56 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9DJrpl4016635
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 15:53:51 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9DJrpjY280578
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 15:53:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9DJrpB3031274
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 15:53:51 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 14:53:46 -0500
Message-Id: <1160769226.11239.22.camel@farscape>
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

On Fri, 2006-13-10 at 12:05 -0700, Christoph Lameter wrote:
> On Fri, 13 Oct 2006, Will Schmidt wrote:
> 
> >     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> > tree.  It's fairly early during boot, so I've included the whole log
> > below.   This partition has 8 procs, (shared, including threads), and
> > 512M RAM.  
> 
> This looks like slab bootstrap. You are bootstrapping while having 
> zonelists build with zones that are only going to be populated later? 
> This will lead to incorrect NUMA placement of lots of slab structures on 
> bootup.

I dont think so..   but it's not an area I'm very familiar with.   one
of the other PPC folks might chime in with something here.  

> 
> Check if the patch below may cure the oops. Your memory is likely 
> still placed on the wrong numa nodes since we have to fallback from 
> the intended node.

Nope, no change with this patch.

> 
> Index: linux-2.6/mm/slab.c
> ===================================================================
> --- linux-2.6.orig/mm/slab.c	2006-10-13 11:59:55.000000000 -0700
> +++ linux-2.6/mm/slab.c	2006-10-13 12:03:15.000000000 -0700
> @@ -3154,7 +3154,8 @@ void *fallback_alloc(struct kmem_cache *
> 
>  	for (z = zonelist->zones; *z && !obj; z++)
>  		if (zone_idx(*z) <= ZONE_NORMAL &&
> -				cpuset_zone_allowed(*z, flags))
> +				cpuset_zone_allowed(*z, flags) &&
> +				(*z)->free_pages)
>  			obj = __cache_alloc_node(cache,
>  					flags | __GFP_THISNODE,
>  					zone_to_nid(*z));
