Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 12:46:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: powerpc: Remove use of 4level-fixup.h for ppc32
Message-ID: <20070508024633.GA11340@localhost.localdomain>
References: <20070507053527.GB24464@localhost.localdomain>
	<20070507082441.GA2795@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507082441.GA2795@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 10:24:41AM +0200, Christoph Hellwig wrote:
> On Mon, May 07, 2007 at 03:35:27PM +1000, David Gibson wrote:
> > ===================================================================
> > --- working-2.6.orig/include/asm-powerpc/page.h	2007-05-07 14:24:21.000000000 +1000
> > +++ working-2.6/include/asm-powerpc/page.h	2007-05-07 15:30:04.000000000 +1000
> > @@ -121,9 +121,11 @@ typedef struct { pte_t pte; } real_pte_t
> >  #endif
> >  
> >  /* PMD level */
> > +#ifdef CONFIG_PPC64
> >  typedef struct { unsigned long pmd; } pmd_t;
> >  #define pmd_val(x)	((x).pmd)
> >  #define __pmd(x)	((pmd_t) { (x) })
> > +#endif
> >  
> >  /* PUD level exusts only on 4k pages */
> >  #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_64K_PAGES)
> > @@ -159,9 +161,11 @@ typedef unsigned long real_pte_t;
> >  #endif
> >  
> >  
> > +#if defined (CONFIG_PPC64)
> >  typedef unsigned long pmd_t;
> >  #define pmd_val(x)	(x)
> >  #define __pmd(x)	(x)
> > +#endif
> 
> This should be one bit CONFIG_PPC64 block with a nested !CONFIG_PPC_64K_PAGES
> block inbetween.

Ok, done.  Resending shortly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
