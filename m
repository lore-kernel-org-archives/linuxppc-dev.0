Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67200B71BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 07:06:37 +1100 (EST)
Subject: Re: [PATCH] powerpc: fix call to subpage_protection()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
In-Reply-To: <1290104610.3067.32.camel@localhost>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost>
	<17075.1289877977@neuling.org> <1289958663.3028.175.camel@localhost>
	<27638.1289959435@neuling.org> <1290020404.2974.15.camel@localhost>
	<13149.1290047579@neuling.org>  <1290104610.3067.32.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Nov 2010 07:06:19 +1100
Message-ID: <1290110779.32570.9.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-11-18 at 10:23 -0800, Jim Keniston wrote:

> FWIW, this failure isn't an obstacle for me.  I'm in no way attached to
> my legacy configuration; pseries_defconfig is fine for me.  On the other
> hand, I can continue testing fixes, and/or make my system available to
> other IBMers when I'm not using it, if you want to continue to pursue
> this problem.
> 
> Thank

>From the look of it your "legacy" config is lacking the necessary
storage drivers...

Ben.

> .
> Jim
> 
> >   
> > 
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> > index 83f534d..5e95844 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -1123,7 +1123,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
> >  	else
> >  #endif /* CONFIG_PPC_HAS_HASH_64K */
> >  		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
> > -				    subpage_protection(pgdir, ea));
> > +				    subpage_protection(mm, ea));
> > 
> >  	/* Dump some info in case of hash insertion failure, they should
> >  	 * never happen so it is really useful to know if/when they do
> > 
> > 
> 
