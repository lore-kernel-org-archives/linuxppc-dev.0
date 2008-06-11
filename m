Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 06/06] powerpc: Don't clear _PAGE_COHERENT when
	_PAGE_SAO is set
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <484EFF86.1030709@ru.mvista.com>
References: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
	<20080610220129.10257.69024.sendpatchset@norville.austin.ibm.com>
	<484EFF86.1030709@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 22:12:42 -0500
Message-Id: <1213153962.6714.0.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-06-11 at 02:26 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Dave Kleikamp wrote:
> > powerpc: Don't clear _PAGE_COHERENT when _PAGE_SAO is set
> >
> > This is a placeholder.  Benh tells me that he will come up with a better fix.
> >
> > Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > ---
> >
> >  arch/powerpc/platforms/pseries/lpar.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff -Nurp linux005/arch/powerpc/platforms/pseries/lpar.c linux006/arch/powerpc/platforms/pseries/lpar.c
> > --- linux005/arch/powerpc/platforms/pseries/lpar.c	2008-06-05 10:07:34.000000000 -0500
> > +++ linux006/arch/powerpc/platforms/pseries/lpar.c	2008-06-10 16:48:59.000000000 -0500
> > @@ -305,7 +305,8 @@ static long pSeries_lpar_hpte_insert(uns
> >  	flags = 0;
> >  
> >  	/* Make pHyp happy */
> > -	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
> > +	if ((rflags & _PAGE_GUARDED) ||
> > +	    ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU)))
> >   
>    I don't think you really meant bitwise AND here. I suppose the second 
> expression just will never be true.

You're right.  That should be &&.  Thanks.

> WBR, Sergei
> 
> 
-- 
David Kleikamp
IBM Linux Technology Center
