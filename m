Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 77441DDE99
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 07:32:11 +1000 (EST)
Date: Wed, 25 Jul 2007 23:33:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: "do section mismatch check on full vmlinux" breaks powerpc build
Message-ID: <20070725213325.GB29855@uranus.ravnborg.org>
References: <20070724224105.GG951@localdomain>
	<20070725114356.GB25580@uranus.ravnborg.org>
	<20070725211610.GJ951@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070725211610.GJ951@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2007 at 04:16:10PM -0500, Nathan Lynch wrote:
> Hi Sam-
> 
> Sam Ravnborg wrote:
> > On Tue, Jul 24, 2007 at 05:41:05PM -0500, Nathan Lynch wrote:
> > > 
> > > 2.6.23-rc1 breaks the build for 64-bit powerpc for me (using
> > > maple_defconfig):
> > > 
> > >   LD      vmlinux.o
> > > powerpc64-unknown-linux-gnu-ld: dynreloc miscount for
> > > kernel/built-in.o, section .opd
> > > powerpc64-unknown-linux-gnu-ld: can not edit opd Bad value
> > > make: *** [vmlinux.o] Error 1
> > > 
> > 
> > I narrowed it down to the following change to avoid the breakage:
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c456c3a..2ea222f 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1246,7 +1246,7 @@ void drop_slab(void);
> >  extern int randomize_va_space;
> >  #endif
> >  
> > -__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma);
> > +//__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma);
> >  
> >  #endif /* __KERNEL__ */
> >  #endif /* _LINUX_MM_H */
> > 
> > So seems that something goes a bit fishy when using weak symbols and this trigges 
> > a binutils bug.
> > 
> > The above line was introdused in the following commit:
> > 
> > commit f269fdd1829acc5e53bf57b145003e5733133f2b
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Wed Sep 27 01:50:23 2006 -0700
> > 
> >     [PATCH] NOMMU: move the fallback arch_vma_name() to a sensible place
> 
> 
> Thanks for looking into this.  Removing the "__attribute__((weak))"
> from arch_vma_name's declaration in linux/mm.h unbreaks the build for
> me.
> 
> Maybe it shouldn't matter, but it seems unusual to have the weak
> attribute specified at the function's declaration.  I wasn't able to
> find any examples of that for other weak functions in the kernel
> (e.g. sched_clock).

Unfortunately removing the weak attribute uncovered that x86_64 has
two functions with the same name => link error.
Needs to have that sorted first out but ball is rolling.
(Se lkml for details)

	Sam
