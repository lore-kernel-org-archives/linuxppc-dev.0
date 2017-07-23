Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xFRDX0xhczDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 11:07:07 +1000 (AEST)
Message-ID: <1500771999.10674.27.camel@kernel.crashing.org>
Subject: Re: [PATCH 07/24] powerpc/mm: Move out definition of CPU specific
 is_write bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Sun, 23 Jul 2017 11:06:39 +1000
In-Reply-To: <20170722184058.Horde.Y2X8hGdhXLwnxJXZApQEhQ1@messagerie.c-s.fr>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-7-benh@kernel.crashing.org>
 <20170722184058.Horde.Y2X8hGdhXLwnxJXZApQEhQ1@messagerie.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-07-22 at 18:40 +0200, LEROY Christophe wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> a écrit :
> 
> > Define a common page_fault_is_write() helper and use it
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  arch/powerpc/mm/fault.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index f257965b54b5..26ec0dd4f419 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -183,6 +183,16 @@ static int mm_fault_error(struct pt_regs *regs,  
> > unsigned long addr, int fault)
> >  }
> > 
> >  /*
> > + * Define the correct "is_write" bit in error_code based
> > + * on the processor family
> > + */
> > +#if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> > +#define page_fault_is_write(__err)	((__err) & ESR_DST)
> > +#else
> > +#define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
> > +#endif
> 
> Doesn't linux kernel codying style make preference to static inline  
> functions instead of macros ?

Doesn't really matter, yes that could be, but then I would have
to add a !! to make them proper bools I think unless I keep things
as int, etc... not sure how well gcc will do with it.
> 
> > +
> > +/*
> >   * For 600- and 800-family processors, the error_code parameter is DSISR
> >   * for a data fault, SRR1 for an instruction fault. For 400-family  
> > processors
> >   * the error_code parameter is ESR for a data fault, 0 for an instruction
> > @@ -202,18 +212,12 @@ static int __do_page_fault(struct pt_regs  
> > *regs, unsigned long address,
> >  	struct mm_struct *mm = current->mm;
> >  	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> >  	int code = SEGV_MAPERR;
> > -	int is_write = 0;
> >   	int is_exec = TRAP(regs) == 0x400;
> >  	int is_user = user_mode(regs);
> > +	int is_write = page_fault_is_write(error_code);
> >  	int fault;
> >  	int rc = 0, store_update_sp = 0;
> > 
> > -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> > -	is_write = error_code & DSISR_ISSTORE;
> > -#else
> > -	is_write = error_code & ESR_DST;
> > -#endif /* CONFIG_4xx || CONFIG_BOOKE */
> > -
> >  #ifdef CONFIG_PPC_ICSWX
> >  	/*
> >  	 * we need to do this early because this "data storage
> > --
> > 2.13.3
> 
> 
