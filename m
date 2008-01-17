Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 5434ADDEF2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 05:58:56 +1100 (EST)
Date: Thu, 17 Jan 2008 10:58:53 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080117181222.GA24411@aepfle.de>
Message-ID: <Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008, Olaf Hering wrote:

> The patch does not help.

Duh. We need to know more about the problem.

> > --- linux-2.6.orig/mm/slab.c	2008-01-03 12:26:42.000000000 -0800
> > +++ linux-2.6/mm/slab.c	2008-01-09 15:59:49.000000000 -0800
> > @@ -2977,7 +2977,10 @@ retry:
> >  	}
> >  	l3 = cachep->nodelists[node];
> >  
> > -	BUG_ON(ac->avail > 0 || !l3);
> > +	if (!l3)
> > +		return NULL;
> > +
> > +	BUG_ON(ac->avail > 0);
> >  	spin_lock(&l3->list_lock);
> >  
> >  	/* See if we can refill from the shared array */
> 
> Is this hsupposed to go into cache_grow()? There is no NULL check
> for l3.

No its for cache_alloc_refill. cache_grow should only be called for
nodes that have memory. l3 is always used before cache_grow is called.

> freeing bootmem node 1
> Memory: 3496632k/3571712k available (6188k kernel code, 75080k reserved, 1324k data, 1220k bss, 304k init)
> cache_grow(2781) swapper(0):c0,j4294937299 cp c0000000006a4fb8 !l3

Is there more backtrace information? What function called cache_grow?
