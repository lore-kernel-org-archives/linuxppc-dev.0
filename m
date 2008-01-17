Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1B828DDEBD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 05:12:14 +1100 (EST)
Date: Thu, 17 Jan 2008 19:12:22 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: crash in kmem_cache_init
Message-ID: <20080117181222.GA24411@aepfle.de>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
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

On Thu, Jan 17, Christoph Lameter wrote:

> On Thu, 17 Jan 2008, Pekka Enberg wrote:
> 
> > Looks similar to the one discussed on linux-mm ("[BUG] at
> > mm/slab.c:3320" thread). Christoph?
> 
> Right. Try the latest version of the patch to fix it:

The patch does not help.
 
> Index: linux-2.6/mm/slab.c
> ===================================================================
> --- linux-2.6.orig/mm/slab.c	2008-01-03 12:26:42.000000000 -0800
> +++ linux-2.6/mm/slab.c	2008-01-09 15:59:49.000000000 -0800
> @@ -2977,7 +2977,10 @@ retry:
>  	}
>  	l3 = cachep->nodelists[node];
>  
> -	BUG_ON(ac->avail > 0 || !l3);
> +	if (!l3)
> +		return NULL;
> +
> +	BUG_ON(ac->avail > 0);
>  	spin_lock(&l3->list_lock);
>  
>  	/* See if we can refill from the shared array */

Is this hunk supposed to go into cache_grow()? There is no NULL check
for l3.

But if I do that, it does not help:

freeing bootmem node 1
Memory: 3496632k/3571712k available (6188k kernel code, 75080k reserved, 1324k data, 1220k bss, 304k init)
cache_grow(2781) swapper(0):c0,j4294937299 cp c0000000006a4fb8 !l3
Kernel panic - not syncing: kmem_cache_create(): failed to create slab `size-32'

Rebooting in 1 seconds..    
