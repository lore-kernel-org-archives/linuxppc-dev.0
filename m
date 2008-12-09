Return-Path: <gknispel@proformatique.com>
Received: from proformatique.com (web.proformatique.com [91.194.179.68])
	by ozlabs.org (Postfix) with ESMTP id 1EEF6DDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 02:14:26 +1100 (EST)
Date: Tue, 9 Dec 2008 16:14:22 +0100
From: Guillaume Knispel <gknispel@proformatique.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
Message-ID: <20081209161422.5e289e6c@xilun.lan.proformatique.com>
In-Reply-To: <493E88B7.5020702@freescale.com>
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
	<493E88B7.5020702@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Guillaume Knispel <gknispel@proformatique.com>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 09 Dec 2008 09:03:19 -0600
Timur Tabi <timur@freescale.com> wrote:

> Guillaume Knispel wrote:
> > There is an error in rh_alloc_fixed() of the Remote Heap code:
> > If there is at least one free block blk won't be NULL at the end of the
> > search loop, so -ENOMEM won't be returned and the else branch of
> > "if (bs == s || be == e)" will be taken, corrupting the management
> > structures.
> > 
> > Signed-off-by: Guillaume Knispel <gknispel@proformatique.com>
> > ---
> > Fix an error in rh_alloc_fixed() that made allocations succeed when
> > they should fail, and corrupted management structures.
> > 
> > diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> > index 29b2941..45907c1 100644
> > --- a/arch/powerpc/lib/rheap.c
> > +++ b/arch/powerpc/lib/rheap.c
> > @@ -556,6 +556,7 @@ unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, co
> >  		be = blk->start + blk->size;
> >  		if (s >= bs && e <= be)
> >  			break;
> > +		blk = NULL;
> >  	}
> >  
> >  	if (blk == NULL)
> 
> This is a good catch, however, wouldn't it be better to do this:
> 
> 	list_for_each(l, &info->free_list) {
> 		blk = list_entry(l, rh_block_t, list);
> 		/* The range must lie entirely inside one free block */
> 		bs = blk->start;
> 		be = blk->start + blk->size;
> 		if (s >= bs && e <= be)
> 			break;
> 	}
> 
> -	if (blk == NULL)
> +	if (blk == &info->free_list)
> 		return (unsigned long) -ENOMEM;
> 
> I haven't tested this, but the if-statement at the end of the loop is meant to
> check whether the list_for_each() loop got to the end or not.
> 
> What do you think?

blk = NULL; at the end of the loop is what is done in the more used
rh_alloc_align(), so for consistency either we change both or we use
the same construction here.
I also think that testing for &info->free_list is harder to understand
because you must have the linked list implementation in your head
(which a kernel developer should anyway so this is not so important)

Guillaume Knispel
