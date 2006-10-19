Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 592B167B22
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 06:37:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9JKbEpP024043
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 16:37:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9JKbEFr273470
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 16:37:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9JKbDJk005151
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 16:37:13 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
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
	<Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 15:37:09 -0500
Message-Id: <1161290229.8946.51.camel@farscape>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-19-10 at 10:03 -0700, Christoph Lameter wrote:
> I would expect this patch to fix your issues. This will allow fallback 
> allocations to occur in the page allocator during slab bootstrap. This 
> means your per node queues will be contaminated as they were before. After 
> the slab allocator is fully booted then the per node queues will become 
> gradually become node clean.
> 
> I think it would be better if the PPC arch would fix this issue 
> by either making memory  available on node 0 or setting up node 1 as 
> the boot node.
> 

This didnt fix the problem on my box.  I tried this both against mm and
linux-2.6.git 



> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.19-rc2-mm1/mm/slab.c
> ===================================================================
> --- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-19 11:54:24.000000000 -0500
> +++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-19 11:59:24.208194796 -0500
> @@ -1589,7 +1589,10 @@ static void *kmem_getpages(struct kmem_c
>  	 * the needed fallback ourselves since we want to serve from our
>  	 * per node object lists first for other nodes.
>  	 */
> -	flags |= cachep->gfpflags | GFP_THISNODE;
> +	if (g_cpucache_up != FULL)
> +		flags |= cachep->gfpflags;
> +	else
> +		flags |= cachep->gfpflags | GFP_THISNODE;
> 
>  	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
>  	if (!page)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
