Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D280DDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 16:47:04 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix _PAGE_CHG_MASK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rpm@xenomai.org
In-Reply-To: <1234493350.29851.80.camel@pasglop>
References: <4994A046.2080806@xenomai.org> <1234493350.29851.80.camel@pasglop>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 16:46:55 +1100
Message-Id: <1234504015.26036.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-02-13 at 13:49 +1100, Benjamin Herrenschmidt wrote:

> > diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
> > index 75dded6..8298afc 100644
> > --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> > +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> > @@ -428,8 +428,8 @@ extern int icache_44x_need_flush;
> >  #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
> >  #endif
> > 
> > -#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_SPECIAL)
> > -
> > +#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
> > +			 _PAGE_SPECIAL)
> > 
> >  #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
> >  			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
> > 

BTW. That part of the patch looks bad (ie, the original line isn't what
is upstream). I've fixed up locally.

Cheers,
Ben.
