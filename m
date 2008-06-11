Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 02/06] mm: Allow architectures to define additional
	protection bits
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080610151423.a6e68632.akpm@linux-foundation.org>
References: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
	<20080610220106.10257.69841.sendpatchset@norville.austin.ibm.com>
	<20080610151423.a6e68632.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 10:47:09 -0500
Message-Id: <1213199229.6483.10.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-10 at 15:14 -0700, Andrew Morton wrote:
> On Tue, 10 Jun 2008 18:01:07 -0400
> Dave Kleikamp <shaggy@linux.vnet.ibm.com> wrote:
> 
> > mm: Allow architectures to define additional protection bits
> > 
> > This patch allows architectures to define functions to deal with
> > additional protections bits for mmap() and mprotect().
> > 
> > arch_calc_vm_prot_bits() maps additonal protection bits to vm_flags
> > arch_vm_get_page_prot() maps additional vm_flags to the vma's vm_page_prot
> > arch_validate_prot() checks for valid values of the protection bits
> > 
> > Note: vm_get_page_prot() is now pretty ugly.  Suggestions?
> 
> It didn't get any better, no ;)
> 
> I wonder if we can do the ORing after doing the protection_map[]
> lookup.  I guess that's illogical even if it happens to work.

I guess we can live with it.  Just holding out hope that someone might
see a nicer way to do it.

> > diff -Nurp linux001/include/linux/mman.h linux002/include/linux/mman.h
> > --- linux001/include/linux/mman.h	2008-06-05 10:08:01.000000000 -0500
> > +++ linux002/include/linux/mman.h	2008-06-10 16:48:59.000000000 -0500
> > @@ -34,6 +34,26 @@ static inline void vm_unacct_memory(long
> >  }
> >  
> >  /*
> > + * Allow architectures to handle additional protection bits
> > + */
> > +
> > +#ifndef HAVE_ARCH_PROT_BITS
> > +#define arch_calc_vm_prot_bits(prot) 0
> > +#define arch_vm_get_page_prot(vm_flags) __pgprot(0)
> > +
> > +/*
> > + * This is called from mprotect().  PROT_GROWSDOWN and PROT_GROWSUP have
> > + * already been masked out.
> > + *
> > + * Returns true if the prot flags are valid
> > + */
> > +static inline int arch_validate_prot(unsigned long prot)
> > +{
> > +	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
> > +}
> > +#endif /* HAVE_ARCH_PROT_BITS */
> 
> argh, another HAVE_ARCH_foo.

Sorry.  I didn't realize HAVE_ARCH_foo was so evil.

> A good (but verbose) way of doing this is to nuke the ifdefs and just
> go and define these three things for each architecture.  That can be
> done via copy-n-paste into include/asm-*/mman.h or #include
> <asm-generic/arch-mman.h>(?) within each asm/mman.h.
> 
> Another way would be
> 
> #ifndef arch_calc_vm_prot_bits
> #define arch_calc_vm_prot_bits(prot) ...

I think I prefer this method.  I'll get rid of HAVE_ARCH_PROT_BITS.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
