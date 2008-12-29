Return-Path: <dave@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3452FDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 08:36:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBTLZ9Uw012243
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 16:35:09 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBTLaBD6191298
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 16:36:11 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBTMaLPu022347
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 17:36:21 -0500
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18772.11376.339295.42622@cargo.ozlabs.ibm.com>
References: <200812241325.49404.chandru@in.ibm.com>
	<20081224233536.b067c9da.akpm@linux-foundation.org>
	<18772.11376.339295.42622@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 13:36:07 -0800
Message-Id: <1230586567.19452.100.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-12-26 at 11:59 +1100, Paul Mackerras wrote:
> 
> > diff -puN arch/powerpc/mm/numa.c~2628-rc9-panics-with-crashkernel=256m-while-booting arch/powerpc/mm/numa.c
> > --- a/arch/powerpc/mm/numa.c~2628-rc9-panics-with-crashkernel=256m-while-booting
> > +++ a/arch/powerpc/mm/numa.c
> > @@ -995,10 +995,11 @@ void __init do_init_bootmem(void)
> >                                 start_pfn, end_pfn);
> >  
> >               free_bootmem_with_active_regions(nid, end_pfn);
> > +     }
> > +
> > +     for_each_online_node(nid) {
> >               /*
> > -              * Be very careful about moving this around.  Future
> > -              * calls to careful_allocation() depend on this getting
> > -              * done correctly.
> > +              * Be very careful about moving this around.
> >                */
> >               mark_reserved_regions_for_nid(nid);
> >               sparse_memory_present_with_active_regions(nid);

I think this reintroduces one of the bugs that I squashed.  You *have*
to call mark_reserved_regions_for_nid() right after you do
free_bootmem_with_active_regions().  Otherwise, someone else can
bootmem_alloc() a reserved region from that node.

Perhaps I need to make that comment a bit more forceful. :)

/*
 * Don't break this loop out.  Period.  Never.  Ever.
 * No, seriously.  Don't do it.  I mean it.  Really!
 */

-- Dave
