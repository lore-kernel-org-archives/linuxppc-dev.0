Return-Path: <gerhard.stenzel@de.ibm.com>
In-Reply-To: <200905051057.19562.jk@ozlabs.org>
References: <87iqkgd5qm.fsf@de.ibm.com> <200905051057.19562.jk@ozlabs.org>
Subject: Re: [Patch] powerpc/cell: make ptcal more reliable
To: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <OF18EF4701.5A8DDA3F-ONC12575AD.00396868-C12575AD.003B5368@de.ibm.com>
From: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>
Date: Tue, 5 May 2009 12:47:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jeremy Kerr <jk@ozlabs.org> wrote on 05/05/2009 02:57:18 AM:

> Hi Gerhard,

Jeremy, thanks for your comments

>
> > This is for QS21. The following patch allocates pages only from
> > the specified node, moves the ptcal area into the middle of the
> > allocated page to avoid potential prefetch problems and prints
> > the address of the ptcal area to facilitate diagnostics.
>
> You're seeing prefetches that cross a page boundary?
>
> > -   area->pages =3D alloc_pages_node(area->nid, GFP_KERNEL, area->o=
rder);
> > +   area->pages =3D alloc_pages_node(area->nid, GFP_KERNEL |
> > GFP_THISNODE, area->order);
>
> Best to keep this under 80 cols.

ok

>
> >
> > -   if (!area->pages)
> > +   if (!area->pages) {
> > +      printk(KERN_INFO "%s: no page on node %d\n",
> > +         __FUNCTION__, area->nid);
> >        goto out_free_area;
> > +   }
>
> That could probably be a KERN_ERR, as we don't have ptcal enabled on
> that node. Also, I believe __func__ is preferred over __FUNCTION__.

Since this is the default for the kdump kernel in most cases, how about=

KERN_WARNING instead.:

>
> > -   addr =3D __pa(page_address(area->pages));
> > +   /*
> > +    * We move the ptcal area to the middle of the allocated
> > +    * page, in order to avoid prefetches in memcpy and similar
> > +    * functions stepping on it.
> > +    */
> > +   addr =3D __pa(page_address(area->pages)) + (PAGE_SIZE >> 1);
>
> Minor nitpick, but I think (PAGE_SIZE / 2) better illustrates that
> you're putting the addr in the middle of the page. But either should =
be
> fine.

ok. I prefer to keep it like this. It should be clear from the comment.=


>
> > +   printk(KERN_INFO "%s: enabling PTCAL on node %d address=3D0x%01=
6lx
> > PAGE_SIZE>>1=3D0x%016lx \n",
> > +         __FUNCTION__, area->nid, addr, PAGE_SIZE>>1);
>
> 80 cols again. Can we do this as a pr_debug?

"PAGE_SIZE>>1" can be omitted anyway. Removing it brings it below 80 co=
ls.
Regarding pr_debug, the message should appear only on QS21 where it can=
 be
of interest. So, I would prefer to keep a printk.

>
> Cheers,
>
> Jeremy

Thanks again,

Best regards,

Gerhard Stenzel, Linux on Cell/Hybrid Technologies, LTC
-----------------------------------------------------------------------=
------------------------------------------------------------

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch=E4ftsf=FChrung: E=
rich
Baier
Sitz der Gesellschaft: B=F6blingen | Registergericht: Amtsgericht Stutt=
gart,
HRB 243294=
