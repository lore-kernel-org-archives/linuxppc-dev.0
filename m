Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc: fix call to subpage_protection()
In-reply-to: <1290082861.22575.6.camel@concordia>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost> <17075.1289877977@neuling.org>
	<1289958663.3028.175.camel@localhost>
	<27638.1289959435@neuling.org> <1290020404.2974.15.camel@localhost>
	<13149.1290047579@neuling.org> <1290082861.22575.6.camel@concordia>
Date: Fri, 19 Nov 2010 07:24:42 +1100
Message-ID: <25179.1290111882@neuling.org>
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Thu, 2010-11-18 at 13:32 +1100, Michael Neuling wrote:
> > In:=20
> >   powerpc/mm: Fix pgtable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
> >   commit d28513bc7f675d28b479db666d572e078ecf182d
> >   Author: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > subpage_protection() was changed to to take an mm rather a pgdir but it
> > didn't change calling site in hashpage_preload().  The change wasn't
> > noticed at compile time since hashpage_preload() used a void* as the
> > parameter to subpage_protection().
> ...=20
> >=20
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
> _64.c
> > index 83f534d..5e95844 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -1123,7 +1123,7 @@ void hash_preload(struct mm_struct *mm, unsigned lo=
> ng ea,
> >  	else
> >  #endif /* CONFIG_PPC_HAS_HASH_64K */
> >  		rc =3D __hash_page_4K(ea, access, vsid, ptep, trap, local, ssiz
e,
> > -				    subpage_protection(pgdir, ea));
> > +				    subpage_protection(mm, ea));
> 
> Type checking is fun :)
> 
> This is stable material no?

Yes.  In the bit you snipped was a:

  cc: stable@kernel.org (only 2.6.33 and newer)

Fortunately it's not in 2.6.32 so the bug missed the distros.

Mikey
